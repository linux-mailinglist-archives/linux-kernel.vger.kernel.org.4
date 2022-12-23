Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42969654CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiLWHm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWHm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:42:56 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C35B1571D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 23:42:55 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 78so2837658pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 23:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xwkjPkB+HDgaumLrNe3xi/8SHaA70l8jiLgxWpcwsNs=;
        b=qBmFxZfkbscd80v1B1WyDYk9D9+tger1/bHCKo2BM6yGSq2jVt9T11X46Josoz+Tpq
         DUb4vxLJKp8x0jpJpXd++iHTRULMNRhd5c8v4kNf1oxHboR9i56j4MxbBro7LczOMlzT
         7+fyVfe//nG/kYvMgBfzZZim5SlO9Y06SvF9PXXQT32QcroPySZsNeU9r0f/i0hB9b5/
         aypk40OEuOmWo2mS6PW2q0VltAolekhZpay6XZFu8O+JWKG0hX4od2gVXn3rE/LvTAr6
         BlzeEB1H1J5EhIxWrqmdT46tfDAlYkqIu8Y93s7rtbZ0J+bEasWKjLPpWNqJxjTtODfM
         USJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwkjPkB+HDgaumLrNe3xi/8SHaA70l8jiLgxWpcwsNs=;
        b=o012kjZQlOyD9U3t+0dMh3h9Rhjq3/JoIIe0TJpadjo7Er5k1ttOi78IqPEOY7MDcC
         rueO6p4ja79rHq/9ODO8jsUMCvN/bW3xZuBRyW1kQb/QILzMH2zctL4T7aKd+UChvLC0
         SA0Ee2L3AOnRYK51Vy0N36S6w6ez52A0cGvJfbEjRtu1D8nbcnOqipOvYCmAkPmLLnWK
         Xct2T8SZFwb4k0bAw2DyQp7nSNhUXJpIimqkCdUwfL9hyZ/ZyUuPSxEgdWGqIRY0NFc+
         Tv35CcY6R65rcAsHgtcga5Xyh46ScLniFB3mDjMpsiJMu+YOz7WTMqdPh9iLP/tejFoF
         gsiQ==
X-Gm-Message-State: AFqh2kqLW8Sfy4CLmV8w9Pmm/MqWgo2QiBNOTghotabXk5Ar0pVIx9lz
        0rhJdotYU2mfl/H34r6cSRs=
X-Google-Smtp-Source: AMrXdXsJbR9ZLMfdO2JBXStou8AKBRsE2QVcXk8hrUY3yVqR62UNTPCBYOSvMTYDi3QoUPleBJR1ew==
X-Received: by 2002:aa7:93b8:0:b0:576:95ec:bc93 with SMTP id x24-20020aa793b8000000b0057695ecbc93mr24262725pff.23.1671781374955;
        Thu, 22 Dec 2022 23:42:54 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:3ffc:2c70:d62e:faaf])
        by smtp.gmail.com with ESMTPSA id 64-20020a620543000000b0056bd1bf4243sm1887187pff.53.2022.12.22.23.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 23:42:54 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] kcsan: test: don't put the expect array on the stack
Date:   Thu, 22 Dec 2022 23:42:38 -0800
Message-Id: <20221223074238.4092772-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
 kernel/kcsan/kcsan_test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index dcec1b743c69..af62ec51bd5f 100644
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
+	if (!expect)
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

