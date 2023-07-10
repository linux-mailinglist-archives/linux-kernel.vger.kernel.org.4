Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A567874C974
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 03:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjGJBSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 21:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjGJBSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 21:18:03 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58B7D1;
        Sun,  9 Jul 2023 18:18:00 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-78372625badso193555039f.3;
        Sun, 09 Jul 2023 18:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688951880; x=1691543880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z39fKcUZ3p7FqsICJneeQrJdxjKRWVhH52o8nOiwBmc=;
        b=amMAIt/tzCRrvnPhWSS3PzD56mlvGeyo5GpP9ja1gFd3LRhRqME48VZDOQlxCuTn+M
         TPGFQHwXMbJHl22cYSApT5gscedlbg9h/WAeM72tAeDnnFg+q2/wDOstmSnG/8Fx/uPi
         4tVee6NnJGaEv/mF51DvHR0mwcsip6f9KG7hF1kfwzSbsMIY02rLB2pX6cn5TZ2jCoc8
         KbHOESiLjv0/QZFqbISEZJBWUnDRu48mBTUXD4wQG6d2XzNQwCjgw2VoyQybGXEiQL2h
         ViY00RQ/Da/0awy/gW6GdIcg+QIDBFp8Cy2mu84dQkWHAM/3nybgBEc66octnenKxsO6
         GJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688951880; x=1691543880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z39fKcUZ3p7FqsICJneeQrJdxjKRWVhH52o8nOiwBmc=;
        b=AgVwsPpLl5xI5+JLE3KKnvAZlSQvaVnTIUFv+2WwMvr+UauAGGVGk5GYq3B1K34kP7
         cY9uk7HXN3AQrBl9cy9nBkOw8ZPS8M0X09kgS7gJBXzJlF4pStOxKktK2hLRtZ2PpDDU
         BEUWn3z46aPIVkxO3ufEpWUiQGV+p3wcLtfCrOaLV1v/GZ89c1VGNGKA7IiXffL5H54R
         ZT0SiauKCMNfbCDourgu9r12Pm7lA1BIrTGJyeaGKfRkFOvy99boriJLxnVk7QCVOeah
         0UN7CPo5hHgSnm6R77Yj5f8yLu/i9tkfQAEOKCa1Y1lYLn1xB1U+BurWcbbI3vo7DT2x
         V0BA==
X-Gm-Message-State: ABy/qLbwIAF8vF1EBbO3Yfn98oNAVqQQU1PiI1ZuD/xHIv4io/pg0RYi
        pw+Ek4/UquDcfrsOJfQ490w=
X-Google-Smtp-Source: APBJJlHtL8raLHVkNlBEDHdfjSGTMCIMX/n3Ax8OS0SP4nQMawtvLiMZ3XUzbhsR8yxbHo54KUT/zA==
X-Received: by 2002:a6b:5916:0:b0:787:169a:927 with SMTP id n22-20020a6b5916000000b00787169a0927mr630834iob.20.1688951879821;
        Sun, 09 Jul 2023 18:17:59 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id j27-20020a02cb1b000000b0042b6a760c31sm3068714jap.28.2023.07.09.18.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 18:17:59 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] acct: Replace all non-returning strlcpy with strscpy
Date:   Mon, 10 Jul 2023 01:17:48 +0000
Message-ID: <20230710011748.3538624-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 kernel/acct.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 010667ce6080..10f769e13f72 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -445,7 +445,7 @@ static void fill_ac(acct_t *ac)
 	memset(ac, 0, sizeof(acct_t));

 	ac->ac_version = ACCT_VERSION | ACCT_BYTEORDER;
-	strlcpy(ac->ac_comm, current->comm, sizeof(ac->ac_comm));
+	strscpy(ac->ac_comm, current->comm, sizeof(ac->ac_comm));

 	/* calculate run_time in nsec*/
 	run_time = ktime_get_ns();
--
2.41.0.255.g8b1d071c50-goog


