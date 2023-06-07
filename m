Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0684725128
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 02:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbjFGAhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 20:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjFGAhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 20:37:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B8410F8;
        Tue,  6 Jun 2023 17:37:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A29CE631E0;
        Wed,  7 Jun 2023 00:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB85C433D2;
        Wed,  7 Jun 2023 00:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686098266;
        bh=Jj21BgI4T47Tjh7uvaUnsKqWs81Zaadmc3y9Tu/8suU=;
        h=From:To:Cc:Subject:Date:From;
        b=szFRy8r+UfdfgVaMTxwyKm+qeOV4f6Sj1dYhO0dVlJmCNpu816jkqpdZRvCtYC8M0
         scqqto4QwxkOEQgDK92ROrJ05loLtKeRa8YrDQ9NjTPdWzSTcyEsLF98WL1JUTEUtd
         cu3UlI0a4jsn4CFpqIR3GVbofD6MFBdl7MVxCVC0JB2JxeZtY+arOCOq+M2F9JZk/t
         VV71f0y34iZFWTcZd0PtxMPla3IbmkbJqKt8yAic9DLyeMSyll02fWHasC+BsLtZtm
         yKIe4ySCZFnL1LUf6tq8ODQ7ypxOi6+AK8MgsDEcFIt4/7y/+mu7uFEaKqSLTxE+tm
         hDTSiVhBileFg==
From:   Eduardo Valentin <evalenti@kernel.org>
To:     evalenti@kernel.org, eduval@amazon.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Date:   Tue,  6 Jun 2023 17:37:21 -0700
Message-Id: <20230607003721.834038-1-evalenti@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eduardo Valentin <eduval@amazon.com>

As the thermal zone caches the current and last temperature
value, the sysfs interface can use that instead of
forcing an actual update or read from the device.
This way, if multiple userspace requests are coming
in, we avoid storming the device with multiple reads
and potentially clogging the timing requirement
for the governors.

Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
Cc: linux-pm@vger.kernel.org (open list:THERMAL)
Cc: linux-kernel@vger.kernel.org (open list)

Signed-off-by: Eduardo Valentin <eduval@amazon.com>
---
 drivers/thermal/thermal_sysfs.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index b6daea2398da..a240c58d9e08 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -35,12 +35,23 @@ static ssize_t
 temp_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int temperature, ret;
-
-	ret = thermal_zone_get_temp(tz, &temperature);
+	int temperature;
 
-	if (ret)
-		return ret;
+	/*
+	 * don't force new update from external reads
+	 * This way we avoid messing up with time constraints.
+	 */
+	if (tz->mode == THERMAL_DEVICE_DISABLED) {
+		int r;
+
+		r = thermal_zone_get_temp(tz, &temperature); /* holds tz->lock*/
+		if (r)
+			return r;
+	} else {
+		mutex_lock(&tz->lock);
+		temperature = tz->temperature;
+		mutex_unlock(&tz->lock);
+	}
 
 	return sprintf(buf, "%d\n", temperature);
 }
-- 
2.34.1

