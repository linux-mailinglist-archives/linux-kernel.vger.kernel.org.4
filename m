Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608586EC33D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 02:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDXAKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 20:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDXAKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 20:10:31 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD51A1702
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 17:10:29 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 12E202C04CD;
        Mon, 24 Apr 2023 12:10:25 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1682295025;
        bh=7WQiXrcqQQ7c3nGHXmCe4hTzplkLjyk4E25wr2sE6hY=;
        h=From:To:Cc:Subject:Date:From;
        b=OB1ZtvKOG/NUnhcpMr9AfU1SFxkdj2MTNcfBc6Ue57atD/71lQVihdqtxTRcJicqC
         ou4Sc60gvQWOlSdr3p2zAtuDfLadGLIDTayVlwdvnPPZvHL6Owm0Mpj0CFD9ENJSkM
         7XElIKtCCv+crh1J5R07BtiJ2bbtAzHB0pbd0IRl6uK29zN4dw9aNba2nq4icTCA8Q
         4XYIO+z7f8MsySksumSHRQNVUeqd/romLLXK7nLKE4QSCphHBgEGlgGazKNWi73BBx
         fJmik1N5qncRlhLd8sf8ZI+JH6mz8BCrNad7VbA7IR7iwv8MNtx04HApOlvz0aubwT
         Po7nVUaIYMGjA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6445c8f00000>; Mon, 24 Apr 2023 12:10:24 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id D487913EE32;
        Mon, 24 Apr 2023 12:10:24 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id CD0FE280B5B; Mon, 24 Apr 2023 12:10:24 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     Ibrahim.Tilki@analog.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeynep.Arslanbenzer@analog.com,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] squash! drivers: rtc: add max313xx series rtc driver
Date:   Mon, 24 Apr 2023 12:10:21 +1200
Message-Id: <20230424001021.687057-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=VfuJw2h9 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=dKHAf1wccvYA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=DQkKNav9h5akm56ItaIA:9 a=AjGcO6oz07-iQ99wixmX:22 a=oVHKYsEdi7-vN-J5QA_j:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is intended to be squashed into [1] for the next round. It deals
with reporting that there has been an oscillator fail and releasing the
SWRST on chips that require it.

I'm not sure what the requirements are for patches like this so I've
included my sign-off in case it's needed but feel free to drop it if
it's not needed.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

[1] - https://lore.kernel.org/all/20230403154342.3108-2-Ibrahim.Tilki@ana=
log.com/
---
 drivers/rtc/rtc-max313xx.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/rtc/rtc-max313xx.c b/drivers/rtc/rtc-max313xx.c
