Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2A664A909
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiLLU7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiLLU7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:59:03 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FC41836E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:59:02 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso4873819wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA+3KveRrg9ruS7yhZJv26q26XB54Sa3d5JjEMDw7bg=;
        b=XFBEiXZK2DmkoL5nXZrzn5zhqUKAjPF8ofrwYAzPTkxsQGc3mNpKAXj2Tu14S2Ajvn
         b0vlm2LEtCZHbbbyQvYMH5nIt0cdr83jUAXWMtDLHUMx2C/ZhlO9oVk7U+3qSEQ7b4v8
         t4VLGw2LXJjou8IkZU4FrUk0D4BLbFqcLytzqrd86F23hSHIZ1brdk6n5i+eWh/sR2CL
         fEr/CvRYQ1cWchNTvo//UhFmPFK88osBNM7eoYW9rfoOp7ZQMU0SlSr0M6JIqlt2p6od
         wE2CFrI0B4FxH5Ptc+u1NgN/LlmQZbSOhB/7dXPrOSvEJ0sNOj1NCjUwkvKBm6qz49O0
         v+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA+3KveRrg9ruS7yhZJv26q26XB54Sa3d5JjEMDw7bg=;
        b=Fx/5tStB7KsdTXjHN9Dq9QdXEfzkD7PGUlCyo1ENx5wuuRKAY4r9YxUaj2AMNCwhkn
         bOMCOkiGP4bpfgb9QvC/qW4numIQFYH0F6VOx7aPpF3r2M7xFVhA0PKdbU0DhAL6gBEj
         SSr0vnrHXgFhhKdNeo2W/nJpt8LIRlXrHTO1VaggDDDt+9UpyoBXDFLFR9pRY/w5wXst
         BNTg3vWm8tZfOGIjosE7aT/15XToXK5GbQIN/SBD+/fxjkj+l9VcfUhp31RAmlF9NM49
         pRSPWaTcBdMhu9akIOZ7C7crlw0eym0s/Qm5H8YNidmszcsyTVvgwTva7X7MEmppPQKT
         Xngg==
X-Gm-Message-State: ANoB5pmBb9qfUOmsHkypKYFOy+dmRkx2/m1LT5ZngAh6zShyeY9r1xbS
        40nkcznbfb/9Mq4IIi97OnWZjQ==
X-Google-Smtp-Source: AA0mqf77gK6MBlHNY2R1SfZaRZScpv+zMDwVIbji4lzVE6w/F0nq/SOFmWhu9J+nCBYY3vUtqothJw==
X-Received: by 2002:a05:600c:5112:b0:3cf:8ed7:712d with SMTP id o18-20020a05600c511200b003cf8ed7712dmr13408312wms.14.1670878742051;
        Mon, 12 Dec 2022 12:59:02 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10537201wma.4.2022.12.12.12.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:59:01 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
X-Google-Original-From: Daniel Lezcano <daniel.lezcano@kernel.org>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] thermal/drivers/intel: Use generic trip points for processor_thermal_device_pci
Date:   Mon, 12 Dec 2022 21:58:43 +0100
Message-Id: <20221212205843.3119407-6-daniel.lezcano@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221212205843.3119407-1-daniel.lezcano@kernel.org>
References: <20221212205843.3119407-1-daniel.lezcano@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 .../processor_thermal_device_pci.c            | 53 ++++++++-----------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index bf1b1cdfade4..c7d50862bf56 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -144,34 +144,6 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 	return 0;
 }
 
-static int sys_get_trip_temp(struct thermal_zone_device *tzd,
-			     int trip, int *temp)
-{
-	struct proc_thermal_pci *pci_info = tzd->devdata;
-	u32 _temp;
-
-	proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_THRES_0, &_temp);
-	if (!_temp) {
-		*temp = THERMAL_TEMP_INVALID;
-	} else {
-		int tjmax;
-
-		proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_TJMAX, &tjmax);
-		_temp = tjmax - _temp;
-		*temp = (unsigned long)_temp * 1000;
-	}
-
-	return 0;
-}
-
-static int sys_get_trip_type(struct thermal_zone_device *tzd, int trip,
-			      enum thermal_trip_type *type)
-{
-	*type = THERMAL_TRIP_PASSIVE;
-
-	return 0;
-}
-
 static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 {
 	struct proc_thermal_pci *pci_info = tzd->devdata;
@@ -200,10 +172,26 @@ static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp
 	return 0;
 }
 
+static int get_trip_temp(struct proc_thermal_pci *pci_info)
+{
+	int temp, tjmax;
+
+	proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_THRES_0, &temp);
+	if (!temp)
+		return THERMAL_TEMP_INVALID;
+
+	proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_TJMAX, &tjmax);
+	temp = (tjmax - temp) * 1000;
+
+	return temp;
+}
+
+static struct thermal_trip psv_trip = {
+	.type = THERMAL_TRIP_PASSIVE,
+};
+
 static struct thermal_zone_device_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
-	.get_trip_temp = sys_get_trip_temp,
-	.get_trip_type = sys_get_trip_type,
 	.set_trip_temp	= sys_set_trip_temp,
 };
 
@@ -251,7 +239,10 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 	if (ret)
 		goto err_ret_thermal;
 
-	pci_info->tzone = thermal_zone_device_register("TCPU_PCI", 1, 1, pci_info,
+	psv_trip.temperature = get_trip_temp(pci_info);
+	
+	pci_info->tzone = thermal_zone_device_register_with_trips("TCPU_PCI", &psv_trip,
+							1, 1, pci_info,
 							&tzone_ops,
 							&tzone_params, 0, 0);
 	if (IS_ERR(pci_info->tzone)) {
-- 
2.34.1

