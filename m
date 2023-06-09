Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EED729EE7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241867AbjFIPmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbjFIPmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:42:32 -0400
Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1CE30F7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:42:31 -0700 (PDT)
Date:   Fri, 09 Jun 2023 15:42:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1686325349; x=1686584549;
        bh=xadFqMnNfgl6gT0vaVLmkE//dImhTGrrvi/LgkS3A0c=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=eM8aZ7y+NM3rLwsevMhMxoeqKFgofaRbvBfA1ynKoGI8Oykbrfy6mIfE5ahu+SvWa
         xjwl76l4Bkqg6hiGtbDzfAJrnovcwfOFSTJugu/P9xK7W8QfKrc8Vw+mzFk6GvaIUR
         91Dl98z0l7AAGCsKtC1OGNdv2tj48u+7LInVGv18OW+11cAo+SKAMB8esB9kD+XDuK
         7Anic43oM4dz0RtpOnWpwksrVOrSvMvS6+6zjsQf6EWO4uLjGSzZVJ5LRCHouvaYz3
         xF9Jk6wqpm+TeOUcF4DsyhyHMeGKhReUpAgEwPgFoGwVHylaEBkCJ3x2RcNAfsNng2
         PtWc9X6Ru8UDg==
To:     linux-kernel@vger.kernel.org
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Walle <michael@walle.cc>,
        =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] NFC: nxp-nci: Add pad supply voltage pvdd-supply
Message-ID: <20230609154200.3620-1-raymondhackley@protonmail.com>
In-Reply-To: <20230609154033.3511-1-raymondhackley@protonmail.com>
References: <20230609154033.3511-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PN547/553, QN310/330 chips on some devices require a pad supply voltage
(PVDD). Otherwise, the NFC won't power up.

Implement support for pad supply voltage pvdd-supply that is enabled by
the nxp-nci driver so that the regulator gets enabled when needed.

Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 drivers/nfc/nxp-nci/i2c.c | 42 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index d4c299be7949..1b8877757cee 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -35,6 +35,7 @@ struct nxp_nci_i2c_phy {
=20
 =09struct gpio_desc *gpiod_en;
 =09struct gpio_desc *gpiod_fw;
+=09struct regulator *pvdd;
=20
 =09int hard_fault; /*
 =09=09=09 * < 0 if hardware error occurred (e.g. i2c err)
@@ -263,6 +264,22 @@ static const struct acpi_gpio_mapping acpi_nxp_nci_gpi=
os[] =3D {
 =09{ }
 };
=20
+static void nxp_nci_i2c_poweroff(void *data)
+{
+=09struct nxp_nci_i2c_phy *phy =3D data;
+=09struct device *dev =3D &phy->i2c_dev->dev;
+=09struct regulator *pvdd =3D phy->pvdd;
+=09int r;
+
+=09if (!IS_ERR(pvdd) && regulator_is_enabled(pvdd)) {
+=09=09r =3D regulator_disable(pvdd);
+=09=09if (r < 0)
+=09=09=09dev_warn(dev,
+=09=09=09=09 "Failed to disable regulator pvdd: %d\n",
+=09=09=09=09 r);
+=09}
+}
+
 static int nxp_nci_i2c_probe(struct i2c_client *client)
 {
 =09struct device *dev =3D &client->dev;
@@ -298,6 +315,29 @@ static int nxp_nci_i2c_probe(struct i2c_client *client=
)
 =09=09return PTR_ERR(phy->gpiod_fw);
 =09}
=20
+=09phy->pvdd =3D devm_regulator_get_optional(dev, "pvdd");
+=09if (IS_ERR(phy->pvdd)) {
+=09=09r =3D PTR_ERR(phy->pvdd);
+=09=09if (r !=3D -ENODEV)
+=09=09=09return dev_err_probe(dev, r,
+=09=09=09=09=09     "Failed to get regulator pvdd\n");
+=09} else {
+=09=09r =3D regulator_enable(phy->pvdd);
+=09=09if (r < 0) {
+=09=09=09nfc_err(dev,
+=09=09=09=09"Failed to enable regulator pvdd: %d\n",
+=09=09=09=09r);
+=09=09=09return r;
+=09=09}
+=09}
+
+=09r =3D devm_add_action_or_reset(dev, nxp_nci_i2c_poweroff, phy);
+=09if (r < 0) {
+=09=09nfc_err(dev, "Failed to install poweroff handler: %d\n",
+=09=09=09r);
+=09=09return r;
+=09}
+
 =09r =3D nxp_nci_probe(phy, &client->dev, &i2c_phy_ops,
 =09=09=09  NXP_NCI_I2C_MAX_PAYLOAD, &phy->ndev);
 =09if (r < 0)
@@ -319,6 +359,8 @@ static void nxp_nci_i2c_remove(struct i2c_client *clien=
t)
=20
 =09nxp_nci_remove(phy->ndev);
 =09free_irq(client->irq, phy);
+
+=09nxp_nci_i2c_poweroff(phy);
 }
=20
 static const struct i2c_device_id nxp_nci_i2c_id_table[] =3D {
--=20
2.30.2


