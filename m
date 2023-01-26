Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A795267CE1C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjAZO20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjAZO2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:28:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E16274A1;
        Thu, 26 Jan 2023 06:28:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34282B81DF0;
        Thu, 26 Jan 2023 14:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF04FC433D2;
        Thu, 26 Jan 2023 14:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674743277;
        bh=fkNCWGzpN9noJHpG5tIoZbVO7VTTQDfyVLycvpHMucI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnoJ2SivmQHSNSxLclMx3tGin0IOcWk+i8F5yh3Im0HS4601HW5zys6GhNdTcjU0c
         nltddIK3DgM8O9SF7tGgODjpje4V/rLiISSSzYvYH1I0tbR1Z3vP4ZrCfIjIzhH6JO
         R00h9P+HBHYdIYl0jv4vJVaD/Sc9D6HuGjpMWelFw6QFSEqVGogmhLNl3IAt/Z6BC7
         6vNvI2hahYP104gb1urzQyY+YbrBBI4gj9OubbxJjiMCPIaTjmmWs2GYLNqgfYq7ej
         5/JZgFX98ODk/gmjo+1T2HRRGv1NSEzLkFCFINLAsDDBnDdK+avbfjrSapwwPF8wL6
         91HkiS8vS0NmQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL39c-0006iO-Cy; Thu, 26 Jan 2023 15:23:04 +0100
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
Subject: [PATCH 05/24] rtc: pm8xxx: return IRQ_NONE on errors
Date:   Thu, 26 Jan 2023 15:20:38 +0100
Message-Id: <20230126142057.25715-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126142057.25715-1-johan+linaro@kernel.org>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
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

