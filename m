Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BE36E755B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjDSIe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjDSIeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:34:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FED448A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:33:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f09b9ac51dso85857155e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681893234; x=1684485234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iK+POleBc/byLDVWHTc7+1oZoRzGsPyfNa6vjT15MA=;
        b=hDC/3pV2pCYg9oQ01G9q6YLUoP6cci4sRaJx3Sm5aYj4inrNFdmQ0mTiaMAmkpYqm9
         0xkuWur4JvIUEUoV3CFBiJ+DLWUI3zMbQNrNGoPySCbgHu3PXFnRA3fJxnrD2GgIQiW9
         yp93aq1KKEn3xocQvrR9R1rG0h4yZQDeJ1Bs/2V12tAVzCd6z5j9zhb8zZNGmg6i8XVe
         M6JQEM+p1lUwGJQPxu0Xzs9Q5gASTJUEGdNBC9QIkdOA9t8kohMjsPc0AeUEWzC4EaXq
         +bozF8bHPsJ/OyG9sxp0agODo83vJjFcmO0NYgxTTgda9dvsjLHYR2fcEUOcBmDXU821
         /HEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681893234; x=1684485234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iK+POleBc/byLDVWHTc7+1oZoRzGsPyfNa6vjT15MA=;
        b=Y0Y8Br5OR8qsIvZ7Ok+Zojb+mezlkLdOxwAn9FoPyJz1v310QpK+hLrNZ9Stgaq02y
         iQXn9HeMaNvwUuoavDeGwSCm4dhfnjfcnEDoyh8jsDXEhb6W2829teFeePr6EI7s93Li
         TxVhCO+jbuZdG0axSjuHRu4HOQABUzqzMN85c5WRKyCvVCTY4Y+i07b1dDsfNIG65zqM
         +qTryN2BPgZJQR9wwSOfRbfLMbP101AGnBunU8orZ+paHZmEuZY13Ed8IQn0AYvarHiK
         sYjYe5msM1xLV7eO1FVAaJbV4Vta7MX66SrkVHP2w+wOHelLls9g0xCcaPoAehV2cpkk
         lSxg==
X-Gm-Message-State: AAQBX9fpKwC/MCOFdFHL0Sxwbg+dGAxzu1SmfRxfb+7KiJ0L82EfPGNe
        lnDiIqAwT0d5zPkTBTZPzUaxGg==
X-Google-Smtp-Source: AKy350Z0vLK/BVPhd0fv9yEhIp66hfcg8Jnye9y9U1dRBnP+hcAFpjOBAiRmf5V3xMdhwyW+fny/sQ==
X-Received: by 2002:adf:ec86:0:b0:2d0:58f9:a6b with SMTP id z6-20020adfec86000000b002d058f90a6bmr1143426wrn.13.1681893234264;
        Wed, 19 Apr 2023 01:33:54 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:a794:9fb2:29fb:606d])
        by smtp.gmail.com with ESMTPSA id s5-20020a1cf205000000b003ed1ff06faasm1442033wmc.19.2023.04.19.01.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 01:33:53 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 6/6] thermal/drivers/intel_menlow: Make additionnal sysfs information optional
Date:   Wed, 19 Apr 2023 10:33:43 +0200
Message-Id: <20230419083343.505780-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419083343.505780-1-daniel.lezcano@linaro.org>
References: <20230419083343.505780-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Menlon thermal driver creates auxiliary trip points in the thermal
zone sysfs directory. It is specific to Menlon. Actually these trip
points could be generalized with the generic trip points in the future.

Let's make the code optional and disable it by default so we have a
consistency with the attributes in the thermal zone sysfs
directories. If that hurts we will enable by default this option
instead of disabling it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/Kconfig        | 11 +++++++++++
 drivers/thermal/intel/intel_menlow.c |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index cb7e7697cf1e..ef7ffe6b56a0 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -112,6 +112,17 @@ config INTEL_MENLOW
 
 	  If unsure, say N.
 
+config INTEL_MENLOW_SYSFS_ADDON
+       bool "Enable extra sysfs attributes in the thermal zone"
+       depends on INTEL_MENLOW
+       def_bool n
+       help
+	 Create auxiliary trip points in the thermal zone sysfs
+	 directory. This is specific to this driver. By default those
+	 are disabled and are candidate for removal, if you need these
+	 information anyway, enable the option or upgrade the
+	 userspace program using them.
+
 config INTEL_HFI_THERMAL
 	bool "Intel Hardware Feedback Interface"
 	depends on NET
diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
index d720add918ff..605983be516c 100644
--- a/drivers/thermal/intel/intel_menlow.c
+++ b/drivers/thermal/intel/intel_menlow.c
@@ -367,6 +367,7 @@ static ssize_t bios_enabled_show(struct device *dev,
 	return sprintf(buf, "%s\n", bios_enabled ? "enabled" : "disabled");
 }
 
+#ifdef CONFIG_INTEL_MENLOW_SYSFS_ADDON
 static int intel_menlow_add_one_attribute(char *name, umode_t mode, void *show,
 					  void *store, struct device *dev,
 					  acpi_handle handle)
@@ -398,6 +399,14 @@ static int intel_menlow_add_one_attribute(char *name, umode_t mode, void *show,
 
 	return 0;
 }
+#else
+static int intel_menlow_add_one_attribute(char *name, umode_t mode, void *show,
+					  void *store, struct device *dev,
+					  acpi_handle handle)
+{
+	return 0;
+}
+#endif
 
 static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 						void *context, void **rv)
-- 
2.34.1

