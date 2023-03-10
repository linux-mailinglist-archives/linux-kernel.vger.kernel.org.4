Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2E36B4716
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjCJOsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbjCJOre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:34 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35039105F13;
        Fri, 10 Mar 2023 06:47:17 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id e26-20020a9d6e1a000000b00694274b5d3aso3045188otr.5;
        Fri, 10 Mar 2023 06:47:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erVHxEOkHulgXr4ymdjMTqBXd4BHusuBykzBB4r+uDs=;
        b=Max5u5lz6ur0UdQinEXDDb/xvgpN0N4F9TO143fM7oMuE+gA6OfsvAO8gaOV7ng/NW
         P3vQJ/YzcSmAl8NQfXKvslbwU2W3INEjovvIuyWrWVIIzBL4SG0rQo87ViRPwkgXAnVJ
         /0H+TjJhs7BUOSvujBRFVJX94WiISrwCa98GCDBfCfMNIkx8pVi91R7oV3w1R0kLvn8x
         3XlYObNixfJ1a71P7MX7EH6FqAVrY3e2a/+kmHKTgFCogL8XI39jgXmBhf12hzwz/Okv
         zzqm4OuNhX+v1iXCs7XD8/yxXkJRmuTCRqb4uALPeIvQ4f5S2IPVs1PDJvQJHiQPET19
         66aQ==
X-Gm-Message-State: AO0yUKVBWNcUgLcu4VH3gKr47XtHIn+t1HqeCjII56eGtu7ECsZe25NZ
        FceojoQqAMGrpcFgwSXT3g==
X-Google-Smtp-Source: AK7set8hJS2ezY4Sj6II5USm8t5lAU/pknQcOqjT5++f2l5DIb1/fgDXqQGDmXQaSJB3gBb5nRHPoQ==
X-Received: by 2002:a05:6830:43a1:b0:690:e7d0:7918 with SMTP id s33-20020a05683043a100b00690e7d07918mr16287581otv.8.1678459633357;
        Fri, 10 Mar 2023 06:47:13 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q19-20020a05683022d300b0068bd20cf07dsm114512otc.48.2023.03.10.06.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:12 -0800 (PST)
Received: (nullmailer pid 1541845 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:03 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: pmac32: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:03 -0600
Message-Id: <20230310144703.1541819-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/cpufreq/pmac32-cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 4b8ee2014da6..7ec6d1bb4592 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -546,7 +546,7 @@ static int pmac_cpufreq_init_7447A(struct device_node *cpunode)
 {
 	struct device_node *volt_gpio_np;
 
-	if (of_get_property(cpunode, "dynamic-power-step", NULL) == NULL)
+	if (!of_property_read_bool(cpunode, "dynamic-power-step"))
 		return 1;
 
 	volt_gpio_np = of_find_node_by_name(NULL, "cpu-vcore-select");
@@ -576,7 +576,7 @@ static int pmac_cpufreq_init_750FX(struct device_node *cpunode)
 	u32 pvr;
 	const u32 *value;
 
-	if (of_get_property(cpunode, "dynamic-power-step", NULL) == NULL)
+	if (!of_property_read_bool(cpunode, "dynamic-power-step"))
 		return 1;
 
 	hi_freq = cur_freq;
@@ -632,7 +632,7 @@ static int __init pmac_cpufreq_setup(void)
 
 	/*  Check for 7447A based MacRISC3 */
 	if (of_machine_is_compatible("MacRISC3") &&
-	    of_get_property(cpunode, "dynamic-power-step", NULL) &&
+	    of_property_read_bool(cpunode, "dynamic-power-step") &&
 	    PVR_VER(mfspr(SPRN_PVR)) == 0x8003) {
 		pmac_cpufreq_init_7447A(cpunode);
 
-- 
2.39.2

