Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773076B314B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjCIWvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjCIWvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:51:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35123E4D8B;
        Thu,  9 Mar 2023 14:50:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59F8561D1D;
        Thu,  9 Mar 2023 22:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF22C433A1;
        Thu,  9 Mar 2023 22:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678402248;
        bh=VNPfceYdTa2oGjCGoB+LsPxhV3yGArTJZyG+RrFRufQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pww8Y39uuXBt+nherJ04UzfjKkKoVoX1ftmIk/DTOku89PYtHhehnztGiUaJdFiue
         mN9XUYw/YmbE+2LPTh8IKLn5FMLiXuGL8zLMAJHIykb7D5Hlpj8xhwv3X56mYURFLz
         DEXSBlIEKZEWFsVB+fBLj9FVdGwMRPsznvcIuZksLt5qMFcByLqeZssDV+y36Gg6Mq
         sngvaV2MTRjzORzTOY3Uc/K70TnkrVBC5JQy4gc+6Dq/VW1OOnHcE0ceZtrigeOy1J
         dEFgLsYPpVtT0TSnxgKYJqDRGGEUDWhel8aicUaZ7eshHJzgdFFh5fHXoHki/y7Tid
         E6sw2GCm5gFhw==
Received: by mercury (Postfix, from userid 1000)
        id 69F821060FD4; Thu,  9 Mar 2023 23:50:43 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv1 09/11] power: supply: generic-adc-battery: simplify read_channel logic
Date:   Thu,  9 Mar 2023 23:50:39 +0100
Message-Id: <20230309225041.477440-10-sre@kernel.org>
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

Drop mostly useless gab_prop_to_chan() function by directly
supplying the correct enum value to read_channel().

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 31 ++++------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index fc6fcfda1ef2..7bc54566664f 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -86,31 +86,12 @@ static bool gab_charge_finished(struct gab *adc_bat)
 	return gpiod_get_value(adc_bat->charge_finished);
 }
 
-static enum gab_chan_type gab_prop_to_chan(enum power_supply_property psp)
-{
-	switch (psp) {
-	case POWER_SUPPLY_PROP_POWER_NOW:
-		return GAB_POWER;
-	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		return GAB_VOLTAGE;
-	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		return GAB_CURRENT;
-	default:
-		WARN_ON(1);
-		break;
-	}
-	return GAB_POWER;
-}
-
-static int read_channel(struct gab *adc_bat, enum power_supply_property psp,
+static int read_channel(struct gab *adc_bat, enum gab_chan_type channel,
 		int *result)
 {
 	int ret;
-	int chan_index;
 
-	chan_index = gab_prop_to_chan(psp);
-	ret = iio_read_channel_processed(adc_bat->channel[chan_index],
-			result);
+	ret = iio_read_channel_processed(adc_bat->channel[channel], result);
 	if (ret < 0)
 		pr_err("read channel error\n");
 	else
@@ -129,13 +110,11 @@ static int gab_get_property(struct power_supply *psy,
 		val->intval = adc_bat->status;
 		return 0;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		return read_channel(adc_bat, GAB_VOLTAGE, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		return read_channel(adc_bat, GAB_CURRENT, &val->intval);
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		ret = read_channel(adc_bat, psp, &result);
-		if (ret < 0)
-			goto err;
-		val->intval = result;
-		break;
+		return read_channel(adc_bat, GAB_POWER, &val->intval);
 	default:
 		return -EINVAL;
 	}
-- 
2.39.2

