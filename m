Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9766D6B3155
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjCIWvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjCIWu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:50:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A166F6C77;
        Thu,  9 Mar 2023 14:50:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE38DB82126;
        Thu,  9 Mar 2023 22:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDB8C433D2;
        Thu,  9 Mar 2023 22:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678402248;
        bh=VYhOuoj42MSKuPzveR1C3Vzmh0B87Z6hDNN0FMDUz74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ucfeeQqPLZumezdSghzWNrUjjSoAAZF5VcHqdt8g76AiQpbiPNA4POsIMgoefstfe
         jt57JVa8G3qQz/eIByDSazevLjqsdXaCx7pdsJtv7ezYgMiQClq1zpYI8Kz1eCeeoF
         tfFeiH70xcyaLyrpoH2Ss1dBF42zD3Yl2SCdAN6BdxDMlyKnuxURUyePPEyQ4lsUlh
         5Icekw7R414kyFM7PeQqeXChlscIk2QxprgKHXZpTX8SIqYAuXj3D4uGzC+p63G7O4
         rjghZ1ydcBXBWM+whEpfE8E8z/Yr9W8AyLQ22LcbyqPinUnHcsaoA2ywPvGFP8yfGV
         XuC2TAOpQD0AQ==
Received: by mercury (Postfix, from userid 1000)
        id 6412710609DB; Thu,  9 Mar 2023 23:50:43 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv1 06/11] power: supply: generic-adc-battery: drop charge now support
Date:   Thu,  9 Mar 2023 23:50:36 +0100
Message-Id: <20230309225041.477440-7-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309225041.477440-1-sre@kernel.org>
References: <20230309225041.477440-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop CHARGE_NOW support, which requires a platform specific
calculation method.

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

