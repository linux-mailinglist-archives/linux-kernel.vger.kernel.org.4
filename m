Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8C561DFF3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 02:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiKFB5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 21:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKFB5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 21:57:00 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7259410FEC
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 18:56:58 -0700 (PDT)
Date:   Sun, 06 Nov 2022 01:56:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acoro.eu;
        s=protonmail2; t=1667699815; x=1667959015;
        bh=mQo/LrxITE3DqpUIqglGeTMcTvldRTD81SH3Ss+5aSc=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=Q90Mc13zK3an+OLi+M1g7Kn33zBw0Vbdlk/A+9nx35u0KsLpflK1TYr81OpbTkBrx
         nGhUErXbzsxHwOiBcrYlQqlWp6p6s0g0yTyVoWo0g+xnk11WDPATO0F4Cu8Yd9ZlWS
         L0OzSu+DGUMfTMgDJPpS0gZ+/CrBw4m3faiVK0V7/72vKoiL4H7fIIrImsFV95jqRc
         TqInnJBd1Z6cw8G9dOh2f7WYurArojs/LGOaPTZljSedd0NJdN0KUYLflnoleIU+DX
         enF9mkqwIOqF/3IZuQMYcLDVftrGkyg3MznQv1Rc6381deJ4xD8sDRGz1vNpnc3+zL
         Bp6nkgqI0X7Kw==
To:     "matt.ranostay@konsulko.com" <matt.ranostay@konsulko.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From:   =?utf-8?Q?Alejandro_Concepci=C3=B3n_Rodr=C3=ADguez?= 
        <asconcepcion@acoro.eu>
Subject: [PATCH] iio: light: apds9960: fix wrong register for gesture gain
Message-ID: <EaT-NKC-H4DNX5z4Lg9B6IWPD5TrTrYBr5DYB784wfDKQkTmzPXkoYqyUOrOgJH-xvTsEkFLcVkeAPZRUODEFI5dGziaWXwjpfBNLeNGfNc=@acoro.eu>
Feedback-ID: 31930248:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gesture Gain Control is in REG_GCONF_2 (0xa3), not in REG_CONFIG_2 (0x90).

Fixes: aff268cd532e ("iio: light: add APDS9960 ALS + promixity driver")

Signed-off-by: Alejandro Concepcion-Rodriguez <asconcepcion@acoro.eu>
---
 drivers/iio/light/apds9960.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index b62c139baf41..38d4c7644bef 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -54,9 +54,6 @@
 #define APDS9960_REG_CONTROL_PGAIN_MASK_SHIFT=092
=20
 #define APDS9960_REG_CONFIG_2=090x90
-#define APDS9960_REG_CONFIG_2_GGAIN_MASK=090x60
-#define APDS9960_REG_CONFIG_2_GGAIN_MASK_SHIFT=095
-
 #define APDS9960_REG_ID=09=090x92
=20
 #define APDS9960_REG_STATUS=090x93
@@ -77,6 +74,9 @@
 #define APDS9960_REG_GCONF_1_GFIFO_THRES_MASK_SHIFT=096
=20
 #define APDS9960_REG_GCONF_2=090xa3
+#define APDS9960_REG_GCONF_2_GGAIN_MASK=09=09=090x60
+#define APDS9960_REG_GCONF_2_GGAIN_MASK_SHIFT=09=095
+
 #define APDS9960_REG_GOFFSET_U=090xa4
 #define APDS9960_REG_GOFFSET_D=090xa5
 #define APDS9960_REG_GPULSE=090xa6
@@ -396,9 +396,9 @@ static int apds9960_set_pxs_gain(struct apds9960_data *=
data, int val)
 =09=09=09}
=20
 =09=09=09ret =3D regmap_update_bits(data->regmap,
-=09=09=09=09APDS9960_REG_CONFIG_2,
-=09=09=09=09APDS9960_REG_CONFIG_2_GGAIN_MASK,
-=09=09=09=09idx << APDS9960_REG_CONFIG_2_GGAIN_MASK_SHIFT);
+=09=09=09=09APDS9960_REG_GCONF_2,
+=09=09=09=09APDS9960_REG_GCONF_2_GGAIN_MASK,
+=09=09=09=09idx << APDS9960_REG_GCONF_2_GGAIN_MASK_SHIFT);
 =09=09=09if (!ret)
 =09=09=09=09data->pxs_gain =3D idx;
 =09=09=09mutex_unlock(&data->lock);
--=20
2.34.1
