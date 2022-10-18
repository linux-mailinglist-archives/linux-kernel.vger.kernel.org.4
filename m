Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1556028FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJRKFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJRKFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:05:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BC7B1BA9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:05:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so13590823pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xpXkUl+z1zNizj9vgkTXvIWAiqD+SGhYAW2dD7JSoQI=;
        b=DzVSaK73+xGrwYowzaegLcBLY3WpmQ4r/uHTmcLTaNlBWKKxQr2IT/3y/a3k9tPfZS
         KhT3I0ScX2Eduz6NBVOLf9qrDJNVKGA/dwt+FQYHUgwItAv3B2JtFjCM664IWOpsZoIx
         5unKNvKHT26Yb/i3SalFenyqelwKbaEVOVHYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpXkUl+z1zNizj9vgkTXvIWAiqD+SGhYAW2dD7JSoQI=;
        b=jo3zxCN1LSIZ5IlnA5IBD66cjIZSyx/lLEGb0YSIp6i/9Ll4112KfYE34govCzg10I
         JpNhaesxdOOLYA7ioSnB+xUede6OmjW7/T5TsziYiJSXIAvPvHE/JZXxhdf7nfNXdtMx
         41Lh9vwGXjvqicmrlD0Orlyn9RCmAdY9MvA8DV66Og6eJsBshp9d3jJap1Upqs4u6ry4
         QKkoTAb1QaFC6Tkvin6wAw12Ypwmx71OysKQUQTXM6wzPZUGd6ZmTDtBIpNfMjnT50Np
         pvccOhfCBR1lpF2dn1M/RsSTg3m3RFk0er82dlIVIWxdf704OzJXwyL8b0m0fRqLtfo1
         iW6Q==
X-Gm-Message-State: ACrzQf153LBRUeJFjoJtpWvg8pKQMelLq5v4v++GiOFho6qjv+pQXzED
        lzPOg6Fen80RIbYqmzyjTRVByg==
X-Google-Smtp-Source: AMsMyM4nwgopl4PThVGH3PQzxQrGrADwJg4nz7UwMJTN07fHWiz3gkdMa8WvOowOmT5Y2CmBQtra9Q==
X-Received: by 2002:a17:90b:f18:b0:20a:9d2b:b75a with SMTP id br24-20020a17090b0f1800b0020a9d2bb75amr38512829pjb.95.1666087549092;
        Tue, 18 Oct 2022 03:05:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b12-20020aa78ecc000000b005627470944dsm8730232pfr.189.2022.10.18.03.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:05:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] siphash: Convert selftest to KUnit
Date:   Tue, 18 Oct 2022 03:05:46 -0700
Message-Id: <20221018100510.never.479-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10466; h=from:subject:message-id; bh=bXI7LVTcU0TAHuxQIqyN9rCLQTorw9vOeWRXpjgDiWg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTnp6J5XHOzMkOwH0LYtAmytll5RTblS0h+meiDm5 BjB73MyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY056egAKCRCJcvTf3G3AJrqMD/ 4yeqkx0Y7HF7pRyX1vJu3yxpcWz2agRNsxMWFQrTAXiAA8tI6yz1+8WqPxtiByPxJGcGl4aJQXgYBL ARR9TsrlEOYTDX1xwWP7/uFr59YB67XHzAq6hJauvGs6Au9X1u+x7gfzYKUURQgJ2Cwgs4PmkZodoe jxTpWi/6Tp5u3WTiq7Wnx9RBN8/v2F9FYFthj5q0VHoox9eDaAgZc3FF7RTg9WhmdaxjLD9iyJGiwA gJgDQLd+YCTKE/30rc6mZ/CHB+0IC7jTz6JKNES7rVFa4KhQRHbZeoWJclJb0cg77IhWA/nweK8t51 o0cNA4dVPzN9pPmTYV2vVbA2N7VhrRbT1YCpjqrUquYibLoWMpw2fJ2SHTy1p7sscPs/iR6GOUyE8k Uys8QoCTbLx43g7SrHSXDz2jGWdiOR5di30Tih1ys4XtqQOenvn48g7TmqMt7cfycuaNdlc8/hEpbr C4E7BK8ThPbjn9vR36MHfUQmoNFcgjYQ8moJOQ/CgvhEBPIKlvbgIaPV0UJyfS2d+B9zrEoczonJSb Z4wS/8JIa68MOhBoYJfpUfWparRsivtgHBxVzzrXlpzsxdqpZPhHmj2dmHjZXZ9zb7K/4FL3g5+mYM +sGLuSgR9oZoMEGas2QC4aUOILG1g+t1m982aQDosqhkiP0/b0WCDW8t0+qg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the siphash self-test to KUnit so it will be included in "all
KUnit tests" coverage, and can be run individually still:

