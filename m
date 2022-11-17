Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B881962E4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbiKQTF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240236AbiKQTFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:05:53 -0500
X-Greylist: delayed 9021 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 11:05:52 PST
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385A67EC85;
        Thu, 17 Nov 2022 11:05:52 -0800 (PST)
Date:   Thu, 17 Nov 2022 19:05:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668711950; x=1668971150;
        bh=SvQ/7qvSOWMTkyWcL82fB0gmqIP5uLDGT8xWRxWMlGM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ZoMIByvnSLQO+gpeH+/EAb+lwGCA8Wo65u926MAgWzntU1/w3U0ziauux0sk02nXu
         JnR0XbGNcPs5blnZypXQ581XnpjIU2p7aWewkws0ndQ8QuY8WnxDkJEinI7HVS4ygi
         TB0yGLHpsHldPd+Uxg2PbgEHOAsGXDSOBPhTY2vfWHhCRgoVW9Pfsdb/9yrnJnuxnC
         f7r9Sbn6qdjphjLRXT8SUzemkOQvVJHCXOnx85VNqy6lDLi3Hxrnl82nDGMoGndHNC
         BE5fWx2jcFhrTg+kYk/ifeDxFCn23hUthaTzn8Ukq4XTIzjV5Z/2mbLPaAy0gdvirE
         szp9fH4SOU4+A==
To:     linux-input@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alistair Francis <alistair@alistair23.me>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: cyttsp5 - add vddio regulator
Message-ID: <20221117190507.87535-3-linmengbo0689@protonmail.com>
In-Reply-To: <20221117190507.87535-1-linmengbo0689@protonmail.com>
References: <20221117190507.87535-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung touchscreen controllers are often used with external pull-up
for the interrupt line and the I2C lines, so we might need to enable
a regulator to bring the lines into usable state. Otherwise, this might
cause spurious interrupts and reading from I2C will fail.

Implement support for a "vddio-supply" that is enabled by the cyttsp5
driver so that the regulator gets enabled when needed.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 drivers/input/touchscreen/cyttsp5.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscree=
n/cyttsp5.c
index 24ab1df9fc07..d02fdb940edf 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -190,7 +190,7 @@ struct cyttsp5 {
 =09int num_prv_rec;
 =09struct regmap *regmap;
 =09struct touchscreen_properties prop;
-=09struct regulator *vdd;
+=09struct regulator_bulk_data supplies[2];
 };
=20
 /*
@@ -767,7 +767,7 @@ static void cyttsp5_cleanup(void *data)
 {
 =09struct cyttsp5 *ts =3D data;
=20
-=09regulator_disable(ts->vdd);
+=09regulator_bulk_disable(ARRAY_SIZE(ts->supplies), ts->supplies);
 }
=20
 static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int ir=
q,
@@ -790,9 +790,12 @@ static int cyttsp5_probe(struct device *dev, struct re=
gmap *regmap, int irq,
 =09init_completion(&ts->cmd_done);
=20
 =09/* Power up the device */
-=09ts->vdd =3D devm_regulator_get(dev, "vdd");
-=09if (IS_ERR(ts->vdd)) {
-=09=09error =3D PTR_ERR(ts->vdd);
+=09ts->supplies[0].supply =3D "vdd";
+=09ts->supplies[1].supply =3D "vddio";
+=09error =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(ts->supplies),
+=09=09=09=09      ts->supplies);
+=09if (error < 0) {
+=09=09dev_err(ts->dev, "Failed to get regulators, error %d\n", error);
 =09=09return error;
 =09}
=20
@@ -800,9 +803,11 @@ static int cyttsp5_probe(struct device *dev, struct re=
gmap *regmap, int irq,
 =09if (error)
 =09=09return error;
=20
-=09error =3D regulator_enable(ts->vdd);
-=09if (error)
+=09error =3D regulator_bulk_enable(ARRAY_SIZE(ts->supplies), ts->supplies)=
;
+=09if (error < 0) {
+=09=09dev_err(ts->dev, "Failed to enable regulators, error %d\n", error);
 =09=09return error;
+=09}
=20
 =09ts->input =3D devm_input_allocate_device(dev);
 =09if (!ts->input) {
--=20
2.30.2


