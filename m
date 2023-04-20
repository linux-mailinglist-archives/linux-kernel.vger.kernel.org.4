Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09A46E8622
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjDTACR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjDTACP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:02:15 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C363E4EDC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:02:14 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-172-149.tukw.qwest.net [174.21.172.149])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 861E491D;
        Wed, 19 Apr 2023 17:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1681948934;
        bh=F3AbR5w5jgDe9WKrNU74298opdwJ1RKaOJYN4wnr8UE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IGj04yVdGEWYNGnr8cpD5xvWusJflWifDmBEA/k+UTVwQPEVfbf7UwSUT1PoNDLu5
         Om11loNX64WFaR9mVkKeCHU563VJFyB0K0S5nZOZjjzzA2DJnH+k4lq66P4jeGm4O4
         /Ru2eNGa00c5b4YyDyw3Rto3XbtliPGs4nMXY+Eo=
Date:   Wed, 19 Apr 2023 17:02:13 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: userspace-consumer: Multiple regulators
Message-ID: <afdd0170-8b14-451f-96a7-2b5656fa0dd7@hatter.bewilderbeest.net>
References: <20230418145051.4192963-1-Naresh.Solanki@9elements.com>
 <20230418145051.4192963-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230418145051.4192963-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 07:50:51AM PDT, Naresh Solanki wrote:
>Use property regulator-supplies to determine all regulator
>supplies.
>This is useful in case of a connector having 2 or more supplies.
>Example: PCIe connector on mainboard can be powered by 12V & 3.3V
>suplies.
>
>Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>---
> drivers/regulator/userspace-consumer.c | 19 +++++++++++++++----
> 1 file changed, 15 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
>index 97f075ed68c9..0bb49547b926 100644
>--- a/drivers/regulator/userspace-consumer.c
>+++ b/drivers/regulator/userspace-consumer.c
>@@ -120,7 +120,10 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> 	struct regulator_userspace_consumer_data tmpdata;
> 	struct regulator_userspace_consumer_data *pdata;
> 	struct userspace_consumer_data *drvdata;
>-	int ret;
>+	struct device_node *np = pdev->dev.of_node;
>+	struct property *prop;
>+	const char *supply;
>+	int ret, count = 0;
>
> 	pdata = dev_get_platdata(&pdev->dev);
> 	if (!pdata) {
>@@ -131,11 +134,19 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> 		memset(pdata, 0, sizeof(*pdata));
>
> 		pdata->no_autoswitch = true;
>-		pdata->num_supplies = 1;
>-		pdata->supplies = devm_kzalloc(&pdev->dev, sizeof(*pdata->supplies), GFP_KERNEL);
>+		pdata->num_supplies = of_property_count_strings(np, "regulator-supplies");
>+		if (pdata->num_supplies < 0) {
>+			dev_err(&pdev->dev, "could not parse property regulator-supplies");
>+			return -EINVAL;
>+		}
>+		pdata->supplies = devm_kzalloc(&pdev->dev,
>+					       sizeof(*pdata->supplies) * pdata->num_supplies,
>+					       GFP_KERNEL);

AFAICT this doesn't appear to implement the "vout" default specified in 
the dt-binding patch?

Also, since the core of the userspace-consumer driver itself already 
supports multiple regulators, it might be nice for the subject line to 
mention DT supplies or something a bit more specifically.

> 		if (!pdata->supplies)
> 			return -ENOMEM;
>-		pdata->supplies[0].supply = "vout";
>+
>+		of_property_for_each_string(np, "regulator-supplies", prop, supply)
>+			pdata->supplies[count++].supply = supply;
> 	}
>
> 	if (pdata->num_supplies < 1) {
>-- 
>2.39.1
>
>
