Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAE161DD82
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiKETAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 15:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiKES7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 14:59:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2855587;
        Sat,  5 Nov 2022 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667674767; bh=NM6v0lFGiR0uEkPynnfwY/N9MRh4qhtWVnH0D2SCNeg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pqQQgU7t5kRDr9kn8GgUH7w/R2Kx6qqCRn8V0XZ1eyaZIwZ2DJB6fcKxbU6Mxu1or
         zxZ5IuFcwdpFrFgGDTTEYTjbMx8yWKb9yWMl9DZkypn3JC24b+mJUZVPUn8lC5AILE
         qV3jxGojV16B+fZN964QLk5mBFBdzq31Whnhqc808K/AzvJpKCBrdOrcZGvqJ9xfFe
         kLvdUzaafGNlIcTC0hJW+46f9UJmgDuIZWMd+yHP3S6EJUu83TaYCdNePuXAn/fwcU
         akJDTo1etoRFSl3CVQeUbporNCVufhJsv6fmn2wasjMY57CK9AUjlTJE6TO7/lWJWq
         jpKDNhjVbH7CA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([87.78.44.193]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNt0C-1ogSBD2h7A-00OEmi; Sat, 05
 Nov 2022 19:59:27 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 7/8] spi: wpcm-fiu: Add driver for Nuvoton WPCM450 Flash Interface Unit (FIU)
Date:   Sat,  5 Nov 2022 19:59:10 +0100
Message-Id: <20221105185911.1547847-8-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
References: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2KODUNLOlhqbVz3eBGVCkVWFgSpdQODBtrQ+lKHWzlgI0FhJsGO
 o8/SMS99+uIjqF/X3qgreoF303PC4DT0NSPXlHYKZwlWUp5h6noxv5wZA8GulNFBuSFyRdv
 gUNyQzeYWmghog+hltJ29QFjViov732g5WQzwobs1+DGqjpGMAqlO2tbBeyu3mo2+u09oR4
 3U3xeCDDaacMhMYdD0hGg==
UI-OutboundReport: notjunk:1;M01:P0:OYaYFq+SuKU=;rW1RETpz4b8K6GoBjHyPuk47tvS
 2XtHZDOpIsBNzXfDd8Q3eNyJV55t0ljrDfZYPpK1snmnsPtuLAwTBeVEwcyPCmoKrO+BUYOa+
 FV3eJ1c2sp4s9c30BGaUALgq1OY9Ta1fh3Pu3Du6FzunLUwVpf0wP4BcqQ+/Hu6T7btBUsuTu
 2Hm36kpJJXw+Ku3XuqIYi06fwXaLh+yt56J32BdS3WbTf9KuexxX9K0A4tAH2TKqPGRW0OeWK
 tNpuu2yx/eW0rlkvn3RpdAu+ZbKTPlh9sJd+pZqDTverCbw33jGs7AHIoD1uVdjD1r9yt7Gyl
 TcYBs2MldYt/JoWLvTIEC7mMStqMAyUkV7vRVFjaVvCiy0nc8bJFsGGem7X3bwDfB3tekOa+E
 jlGDnOM1jltDGhGun8eUoQ9J7eTln6zUyBHvZdRt+nkqhfm0a4pAPQj1UNeS9JuozCVZ3aaBv
 4KiXz/2PxY/ohaxK96gqCq5x3iVFZjqEqKAygAfnAzXFqkjqq0nF/X/Fpe2GAhPKuVCOKxnPY
 g5oBcxZk6o4aKWQlAhAcNHSQhTaJZcM9lEDm8I3HoIPTPtrg+WBVh3PKlzlLCEixGmYEK1wua
 jHsttNPSsM8q3fZxi1SXYuBP6Q1QGx1taLH8W7fbIMvV7BKSAoGYNSQwFesdmK8lUvIwJIt2Y
 SKjPi1ALMDVPkp72Xmz3nb3v4R+/gDrZq/iUESOrN4unxZpCT/RXvpPHjiJWQXNUHWkqqoLT2
 5ebyrNrE+2Y2UicvLTceB18sqvR94Khp9I+sWIv/NBU5mllvM68QvLiThrNhFAoZpqm6SeCN1
 /aOE2qyB1D131OOVDjkpH4V7LPN2D/iwKkCRPpu/y0YjIviwXWbFTh4/pMBr2wfssYa+81geu
 C143KLXvH9TETePIm7fxuF+nf37Bw3lFL0M4Y/QicWbqrgcYHn9kFKQjc7KT5S8Bp92e4qe+4
 WBpWAd/h99bLzz1XOs4B21KlnGw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Flash Interface Unit (FIU) is the SPI flash controller in the
