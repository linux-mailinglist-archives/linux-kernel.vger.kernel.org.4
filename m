Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AF461DD71
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 19:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiKES7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 14:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiKES7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 14:59:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B172BFF;
        Sat,  5 Nov 2022 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667674761; bh=Qpw8OKKBbZVVfzRq9A/GSiYS3wmIwpXxBurfIN6x05I=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SlDnVSwIFHrbJ4TPSLdlFuzAXHC+bhydtVpb9WMVZB0v6f01S4F78lyUg/+J+C6Tt
         CMQ8PLC1PWyN6BpBAtQjO0NmP4h4SvP7s7uDegygqsYg0BguryUfEytGL4RH0zMfht
         65Rkb8r0evwqpBLKV6LSQhqNBb/ybRZS4oJLDrWdR9Dj2BeeSbS2rOMBzZSxsw4Mz6
         kdl9PMtD7MK6sdgM0iIoilyTg/2XyGMx/nZDziyeKE+j2Y5n7Lh7JZu0ona21wuYkS
         XKvb3IEJwPLoeaIQYNe8pvDquFEfcBna05w9Bbz+8md0+p7JgQRxuXMWjaiRCuCOgy
         JIPDD+uQ3LSfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([87.78.44.193]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fmq-1p2ITJ2h5M-011x00; Sat, 05
 Nov 2022 19:59:21 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 2/8] pinctrl: nuvoton: wpcm450: Fix handling of inverted MFSEL bits
Date:   Sat,  5 Nov 2022 19:59:05 +0100
Message-Id: <20221105185911.1547847-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
References: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vfta1KKuPXfyTJlokrlUIHqVt+wLZz8l/XAP30d+cEfJqL6A2LA
 g5LjfJosVcXeoCtrvPlJNvI6ZX5ynJxH721gUnKyGVOj9SLpUA29/I2PBZtdDVOB+d6EqT2
 Dh6Q2yAtBCAYQK1V7mhtYOqApao/igkZ0ZQvTwRlIP8pwqLrQKJpVLYaZ/fzXTl17AwqWjx
 bR+w2fkM/sYjgaVQBMYHw==
UI-OutboundReport: notjunk:1;M01:P0:n3cR5LUqolI=;cP+fOJOaOTtw9hjNLch1t/06EwK
 N+vvEtSrqWPHeYoWb6HLd+ym+5ej+kC0F1ErWt8n+MfZU3Xs8uP1kuhkMllSbQyTmEXLC7WIL
 SFdwcTVxNV4oAbP9q/GUqnedEiLtEpH+rTsm9XYG+9QMkLt6GjXh/4k0dHvgxI8XqIDwRaaUM
 Nln9YkmS4awqNp4Eq5ZKIQSh5nwLWf/q5ecC+rIe6S9ztCMUuZOJxTtWUj2ZKBf8GwfL5W3rd
 Ni5Vu5vU3NbID+p83WYl/HT2tYHQhu5Ktsmuw8nIuF2YLq9sGt9yqy1NL+V+jwxFnemoqnKm0
 tAM+Sp6GXELpvq/Gw8azuUNZhkvg6wd9Ow2sMkIX4M5ovoSX4zMUb6Xa4knAr4qNAIX6NTmk8
 gO7Hls5ZE8hvkxmOXdOX/bblzEv/Ln81ClPvOr9g7XGegpVSAFy6ucYqbXE2wndzbSxYfZIRU
 iZyh0l+K4yJdFAGlkUHaVi7+5oIBCp2TSOzG08oFVQkVRzLW45RhSniQ+8fRIrQ/nGsiwI7T4
 wE3IHqoC5kIQiEkMqEWLk2vgiG+xFAzv1jnMB10JKkMuJ2YcDjTiYf8kEmMxonkv1Vb+JMYa9
 GoNSL/aFidXyb3dyw53BmX0FhY+WbwUMrOxXMAzA11SND6QaJWQx6OwaYmOElCdhCyTagHj8C
 rIsNmb3ssRcgmZJSyIWh8w+i8VyIIXB2E2tLNAsHoPphMs6sMe+XfvspRfaFqZz64AKeaTNle
 JCBj9KboCuv6gq80WVNRc3jTLDOfKf+Mstx1KF+j7UgcJ8SE2hXf4SlBWg8VVURz3w7QC5zmo
 6A2Bqn3ZNXPPoeqyoA5LSd8YotnUU9ixrjdHXejGoqEDV6alcWbB2WxXWaix2f5ByAfGHZbKN
 QyYUnlB2DqFsQXiMNJlF8tvNV1iQ326GUUEZWlGfbu4GW8DVU9WRdf4c+LBbFBhJE7mZvZBR5
 wD5J/CG787cp2GsgKDZbeo7U+UQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCS3SEL and KBCCSEL use inverted logic: Whereas in other fields 0