$ ./tools/testing/kunit/kunit.py run siphash
...
[02:58:45] Starting KUnit Kernel (1/1)...
[02:58:45] ============================================================
[02:58:45] =================== siphash (1 subtest) ====================
[02:58:45] [PASSED] siphash_test
[02:58:45] ===================== [PASSED] siphash =====================
[02:58:45] ============================================================
[02:58:45] Testing complete. Ran 1 tests: passed: 1
[02:58:45] Elapsed time: 21.421s total, 4.306s configuring, 16.947s building, 0.148s running

Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: David Gow <davidgow@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS                             |   2 +-
 lib/Kconfig.debug                       |  20 +--
 lib/Makefile                            |   2 +-
 lib/{test_siphash.c => siphash_kunit.c} | 165 ++++++++++--------------
 4 files changed, 83 insertions(+), 106 deletions(-)
 rename lib/{test_siphash.c => siphash_kunit.c} (60%)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..037466b9a027 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18862,7 +18862,7 @@ M:	Jason A. Donenfeld <Jason@zx2c4.com>
 S:	Maintained
 F:	include/linux/siphash.h
 F:	lib/siphash.c
-F:	lib/test_siphash.c
+F:	lib/siphash_kunit.c
 
 SIS 190 ETHERNET DRIVER
 M:	Francois Romieu <romieu@fr.zoreil.com>
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3fc7abffc7aa..65593675cd5a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2247,15 +2247,6 @@ config TEST_RHASHTABLE
 
 	  If unsure, say N.
 
-config TEST_SIPHASH
-	tristate "Perform selftest on siphash functions"
-	help
-	  Enable this option to test the kernel's siphash (<linux/siphash.h>) hash
-	  functions on boot (or module load).
-
-	  This is intended to help people writing architecture-specific
-	  optimized versions.  If unsure, say N.
-
 config TEST_IDA
 	tristate "Perform selftest on IDA functions"
 
@@ -2583,6 +2574,17 @@ config HW_BREAKPOINT_KUNIT_TEST
 
 	  If unsure, say N.
 
+config SIPHASH_KUNIT_TEST
+	tristate "Perform selftest on siphash functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to test the kernel's siphash (<linux/siphash.h>) hash
+	  functions on boot (or module load).
+
+	  This is intended to help people writing architecture-specific
+	  optimized versions.  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 161d6a724ff7..bca02ac1adf8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -62,7 +62,6 @@ obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
 CFLAGS_test_bitops.o += -Werror
 obj-$(CONFIG_CPUMASK_KUNIT_TEST) += cpumask_kunit.o
 obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
-obj-$(CONFIG_TEST_SIPHASH) += test_siphash.o
 obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
 obj-$(CONFIG_TEST_IDA) += test_ida.o
 obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
@@ -380,6 +379,7 @@ obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
 CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
 obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
+obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/test_siphash.c b/lib/siphash_kunit.c
similarity index 60%
rename from lib/test_siphash.c
rename to lib/siphash_kunit.c
index a96788d0141d..a3c697e8be35 100644
--- a/lib/test_siphash.c
+++ b/lib/siphash_kunit.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/test.h>
 #include <linux/siphash.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -109,114 +110,88 @@ static const u32 test_vectors_hsiphash[64] = {
 };
 #endif
 
