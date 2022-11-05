Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8357A61DD83
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiKETAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 15:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiKES7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 14:59:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CBF5FF6;
        Sat,  5 Nov 2022 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667674768; bh=8Hp1zx/5xqPjJdBvcxGOdwOBXS460B5xQd0dp8zyAXc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=R/FiV9Fg+SF9iBOFI1rcYT+poYx0llGUbBL2CU9PGJJ2IS4XLlGfI176v2lmd3Fl3
         fXgqT1BXgP+HHQBUPrzdlcVYhQhLf4aRohbQ5ZVv36qlLCs5jQbYLEYt/u+PJpfhIM
         544S4L3ZiOBLw11J7uwGE8Q5Mw9KtQvdR7u43qUDlnHccwfnMD31/Jk8i9AzclXFrg
         XrpGjKaNAwXA40Fq7yfqmBQDfFrG5kUlCys84tGJXU/5OBySSF5DAmnk2OEvDAyqsV
         jc5xQWFvH1uADn3QVB+VaLj6Ad69lExtdTYmikNBafsFVVbwxWTvmtegUvywymT5BY
         /EXF28mSUX3iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([87.78.44.193]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp5Q-1oWWYm1aay-00YChF; Sat, 05
 Nov 2022 19:59:28 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 8/8] spi: wpcm-fiu: Add direct map support
Date:   Sat,  5 Nov 2022 19:59:11 +0100
Message-Id: <20221105185911.1547847-9-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
References: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9V2ZEZNXbUL5fJgOg60HwNFPLB73gmrjIGRAPTVp/sNNac9zK1d
 5UDoJcPw0nIsuE7FZ8KCLcHIfz58KPYWQvdhIo8CIU/EzQuxHAHm+XT2KOdPqzrHG1NszEP
 m1ME/7xu25bTayYm4BJIW2aSreCn6fKWoCcFtacYiyGy+EEVfWp+0eTv4LcQu/mEKyDffyp
 2r6iyMuxikbYLE3S4jMYA==
UI-OutboundReport: notjunk:1;M01:P0:u4ojvdMZIts=;SlqvjLzK+y0Xc6K4ER98wtDp10q
 uHKtssdXHpWlIjADhYxl7EznuhbAE0IeW47bH3v502JnVxiGOYKlF1k8nWGKHJIT9rSqPgoyv
 YQNR3TGd5isFq3YCnnaqIdnBUQb/mQbqZS0nsdFcMkMMfBxwVrbNoXskbqN5605fPchKeUwX7
 HxzzHcw//qyIdaCiTm4bB7osiSTF6rHA79YkHOX3L8r2htuL3RKDqxdyBMd2i7Xdrc4S/IZOH
 w8YWuc31nPkTQO4c2MLbrV00sfHXngzpBl7Bx/rZRQ4q5DJe4ZCogq56OL6TX7VtEiPJr5lmB
 qDLTaChbf8sMbaazK85199TXdUXuU1f7iobeBBWx/vsU14P9GTiLwmQ60Os2DybFD1kPa7jSy
 DyRGwOa4Jsc/coJzO5iqag6B6AQDp3PYb04GUDGHabGe34/MRXXAAM7Wse+x6kZf6BOss2chf
 ykHyVMxO4LJBYoAIBn2ooprsIHvjp+bkNc7MITPoOwk4DJ8lXOPPdNy44W5lblyAnzVYQv95h
 4wzkhtvF1TToO6ij03q1T0UaKGvFCKSuadlZr8sSHizQzkm7k5Y5vqggMe27i4WHpJUYPldSb
 aMtySlOpQ2zjJBCKeUlIp/o7T8uzhfNA709QT4CLGAz0Xf8gp47RJWYPzEDYkQnWusvLTt4k7
 nHMyaq2sl8ki3tTV1k+3Cxczu/3GdvDp/Btogtfv2CpL2J04y22EIJV3MTuGOhggW+sJcPm68
 oVDTyBrhogKfmLzGBFsIdg82v9BP/mxACzcmGRAYWgYVuCKo8Eg+jfuy6pBZpqSGALUWZngKi
 kYHquwOhZBRzc9o6miGRwOGAuPlpyq7cAMZP99hqUYzdAKFUj5jsKscPtPGfCXTRAJ6r6dOU2
 YN22BSncJRv9qmxSqYSgfhG6HEm0CpNhwBOwZViAT09ZTftJlgVuuzYBJREQ5i9Ap/5yeQrGY
 BCP2Mv7zoYoR+qrlQQhx2c59Y2Q=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides software controlled SPI transfers (UMA, "user mode access"), FIU
also supports a 16 MiB mapping window per attached flash chip.

This patch implements direct mapped read access, to speed up flash reads.


Without direct mapping:

	# time dd if=3D/dev/mtd0ro of=3Ddump bs=3D1M
	16+0 records in
	16+0 records out
	real    1m 47.74s
	user    0m 0.00s
	sys     1m 47.75s