Nuvoton WPCM450 BMC SoC. It supports four chip selects, and direct
(memory-mapped) access to 16 MiB per chip. Larger flash chips can be
accessed by software-defined SPI transfers.

The FIU in newer NPCM7xx SoCs is not compatible with the WPCM450 FIU.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/spi/Kconfig        |  11 +
 drivers/spi/Makefile       |   1 +
 drivers/spi/spi-wpcm-fiu.c | 443 +++++++++++++++++++++++++++++++++++++
 3 files changed, 455 insertions(+)
 create mode 100644 drivers/spi/spi-wpcm-fiu.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d1bb62f7368b7..ee5f9e61cc280 100644
=2D-- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -635,6 +635,17 @@ config SPI_MTK_SNFI
 	  is implemented as a SPI-MEM controller with pipelined ECC
 	  capcability.

+config SPI_WPCM_FIU
+	tristate "Nuvoton WPCM450 Flash Interface Unit"
+	depends on ARCH_NPCM || COMPILE_TEST
+	select REGMAP
+	help
+	  This enables support got the Flash Interface Unit SPI controller
+	  present in the Nuvoton WPCM450 SoC.
+
+	  This driver does not support generic SPI. The implementation only
+	  supports the spi-mem interface.
+
 config SPI_NPCM_FIU
 	tristate "Nuvoton NPCM FLASH Interface Unit"
 	depends on ARCH_NPCM || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 4b34e855c8412..e30196d0a4cf9 100644
=2D-- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_SPI_MTK_NOR)		+=3D spi-mtk-nor.o
 obj-$(CONFIG_SPI_MTK_SNFI)		+=3D spi-mtk-snfi.o
 obj-$(CONFIG_SPI_MXIC)			+=3D spi-mxic.o
 obj-$(CONFIG_SPI_MXS)			+=3D spi-mxs.o
+obj-$(CONFIG_SPI_WPCM_FIU)		+=3D spi-wpcm-fiu.o
 obj-$(CONFIG_SPI_NPCM_FIU)		+=3D spi-npcm-fiu.o
 obj-$(CONFIG_SPI_NPCM_PSPI)		+=3D spi-npcm-pspi.o
 obj-$(CONFIG_SPI_NXP_FLEXSPI)		+=3D spi-nxp-fspi.o
diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
new file mode 100644
index 0000000000000..d68693d4cd8bd
=2D-- /dev/null
+++ b/drivers/spi/spi-wpcm-fiu.c
@@ -0,0 +1,443 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022 Jonathan Neusch=C3=A4fer
+
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi-mem.h>
+
+#define FIU_CFG		0x00
+#define FIU_BURST_BFG	0x01
+#define FIU_RESP_CFG	0x02
+#define FIU_CFBB_PROT	0x03
+#define FIU_FWIN1_LOW	0x04
+#define FIU_FWIN1_HIGH	0x06
+#define FIU_FWIN2_LOW	0x08
+#define FIU_FWIN2_HIGH	0x0a
+#define FIU_FWIN3_LOW	0x0c
+#define FIU_FWIN3_HIGH	0x0e
+#define FIU_PROT_LOCK	0x10
+#define FIU_PROT_CLEAR	0x11
+#define FIU_SPI_FL_CFG	0x14
+#define FIU_UMA_CODE	0x16
+#define FIU_UMA_AB0	0x17
+#define FIU_UMA_AB1	0x18
+#define FIU_UMA_AB2	0x19
+#define FIU_UMA_DB0	0x1a
+#define FIU_UMA_DB1	0x1b
+#define FIU_UMA_DB2	0x1c
+#define FIU_UMA_DB3	0x1d
+#define FIU_UMA_CTS	0x1e
+#define FIU_UMA_ECTS	0x1f
+
+#define FIU_BURST_CFG_R16	3
+
+#define FIU_UMA_CTS_D_SIZE(x)	(x)
+#define FIU_UMA_CTS_A_SIZE	BIT(3)
+#define FIU_UMA_CTS_WR		BIT(4)
+#define FIU_UMA_CTS_CS(x)	((x) << 5)
+#define FIU_UMA_CTS_EXEC_DONE	BIT(7)
+
+#define SHM_FLASH_SIZE	0x02
+#define SHM_FLASH_SIZE_STALL_HOST BIT(6)
+
+/*
+ * I observed a typical wait time of 16 iterations for a UMA transfer to
+ * finish, so this should be a safe limit.
+ */
+#define UMA_WAIT_ITERATIONS 100
+
+struct wpcm_fiu_spi {
+	struct device *dev;
+	struct clk *clk;
+	void __iomem *regs;
+	struct regmap *shm_regmap;
+};
+
+static void wpcm_fiu_set_opcode(struct wpcm_fiu_spi *fiu, u8 opcode)
+{
+	writeb(opcode, fiu->regs + FIU_UMA_CODE);
+}
+
+static void wpcm_fiu_set_addr(struct wpcm_fiu_spi *fiu, u32 addr)
+{
+	writeb((addr >>  0) & 0xff, fiu->regs + FIU_UMA_AB0);
+	writeb((addr >>  8) & 0xff, fiu->regs + FIU_UMA_AB1);
+	writeb((addr >> 16) & 0xff, fiu->regs + FIU_UMA_AB2);
+}
+
+static void wpcm_fiu_set_data(struct wpcm_fiu_spi *fiu, const u8 *data, u=
nsigned int nbytes)
+{
+	int i;
+
+	for (i =3D 0; i < nbytes; i++)
+		writeb(data[i], fiu->regs + FIU_UMA_DB0 + i);
+}
+
+static void wpcm_fiu_get_data(struct wpcm_fiu_spi *fiu, u8 *data, unsigne=
d int nbytes)
+{
+	int i;
+
+	for (i =3D 0; i < nbytes; i++)
+		data[i] =3D readb(fiu->regs + FIU_UMA_DB0 + i);
+}
+
+/*
+ * Perform a UMA (User Mode Access) operation, i.e. a software-controlled=
 SPI transfer.
+ */
+static int wpcm_fiu_do_uma(struct wpcm_fiu_spi *fiu, unsigned int cs,
+			   bool use_addr, bool write, int data_bytes)
+{
+	int i =3D 0;
+	u8 cts =3D FIU_UMA_CTS_EXEC_DONE | FIU_UMA_CTS_CS(cs);
+
+	if (use_addr)
+		cts |=3D FIU_UMA_CTS_A_SIZE;
+	if (write)
+		cts |=3D FIU_UMA_CTS_WR;
+	cts |=3D FIU_UMA_CTS_D_SIZE(data_bytes);
+
+	writeb(cts, fiu->regs + FIU_UMA_CTS);
+
+	for (i =3D 0; i < UMA_WAIT_ITERATIONS; i++)
+		if (!(readb(fiu->regs + FIU_UMA_CTS) & FIU_UMA_CTS_EXEC_DONE))
+			return 0;
+
+	dev_info(fiu->dev, "UMA transfer has not finished in %d iterations\n", U=
MA_WAIT_ITERATIONS);
+	return -EIO;
+}
+
+static void wpcm_fiu_ects_assert(struct wpcm_fiu_spi *fiu, unsigned int c=
s)
+{
+	u8 ects =3D readb(fiu->regs + FIU_UMA_ECTS);
+
+	ects &=3D ~BIT(cs);
+	writeb(ects, fiu->regs + FIU_UMA_ECTS);
+}
+
+static void wpcm_fiu_ects_deassert(struct wpcm_fiu_spi *fiu, unsigned int=
 cs)