index 043528d7d3e0..a7028b901358 100644
--- a/drivers/rtc/rtc-max313xx.c
+++ b/drivers/rtc/rtc-max313xx.c
@@ -81,6 +81,7 @@ struct chip_desc {
=20
 	u8 int_en_reg;
 	u8 int_status_reg;
+	u8 osf_bit;
=20
 	u8 ram_reg;
 	u8 ram_size;
@@ -88,6 +89,9 @@ struct chip_desc {
 	u8 temp_reg;
=20
 	u8 trickle_reg;
+
+	u8 rst_reg;
+	u8 rst_bit;
 };
=20
 #define clk_hw_to_max313xx(_hw) container_of(_hw, struct max313xx, clkou=
t)
@@ -156,6 +160,7 @@ static const struct chip_desc chip[MAX313XX_ID_NR] =3D=
 {
 	[ID_MAX31328] =3D {
 		.int_en_reg =3D 0x0E,
 		.int_status_reg =3D 0x0F,
+		.osf_bit =3D BIT(7),
 		.sec_reg =3D 0x00,
 		.alarm1_sec_reg =3D 0x07,
 		.temp_reg =3D 0x11,
@@ -165,6 +170,7 @@ static const struct chip_desc chip[MAX313XX_ID_NR] =3D=
 {
 	[ID_MAX31329] =3D {
 		.int_en_reg =3D 0x01,
 		.int_status_reg =3D 0x00,
+		.osf_bit =3D BIT(6),
 		.sec_reg =3D 0x06,
 		.alarm1_sec_reg =3D 0x0D,
 		.ram_reg =3D 0x22,
@@ -172,10 +178,13 @@ static const struct chip_desc chip[MAX313XX_ID_NR] =
=3D {
 		.trickle_reg =3D 0x19,
 		.clkout =3D &max31329_clkout,
 		.clkout_name =3D "max31329-clkout",
+		.rst_reg =3D 0x02,
+		.rst_bit =3D BIT(0),
 	},
 	[ID_MAX31331] =3D {
 		.int_en_reg =3D 0x01,
 		.int_status_reg =3D 0x00,
+		.osf_bit =3D BIT(6),
 		.sec_reg =3D 0x08,
 		.alarm1_sec_reg =3D 0x0F,
 		.ram_reg =3D 0x20,
@@ -183,10 +192,13 @@ static const struct chip_desc chip[MAX313XX_ID_NR] =
=3D {
 		.trickle_reg =3D 0x1B,
 		.clkout =3D &max3133x_clkout,
 		.clkout_name =3D "max31331-clkout",
+		.rst_reg =3D 0x02,
+		.rst_bit =3D BIT(0),
 	},
 	[ID_MAX31334] =3D {
 		.int_en_reg =3D 0x01,
 		.int_status_reg =3D 0x00,
+		.osf_bit =3D BIT(6),
 		.sec_reg =3D 0x09,
 		.alarm1_sec_reg =3D 0x10,
 		.ram_reg =3D 0x30,
@@ -194,10 +206,13 @@ static const struct chip_desc chip[MAX313XX_ID_NR] =
=3D {
 		.trickle_reg =3D 0x1E,
 		.clkout =3D &max3133x_clkout,
 		.clkout_name =3D "max31334-clkout",
+		.rst_reg =3D 0x02,
+		.rst_bit =3D BIT(0),
 	},
 	[ID_MAX31341] =3D {
 		.int_en_reg =3D 0x04,
 		.int_status_reg =3D 0x05,
+		.osf_bit =3D BIT(6),
 		.sec_reg =3D 0x06,
 		.alarm1_sec_reg =3D 0x0D,
 		.ram_reg =3D 0x16,
@@ -205,18 +220,24 @@ static const struct chip_desc chip[MAX313XX_ID_NR] =
=3D {
 		.trickle_reg =3D 0x57,
 		.clkout =3D &max31341_42_clkout,
 		.clkout_name =3D "max31341-clkout",
+		.rst_reg =3D 0x00,
+		.rst_bit =3D BIT(0),
 	},
 	[ID_MAX31342] =3D {
 		.int_en_reg =3D 0x04,
 		.int_status_reg =3D 0x05,
+		.osf_bit =3D BIT(6),
 		.sec_reg =3D 0x06,
 		.alarm1_sec_reg =3D 0x0D,
 		.clkout =3D &max31341_42_clkout,
 		.clkout_name =3D "max31342-clkout",
+		.rst_reg =3D 0x00,
+		.rst_bit =3D BIT(0),
 	},
 	[ID_MAX31343] =3D {
 		.int_en_reg =3D 0x01,
 		.int_status_reg =3D 0x00,
+		.osf_bit =3D BIT(6),
 		.sec_reg =3D 0x06,
 		.alarm1_sec_reg =3D 0x0D,
 		.ram_reg =3D 0x22,
@@ -225,6 +246,8 @@ static const struct chip_desc chip[MAX313XX_ID_NR] =3D=
 {
 		.trickle_reg =3D 0x19,
 		.clkout =3D &max31343_clkout,
 		.clkout_name =3D "max31343-clko",
+		.rst_reg =3D 0x02,
+		.rst_bit =3D BIT(0),
 	},
 };
=20
@@ -279,6 +302,14 @@ static int max313xx_read_time(struct device *dev, st=
ruct rtc_time *t)
 	struct max313xx *rtc =3D dev_get_drvdata(dev);
 	u8 regs[7];
 	int ret;
+	unsigned int status;
+
+	ret =3D regmap_read(rtc->regmap, rtc->chip->int_status_reg, &status);
+	if (ret)
+		return ret;
+
+	if (status & rtc->chip->osf_bit)
+		return -EINVAL;
=20
 	ret =3D regmap_bulk_read(rtc->regmap, rtc->chip->sec_reg, regs, 7);
 	if (ret)
@@ -368,6 +399,12 @@ static int max313xx_set_time(struct device *dev, str=
uct rtc_time *t)
 	if (ret)
 		return ret;
=20
+	if (rtc->chip->rst_bit) {
+		ret =3D regmap_clear_bits(rtc->regmap, rtc->chip->rst_reg, rtc->chip->=
rst_bit);
+		if (ret)
+			return ret;
+	}
+
 	ret =3D regmap_bulk_write(rtc->regmap, rtc->chip->sec_reg, regs, 7);
 	if (ret)
 		return ret;
--=20
2.40.0

