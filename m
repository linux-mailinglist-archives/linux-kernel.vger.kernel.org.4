Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC0A6C1498
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjCTOXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjCTOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:23:03 -0400
X-Greylist: delayed 140 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Mar 2023 07:22:57 PDT
Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C096F2200D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:22:57 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:22:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1679322175; x=1679581375;
        bh=hnNQw8IGieeGXczUkQFigxPqYaJQ3wX8rs+fIziAfsA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=cFCg2QVgznqVtFP9eEgtD2O96s0VDDWHNQ0clkXOHyio208BE1CMPBFTq4FxwqAQd
         DgPGzeubXAFZXrfzVtVoI6RuU8pSHhSw4ylAt4cENkTCqaxziMWT9VxFi3cd8pAwC5
         iZfknvxU4Lc9+h7rpdHZIjSi2+BhCdjILweF8oOS4SQPDkylWbOxfBwJ2RPcZDI8PZ
         p7TXOfLVGNPJ+TgPBMhK5Iscjv0ckxSNJc2wZlOP7lM/9O+amqmFDm0O4ByYFxJkp1
         C6CZafVjnJ7fyFscCLtxZufKA5kUkAB4rQ86uVxcNwGHjSU9CO2VqIjd3nhJfBmAmB
         kBdNVB6qyz1rg==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 2/2] leds: aw2013: Add vdd regulator
Message-ID: <20230320142116.3494-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230320141638.3378-1-linmengbo0689@protonmail.com>
References: <20230320141638.3378-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for a "vdd" that is enabled by the aw2013 driver so that
the regulator gets enabled when needed.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 drivers/leds/leds-aw2013.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
index 0b52fc9097c6..91d720edb857 100644
--- a/drivers/leds/leds-aw2013.c
+++ b/drivers/leds/leds-aw2013.c
@@ -62,7 +62,7 @@ struct aw2013_led {
=20
 struct aw2013 {
 =09struct mutex mutex; /* held when writing to registers */
-=09struct regulator *vcc_regulator;
+=09struct regulator_bulk_data regulators[2];
 =09struct i2c_client *client;
 =09struct aw2013_led leds[AW2013_MAX_LEDS];
 =09struct regmap *regmap;
@@ -106,7 +106,8 @@ static void aw2013_chip_disable(struct aw2013 *chip)
=20
 =09regmap_write(chip->regmap, AW2013_GCR, 0);
=20
-=09ret =3D regulator_disable(chip->vcc_regulator);
+=09ret =3D regulator_bulk_disable(ARRAY_SIZE(chip->regulators),
+=09=09=09=09     chip->regulators);
 =09if (ret) {
 =09=09dev_err(&chip->client->dev,
 =09=09=09"Failed to disable regulator: %d\n", ret);
@@ -123,7 +124,8 @@ static int aw2013_chip_enable(struct aw2013 *chip)
 =09if (chip->enabled)
 =09=09return 0;
=20
-=09ret =3D regulator_enable(chip->vcc_regulator);
+=09ret =3D regulator_bulk_enable(ARRAY_SIZE(chip->regulators),
+=09=09=09=09    chip->regulators);
 =09if (ret) {
 =09=09dev_err(&chip->client->dev,
 =09=09=09"Failed to enable regulator: %d\n", ret);
@@ -348,16 +350,20 @@ static int aw2013_probe(struct i2c_client *client)
 =09=09goto error;
 =09}
=20
-=09chip->vcc_regulator =3D devm_regulator_get(&client->dev, "vcc");
-=09ret =3D PTR_ERR_OR_ZERO(chip->vcc_regulator);
-=09if (ret) {
+=09chip->regulators[0].supply =3D "vcc";
+=09chip->regulators[1].supply =3D "vdd";
+=09ret =3D devm_regulator_bulk_get(&client->dev,
+=09=09=09=09      ARRAY_SIZE(chip->regulators),
+=09=09=09=09      chip->regulators);
+=09if (ret < 0) {
 =09=09if (ret !=3D -EPROBE_DEFER)
 =09=09=09dev_err(&client->dev,
 =09=09=09=09"Failed to request regulator: %d\n", ret);
 =09=09goto error;
 =09}
=20
-=09ret =3D regulator_enable(chip->vcc_regulator);
+=09ret =3D regulator_bulk_enable(ARRAY_SIZE(chip->regulators),
+=09=09=09=09    chip->regulators);
 =09if (ret) {
 =09=09dev_err(&client->dev,
 =09=09=09"Failed to enable regulator: %d\n", ret);
@@ -382,7 +388,8 @@ static int aw2013_probe(struct i2c_client *client)
 =09if (ret < 0)
 =09=09goto error_reg;
=20
-=09ret =3D regulator_disable(chip->vcc_regulator);
+=09ret =3D regulator_bulk_disable(ARRAY_SIZE(chip->regulators),
+=09=09=09=09     chip->regulators);
 =09if (ret) {
 =09=09dev_err(&client->dev,
 =09=09=09"Failed to disable regulator: %d\n", ret);
@@ -394,7 +401,8 @@ static int aw2013_probe(struct i2c_client *client)
 =09return 0;
=20
 error_reg:
-=09regulator_disable(chip->vcc_regulator);
+=09regulator_bulk_disable(ARRAY_SIZE(chip->regulators),
+=09=09=09       chip->regulators);
=20
 error:
 =09mutex_destroy(&chip->mutex);
--=20
2.30.2


