Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F470729EE6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241854AbjFIPmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241861AbjFIPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:42:14 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017C830F7;
        Fri,  9 Jun 2023 08:42:14 -0700 (PDT)
Date:   Fri, 09 Jun 2023 15:42:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1686325330; x=1686584530;
        bh=0ZCYTq1OJ9ne6rrLmF3n5ebjjUoiWyyt/yw2i6ZwXrY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Nd4w57QnR41eHmiT2b0ea9VYXdx4NEBAIhXQ2hEAK929KC4yoByAbx3V1+lgVghkr
         UQyuS1ErwU7pXLBvAaI4JJ97HzQC3VK6ayzRC5o7/ltIcCd6LiQn52oSAxZx8qRPfR
         Yx7NF5xYmYTfcwan7W7rLGW8fAbILEBB0qK2a8Hbl61OYcz7IKRfKGpYZo6bot6Lhl
         7mZ2xwMdvo5T6nhbXQLNWJCrMsqypStot1tvSQMV1KEi3Hu6p9fwGV0bQ7lmxeEeHW
         7kLF56mONnpkcXqr6RjYRqRZ8h7G18hkJ3GOHAnFxXxkSsBQ7v8DRI8PZjzKj6tq1E
         d87F1EkSLOM9g==
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
Subject: [PATCH v2 1/2] dt-bindings: nfc: nxp-nci: document pvdd-supply
Message-ID: <20230609154139.3566-1-raymondhackley@protonmail.com>
In-Reply-To: <20230609154033.3511-1-raymondhackley@protonmail.com>
References: <20230609154033.3511-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PN547/553, QN310/330 chips on some devices require a pad supply voltage
(PVDD). Otherwise, the NFC won't power up.

Document support for pad supply voltage pvdd-supply that is enabled by
the nxp-nci driver so that the regulator gets enabled when needed.

Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml b/Docum=
entation/devicetree/bindings/net/nfc/nxp,nci.yaml
index 6924aff0b2c5..d5a4f935c2ce 100644
--- a/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
@@ -25,6 +25,11 @@ properties:
   firmware-gpios:
     description: Output GPIO pin used to enter firmware download mode
=20
+  pvdd-supply:
+    description: |
+      Optional regulator that provides pad supply voltage for some
+      controllers
+
   interrupts:
     maxItems: 1
=20
--=20
2.30.2


