Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BDC64279A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiLELf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiLELfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:35:53 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B13C1A06B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:35:52 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z92so15393853ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 03:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9b59iFvofQpoKBEaYeQhFybU9NmyF7WlZBKIJce18E=;
        b=hbs+USPpFBZKRF/tug7MDLQSmfqVJbidEvpUgMVjKTYzJI+P7XcwTDngm7SahaSO0K
         iuQb3QeZi1ZOQPVCY4RNw2HabP89aKsWp5YylYgKiSrrYEIUANVuJ3lZdeFoepuKUPAl
         rpugTdctPHudbeVKnKvIfDTxgiSF309QLeAWd43944UlSOYsq+T/pURyZe04rnlZX4KZ
         NrevYRSFEvJM7S+Tr0Co7+XdUnidwDMtNCjN+bCG3Flys7Hrr109QkgnofeWDwt1a094
         G6hm8n3dOEMVzwnU08SjqU/faHT/oKuqyFe1FDAg5BeAFWN6hHmUt+uZtvqB1XFadCk6
         oBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9b59iFvofQpoKBEaYeQhFybU9NmyF7WlZBKIJce18E=;
        b=XkMSn3SwMkfjKUNvgSyRbLnwhqIG2arl1PJiZa7GoeAumgpzVzQrUQfHJ3towP0Qg0
         U02CMIAvPCn+HEzIKYqpTst/pkb9WhmBGTs3/0LheHU9odfeOIur32mXMuPHc/lAwr2h
         5dwmzwGMuwILOyjsobufRV6mRT9nzmgPyjWwAq7VRg3qe2aOz+d/37N9KYzcHkc0mZXL
         EyN6/26NjdOnVj0q2/cO2N6UoRF5UfTC3FY/9P5sgfPYKinX0j9XGPgiHsFMv3HmpNk/
         jpVs4ZVOclXMHP9EXOpJ7QjiduRZoQAxSkqY/rZBkqkVjttLPnqmeMkNg0fClPdlmLeK
         M1lw==
X-Gm-Message-State: ANoB5pmf81BK4t3e8YDhNhaEi5vOUV9MB7Jl5AhHUHatmt4sFASyWaf8
        2ojdk4GCn0db4W/ugatGW86kyQ==
X-Google-Smtp-Source: AA0mqf4XBZBNLqDHPdHU/DC0N6f8lDzA5/GvMqXPm4ghYzrxzndI2QiAGJwitj6kTYfdthLLBTHHCg==
X-Received: by 2002:a05:6402:449b:b0:459:2b41:3922 with SMTP id er27-20020a056402449b00b004592b413922mr4788067edb.160.1670240150767;
        Mon, 05 Dec 2022 03:35:50 -0800 (PST)
Received: from fedora.. ([188.252.220.250])
        by smtp.googlemail.com with ESMTPSA id q26-20020a170906389a00b007bdc2de90e6sm6164189ejd.42.2022.12.05.03.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 03:35:50 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] clk: qcom: gcc-ipq4019: switch to devm_clk_notifier_register
Date:   Mon,  5 Dec 2022 12:35:45 +0100
Message-Id: <20221205113545.575702-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using devres-managed version of clk_notifier_register(). This
allows us to drop driver's remove() callback.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/clk/qcom/gcc-ipq4019.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq4019.c b/drivers/clk/qcom/gcc-ipq4019.c
index 9102150d144a..e4cb9e240a72 100644
--- a/drivers/clk/qcom/gcc-ipq4019.c
+++ b/drivers/clk/qcom/gcc-ipq4019.c
@@ -1795,19 +1795,12 @@ static int gcc_ipq4019_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	return clk_notifier_register(apps_clk_src.clkr.hw.clk,
-				     &gcc_ipq4019_cpu_clk_notifier);
-}
-
-static int gcc_ipq4019_remove(struct platform_device *pdev)
-{
-	return clk_notifier_unregister(apps_clk_src.clkr.hw.clk,
-				       &gcc_ipq4019_cpu_clk_notifier);
+	return devm_clk_notifier_register(&pdev->dev, apps_clk_src.clkr.hw.clk,
+					  &gcc_ipq4019_cpu_clk_notifier);
 }
 
 static struct platform_driver gcc_ipq4019_driver = {
 	.probe		= gcc_ipq4019_probe,
-	.remove		= gcc_ipq4019_remove,
 	.driver		= {
 		.name	= "qcom,gcc-ipq4019",
 		.of_match_table = gcc_ipq4019_match_table,
-- 
2.38.1

