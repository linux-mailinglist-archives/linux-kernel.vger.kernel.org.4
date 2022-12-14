Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BAE64CB05
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbiLNNTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbiLNNS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:18:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53EAEE16;
        Wed, 14 Dec 2022 05:18:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 989F0B818B1;
        Wed, 14 Dec 2022 13:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BDEC433D2;
        Wed, 14 Dec 2022 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671023934;
        bh=I3NjFkga/P0GdNEJyAvlKrNR4+s/YWzEm5lbyRY0s9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2WaLz9uLD0YeDJNA+Ip5rqhGSXG1u8qeishyJFdMYLR6Q4x2qHmyPIxxxb5STvGM
         A/G5AzxETsvPhBcetsWvZUtJipLXsjwDoDXwif3Wi1NdluMHisdWXhaROrgnmVs5eV
         XB+913GHKWDIleY8/bmovAaooXU5CJk+5jxkG5EewY6aaaF4Kj1t8DzP8MzeoHnpxh
         Z6NzORvKUPLloBA4ok1WE85k7cJZWuR9mD/2FAakMLTfbTGaCc08HkNIPhxAFvdatL
         cxbqlyACrKBkyTZBicZB6GTYFHuLEAP5mA/ccsZXdtdB8lT1vjB50P3vCOj5Q221nb
         qY++E7gwzKEoA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p5RfO-0000gK-Hc; Wed, 14 Dec 2022 14:19:22 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/4] thermal/drivers/exynos: fix set_trip_temp() deadlock
Date:   Wed, 14 Dec 2022 14:16:15 +0100
Message-Id: <20221214131617.2447-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221214131617.2447-1-johan+linaro@kernel.org>
References: <20221214131617.2447-1-johan+linaro@kernel.org>
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

The set_trip_temp() callback is used when changing the trip temperature
through sysfs. As it is called with the thermal-zone-device lock held
it must not use thermal_zone_get_trip() directly or it will deadlock.

Fixes: 169865e317f2 ("thermal/drivers/exynos: Use generic thermal_zone_get_trip() function")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 37465af59262..cf9028f80415 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -354,7 +354,7 @@ static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
 	struct thermal_trip trip;
 	u8 ref, th_code;
 
-	if (thermal_zone_get_trip(data->tzd, 0, &trip))
+	if (__thermal_zone_get_trip(data->tzd, 0, &trip))
 		return;
 
 	ref = trip.temperature / MCELSIUS;
-- 
2.37.4

