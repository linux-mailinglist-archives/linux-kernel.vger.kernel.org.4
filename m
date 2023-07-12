Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B7375029A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjGLJNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjGLJMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:12:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FEC11B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:12:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so72672375e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689153169; x=1691745169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=As2y1S5d2MKNIGGSQpxsJqwHM8ix7xWAPQggfbywHb4=;
        b=Hs0IRBomcYhxipA/LiintP1gtFz4DiE7t+yEZ7uHGCq082dAK1i0xqnOkPPKy9gv5R
         0FbdI+i1lgZQUBWsNbBF1NsciF7dLdCfuXHCR0pN2QqY5JCCOwqRfSp1GpctvmPzUR72
         w7h1i24zz9YT8gJoyYvHKhgMm0MNZbQ39XCgCj4TS1023eCnO52jesVLqxrsnIQN/lZX
         tcH8lTgu3BTy+9Q2I5EhZcilGQu6ttx8rSMi2VN97cTrlhP76iw6Nmun8PiGMYOghkPR
         /rhtyX0UCFPiXW9Vvx+rPVS2AkypAuUgi+7DRcxcPzQy9a3WGrj5nXOsbsYs6EmAXL/v
         sepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689153169; x=1691745169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=As2y1S5d2MKNIGGSQpxsJqwHM8ix7xWAPQggfbywHb4=;
        b=M+2r3Z13+FtcPCwrVjo94NsquzX0hTy0ch8GYWhGVOiAA1BnaPyb+tl/WrWvhOdwCj
         a13RLO4jBkM0oEsvHTdWYCfOoPsA5KdsHAuYC8fkcL7aT9ajUplHFS30qYNE7uyCmtuf
         YIhHukJSkIhPRNFI1EtEVxzF7nCnLCRPPzYzTHqA8Ua7O3fuyRJasv6Cjo4H2Slx1mkb
         l2LvH3tkMFZshnGVeY04Bpko9xSP8FJp7mVoSXWfq6FJ0vys1as0m5RqCpLaC14yDw4K
         naqQ2PBGRJ8BICjmxUkmQrZXNOhJ6AtRXPBlsVnVOSemanCgNzHcdegyHOWAW+TJgLpg
         CDVQ==
X-Gm-Message-State: ABy/qLb+i4wB7n+Hycp06nTXhRxws990FfFF3iL8eymeKfdC0MqjfGVC
        N2Rr8KPILSjLfSs6l2Ek8hVwt6R42xRvDz95pzV3NA==
X-Google-Smtp-Source: APBJJlG+8CvYiKqmaycbha1cyDEg2VMoqqT40oIx06ECrjzd+sS/mZtwA/vlvGg/cL6i7ymTaVLp1w==
X-Received: by 2002:a7b:c5d4:0:b0:3fa:9e61:19ed with SMTP id n20-20020a7bc5d4000000b003fa9e6119edmr16894535wmk.23.1689153168720;
        Wed, 12 Jul 2023 02:12:48 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id y11-20020a05600c364b00b003f90b9b2c31sm15013711wmq.28.2023.07.12.02.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 02:12:48 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        iwona.winiarska@intel.com, linux@roeck-us.net, jdelvare@suse.com
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v2 2/3] hwmon: (peci/cputemp) Add Intel Sapphire Rapids support
Date:   Wed, 12 Jul 2023 11:12:39 +0200
Message-ID: <20230712091241.3668454-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712091241.3668454-1-Naresh.Solanki@9elements.com>
References: <20230712091241.3668454-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add support to read DTS for reading Intel Sapphire Rapids platform.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
Changes in V2:
- Refactored from previous patchset as seperate patch based on subsystem.
---
 drivers/hwmon/peci/cputemp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

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
-- 
2.41.0

