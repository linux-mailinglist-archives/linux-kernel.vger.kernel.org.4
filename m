Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B26F64CB09
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiLNNTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbiLNNS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:18:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003D2205CD;
        Wed, 14 Dec 2022 05:18:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3F66B818B6;
        Wed, 14 Dec 2022 13:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501A3C433AA;
        Wed, 14 Dec 2022 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671023934;
        bh=pUvEkaZ93TrgdiMPgbWAhQQFmdmtaGqKxLqih4iKcMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4tNaPYhQ+umQ4W+AIlhusLg33i3tL1Gzd+nFpK3a5GHUosvVNTKfE0eJCahr7dE1
         CURwKN+RXbUdavJnJhKY3PDISjPRiiwBvEpmC2SFEkdO+6yS2GPi9UCXXjWnH590uR
         MGGSLN2uIftEE8nVGaZeyydpxpUIDRddNRdmaq59jH63UYufTlNQ0p5u+CwbLxFpKd
         /Pg7Ba/xUdWIxSBuUvLKeA2+qWEx96ZYaEXrvsikDfaiF82URpzZT7F07RVImf90Ay
         sDfZj/sR8i1I4Wy3CVA+3GVBZXe6ybbozYBy8+sCz2CGT4albApv6ipWn2qJZJBvz4
         jksoqniLJGFFQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p5RfO-0000gM-KX; Wed, 14 Dec 2022 14:19:22 +0100
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
Subject: [PATCH 3/4] thermal/drivers/tegra: fix set_trip_temp() deadlock
Date:   Wed, 14 Dec 2022 14:16:16 +0100
Message-Id: <20221214131617.2447-4-johan+linaro@kernel.org>
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

Fixes: 56d7b397cc29 ("thermal/drivers/tegra: Use generic thermal_zone_get_trip() function")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/thermal/tegra/soctherm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 4203e74e2f79..220873298d77 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -594,7 +594,7 @@ static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip
 	if (!tz)
 		return -EINVAL;
 
-	ret = thermal_zone_get_trip(tz, trip_id, &trip);
+	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
 	if (ret)
 		return ret;
 
-- 
2.37.4

