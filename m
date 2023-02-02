Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DD0688387
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjBBP4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjBBPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:54:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86A9611F9;
        Thu,  2 Feb 2023 07:54:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41B3361BE6;
        Thu,  2 Feb 2023 15:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACECC433A1;
        Thu,  2 Feb 2023 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353284;
        bh=fkNCWGzpN9noJHpG5tIoZbVO7VTTQDfyVLycvpHMucI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A/9GOdDw1iTm2CaCJPoDPl/5jKbAgyt+x3BXl5kIREc3nUo9Zfz1roVZr9Yhvt4C+
         xFPwuM6Wn12Bgn0oIJGgnVZqcsiIFIm1Tpw3dZuKN5bijbtvCPsFwTc/qJi6rEy0WS
         XdtmPzZl8zciaq1QW3vJ0h4R02ysGkJE8kT+AZmRgHH2/c0yiIEO5PRMwt+CxVvrrV
         jBWzzkH5gLVAEsGf/Uj6qKY/MSVRiv2iJZxCxuLw3XVotiah+O78hTZG1I0dqxpRyG
         jIuE2k53UWyELDY4jNsC0AMrhtxMN02+Hrx0KRxcvwnG+vS/ZEB+YdmC6kzrFk6P0G
         6aa27RShNi+sQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNbvY-0001ls-V6; Thu, 02 Feb 2023 16:55:08 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 05/22] rtc: pm8xxx: return IRQ_NONE on errors
Date:   Thu,  2 Feb 2023 16:54:31 +0100
Message-Id: <20230202155448.6715-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202155448.6715-1-johan+linaro@kernel.org>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
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

In the unlikely event that disabling the alarm and clearing the status
ever fails, return IRQ_NONE instead of IRQ_HANDLED.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/rtc/rtc-pm8xxx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 053a04f74a91..dc7e659cbb2a 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -291,14 +291,14 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
 	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl,
 				regs->alarm_en, 0);
 	if (rc)
-		goto out;
+		return IRQ_NONE;
 
 	/* Clear RTC alarm register */
 	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl2,
 				PM8xxx_RTC_ALARM_CLEAR, 0);
 	if (rc)
-		goto out;
-out:
+		return IRQ_NONE;
+
 	return IRQ_HANDLED;
 }
 
-- 
2.39.1

