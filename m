Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3578872A26F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjFIShu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjFIShb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:37:31 -0400
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5138A3C34;
        Fri,  9 Jun 2023 11:37:17 -0700 (PDT)
Date:   Fri, 09 Jun 2023 18:36:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1686335835; x=1686595035;
        bh=ZWzcN/Tm7VxGdb18LHyy/4I9RAaaMI8KoDWSNbJZYMw=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=GDkj0e4YcK/k1MkYVYVM0O0q+8qmFCLOC0i+keM0nC1jzGHmfGugU5gnfahcA9q3c
         0DE4DpPpLLsYosXJGxfdIHrk8GVzPAqOfcBbQI4xs1AQeWu6x0dLAdzmslyJZ+i41y
         +pfmlMnmyiKfE4aOO9VdZ8+RZCnyczrEUVep3B/vS3x+Yv4WUF90CxlWiJg8KZaFRQ
         oSa48X4kp+apvcrutYTwwDAUl1x+jUCoui/RaI/hEh/+1RtGUOyV2odyqH5Tajl8TG
         7EsAvWzyr4oi29a1yhsmCOq3OIhW6PMBstRC8MAX7pyXv9nh0nM81UXGftV7Gt3YwL
         g4h37ftONB1bw==
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
Subject: [RESEND PATCH v3 0/2] NFC: nxp-nci: Add pad supply voltage pvdd-supply
Message-ID: <20230609183639.85221-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3: Fix weird wrapping and drop another unnecessary nxp_nci_i2c_poweroff()
v2: Use dev_err_probe() and drop unnecessary nxp_nci_i2c_poweroff()

PN547/553, QN310/330 chips on some devices require a pad supply voltage
(PVDD). Otherwise, the NFC won't power up.

Implement support for pad supply voltage pvdd-supply that is enabled by
the nxp-nci driver so that the regulator gets enabled when needed.