selects the GPIO function and 1 selects the special function, in these
two fields, 0 selects the special function and 1 selects the GPIO
function.

Adjust the code to handle this quirk.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c b/drivers/pinctrl/n=
uvoton/pinctrl-wpcm450.c
index 49b2177af17b2..2d1c1652cfd9d 100644
=2D-- a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
@@ -628,6 +628,9 @@ struct wpcm450_pincfg {
 	int fn1, reg1, bit1;
 };

+/* Add this value to bit0 or bit1 to indicate that the MFSEL bit is inver=
ted */
+#define INV	BIT(5)
+
 static const struct wpcm450_pincfg pincfg[] =3D {
 	/*		PIN	  FUNCTION 1		   FUNCTION 2 */
 	WPCM450_PINCFG(0,	 none, NONE, 0,		  none, NONE, 0),
@@ -665,7 +668,7 @@ static const struct wpcm450_pincfg pincfg[] =3D {

 	WPCM450_PINCFG(32,	 scs1, MFSEL1, 3,	  none, NONE, 0),
 	WPCM450_PINCFG(33,	 scs2, MFSEL1, 4,	  none, NONE, 0),
-	WPCM450_PINCFG(34,	 scs3, MFSEL1, 5,	  none, NONE, 0),
+	WPCM450_PINCFG(34,	 scs3, MFSEL1, 5 | INV,	  none, NONE, 0),
 	WPCM450_PINCFG(35,	 xcs1, MFSEL1, 29,	  none, NONE, 0),
 	WPCM450_PINCFG(36,	 xcs2, MFSEL1, 28,	  none, NONE, 0),
 	WPCM450_PINCFG(37,	 none, NONE, 0,		  none, NONE, 0), /* DVO */
@@ -725,8 +728,8 @@ static const struct wpcm450_pincfg pincfg[] =3D {
 	WPCM450_PINCFG(90,	r2err, MFSEL1, 15,	  none, NONE, 0),
 	WPCM450_PINCFG(91,	 r2md, MFSEL1, 16,	  none, NONE, 0),
 	WPCM450_PINCFG(92,	 r2md, MFSEL1, 16,	  none, NONE, 0),
-	WPCM450_PINCFG(93,	 kbcc, MFSEL1, 17,	  none, NONE, 0),
-	WPCM450_PINCFG(94,	 kbcc, MFSEL1, 17,	  none, NONE, 0),
+	WPCM450_PINCFG(93,	 kbcc, MFSEL1, 17 | INV,  none, NONE, 0),
+	WPCM450_PINCFG(94,	 kbcc, MFSEL1, 17 | INV,  none, NONE, 0),
 	WPCM450_PINCFG(95,	 none, NONE, 0,		  none, NONE, 0),

 	WPCM450_PINCFG(96,	 none, NONE, 0,		  none, NONE, 0),
@@ -805,6 +808,11 @@ static void wpcm450_update_mfsel(struct regmap *gcr_r=
egmap, int reg, int bit, in
 {
 	bool value =3D (fn =3D=3D fn_selected);

+	if (bit & INV) {
+		value =3D !value;
+		bit &=3D ~INV;
+	}
+
 	regmap_update_bits(gcr_regmap, reg, BIT(bit), value ? BIT(bit) : 0);
 }

=2D-
2.35.1

