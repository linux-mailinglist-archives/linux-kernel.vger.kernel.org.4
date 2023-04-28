Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BE26F165B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbjD1LEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345504AbjD1LEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:04:43 -0400
Received: from mail.nsr.re.kr (unknown [210.104.33.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A504497
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; s=LIY0OQ3MUMW6182UNI14; d=nsr.re.kr; t=1682679713; c=relaxed/relaxed; h=date:from:message-id:mime-version:subject:to; bh=V56FEsJobNDyA19FboZVS3+KQvUZ3u+gIvK5WOE8Nt0=; b=A/QjAUbrNjSWM/4wseqSHNw1zrSaoDrWqoi8VPZMude8HAyBXWlGeDH32QRrKUKPPOpnt5FyJeIFSq6smoEwbjMpiWGc5hDpmyLVyNbG9tSJkpaMhNRK+t2zW83iJ4yshwj6NjXFZxxvjNB4GFwlhFoUR89uPoEpc7tJDGY1zTfnZN9xBkdTGHIifloNEHlyBwF/jxNKshl8n7WpGudvdj7gbLoFBrCbxyibihqid15UIvLToYCCsXh9XpEy9ex332Zph5OdHd6CosqzCQBK5GsRbI3tWJsjhhO5pzrFhdGb7PzgH5lweCdZkN6H0RbX4Wfgb9WVNPjUFcyP0BFC+A==
Received: from 210.104.33.70 (nsr.re.kr)
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128 bits))
        by mail.nsr.re.kr with SMTP; Fri, 28 Apr 2023 19:59:32 +0900
Received: from 192.168.155.188 ([192.168.155.188])
          by mail.nsr.re.kr (Crinity Message Backbone-7.0.1) with SMTP ID 623;
          Fri, 28 Apr 2023 20:01:11 +0900 (KST)
From:   Dongsoo Lee <letrhee@nsr.re.kr>
To:     linux-crypto@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "David S. Miller" <abc@test.nsr.re.kr>,
        Dongsoo Lee <letrhee@gmail.com>,
        Dongsoo Lee <letrhee@nsr.re.kr>
Subject: [PATCH 1/3] crypto: LEA block cipher implementation
Date:   Fri, 28 Apr 2023 20:00:56 +0900
Message-Id: <20230428110058.1516119-2-letrhee@nsr.re.kr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230428110058.1516119-1-letrhee@nsr.re.kr>
References: <20230428110058.1516119-1-letrhee@nsr.re.kr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LEA is a Korean national standard block cipher, described in
"KS X 3246" and is also included in the international standard, "ISO/IEC
29192-2:2019 standard (Information security - Lightweight cryptography
- Part 2: Block ciphers)".

The LEA algorithm is a symmetric key cipher that processes data blocks
of 128-bits and has three different key lengths, each with a different
number of rounds:

- LEA-128: 128-bit key, 24 rounds,
- LEA-192: 192-bit key, 28 rounds, and
- LEA-256: 256-bit key, 32 rounds.

The round function of LEA consists of 32-bit ARX(modular Addition,
bitwise Rotation, and bitwise XOR) operations.

The implementation same as submitted generic C implementation is
distributed through the Korea Internet & Security Agency (KISA).

- https://seed.kisa.or.kr/kisa/algorithm/EgovLeaInfo.do
- https://seed.kisa.or.kr/kisa/Board/20/detailView.do

Signed-off-by: Dongsoo Lee <letrhee@nsr.re.kr>
---
 crypto/Kconfig       |  12 +
 crypto/Makefile      |   1 +
 crypto/lea_generic.c | 915 +++++++++++++++++++++++++++++++++++++++++++
 include/crypto/lea.h |  39 ++
 4 files changed, 967 insertions(+)
 create mode 100644 crypto/lea_generic.c
 create mode 100644 include/crypto/lea.h

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 9c86f7045157..5c56f6083cbd 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -485,6 +485,18 @@ config CRYPTO_KHAZAD
 	  See https://web.archive.org/web/20171011071731/http://www.larc.usp.br/~pbarreto/KhazadPage.html
 	  for further information.
 
+config CRYPTO_LEA
+	tristate "LEA"
+	select CRYPTO_ALGAPI
+	help
+	  LEA cipher algorithm (KS X 3246, ISO/IEC 29192-2:2019)
+
+	  LEA is one of the standard cryptographic alorithms of
+	  the Republic of Korea. It consists of four 32bit word.
+
+	  See:
+	  https://seed.kisa.or.kr/kisa/algorithm/EgovLeaInfo.do
+
 config CRYPTO_SEED
 	tristate "SEED"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
diff --git a/crypto/Makefile b/crypto/Makefile
index d0126c915834..bf52af4dfdf2 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -149,6 +149,7 @@ obj-$(CONFIG_CRYPTO_KHAZAD) += khazad.o
 obj-$(CONFIG_CRYPTO_ANUBIS) += anubis.o
 obj-$(CONFIG_CRYPTO_SEED) += seed.o
 obj-$(CONFIG_CRYPTO_ARIA) += aria_generic.o
+obj-$(CONFIG_CRYPTO_LEA) += lea_generic.o
 obj-$(CONFIG_CRYPTO_CHACHA20) += chacha_generic.o
 obj-$(CONFIG_CRYPTO_POLY1305) += poly1305_generic.o
 obj-$(CONFIG_CRYPTO_DEFLATE) += deflate.o
