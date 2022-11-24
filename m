Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D885637F73
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiKXTO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiKXTOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:14:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD08287574;
        Thu, 24 Nov 2022 11:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669317250; bh=3d5wRu8H4rV67y0AcOBjPXJoU2peJtLzij7b7I+rk+E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AHL1Snn1Vm7i2/aVQdLF4IOE8e6Emt2n8GJq4hhGCRo7W84WAj0lzNSs19P9nPz0d
         MtPAobnGdOcJL5PLVM5VvciM4xnJUhzMTk3nNc2QYA0XZTdNtOwJOA0k5JByXZcJ/D
         6Naz04BTGYa/mwo4Aplg1GkvvWxKm73YkObQJO9JFTN1H9fOgRaJBA2V5TCuSmsFo2
         iqW6AjOJx1fa0BCD0enYWaGDyZPN0muE4wPZmAoVmIWQDvleP25saEVVBS6xawDAon
         h8+NPdxMDBLHD0Qc6v2xn9/cYnxNt0eAhEFbGVrMbvwE213A+GsH5H9IWi2iuWbDP6
         qGj6JFWRVh4dg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1p19wy493t-015WKW; Thu, 24
 Nov 2022 20:14:10 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/3] spi: wpcm-fiu: Add direct map support
Date:   Thu, 24 Nov 2022 20:14:00 +0100
Message-Id: <20221124191400.287918-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221124191400.287918-1-j.neuschaefer@gmx.net>
References: <20221124191400.287918-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t39AaDJmFgdivvbDoFkLkv/flCQ4QNQrXQ2seNnr38jxbz8uLGN
 JD5xXUQIO3bnfEZqbhcRCCIQ7El0WW/RjX68OSU1BTf4yRQmWiuiBh5cynZYZNGPp+ZXuAq
 jUobt8Pk/6DCZUVg+Qkzytu+B72pAH86tu5NN0Fm4aEiA5OkEdYTgfIGH4gjNswKxHjN8hy
 x7AT8dVbmva2t2HUQDN8w==
UI-OutboundReport: notjunk:1;M01:P0:DSc4kqUiQ7M=;FiW4VAxGlixqn7OX9WfgMCy5tx+
 2oAG/ANhk0sOGSzuKDGhfJlQKLYfHl0xMBP6zguUlv4VAx775fS9BDJ2DBFw+1HmYWZPxcsDI
 udtzt1BzbYNodInMXUL3zq593vuqK2mJULpIyinQ0W4crSXJSIm/LGNKOLLrpDTg2UJoNYCRV
 CEGs4jYQ1Gf/sUyTDskQpQRLPOG+ShwPQabTi2go+jRBbit0ZmTvS1/erKJgrmUlR4MxAK2go
 h5MOt9mbOUQERi9ujqm5yYzQk5V1z18h56HGvMDGR0WSOObAkZxxqk3ZV8qZu/03TxmABRVHE
 44wML3KRU0luG0PWJSZq9pHR2qWeN8cXxnKnb8YxBQdptXUzZ9fByV0GW/VwM/Fw010NeXW3e
 LUKFSWkvytsWUWX1jKjTB21DlF01pr+OgRAHUyfAx/d+k4Eq1aN3jYvXxHKHMN/U7FRbO90m7
 It9e+b+E/0C3GVqhpMshViU2E32CYWPPUxlVoKq41UaEEbWPTipSz/etR/A/JrKAQ5Zdyd6Vz
 IoxMNkZuxz1COLQw1lR59BEPjL1Jm09tWeLC8po6K/QFzxasx0cm+VCaRhdcCwkjZfWJhSRH4
 qKq5BFSTL1rpQ9yYapDK4kxpadGD1tQhzzF5mvmvIJuxaILpFTd8SQzrLEKwQ0SB9FASxPlfQ
 D+NPkF5syRHmnETUYlncYBjTjnB/aXh80CewmfWS8g1hF6qZLqswaqd3zy9HDXl5yZY8xIq3t
 1xAm9vn3otlFzCWFzCSCiaj5XztwqOCUzdZRMEPfxB86/lM1rZ/uDjs46+TMofkrELGaFNq6r
 Dh2viJeBV5ovODz/8ionBN6tyCyO9irM/HvT9MAQxGNJAzUdJNlmUpZylnyQduRlsKloTZU+u
 LyGr20/QujC6HZGZJZiz0nDODqazXh6M+/anxi1KSDZMwph4SffihQrSnV9MpJ7Q2dcBuvjua
 AbJ0vO8ivqIpH0kXMbcPZ2jyKiI=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
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

v2:
- Fix a few nits from the kernel test robot
- Fix check for fiu->memory mapping error

v1:
- https://lore.kernel.org/lkml/20221105185911.1547847-9-j.neuschaefer@gmx.=
net/
=2D--
 drivers/spi/spi-wpcm-fiu.c | 64 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
index e525fe074f883..ab33710d50ac8 100644
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
+static ssize_t wpcm_fiu_direct_read(struct spi_mem_dirmap_desc *desc, u64=
 offs, size_t len, void *buf)
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
+	if (IS_ERR(fiu->memory)) {
+		dev_err(dev, "Failed to map flash memory window\n");
+		return PTR_ERR(fiu->memory);
+	}
+
 	fiu->shm_regmap =3D syscon_regmap_lookup_by_phandle_optional(dev->of_nod=
e, "nuvoton,shm");

 	wpcm_fiu_hw_init(fiu);
=2D-
2.35.1