+{
+	u8 ects =3D readb(fiu->regs + FIU_UMA_ECTS);
+
+	ects |=3D BIT(cs);
+	writeb(ects, fiu->regs + FIU_UMA_ECTS);
+}
+
+struct wpcm_fiu_op_shape {
+	bool (*match)(const struct spi_mem_op *op);
+	int (*exec)(struct spi_mem *mem, const struct spi_mem_op *op);
+};
+
+static bool wpcm_fiu_normal_match(const struct spi_mem_op *op)
+{
+	// Opcode 0x0b (FAST READ) is treated differently in hardware
+	if (op->cmd.opcode =3D=3D 0x0b)
+		return false;
+
+	return (op->addr.nbytes =3D=3D 0 || op->addr.nbytes =3D=3D 3) &&
+	       op->dummy.nbytes =3D=3D 0 && op->data.nbytes <=3D 4;
+}
+
+static int wpcm_fiu_normal_exec(struct spi_mem *mem, const struct spi_mem=
_op *op)
+{
+	struct wpcm_fiu_spi *fiu =3D spi_controller_get_devdata(mem->spi->contro=
ller);
+	int ret;
+
+	wpcm_fiu_set_opcode(fiu, op->cmd.opcode);
+	wpcm_fiu_set_addr(fiu, op->addr.val);
+	if (op->data.dir =3D=3D SPI_MEM_DATA_OUT)
+		wpcm_fiu_set_data(fiu, op->data.buf.out, op->data.nbytes);
+
+	ret =3D wpcm_fiu_do_uma(fiu, mem->spi->chip_select, op->addr.nbytes =3D=
=3D 3,
+			      op->data.dir =3D=3D SPI_MEM_DATA_OUT, op->data.nbytes);
+
+	if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
+		wpcm_fiu_get_data(fiu, op->data.buf.in, op->data.nbytes);
+
+	return ret;
+}
+
+static bool wpcm_fiu_fast_read_match(const struct spi_mem_op *op)
+{
+	return op->cmd.opcode =3D=3D 0x0b && op->addr.nbytes =3D=3D 3 &&
+	       op->dummy.nbytes =3D=3D 1 &&
+	       op->data.nbytes >=3D 1 && op->data.nbytes <=3D 4 &&
+	       op->data.dir =3D=3D SPI_MEM_DATA_IN;
+}
+
+static int wpcm_fiu_fast_read_exec(struct spi_mem *mem, const struct spi_=
mem_op *op)
+{
+	return -EINVAL;
+}
+
+/*
+ * 4-byte addressing.
+ *
+ * Flash view:  [ C  A  A  A   A     D  D  D  D]
+ * bytes:        13 aa bb cc  dd -> 5a a5 f0 0f
+ * FIU's view:  [ C  A  A  A][ C     D  D  D  D]
+ * FIU mode:    [ read/write][      read       ]
+ */
+static bool wpcm_fiu_4ba_match(const struct spi_mem_op *op)
+{
+	return op->addr.nbytes =3D=3D 4 && op->dummy.nbytes =3D=3D 0 && op->data=
.nbytes <=3D 4;
+}
+
+static int wpcm_fiu_4ba_exec(struct spi_mem *mem, const struct spi_mem_op=
 *op)
