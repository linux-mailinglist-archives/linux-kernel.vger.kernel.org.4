Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02AF74A555
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjGFUzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjGFUzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:55:15 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C58A9D;
        Thu,  6 Jul 2023 13:55:12 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7866189cff1so42635239f.0;
        Thu, 06 Jul 2023 13:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688676911; x=1691268911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=781hmHvNO59Ce4e05rVFQVLl4Gj7HUr6rWG6tbtSkTg=;
        b=hVKuQij3Vr8ZrbobSfJ64gH2K4iV8xeBigG3jpqLRplcAqukbsG/y80YBMjuZXXdd3
         LnDEP5dQJJzznMvhqbdLgvpnJgRPO7o9pEyw+EFQcyQl4UGz10YtkkVCdTwXN1N4R6z2
         UYuGSNl1dPXePbiQDWTIHCP+jHxJwITn497RTpa/xh702rVMY02CSooY0eH8vObxWQDE
         YGQrmH4fst3V+qiiBPGIkAeqm1hpapKbKz2Bc076K9lBoV2gecHw6X6C9B/0T4QwmWOR
         q+O+ggOpDubncuIAFhjAuDt5nkWPmAMh6J2peKYY8HfzbxK26hVSkekMiST7oFWQ9k3v
         lQyQ==
X-Gm-Message-State: ABy/qLbAkn7gvo1aNcPtYZ1HY8Ou9yXEmXSzrgTf0j3klqDnh1722vjT
        1SmFEv1RjLLAZnb1wEZLDw==
X-Google-Smtp-Source: APBJJlFTbf0DEJsDabvrCUGjZEyi4enCSM73H3xGdf3q/7mCzrHhF/smdG5Q4DD9PEPZ7v2GhJECkw==
X-Received: by 2002:a5e:c009:0:b0:783:6190:f913 with SMTP id u9-20020a5ec009000000b007836190f913mr3129046iol.4.1688676911506;
        Thu, 06 Jul 2023 13:55:11 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id dp21-20020a056602069500b0078647b08ab0sm778513iob.6.2023.07.06.13.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 13:55:10 -0700 (PDT)
Received: (nullmailer pid 308623 invoked by uid 1000);
        Thu, 06 Jul 2023 20:55:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] perf: pmuv3: Add Cortex A520, A715, A720, X3 and X4 PMUs
Date:   Thu,  6 Jul 2023 14:55:04 -0600
Message-Id: <20230706205505.308523-2-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706205505.308523-1-robh@kernel.org>
References: <20230706205505.308523-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Arm Cortex-A520, Cortex-A715, Cortex-A720,
Cortex-X3, and Cortex-X4 CPU PMUs. They are straight-forward additions
with just new compatible strings.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Also add Cortex-X3 and Cortex-X4
---
 drivers/perf/arm_pmuv3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 08b3a1bf0ef6..d2dffb4e9d07 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1266,9 +1266,14 @@ PMUV3_INIT_SIMPLE(armv8_cortex_a76)
 PMUV3_INIT_SIMPLE(armv8_cortex_a77)
 PMUV3_INIT_SIMPLE(armv8_cortex_a78)
 PMUV3_INIT_SIMPLE(armv9_cortex_a510)
+PMUV3_INIT_SIMPLE(armv9_cortex_a520)
 PMUV3_INIT_SIMPLE(armv9_cortex_a710)
+PMUV3_INIT_SIMPLE(armv9_cortex_a715)
+PMUV3_INIT_SIMPLE(armv9_cortex_a720)
 PMUV3_INIT_SIMPLE(armv8_cortex_x1)
 PMUV3_INIT_SIMPLE(armv9_cortex_x2)
+PMUV3_INIT_SIMPLE(armv9_cortex_x3)
+PMUV3_INIT_SIMPLE(armv9_cortex_x4)
 PMUV3_INIT_SIMPLE(armv8_neoverse_e1)
 PMUV3_INIT_SIMPLE(armv8_neoverse_n1)
 PMUV3_INIT_SIMPLE(armv9_neoverse_n2)
@@ -1334,9 +1339,14 @@ static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{.compatible = "arm,cortex-a77-pmu",	.data = armv8_cortex_a77_pmu_init},
 	{.compatible = "arm,cortex-a78-pmu",	.data = armv8_cortex_a78_pmu_init},
 	{.compatible = "arm,cortex-a510-pmu",	.data = armv9_cortex_a510_pmu_init},
+	{.compatible = "arm,cortex-a520-pmu",	.data = armv9_cortex_a520_pmu_init},
 	{.compatible = "arm,cortex-a710-pmu",	.data = armv9_cortex_a710_pmu_init},
+	{.compatible = "arm,cortex-a715-pmu",	.data = armv9_cortex_a715_pmu_init},
+	{.compatible = "arm,cortex-a720-pmu",	.data = armv9_cortex_a720_pmu_init},
 	{.compatible = "arm,cortex-x1-pmu",	.data = armv8_cortex_x1_pmu_init},
 	{.compatible = "arm,cortex-x2-pmu",	.data = armv9_cortex_x2_pmu_init},
+	{.compatible = "arm,cortex-x3-pmu",	.data = armv9_cortex_x3_pmu_init},
+	{.compatible = "arm,cortex-x4-pmu",	.data = armv9_cortex_x4_pmu_init},
 	{.compatible = "arm,neoverse-e1-pmu",	.data = armv8_neoverse_e1_pmu_init},
 	{.compatible = "arm,neoverse-n1-pmu",	.data = armv8_neoverse_n1_pmu_init},
 	{.compatible = "arm,neoverse-n2-pmu",	.data = armv9_neoverse_n2_pmu_init},
-- 
2.40.1

