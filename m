Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD09B6D003F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjC3Jyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjC3Jye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:54:34 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC18B0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=W0nW0vQLM7G/2/2VIeK8J7D28U5u8Jc7f3i4je1IBPI=; b=J+tlZn+jVHSD//mSIQllBB2cQV
        uC95+Onna9Su0RG4BPi6Zv/0N4pET4/TZzYJkOyDpaj+lM7NKQD4FTn7/AGurFv1YdG0lye8AO247
        QqM8jChJLdKh3t929x+yc+ZlM04TlwxJnOb2H6JWZQBtXbBBFdUPBmc0iwfLZDO1FKOgTq35Oi38L
        mbkU8G/L6qpPC3BbO5Dl6gdPKQoN4JjQve8LB+VNDRcMs59lyzdlM8nkc7/WDbMA9nnz5veYg04ak
        60nSwD3cehekbqDfMw88sEMzWrDUuMq4ecxL47klPOUjjyY1FY9I9j48TYrjsS3f6lmunTSpnzxL9
        eVlu788g==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1phouA-0007Ze-AN; Thu, 30 Mar 2023 12:49:14 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] thermal: tegra-bpmp: Handle offline zones
Date:   Thu, 30 Mar 2023 12:49:04 +0300
Message-Id: <20230330094904.2589428-1-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Thermal zones located in power domains may not be accessible when
the domain is powergated. In this situation, reading the temperature
will return -BPMP_EFAULT. When evaluating trips, BPMP will internally
use -256C as the temperature for offline zones.

For smooth operation, for offline zones, return -EAGAIN when reading
the temperature and allow registration of zones even if they are
offline during probe.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v2:
* Adjusted commit message.
* Patch 2/2 dropped for now since it is more controversial,
  and this patch is more critical.

 drivers/thermal/tegra/tegra-bpmp-thermal.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
index f5fd4018f72f..4ffc3bb3bf35 100644
--- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
+++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
@@ -52,6 +52,8 @@ static int __tegra_bpmp_thermal_get_temp(struct tegra_bpmp_thermal_zone *zone,
 	err = tegra_bpmp_transfer(zone->tegra->bpmp, &msg);
 	if (err)
 		return err;
+	if (msg.rx.ret == -BPMP_EFAULT)
+		return -EAGAIN;
 	if (msg.rx.ret)
 		return -EINVAL;
 
@@ -259,7 +261,12 @@ static int tegra_bpmp_thermal_probe(struct platform_device *pdev)
 		zone->tegra = tegra;
 
 		err = __tegra_bpmp_thermal_get_temp(zone, &temp);
-		if (err < 0) {
+
+		/*
+		 * Sensors in powergated domains may temporarily fail to be read
+		 * (-EAGAIN), but will become accessible when the domain is powered on.
+		 */
+		if (err < 0 && err != -EAGAIN) {
 			devm_kfree(&pdev->dev, zone);
 			continue;
 		}
-- 
2.39.2

