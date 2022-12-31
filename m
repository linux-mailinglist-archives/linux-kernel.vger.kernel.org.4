Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED79659FE6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 01:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiLaAp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 19:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbiLaApY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 19:45:24 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C101DDE2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 16:45:23 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d15so23425007pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 16:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rdAX1tY2lgADZc9s6/5hpXkndV7lITnERV5/PWeUdiA=;
        b=Vao5WWjd1UgEofNPl1aierPhd/Cf1oGIeB6WQ9d9vhsZoWu8Xp9LutRYsWog343BPK
         e4qPkflbnKppzaeWiaY5dK2guRg59JsriCyVrwJ1j9sFkU1ZWOwu3HClzSPPIIxuBwVb
         Nc7AdXh9W4cXIJ70U8zeTGhuVfgAU1GsjLaZnQwx1ogp9zmdnpflWkr3aoxfih7PNKwX
         uRTXmClZjmp+6QQjgdU/nMvQnr/ebIDie/33pSULnWCsRosbUqtLhdcjDfROo6HgsU5W
         JjaTiWMC/A0KU6jNO96q+UoG2TfV+RvhO0SEzeum8fGw/2RJm+0WHvcbVAik5PnsEHmB
         cv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rdAX1tY2lgADZc9s6/5hpXkndV7lITnERV5/PWeUdiA=;
        b=FrMZcV8yfSCLTNnxPkiCqxR5D2YdazGnq5l887sO8eK+RZTr7SU0vHZgzWfL4ZoKVg
         93FliWTq/aiceqDB776UneaD5SH8bhbgNA2sOF4bTjTGS7dSY3+9vBklII9JhwspPTUY
         IrfGwyK5CfHO5QkTvWHKqYh7dSHANFahDBRwZw5w+M61DxmMNOSLD6zkcjp+R87Gfcrq
         OwVXBhQBNjq5qNzIBPA9aDbpjwacG78g8HY+yhkemeIzIAOm5qAIhxQfPHw0xQTVrt2Y
         H0aGQobi+0nH8PZkpBZyAiibZwhS8Y+vOY+wD4EiXvB8hsOybJJi0LbZ5jcOs5ImrrzP
         mLIg==
X-Gm-Message-State: AFqh2kpplL0F8g9g2N415LO9XcQSwaiDPJfJ17trFBBVSftpDVxaEbPf
        T1XS3sGHPxtvkPtvV0G/jBY=
X-Google-Smtp-Source: AMrXdXuyApOuv5qCY8J2FgzYJc+bsRBanaTsj6EkHsFM+4+zkcC2mJp3YMio9MIcmFroPRZRqf6lyw==
X-Received: by 2002:a17:902:c948:b0:188:c395:1756 with SMTP id i8-20020a170902c94800b00188c3951756mr47555051pla.41.1672447522835;
        Fri, 30 Dec 2022 16:45:22 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:499d:36bb:724c:bd6e])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090301c700b00186c3af9644sm15573030plh.273.2022.12.30.16.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 16:45:22 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2] kcsan: test: don't put the expect array on the stack
Date:   Fri, 30 Dec 2022 16:45:14 -0800
Message-Id: <20221231004514.317809-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Size of the 'expect' array in the __report_matches is 1536 bytes, which
is exactly the default frame size warning limit of the xtensa
architecture.
As a result allmodconfig xtensa kernel builds with the gcc that does not
support the compiler plugins (which otherwise would push the said
warning limit to 2K) fail with the following message:

  kernel/kcsan/kcsan_test.c:257:1: error: the frame size of 1680 bytes
    is larger than 1536 bytes

Fix it by dynamically alocating the 'expect' array.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- add WARN_ON in case of kmalloc failure

 kernel/kcsan/kcsan_test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index dcec1b743c69..a60c561724be 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -159,7 +159,7 @@ static bool __report_matches(const struct expect_report *r)
 	const bool is_assert = (r->access[0].type | r->access[1].type) & KCSAN_ACCESS_ASSERT;
 	bool ret = false;
 	unsigned long flags;
-	typeof(observed.lines) expect;
+	typeof(*observed.lines) *expect;
 	const char *end;
 	char *cur;
 	int i;
@@ -168,6 +168,10 @@ static bool __report_matches(const struct expect_report *r)
 	if (!report_available())
 		return false;
 
+	expect = kmalloc(sizeof(observed.lines), GFP_KERNEL);
+	if (WARN_ON(!expect))
+		return false;
+
 	/* Generate expected report contents. */
 
 	/* Title */
@@ -253,6 +257,7 @@ static bool __report_matches(const struct expect_report *r)
 		strstr(observed.lines[2], expect[1])));
 out:
 	spin_unlock_irqrestore(&observed.lock, flags);
+	kfree(expect);
 	return ret;
 }
 
-- 
2.30.2

