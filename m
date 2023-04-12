Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8AE6E00BF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjDLVWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDLVWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:22:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020EE19A1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681334514; i=j.neuschaefer@gmx.net;
        bh=w4sCM12T3GwE9Idp4Z+5KQM9o6BWvMigt3zMC505xKw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EIthzBk7V9dTwGCevl2ID2eaBvJ99830DWe/E4B+7cEm17DwtfvhtH6sal9eMXI4P
         pbTzg+2Ukbp+YMO9gNMkrbrpkUx40LvdQ/C1rJsDUMPothsoLVLrJEE/4YCZRqw5Nw
         vc0jF19Y1J/resZculEGxxkm3tynBsAQGbqW85MVQtQie0FXETsYLUgLUhR6LpiOEI
         CPaTksxxq5e8MyO8jb1wb/81I1wj8ChMRpPH7o16uScDohkBuP17RaioouhQWNnR2B
         hG1Y76JCgA0fdU+pvE711NPZZahOJgV5S6OGywqviolcfVoA+j7sSTHBbJ60QPdb8E
         YSYTUnGOmeyYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([185.66.193.41]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QsO-1qTERQ26K6-011Ohg; Wed, 12
 Apr 2023 23:21:54 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Nick Terrell <terrelln@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Li <xin3.li@intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 1/3] ARM: compressed: Pass the actual output length to the decompressor
Date:   Wed, 12 Apr 2023 23:21:24 +0200
Message-Id: <20230412212126.3966502-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:asTkI05mit0v6ML4tVuKmImFEuUsK0Fu2edpCC39+pLZg2GbPEp
 uz6X4ZfRT20DLhLPUl8stqEq3qsocNzWidlj25tSp8ODUYV8E61NLSs9J2c01K8hlt2sdnU
 4eLQbQQmZxMqVRPCi2Ngsw55OhjDQbP4MkfpuGDNQgKVJ4vIs98dvmU1022PSQkJ8VjBKJl
 cm/3GJ/kQSIr4KYl47XQQ==
UI-OutboundReport: notjunk:1;M01:P0:wYI1qy9oxMg=;ZVVUPgqmOo4gpzWIhJbrqdHAqdl
 N/GLP6C6/VhJGvwN/crPZrSQBl8auweY4IQwlsQeyi5qyOCoWzQrSaDquJfz55LP19Gppap3t
 wQObz41pOU4bLa6Y8cM9EBOrXquszDEKVaVgRj9GKRnftxUuIZh8ZQtpVd5bwHPZrTMC+KwmC
 wLmUVxzfg29ft2ErEWZACAYnztBqaYr5OkLudtrTyBRfc/ZqhBJkeucHwKA8GehJmrrmIikNq
 IJG2bv5jvss8+W8HYYjUlEAG/g1nSKi9lsQhGXXgECDzgwAU9Hv4KCbEIWG71L252b2BG64nf
 h0y9IxXFHTLJYRN6AFpDxP9DqPtaMAdmF0i5LnsUw21I/arDhvspGVpVpLr7XHSUc7KMqO3BK
 4EbzfaFLHvm09ep3TfdNS1tV2WSj3VZ06UNkBI7EwOHzrWw86tBf0ebxyRI1BPXnfT7aYU+8Z
 Ce3wO+HJcOrMhhIpkz9eZdKOw8i3mDgTMe1cYVtlGyIA6vZ9W2Vo8178qismrg/v25MAejjxt
 oD+IEAeHOrGMp1/LhCad1/wybR/BG5fsHh5yhgNoSQeu5iuxoWYwXcGpoC5TZSMRYRsxLpdNT
 y96LkkEmGQ5H9DaX6Rp/f5ODudF614GI9aJH/vWYFcfVpnhdiY+Jo6BAY3Syeu2aSJo8kmv5f
 2Ab6Z1bWpZYl33Ons8+F7v3B2ZT+4l8HxyDTnC2NhiYJVpDYqQCSlvy9V44cCkUfsfZUBlHIS
 TXeR/p5qQbkv2OwasfFVrbbswyhpDtgXH6camhneX7UAKkHx6A0o6gJtcLmhOBGxnH1i3dBvv
 MEGuUBs8b7AOfR/iMogtMFY5I47xjUIMoJCib7Y2S/hTtwAal7syElPOb58tuoVns9Hu3+QJx
 UuEVsGJUYFA2G3SXzk3WaHq057WuDBTvfAdFoxQZjG9XttxcWVKDLwH60H9VLbJEPYU53H02i
 ijJvIQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZSTD writes outside of the space that is necessary for the uncompressed
data, when it is told it has unlimited output length. To fix this, pass
the actual output length (the length of the uncompressed kernel) to the
decompressor.

The uncompressed length is already stored as a little endian 32-bit
constant before the input_data_end symbol.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/boot/compressed/decompress.c |  4 ++--
 arch/arm/boot/compressed/misc.c       | 12 ++++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compres=
sed/decompress.c
index 74255e8198314..3d098b84ee391 100644
=2D-- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -59,7 +59,7 @@ extern char * strchrnul(const char *, int);
 #include "../../../../lib/decompress_unlz4.c"
 #endif

-int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x))
+int do_decompress(u8 *input, int len, u8 *output, int outlen, void (*erro=
r)(char *x))
 {
-	return __decompress(input, len, NULL, NULL, output, 0, NULL, error);
+	return __decompress(input, len, NULL, NULL, output, outlen, NULL, error)=
;
 }
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/mi=
sc.c
index abfed1aa2baa8..8402b29bccc82 100644
=2D-- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -22,6 +22,7 @@ unsigned int __machine_arch_type;
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>
 #include <linux/linkage.h>
+#include <asm/unaligned.h>
 #include "misc.h"
 #ifdef CONFIG_ARCH_EP93XX
 #include "misc-ep93xx.h"
@@ -131,17 +132,24 @@ asmlinkage void __div0(void)
 	error("Attempting division by 0!");
 }

-extern int do_decompress(u8 *input, int len, u8 *output, void (*error)(ch=
ar *x));
+extern int do_decompress(u8 *input, int len, u8 *output, int outlen,
+			 void (*error)(char *x));

+static u32 get_inflated_image_size(void)
+{
+	return get_unaligned_le32(input_data_end - 4);
+}

 void
 decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_=
p,
 		unsigned long free_mem_ptr_end_p,
 		int arch_id)
 {
+	unsigned long output_data_len;
 	int ret;

 	output_data		=3D (unsigned char *)output_start;
+	output_data_len		=3D get_inflated_image_size();
 	free_mem_ptr		=3D free_mem_ptr_p;
 	free_mem_end_ptr	=3D free_mem_ptr_end_p;
 	__machine_arch_type	=3D arch_id;
@@ -153,7 +161,7 @@ decompress_kernel(unsigned long output_start, unsigned=
 long free_mem_ptr_p,

 	putstr("Uncompressing Linux...");
 	ret =3D do_decompress(input_data, input_data_end - input_data,
-			    output_data, error);
+			    output_data, output_data_len, error);
 	if (ret)
 		error("decompressor returned an error");
 	else
=2D-
2.39.2

