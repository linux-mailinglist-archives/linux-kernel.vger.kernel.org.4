Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725D365B9E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 04:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjACDxd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Jan 2023 22:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjACDxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 22:53:31 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B68E23F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 19:53:28 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 8B48924E1E1;
        Tue,  3 Jan 2023 11:53:26 +0800 (CST)
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 3 Jan
 2023 11:53:26 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX161.cuchost.com
 (172.16.6.71) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 3 Jan
 2023 11:53:23 +0800
From:   Ley Foon Tan <leyfoon.tan@starfivetech.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Ley Foon Tan" <lftan.linux@gmail.com>
Subject: [PATCH] riscv: Move call to init_cpu_topology() to later initialization stage
Date:   Tue, 3 Jan 2023 11:53:16 +0800
Message-ID: <20230103035316.3841303-1-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX161.cuchost.com
 (172.16.6.71)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

topology_parse_cpu_capacity() is failed to allocate memory with kcalloc()
after read "capacity-dmips-mhz" DT parameter in CPU DT nodes. This
topology_parse_cpu_capacity() is called from init_cpu_topology(), move
call to init_cpu_topology() to later initialization  stage (after memory
allocation is available).

Note, this refers to ARM64 implementation, call init_cpu_topology() in
smp_prepare_cpus().

Tested on Qemu platform.

Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

---

In drivers/base/arch_topology.c: topology_parse_cpu_capacity():

	ret = of_property_read_u32(cpu_node, "capacity-dmips-mhz",
				   &cpu_capacity);
	if (!ret) {
		if (!raw_capacity) {
			raw_capacity = kcalloc(num_possible_cpus(),
					       sizeof(*raw_capacity),
					       GFP_KERNEL);
			if (!raw_capacity) {
				cap_parsing_failed = true;
				return false;
			}
---
 arch/riscv/kernel/smpboot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 3373df413c88..ddb2afba6d25 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -39,7 +39,6 @@ static DECLARE_COMPLETION(cpu_running);
 
 void __init smp_prepare_boot_cpu(void)
 {
-	init_cpu_topology();
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
@@ -48,6 +47,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	int ret;
 	unsigned int curr_cpuid;
 
+	init_cpu_topology();
+
 	curr_cpuid = smp_processor_id();
 	store_cpu_topology(curr_cpuid);
 	numa_store_cpu_info(curr_cpuid);
-- 
2.25.1

