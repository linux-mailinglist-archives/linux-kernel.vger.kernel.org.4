Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFC26E7865
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjDSLTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjDSLS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:18:57 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D403F76B0;
        Wed, 19 Apr 2023 04:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0tGMLj6kAURlLI3fWADrBTdC3h3MoLbtauinovC6cY0=; b=rfGM9A0BUOOxp55ZLo2ZLnug1b
        CY36q79wUnmKom9zmyMiJljEMI79dXq2S3v0kxoKtuNYXTJPKwy2hYoL2C6ubzeKfYeWv7Ns8+YQS
        Dm2evaLg88rLY19FkJ/FClz17PfPm5QbDFQz5sz41KOxuDCUA93ZhOBD2MlOxksnzuj3ix8p01pV1
        g1N9OZ8eLpr+3EMSChlPsfp4Xxzt3dcNZt2IcB4wau8kUbvEJmZeq4/NsIdtgVu3ACi/oy+uNyM6e
        ie9CfPx5HfaUT0viXGpjidwW9r9B+T4Zj2ZdGNcf3nGSAfy1NcCLUuu1HEmbz7VRzdW3AnRvhYPbZ
        FgJdAZSA==;
Received: from p200300ccff0a67001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0a:6700:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pp5pF-00085i-PN; Wed, 19 Apr 2023 13:18:13 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1pp5pF-004cHG-11;
        Wed, 19 Apr 2023 13:18:13 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andreas@kemnade.info,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [PATCH v6 0/2] leds: Add a driver for the BD2606MVV
Date:   Wed, 19 Apr 2023 13:18:04 +0200
Message-Id: <20230419111806.1100437-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding description and the corresponding driver for
the BD2606.

Changes in V6:
- comments about dealing with shared brightness registers
- comment about building as a module

Changes in V5:
- remove "driver" from the binding subject line
- avoid presenting shared brightness to the userspace
  by allowing only on/off in such cases.

Changes in V4:
- minor tuning of description in bindings
 
Changes in V3:
- binding cleanup
- move active variable from long-living struct onto stack

Changes in V2:
- Add Datasheet link
- use fwnode api
- remove childnode count check, that will bail out
  anyways later.
- add enable-gpios to binding but not to driver due to lack of
  testing ability

Andreas Kemnade (2):
  dt-bindings: leds: Add ROHM BD2606MVV LED
  leds: bd2606mvv: Driver for the Rohm 6 Channel i2c LED driver

 .../bindings/leds/rohm,bd2606mvv.yaml         |  81 +++++++++
 drivers/leds/Kconfig                          |  14 ++
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-bd2606mvv.c                 | 160 ++++++++++++++++++
 4 files changed, 256 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
 create mode 100644 drivers/leds/leds-bd2606mvv.c

-- 
2.39.2

