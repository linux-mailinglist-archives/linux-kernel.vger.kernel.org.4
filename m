Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B2C6BA2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjCNW4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjCNWzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:55:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8183E60F;
        Tue, 14 Mar 2023 15:55:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D674EB81C03;
        Tue, 14 Mar 2023 22:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F89C433EF;
        Tue, 14 Mar 2023 22:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678834542;
        bh=TaqFMsF6uQPer7urWpXd+hD3bCoXdn3xFrMC/vSG5ks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHHYd5al8ljAwEqeWDYM40QXnrc7ffF7s2o4EeVLwV2MKYPytThnCtVdkwnpchzVH
         dkxSgwMzQXSmFg3bUb/7Bvh93WqclU/v8bAE5qQJbLl0CtFoZXFt9kn8jzk1iWXOu+
         +cp8Hxp+gTbJ+pSHn9DU3ZFPvy+yxV1Fnv64fbfW8sHrK3c72jbkNbbOtYwrfnomx+
         lCDDD1udGsb2e6twARymFM5A/i0ZHSWt1LPRifVdbms0O1699UZn+HlnLOVaUqMlBO
         K4Mieoa1td+arnYC4aTUG7wFCeacrnCF3bwlMJnSABqM8w5ezfST+qmPRmJbrOZsSI
         /NsPs5/YvaBKg==
Received: by mercury (Postfix, from userid 1000)
        id E6C0410620B1; Tue, 14 Mar 2023 23:55:36 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 10/12] power: supply: generic-adc-battery: add temperature support
Date:   Tue, 14 Mar 2023 23:55:33 +0100
Message-Id: <20230314225535.1321736-11-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314225535.1321736-1-sre@kernel.org>
References: <20230314225535.1321736-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.com>

Another typical thing to monitor via an ADC line is
the battery temperature.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/generic-adc-battery.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 4811e72df8cd..0124d8d51af7 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -30,6 +30,7 @@ enum gab_chan_type {
 	GAB_VOLTAGE = 0,
 	GAB_CURRENT,
 	GAB_POWER,
+	GAB_TEMP,
 	GAB_MAX_CHAN_TYPE
 };
 
@@ -40,7 +41,8 @@ enum gab_chan_type {
 static const char *const gab_chan_name[] = {
 	[GAB_VOLTAGE]	= "voltage",
 	[GAB_CURRENT]	= "current",
-	[GAB_POWER]		= "power",
+	[GAB_POWER]	= "power",
+	[GAB_TEMP]	= "temperature",
 };
 
 struct gab {
@@ -77,6 +79,7 @@ static const enum power_supply_property gab_dyn_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_TEMP,
 };
 
 static bool gab_charge_finished(struct gab *adc_bat)
@@ -115,6 +118,8 @@ static int gab_get_property(struct power_supply *psy,
 		return read_channel(adc_bat, GAB_CURRENT, &val->intval);
 	case POWER_SUPPLY_PROP_POWER_NOW:
 		return read_channel(adc_bat, GAB_POWER, &val->intval);
+	case POWER_SUPPLY_PROP_TEMP:
+		return read_channel(adc_bat, GAB_TEMP, &val->intval);
 	default:
 		return -EINVAL;
 	}
-- 
2.39.2

