Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB6F68DC11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjBGOuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjBGOuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:50:00 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E218D7;
        Tue,  7 Feb 2023 06:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AMCBklPpZiJm6G+yI87fmT6RWZwGjjZhJUPUbbl1SrM=; b=r6xXnZyXYevGlxKGGwgcZW/CJm
        ezl5C4pcwNrZuiifVl2gaIqYeXSDcSZJahz0ebZT4gOAJr0HiHo4/8EEBGrbWEuEGiwtqBbGNoItk
        QSVbiWh2lOfajfyv6C910kc14wBP4cfsuotI4CBbK/d4ThNGzESE94rSLTVHGETgs9gwxk9+4j54o
        cVXAjUt+sDkluLQ1T3zzc03hkj3xxKYAa8s8cte0TlLaRuZC5oFc6f6/vTNG2nAUIVK3Ome/Eq3AX
        Gi7qeNpMCjLp8ZJPov0Tpbmu988nGveCOPhs0fs17rnKudOvwVW24SBm0Q9LPb8oiIXikUSOZUOZc
        oSjLMn3w==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1pPOSV-002qTL-L6; Tue, 07 Feb 2023 15:56:31 +0200
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Srikar Srimath Tirumala <srikars@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Timo Alho <talho@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thermal: tegra-bpmp: Handle offline zones
Date:   Tue,  7 Feb 2023 15:56:08 +0200
Message-Id: <20230207135610.3100865-1-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Thermal zones located in power domains may not be accessible when
the domain is powergated. In this situation, reading the temperature
will return -BPMP_EFAULT and the temperature is considered to be
-256C for calculating trips.

For smooth operation, for offline zones, return -EAGAIN when reading
the temperature and allow registration of zones even if they are
offline during probe.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/thermal/tegra/tegra-bpmp-thermal.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
index c76e1ea62c8a..628b18818ae9 100644
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
 
@@ -257,7 +259,12 @@ static int tegra_bpmp_thermal_probe(struct platform_device *pdev)
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
2.39.0

