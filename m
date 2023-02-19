Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9205C69C0D0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjBSOia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjBSOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:37:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D1011645
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:37:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c3so489434wrb.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzE7tCtv9nXhTqCLmkAtvvd9XPqHKuG/dItaNXtPrVU=;
        b=OpBiHvkSLr05x1vk9n2mt2wFV84toJJTTuvndMhdR3wBSnUjGBpzbVeiJKoDf7uBWE
         kERcmA/sV+u8Ftr8cOhpKfQNHIcCv/Zh5/CrLsp93UCQK6KJHlejtamPW/Y7SA9XENR7
         Bqq2lMyPu33A0fA4dxuKRI8S8o9zNiSmF2rGMhZIdUV2igOfr6kZAYudA6NdHZw1+lVx
         FAPUveDVijOr2Jc47zm9hUFfDw3d03p3LFDn+pA61gESR5L6a8VQ4qDzZHpDsMSyPL73
         uD0uO5aSVbciyy592CGyamIZ7xWEsDp+V7dfNrLiYxgXsEGeNHdWw8hQddvHe2wfCm4T
         4XsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzE7tCtv9nXhTqCLmkAtvvd9XPqHKuG/dItaNXtPrVU=;
        b=z1l3kLHfp5fuqoL+YB/KgMJ9njN5HcAtKMPHApgHkt7sxAERSE/6KtdGxFArJSvojK
         CPswPIBS1KFReNYVpO2HXTUs/7KTlk58kxwBPAhHeG2czzYqin2LeIv8D1vUnHSCa6cH
         wnZFXMtUEPyCwr0OoeIEWrTB88xYTPxYVDSiMrqpuZPld52zn4Wb+rGJVmmZgcqO1GXC
         3RgWAWbG9NsvtHC/IP0t3NwGiXSjc4A+ipADfY4NAoj22HiZwDHLWp5VOkFGB0IlNRwn
         6MXv5PFueA8Dr7NRlAXDFfd89nCNsHA4DmTP+jFWKJmnpS6gG+hSCdTouDDKLnKiNC/Q
         Ee4g==
X-Gm-Message-State: AO0yUKX9qnaxpFlh5faFQhlzXbl73wnBycMAT3MqAxW2TNONJSPjScHS
        k804E7R6dRWa1phRbxxVCpe005c22btWX+6B
X-Google-Smtp-Source: AK7set9Xu4OAhco6//3XMOMWPsgze7O9LMLV6Zi0gxIz1V3EOVI2Imy0wZeqJKD3bkvngaxWR0FUEg==
X-Received: by 2002:adf:fbcf:0:b0:2c5:62c8:5f43 with SMTP id d15-20020adffbcf000000b002c562c85f43mr1816465wrs.29.1676817464864;
        Sun, 19 Feb 2023 06:37:44 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6f43:b92:7670:463])
        by smtp.gmail.com with ESMTPSA id a18-20020adfe5d2000000b002be505ab59asm86176wrn.97.2023.02.19.06.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 06:37:44 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1 02/17] thermal/core: Show a debug message when get_temp() fails
Date:   Sun, 19 Feb 2023 15:36:42 +0100
Message-Id: <20230219143657.241542-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230219143657.241542-1-daniel.lezcano@linaro.org>
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The different thermal drivers are showing an error in case the
get_temp() fails. Actually no traces should be displayed in the
backend ops but in the call site of this ops.

Furthermore, the message is often a dev_dbg message where the
tz->device is used, thus using the internal of the structure from the
driver.

Show a debug message if the thermal_zone_get_temp() fails to read the
sensor temperature, so code showing the message is factored out and
the tz->device accesss is in the scope of the thermal core framework.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 0f648131b0b5..9558339f5633 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -107,6 +107,9 @@ int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 			*temp = tz->emul_temperature;
 	}
 
+	if (ret)
+		dev_dbg(&tz->device, "Failed to get temperature: %d\n", ret);
+	
 	return ret;
 }
 
-- 
2.34.1

