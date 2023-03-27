Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F037B6CAD03
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjC0S2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0S2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:28:32 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE791271D;
        Mon, 27 Mar 2023 11:28:26 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id bm2so7079983oib.4;
        Mon, 27 Mar 2023 11:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679941706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQ7v2ex9dTmzCe2haOqOXoH6TENnIyNV9xel5tp8My8=;
        b=JheVcrXGSM9asqfJTX/uZLNhJ83sy06on1UVEnUYpsgMD2FNtTK7un2iBwxkvlpNK3
         ACHlgSo8u8MicDNTCmql4xrjJtcAVQCd3t1RIOrYFdj1IGLTCPadT7uMer95xLB6qKKM
         Yen23l1zwXFcBnOReAFd93YBgqgryINgVK7bRafd/8IElJ3ReXJsZ7ykHwaSCP1mqzp8
         RRrZN/MK19bKL2n5k3ugbMtE8cDeqDd7v101xXH5UPCpM5ZXD6jo5LMaEkWJlN5jUS/Q
         HMzkimv8diVej8CsRBMfZjfEqzaIuPt36s0qmE43lg63EahbMIEIIYQshT6z+88SqmbJ
         VFUg==
X-Gm-Message-State: AO0yUKXgtMi/P28LlyVAAsLCGUIOtiRembErlgNpDPappW6Cl2e4HWX3
        hTedH7EtErtWDZH/VK2maA==
X-Google-Smtp-Source: AK7set8IqfFHZHfzgonx7cRWuX0fDVTESng3LZtFAfiKlkOBoD5InFl7BN7irfmAg+/oa0WJPBYBug==
X-Received: by 2002:aca:1b09:0:b0:383:eff6:d3c3 with SMTP id b9-20020aca1b09000000b00383eff6d3c3mr5659291oib.3.1679941706033;
        Mon, 27 Mar 2023 11:28:26 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 124-20020a4a0082000000b0053732f1acd2sm1559427ooh.5.2023.03.27.11.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 11:28:25 -0700 (PDT)
Received: (nullmailer pid 234000 invoked by uid 1000);
        Mon, 27 Mar 2023 18:28:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Cc:     linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] openrisc: Use common of_get_cpu_node() instead of open-coding
Date:   Mon, 27 Mar 2023 13:28:16 -0500
Message-Id: <20230327182816.233818-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common of_get_cpu_node() is equivalent to setup_find_cpu_node(), so
use it instead.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/openrisc/kernel/setup.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 0cd04d936a7a..9cf7fb60441f 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -152,21 +152,6 @@ static void print_cpuinfo(void)
 		printk(KERN_INFO "-- custom unit(s)\n");
 }
 
-static struct device_node *setup_find_cpu_node(int cpu)
-{
-	u32 hwid;
-	struct device_node *cpun;
-
-	for_each_of_cpu_node(cpun) {
-		if (of_property_read_u32(cpun, "reg", &hwid))
-			continue;
-		if (hwid == cpu)
-			return cpun;
-	}
-
-	return NULL;
-}
-
 void __init setup_cpuinfo(void)
 {
 	struct device_node *cpu;
@@ -175,7 +160,7 @@ void __init setup_cpuinfo(void)
 	int cpu_id = smp_processor_id();
 	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[cpu_id];
 
-	cpu = setup_find_cpu_node(cpu_id);
+	cpu = of_get_cpu_node(cpu_id, NULL);
 	if (!cpu)
 		panic("Couldn't find CPU%d in device tree...\n", cpu_id);
 
@@ -255,7 +240,7 @@ static inline unsigned long extract_value(unsigned long reg, unsigned long mask)
 void calibrate_delay(void)
 {
 	const int *val;
-	struct device_node *cpu = setup_find_cpu_node(smp_processor_id());
+	struct device_node *cpu = of_get_cpu_node(smp_processor_id(), NULL);
 
 	val = of_get_property(cpu, "clock-frequency", NULL);
 	if (!val)
-- 
2.39.2

