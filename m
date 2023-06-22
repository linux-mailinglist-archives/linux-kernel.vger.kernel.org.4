Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFF173993A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjFVITF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjFVIS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:18:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A3D2137;
        Thu, 22 Jun 2023 01:18:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f900cd3f96so57711005e9.2;
        Thu, 22 Jun 2023 01:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687421900; x=1690013900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NS1xFrJX+6qQ1UwuwL9AKus1/EqzRZr8t+BiNUW5wqs=;
        b=eNROBa+nMhlNdHc5aqnSWxtIYlaf62BFhUpz3BgduwicT5nT/o7qgZbb9ZmQjexO7y
         u/ohXuwkI+0nJayvgLe7ECvtIsciAgZtCa8tg03D4U6R7iv1mR2rEyiEyiC6OuZdV8Qj
         8/BdVOR6wex1mt6PZCFd1zhJhWc40aH06z6Hk0GuunE/sDtZYhUuA1tlUrs+AaBNn/SZ
         KOBPp3YV3wB1ieZMi9hKdLOYSRhYnIlNkry4+s+2sdA4he7xI+qtIYwsDOPIrMPHkxDF
         Kff0V9ZmLdLeYRTR/hsrjaMThmNzDVwV8yYb2rGQ4f9LPlCsHry03XCAK10mGFZ2R93G
         IQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687421900; x=1690013900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NS1xFrJX+6qQ1UwuwL9AKus1/EqzRZr8t+BiNUW5wqs=;
        b=HaThwW/4srncxR9vM/qdMeTrtJq+JvMf4UK3UrKPjvKjdvH9ZYKYmwj3fIhcg/0W+G
         U7+KA0StJcnCWLNJPjMWzCAFQs/n3Iu4TZaeNs327lvRcAVGCdEZ0y7ysAy/R24rqopV
         RveY4put+gkPuzbtzZhbupsBWsWLxnMl8N6bvCLTDxFweB7c+zpK4dG/BsDXZgqpiWNk
         8MMW8F8hSQwyYaAVqDUYTO7t8taroP+Ju4n1PSGfZVBRY88Q5TNsNfhT2b5iRvabrmC3
         dzVcVQn958qASK7wQeiHGJbzYGH1V9vjNCsTal5Vj08EtDW8RxUHGLy/E3ob/c92GYNp
         zcgA==
X-Gm-Message-State: AC+VfDyNwHQykgQoMXVzrTDpliGSWwt03xxA4GFaZkUf0ntnbgLSuOXK
        cItc4L4bml+s81w3MaqIOD8=
X-Google-Smtp-Source: ACHHUZ5+FBm2KfU23mMZ4FDV7sk8nRgjM/SFUAQ00XEqSzuD7JL6vOn+KT5MEHgIiaW6Ze1ngPFWHA==
X-Received: by 2002:a7b:cbcd:0:b0:3fa:74bf:f028 with SMTP id n13-20020a7bcbcd000000b003fa74bff028mr486383wmi.0.1687421899802;
        Thu, 22 Jun 2023 01:18:19 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c240900b003f93c450657sm6974330wmp.38.2023.06.22.01.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:18:19 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] pipe: remove redundant initialization of pointer buf
Date:   Thu, 22 Jun 2023 09:18:18 +0100
Message-Id: <20230622081818.2795019-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer buf is being initialized with a value that is never
read. Buf is being re-assigned later on, the initialization is
redundant and can be removed. Cleans up clang scan build warning:

fs/pipe.c:492:24: warning: Value stored to 'buf' during its
initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 2d88f73f585a..71b6b0545e0f 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -489,7 +489,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		head = pipe->head;
 		if (!pipe_full(head, pipe->tail, pipe->max_usage)) {
 			unsigned int mask = pipe->ring_size - 1;
-			struct pipe_buffer *buf = &pipe->bufs[head & mask];
+			struct pipe_buffer *buf;
 			struct page *page = pipe->tmp_page;
 			int copied;
 
-- 
2.39.2

