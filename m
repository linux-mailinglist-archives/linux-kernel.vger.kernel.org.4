Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC09567268C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjARSRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjARSQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:16:36 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772C15A363
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:16:35 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l8so8223750wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxJbiMFPybMH7ivLVqW5OITYDgd53EwEIHVHwObfw3I=;
        b=qyB/LtnhmSxHJrvWocFFevyKHuFEjEQiE5y2D3UO9aNo+RKqMQGFsOuP0uOVdwtO57
         UA9A7H9roO1E3q6v24nvjOwhUhm2is6X+Yck2oDLefakLn+jbna/6PE8XcS1+Wkw+cOO
         y1iZELhycvgDBXlU+lNuFTkXwmDjIqm+sMVBrYBjLyeizTjywTR3WJLK56i+NBLLBIfl
         PTk6vjNuVHniqv08Y87dd/6pXY/P67dmzqtILvy0vpXjvfpPTBd4QlruumaAq4opM3Xl
         fGu+pwWVh6CxYjk4JUc75b8ATSxu34a3djWnWmgAbDBuma/dsX8MaYSnUd+eBQbpGEb3
         it4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxJbiMFPybMH7ivLVqW5OITYDgd53EwEIHVHwObfw3I=;
        b=uR4PnOLfvisuFyyI/ReUOGz6QybHMMsRDZhMeB/EiJXpxHejKznNGcS474/3xfTLxP
         rjOzwaHuGONBVLs89Ixyrx4EMnzrQFnSpfrmMVytpCn8azxCaYIaJvNJQK2rdD/f5jKI
         aOCaEquMnjutOy/tBFe5DCgX22+sQBo8njpLASQ06oFTgNU0vyxoLFCrd3loau1ES9rx
         bzH7ij3wMIZ19RS9bCk6iAbMoRfbs6QcGiof9LlFlyJtQ70xBt8pT7RhFjFlrTeN+okc
         csKZ7Dtp29qLXIv1vRFli8nyTLOxwBJ2q0R3kF9SMQOIbSDlbBQZPImcg95rYLgKFkwN
         AxEg==
X-Gm-Message-State: AFqh2kp8gwiP2Ejoiw6AuJ9tNqkPvuNz8xazJ4x8F8FK5sZXNjHcl0D9
        ohK51zmbLy7XQAIANhUXV9c4TQ==
X-Google-Smtp-Source: AMrXdXv2E22gh+vD4W7TR2GDM8bhtQIDNJcqhSCfxEQ1D83Cs6NJkinjjEX/ewrnDcha4kpIY233wQ==
X-Received: by 2002:a1c:cc11:0:b0:3da:1d52:26b5 with SMTP id h17-20020a1ccc11000000b003da1d5226b5mr16204270wmb.14.1674065793891;
        Wed, 18 Jan 2023 10:16:33 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id c10-20020a05600c0a4a00b003db12112fcfsm2817414wmq.4.2023.01.18.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:16:33 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Amit Kucheria <amitk@kernel.org>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>
Subject: [PATCH 2/3] thermal/drivers/intel: Use generic trip points for processor_thermal_device_pci
Date:   Wed, 18 Jan 2023 19:16:20 +0100
Message-Id: <20230118181622.33335-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118181622.33335-1-daniel.lezcano@linaro.org>
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
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

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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

