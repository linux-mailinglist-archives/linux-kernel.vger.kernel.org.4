Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C390974DB0F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjGJQ1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGJQ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:27:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D648611A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:27:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3159d5e409dso662103f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689006453; x=1691598453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVlZJd24DRUTRrQURnZ7yN63fxP+eJTyjrLPGCN3yY4=;
        b=Bnwq/Qi/JmJjvgrXJcJ4mxBmPQeRQvv390HGFGyUuTvK+3qjIUcYFRnHUurd+gHv3i
         USKmOQi84077zEMtO7p2FhECnBcE9G7vjQgZ19Kds60m7VHN0MpNvyJc4V5XavGlJpQm
         tjZrqL2UC/kdcEONl+g1Uc+2eRQ7ftePacgIlBr5xUWoDde/to5RoEqMdvh8dD0JioYY
         Z79ws2GNv5acVnlc8DqjGQE8i58IFkKYB/YyLALneu1RcQGXdztWFuVVlVueOY/+fE7A
         6tajkBjIlsf57ytcpElDPl7q4gUgmS5UOyD7x10Y4Kew82jwdMv5HIQAswHYrbSUZ1md
         X7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689006453; x=1691598453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVlZJd24DRUTRrQURnZ7yN63fxP+eJTyjrLPGCN3yY4=;
        b=J4LQi/7soLYJQ1abAg2+3KNNU3hF/ViaNFjL8nQhm363cPeJqL0Ak2VPy2+RNcSqND
         D1192uF7M1p6ZZ75jcmK9hnZxgW2fSdewm1omxZWO6PrJA/9vwKwbBR9Y1Py7uNxCWTF
         rJadAheCAP9XtFI11yCtsknveCGtbrF91ItzYEjJWjwbRaDZDmIglFdVRq4Z4w/e8SNu
         bORqrwPH0QUxCYYACwrHLy4m2Uq6a88g/WGdEkDDF3nhhF4TqASTythi0hJmBU/huLxY
         I6C+H4jiZWe1XCQy6kMUWQCSlEml/YG13W3+suu20TLnfTR1XLCYkcd4uUHlBbobyebk
         tDnQ==
X-Gm-Message-State: ABy/qLZZTXG+dpCl5fZ1FG1U0EjY5MwXdOmlhKWBkP89+/vgONpCB8NK
        9T5nEgxAi877lxNjnQRSow+0vQ==
X-Google-Smtp-Source: APBJJlFhwyy6ydGp2WjaMZUpUK1JbYJNqOtWi+1SPoy1P4WD5lmV5bX0C2TlnZFlc4ZK4sKA1DrIFQ==
X-Received: by 2002:a5d:65ce:0:b0:315:7f1d:7790 with SMTP id e14-20020a5d65ce000000b003157f1d7790mr6145269wrw.6.1689006453352;
        Mon, 10 Jul 2023 09:27:33 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id h16-20020adff190000000b003144b95e1ecsm12029064wro.93.2023.07.10.09.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 09:27:33 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        openbmc@lists.ozlabs.org
Subject: [PATCH] hwmon: (peci/cputemp) Add Intel Sapphire Rapids support
Date:   Mon, 10 Jul 2023 18:27:23 +0200
Message-ID: <20230710162724.827833-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add support to read DTS for reading Intel Sapphire Rapids platform.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/hwmon/peci/cputemp.c | 18 ++++++++++++++++++
 drivers/peci/cpu.c           |  5 +++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
index e5b65a382772..a812c15948d9 100644
--- a/drivers/hwmon/peci/cputemp.c
+++ b/drivers/hwmon/peci/cputemp.c
@@ -363,6 +363,7 @@ static int init_core_mask(struct peci_cputemp *priv)
 	switch (peci_dev->info.model) {
 	case INTEL_FAM6_ICELAKE_X:
 	case INTEL_FAM6_ICELAKE_D:
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 		ret = peci_ep_pci_local_read(peci_dev, 0, reg->bus, reg->dev,
 					     reg->func, reg->offset + 4, &data);
 		if (ret)
@@ -531,6 +532,13 @@ static struct resolved_cores_reg resolved_cores_reg_icx = {
 	.offset = 0xd0,
 };
 
+static struct resolved_cores_reg resolved_cores_reg_spr = {
+	.bus = 31,
+	.dev = 30,
+	.func = 6,
+	.offset = 0x80,
+};
+
 static const struct cpu_info cpu_hsx = {
 	.reg		= &resolved_cores_reg_hsx,
 	.min_peci_revision = 0x33,
@@ -549,6 +557,12 @@ static const struct cpu_info cpu_icx = {
 	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
 };
 
+static const struct cpu_info cpu_spr = {
+	.reg		= &resolved_cores_reg_spr,
+	.min_peci_revision = 0x40,
+	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
+};
+
 static const struct auxiliary_device_id peci_cputemp_ids[] = {
 	{
 		.name = "peci_cpu.cputemp.hsx",
@@ -574,6 +588,10 @@ static const struct auxiliary_device_id peci_cputemp_ids[] = {
 		.name = "peci_cpu.cputemp.icxd",
 		.driver_data = (kernel_ulong_t)&cpu_icx,
 	},
+	{
+		.name = "peci_cpu.cputemp.spr",
+		.driver_data = (kernel_ulong_t)&cpu_spr,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(auxiliary, peci_cputemp_ids);
diff --git a/drivers/peci/cpu.c b/drivers/peci/cpu.c
index de4a7b3e5966..3668a908d259 100644
--- a/drivers/peci/cpu.c
+++ b/drivers/peci/cpu.c
@@ -318,6 +318,11 @@ static const struct peci_device_id peci_cpu_device_ids[] = {
 		.model	= INTEL_FAM6_ICELAKE_X,
 		.data	= "icx",
 	},
+	{ /* Sapphire Rapids Xeon */
+		.family	= 6,
+		.model	= INTEL_FAM6_SAPPHIRERAPIDS_X,
+		.data	= "spr",
+	},
 	{ /* Icelake Xeon D */
 		.family	= 6,
 		.model	= INTEL_FAM6_ICELAKE_D,

base-commit: 4dbbaf8fbdbd13adc80731b2452257857e4c2d8b
-- 
2.41.0

