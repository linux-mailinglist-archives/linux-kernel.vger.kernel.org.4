Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3953C6BF58E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjCQW5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjCQW5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:57:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D172D162;
        Fri, 17 Mar 2023 15:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F418A60CA3;
        Fri, 17 Mar 2023 22:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B25BC433A0;
        Fri, 17 Mar 2023 22:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679093833;
        bh=c3WYbgfatFUXlt2kUOofkHvWoKbgirGFc4A+gjyj7bE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sNfBeWUmAoIMbt5c8TAoNvIj1fVw3JIlBQPkOpPM2xjh9iWKi+8b4sJp/F1PojNo7
         qW20EJJcE+0CmD2ljfQDQj+sCKAbiI8+iiFK1zcMBRNlOHCx1iKmLE52EQV0P/vTSX
         k83pB5izv2lVunxcvNSrbdkVHcRnhusGazVtXJZR2Jf4rrjlgyarBBhTWlTD3stana
         39I+6W3VSr8F1ikG5c4amr1uh4VCpVnaUZ45ZvpL/BV/3hWx8SIlAhGR0qHF+7aWfT
         lhWaQV9y6hqGcyKh20rEapLUF/9PG6VZFGG+JZN+5i0xo4MGPhS0373c7ME7t2/juB
         zaQfq53+wgIgw==
Received: by mercury (Postfix, from userid 1000)
        id 8F2C31062107; Fri, 17 Mar 2023 23:57:08 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv3 06/14] power: supply: generic-adc-battery: drop charge now support
Date:   Fri, 17 Mar 2023 23:56:59 +0100
Message-Id: <20230317225707.1552512-7-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317225707.1552512-1-sre@kernel.org>
References: <20230317225707.1552512-1-sre@kernel.org>
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

Drop CHARGE_NOW support, which requires a platform specific
calculation method.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 4 ----
 include/linux/power/generic-adc-battery.h  | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index e20894460d7f..d07eeb7d46d3 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -72,7 +72,6 @@ static const enum power_supply_property gab_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN,
-	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
@@ -166,9 +165,6 @@ static int gab_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN:
 		val->intval = 0;
 		break;
-	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		val->intval = pdata->cal_charge(result);
-		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_POWER_NOW:
diff --git a/include/linux/power/generic-adc-battery.h b/include/linux/power/generic-adc-battery.h
index 50eb4bf28286..54434e4304d3 100644
--- a/include/linux/power/generic-adc-battery.h
+++ b/include/linux/power/generic-adc-battery.h
@@ -10,11 +10,9 @@
  * struct gab_platform_data - platform_data for generic adc iio battery driver.
  * @battery_info:         recommended structure to specify static power supply
  *			   parameters
- * @cal_charge:           calculate charge level.
  */
 struct gab_platform_data {
 	struct power_supply_info battery_info;
-	int	(*cal_charge)(long value);
 };
 
 #endif /* GENERIC_ADC_BATTERY_H */
-- 
2.39.2

