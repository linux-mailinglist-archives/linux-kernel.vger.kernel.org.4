Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AE96BA2EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjCNW4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjCNWzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:55:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9523E60D;
        Tue, 14 Mar 2023 15:55:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2255B81BFD;
        Tue, 14 Mar 2023 22:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71978C4339B;
        Tue, 14 Mar 2023 22:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678834542;
        bh=yPzVoyb/Gfy3GbgXbS/xEPN0qDCVRKIVaWj3y97xOno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbkrJl8Um/67y1V8O9IC2TYKYe9FNx3Etd6CgWjefe353hRY6L6/jx/ng9EIre2Mo
         d/kjROV1i/Z1PRej2poOfRwXOuN0MhSWvtAzfAPYC9/74dplgETKRveYRygyuYo5kQ
         ZliBzSJLNn3T3HBsCwW0IBCRW9OXgS+Tw8kyJp1N83HPOW0lsC7jOJbzluBqefZGBW
         NsNid6xSPJxWAeHHBenfWjUiti99lkD5NomB9UZRqHqBa0QNgM7w7UHp3VoWXamuhu
         weIQ04dR6YdTDK1lS3IbbGr0KbE19wehMgrmH/ohGsjSFBadiXtZGejrd+62J36A66
         q/vLvFzkMnEOQ==
Received: by mercury (Postfix, from userid 1000)
        id DFE5210620AA; Tue, 14 Mar 2023 23:55:36 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv2 07/12] power: supply: generic-adc-battery: drop memory alloc error message
Date:   Tue, 14 Mar 2023 23:55:30 +0100
Message-Id: <20230314225535.1321736-8-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314225535.1321736-1-sre@kernel.org>
References: <20230314225535.1321736-1-sre@kernel.org>
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

Error printing happens automatically for memory allocation problems.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index d07eeb7d46d3..771e5cfc49c3 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -243,10 +243,8 @@ static int gab_probe(struct platform_device *pdev)
 	bool any = false;
 
 	adc_bat = devm_kzalloc(&pdev->dev, sizeof(*adc_bat), GFP_KERNEL);
-	if (!adc_bat) {
-		dev_err(&pdev->dev, "failed to allocate memory\n");
+	if (!adc_bat)
 		return -ENOMEM;
-	}
 
 	psy_cfg.drv_data = adc_bat;
 	psy_desc = &adc_bat->psy_desc;
-- 
2.39.2

