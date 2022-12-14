Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A675364CB07
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbiLNNTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238520AbiLNNTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:19:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12920209AC;
        Wed, 14 Dec 2022 05:18:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3B0DB818BA;
        Wed, 14 Dec 2022 13:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A14FC433EF;
        Wed, 14 Dec 2022 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671023934;
        bh=xwJ2F+HL8Yk0Fx3XqoMXtNfS5GIPd1gzxcsg5dDoon8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QP7v+ZzVI06/yPy1cj0gYDD7mG1of1hKuSt/w5bpOrTOsOETjgUEc6Dxsq65g4/hQ
         Fjy5ZqjxlEO4FPBy+HmWmxUARSuxIc328Fzp+FLLmftMf0i9OO7JDX0pfLb1AAELxO
         4F2oUr73dVKcnjM84Sm1+0uoO332iQyxBEjrQDzgOhOchxhbfaBaP0GiecxfOpt8U7
         2RgX4K0g69VvqkFaH3Oy4ffIl4AFigY7gl+xIltPIJbjXCwlSdgufiiDPMDhPmI97X
         cp5rZOCf/Bmf7NFqdGdEGrwTBsae1YJmG5SHuHSmoPTDEGuXLGZ97M7gAlRE+SBO+a
         iT520n6hJ8R2Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p5RfO-0000gO-Nm; Wed, 14 Dec 2022 14:19:22 +0100
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
Subject: [PATCH 4/4] thermal/drivers/qcom: fix lock inversion
Date:   Wed, 14 Dec 2022 14:16:17 +0100
Message-Id: <20221214131617.2447-5-johan+linaro@kernel.org>
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

The thermal-zone-device lock is held by core when setting trip points
and the driver takes its chip lock in the corresponding callback.

Fetching the thermal trip points using thermal_zone_get_trip() also
involves taking the thermal-zone-device lock, which means that the chip
lock can not be held when doing so.

Drop the chip lock temporarily during probe to avoid the lock inversion
that was detected by lockdep:

  ======================================================
  WARNING: possible circular locking dependency detected
  6.1.0-next-20221213 #122 Not tainted
  ------------------------------------------------------
  systemd-udevd/264 is trying to acquire lock:
  ffff741e444a0920 (&chip->lock){+.+.}-{3:3}, at: qpnp_tm_get_temp+0xb4/0x1b0 [qcom_spmi_temp_alarm]

  but task is already holding lock:
  ffff741e44341618 (&tz->lock){+.+.}-{3:3}, at: thermal_zone_device_update+0x2c/0x70

  which lock already depends on the new lock.

Fixes: 78c3e2429be8 ("thermal/drivers/qcom: Use generic thermal_zone_get_trip() function")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index bfaec74f13b2..e2429676d0d2 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -348,7 +348,12 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 	if (stage)
 		chip->temp = qpnp_tm_decode_temp(chip, stage);
 
+	mutex_unlock(&chip->lock);
+
 	crit_temp = qpnp_tm_get_critical_trip_temp(chip);
+
+	mutex_lock(&chip->lock);
+
 	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
 	if (ret < 0)
 		goto out;
-- 
2.37.4

