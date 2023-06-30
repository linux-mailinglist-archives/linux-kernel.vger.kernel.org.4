Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBD8744293
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjF3S4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjF3S4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:56:11 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595713C17;
        Fri, 30 Jun 2023 11:56:10 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-77b00bb3fd6so51891439f.1;
        Fri, 30 Jun 2023 11:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688151369; x=1690743369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qg6XVnmpWeSRuQrQC40KAOfl9x3/Hr4okb3QeBv6fgE=;
        b=geiLsChRorAwTUt670HMznbhiWFUkVbHOfMmP1GXE36rgASWH/+pJWY12WBSiKnS0B
         /1hzQkTf7kD3uUbNF/jIheXKmABUyh2KDPwtWvygXr9uQ48Ze/jzx1UFiLxieSZngicy
         4cnbQpBO9i6tEQpNWJpnRhuiE/VBfkNgG6LL0j1RNVdw1C6XaQW8GlibRxp6ZbVlvFKH
         JVe8iSOtQ+oTOQW8OPaax81uyZARXEqZVLEa5bKaCkmqx0P8qyg/lS5eBtdi9lExbQ+S
         GBwl12I3Jy6mMLrCVS05RXMJfcrSJa2VA7y6L1pCv1t/vG2RTQrp1pDzqvfQIM/cI1uR
         74/w==
X-Gm-Message-State: ABy/qLaBYmjrEdZMqfeKuMZ+k+6l7fKiM4wIIFyq5hm3zy5/s90jlAFa
        B+w69bU6+gYE/BaQyFg4bg==
X-Google-Smtp-Source: APBJJlHWJaskZv3IELRdSwceCuqGTeoQp5cmpZiCU6K880XpKdNZYgYaqdOYrD23taksnR3tOp+82w==
X-Received: by 2002:a05:6e02:78f:b0:345:93da:1fe with SMTP id q15-20020a056e02078f00b0034593da01femr2817222ils.10.1688151369566;
        Fri, 30 Jun 2023 11:56:09 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d8-20020a92d788000000b0034233fd80d3sm4876420iln.22.2023.06.30.11.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:56:08 -0700 (PDT)
Received: (nullmailer pid 2175697 invoked by uid 1000);
        Fri, 30 Jun 2023 18:56:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf: pmuv3: Add Cortex-A520, Cortex-A715, and Cortex-A720 PMUs
Date:   Fri, 30 Jun 2023 12:56:02 -0600
Message-Id: <20230630185602.2175559-2-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230630185602.2175559-1-robh@kernel.org>
References: <20230630185602.2175559-1-robh@kernel.org>
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

Add support for the Arm Cortex-A520, Cortex-A715, and Cortex-A720 CPU
PMUs. They are straight-forward additions with just new compatible
strings.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/perf/arm_pmuv3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 08b3a1bf0ef6..0bf522b05dc3 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1266,7 +1266,10 @@ PMUV3_INIT_SIMPLE(armv8_cortex_a76)
 PMUV3_INIT_SIMPLE(armv8_cortex_a77)
 PMUV3_INIT_SIMPLE(armv8_cortex_a78)
 PMUV3_INIT_SIMPLE(armv9_cortex_a510)
+PMUV3_INIT_SIMPLE(armv9_cortex_a520)
 PMUV3_INIT_SIMPLE(armv9_cortex_a710)
+PMUV3_INIT_SIMPLE(armv9_cortex_a715)
+PMUV3_INIT_SIMPLE(armv9_cortex_a720)
 PMUV3_INIT_SIMPLE(armv8_cortex_x1)
 PMUV3_INIT_SIMPLE(armv9_cortex_x2)
 PMUV3_INIT_SIMPLE(armv8_neoverse_e1)
@@ -1334,7 +1337,10 @@ static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{.compatible = "arm,cortex-a77-pmu",	.data = armv8_cortex_a77_pmu_init},
 	{.compatible = "arm,cortex-a78-pmu",	.data = armv8_cortex_a78_pmu_init},
 	{.compatible = "arm,cortex-a510-pmu",	.data = armv9_cortex_a510_pmu_init},
+	{.compatible = "arm,cortex-a520-pmu",	.data = armv9_cortex_a520_pmu_init},
 	{.compatible = "arm,cortex-a710-pmu",	.data = armv9_cortex_a710_pmu_init},
+	{.compatible = "arm,cortex-a715-pmu",	.data = armv9_cortex_a715_pmu_init},
+	{.compatible = "arm,cortex-a720-pmu",	.data = armv9_cortex_a720_pmu_init},
 	{.compatible = "arm,cortex-x1-pmu",	.data = armv8_cortex_x1_pmu_init},
 	{.compatible = "arm,cortex-x2-pmu",	.data = armv9_cortex_x2_pmu_init},
 	{.compatible = "arm,neoverse-e1-pmu",	.data = armv8_neoverse_e1_pmu_init},
-- 
2.40.1