diff --git a/crypto/lea_generic.c b/crypto/lea_generic.c
new file mode 100644
index 000000000000..919c23e7bcc5
--- /dev/null
+++ b/crypto/lea_generic.c
@@ -0,0 +1,915 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Cryptographic API.
+ *
+ * LEA Cipher Algorithm
+ *
+ * LEA is a 128-bit block cipher developed by South Korea in 2013.
+ *
+ * LEA is the national standard of Republic of Korea (KS X 3246) and included in
+ * the ISO/IEC 29192-2:2019 standard (Information security - Lightweight
+ * cryptography - Part 2: Block ciphers).
+ *
+ * Copyright (c) 2023 National Security Research.
+ * Author: Dongsoo Lee <letrhee@nsr.re.kr>
+ */
+
+
+#include <asm/unaligned.h>
+#include <linux/module.h>
+#include <linux/crypto.h>
+#include <crypto/algapi.h>
+#include <crypto/lea.h>
+
+static const u32 lea_delta[8][36] ____cacheline_aligned = {
+	{
+		0xc3efe9db, 0x87dfd3b7, 0x0fbfa76f, 0x1f7f4ede, 0x3efe9dbc, 0x7dfd3b78,
+		0xfbfa76f0, 0xf7f4ede1, 0xefe9dbc3, 0xdfd3b787, 0xbfa76f0f, 0x7f4ede1f,
+		0xfe9dbc3e, 0xfd3b787d, 0xfa76f0fb, 0xf4ede1f7, 0xe9dbc3ef, 0xd3b787df,
+		0xa76f0fbf, 0x4ede1f7f, 0x9dbc3efe, 0x3b787dfd, 0x76f0fbfa, 0xede1f7f4,
+		0xdbc3efe9, 0xb787dfd3, 0x6f0fbfa7, 0xde1f7f4e, 0xbc3efe9d, 0x787dfd3b,
+		0xf0fbfa76, 0xe1f7f4eD, 0xc3efe9db, 0x87dfd3b7, 0x0fbfa76f, 0x1f7f4ede
+	},
+	{
+		0x44626b02, 0x88c4d604, 0x1189ac09, 0x23135812, 0x4626b024, 0x8c4d6048,
+		0x189ac091, 0x31358122, 0x626b0244, 0xc4d60488, 0x89ac0911, 0x13581223,
+		0x26b02446, 0x4d60488c, 0x9ac09118, 0x35812231, 0x6b024462, 0xd60488c4,
+		0xac091189, 0x58122313, 0xb0244626, 0x60488c4d, 0xc091189a, 0x81223135,
+		0x0244626b, 0x0488c4d6, 0x091189ac, 0x12231358, 0x244626b0, 0x488c4d60,
+		0x91189ac0, 0x22313581, 0x44626b02, 0x88c4d604, 0x1189ac09, 0x23135812
+	},
+	{
+		0x79e27c8a, 0xf3c4f914, 0xe789f229, 0xcf13e453, 0x9e27c8a7, 0x3c4f914f,
+		0x789f229e, 0xf13e453c, 0xe27c8a79, 0xc4f914f3, 0x89f229e7, 0x13e453cf,
+		0x27c8a79e, 0x4f914f3c, 0x9f229e78, 0x3e453cf1, 0x7c8a79e2, 0xf914f3c4,
+		0xf229e789, 0xe453cf13, 0xc8a79e27, 0x914f3c4f, 0x229e789f, 0x453cf13e,
+		0x8a79e27c, 0x14f3c4f9, 0x29e789f2, 0x53cf13e4, 0xa79e27c8, 0x4f3c4f91,
+		0x9e789f22, 0x3cf13e45, 0x79e27c8a, 0xf3c4f914, 0xe789f229, 0xcf13e453
+	},
+	{
+		0x78df30ec, 0xf1be61d8, 0xe37cc3b1, 0xc6f98763, 0x8df30ec7, 0x1be61d8f,
+		0x37cc3b1e, 0x6f98763c, 0xdf30ec78, 0xbe61d8f1, 0x7cc3b1e3, 0xf98763c6,
+		0xf30ec78d, 0xe61d8f1b, 0xcc3b1e37, 0x98763c6f, 0x30ec78df, 0x61d8f1be,
+		0xc3b1e37c, 0x8763c6f9, 0x0ec78df3, 0x1d8f1be6, 0x3b1e37cc, 0x763c6f98,
+		0xec78df30, 0xd8f1be61, 0xb1e37cc3, 0x63c6f987, 0xc78df30e, 0x8f1be61d,
+		0x1e37cc3b, 0x3c6f9876, 0x78df30ec, 0xf1be61d8, 0xe37cc3b1, 0xc6f98763
+	},
+	{
+		0x715ea49e, 0xe2bd493c, 0xc57a9279, 0x8af524f3, 0x15ea49e7, 0x2bd493ce,
+		0x57a9279c, 0xaf524f38, 0x5ea49e71, 0xbd493ce2, 0x7a9279c5, 0xf524f38a,
+		0xea49e715, 0xd493ce2b, 0xa9279c57, 0x524f38af, 0xa49e715e, 0x493ce2bd,
+		0x9279c57a, 0x24f38af5, 0x49e715ea, 0x93ce2bd4, 0x279c57a9, 0x4f38af52,
+		0x9e715ea4, 0x3ce2bd49, 0x79c57a92, 0xf38af524, 0xe715ea49, 0xce2bd493,
+		0x9c57a927, 0x38af524f, 0x715ea49e, 0xe2bd493c, 0xc57a9279, 0x8af524f3
+	},
+	{
+		0xc785da0a, 0x8f0bb415, 0x1e17682b, 0x3c2ed056, 0x785da0ac, 0xf0bb4158,
+		0xe17682b1, 0xc2ed0563, 0x85da0ac7, 0x0bb4158f, 0x17682b1e, 0x2ed0563c,
+		0x5da0ac78, 0xbb4158f0, 0x7682b1e1, 0xed0563c2, 0xda0ac785, 0xb4158f0b,
+		0x682b1e17, 0xd0563c2e, 0xa0ac785d, 0x4158f0bb, 0x82b1e176, 0x0563c2ed,
+		0x0ac785da, 0x158f0bb4, 0x2b1e1768, 0x563c2ed0, 0xac785da0, 0x58f0bb41,
+		0xb1e17682, 0x63c2ed05, 0xc785da0a, 0x8f0bb415, 0x1e17682b, 0x3c2ed056
+	},
+	{
+		0xe04ef22a, 0xc09de455, 0x813bc8ab, 0x02779157, 0x04ef22ae, 0x09de455c,
+		0x13bc8ab8, 0x27791570, 0x4ef22ae0, 0x9de455c0, 0x3bc8ab81, 0x77915702,
+		0xef22ae04, 0xde455c09, 0xbc8ab813, 0x79157027, 0xf22ae04e, 0xe455c09d,
+		0xc8ab813b, 0x91570277, 0x22ae04ef, 0x455c09de, 0x8ab813bc, 0x15702779,
+		0x2ae04ef2, 0x55c09de4, 0xab813bc8, 0x57027791, 0xae04ef22, 0x5c09de45,
+		0xb813bc8a, 0x70277915, 0xe04ef22a, 0xc09de455, 0x813bc8ab, 0x02779157
+	},
+	{
+		0xe5c40957, 0xcb8812af, 0x9710255f, 0x2e204abf, 0x5c40957e, 0xb8812afc,
+		0x710255f9, 0xe204abf2, 0xc40957e5, 0x8812afcb, 0x10255f97, 0x204abf2e,
+		0x40957e5c, 0x812afcb8, 0x0255f971, 0x04abf2e2, 0x0957e5c4, 0x12afcb88,
+		0x255f9710, 0x4abf2e20, 0x957e5c40, 0x2afcb881, 0x55f97102, 0xabf2e204,
+		0x57e5c409, 0xafcb8812, 0x5f971025, 0xbf2e204a, 0x7e5c4095, 0xfcb8812a,
+		0xf9710255, 0xf2e204ab, 0xe5c40957, 0xcb8812af, 0x9710255f, 0x2e204abf
+	}
+};
+
+void lea_encrypt(const void *ctx, u8 *out, const u8 *in)
+{
+	const struct crypto_lea_ctx *key = ctx;
+	u32 X0 = get_unaligned_le32(&in[0]);
+	u32 X1 = get_unaligned_le32(&in[4]);
+	u32 X2 = get_unaligned_le32(&in[8]);
+	u32 X3 = get_unaligned_le32(&in[12]);
+
+	X3 = ror32((X2 ^ key->rk[4]) + (X3 ^ key->rk[5]), 3);
+	X2 = ror32((X1 ^ key->rk[2]) + (X2 ^ key->rk[3]), 5);
+	X1 = rol32((X0 ^ key->rk[0]) + (X1 ^ key->rk[1]), 9);
+	X0 = ror32((X3 ^ key->rk[10]) + (X0 ^ key->rk[11]), 3);
+	X3 = ror32((X2 ^ key->rk[8]) + (X3 ^ key->rk[9]), 5);
+	X2 = rol32((X1 ^ key->rk[6]) + (X2 ^ key->rk[7]), 9);
+	X1 = ror32((X0 ^ key->rk[16]) + (X1 ^ key->rk[17]), 3);
+	X0 = ror32((X3 ^ key->rk[14]) + (X0 ^ key->rk[15]), 5);
+	X3 = rol32((X2 ^ key->rk[12]) + (X3 ^ key->rk[13]), 9);
+	X2 = ror32((X1 ^ key->rk[22]) + (X2 ^ key->rk[23]), 3);
+	X1 = ror32((X0 ^ key->rk[20]) + (X1 ^ key->rk[21]), 5);
+	X0 = rol32((X3 ^ key->rk[18]) + (X0 ^ key->rk[19]), 9);
+
+	X3 = ror32((X2 ^ key->rk[28]) + (X3 ^ key->rk[29]), 3);
+	X2 = ror32((X1 ^ key->rk[26]) + (X2 ^ key->rk[27]), 5);
+	X1 = rol32((X0 ^ key->rk[24]) + (X1 ^ key->rk[25]), 9);
+	X0 = ror32((X3 ^ key->rk[34]) + (X0 ^ key->rk[35]), 3);
+	X3 = ror32((X2 ^ key->rk[32]) + (X3 ^ key->rk[33]), 5);
+	X2 = rol32((X1 ^ key->rk[30]) + (X2 ^ key->rk[31]), 9);
+	X1 = ror32((X0 ^ key->rk[40]) + (X1 ^ key->rk[41]), 3);
+	X0 = ror32((X3 ^ key->rk[38]) + (X0 ^ key->rk[39]), 5);
+	X3 = rol32((X2 ^ key->rk[36]) + (X3 ^ key->rk[37]), 9);
+	X2 = ror32((X1 ^ key->rk[46]) + (X2 ^ key->rk[47]), 3);
+	X1 = ror32((X0 ^ key->rk[44]) + (X1 ^ key->rk[45]), 5);
+	X0 = rol32((X3 ^ key->rk[42]) + (X0 ^ key->rk[43]), 9);
+
+	X3 = ror32((X2 ^ key->rk[52]) + (X3 ^ key->rk[53]), 3);
+	X2 = ror32((X1 ^ key->rk[50]) + (X2 ^ key->rk[51]), 5);
+	X1 = rol32((X0 ^ key->rk[48]) + (X1 ^ key->rk[49]), 9);
+	X0 = ror32((X3 ^ key->rk[58]) + (X0 ^ key->rk[59]), 3);
+	X3 = ror32((X2 ^ key->rk[56]) + (X3 ^ key->rk[57]), 5);
+	X2 = rol32((X1 ^ key->rk[54]) + (X2 ^ key->rk[55]), 9);
+	X1 = ror32((X0 ^ key->rk[64]) + (X1 ^ key->rk[65]), 3);
+	X0 = ror32((X3 ^ key->rk[62]) + (X0 ^ key->rk[63]), 5);
+	X3 = rol32((X2 ^ key->rk[60]) + (X3 ^ key->rk[61]), 9);
+	X2 = ror32((X1 ^ key->rk[70]) + (X2 ^ key->rk[71]), 3);
+	X1 = ror32((X0 ^ key->rk[68]) + (X1 ^ key->rk[69]), 5);
+	X0 = rol32((X3 ^ key->rk[66]) + (X0 ^ key->rk[67]), 9);
+
+	X3 = ror32((X2 ^ key->rk[76]) + (X3 ^ key->rk[77]), 3);
+	X2 = ror32((X1 ^ key->rk[74]) + (X2 ^ key->rk[75]), 5);
+	X1 = rol32((X0 ^ key->rk[72]) + (X1 ^ key->rk[73]), 9);
+	X0 = ror32((X3 ^ key->rk[82]) + (X0 ^ key->rk[83]), 3);
+	X3 = ror32((X2 ^ key->rk[80]) + (X3 ^ key->rk[81]), 5);
+	X2 = rol32((X1 ^ key->rk[78]) + (X2 ^ key->rk[79]), 9);
+	X1 = ror32((X0 ^ key->rk[88]) + (X1 ^ key->rk[89]), 3);
+	X0 = ror32((X3 ^ key->rk[86]) + (X0 ^ key->rk[87]), 5);
+	X3 = rol32((X2 ^ key->rk[84]) + (X3 ^ key->rk[85]), 9);
+	X2 = ror32((X1 ^ key->rk[94]) + (X2 ^ key->rk[95]), 3);
+	X1 = ror32((X0 ^ key->rk[92]) + (X1 ^ key->rk[93]), 5);
+	X0 = rol32((X3 ^ key->rk[90]) + (X0 ^ key->rk[91]), 9);
+
+	X3 = ror32((X2 ^ key->rk[100]) + (X3 ^ key->rk[101]), 3);
+	X2 = ror32((X1 ^ key->rk[98]) + (X2 ^ key->rk[99]), 5);
+	X1 = rol32((X0 ^ key->rk[96]) + (X1 ^ key->rk[97]), 9);
+	X0 = ror32((X3 ^ key->rk[106]) + (X0 ^ key->rk[107]), 3);
+	X3 = ror32((X2 ^ key->rk[104]) + (X3 ^ key->rk[105]), 5);
+	X2 = rol32((X1 ^ key->rk[102]) + (X2 ^ key->rk[103]), 9);
+	X1 = ror32((X0 ^ key->rk[112]) + (X1 ^ key->rk[113]), 3);
+	X0 = ror32((X3 ^ key->rk[110]) + (X0 ^ key->rk[111]), 5);
+	X3 = rol32((X2 ^ key->rk[108]) + (X3 ^ key->rk[109]), 9);
+	X2 = ror32((X1 ^ key->rk[118]) + (X2 ^ key->rk[119]), 3);
+	X1 = ror32((X0 ^ key->rk[116]) + (X1 ^ key->rk[117]), 5);
+	X0 = rol32((X3 ^ key->rk[114]) + (X0 ^ key->rk[115]), 9);
+
+	X3 = ror32((X2 ^ key->rk[124]) + (X3 ^ key->rk[125]), 3);
+	X2 = ror32((X1 ^ key->rk[122]) + (X2 ^ key->rk[123]), 5);
+	X1 = rol32((X0 ^ key->rk[120]) + (X1 ^ key->rk[121]), 9);
+	X0 = ror32((X3 ^ key->rk[130]) + (X0 ^ key->rk[131]), 3);
+	X3 = ror32((X2 ^ key->rk[128]) + (X3 ^ key->rk[129]), 5);
+	X2 = rol32((X1 ^ key->rk[126]) + (X2 ^ key->rk[127]), 9);
+	X1 = ror32((X0 ^ key->rk[136]) + (X1 ^ key->rk[137]), 3);
+	X0 = ror32((X3 ^ key->rk[134]) + (X0 ^ key->rk[135]), 5);
+	X3 = rol32((X2 ^ key->rk[132]) + (X3 ^ key->rk[133]), 9);
+	X2 = ror32((X1 ^ key->rk[142]) + (X2 ^ key->rk[143]), 3);
+	X1 = ror32((X0 ^ key->rk[140]) + (X1 ^ key->rk[141]), 5);
+	X0 = rol32((X3 ^ key->rk[138]) + (X0 ^ key->rk[139]), 9);
+
+	if (key->round > 24) {
+		X3 = ror32((X2 ^ key->rk[148]) + (X3 ^ key->rk[149]), 3);
+		X2 = ror32((X1 ^ key->rk[146]) + (X2 ^ key->rk[147]), 5);
+		X1 = rol32((X0 ^ key->rk[144]) + (X1 ^ key->rk[145]), 9);
+		X0 = ror32((X3 ^ key->rk[154]) + (X0 ^ key->rk[155]), 3);
+		X3 = ror32((X2 ^ key->rk[152]) + (X3 ^ key->rk[153]), 5);
+		X2 = rol32((X1 ^ key->rk[150]) + (X2 ^ key->rk[151]), 9);
+		X1 = ror32((X0 ^ key->rk[160]) + (X1 ^ key->rk[161]), 3);
+		X0 = ror32((X3 ^ key->rk[158]) + (X0 ^ key->rk[159]), 5);
+		X3 = rol32((X2 ^ key->rk[156]) + (X3 ^ key->rk[157]), 9);
+		X2 = ror32((X1 ^ key->rk[166]) + (X2 ^ key->rk[167]), 3);
+		X1 = ror32((X0 ^ key->rk[164]) + (X1 ^ key->rk[165]), 5);
+		X0 = rol32((X3 ^ key->rk[162]) + (X0 ^ key->rk[163]), 9);
+	}
+
+	if (key->round > 28) {
+		X3 = ror32((X2 ^ key->rk[172]) + (X3 ^ key->rk[173]), 3);
+		X2 = ror32((X1 ^ key->rk[170]) + (X2 ^ key->rk[171]), 5);
+		X1 = rol32((X0 ^ key->rk[168]) + (X1 ^ key->rk[169]), 9);
+		X0 = ror32((X3 ^ key->rk[178]) + (X0 ^ key->rk[179]), 3);
+		X3 = ror32((X2 ^ key->rk[176]) + (X3 ^ key->rk[177]), 5);
+		X2 = rol32((X1 ^ key->rk[174]) + (X2 ^ key->rk[175]), 9);
+		X1 = ror32((X0 ^ key->rk[184]) + (X1 ^ key->rk[185]), 3);
+		X0 = ror32((X3 ^ key->rk[182]) + (X0 ^ key->rk[183]), 5);
+		X3 = rol32((X2 ^ key->rk[180]) + (X3 ^ key->rk[181]), 9);
+		X2 = ror32((X1 ^ key->rk[190]) + (X2 ^ key->rk[191]), 3);
+		X1 = ror32((X0 ^ key->rk[188]) + (X1 ^ key->rk[189]), 5);
+		X0 = rol32((X3 ^ key->rk[186]) + (X0 ^ key->rk[187]), 9);
+	}
+
+	put_unaligned_le32(X0, &out[0]);
+	put_unaligned_le32(X1, &out[4]);
+	put_unaligned_le32(X2, &out[8]);
+	put_unaligned_le32(X3, &out[12]);
+}
+EXPORT_SYMBOL_GPL(lea_encrypt);
+
+void lea_decrypt(const void *ctx, u8 *out, const u8 *in)
+{
+	const struct crypto_lea_ctx *key = ctx;
+
+	u32 X0 = get_unaligned_le32(&in[0]);
+	u32 X1 = get_unaligned_le32(&in[4]);
+	u32 X2 = get_unaligned_le32(&in[8]);
+	u32 X3 = get_unaligned_le32(&in[12]);
+
+	if (key->round > 28) {
+		X0 = (ror32(X0, 9) - (X3 ^ key->rk[186])) ^ key->rk[187];
+		X1 = (rol32(X1, 5) - (X0 ^ key->rk[188])) ^ key->rk[189];
+		X2 = (rol32(X2, 3) - (X1 ^ key->rk[190])) ^ key->rk[191];
+		X3 = (ror32(X3, 9) - (X2 ^ key->rk[180])) ^ key->rk[181];
+		X0 = (rol32(X0, 5) - (X3 ^ key->rk[182])) ^ key->rk[183];
+		X1 = (rol32(X1, 3) - (X0 ^ key->rk[184])) ^ key->rk[185];
+		X2 = (ror32(X2, 9) - (X1 ^ key->rk[174])) ^ key->rk[175];
+		X3 = (rol32(X3, 5) - (X2 ^ key->rk[176])) ^ key->rk[177];
+		X0 = (rol32(X0, 3) - (X3 ^ key->rk[178])) ^ key->rk[179];
+		X1 = (ror32(X1, 9) - (X0 ^ key->rk[168])) ^ key->rk[169];
+		X2 = (rol32(X2, 5) - (X1 ^ key->rk[170])) ^ key->rk[171];
+		X3 = (rol32(X3, 3) - (X2 ^ key->rk[172])) ^ key->rk[173];
+	}
+
+	if (key->round > 24) {
+		X0 = (ror32(X0, 9) - (X3 ^ key->rk[162])) ^ key->rk[163];
+		X1 = (rol32(X1, 5) - (X0 ^ key->rk[164])) ^ key->rk[165];
+		X2 = (rol32(X2, 3) - (X1 ^ key->rk[166])) ^ key->rk[167];
+		X3 = (ror32(X3, 9) - (X2 ^ key->rk[156])) ^ key->rk[157];
+		X0 = (rol32(X0, 5) - (X3 ^ key->rk[158])) ^ key->rk[159];
+		X1 = (rol32(X1, 3) - (X0 ^ key->rk[160])) ^ key->rk[161];
+		X2 = (ror32(X2, 9) - (X1 ^ key->rk[150])) ^ key->rk[151];
+		X3 = (rol32(X3, 5) - (X2 ^ key->rk[152])) ^ key->rk[153];
+		X0 = (rol32(X0, 3) - (X3 ^ key->rk[154])) ^ key->rk[155];
+		X1 = (ror32(X1, 9) - (X0 ^ key->rk[144])) ^ key->rk[145];
+		X2 = (rol32(X2, 5) - (X1 ^ key->rk[146])) ^ key->rk[147];
+		X3 = (rol32(X3, 3) - (X2 ^ key->rk[148])) ^ key->rk[149];
+	}
+
+	X0 = (ror32(X0, 9) - (X3 ^ key->rk[138])) ^ key->rk[139];
+	X1 = (rol32(X1, 5) - (X0 ^ key->rk[140])) ^ key->rk[141];
+	X2 = (rol32(X2, 3) - (X1 ^ key->rk[142])) ^ key->rk[143];
+	X3 = (ror32(X3, 9) - (X2 ^ key->rk[132])) ^ key->rk[133];
+	X0 = (rol32(X0, 5) - (X3 ^ key->rk[134])) ^ key->rk[135];
+	X1 = (rol32(X1, 3) - (X0 ^ key->rk[136])) ^ key->rk[137];
+	X2 = (ror32(X2, 9) - (X1 ^ key->rk[126])) ^ key->rk[127];
+	X3 = (rol32(X3, 5) - (X2 ^ key->rk[128])) ^ key->rk[129];
+	X0 = (rol32(X0, 3) - (X3 ^ key->rk[130])) ^ key->rk[131];
+	X1 = (ror32(X1, 9) - (X0 ^ key->rk[120])) ^ key->rk[121];
+	X2 = (rol32(X2, 5) - (X1 ^ key->rk[122])) ^ key->rk[123];
+	X3 = (rol32(X3, 3) - (X2 ^ key->rk[124])) ^ key->rk[125];
+
+	X0 = (ror32(X0, 9) - (X3 ^ key->rk[114])) ^ key->rk[115];
+	X1 = (rol32(X1, 5) - (X0 ^ key->rk[116])) ^ key->rk[117];
+	X2 = (rol32(X2, 3) - (X1 ^ key->rk[118])) ^ key->rk[119];
+	X3 = (ror32(X3, 9) - (X2 ^ key->rk[108])) ^ key->rk[109];
+	X0 = (rol32(X0, 5) - (X3 ^ key->rk[110])) ^ key->rk[111];
+	X1 = (rol32(X1, 3) - (X0 ^ key->rk[112])) ^ key->rk[113];
+	X2 = (ror32(X2, 9) - (X1 ^ key->rk[102])) ^ key->rk[103];
+	X3 = (rol32(X3, 5) - (X2 ^ key->rk[104])) ^ key->rk[105];
+	X0 = (rol32(X0, 3) - (X3 ^ key->rk[106])) ^ key->rk[107];
+	X1 = (ror32(X1, 9) - (X0 ^ key->rk[96])) ^ key->rk[97];
+	X2 = (rol32(X2, 5) - (X1 ^ key->rk[98])) ^ key->rk[99];
+	X3 = (rol32(X3, 3) - (X2 ^ key->rk[100])) ^ key->rk[101];
+
+	X0 = (ror32(X0, 9) - (X3 ^ key->rk[90])) ^ key->rk[91];
+	X1 = (rol32(X1, 5) - (X0 ^ key->rk[92])) ^ key->rk[93];
+	X2 = (rol32(X2, 3) - (X1 ^ key->rk[94])) ^ key->rk[95];
+	X3 = (ror32(X3, 9) - (X2 ^ key->rk[84])) ^ key->rk[85];
+	X0 = (rol32(X0, 5) - (X3 ^ key->rk[86])) ^ key->rk[87];
+	X1 = (rol32(X1, 3) - (X0 ^ key->rk[88])) ^ key->rk[89];
+	X2 = (ror32(X2, 9) - (X1 ^ key->rk[78])) ^ key->rk[79];
+	X3 = (rol32(X3, 5) - (X2 ^ key->rk[80])) ^ key->rk[81];
+	X0 = (rol32(X0, 3) - (X3 ^ key->rk[82])) ^ key->rk[83];
+	X1 = (ror32(X1, 9) - (X0 ^ key->rk[72])) ^ key->rk[73];
+	X2 = (rol32(X2, 5) - (X1 ^ key->rk[74])) ^ key->rk[75];
+	X3 = (rol32(X3, 3) - (X2 ^ key->rk[76])) ^ key->rk[77];
+
+	X0 = (ror32(X0, 9) - (X3 ^ key->rk[66])) ^ key->rk[67];
+	X1 = (rol32(X1, 5) - (X0 ^ key->rk[68])) ^ key->rk[69];
+	X2 = (rol32(X2, 3) - (X1 ^ key->rk[70])) ^ key->rk[71];
+	X3 = (ror32(X3, 9) - (X2 ^ key->rk[60])) ^ key->rk[61];
+	X0 = (rol32(X0, 5) - (X3 ^ key->rk[62])) ^ key->rk[63];
+	X1 = (rol32(X1, 3) - (X0 ^ key->rk[64])) ^ key->rk[65];
+	X2 = (ror32(X2, 9) - (X1 ^ key->rk[54])) ^ key->rk[55];
+	X3 = (rol32(X3, 5) - (X2 ^ key->rk[56])) ^ key->rk[57];
+	X0 = (rol32(X0, 3) - (X3 ^ key->rk[58])) ^ key->rk[59];
+	X1 = (ror32(X1, 9) - (X0 ^ key->rk[48])) ^ key->rk[49];
+	X2 = (rol32(X2, 5) - (X1 ^ key->rk[50])) ^ key->rk[51];
+	X3 = (rol32(X3, 3) - (X2 ^ key->rk[52])) ^ key->rk[53];
+
+	X0 = (ror32(X0, 9) - (X3 ^ key->rk[42])) ^ key->rk[43];
+	X1 = (rol32(X1, 5) - (X0 ^ key->rk[44])) ^ key->rk[45];
+	X2 = (rol32(X2, 3) - (X1 ^ key->rk[46])) ^ key->rk[47];
+	X3 = (ror32(X3, 9) - (X2 ^ key->rk[36])) ^ key->rk[37];
+	X0 = (rol32(X0, 5) - (X3 ^ key->rk[38])) ^ key->rk[39];
+	X1 = (rol32(X1, 3) - (X0 ^ key->rk[40])) ^ key->rk[41];
+	X2 = (ror32(X2, 9) - (X1 ^ key->rk[30])) ^ key->rk[31];
+	X3 = (rol32(X3, 5) - (X2 ^ key->rk[32])) ^ key->rk[33];
+	X0 = (rol32(X0, 3) - (X3 ^ key->rk[34])) ^ key->rk[35];
+	X1 = (ror32(X1, 9) - (X0 ^ key->rk[24])) ^ key->rk[25];
+	X2 = (rol32(X2, 5) - (X1 ^ key->rk[26])) ^ key->rk[27];
+	X3 = (rol32(X3, 3) - (X2 ^ key->rk[28])) ^ key->rk[29];
+
+	X0 = (ror32(X0, 9) - (X3 ^ key->rk[18])) ^ key->rk[19];
+	X1 = (rol32(X1, 5) - (X0 ^ key->rk[20])) ^ key->rk[21];
+	X2 = (rol32(X2, 3) - (X1 ^ key->rk[22])) ^ key->rk[23];
+	X3 = (ror32(X3, 9) - (X2 ^ key->rk[12])) ^ key->rk[13];
+	X0 = (rol32(X0, 5) - (X3 ^ key->rk[14])) ^ key->rk[15];
+	X1 = (rol32(X1, 3) - (X0 ^ key->rk[16])) ^ key->rk[17];
+	X2 = (ror32(X2, 9) - (X1 ^ key->rk[6])) ^ key->rk[7];
+	X3 = (rol32(X3, 5) - (X2 ^ key->rk[8])) ^ key->rk[9];
+	X0 = (rol32(X0, 3) - (X3 ^ key->rk[10])) ^ key->rk[11];
+	X1 = (ror32(X1, 9) - (X0 ^ key->rk[0])) ^ key->rk[1];
+	X2 = (rol32(X2, 5) - (X1 ^ key->rk[2])) ^ key->rk[3];
+	X3 = (rol32(X3, 3) - (X2 ^ key->rk[4])) ^ key->rk[5];
+
+	put_unaligned_le32(X0, &out[0]);
+	put_unaligned_le32(X1, &out[4]);
+	put_unaligned_le32(X2, &out[8]);
+	put_unaligned_le32(X3, &out[12]);
+}
+EXPORT_SYMBOL_GPL(lea_decrypt);
+
+int lea_set_key(struct crypto_lea_ctx *key, const u8 *in_key,
+						u32 key_len)
+{
+	const u32 *_mk = (const u32 *)in_key;
+
+	switch (key_len) {
+	case 16:
+		key->rk[0] = rol32(get_unaligned_le32(&_mk[0]) + lea_delta[0][0], 1);
+		key->rk[6] = rol32(key->rk[0] + lea_delta[1][1], 1);
+		key->rk[12] = rol32(key->rk[6] + lea_delta[2][2], 1);
+		key->rk[18] = rol32(key->rk[12] + lea_delta[3][3], 1);
+		key->rk[24] = rol32(key->rk[18] + lea_delta[0][4], 1);
+		key->rk[30] = rol32(key->rk[24] + lea_delta[1][5], 1);
+		key->rk[36] = rol32(key->rk[30] + lea_delta[2][6], 1);
+		key->rk[42] = rol32(key->rk[36] + lea_delta[3][7], 1);
+		key->rk[48] = rol32(key->rk[42] + lea_delta[0][8], 1);
+		key->rk[54] = rol32(key->rk[48] + lea_delta[1][9], 1);
+		key->rk[60] = rol32(key->rk[54] + lea_delta[2][10], 1);
+		key->rk[66] = rol32(key->rk[60] + lea_delta[3][11], 1);
+		key->rk[72] = rol32(key->rk[66] + lea_delta[0][12], 1);
+		key->rk[78] = rol32(key->rk[72] + lea_delta[1][13], 1);
+		key->rk[84] = rol32(key->rk[78] + lea_delta[2][14], 1);
+		key->rk[90] = rol32(key->rk[84] + lea_delta[3][15], 1);
+		key->rk[96] = rol32(key->rk[90] + lea_delta[0][16], 1);
+		key->rk[102] = rol32(key->rk[96] + lea_delta[1][17], 1);
+		key->rk[108] = rol32(key->rk[102] + lea_delta[2][18], 1);
+		key->rk[114] = rol32(key->rk[108] + lea_delta[3][19], 1);
+		key->rk[120] = rol32(key->rk[114] + lea_delta[0][20], 1);
+		key->rk[126] = rol32(key->rk[120] + lea_delta[1][21], 1);
+		key->rk[132] = rol32(key->rk[126] + lea_delta[2][22], 1);
+		key->rk[138] = rol32(key->rk[132] + lea_delta[3][23], 1);
+
+		key->rk[1] = key->rk[3] = key->rk[5] =
+				rol32(get_unaligned_le32(&_mk[1]) + lea_delta[0][1], 3);
+		key->rk[7] = key->rk[9] = key->rk[11] =
+				rol32(key->rk[1] + lea_delta[1][2], 3);
+		key->rk[13] = key->rk[15] = key->rk[17] =
+				rol32(key->rk[7] + lea_delta[2][3], 3);
+		key->rk[19] = key->rk[21] = key->rk[23] =
+				rol32(key->rk[13] + lea_delta[3][4], 3);
+		key->rk[25] = key->rk[27] = key->rk[29] =
+				rol32(key->rk[19] + lea_delta[0][5], 3);
+		key->rk[31] = key->rk[33] = key->rk[35] =
+				rol32(key->rk[25] + lea_delta[1][6], 3);
+		key->rk[37] = key->rk[39] = key->rk[41] =
+				rol32(key->rk[31] + lea_delta[2][7], 3);
+		key->rk[43] = key->rk[45] = key->rk[47] =
+				rol32(key->rk[37] + lea_delta[3][8], 3);
+		key->rk[49] = key->rk[51] = key->rk[53] =
+				rol32(key->rk[43] + lea_delta[0][9], 3);
+		key->rk[55] = key->rk[57] = key->rk[59] =
+				rol32(key->rk[49] + lea_delta[1][10], 3);
+		key->rk[61] = key->rk[63] = key->rk[65] =
+				rol32(key->rk[55] + lea_delta[2][11], 3);
+		key->rk[67] = key->rk[69] = key->rk[71] =
+				rol32(key->rk[61] + lea_delta[3][12], 3);
+		key->rk[73] = key->rk[75] = key->rk[77] =
+				rol32(key->rk[67] + lea_delta[0][13], 3);
+		key->rk[79] = key->rk[81] = key->rk[83] =
+				rol32(key->rk[73] + lea_delta[1][14], 3);
+		key->rk[85] = key->rk[87] = key->rk[89] =
+				rol32(key->rk[79] + lea_delta[2][15], 3);
+		key->rk[91] = key->rk[93] = key->rk[95] =
+				rol32(key->rk[85] + lea_delta[3][16], 3);
+		key->rk[97] = key->rk[99] = key->rk[101] =
+				rol32(key->rk[91] + lea_delta[0][17], 3);
+		key->rk[103] = key->rk[105] = key->rk[107] =
+				rol32(key->rk[97] + lea_delta[1][18], 3);
+		key->rk[109] = key->rk[111] = key->rk[113] =
+				rol32(key->rk[103] + lea_delta[2][19], 3);
+		key->rk[115] = key->rk[117] = key->rk[119] =
+				rol32(key->rk[109] + lea_delta[3][20], 3);
+		key->rk[121] = key->rk[123] = key->rk[125] =
+				rol32(key->rk[115] + lea_delta[0][21], 3);
+		key->rk[127] = key->rk[129] = key->rk[131] =
+				rol32(key->rk[121] + lea_delta[1][22], 3);
+		key->rk[133] = key->rk[135] = key->rk[137] =
+				rol32(key->rk[127] + lea_delta[2][23], 3);
+		key->rk[139] = key->rk[141] = key->rk[143] =
+				rol32(key->rk[133] + lea_delta[3][24], 3);
+
+		key->rk[2] = rol32(get_unaligned_le32(&_mk[2]) + lea_delta[0][2], 6);
+		key->rk[8] = rol32(key->rk[2] + lea_delta[1][3], 6);
+		key->rk[14] = rol32(key->rk[8] + lea_delta[2][4], 6);
+		key->rk[20] = rol32(key->rk[14] + lea_delta[3][5], 6);
+		key->rk[26] = rol32(key->rk[20] + lea_delta[0][6], 6);
+		key->rk[32] = rol32(key->rk[26] + lea_delta[1][7], 6);
+		key->rk[38] = rol32(key->rk[32] + lea_delta[2][8], 6);
+		key->rk[44] = rol32(key->rk[38] + lea_delta[3][9], 6);
+		key->rk[50] = rol32(key->rk[44] + lea_delta[0][10], 6);
+		key->rk[56] = rol32(key->rk[50] + lea_delta[1][11], 6);
+		key->rk[62] = rol32(key->rk[56] + lea_delta[2][12], 6);
+		key->rk[68] = rol32(key->rk[62] + lea_delta[3][13], 6);
+		key->rk[74] = rol32(key->rk[68] + lea_delta[0][14], 6);
+		key->rk[80] = rol32(key->rk[74] + lea_delta[1][15], 6);
+		key->rk[86] = rol32(key->rk[80] + lea_delta[2][16], 6);
+		key->rk[92] = rol32(key->rk[86] + lea_delta[3][17], 6);
+		key->rk[98] = rol32(key->rk[92] + lea_delta[0][18], 6);
+		key->rk[104] = rol32(key->rk[98] + lea_delta[1][19], 6);
+		key->rk[110] = rol32(key->rk[104] + lea_delta[2][20], 6);
+		key->rk[116] = rol32(key->rk[110] + lea_delta[3][21], 6);
+		key->rk[122] = rol32(key->rk[116] + lea_delta[0][22], 6);
+		key->rk[128] = rol32(key->rk[122] + lea_delta[1][23], 6);
+		key->rk[134] = rol32(key->rk[128] + lea_delta[2][24], 6);
+		key->rk[140] = rol32(key->rk[134] + lea_delta[3][25], 6);
+
+		key->rk[4] = rol32(get_unaligned_le32(&_mk[3]) + lea_delta[0][3], 11);
+		key->rk[10] = rol32(key->rk[4] + lea_delta[1][4], 11);
+		key->rk[16] = rol32(key->rk[10] + lea_delta[2][5], 11);
+		key->rk[22] = rol32(key->rk[16] + lea_delta[3][6], 11);
+		key->rk[28] = rol32(key->rk[22] + lea_delta[0][7], 11);
+		key->rk[34] = rol32(key->rk[28] + lea_delta[1][8], 11);
+		key->rk[40] = rol32(key->rk[34] + lea_delta[2][9], 11);
+		key->rk[46] = rol32(key->rk[40] + lea_delta[3][10], 11);
+		key->rk[52] = rol32(key->rk[46] + lea_delta[0][11], 11);
+		key->rk[58] = rol32(key->rk[52] + lea_delta[1][12], 11);
+		key->rk[64] = rol32(key->rk[58] + lea_delta[2][13], 11);
+		key->rk[70] = rol32(key->rk[64] + lea_delta[3][14], 11);
+		key->rk[76] = rol32(key->rk[70] + lea_delta[0][15], 11);
+		key->rk[82] = rol32(key->rk[76] + lea_delta[1][16], 11);
+		key->rk[88] = rol32(key->rk[82] + lea_delta[2][17], 11);
+		key->rk[94] = rol32(key->rk[88] + lea_delta[3][18], 11);
+		key->rk[100] = rol32(key->rk[94] + lea_delta[0][19], 11);
+		key->rk[106] = rol32(key->rk[100] + lea_delta[1][20], 11);
+		key->rk[112] = rol32(key->rk[106] + lea_delta[2][21], 11);
+		key->rk[118] = rol32(key->rk[112] + lea_delta[3][22], 11);
+		key->rk[124] = rol32(key->rk[118] + lea_delta[0][23], 11);
+		key->rk[130] = rol32(key->rk[124] + lea_delta[1][24], 11);
+		key->rk[136] = rol32(key->rk[130] + lea_delta[2][25], 11);
+		key->rk[142] = rol32(key->rk[136] + lea_delta[3][26], 11);
+		break;
+
+	case 24:
+		key->rk[0] = rol32(get_unaligned_le32(&_mk[0]) + lea_delta[0][0], 1);
+		key->rk[6] = rol32(key->rk[0] + lea_delta[1][1], 1);
+		key->rk[12] = rol32(key->rk[6] + lea_delta[2][2], 1);
+		key->rk[18] = rol32(key->rk[12] + lea_delta[3][3], 1);
+		key->rk[24] = rol32(key->rk[18] + lea_delta[4][4], 1);
+		key->rk[30] = rol32(key->rk[24] + lea_delta[5][5], 1);
+		key->rk[36] = rol32(key->rk[30] + lea_delta[0][6], 1);
+		key->rk[42] = rol32(key->rk[36] + lea_delta[1][7], 1);
+		key->rk[48] = rol32(key->rk[42] + lea_delta[2][8], 1);
+		key->rk[54] = rol32(key->rk[48] + lea_delta[3][9], 1);
+		key->rk[60] = rol32(key->rk[54] + lea_delta[4][10], 1);
+		key->rk[66] = rol32(key->rk[60] + lea_delta[5][11], 1);
+		key->rk[72] = rol32(key->rk[66] + lea_delta[0][12], 1);
+		key->rk[78] = rol32(key->rk[72] + lea_delta[1][13], 1);
+		key->rk[84] = rol32(key->rk[78] + lea_delta[2][14], 1);
+		key->rk[90] = rol32(key->rk[84] + lea_delta[3][15], 1);
+		key->rk[96] = rol32(key->rk[90] + lea_delta[4][16], 1);
+		key->rk[102] = rol32(key->rk[96] + lea_delta[5][17], 1);
+		key->rk[108] = rol32(key->rk[102] + lea_delta[0][18], 1);
+		key->rk[114] = rol32(key->rk[108] + lea_delta[1][19], 1);
+		key->rk[120] = rol32(key->rk[114] + lea_delta[2][20], 1);
+		key->rk[126] = rol32(key->rk[120] + lea_delta[3][21], 1);
+		key->rk[132] = rol32(key->rk[126] + lea_delta[4][22], 1);
+		key->rk[138] = rol32(key->rk[132] + lea_delta[5][23], 1);
+		key->rk[144] = rol32(key->rk[138] + lea_delta[0][24], 1);
+		key->rk[150] = rol32(key->rk[144] + lea_delta[1][25], 1);
+		key->rk[156] = rol32(key->rk[150] + lea_delta[2][26], 1);
+		key->rk[162] = rol32(key->rk[156] + lea_delta[3][27], 1);
+
+		key->rk[1] = rol32(get_unaligned_le32(&_mk[1]) + lea_delta[0][1], 3);
+		key->rk[7] = rol32(key->rk[1] + lea_delta[1][2], 3);
+		key->rk[13] = rol32(key->rk[7] + lea_delta[2][3], 3);
+		key->rk[19] = rol32(key->rk[13] + lea_delta[3][4], 3);
+		key->rk[25] = rol32(key->rk[19] + lea_delta[4][5], 3);
+		key->rk[31] = rol32(key->rk[25] + lea_delta[5][6], 3);
+		key->rk[37] = rol32(key->rk[31] + lea_delta[0][7], 3);
+		key->rk[43] = rol32(key->rk[37] + lea_delta[1][8], 3);
+		key->rk[49] = rol32(key->rk[43] + lea_delta[2][9], 3);
+		key->rk[55] = rol32(key->rk[49] + lea_delta[3][10], 3);
+		key->rk[61] = rol32(key->rk[55] + lea_delta[4][11], 3);
+		key->rk[67] = rol32(key->rk[61] + lea_delta[5][12], 3);
+		key->rk[73] = rol32(key->rk[67] + lea_delta[0][13], 3);
+		key->rk[79] = rol32(key->rk[73] + lea_delta[1][14], 3);
+		key->rk[85] = rol32(key->rk[79] + lea_delta[2][15], 3);
+		key->rk[91] = rol32(key->rk[85] + lea_delta[3][16], 3);
+		key->rk[97] = rol32(key->rk[91] + lea_delta[4][17], 3);
+		key->rk[103] = rol32(key->rk[97] + lea_delta[5][18], 3);
+		key->rk[109] = rol32(key->rk[103] + lea_delta[0][19], 3);
+		key->rk[115] = rol32(key->rk[109] + lea_delta[1][20], 3);
+		key->rk[121] = rol32(key->rk[115] + lea_delta[2][21], 3);
+		key->rk[127] = rol32(key->rk[121] + lea_delta[3][22], 3);
+		key->rk[133] = rol32(key->rk[127] + lea_delta[4][23], 3);
+		key->rk[139] = rol32(key->rk[133] + lea_delta[5][24], 3);
+		key->rk[145] = rol32(key->rk[139] + lea_delta[0][25], 3);
+		key->rk[151] = rol32(key->rk[145] + lea_delta[1][26], 3);
+		key->rk[157] = rol32(key->rk[151] + lea_delta[2][27], 3);
+		key->rk[163] = rol32(key->rk[157] + lea_delta[3][28], 3);
+
+		key->rk[2] = rol32(get_unaligned_le32(&_mk[2]) + lea_delta[0][2], 6);
+		key->rk[8] = rol32(key->rk[2] + lea_delta[1][3], 6);
+		key->rk[14] = rol32(key->rk[8] + lea_delta[2][4], 6);
+		key->rk[20] = rol32(key->rk[14] + lea_delta[3][5], 6);
+		key->rk[26] = rol32(key->rk[20] + lea_delta[4][6], 6);
+		key->rk[32] = rol32(key->rk[26] + lea_delta[5][7], 6);
+		key->rk[38] = rol32(key->rk[32] + lea_delta[0][8], 6);
+		key->rk[44] = rol32(key->rk[38] + lea_delta[1][9], 6);
+		key->rk[50] = rol32(key->rk[44] + lea_delta[2][10], 6);
+		key->rk[56] = rol32(key->rk[50] + lea_delta[3][11], 6);
+		key->rk[62] = rol32(key->rk[56] + lea_delta[4][12], 6);
+		key->rk[68] = rol32(key->rk[62] + lea_delta[5][13], 6);
+		key->rk[74] = rol32(key->rk[68] + lea_delta[0][14], 6);
+		key->rk[80] = rol32(key->rk[74] + lea_delta[1][15], 6);
+		key->rk[86] = rol32(key->rk[80] + lea_delta[2][16], 6);
+		key->rk[92] = rol32(key->rk[86] + lea_delta[3][17], 6);
+		key->rk[98] = rol32(key->rk[92] + lea_delta[4][18], 6);
+		key->rk[104] = rol32(key->rk[98] + lea_delta[5][19], 6);
+		key->rk[110] = rol32(key->rk[104] + lea_delta[0][20], 6);
+		key->rk[116] = rol32(key->rk[110] + lea_delta[1][21], 6);
+		key->rk[122] = rol32(key->rk[116] + lea_delta[2][22], 6);
+		key->rk[128] = rol32(key->rk[122] + lea_delta[3][23], 6);
+		key->rk[134] = rol32(key->rk[128] + lea_delta[4][24], 6);
+		key->rk[140] = rol32(key->rk[134] + lea_delta[5][25], 6);
+		key->rk[146] = rol32(key->rk[140] + lea_delta[0][26], 6);
+		key->rk[152] = rol32(key->rk[146] + lea_delta[1][27], 6);
+		key->rk[158] = rol32(key->rk[152] + lea_delta[2][28], 6);
+		key->rk[164] = rol32(key->rk[158] + lea_delta[3][29], 6);
+
+		key->rk[3] = rol32(get_unaligned_le32(&_mk[3]) + lea_delta[0][3], 11);
+		key->rk[9] = rol32(key->rk[3] + lea_delta[1][4], 11);
+		key->rk[15] = rol32(key->rk[9] + lea_delta[2][5], 11);
+		key->rk[21] = rol32(key->rk[15] + lea_delta[3][6], 11);
+		key->rk[27] = rol32(key->rk[21] + lea_delta[4][7], 11);
+		key->rk[33] = rol32(key->rk[27] + lea_delta[5][8], 11);
+		key->rk[39] = rol32(key->rk[33] + lea_delta[0][9], 11);
+		key->rk[45] = rol32(key->rk[39] + lea_delta[1][10], 11);
+		key->rk[51] = rol32(key->rk[45] + lea_delta[2][11], 11);
+		key->rk[57] = rol32(key->rk[51] + lea_delta[3][12], 11);
+		key->rk[63] = rol32(key->rk[57] + lea_delta[4][13], 11);
+		key->rk[69] = rol32(key->rk[63] + lea_delta[5][14], 11);
+		key->rk[75] = rol32(key->rk[69] + lea_delta[0][15], 11);
+		key->rk[81] = rol32(key->rk[75] + lea_delta[1][16], 11);
+		key->rk[87] = rol32(key->rk[81] + lea_delta[2][17], 11);
+		key->rk[93] = rol32(key->rk[87] + lea_delta[3][18], 11);
+		key->rk[99] = rol32(key->rk[93] + lea_delta[4][19], 11);
+		key->rk[105] = rol32(key->rk[99] + lea_delta[5][20], 11);
+		key->rk[111] = rol32(key->rk[105] + lea_delta[0][21], 11);
+		key->rk[117] = rol32(key->rk[111] + lea_delta[1][22], 11);
+		key->rk[123] = rol32(key->rk[117] + lea_delta[2][23], 11);
+		key->rk[129] = rol32(key->rk[123] + lea_delta[3][24], 11);
+		key->rk[135] = rol32(key->rk[129] + lea_delta[4][25], 11);
+		key->rk[141] = rol32(key->rk[135] + lea_delta[5][26], 11);
+		key->rk[147] = rol32(key->rk[141] + lea_delta[0][27], 11);
+		key->rk[153] = rol32(key->rk[147] + lea_delta[1][28], 11);
+		key->rk[159] = rol32(key->rk[153] + lea_delta[2][29], 11);
+		key->rk[165] = rol32(key->rk[159] + lea_delta[3][30], 11);
+
+		key->rk[4] = rol32(get_unaligned_le32(&_mk[4]) + lea_delta[0][4], 13);
+		key->rk[10] = rol32(key->rk[4] + lea_delta[1][5], 13);
+		key->rk[16] = rol32(key->rk[10] + lea_delta[2][6], 13);
+		key->rk[22] = rol32(key->rk[16] + lea_delta[3][7], 13);
+		key->rk[28] = rol32(key->rk[22] + lea_delta[4][8], 13);
+		key->rk[34] = rol32(key->rk[28] + lea_delta[5][9], 13);
+		key->rk[40] = rol32(key->rk[34] + lea_delta[0][10], 13);
+		key->rk[46] = rol32(key->rk[40] + lea_delta[1][11], 13);
+		key->rk[52] = rol32(key->rk[46] + lea_delta[2][12], 13);
+		key->rk[58] = rol32(key->rk[52] + lea_delta[3][13], 13);
+		key->rk[64] = rol32(key->rk[58] + lea_delta[4][14], 13);
+		key->rk[70] = rol32(key->rk[64] + lea_delta[5][15], 13);
+		key->rk[76] = rol32(key->rk[70] + lea_delta[0][16], 13);
+		key->rk[82] = rol32(key->rk[76] + lea_delta[1][17], 13);
+		key->rk[88] = rol32(key->rk[82] + lea_delta[2][18], 13);
+		key->rk[94] = rol32(key->rk[88] + lea_delta[3][19], 13);
+		key->rk[100] = rol32(key->rk[94] + lea_delta[4][20], 13);
+		key->rk[106] = rol32(key->rk[100] + lea_delta[5][21], 13);
+		key->rk[112] = rol32(key->rk[106] + lea_delta[0][22], 13);
+		key->rk[118] = rol32(key->rk[112] + lea_delta[1][23], 13);
+		key->rk[124] = rol32(key->rk[118] + lea_delta[2][24], 13);
+		key->rk[130] = rol32(key->rk[124] + lea_delta[3][25], 13);
+		key->rk[136] = rol32(key->rk[130] + lea_delta[4][26], 13);
+		key->rk[142] = rol32(key->rk[136] + lea_delta[5][27], 13);
+		key->rk[148] = rol32(key->rk[142] + lea_delta[0][28], 13);
+		key->rk[154] = rol32(key->rk[148] + lea_delta[1][29], 13);
+		key->rk[160] = rol32(key->rk[154] + lea_delta[2][30], 13);
+		key->rk[166] = rol32(key->rk[160] + lea_delta[3][31], 13);
+
+		key->rk[5] = rol32(get_unaligned_le32(&_mk[5]) + lea_delta[0][5], 17);
+		key->rk[11] = rol32(key->rk[5] + lea_delta[1][6], 17);
+		key->rk[17] = rol32(key->rk[11] + lea_delta[2][7], 17);
+		key->rk[23] = rol32(key->rk[17] + lea_delta[3][8], 17);
+		key->rk[29] = rol32(key->rk[23] + lea_delta[4][9], 17);
+		key->rk[35] = rol32(key->rk[29] + lea_delta[5][10], 17);
+		key->rk[41] = rol32(key->rk[35] + lea_delta[0][11], 17);
+		key->rk[47] = rol32(key->rk[41] + lea_delta[1][12], 17);
+		key->rk[53] = rol32(key->rk[47] + lea_delta[2][13], 17);
+		key->rk[59] = rol32(key->rk[53] + lea_delta[3][14], 17);
+		key->rk[65] = rol32(key->rk[59] + lea_delta[4][15], 17);
+		key->rk[71] = rol32(key->rk[65] + lea_delta[5][16], 17);
+		key->rk[77] = rol32(key->rk[71] + lea_delta[0][17], 17);
+		key->rk[83] = rol32(key->rk[77] + lea_delta[1][18], 17);
+		key->rk[89] = rol32(key->rk[83] + lea_delta[2][19], 17);
+		key->rk[95] = rol32(key->rk[89] + lea_delta[3][20], 17);
+		key->rk[101] = rol32(key->rk[95] + lea_delta[4][21], 17);
+		key->rk[107] = rol32(key->rk[101] + lea_delta[5][22], 17);
+		key->rk[113] = rol32(key->rk[107] + lea_delta[0][23], 17);
+		key->rk[119] = rol32(key->rk[113] + lea_delta[1][24], 17);
+		key->rk[125] = rol32(key->rk[119] + lea_delta[2][25], 17);
+		key->rk[131] = rol32(key->rk[125] + lea_delta[3][26], 17);
+		key->rk[137] = rol32(key->rk[131] + lea_delta[4][27], 17);
+		key->rk[143] = rol32(key->rk[137] + lea_delta[5][28], 17);
+		key->rk[149] = rol32(key->rk[143] + lea_delta[0][29], 17);
+		key->rk[155] = rol32(key->rk[149] + lea_delta[1][30], 17);
+		key->rk[161] = rol32(key->rk[155] + lea_delta[2][31], 17);
+		key->rk[167] = rol32(key->rk[161] + lea_delta[3][0], 17);
+		break;
+
+	case 32:
+		key->rk[0] = rol32(get_unaligned_le32(&_mk[0]) + lea_delta[0][0], 1);
+		key->rk[8] = rol32(key->rk[0] + lea_delta[1][3], 6);
+		key->rk[16] = rol32(key->rk[8] + lea_delta[2][6], 13);
+		key->rk[24] = rol32(key->rk[16] + lea_delta[4][4], 1);
+		key->rk[32] = rol32(key->rk[24] + lea_delta[5][7], 6);
+		key->rk[40] = rol32(key->rk[32] + lea_delta[6][10], 13);
+		key->rk[48] = rol32(key->rk[40] + lea_delta[0][8], 1);
+		key->rk[56] = rol32(key->rk[48] + lea_delta[1][11], 6);
+		key->rk[64] = rol32(key->rk[56] + lea_delta[2][14], 13);
+		key->rk[72] = rol32(key->rk[64] + lea_delta[4][12], 1);
+		key->rk[80] = rol32(key->rk[72] + lea_delta[5][15], 6);
+		key->rk[88] = rol32(key->rk[80] + lea_delta[6][18], 13);
+		key->rk[96] = rol32(key->rk[88] + lea_delta[0][16], 1);
+		key->rk[104] = rol32(key->rk[96] + lea_delta[1][19], 6);
+		key->rk[112] = rol32(key->rk[104] + lea_delta[2][22], 13);
+		key->rk[120] = rol32(key->rk[112] + lea_delta[4][20], 1);
+		key->rk[128] = rol32(key->rk[120] + lea_delta[5][23], 6);
+		key->rk[136] = rol32(key->rk[128] + lea_delta[6][26], 13);
+		key->rk[144] = rol32(key->rk[136] + lea_delta[0][24], 1);
+		key->rk[152] = rol32(key->rk[144] + lea_delta[1][27], 6);
+		key->rk[160] = rol32(key->rk[152] + lea_delta[2][30], 13);
+		key->rk[168] = rol32(key->rk[160] + lea_delta[4][28], 1);
+		key->rk[176] = rol32(key->rk[168] + lea_delta[5][31], 6);
+		key->rk[184] = rol32(key->rk[176] + lea_delta[6][2], 13);
+
+		key->rk[1] = rol32(get_unaligned_le32(&_mk[1]) + lea_delta[0][1], 3);
+		key->rk[9] = rol32(key->rk[1] + lea_delta[1][4], 11);
+		key->rk[17] = rol32(key->rk[9] + lea_delta[2][7], 17);
+		key->rk[25] = rol32(key->rk[17] + lea_delta[4][5], 3);
+		key->rk[33] = rol32(key->rk[25] + lea_delta[5][8], 11);
+		key->rk[41] = rol32(key->rk[33] + lea_delta[6][11], 17);
+		key->rk[49] = rol32(key->rk[41] + lea_delta[0][9], 3);
+		key->rk[57] = rol32(key->rk[49] + lea_delta[1][12], 11);
+		key->rk[65] = rol32(key->rk[57] + lea_delta[2][15], 17);
+		key->rk[73] = rol32(key->rk[65] + lea_delta[4][13], 3);
+		key->rk[81] = rol32(key->rk[73] + lea_delta[5][16], 11);
+		key->rk[89] = rol32(key->rk[81] + lea_delta[6][19], 17);
+		key->rk[97] = rol32(key->rk[89] + lea_delta[0][17], 3);
+		key->rk[105] = rol32(key->rk[97] + lea_delta[1][20], 11);
+		key->rk[113] = rol32(key->rk[105] + lea_delta[2][23], 17);
+		key->rk[121] = rol32(key->rk[113] + lea_delta[4][21], 3);
+		key->rk[129] = rol32(key->rk[121] + lea_delta[5][24], 11);
+		key->rk[137] = rol32(key->rk[129] + lea_delta[6][27], 17);
+		key->rk[145] = rol32(key->rk[137] + lea_delta[0][25], 3);
+		key->rk[153] = rol32(key->rk[145] + lea_delta[1][28], 11);
+		key->rk[161] = rol32(key->rk[153] + lea_delta[2][31], 17);
+		key->rk[169] = rol32(key->rk[161] + lea_delta[4][29], 3);
+		key->rk[177] = rol32(key->rk[169] + lea_delta[5][0], 11);
+		key->rk[185] = rol32(key->rk[177] + lea_delta[6][3], 17);
+
+		key->rk[2] = rol32(get_unaligned_le32(&_mk[2]) + lea_delta[0][2], 6);
+		key->rk[10] = rol32(key->rk[2] + lea_delta[1][5], 13);
+		key->rk[18] = rol32(key->rk[10] + lea_delta[3][3], 1);
+		key->rk[26] = rol32(key->rk[18] + lea_delta[4][6], 6);
+		key->rk[34] = rol32(key->rk[26] + lea_delta[5][9], 13);
+		key->rk[42] = rol32(key->rk[34] + lea_delta[7][7], 1);
+		key->rk[50] = rol32(key->rk[42] + lea_delta[0][10], 6);
+		key->rk[58] = rol32(key->rk[50] + lea_delta[1][13], 13);
+		key->rk[66] = rol32(key->rk[58] + lea_delta[3][11], 1);
+		key->rk[74] = rol32(key->rk[66] + lea_delta[4][14], 6);
+		key->rk[82] = rol32(key->rk[74] + lea_delta[5][17], 13);
+		key->rk[90] = rol32(key->rk[82] + lea_delta[7][15], 1);
+		key->rk[98] = rol32(key->rk[90] + lea_delta[0][18], 6);
+		key->rk[106] = rol32(key->rk[98] + lea_delta[1][21], 13);
+		key->rk[114] = rol32(key->rk[106] + lea_delta[3][19], 1);
+		key->rk[122] = rol32(key->rk[114] + lea_delta[4][22], 6);
+		key->rk[130] = rol32(key->rk[122] + lea_delta[5][25], 13);
+		key->rk[138] = rol32(key->rk[130] + lea_delta[7][23], 1);
+		key->rk[146] = rol32(key->rk[138] + lea_delta[0][26], 6);
+		key->rk[154] = rol32(key->rk[146] + lea_delta[1][29], 13);
+		key->rk[162] = rol32(key->rk[154] + lea_delta[3][27], 1);
+		key->rk[170] = rol32(key->rk[162] + lea_delta[4][30], 6);
+		key->rk[178] = rol32(key->rk[170] + lea_delta[5][1], 13);
+		key->rk[186] = rol32(key->rk[178] + lea_delta[7][31], 1);
+
+		key->rk[3] = rol32(get_unaligned_le32(&_mk[3]) + lea_delta[0][3], 11);
+		key->rk[11] = rol32(key->rk[3] + lea_delta[1][6], 17);
+		key->rk[19] = rol32(key->rk[11] + lea_delta[3][4], 3);
+		key->rk[27] = rol32(key->rk[19] + lea_delta[4][7], 11);
+		key->rk[35] = rol32(key->rk[27] + lea_delta[5][10], 17);
+		key->rk[43] = rol32(key->rk[35] + lea_delta[7][8], 3);
+		key->rk[51] = rol32(key->rk[43] + lea_delta[0][11], 11);
+		key->rk[59] = rol32(key->rk[51] + lea_delta[1][14], 17);
+		key->rk[67] = rol32(key->rk[59] + lea_delta[3][12], 3);
+		key->rk[75] = rol32(key->rk[67] + lea_delta[4][15], 11);
+		key->rk[83] = rol32(key->rk[75] + lea_delta[5][18], 17);
+		key->rk[91] = rol32(key->rk[83] + lea_delta[7][16], 3);
+		key->rk[99] = rol32(key->rk[91] + lea_delta[0][19], 11);
+		key->rk[107] = rol32(key->rk[99] + lea_delta[1][22], 17);
+		key->rk[115] = rol32(key->rk[107] + lea_delta[3][20], 3);
+		key->rk[123] = rol32(key->rk[115] + lea_delta[4][23], 11);
+		key->rk[131] = rol32(key->rk[123] + lea_delta[5][26], 17);
+		key->rk[139] = rol32(key->rk[131] + lea_delta[7][24], 3);
+		key->rk[147] = rol32(key->rk[139] + lea_delta[0][27], 11);
+		key->rk[155] = rol32(key->rk[147] + lea_delta[1][30], 17);
+		key->rk[163] = rol32(key->rk[155] + lea_delta[3][28], 3);
+		key->rk[171] = rol32(key->rk[163] + lea_delta[4][31], 11);
+		key->rk[179] = rol32(key->rk[171] + lea_delta[5][2], 17);
+		key->rk[187] = rol32(key->rk[179] + lea_delta[7][0], 3);
+
+		key->rk[4] = rol32(get_unaligned_le32(&_mk[4]) + lea_delta[0][4], 13);
+		key->rk[12] = rol32(key->rk[4] + lea_delta[2][2], 1);
+		key->rk[20] = rol32(key->rk[12] + lea_delta[3][5], 6);
+		key->rk[28] = rol32(key->rk[20] + lea_delta[4][8], 13);
+		key->rk[36] = rol32(key->rk[28] + lea_delta[6][6], 1);
+		key->rk[44] = rol32(key->rk[36] + lea_delta[7][9], 6);
+		key->rk[52] = rol32(key->rk[44] + lea_delta[0][12], 13);
+		key->rk[60] = rol32(key->rk[52] + lea_delta[2][10], 1);
+		key->rk[68] = rol32(key->rk[60] + lea_delta[3][13], 6);
+		key->rk[76] = rol32(key->rk[68] + lea_delta[4][16], 13);
+		key->rk[84] = rol32(key->rk[76] + lea_delta[6][14], 1);
+		key->rk[92] = rol32(key->rk[84] + lea_delta[7][17], 6);
+		key->rk[100] = rol32(key->rk[92] + lea_delta[0][20], 13);
+		key->rk[108] = rol32(key->rk[100] + lea_delta[2][18], 1);
+		key->rk[116] = rol32(key->rk[108] + lea_delta[3][21], 6);
+		key->rk[124] = rol32(key->rk[116] + lea_delta[4][24], 13);
+		key->rk[132] = rol32(key->rk[124] + lea_delta[6][22], 1);
+		key->rk[140] = rol32(key->rk[132] + lea_delta[7][25], 6);
+		key->rk[148] = rol32(key->rk[140] + lea_delta[0][28], 13);
+		key->rk[156] = rol32(key->rk[148] + lea_delta[2][26], 1);
+		key->rk[164] = rol32(key->rk[156] + lea_delta[3][29], 6);
+		key->rk[172] = rol32(key->rk[164] + lea_delta[4][0], 13);
+		key->rk[180] = rol32(key->rk[172] + lea_delta[6][30], 1);
+		key->rk[188] = rol32(key->rk[180] + lea_delta[7][1], 6);
+
+		key->rk[5] = rol32(get_unaligned_le32(&_mk[5]) + lea_delta[0][5], 17);
+		key->rk[13] = rol32(key->rk[5] + lea_delta[2][3], 3);
+		key->rk[21] = rol32(key->rk[13] + lea_delta[3][6], 11);
+		key->rk[29] = rol32(key->rk[21] + lea_delta[4][9], 17);
+		key->rk[37] = rol32(key->rk[29] + lea_delta[6][7], 3);
+		key->rk[45] = rol32(key->rk[37] + lea_delta[7][10], 11);
+		key->rk[53] = rol32(key->rk[45] + lea_delta[0][13], 17);
+		key->rk[61] = rol32(key->rk[53] + lea_delta[2][11], 3);
+		key->rk[69] = rol32(key->rk[61] + lea_delta[3][14], 11);
+		key->rk[77] = rol32(key->rk[69] + lea_delta[4][17], 17);
+		key->rk[85] = rol32(key->rk[77] + lea_delta[6][15], 3);
+		key->rk[93] = rol32(key->rk[85] + lea_delta[7][18], 11);
+		key->rk[101] = rol32(key->rk[93] + lea_delta[0][21], 17);
+		key->rk[109] = rol32(key->rk[101] + lea_delta[2][19], 3);
+		key->rk[117] = rol32(key->rk[109] + lea_delta[3][22], 11);
+		key->rk[125] = rol32(key->rk[117] + lea_delta[4][25], 17);
+		key->rk[133] = rol32(key->rk[125] + lea_delta[6][23], 3);
+		key->rk[141] = rol32(key->rk[133] + lea_delta[7][26], 11);
+		key->rk[149] = rol32(key->rk[141] + lea_delta[0][29], 17);
+		key->rk[157] = rol32(key->rk[149] + lea_delta[2][27], 3);
+		key->rk[165] = rol32(key->rk[157] + lea_delta[3][30], 11);
+		key->rk[173] = rol32(key->rk[165] + lea_delta[4][1], 17);
+		key->rk[181] = rol32(key->rk[173] + lea_delta[6][31], 3);
+		key->rk[189] = rol32(key->rk[181] + lea_delta[7][2], 11);
+
+		key->rk[6] = rol32(get_unaligned_le32(&_mk[6]) + lea_delta[1][1], 1);
+		key->rk[14] = rol32(key->rk[6] + lea_delta[2][4], 6);
+		key->rk[22] = rol32(key->rk[14] + lea_delta[3][7], 13);
+		key->rk[30] = rol32(key->rk[22] + lea_delta[5][5], 1);
+		key->rk[38] = rol32(key->rk[30] + lea_delta[6][8], 6);
+		key->rk[46] = rol32(key->rk[38] + lea_delta[7][11], 13);
+		key->rk[54] = rol32(key->rk[46] + lea_delta[1][9], 1);
+		key->rk[62] = rol32(key->rk[54] + lea_delta[2][12], 6);
+		key->rk[70] = rol32(key->rk[62] + lea_delta[3][15], 13);
+		key->rk[78] = rol32(key->rk[70] + lea_delta[5][13], 1);
+		key->rk[86] = rol32(key->rk[78] + lea_delta[6][16], 6);
+		key->rk[94] = rol32(key->rk[86] + lea_delta[7][19], 13);
+		key->rk[102] = rol32(key->rk[94] + lea_delta[1][17], 1);
+		key->rk[110] = rol32(key->rk[102] + lea_delta[2][20], 6);
+		key->rk[118] = rol32(key->rk[110] + lea_delta[3][23], 13);
+		key->rk[126] = rol32(key->rk[118] + lea_delta[5][21], 1);
+		key->rk[134] = rol32(key->rk[126] + lea_delta[6][24], 6);
+		key->rk[142] = rol32(key->rk[134] + lea_delta[7][27], 13);
+		key->rk[150] = rol32(key->rk[142] + lea_delta[1][25], 1);
+		key->rk[158] = rol32(key->rk[150] + lea_delta[2][28], 6);
+		key->rk[166] = rol32(key->rk[158] + lea_delta[3][31], 13);
+		key->rk[174] = rol32(key->rk[166] + lea_delta[5][29], 1);
+		key->rk[182] = rol32(key->rk[174] + lea_delta[6][0], 6);
+		key->rk[190] = rol32(key->rk[182] + lea_delta[7][3], 13);
+
+		key->rk[7] = rol32(get_unaligned_le32(&_mk[7]) + lea_delta[1][2], 3);
+		key->rk[15] = rol32(key->rk[7] + lea_delta[2][5], 11);
+		key->rk[23] = rol32(key->rk[15] + lea_delta[3][8], 17);
+		key->rk[31] = rol32(key->rk[23] + lea_delta[5][6], 3);
+		key->rk[39] = rol32(key->rk[31] + lea_delta[6][9], 11);
+		key->rk[47] = rol32(key->rk[39] + lea_delta[7][12], 17);
+		key->rk[55] = rol32(key->rk[47] + lea_delta[1][10], 3);
+		key->rk[63] = rol32(key->rk[55] + lea_delta[2][13], 11);
+		key->rk[71] = rol32(key->rk[63] + lea_delta[3][16], 17);
+		key->rk[79] = rol32(key->rk[71] + lea_delta[5][14], 3);
+		key->rk[87] = rol32(key->rk[79] + lea_delta[6][17], 11);
+		key->rk[95] = rol32(key->rk[87] + lea_delta[7][20], 17);
+		key->rk[103] = rol32(key->rk[95] + lea_delta[1][18], 3);
+		key->rk[111] = rol32(key->rk[103] + lea_delta[2][21], 11);
+		key->rk[119] = rol32(key->rk[111] + lea_delta[3][24], 17);
+		key->rk[127] = rol32(key->rk[119] + lea_delta[5][22], 3);
+		key->rk[135] = rol32(key->rk[127] + lea_delta[6][25], 11);
+		key->rk[143] = rol32(key->rk[135] + lea_delta[7][28], 17);
+		key->rk[151] = rol32(key->rk[143] + lea_delta[1][26], 3);
+		key->rk[159] = rol32(key->rk[151] + lea_delta[2][29], 11);
+		key->rk[167] = rol32(key->rk[159] + lea_delta[3][0], 17);
+		key->rk[175] = rol32(key->rk[167] + lea_delta[5][30], 3);
+		key->rk[183] = rol32(key->rk[175] + lea_delta[6][1], 11);
+		key->rk[191] = rol32(key->rk[183] + lea_delta[7][4], 17);
+
+		break;
+
+	default:
+		return 1;
+	}
+
+	key->round = LEA_ROUND_CNT(key_len);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lea_set_key);
+
+static int crypto_lea_set_key(struct crypto_tfm *tfm, const u8 *in_key,
+											u32 key_len)
+{
+	return lea_set_key(crypto_tfm_ctx(tfm), in_key, key_len);
+}
+
+static void crypto_lea_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
+{
+	const struct crypto_lea_ctx *key = crypto_tfm_ctx(tfm);
+
+	lea_encrypt(key, out, in);
+}
+
+static void crypto_lea_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
+{
+	const struct crypto_lea_ctx *key = crypto_tfm_ctx(tfm);
+
+	lea_decrypt(key, out, in);
+}
+
+static struct crypto_alg lea_alg = {
+	.cra_name        = "lea",
+	.cra_driver_name = "lea-generic",
+	.cra_priority    = 100,
+	.cra_flags       = CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize   = LEA_BLOCK_SIZE,
+	.cra_ctxsize     = sizeof(struct crypto_lea_ctx),
+	.cra_module      = THIS_MODULE,
+	.cra_u           = {
+		.cipher = {
+			.cia_min_keysize = LEA_MIN_KEY_SIZE,
+			.cia_max_keysize = LEA_MAX_KEY_SIZE,
+			.cia_setkey = crypto_lea_set_key,
+			.cia_encrypt = crypto_lea_encrypt,
+			.cia_decrypt = crypto_lea_decrypt
+		}
+	}
+};
+
+static int crypto_lea_init(void)
+{
+	return crypto_register_alg(&lea_alg);
+}
+
+static void crypto_lea_exit(void)
+{
+	crypto_unregister_alg(&lea_alg);
+}
+
+module_init(crypto_lea_init);
+module_exit(crypto_lea_exit);
+
+MODULE_DESCRIPTION("LEA Cipher Algorithm");
+MODULE_AUTHOR("Dongsoo Lee <letrhee@nsr.re.kr>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("lea");
+MODULE_ALIAS_CRYPTO("lea-generic");
diff --git a/include/crypto/lea.h b/include/crypto/lea.h
new file mode 100644
index 000000000000..1668c7ed5a6e
--- /dev/null
+++ b/include/crypto/lea.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Cryptographic API.
+ *
+ * LEA Cipher Algorithm
+ *
+ * LEA is a 128-bit block cipher developed by South Korea in 2013.
+ *
+ * LEA is the national standard of Republic of Korea (KS X 3246) and included in
+ * the ISO/IEC 29192-2:2019 standard (Information security - Lightweight
+ * cryptography - Part 2: Block ciphers).
+ *
+ * Copyright (c) 2023 National Security Research.
+ * Author: Dongsoo Lee <letrhee@nsr.re.kr>
+ */
+
+#ifndef _CRYPTO_LEA_H
+#define _CRYPTO_LEA_H
+
+#include <linux/types.h>
+
+#define LEA_MIN_KEY_SIZE 16
+#define LEA_MAX_KEY_SIZE 32
+#define LEA_BLOCK_SIZE 16
+#define LEA_ROUND_CNT(key_len) ((key_len >> 1) + 16)
+
+#define LEA_MAX_KEYLENGTH_U32 (LEA_ROUND_CNT(LEA_MAX_KEY_SIZE) * 6)
+#define LEA_MAX_KEYLENGTH (LEA_MAX_KEYLENGTH_U32 * sizeof(u32))
+
+struct crypto_lea_ctx {
+	u32 rk[LEA_MAX_KEYLENGTH_U32];
+	u32 round;
+};
+
+int lea_set_key(struct crypto_lea_ctx *ctx, const u8 *in_key, u32 key_len);
+void lea_encrypt(const void *ctx, u8 *out, const u8 *in);
+void lea_decrypt(const void *ctx, u8 *out, const u8 *in);
+
+#endif
-- 
2.34.1
