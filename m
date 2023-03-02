Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA696A7BC5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCBHUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCBHTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:19:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6FAA24E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 23:19:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A61A614B3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CCCC433EF;
        Thu,  2 Mar 2023 07:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677741587;
        bh=x+GFgv/5i/F5V9VZV9k4Y/49cV0Hpjtg26OJcDxewj8=;
        h=From:To:Cc:Subject:Date:From;
        b=Mc1t119H+fFTJ5RrU80t7GhKlmv/qjrH+mvhXlveKB67C1AQ4FMzc80kZNoe9oo94
         KSa4dFTh8HI/IX/kcGJ2SfvH3QhldduBNyjJR887Ly5uPX32PBNhO9HK/p4P6syoNj
         nubTohYX8lJvEQI5fslphaa9UE/i4nDfrY1IXIqZ3MsO7ar1ggZDiDv9rDK28HxVHv
         yTPGisaq68blznooFT3VJdtIYLJuAwXpcUHQPfQM+uYcDi8aeZ7CnZet12hepRajRk
         GdfGhUKdkHzBuWKr6FY7LOTN7VYiRNRhL+URhyFNhyb6aLsZNdecMY52Jq3CcXc3Z5
         0G/lTmkqyvTCQ==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-riscv@lists.infradead.org,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v3] lib/test_string.c: Add strncmp() tests
Date:   Thu,  2 Mar 2023 08:19:34 +0100
Message-Id: <20230302071934.254111-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

The RISC-V strncmp() fails on some inputs, see the linked thread for
more details. It turns out there were no strncmp() calls in the self
tests, this adds one.

Reported-by: Heiko Stübner <heiko@sntech.de>
Link: https://lore.kernel.org/all/2801162.88bMQJbFj6@diego/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
Change back to it's original form. Checkpatch still complains about
__initconst, but there's a patch addressing that [1].

[1] https://lore.kernel.org/all/20230301094320.15954-1-bjorn@kernel.org/

v2->v3: Removed the "checkpatch fix" patch
        Added one more test

v1->v2: Added two more tests (pos/neg). (Andy)
        Minor code style issues. (Andy)
        Fixed checkpatch errors.
---
lib/test_string.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/lib/test_string.c b/lib/test_string.c
index c5cb92fb710e..f18a34578f1f 100644
--- a/lib/test_string.c
+++ b/lib/test_string.c
@@ -207,6 +207,43 @@ static __init int strspn_selftest(void)
 	return 0;
 }
 
+static __init int strncmp_selftest(void)
+{
+	size_t i;
+	static const struct strncmp_test {
+		const char *str_a;
+		const char *str_b;
+		unsigned long count;
+		unsigned long max_off;
+		int retval;
+	} tests[] __initconst = {
+		{ "/dev/vda", "/dev/", 5, 4, 0 },
+		{ "/dev/vda", "/dev/vdb", 5, 4, 0 },
+		{ "00000000---11111", "00000000---11112", 12, 4, 0 },
+		{ "/dev/vda", "/dev/vd\0", 8, 0, 97 },
+		{ "ABC", "AB", 3, 0, 67 },
+		{ "ABA", "ABZ", 3, 0, -25 },
+		{ "ABC", "ABC", 3, 0, 0 },
+	};
+
+	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
+		const struct strncmp_test *s = tests + i;
+		size_t off;
+
+		for (off = 0; off <= s->max_off; off++) {
+			int res = strncmp(s->str_a + off, s->str_b + off, s->count - off);
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
@@ -245,6 +282,11 @@ static __init int string_selftest_init(void)
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

base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
-- 
2.37.2

