Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02C36B316B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjCIWv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjCIWvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:51:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C2DE6804;
        Thu,  9 Mar 2023 14:50:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EC1E61D1E;
        Thu,  9 Mar 2023 22:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B4AC4339B;
        Thu,  9 Mar 2023 22:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678402248;
        bh=pgooTjpmkH0T4+938WzlRJ0u+gHeFjR0k59+b8+puVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GsH0euTea8XbVDNJPjcjtoGVLcP+H6/i0ezskqym3D/VJOpYF99vba96il72ceyE7
         Z8f/89TntYNQpJtZfJT1QiQjQRLeJHJfCjC5vuHPK5DI2mBEFnvzMy/+llBBGuD0TJ
         qV74i74QGJpEgi31xRKY6+92kkCmrMf6onKOQZ9D44wzaA2ApmBCzzCzybXjVNCu4V
         XVGqKiRhM/0IH+7PbRqCoAQRLS5oNR9ZuFsCtP/WGSp8A+NOssZJzbmm6DSwl/2XPc
         pP/00G06EIo7gmR9lQjkg7k6U8LO8BURT91RDEKknFhDK3WEAxZXlrr5JtzHQXtL5K
         VA3ihawG6VHqQ==
Received: by mercury (Postfix, from userid 1000)
        id 6536310609DE; Thu,  9 Mar 2023 23:50:43 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv1 07/11] power: supply: generic-adc-battery: drop memory alloc error message
Date:   Thu,  9 Mar 2023 23:50:37 +0100
Message-Id: <20230309225041.477440-8-sre@kernel.org>
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

Error printing happens automatically for memory allocation problems.

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

