Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0CC6C205E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCTSvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCTSum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:50:42 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FB939CE3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:44:00 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso13446338pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679337837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AANWMLFPRmqhsaZtqr8wdmw+KFHZMOER6tyEOUd1jY=;
        b=aayDCvoa4akAYkEkTafaCxZ2nR1eSeMrKHj9HE6+9z++c5J72CEqZpIT5tpfQK+b7s
         DfuRe8crETVZKJd7uc0tuIZ8azHmpKuERgrjpt89W9SIu+0YifdXi+zZdituMLj72Ddt
         xHXEvsyqD2IEJIBvlkKznOnL7/A7Cpn0SCu340rW1bp4582lqhObv9MZCxxduVnyd6YC
         F6YCqbrU7YieFt1BvufySI4dNdoh3ers5n877fPRgMeWB3susKV56FX8TyafnLYQmQ5V
         /lXEBoeDHBHwBwqLD1/Jh1rLYp7jFfuzZ8zIx+UAwApFvxb2GqPsQ/5Fe02jkpZo4byR
         TZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AANWMLFPRmqhsaZtqr8wdmw+KFHZMOER6tyEOUd1jY=;
        b=NnvEGF1FVuSXNNCLmyhijnyz+8WT9OcgWQhy232Xv9CoRm3B07+x3JFT9TSShXJ7LQ
         hs0OHFiX/r81HYcxGoUaQkuDM4G9u9PRKhlO3zLg01qiH6IU6BBr+MntPDlXUBfdVWIc
         /cpoc5iExznX2l3bc/xI4qql3vsZ7USdUYXpN0CbHHPZbc7fRobe06djQL2tMPN37cnO
         GvuCgNZgupfaDat8i9q7uIGmePIiayjJWqf7DeW78HsyXcWAJfDEnHrMiIq/pB6yvd4V
         ppivQlT5qfKe2+8nnBBTjTGSGx52dw25REY6+gvHjR7TS/QdOFW8aPxoITctsn65mFiB
         NGvw==
X-Gm-Message-State: AO0yUKVoFOD5bN7au149zSoQItCqZN7ElbGHBxXdRrEO9XWVvSMerNgv
        sXFkNwcHMsg5t3g7JkUfQxk=
X-Google-Smtp-Source: AK7set+Xx5XgQDVcXACM8YyS1hM83LeSbW8ufd+N6fnFfZRXiW4rfq7zPjHBSbjW7uqHwxm6532pfA==
X-Received: by 2002:a05:6a20:2925:b0:da:2db4:c21e with SMTP id t37-20020a056a20292500b000da2db4c21emr1527455pzf.41.1679337837489;
        Mon, 20 Mar 2023 11:43:57 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id bn10-20020a056a00324a00b005a84ef49c63sm6671755pfb.214.2023.03.20.11.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 11:43:57 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v5 6/7] sign-file: use const with a global string constant
Date:   Tue, 21 Mar 2023 00:13:44 +0530
Message-Id: <20230320184345.80166-7-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320184345.80166-1-sshedi@vmware.com>
References: <20230320184345.80166-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreenidhi Shedi <yesshedi@gmail.com>

Reported by checkpatch.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index d3abc5721a7e..e8dfbdd3eea3 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -71,7 +71,7 @@ struct module_signature {
 
 #define PKEY_ID_PKCS7 2
 
-static char magic_number[] = "~Module signature appended~\n";
+static const char magic_number[] = "~Module signature appended~\n";
 
 static __attribute__((noreturn))
 void print_usage(void)
-- 
2.39.2

