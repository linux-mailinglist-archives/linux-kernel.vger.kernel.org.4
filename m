Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AC56E0CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjDMLrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjDMLrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:47:02 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189AA9EDE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:46:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s12so5460239wrb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681386416; x=1683978416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPfklvntaSAZNSstWZb9c9xIuh7wy5gv7laC1WOc6HM=;
        b=mDbWDIMrs80Dg1X3n8qgHhFGUOe6N65/cxnaPkXu8L/u0v2gXFy4o5AYBOPULELYrf
         EIiwVZSyOUpakBCyW+PfJfDJRoIrIL2F6ljEw7xeELo5D7NHqckJy5HFn3qcalkjGpwz
         sXwV6Wrx03D6MMqcJyOE4kpFdXoIv55w1u0+MmI3TOfc6Fz1DgDs6HLtH9D5LWy24M/M
         iPRCZdLZx0SW20t1P+QRyt3eMRDLMxcnNk6s8lzavrgwyTWeFgrC1R1kdK6WIsB9pY2z
         ro/Opp0IWV4twEI73qiVgQOCbcht/Rv0tykmsjSP8GlMz691Wf6L//VRJO0+pJfrysgB
         rXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681386416; x=1683978416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPfklvntaSAZNSstWZb9c9xIuh7wy5gv7laC1WOc6HM=;
        b=P3Luvda/f8LgulqoLjugyK8O/RDOlTS8Aneo1arhANQiTeQPsfEDCjFAraxvQN7JV7
         ZuIzKd2zgFbcPM59AeELOmtDHz3FAIIWzZf+Bpz218eJXcQSpYAclrMUktJ81jHxXNfE
         hV0dPAy3/rvtD4xbcfk94BoHIBbsdfN1rixqYPELjwM9/J56ou5oVj/3ga9r1YM8D7mN
         xP3ZvyaVi1s0P+Ha03E7CqgZwokLYQENDH1J++MwPIi4Wvzhs27EcymNdmv07KEU39Gy
         taV6ajIT3YutnxYmJLGqa3lTNB349Onq1YZYodAVFCEOVOMsNEwjhio08edobB4CuYoF
         FV+A==
X-Gm-Message-State: AAQBX9dFh417rsicy3284K3a0fgzcek9OYBT6pZtXsDDdzj4IyOKFvPH
        jpIorM+IIrBKCy8UW/n7ecsQ7w==
X-Google-Smtp-Source: AKy350YoZHt4D4EMrgZOQ9wXahuXlD/QN0ullKssM3+oVI64zUdHVMOgcxKjDjSNsfBySge+BjF4yw==
X-Received: by 2002:adf:dc45:0:b0:2f6:44fb:a7f2 with SMTP id m5-20020adfdc45000000b002f644fba7f2mr625230wrj.24.1681386416496;
        Thu, 13 Apr 2023 04:46:56 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6418:c878:b0e:d11b])
        by smtp.gmail.com with ESMTPSA id iz11-20020a05600c554b00b003f09aaf547asm6730590wmb.1.2023.04.13.04.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:46:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Sujith Thomas <sujith.thomas@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v3 4/6] thermal/drivers/menlow: Use thermal_zone_device()
Date:   Thu, 13 Apr 2023 13:46:45 +0200
Message-Id: <20230413114647.3878792-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
References: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to get the device associated with the thermal zone, let's use
the wrapper thermal_zone_device() instead of accessing directly the
content of the thermal zone device structure.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/intel_menlow.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
index 5a6ad0552311..d720add918ff 100644
--- a/drivers/thermal/intel/intel_menlow.c
+++ b/drivers/thermal/intel/intel_menlow.c
@@ -422,7 +422,8 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 
 	result = intel_menlow_add_one_attribute("aux0", 0644,
 						aux0_show, aux0_store,
-						&thermal->device, handle);
+						thermal_zone_device(thermal),
+						handle);
 	if (result)
 		return AE_ERROR;
 
@@ -436,7 +437,8 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 
 	result = intel_menlow_add_one_attribute("aux1", 0644,
 						aux1_show, aux1_store,
-						&thermal->device, handle);
+						thermal_zone_device(thermal),
+						handle);
 	if (result) {
 		intel_menlow_unregister_sensor();
 		return AE_ERROR;
@@ -449,7 +451,8 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 
 	result = intel_menlow_add_one_attribute("bios_enabled", 0444,
 						bios_enabled_show, NULL,
-						&thermal->device, handle);
+						thermal_zone_device(thermal),
+						handle);
 	if (result) {
 		intel_menlow_unregister_sensor();
 		return AE_ERROR;
-- 
2.34.1