+{
+	struct wpcm_fiu_spi *fiu =3D spi_controller_get_devdata(mem->spi->contro=
ller);
+	int cs =3D mem->spi->chip_select;
+
+	wpcm_fiu_ects_assert(fiu, cs);
+
+	wpcm_fiu_set_opcode(fiu, op->cmd.opcode);
+	wpcm_fiu_set_addr(fiu, op->addr.val >> 8);
+	wpcm_fiu_do_uma(fiu, cs, true, false, 0);
+
+	wpcm_fiu_set_opcode(fiu, op->addr.val & 0xff);
+	wpcm_fiu_set_addr(fiu, 0);
+	if (op->data.dir =3D=3D SPI_MEM_DATA_OUT)
+		wpcm_fiu_set_data(fiu, op->data.buf.out, op->data.nbytes);
+	wpcm_fiu_do_uma(fiu, cs, false, op->data.dir =3D=3D SPI_MEM_DATA_OUT, op=
->data.nbytes);
+
+	wpcm_fiu_ects_deassert(fiu, cs);
+
+	if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
+		wpcm_fiu_get_data(fiu, op->data.buf.in, op->data.nbytes);
+
+	return 0;
+}
+
+/*
+ * RDID (Read Identification) needs special handling because Linux expect=
s to
+ * be able to read 6 ID bytes and FIU can only read up to 4 at once.
+ *
+ * We're lucky in this case, because executing the RDID instruction twice=
 will
+ * result in the same result.
+ *
+ * What we do is as follows (C: write command/opcode byte, D: read data b=
yte,
+ * A: write address byte):
+ *
+ *  1. C D D D
+ *  2. C A A A D D D
+ */
+static bool wpcm_fiu_rdid_match(const struct spi_mem_op *op)
+{
+	return op->cmd.opcode =3D=3D 0x9f && op->addr.nbytes =3D=3D 0 &&
+	       op->dummy.nbytes =3D=3D 0 && op->data.nbytes =3D=3D 6 &&
+	       op->data.dir =3D=3D SPI_MEM_DATA_IN;
+}
+
+static int wpcm_fiu_rdid_exec(struct spi_mem *mem, const struct spi_mem_o=
p *op)
+{
+	struct wpcm_fiu_spi *fiu =3D spi_controller_get_devdata(mem->spi->contro=
ller);
+	int cs =3D mem->spi->chip_select;
+
+	/* First transfer */
+	wpcm_fiu_set_opcode(fiu, op->cmd.opcode);
+	wpcm_fiu_set_addr(fiu, 0);
+	wpcm_fiu_do_uma(fiu, cs, false, false, 3);
+	wpcm_fiu_get_data(fiu, op->data.buf.in, 3);
+
+	/* Second transfer */
+	wpcm_fiu_set_opcode(fiu, op->cmd.opcode);
+	wpcm_fiu_set_addr(fiu, 0);
+	wpcm_fiu_do_uma(fiu, cs, true, false, 3);
+	wpcm_fiu_get_data(fiu, op->data.buf.in + 3, 3);
+
+	return 0;
+}
+
+/*
+ * With some dummy bytes.
+ *
+ *  C A A A  X*  X D D D D
+ * [C A A A  D*][C D D D D]
+ */
+static bool wpcm_fiu_dummy_match(const struct spi_mem_op *op)
+{
+	// Opcode 0x0b (FAST READ) is treated differently in hardware
+	if (op->cmd.opcode =3D=3D 0x0b)
+		return false;
+
+	return (op->addr.nbytes =3D=3D 0 || op->addr.nbytes =3D=3D 3) &&
+	       op->dummy.nbytes >=3D 1 && op->dummy.nbytes <=3D 5 &&
+	       op->data.nbytes <=3D 4;
+}
+
+static int wpcm_fiu_dummy_exec(struct spi_mem *mem, const struct spi_mem_=
op *op)
+{
+	struct wpcm_fiu_spi *fiu =3D spi_controller_get_devdata(mem->spi->contro=
ller);
+	int cs =3D mem->spi->chip_select;
+
+	wpcm_fiu_ects_assert(fiu, cs);
+
+	/* First transfer */
+	wpcm_fiu_set_opcode(fiu, op->cmd.opcode);
+	wpcm_fiu_set_addr(fiu, op->addr.val);
+	wpcm_fiu_do_uma(fiu, cs, op->addr.nbytes !=3D 0, true, op->dummy.nbytes =
- 1);
+
+	/* Second transfer */
+	wpcm_fiu_set_opcode(fiu, 0);
+	wpcm_fiu_set_addr(fiu, 0);
+	wpcm_fiu_do_uma(fiu, cs, false, false, op->data.nbytes);
+	wpcm_fiu_get_data(fiu, op->data.buf.in, op->data.nbytes);
+
+	wpcm_fiu_ects_deassert(fiu, cs);
+
+	return 0;
+}
+
+static const struct wpcm_fiu_op_shape wpcm_fiu_op_shapes[] =3D {
+	{ wpcm_fiu_normal_match, wpcm_fiu_normal_exec },
+	{ wpcm_fiu_fast_read_match, wpcm_fiu_fast_read_exec },
+	{ wpcm_fiu_4ba_match, wpcm_fiu_4ba_exec },
+	{ wpcm_fiu_rdid_match, wpcm_fiu_rdid_exec },
+	{ wpcm_fiu_dummy_match, wpcm_fiu_dummy_exec },
+};
+
+static const struct wpcm_fiu_op_shape *wpcm_fiu_find_op_shape(const struc=
t spi_mem_op *op)
+{
+	size_t i;
+
+	for (i =3D 0; i < ARRAY_SIZE(wpcm_fiu_op_shapes); i++) {
+		const struct wpcm_fiu_op_shape *shape =3D &wpcm_fiu_op_shapes[i];
+
+		if (shape->match(op))
+			return shape;
+	}
+
+	return NULL;
+}
+
+static bool wpcm_fiu_supports_op(struct spi_mem *mem, const struct spi_me=
m_op *op)
+{
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+
+	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
+		return false;
+
+	if (op->cmd.buswidth > 1 || op->addr.buswidth > 1 ||
+	    op->dummy.buswidth > 1 || op->data.buswidth > 1)
+		return false;
+
+	return wpcm_fiu_find_op_shape(op) !=3D NULL;
+}
+
+/*
+ * In order to ensure the integrity of SPI transfers performed via UMA,
+ * temporarily disable (stall) memory accesses coming from the host CPU.
+ */
+static void wpcm_fiu_stall_host(struct wpcm_fiu_spi *fiu, bool stall)
+{
+	if (fiu->shm_regmap) {
+		int res =3D regmap_update_bits(fiu->shm_regmap, SHM_FLASH_SIZE,
+					     SHM_FLASH_SIZE_STALL_HOST,
+					     stall ? SHM_FLASH_SIZE_STALL_HOST : 0);
+		if (res)
+			dev_warn(fiu->dev, "Failed to (un)stall host memory accesses: %d\n", r=
es);
+	}
+}
+
+static int wpcm_fiu_exec_op(struct spi_mem *mem, const struct spi_mem_op =
*op)
+{
+	struct wpcm_fiu_spi *fiu =3D spi_controller_get_devdata(mem->spi->contro=
ller);
+	const struct wpcm_fiu_op_shape *shape =3D wpcm_fiu_find_op_shape(op);
+
+	wpcm_fiu_stall_host(fiu, true);
+
+	if (shape)
+		return shape->exec(mem, op);
+
+	wpcm_fiu_stall_host(fiu, false);
+
+	return -ENOTSUPP;
+}
+
+static int wpcm_fiu_adjust_op_size(struct spi_mem *mem, struct spi_mem_op=
 *op)
