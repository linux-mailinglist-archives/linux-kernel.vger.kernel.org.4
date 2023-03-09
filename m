Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECEF6B3160
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjCIWuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjCIWuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:50:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31741F209C;
        Thu,  9 Mar 2023 14:50:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C294C61D12;
        Thu,  9 Mar 2023 22:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2380C433EF;
        Thu,  9 Mar 2023 22:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678402246;
        bh=YniPoXTs7rUu0i27ecAmQDdt91YnlzI00Xc0ywnf1UY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wx0vjHLpV930/MkCtPtQ2SgZ7mFaMJppT5NIg6aH0RuEd/E2/6rmJi2gRAft8DmGo
         52cTBqBf6v3q90PuhM5u07rX0hebzZVuv0Xr6v+MLAcPDyGVN475y0sOkbMXih1Q/e
         H4JUTiCXgum/1E8cYKIP/DN0roctGIy5eY33yjdEfi+nqTzJPrM3V3C+3BBOcv4SE2
         bGagRoMkMru3aIP97E1f0Rf6E7l6QMe8lqtaRy0RgdYZgDQXEpFxaiubJ6UolFU3WK
         NTnFnlerv6tknt2kdfdqclW81rsiyuqOYOI/QXzAXeREtgDn8yh8g0ojei3LKRJ99/
         j+jBXWJTjm8pQ==
Received: by mercury (Postfix, from userid 1000)
        id 631D710609CD; Thu,  9 Mar 2023 23:50:43 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv1 04/11] power: supply: generic-adc-battery: fix unit scaling
Date:   Thu,  9 Mar 2023 23:50:34 +0100
Message-Id: <20230309225041.477440-5-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309225041.477440-1-sre@kernel.org>
References: <20230309225041.477440-1-sre@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

power-supply properties are reported in µV, µA and µW.
The IIO API provides mV, mA, mW, so the values need to
be multiplied by 1000.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 917bd2a6cc52..535972a332b3 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -136,6 +136,9 @@ static int read_channel(struct gab *adc_bat, enum power_supply_property psp,
 			result);
 	if (ret < 0)
 		pr_err("read channel error\n");
+	else
+		*result *= 1000;
+
 	return ret;
 }
 
-- 
2.39.2

