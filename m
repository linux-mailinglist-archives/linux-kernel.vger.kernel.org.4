Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638D069FE21
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjBVWKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBVWK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:10:28 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BF7392BE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:10:27 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id pt11so11311933pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=+bvlqXAakwX2gdnOC29zT7CXrEv41Aaug8Y6u3C5RBA=;
        b=DQNw/KI4e7T2/iVpxq/MsLgmGAFx6CBpljybLL84b6mP9D7C60q5Ao1gmBea3HALtV
         TV9c0ZJWfuuCosaJlVVvindhasFMYvUCiFFsJNDjTZZb7AJpHEBC9l9d2pyaG8yxArPF
         2p8XrFV78LWi6toXIbF0ZH2g6T0GdPl25lBW88k0GnSayz90tRkOrgnOnIQ0Y/MP5KIn
         ghpRq+/yYPMTvsGthgBKNTq4VZ2ZTpvmQkwQrlGmz4484A4i4qg3at1DSTGDt9wtr3v9
         6Sy4BQuQmQD0k79FkCvU7iG910OH/WFCYFyBStlBB6UlYYhw2xRxb7r5AAGUhYUUuByZ
         xNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bvlqXAakwX2gdnOC29zT7CXrEv41Aaug8Y6u3C5RBA=;
        b=0qDQnzQl36xTbYjA0T23mNZNa0Y6d56eEz4PFbrrB08/gV7YIDFFdfIOzigRL/Ufxm
         hXKLOVuTIwmg6qCbZ1Kb2NfpSo0ws48sXdgRlJowee5uifcLHkiXkA72IlXu+p6YgrCe
         Tfy6Erxcurfqa/4dSPgpFfYRKvfTDwSlgro+qo9U5fXne/35yF0sHl5janhUxOua40ip
         xig7IoHTFPLhyJ98S5vm5PnjrKy9nD3T0vlsVomfyBG/e+NuF6be9/WdzBKdoEBfaTpr
         WQRhsuwH8CNLc4n5IStPQxtmdHF4t5EaZJ8DRWA4iQCMVNNFGCTtvEkE5UA0gpwGh5pP
         ricQ==
X-Gm-Message-State: AO0yUKUxenBo2jzgR593NlOyErY4Z+Q6HD5iWYkEMQhCSxmNgqE0nXwE
        s7XBoIPcOfZWz7WCGjaJIFqxSoh35A+GIwUx
X-Google-Smtp-Source: AK7set9z2QVnvZgNtqRGxvJGA5quWz7GivpPeP6o43VdffO65fbplX3fXoRHOUlcxr9wyxYSbC2szA==
X-Received: by 2002:a17:902:b286:b0:19c:a9b8:4349 with SMTP id u6-20020a170902b28600b0019ca9b84349mr3477658plr.32.1677103826529;
        Wed, 22 Feb 2023 14:10:26 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id jd7-20020a170903260700b0019956f23fc1sm12255748plb.302.2023.02.22.14.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 14:10:26 -0800 (PST)
Subject: [PATCH] lib/test_string.c: Add strncmp() tests
Date:   Wed, 22 Feb 2023 14:04:35 -0800
Message-Id: <20230222220435.10688-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     andy@kernel.org, linux-kernel@vger.kernel.org, heiko@sntech.de
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V strncmp() fails on some inputs, see the linked thread for
more details.  It turns out there were no strncmp() calls in the self
tests, this adds one.  It currently fails on RISC-V systems with Zbb
enabled with

    [    0.683479] String selftest failure 7.00001001

Link: https://lore.kernel.org/all/2801162.88bMQJbFj6@diego/
Reported-by: Heiko Stübner <heiko@sntech.de>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
This reports a checkpatch error for the __initconst, but I think it's
spurious as I've just pattern matched the above test.
---
 lib/test_string.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/lib/test_string.c b/lib/test_string.c
index c5cb92fb710e..8420379963ba 100644
--- a/lib/test_string.c
+++ b/lib/test_string.c
@@ -207,6 +207,40 @@ static __init int strspn_selftest(void)
 	return 0;
 }
 
+static __init int strncmp_selftest(void)
+{
+	static const struct strncmp_test {
+		const char *str_a;
+		const char *str_b;
+		unsigned long count;
+		unsigned long max_off;
+		size_t retval;
+	} tests[] __initconst = {
+		{ "/dev/vda", "/dev/",    5, 4, 0 },
+		{ "/dev/vda", "/dev/vdb", 5, 4, 0 },
+	};
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
+		const struct strncmp_test *s = tests + i;
+		size_t off;
+
+		for (off = 0; off <= s->max_off; ++off) {
+			size_t res = strncmp(s->str_a + off,
+					     s->str_b + off,
+					     s->count - off);
+
+			if (res == 0 && s->retval != 0)
+				return 0x1000 + 0x100*off + 0x10*i + 0x0;
+			if (res > 0 && s->retval <= 0)
+				return 0x1000 + 0x100*off + 0x10*i + 0x1;
+			if (res < 0 && s->retval >= 0)
+				return 0x1000 + 0x100*off + 0x10*i + 0x2;
+		}
+	}
+	return 0;
+}
+
 static __exit void string_selftest_remove(void)
 {
 }
@@ -245,6 +279,11 @@ static __init int string_selftest_init(void)
 	if (subtest)
 		goto fail;
 
+	test = 7;
+	subtest = strncmp_selftest();
+	if (subtest)
+		goto fail;
+
 	pr_info("String selftests succeeded\n");
 	return 0;
 fail:
-- 
2.39.1