+{
+	if (op->data.nbytes > 4)
+		op->data.nbytes =3D 4;
+
+	return 0;
+}
+
+static const struct spi_controller_mem_ops wpcm_fiu_mem_ops =3D {
+	.adjust_op_size =3D wpcm_fiu_adjust_op_size,
+	.supports_op =3D wpcm_fiu_supports_op,
+	.exec_op =3D wpcm_fiu_exec_op,
+};
+
+static void wpcm_fiu_hw_init(struct wpcm_fiu_spi *fiu)
+{
+	/* Deassert all manually asserted chip selects */
+	writeb(0x0f, fiu->regs + FIU_UMA_ECTS);
+}
+
+static int wpcm_fiu_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct spi_controller *ctrl;
+	struct wpcm_fiu_spi *fiu;
+	struct resource *res;
+
+	ctrl =3D devm_spi_alloc_master(dev, sizeof(*fiu));
+	if (!ctrl)
+		return -ENOMEM;
+
+	fiu =3D spi_controller_get_devdata(ctrl);
+	fiu->dev =3D dev;
+
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "control");
+	fiu->regs =3D devm_ioremap_resource(dev, res);
+	if (IS_ERR(fiu->regs)) {
+		dev_err(dev, "Failed to map registers\n");
+		return PTR_ERR(fiu->regs);
+	}
+
+	fiu->clk =3D devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(fiu->clk))
+		return PTR_ERR(fiu->clk);
+
+	fiu->shm_regmap =3D syscon_regmap_lookup_by_phandle_optional(dev->of_nod=
e, "nuvoton,shm");
+
+	wpcm_fiu_hw_init(fiu);
+
+	ctrl->bus_num =3D -1;
+	ctrl->mem_ops =3D &wpcm_fiu_mem_ops;
+	ctrl->num_chipselect =3D 4;
+	ctrl->dev.of_node =3D dev->of_node;
+
+	/*
+	 * The FIU doesn't include a clock divider, the clock is entirely
+	 * determined by the AHB3 bus clock.
+	 */
+	ctrl->min_speed_hz =3D ctrl->max_speed_hz =3D clk_get_rate(fiu->clk);
+
+	return devm_spi_register_controller(dev, ctrl);
+}
+
+static const struct of_device_id wpcm_fiu_dt_ids[] =3D {
+	{ .compatible =3D "nuvoton,wpcm450-fiu", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wpcm_fiu_dt_ids);
+
+static struct platform_driver wpcm_fiu_driver =3D {
+	.driver =3D {
+		.name	=3D "wpcm450-fiu",
+		.bus	=3D &platform_bus_type,
+		.of_match_table =3D wpcm_fiu_dt_ids,
+	},
+	.probe      =3D wpcm_fiu_probe,
+};
+module_platform_driver(wpcm_fiu_driver);
+
+MODULE_DESCRIPTION("Nuvoton WPCM450 FIU SPI controller driver");
+MODULE_AUTHOR("Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>");
+MODULE_LICENSE("GPL");
=2D-
2.35.1

