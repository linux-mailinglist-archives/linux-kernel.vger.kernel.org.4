Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB906BF591
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjCQW5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCQW5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:57:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169672A160;
        Fri, 17 Mar 2023 15:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 808D360B38;
        Fri, 17 Mar 2023 22:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58629C433A1;
        Fri, 17 Mar 2023 22:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679093833;
        bh=9QR9W/JE2VPSuxBafhH+1vjL6oKiJkoUkzDOh5uWc/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQy1d/yc+7I5q/SjQKAnAgjo3vcozx4XWP0YHxb8TxeEI3csoW/kmJUyn9o3TTMFg
         vkFDl3wVaj6i02LfuizD0LcCGWgCN39XekQgLZ0IPen1MfUJTTr/A5HrJb37c6xhSx
         zxC5MPCzA7BuPqqHmO/hU5WcxkHD6pVcKuPWpp9HhEwePkl5XePryXaYzWm/FX3kWC
         r5r7shq4L/5gYrVoER4lmaWZh4c6Bh8u2IL3EEFrEnTFa8AWtt9ZxuxN7sgEpTHngC
         YXptoMyD9SVbPuQMWiWq8EPWvAuLeN1PbZCemLFpxPvp7qNY2N4NF7ClFbkg/RxXH9
         nyYCWDrdtUI+g==
Received: by mercury (Postfix, from userid 1000)
        id 9820E1062110; Fri, 17 Mar 2023 23:57:08 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv3 10/14] power: supply: generic-adc-battery: add temperature support
Date:   Fri, 17 Mar 2023 23:57:03 +0100
Message-Id: <20230317225707.1552512-11-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317225707.1552512-1-sre@kernel.org>
References: <20230317225707.1552512-1-sre@kernel.org>
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

Another typical thing to monitor via an ADC line is
the battery temperature.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
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

