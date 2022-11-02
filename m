Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE0F616617
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiKBP1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiKBP1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:27:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFF713E2B;
        Wed,  2 Nov 2022 08:27:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49386B8233C;
        Wed,  2 Nov 2022 15:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB6AC433D6;
        Wed,  2 Nov 2022 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667402855;
        bh=hUMH3kogeaEGr2FmRDxDjl277jnXJkiytyvOR+dvAgo=;
        h=From:To:Cc:Subject:Date:From;
        b=QcmfDof65Dj/WWk3IHoJ+u78L27TQc6+kJIR5G0PrG2kohGJhF3rBnI9wHS7VHgHK
         N8HiNvWQ/13NR5v/RJd2qaJ7E/iFNUEXmZN/AYEwQnSDGaPsvq44WdwfAz+TJAd8sf
         KX+ik7vapmvV5cbtkkIP6own963IhU7OMU2ozEMr6+PSTH+WdIVwYm4nhgWe2w+oK9
         lEM420OrJzOdyrl04JrCEleFEZOOdxwzSKac2MrAc9VF5ifIb3nKfEU1YrVlwRdj5q
         lsczXwErPnDVLizIrrYwe8Fg2osMLMg/fKZwjkejOAHkkEIMmOfJwRz897pHFwYYHG
         nar8nxzSdfl/w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oqFeB-0000C8-8M; Wed, 02 Nov 2022 16:27:19 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] thermal: qcom-spmi-adc-tm5: suppress probe-deferral error message
Date:   Wed,  2 Nov 2022 16:26:30 +0100
Message-Id: <20221102152630.696-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers should not be logging errors on probe deferral. Switch to using
dev_err_probe() to log failures when parsing the devicetree to avoid
errors like:

	qcom-spmi-adc-tm5 c440000.spmi:pmic@0:adc-tm@3400: get dt data failed: -517

when a channel is not yet available.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index a3310bf061cb..c70615d2d771 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -1031,10 +1031,8 @@ static int adc_tm5_probe(struct platform_device *pdev)
 		return irq;
 
 	ret = adc_tm5_get_dt_data(adc_tm, node);
-	if (ret) {
-		dev_err(dev, "get dt data failed: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "get dt data failed\n");
 
 	ret = adc_tm->data->init(adc_tm);
 	if (ret) {
-- 
2.37.3

