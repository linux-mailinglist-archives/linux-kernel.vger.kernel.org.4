Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262C56E00BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjDLVWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDLVWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:22:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025921FFB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681334525; i=j.neuschaefer@gmx.net;
        bh=O8EbCtqxtHYhZl3Wus9zpBDqTyNgSWv3QZ/g5KBbeZI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OEA1FhescqUfkOmuDqtkrGYkKZCy/DMEnk/LaDmgvBNs6cqpozk4B5wSbdVg4eX+0
         jA55Hn+8mgTDiLiJxRBXYzrhFkxTydPaae1mBbv9EbLrqTZdeeWYTRdDeA2ysIHdWe
         T2au7ZXelcTcVcaqof0jmgi2RFJ3ed08v4XSOUmqSy2YPWT6FEYzFJDBE66qLlX55A
         G8gUPrynRofubUWeiO5vh20659JGdvj+8KHG/VPf2VS6bJ027Hv9i5RSjdo/5QZ4fC
         Jl1N5WtMV8ONYplNfVOxh77gD05BSzzrBsqyp4ZJf/e7cO1qJFFJOGGgoDoehmWX6a
         EffFTMVy6YMBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([185.66.193.41]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63RQ-1qShXR3GeW-016N3I; Wed, 12
 Apr 2023 23:22:05 +0200
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
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 3/3] ARM: compressed: Enable ZSTD compression
Date:   Wed, 12 Apr 2023 23:21:26 +0200
Message-Id: <20230412212126.3966502-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NLKJGLSHU/mKfwCFI6t1irU5z5u/MoO8jr3NJmsYweqgxdI5Qej
 8HKkQD920FU6M/3UgPqB3iyyeKTUracoZXdCvl6zR9JR8iCBQopsrIkYbHNi829tR8F85qN
 gfcXNwiXoc7xB1PZcoSLxNCks6kZ4E9WWqCJxk/io62ncpopqYU+SGyVLaLVgRb6vXLg/q0
 nlxUZapXHoRUQp5KeUkCg==
UI-OutboundReport: notjunk:1;M01:P0:7C88/EJwyYk=;EeZbn8oZQQ/XlBkmsNhLXC3DX7O
 R87+ukUz9LEx9YhSUTia1vUhBfnlR+q/60srJ9GvSFs3KRBjshvC2NEXiM+VR6mKcx5zKDJGv
 p08RzsUUX0moiNRGbI4unwoyVbI+tI93CkBjnl8PAGA7QRRK0y6SJWoDU9Z6+BXglJ/sLlvKY
 EaHPhCyVSyMPTxMDDdfcpd8SSksT5Q91jf2+YQBm/c1XYi/M5Lk4HFxw/bARvBqEYaqe8ZOgy
 Pt309QyAELbHcVzb/45JWFFsKWO5Jr8LkhAMDaULrGq+E+PBZskNxU3h4O3fxbC4xcjHHhAGu
 ihSPkV7N88zZL+B6EeNYQYn3s8ayZU8PV9AuCvIWH0pNJEVa9b7CkH66XbkJJDHmhF1Rb0aYP
 zXzk+Q6pSnSiV4mb7x0IAZcNIw6PtbLnkGQ11w0yJEW4PtthEZmL+opLCg2ddmRmZwQ8GYVch
 K1ED8gy3/+lWlpp31ahWDrq/7jZdlcdDYH0pX+IGtAVBVtY3xEqK91270ofa6CJGr9KylJ4zv
 YYTCFR+6ffFOkvpqnw9rEtN0tk65MjseXOK1Cy9CVFA+CLzm9jW1S1rVvSMvuny/W69DYM2gW
 qp/uM7ccNaBPcdpmdrYGo1EOFi+J8OVw+/qf1dJf14uliHL3T2hWP0MWIEvUl4WseV0Nui1/t
 EZ98duNQ5kZCmiLiWc5MnmLIDvIYB7RDHzV9gJHZRXww/BGdI18S0EkE3774F4BTjifZodfgy
 hGN73q3Tku/qeJsvWustKlGnEch6/OkzV54elWHrrYxj8ugoX9nZP+Iy5pE2A8/aMNr8myvCo
 1Tofwfxw2qg5xMBP24MahPlPk/HgM7JPwsjqNTQyVfCclALIHvIdgmk2TJGxGM6EyZFS6ddXx
 nbe4+8TGXLF4Rax/CoyhO1MswNk+4dp9n2+FcBxMsZ9A/xBlSYdVKYfqy6ITGFrIlc2l2lCJp
 eyu5pQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the previous two commits, it is possible to enable ZSTD
in the decompressor stub for 32-bit ARM.

Unfortunately, ZSTD decompression has been quite slow in my tests
(on ARM926EJ-S, ARMv5T):

 - LZO:  7.2 MiB,  6 seconds
 - ZSTD: 5.6 MiB, 60 seconds

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/Kconfig                      | 1 +
 arch/arm/boot/compressed/Makefile     | 3 ++-
 arch/arm/boot/compressed/decompress.c | 4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e24a9820e12fa..065a1746a257a 100644
=2D-- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -108,6 +108,7 @@ config ARM
 	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
+	select HAVE_KERNEL_ZSTD
 	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
 	select HAVE_KRETPROBES if HAVE_KPROBES
 	select HAVE_MOD_ARCH_SPECIFIC
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/=
Makefile
index dec565a5b1f21..55bfca154b12a 100644
=2D-- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -81,6 +81,7 @@ compress-$(CONFIG_KERNEL_LZO)  =3D lzo_with_size
 compress-$(CONFIG_KERNEL_LZMA) =3D lzma_with_size
 compress-$(CONFIG_KERNEL_XZ)   =3D xzkern_with_size
 compress-$(CONFIG_KERNEL_LZ4)  =3D lz4_with_size
+compress-$(CONFIG_KERNEL_ZSTD) =3D zstd22_with_size

 libfdt_objs :=3D fdt_rw.o fdt_ro.o fdt_wip.o fdt.o

@@ -98,7 +99,7 @@ OBJS	+=3D lib1funcs.o ashldi3.o bswapsdi2.o
 targets       :=3D vmlinux vmlinux.lds piggy_data piggy.o \
 		 head.o $(OBJS)

-KBUILD_CFLAGS +=3D -DDISABLE_BRANCH_PROFILING
+KBUILD_CFLAGS +=3D -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS

 ccflags-y :=3D -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin=
 \
 	     -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compres=
sed/decompress.c
index 3d098b84ee391..2c4fd33444829 100644
=2D-- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -59,6 +59,10 @@ extern char * strchrnul(const char *, int);
 #include "../../../../lib/decompress_unlz4.c"
 #endif

+#ifdef CONFIG_KERNEL_ZSTD
+#include "../../../../lib/decompress_unzstd.c"
+#endif
+
 int do_decompress(u8 *input, int len, u8 *output, int outlen, void (*erro=
r)(char *x))
 {
 	return __decompress(input, len, NULL, NULL, output, outlen, NULL, error)=
;
=2D-
2.39.2

