Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0059E74ED2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGKLsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGKLs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:48:29 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C61810E;
        Tue, 11 Jul 2023 04:48:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e6113437cso1426930a12.2;
        Tue, 11 Jul 2023 04:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689076107; x=1691668107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Cy1faYBjU+oiNv+mEI1JhoJuRWFnOpAxBy8BKOfb6Y=;
        b=XOB1ozW4MPG56pfPy9tXjW2N2vo8eLy6XkcbnrRw8ZvkS/T/EvMX6W7lZs7YnrznUo
         sRzstRISZW4il2kkRjCLo5k5hnI0YCaVACXUQFZXP0ZqcUOvxT3u333zm2A/TuDmAnwz
         aXg1LLaGRqqFt3GmM9Dl5Zw9bzgn8NJxGECl4cN0OhtnHgj+6QChCxlkepxrviVK/nk8
         Bh/quw+KAq+2dJTLKazthOpBBgZSXDSqNNEYDalNypOQYrTaJr85kKKEpY2FGyN/t3cS
         6aWhpxoDyyUQp/YTz3iKsKt/0soTXxyzpl6ENhVNnYuWkJGqt1NhCwhy7GX8wSVrx3h9
         4jsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689076107; x=1691668107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Cy1faYBjU+oiNv+mEI1JhoJuRWFnOpAxBy8BKOfb6Y=;
        b=WeGRkr/7QCJarv2PxfWLdWTPkTW2elkpxmCoI1v6hfaUl4UhSqnopSDhca2Eb3DvF7
         iW754LqIzt71QPKUUDQ2bi2bZ57aD6OtmoYS28Sjk+q0JChFB63TiOwBAHlzMg6WnR8Y
         rXPaSSPv8T3T8XP92Yi/p7bnyETMFHEL3e85idijFPB9lW6vYHK6I5ERWt1LdHj1BLVq
         mvwyE3rUX5GzW7CYYzQpEYiXsmLOKb95Y8Mv5sFNY2ylQaz0jrCW2FDQ2iO0ASuvSzDl
         TMCHBnfvE5FH01Kd2ut6h6tb/kb8sG5sAHFgRADMb/E7h2OPv4L9iemeRa9Tjeiea0pt
         4Z9g==
X-Gm-Message-State: ABy/qLbxyHHab5vZgO52Dcveaztw6BWuCFiL6DsNVnwKgvceQoejBj7Z
        OXEvW3QNbPgczjqCZlfLpvQ7Fu1IFU0=
X-Google-Smtp-Source: APBJJlEhY7DcL5cvXqOY4Rtmkh4B7YIxRwZc/XlJiBs8hYkXyDHXFlR+mPsQFgFtDT5y4dGKYk9pFg==
X-Received: by 2002:aa7:cd71:0:b0:51d:e486:4348 with SMTP id ca17-20020aa7cd71000000b0051de4864348mr12437544edb.22.1689076106521;
        Tue, 11 Jul 2023 04:48:26 -0700 (PDT)
Received: from localhost (2a02-a210-0fc1-bf80-3ee9-f7ff-fec5-cf4c.cable.dynamic.v6.ziggo.nl. [2a02:a210:fc1:bf80:3ee9:f7ff:fec5:cf4c])
        by smtp.gmail.com with ESMTPSA id s15-20020aa7cb0f000000b0051e3cda6d49sm1121146edt.90.2023.07.11.04.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 04:48:25 -0700 (PDT)
From:   Azat Khuzhin <a3at.mail@gmail.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Azat Khuzhin <a3at.mail@gmail.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] Fix writing maj:min to /sys/power/resume (fixes hiberation with systemd)
Date:   Tue, 11 Jul 2023 13:48:12 +0200
Message-ID: <20230711114821.1273-1-a3at.mail@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

resume_store() first calls lookup_bdev() and after tries to handle
maj:min, but it does not reset the error before, hence if you will write
maj:min you will get ENOENT:

    # echo 259:2 >| /sys/power/resume
    bash: echo: write error: No such file or directory

This also should fix hiberation via systemd, since it uses this way.

Fixes: 1e8c813b083c4 ("PM: hibernate: don't use early_lookup_bdev in resume_store")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Azat Khuzhin <a3at.mail@gmail.com>
---
 kernel/power/hibernate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index f62e89d0d906..e1b4bfa938dd 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1179,6 +1179,7 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 		unsigned maj, min, offset;
 		char *p, dummy;
 
+		error = 0;
 		if (sscanf(name, "%u:%u%c", &maj, &min, &dummy) == 2 ||
 		    sscanf(name, "%u:%u:%u:%c", &maj, &min, &offset,
 				&dummy) == 3) {
-- 
2.41.0