-static int __init siphash_test_init(void)
+#define chk(hash, vector, fmt...)			\
+	KUNIT_EXPECT_EQ_MSG(test, hash, vector, fmt)
+
+static void siphash_test(struct kunit *test)
 {
 	u8 in[64] __aligned(SIPHASH_ALIGNMENT);
 	u8 in_unaligned[65] __aligned(SIPHASH_ALIGNMENT);
 	u8 i;
-	int ret = 0;
 
 	for (i = 0; i < 64; ++i) {
 		in[i] = i;
 		in_unaligned[i + 1] = i;
-		if (siphash(in, i, &test_key_siphash) !=
-						test_vectors_siphash[i]) {
-			pr_info("siphash self-test aligned %u: FAIL\n", i + 1);
-			ret = -EINVAL;
-		}
-		if (siphash(in_unaligned + 1, i, &test_key_siphash) !=
-						test_vectors_siphash[i]) {
-			pr_info("siphash self-test unaligned %u: FAIL\n", i + 1);
-			ret = -EINVAL;
-		}
-		if (hsiphash(in, i, &test_key_hsiphash) !=
-						test_vectors_hsiphash[i]) {
-			pr_info("hsiphash self-test aligned %u: FAIL\n", i + 1);
-			ret = -EINVAL;
-		}
-		if (hsiphash(in_unaligned + 1, i, &test_key_hsiphash) !=
-						test_vectors_hsiphash[i]) {
-			pr_info("hsiphash self-test unaligned %u: FAIL\n", i + 1);
-			ret = -EINVAL;
-		}
-	}
-	if (siphash_1u64(0x0706050403020100ULL, &test_key_siphash) !=
-						test_vectors_siphash[8]) {
-		pr_info("siphash self-test 1u64: FAIL\n");
-		ret = -EINVAL;
-	}
-	if (siphash_2u64(0x0706050403020100ULL, 0x0f0e0d0c0b0a0908ULL,
-			 &test_key_siphash) != test_vectors_siphash[16]) {
-		pr_info("siphash self-test 2u64: FAIL\n");
-		ret = -EINVAL;
+		chk(siphash(in, i, &test_key_siphash),
+		    test_vectors_siphash[i],
+		    "siphash self-test aligned %u: FAIL", i + 1);
+		chk(siphash(in_unaligned + 1, i, &test_key_siphash),
+		    test_vectors_siphash[i],
+		    "siphash self-test unaligned %u: FAIL", i + 1);
+		chk(hsiphash(in, i, &test_key_hsiphash),
+		    test_vectors_hsiphash[i],
+		    "hsiphash self-test aligned %u: FAIL", i + 1);
+		chk(hsiphash(in_unaligned + 1, i, &test_key_hsiphash),
+		    test_vectors_hsiphash[i],
+		    "hsiphash self-test unaligned %u: FAIL", i + 1);
 	}
-	if (siphash_3u64(0x0706050403020100ULL, 0x0f0e0d0c0b0a0908ULL,
-			 0x1716151413121110ULL, &test_key_siphash) !=
-						test_vectors_siphash[24]) {
-		pr_info("siphash self-test 3u64: FAIL\n");
-		ret = -EINVAL;
-	}
-	if (siphash_4u64(0x0706050403020100ULL, 0x0f0e0d0c0b0a0908ULL,
+	chk(siphash_1u64(0x0706050403020100ULL, &test_key_siphash),
+	    test_vectors_siphash[8],
+	    "siphash self-test 1u64: FAIL");
+	chk(siphash_2u64(0x0706050403020100ULL, 0x0f0e0d0c0b0a0908ULL,
+			 &test_key_siphash),
+	    test_vectors_siphash[16],
+	    "siphash self-test 2u64: FAIL");
+	chk(siphash_3u64(0x0706050403020100ULL, 0x0f0e0d0c0b0a0908ULL,
+			 0x1716151413121110ULL, &test_key_siphash),
+	    test_vectors_siphash[24],
+	    "siphash self-test 3u64: FAIL");
+	chk(siphash_4u64(0x0706050403020100ULL, 0x0f0e0d0c0b0a0908ULL,
 			 0x1716151413121110ULL, 0x1f1e1d1c1b1a1918ULL,
-			 &test_key_siphash) != test_vectors_siphash[32]) {
-		pr_info("siphash self-test 4u64: FAIL\n");
-		ret = -EINVAL;
-	}
-	if (siphash_1u32(0x03020100U, &test_key_siphash) !=
-						test_vectors_siphash[4]) {
-		pr_info("siphash self-test 1u32: FAIL\n");
-		ret = -EINVAL;
-	}
-	if (siphash_2u32(0x03020100U, 0x07060504U, &test_key_siphash) !=
-						test_vectors_siphash[8]) {
-		pr_info("siphash self-test 2u32: FAIL\n");
-		ret = -EINVAL;
-	}
-	if (siphash_3u32(0x03020100U, 0x07060504U,
-			 0x0b0a0908U, &test_key_siphash) !=
-						test_vectors_siphash[12]) {
-		pr_info("siphash self-test 3u32: FAIL\n");
-		ret = -EINVAL;
-	}
-	if (siphash_4u32(0x03020100U, 0x07060504U,
-			 0x0b0a0908U, 0x0f0e0d0cU, &test_key_siphash) !=
-						test_vectors_siphash[16]) {
-		pr_info("siphash self-test 4u32: FAIL\n");
-		ret = -EINVAL;
-	}
-	if (hsiphash_1u32(0x03020100U, &test_key_hsiphash) !=
-						test_vectors_hsiphash[4]) {
-		pr_info("hsiphash self-test 1u32: FAIL\n");
-		ret = -EINVAL;
-	}
-	if (hsiphash_2u32(0x03020100U, 0x07060504U, &test_key_hsiphash) !=
-						test_vectors_hsiphash[8]) {
-		pr_info("hsiphash self-test 2u32: FAIL\n");
-		ret = -EINVAL;
-	}
-	if (hsiphash_3u32(0x03020100U, 0x07060504U,
-			  0x0b0a0908U, &test_key_hsiphash) !=
-						test_vectors_hsiphash[12]) {
-		pr_info("hsiphash self-test 3u32: FAIL\n");
-		ret = -EINVAL;
-	}
-	if (hsiphash_4u32(0x03020100U, 0x07060504U,
-			  0x0b0a0908U, 0x0f0e0d0cU, &test_key_hsiphash) !=
-						test_vectors_hsiphash[16]) {
-		pr_info("hsiphash self-test 4u32: FAIL\n");
-		ret = -EINVAL;
-	}
-	if (!ret)
-		pr_info("self-tests: pass\n");
-	return ret;
+			 &test_key_siphash),
+	    test_vectors_siphash[32],
+	    "siphash self-test 4u64: FAIL");
+	chk(siphash_1u32(0x03020100U, &test_key_siphash),
+	    test_vectors_siphash[4],
+	    "siphash self-test 1u32: FAIL");
+	chk(siphash_2u32(0x03020100U, 0x07060504U, &test_key_siphash),
+	    test_vectors_siphash[8],
+	    "siphash self-test 2u32: FAIL");
+	chk(siphash_3u32(0x03020100U, 0x07060504U,
+			 0x0b0a0908U, &test_key_siphash),
+	    test_vectors_siphash[12],
+	    "siphash self-test 3u32: FAIL");
+	chk(siphash_4u32(0x03020100U, 0x07060504U,
+			 0x0b0a0908U, 0x0f0e0d0cU, &test_key_siphash),
+	    test_vectors_siphash[16],
+	    "siphash self-test 4u32: FAIL");
+	chk(hsiphash_1u32(0x03020100U, &test_key_hsiphash),
+	    test_vectors_hsiphash[4],
+	    "hsiphash self-test 1u32: FAIL");
+	chk(hsiphash_2u32(0x03020100U, 0x07060504U, &test_key_hsiphash),
+	    test_vectors_hsiphash[8],
+	    "hsiphash self-test 2u32: FAIL");
+	chk(hsiphash_3u32(0x03020100U, 0x07060504U,
+			  0x0b0a0908U, &test_key_hsiphash),
+	    test_vectors_hsiphash[12],
+	    "hsiphash self-test 3u32: FAIL");
+	chk(hsiphash_4u32(0x03020100U, 0x07060504U,
+			  0x0b0a0908U, 0x0f0e0d0cU, &test_key_hsiphash),
+	    test_vectors_hsiphash[16],
+	    "hsiphash self-test 4u32: FAIL");
 }
 
-static void __exit siphash_test_exit(void)
-{
-}
+static struct kunit_case siphash_test_cases[] = {
+	KUNIT_CASE(siphash_test),
+	{}
+};
+
+static struct kunit_suite siphash_test_suite = {
+	.name = "siphash",
+	.test_cases = siphash_test_cases,
+};
 
-module_init(siphash_test_init);
-module_exit(siphash_test_exit);
+kunit_test_suite(siphash_test_suite);
 
 MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.34.1