With direct mapping:

	# time dd if=3D/dev/mtd0ro of=3Ddump bs=3D1M
	16+0 records in
	16+0 records out
	real    0m 30.81s
	user    0m 0.00s
	sys     0m 30.81s

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/spi/spi-wpcm-fiu.c | 64 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
index d68693d4cd8bd..eda46c766ad9d 100644
=2D-- a/drivers/spi/spi-wpcm-fiu.c
+++ b/drivers/spi/spi-wpcm-fiu.c
@@ -51,10 +51,16 @@
  */
 #define UMA_WAIT_ITERATIONS 100

+/* The memory-mapped view of flash is 16 MiB long */
+#define MAX_MEMORY_SIZE_PER_CS	(16 << 20)
+#define MAX_MEMORY_SIZE_TOTAL	(4 * MAX_MEMORY_SIZE_PER_CS)
+
 struct wpcm_fiu_spi {
 	struct device *dev;
 	struct clk *clk;
 	void __iomem *regs;
+	void __iomem *memory;
+	size_t memory_size;
 	struct regmap *shm_regmap;
 };

@@ -367,14 +373,64 @@ static int wpcm_fiu_adjust_op_size(struct spi_mem *m=
em, struct spi_mem_op *op)
 	return 0;
 }

+static int wpcm_fiu_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct wpcm_fiu_spi *fiu =3D spi_controller_get_devdata(desc->mem->spi->=
controller);
+	int cs =3D desc->mem->spi->chip_select;
+
+	if (desc->info.op_tmpl.data.dir !=3D SPI_MEM_DATA_IN)
+		return -ENOTSUPP;
+
+	/*
+	 * Unfortunately, FIU only supports a 16 MiB direct mapping window (per
+	 * attached flash chip), but the SPI MEM core doesn't support partial
+	 * direct mappings. This means that we can't support direct mapping on
+	 * flashes that are bigger than 16 MiB.
+	 */
+	if (desc->info.offset + desc->info.length > MAX_MEMORY_SIZE_PER_CS)
+		return -ENOTSUPP;
+
+	/* Don't read past the memory window */
+	if (cs * MAX_MEMORY_SIZE_PER_CS + desc->info.offset + desc->info.length =
> fiu->memory_size)
+		return -ENOTSUPP;
+
+	return 0;
+}
+
+static int wpcm_fiu_direct_read(struct spi_mem_dirmap_desc *desc, u64 off=
s, size_t len, void *buf)
+{
+	struct wpcm_fiu_spi *fiu =3D spi_controller_get_devdata(desc->mem->spi->=
controller);
+	int cs =3D desc->mem->spi->chip_select;
+
+	if (offs >=3D MAX_MEMORY_SIZE_PER_CS)
+		return -ENOTSUPP;
+
+	offs +=3D cs * MAX_MEMORY_SIZE_PER_CS;
+
+	if (!fiu->memory || offs >=3D fiu->memory_size)
+		return -ENOTSUPP;
+
+	len =3D min_t(size_t, len, fiu->memory_size - offs);
+	memcpy_fromio(buf, fiu->memory + offs, len);
+
+	return len;
+}
+
 static const struct spi_controller_mem_ops wpcm_fiu_mem_ops =3D {
 	.adjust_op_size =3D wpcm_fiu_adjust_op_size,
 	.supports_op =3D wpcm_fiu_supports_op,
 	.exec_op =3D wpcm_fiu_exec_op,
+	.dirmap_create =3D wpcm_fiu_dirmap_create,
+	.dirmap_read =3D wpcm_fiu_direct_read,
 };

 static void wpcm_fiu_hw_init(struct wpcm_fiu_spi *fiu)
 {
+	/* Configure memory-mapped flash access */
+	writeb(FIU_BURST_CFG_R16, fiu->regs + FIU_BURST_BFG);
+	writeb(MAX_MEMORY_SIZE_TOTAL / (512 << 10), fiu->regs + FIU_CFG);
+	writeb(MAX_MEMORY_SIZE_PER_CS / (512 << 10) | BIT(6), fiu->regs + FIU_SP=
I_FL_CFG);
+
 	/* Deassert all manually asserted chip selects */
 	writeb(0x0f, fiu->regs + FIU_UMA_ECTS);
 }
@@ -404,6 +460,14 @@ static int wpcm_fiu_probe(struct platform_device *pde=
v)
 	if (IS_ERR(fiu->clk))
 		return PTR_ERR(fiu->clk);

+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "memory");
+	fiu->memory =3D devm_ioremap_resource(dev, res);
+	fiu->memory_size =3D min_t(size_t, resource_size(res), MAX_MEMORY_SIZE_T=
OTAL);
+	if (IS_ERR(fiu->regs)) {
+		dev_err(dev, "Failed to map flash memory window\n");
+		return PTR_ERR(fiu->memory);
+	}
+
 	fiu->shm_regmap =3D syscon_regmap_lookup_by_phandle_optional(dev->of_nod=
e, "nuvoton,shm");

 	wpcm_fiu_hw_init(fiu);
=2D-
2.35.1

