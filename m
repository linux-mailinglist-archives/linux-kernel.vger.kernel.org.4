Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635FB64CB08
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbiLNNTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbiLNNS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:18:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACBA1B1F0;
        Wed, 14 Dec 2022 05:18:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6CC9B818B4;
        Wed, 14 Dec 2022 13:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F83C43396;
        Wed, 14 Dec 2022 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671023934;
        bh=UCFo0ATECrapHBfgYnwVb9qzMIvCn8cEKis++tPi5aQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mw6CY3ggr5HWgJSWziERMPdFzl7QJU9BkCjeghJp4NfImECloE5Dvq9Me4wyTK+RU
         YJCd72fDDShia2IrQj5qG374opeBTWoL5Z+Ohc3gMGxcZVoV46n2QrkO6Wzp2zlwWX
         EFTKIYIjbrVhNDAB+TWY/IdUF64KIcAQwOV4YJWUvq5nRs95QyzW//bnQlDeg57hmt
         cza83BCXlOTLYq89wqaFuYdToOLxyYfI49mZxrq2bZn4vD4khDtv84ROLimgDdfo0G
         ZMf9uE4v/pFJMx7s94q8Z16qJKtaqXMprQ53RSIlIEMibLdp1p1L451elxdLiKpZEO
         BXHhj5DW51Deg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p5RfO-0000gI-EO; Wed, 14 Dec 2022 14:19:22 +0100
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
Subject: [PATCH 1/4] thermal/drivers/qcom: fix set_trip_temp() deadlock
Date:   Wed, 14 Dec 2022 14:16:14 +0100
Message-Id: <20221214131617.2447-2-johan+linaro@kernel.org>
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

Fixes: 78c3e2429be8 ("thermal/drivers/qcom: Use generic thermal_zone_get_trip() function")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 2 +-
 drivers/thermal/thermal_core.c              | 1 +
 include/linux/thermal.h                     | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 58055a7abaf6..bfaec74f13b2 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -270,7 +270,7 @@ static int qpnp_tm_set_trip_temp(struct thermal_zone_device *tz, int trip_id, in
 	struct thermal_trip trip;
 	int ret;
 
-	ret = thermal_zone_get_trip(chip->tz_dev, trip_id, &trip);
+	ret = __thermal_zone_get_trip(chip->tz_dev, trip_id, &trip);
 	if (ret)
 		return ret;
 
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c24c9efcd175..d9a3d9566d73 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1214,6 +1214,7 @@ int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 
 	return tz->ops->get_trip_type(tz, trip_id, &trip->type);
 }
+EXPORT_SYMBOL_GPL(__thermal_zone_get_trip);
 
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e2797f314d99..30353e4b1424 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -334,6 +334,8 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 }
 #endif
 
+int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
+			    struct thermal_trip *trip);
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip);
 
-- 
2.37.4

