Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1600F6F0DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 23:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344140AbjD0Vxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 17:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0Vxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 17:53:52 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2124.outbound.protection.outlook.com [40.107.95.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F6A2D67;
        Thu, 27 Apr 2023 14:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZ+Cs8D61R+zICYxVgoKWG06RZGrw1rl+4rxlZ9t1OomhJHqZsl793h+o56sog66+vbLG7pmDry2cTDXwUcaPKwf66EMN32o3AK9OzWSTBcA2kgCfS/YTt6A4j7gfvTGisYgym0cWsKBEkhESUqv67YLAUwOSsUI8MDKAZr41WFEfYO100ywGLow3ZaJ6krTACEFbcH5cXkaW+i5FZXmJCS9amCc+555f4phq2b27A+oXR/ulByXCKlM9bThrw+8skfXCZbifGlH0+QJBv7mKRkSbrAkxtu3Rb26jDarLqaYMalC13t5odbWqhmw6AruuQgSVsD+tqrcCYpqcn2nvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkc7Tb9pt3BZ0oDfxnKWLgfkmxVuxYfwjUHrbXaf+Hc=;
 b=AyFzx5iATgvQcKIomsoKEdja5nLdN/oiDTwW8OC/UlC8EhB32pugTEQRnmRzkzLNmw75/BWtoHvRnQ9ZjV8/6kgkun0xFh8GGwW/SvyutgNVzTf9Li9eGbZKfGp5viUAV/q1s6rgxixgnuAE6Ft+ox/TSflBBoVPecwzfwt6O9ZnKm7/GRAj5i4m3TcENblB1Ka01CO/zXNf9B6nCuZW/1sY8j7gGhRiEWO1dA2aQl+hmerx52kOPdLL2VzVDyVKuof06I1GavqT/CamOCZxJHqf/8NYhyHFLblsQ6JpMZ+5vbziWcjH4mZElDegqIgkJdHsdLQsDUfUbNOhMYdseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkc7Tb9pt3BZ0oDfxnKWLgfkmxVuxYfwjUHrbXaf+Hc=;
 b=NYBkfhq9wyS2imia5/JvaqLF024zAXang8rpqeqpKtkHKaondQz7LyzP4PHGU9uC9KhsxY6PsMrVbLagLmGACW510W0v2wMxWMrxnUMvupyMW30+BGsUUijM/X/GgejoRJxnBbeawrvt0cwnmZyFIb3FvY642+zI5Q9o3UmirtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM6PR01MB5610.prod.exchangelabs.com (2603:10b6:5:152::22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22; Thu, 27 Apr 2023 21:53:44 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%6]) with mapi id 15.20.6340.011; Thu, 27 Apr 2023
 21:53:44 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH] perf: ampere: Add support for Ampere SoC PMUs
Date:   Thu, 27 Apr 2023 14:53:25 -0700
Message-Id: <20230427215325.1067752-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:610:e6::24) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|DM6PR01MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6e4d20-cb1e-4e8a-e3af-08db4769df25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2clP4PVnaTFhowWXDYGq5a6Snof75GVXR/R8E1LpqILDX2O19GYJp7Bd70u0UEJzP1DOfS+rW2MWrOb4YFonYFwPm1S44O9ujTLXxdjZw3hxlOSAtVv5LpwBRyqYwMS5QFBxskazApesuIb0cBN49Qz9mkYE1abv3scRMGSqjWsPIwc3vMxzoKmhOZLFVlWwdje0WG5dUzwIUXVBjbwbA3fi4bQGQFumrwyfgHWjkDflIrMDK9+kOfexwnpiRs3dSLpGTc/DEcKwnxO1FJ3XFm62HTNgipw2qkCCnQ1mXWnriqdVNHXXqn6i76jM05QxEa3oiK0rmNzWMVmXLwoE8UpWNS9F1rGe2f0ZyNQRT3BrVHrCiYjKqnz3zkTYg4iP9ADVUNo6yeI+oivYNs9/cOWDaqX0U2ZSGuHI0hEhBSGlSpp8yVCzA09uTFSCOu3DOwvTeAOZJgVjRLVP9qYqPB/EPNrCnxMdfgXK6fDi1gz9BX9ij7nRGiVjAngAN8HGhCgYSWaa1/lQzIH2euNAuOepPDRN4gyVBs2mzlbjjiVC/B9Fy3FyIgt16WFUZlkPX6h5D2qKhddKBDQQldxb+/HVzHMpogEQ0qujS5Faxv6zIO9spU6mT6hUzryFdWk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(39850400004)(396003)(451199021)(52116002)(6666004)(6486002)(478600001)(83380400001)(2616005)(26005)(186003)(107886003)(6512007)(1076003)(6506007)(38100700002)(86362001)(38350700002)(66556008)(66946007)(66476007)(316002)(4326008)(30864003)(2906002)(8936002)(8676002)(41300700001)(5660300002)(54906003)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XitE9WjXBzffyZzoDCKNx/LOEV/ScNztCitnqJxl+KmXgyZ/WH1DPwsARII8?=
 =?us-ascii?Q?+s7SPRQue0vImUMw0JNeqNDvc48tEq7hxWiT5xqauZcIY0+A4CHyrrY25OE4?=
 =?us-ascii?Q?SJPKboytgFBqBnls6u+saL3G8MiLy0tKHJTubIurQNDuEWf67qUAw8QMO4rg?=
 =?us-ascii?Q?JAfMxF6LCtU06RraMCwD8IcrRNkc8wqg1djMa3m7nY8KK7eBjB86AqA+KkwE?=
 =?us-ascii?Q?gkVFAVbxchBDfi/mlzP0jASIZvBHNl3EXhDznIObupz/CIlbbY0/qwAYY635?=
 =?us-ascii?Q?oVLcyWhia8m4xD1405MRLEmdjctGqumJNjYIM+Wp/E2vndvDz8sCjMJbINYZ?=
 =?us-ascii?Q?NsGrqJ6Bjr3M6P5NYM2Dahzl87OA+Tug56QZmblqy2pmq6U2mVuUyrvmODW2?=
 =?us-ascii?Q?1PAipS6VLmGKiOLgkUM1x/SD2CF34LfGi9st5Kr1zEk4mSYx9EpMKk75KFL6?=
 =?us-ascii?Q?vzgpR6gMbt1a3wX+O4DhkVZ7A98RTnBXwhrnTzMbTYxHAlhI/k7PbDh5InmW?=
 =?us-ascii?Q?vrvgdM966MOpive3+JLbB0sM2dgwRZ6DnZ3NdyEXSJO7qys3tiG7DGdno/PQ?=
 =?us-ascii?Q?PeQYD1g3lf2yY9m4M0/5rUS4K07Yhr091c1OCzuSlIuXnE7E8HC7ECIKnrxX?=
 =?us-ascii?Q?eJAGgF3FYDpsSFwd9z5CvGYLTZP5573+Y/XKCE/Bt3bH16YNF9dAk8zGPJL5?=
 =?us-ascii?Q?KJtEXdCGNEtLjP8APDRVl0MKMjtYRWZ/cqMm7XDG4hwElQHNIXDHGxQ/O42T?=
 =?us-ascii?Q?sE50820aVkz8rbq0LUMJGE9P80WDMLbduyesDAnAdh9T7z1GT1QaZ/GncNO1?=
 =?us-ascii?Q?qZvTAd6ThByT/TD7nWrUFTPd0VT3frblEP56PWcyAFXJx809ChUzJ4G1pFDt?=
 =?us-ascii?Q?uLi1t7Ex+TZoCiMJtxQSRsXSAWzy2FYXh5qamSx4mK+QTaJNC1RWzR3K43Ey?=
 =?us-ascii?Q?Tn15ksEyl/xT0oJjR3qHyQFphOSydv0mCm/POufZkjZr2gXog9tt4FHqKfyF?=
 =?us-ascii?Q?e3UOPvZSas+l6bpxjw2Ms3WscD1xQ2kQBe5WzTFfRTgMY1KXj5lsFPcEF+42?=
 =?us-ascii?Q?L8u6vnz7fIUbfFfex8w+PRVJUc6PxTUDTySZcHxIeV+1qPqPG8pD7NxGPAHj?=
 =?us-ascii?Q?UjvisCMIN33NSiqwNScYKh31gUrbkvUk+DRmv5LhLwOgus4YEC2WOUKOPVWr?=
 =?us-ascii?Q?8Fbnjq17cjBqQZXTSqnVwu0C4Su5NOeI/WhM5DNYGHw6SIL7+Mu+Kgh5zNr3?=
 =?us-ascii?Q?CnY1tLs3iX595ErvWOtYO28ti/GXskE6/ZucVnNj0B3b/5Ml7P52N3fsodCX?=
 =?us-ascii?Q?jCzn1NCb5cOMDNOoOsdTNpZ9dwQtz/FO7lhK1SYzqyHBK21h+Je4qfSd3GHu?=
 =?us-ascii?Q?/LV76M7OwOi4HyVfoJhB6A2n9dQPC+ZWDTkd04u+3gEGSbkHtqIdyjq8zDRu?=
 =?us-ascii?Q?YEneOb7biY67QA6UW0tXurANs30bpVyErjn9qSXBS8YeEk0iqhDDwQadPRzA?=
 =?us-ascii?Q?5fCcY1cF9JUBU2ILRfCgTL6lztn8qSe3AMmwpBCZdIhnIUaQdkuOLvKIhyBc?=
 =?us-ascii?Q?HA21sqxwkaUQ22RvEkW2dr4sLPmwGKB/4JazLiby6XYcACScDJ+cbx71BCJT?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6e4d20-cb1e-4e8a-e3af-08db4769df25
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 21:53:44.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jO0dzkwYppc743UBqKgcw/HBZNssmwTEYXcqw56lMugocWryy8JWnSWy96atDcnY9pSRQDuObF7J1PfwQWVQ3Tqwz+whLmDXMhs0GXho1HRACrTE3bypYhU+qrttcVGN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5610
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Ampere SoC PMUs. This driver supports MCU PMU
available in the AmpereOne SoC.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../admin-guide/perf/ampere-soc-pmu.rst       |  36 +
 Documentation/admin-guide/perf/index.rst      |   1 +
 drivers/perf/Kconfig                          |  10 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/ampere_soc_pmu.c                 | 724 ++++++++++++++++++
 5 files changed, 772 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/ampere-soc-pmu.rst
 create mode 100644 drivers/perf/ampere_soc_pmu.c

diff --git a/Documentation/admin-guide/perf/ampere-soc-pmu.rst b/Documentation/admin-guide/perf/ampere-soc-pmu.rst
new file mode 100644
index 000000000000..5161fbd1c548
--- /dev/null
+++ b/Documentation/admin-guide/perf/ampere-soc-pmu.rst
@@ -0,0 +1,36 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================
+Ampere SoC Performance Monitoring Unit (PMU)
+============================================
+
+Ampere SoC PMU is a generic PMU IP. At the first phase it's used for counting
+MCU events on AmpereOne.
+
+MCU PMU events
+--------------
+
+The PMU driver registers a PMU device for every supported PMU instance on each
+SoC. See /sys/devices/AMPC0100:<nn>/.
+
+The PMU driver supports setting filters for "rank", "bank", and "threshold". The
+filter settings are device specific and shared between all the relevant events.
+The default value for all the filters is zero. The filters can be modified by
+setting them with the last event of the particular device. All the previous
+settings are overwritten.
+
+
+Example for perf tool use::
+
+  / # perf list mcu
+    mcu0/cycle-count                                  [Kernel PMU event]
+  <...>
+    mcu16/cycle-count                                 [Kernel PMU event]
+  <...>
+
+  / # perf stat -a -e mcu0/cycle-count,bank=5/,mcu0/dfi-cmd,threshold=16,rank=8/,mcu1/dfi-cmd/ \
+        sleep 1
+
+Note, as none of the filters was set for mcu1, the default value is assigned to
+them. For mcu0, bank setting will be overwritten with the default value since
+it wasn't set with the last mcu0 event.
diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 9de64a40adab..8de9d253ae81 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -21,3 +21,4 @@ Performance monitor support
    alibaba_pmu
    nvidia-pmu
    meson-ddr-pmu
+   ampere-soc-pmu
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 711f82400086..6551005aaa04 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -209,6 +209,16 @@ config MARVELL_CN10K_DDR_PMU
 	  Enable perf support for Marvell DDR Performance monitoring
 	  event on CN10K platform.
 
+config AMPERE_SOC_PMU
+	tristate "Ampere SoC PMU"
+	depends on ARM64 && ACPI
+	help
+	  Enable support for Ampere SoC performance counters used on
+	  Ampere SoCs.
+
+	  The SoC PMU can support multiple different PMU types. At the first
+	  phase it supports MCU PMU available on AmpereOne.
+
 source "drivers/perf/arm_cspmu/Kconfig"
 
 source "drivers/perf/amlogic/Kconfig"
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index dabc859540ce..17be9b0f75f8 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
 obj-$(CONFIG_ALIBABA_UNCORE_DRW_PMU) += alibaba_uncore_drw_pmu.o
 obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
 obj-$(CONFIG_MESON_DDR_PMU) += amlogic/
+obj-$(CONFIG_AMPERE_SOC_PMU) += ampere_soc_pmu.o
diff --git a/drivers/perf/ampere_soc_pmu.c b/drivers/perf/ampere_soc_pmu.c
new file mode 100644
index 000000000000..0591e0e4fbd2
--- /dev/null
+++ b/drivers/perf/ampere_soc_pmu.c
@@ -0,0 +1,724 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ampere SoC PMU (Performance Monitor Unit)
+ *
+ * Copyright (c) 2023, Ampere Computing LLC
+ */
+
+#include <linux/acpi.h>
+#include <linux/cpuhotplug.h>
+#include <linux/cpumask.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define SOC_PMEVCNTR0_LO	0x000
+#define SOC_PMEVCNTR0_HI	0x004
+#define SOC_PMCCNTR_LO		0x0F8
+#define SOC_PMCCNTR_HI		0x0FC
+
+#define SOC_PMEVTYPER0		0x400
+
+#define SOC_PMELCSR		0xA10
+
+#define SOC_PMCNTENSET		0xC00
+#define SOC_PMCNTENCLR		0xC20
+#define SOC_PMINTENSET		0xC40
+#define SOC_PMINTENCLR		0xC60
+#define SOC_PMOVSCLR		0xC80
+#define SOC_PMOVSSET		0xCC0
+
+#define SOC_PMAUXR0		0xD80
+#define SOC_PMAUXR1		0xD84
+#define SOC_PMAUXR2		0xD88
+#define SOC_PMAUXR3		0xD8C
+
+#define SOC_PMCFGR		0xE00
+#define SOC_PMCR		0xE04
+#define PMU_PMCR_E		BIT(0)
+#define PMU_PMCR_P		BIT(1)
+
+#define SOC_PMAUTHSTATUS	0xFB8
+#define SOC_PMDEVARCH		0xFBC
+#define SOC_PMDEVTYPE		0xFCC
+#define SOC_PMPIDR4		0xFD0
+#define SOC_PMPIDR0		0xFE0
+#define SOC_PMPIDR1		0xFE4
+#define SOC_PMPIDR2		0xFE8
+#define SOC_PMPIDR3		0xFEC
+#define SOC_PMCIDR0		0xFF0
+#define SOC_PMCIDR1		0xFF4
+#define SOC_PMCIDR2		0xFF8
+#define SOC_PMCIDR3		0xFFC
+
+#define SOC_ID_MASK		0xFFF
+#define SOC_VERSION_MASK	0xFF000
+#define SOC_CYCLE_COUNTER	BIT(14)
+#define SOC_NR_COUNTERS_MASK	0xF
+
+#define SOC_PMEVCNTR_LOn(n)	(SOC_PMEVCNTR0_LO + (n) * 8)
+#define SOC_PMEVCNTR_HIn(n)	(SOC_PMEVCNTR0_HI + (n) * 8)
+#define SOC_PMEVTYPERn(n)	(SOC_PMEVTYPER0 + (n) * 4)
+
+#define SOC_CYCLE_COUNTER_BIT	BIT(31)
+#define SOC_MAX_COUNTERS	4
+#define SOC_CYCLE_COUNTER_IDX	SOC_MAX_COUNTERS
+#define SOC_CYCLE_COUNTER_EVENT	0x100
+
+#define SOC_MAX_PERIOD		0xFFFFFFFFFFFFFFFFULL
+
+struct ampere_pmu {
+	int id;
+	int version;
+
+	void __iomem *base;
+	int irq;
+
+	int nr_counters;
+
+	/* Number of generic counters + optional cycle counter */
+	DECLARE_BITMAP(counter_mask, SOC_MAX_COUNTERS + 1);
+	struct perf_event *counters[SOC_MAX_COUNTERS + 1];
+	bool cycle_exists;
+
+	int cpu;
+	struct hlist_node node;
+	struct pmu pmu;
+	struct device *dev;
+};
+
+static int cpuhp_state_num;
+
+#define to_ampere_pmu(_pmu) container_of(_pmu, struct ampere_pmu, pmu)
+
+#define SOC_CONFIG_EVENTID		GENMASK(8, 0)
+#define SOC_CONFIG_THRESHOLD		GENMASK(7, 0)
+#define SOC_CONFIG_RANK			GENMASK(23, 8)
+#define SOC_CONFIG_BANK			GENMASK(31, 0)
+
+#define SOC_EVENT_EVENTID(event)	FIELD_GET(SOC_CONFIG_EVENTID, (event)->attr.config)
+#define SOC_EVENT_THRESHOLD(event)	FIELD_GET(SOC_CONFIG_THRESHOLD, (event)->attr.config1)
+#define SOC_EVENT_RANK(event)		FIELD_GET(SOC_CONFIG_RANK, (event)->attr.config1)
+#define SOC_EVENT_BANK(event)		FIELD_GET(SOC_CONFIG_BANK, (event)->attr.config2)
+
+#define AMPERE_PMU_EVENT_ATTR(_name, _event)			\
+	PMU_EVENT_ATTR_ID(_name, ampere_pmu_event_show, _event)
+
+#define AMPERE_PMU_EVENT_CYCLE(_name)				\
+	AMPERE_PMU_EVENT_ATTR(_name, SOC_CYCLE_COUNTER_EVENT)
+
+#define AMPERE_PMU_FORMAT_ATTR(_name, _config)					\
+	(&((struct dev_ext_attribute[]) {{					\
+		.attr = __ATTR(_name, 0444, ampere_pmu_format_show, NULL),	\
+		.var = (void *) _config						\
+	}})[0].attr.attr)
+
+static ssize_t ampere_pmu_format_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *eattr =
+		container_of(attr, struct dev_ext_attribute, attr);
+
+	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
+}
+
+static struct attribute *ampere_pmu_format_attrs[] = {
+	AMPERE_PMU_FORMAT_ATTR(event, "config:0-8"),
+	AMPERE_PMU_FORMAT_ATTR(threshold, "config1:0-7"),
+	AMPERE_PMU_FORMAT_ATTR(rank, "config1:8-23"),
+	AMPERE_PMU_FORMAT_ATTR(bank, "config2:0-31"),
+	NULL,
+};
+
+static const struct attribute_group ampere_pmu_format_attr_group = {
+	.name = "format",
+	.attrs = ampere_pmu_format_attrs,
+};
+
+static ssize_t ampere_pmu_event_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct perf_pmu_events_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return  sysfs_emit(buf, "event=0x%llx\n", pmu_attr->id);
+}
+
+static struct attribute *ampere_mcu_pmu_events_attrs[] = {
+	AMPERE_PMU_EVENT_ATTR(cycle_count,		0x00),
+	AMPERE_PMU_EVENT_ATTR(act_sent,			0x01),
+	AMPERE_PMU_EVENT_ATTR(pre_sent,			0x02),
+	AMPERE_PMU_EVENT_ATTR(rd_sent,			0x03),
+	AMPERE_PMU_EVENT_ATTR(rda_sent,			0x04),
+	AMPERE_PMU_EVENT_ATTR(wr_sent,			0x05),
+	AMPERE_PMU_EVENT_ATTR(wra_sent,			0x06),
+	AMPERE_PMU_EVENT_ATTR(pd_entry_vld,		0x07),
+	AMPERE_PMU_EVENT_ATTR(sref_entry_vld,		0x08),
+	AMPERE_PMU_EVENT_ATTR(prea_sent,		0x09),
+	AMPERE_PMU_EVENT_ATTR(pre_sb_sent,		0x0a),
+	AMPERE_PMU_EVENT_ATTR(ref_sent,			0x0b),
+	AMPERE_PMU_EVENT_ATTR(rfm_sent,			0x0c),
+	AMPERE_PMU_EVENT_ATTR(ref_sb_sent,		0x0d),
+	AMPERE_PMU_EVENT_ATTR(rfm_sb_sent,		0x0e),
+	AMPERE_PMU_EVENT_ATTR(rd_rda_sent,		0x0f),
+	AMPERE_PMU_EVENT_ATTR(wr_wra_sent,		0x10),
+	AMPERE_PMU_EVENT_ATTR(raw_hazard,		0x11),
+	AMPERE_PMU_EVENT_ATTR(war_hazard,		0x12),
+	AMPERE_PMU_EVENT_ATTR(waw_hazard,		0x13),
+	AMPERE_PMU_EVENT_ATTR(rar_hazard,		0x14),
+	AMPERE_PMU_EVENT_ATTR(raw_war_waw_hazard,	0x15),
+	AMPERE_PMU_EVENT_ATTR(hprd_lprd_wr_req_vld,	0x16),
+	AMPERE_PMU_EVENT_ATTR(lprd_req_vld,		0x17),
+	AMPERE_PMU_EVENT_ATTR(hprd_req_vld,		0x18),
+	AMPERE_PMU_EVENT_ATTR(hprd_lprd_req_vld,	0x19),
+	AMPERE_PMU_EVENT_ATTR(prefetch_tgt,		0x1a),
+	AMPERE_PMU_EVENT_ATTR(wr_req_vld,		0x1b),
+	AMPERE_PMU_EVENT_ATTR(partial_wr_req_vld,	0x1c),
+	AMPERE_PMU_EVENT_ATTR(rd_retry,			0x1d),
+	AMPERE_PMU_EVENT_ATTR(wr_retry,			0x1e),
+	AMPERE_PMU_EVENT_ATTR(retry_gnt,		0x1f),
+	AMPERE_PMU_EVENT_ATTR(rank_change,		0x20),
+	AMPERE_PMU_EVENT_ATTR(dir_change,		0x21),
+	AMPERE_PMU_EVENT_ATTR(rank_dir_change,		0x22),
+	AMPERE_PMU_EVENT_ATTR(rank_active,		0x23),
+	AMPERE_PMU_EVENT_ATTR(rank_idle,		0x24),
+	AMPERE_PMU_EVENT_ATTR(rank_pd,			0x25),
+	AMPERE_PMU_EVENT_ATTR(rank_sref,		0x26),
+	AMPERE_PMU_EVENT_ATTR(queue_fill_gt_thresh,	0x27),
+	AMPERE_PMU_EVENT_ATTR(queue_rds_gt_thresh,	0x28),
+	AMPERE_PMU_EVENT_ATTR(queue_wrs_gt_thresh,	0x29),
+	AMPERE_PMU_EVENT_ATTR(phy_updt_complt,		0x2a),
+	AMPERE_PMU_EVENT_ATTR(tz_fail,			0x2b),
+	AMPERE_PMU_EVENT_ATTR(dram_errc,		0x2c),
+	AMPERE_PMU_EVENT_ATTR(dram_errd,		0x2d),
+	AMPERE_PMU_EVENT_ATTR(read_data_return,		0x32),
+	AMPERE_PMU_EVENT_ATTR(chi_wr_data_delta,	0x33),
+	AMPERE_PMU_EVENT_ATTR(zq_start,			0x34),
+	AMPERE_PMU_EVENT_ATTR(zq_latch,			0x35),
+	AMPERE_PMU_EVENT_ATTR(wr_fifo_full,		0x36),
+	AMPERE_PMU_EVENT_ATTR(info_fifo_full,		0x37),
+	AMPERE_PMU_EVENT_ATTR(cmd_fifo_full,		0x38),
+	AMPERE_PMU_EVENT_ATTR(dfi_nop,			0x39),
+	AMPERE_PMU_EVENT_ATTR(dfi_cmd,			0x3a),
+	AMPERE_PMU_EVENT_ATTR(rd_run_len,		0x3b),
+	AMPERE_PMU_EVENT_ATTR(wr_run_len,		0x3c),
+
+	AMPERE_PMU_EVENT_CYCLE(cycle),
+	NULL,
+};
+
+static umode_t ampere_pmu_event_is_visible(struct kobject *kobj,
+					   struct attribute *attr, int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct ampere_pmu *apmu = to_ampere_pmu(dev_get_drvdata(dev));
+	struct perf_pmu_events_attr *eattr =
+		container_of(attr, struct perf_pmu_events_attr, attr.attr);
+
+	if (eattr->id == SOC_CYCLE_COUNTER_EVENT && !apmu->cycle_exists)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group ampere_pmu_events_attrs_group = {
+	.name = "events",
+	.attrs = ampere_mcu_pmu_events_attrs,
+	.is_visible = ampere_pmu_event_is_visible,
+};
+
+static ssize_t ampere_cpumask_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct ampere_pmu *apmu = to_ampere_pmu(dev_get_drvdata(dev));
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(apmu->cpu));
+}
+
+static struct device_attribute ampere_pmu_cpumask_attr =
+	__ATTR(cpumask, 0444, ampere_cpumask_show, NULL);
+
+static struct attribute *ampere_pmu_cpumask_attrs[] = {
+	&ampere_pmu_cpumask_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ampere_pmu_cpumask_attr_group = {
+	.attrs = ampere_pmu_cpumask_attrs,
+};
+
+static const struct attribute_group *ampere_pmu_attr_groups[] = {
+	&ampere_pmu_events_attrs_group,
+	&ampere_pmu_format_attr_group,
+	&ampere_pmu_cpumask_attr_group,
+	NULL,
+};
+
+static void ampere_pmu_event_config(struct perf_event *event)
+{
+	struct ampere_pmu *apmu = to_ampere_pmu(event->pmu);
+
+	writel(SOC_EVENT_THRESHOLD(event), apmu->base + SOC_PMAUXR0);
+	writel(SOC_EVENT_RANK(event), apmu->base + SOC_PMAUXR1);
+	writel(SOC_EVENT_BANK(event), apmu->base + SOC_PMAUXR2);
+}
+
+static inline u64 ampere_pmu_read_counter(struct ampere_pmu *apmu, int idx)
+{
+	u32 lo, hi, reg_high, reg_low;
+
+	if (idx == SOC_CYCLE_COUNTER_IDX) {
+		reg_low  = SOC_PMCCNTR_LO;
+		reg_high = SOC_PMCCNTR_HI;
+	} else {
+		reg_low  = SOC_PMEVCNTR_LOn(idx);
+		reg_high = SOC_PMEVCNTR_HIn(idx);
+	}
+
+	do {
+		hi = readl(apmu->base + reg_high);
+		lo = readl(apmu->base + reg_low);
+	} while (hi != readl(apmu->base + reg_high));
+
+	return (((u64)hi << 32) | lo);
+}
+
+static inline void ampere_pmu_write_counter(struct ampere_pmu *apmu, int idx, u64 val)
+{
+	if (idx == SOC_CYCLE_COUNTER_IDX) {
+		writel(lower_32_bits(val), apmu->base + SOC_PMCCNTR_LO);
+		writel(upper_32_bits(val), apmu->base + SOC_PMCCNTR_HI);
+	} else {
+		writel(lower_32_bits(val), apmu->base + SOC_PMEVCNTR_LOn(idx));
+		writel(upper_32_bits(val), apmu->base + SOC_PMEVCNTR_HIn(idx));
+	}
+}
+
+static int ampere_get_counter_idx(struct perf_event *event)
+{
+	struct ampere_pmu *apmu = to_ampere_pmu(event->pmu);
+	int idx, eventid = SOC_EVENT_EVENTID(event);
+
+	if (eventid == SOC_CYCLE_COUNTER_EVENT) {
+		if (test_and_set_bit(SOC_CYCLE_COUNTER_IDX, apmu->counter_mask))
+			return -ENOSPC;
+
+		return SOC_CYCLE_COUNTER_IDX;
+	}
+
+	for (idx = 0; idx < apmu->nr_counters; idx++)
+		if (!test_and_set_bit(idx, apmu->counter_mask))
+			return idx;
+
+	return -ENOSPC;
+}
+
+static void ampere_pmu_enable(struct pmu *pmu)
+{
+	struct ampere_pmu *apmu = to_ampere_pmu(pmu);
+	u32 val;
+
+	val = readl(apmu->base + SOC_PMCR);
+	val |= PMU_PMCR_E;
+	writel(val, apmu->base + SOC_PMCR);
+}
+
+static void ampere_pmu_disable(struct pmu *pmu)
+{
+	struct ampere_pmu *apmu = to_ampere_pmu(pmu);
+	u32 val;
+
+	val = readl(apmu->base + SOC_PMCR);
+	val &= ~PMU_PMCR_E;
+	writel(val, apmu->base + SOC_PMCR);
+}
+
+static void ampere_pmu_enable_event(struct perf_event *event)
+{
+	struct ampere_pmu *apmu = to_ampere_pmu(event->pmu);
+	struct hw_perf_event *hw = &event->hw;
+	u32 val, cnt_bit;
+	int eventid = SOC_EVENT_EVENTID(event);
+
+	if (eventid == SOC_CYCLE_COUNTER_EVENT) {
+		cnt_bit = SOC_CYCLE_COUNTER_BIT;
+	} else {
+		cnt_bit = BIT(hw->idx);
+		writel(eventid, apmu->base + SOC_PMEVTYPERn(hw->idx));
+	}
+
+	val = readl(apmu->base + SOC_PMCNTENSET);
+	val |= cnt_bit;
+	writel(val, apmu->base + SOC_PMCNTENSET);
+
+	val = readl(apmu->base + SOC_PMINTENSET);
+	val |= cnt_bit;
+	writel(val, apmu->base + SOC_PMINTENSET);
+}
+
+static void ampere_pmu_disable_event(struct perf_event *event)
+{
+	struct ampere_pmu *apmu = to_ampere_pmu(event->pmu);
+	struct hw_perf_event *hw = &event->hw;
+	u32 val, cnt_bit;
+	int eventid = SOC_EVENT_EVENTID(event);
+
+	if (eventid == SOC_CYCLE_COUNTER_EVENT)
+		cnt_bit = SOC_CYCLE_COUNTER_BIT;
+	else
+		cnt_bit = BIT(hw->idx);
+
+	val = readl(apmu->base + SOC_PMCNTENCLR);
+	val |= cnt_bit;
+	writel(val, apmu->base + SOC_PMCNTENCLR);
+
+	val = readl(apmu->base + SOC_PMINTENSET);
+	val |= cnt_bit;
+	writel(val, apmu->base + SOC_PMINTENSET);
+}
+
+static void ampere_perf_event_set_period(struct perf_event *event)
+{
+	struct ampere_pmu *apmu = to_ampere_pmu(event->pmu);
+	struct hw_perf_event *hw = &event->hw;
+
+	/*
+	 * With 64 bit counter, we don't expect the counter to
+	 * wrap past its initial value.
+	 */
+	u64 val = 1ULL << 31;
+
+	local64_set(&hw->prev_count, val);
+	ampere_pmu_write_counter(apmu, hw->idx, val);
+}
+
+static void ampere_perf_event_update(struct perf_event *event)
+{
+	struct ampere_pmu *apmu = to_ampere_pmu(event->pmu);
+	struct hw_perf_event *hw = &event->hw;
+	u64 prev_count, new_count;
+
+	do {
+		prev_count = local64_read(&hw->prev_count);
+		new_count = ampere_pmu_read_counter(apmu, hw->idx);
+	} while (local64_xchg(&hw->prev_count, new_count) != prev_count);
+
+	local64_add((new_count - prev_count) & SOC_MAX_PERIOD,
+		    &event->count);
+}
+
+static void ampere_perf_read(struct perf_event *event)
+{
+	ampere_perf_event_update(event);
+}
+
+static void ampere_perf_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hw = &event->hw;
+
+	if (WARN_ON_ONCE(!(hw->state & PERF_HES_STOPPED)))
+		return;
+
+	if (flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(hw->state & PERF_HES_UPTODATE));
+
+	hw->state = 0;
+	ampere_perf_event_set_period(event);
+
+	ampere_pmu_enable_event(event);
+	perf_event_update_userpage(event);
+}
+
+static void ampere_perf_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hw = &event->hw;
+
+	ampere_pmu_disable_event(event);
+
+	WARN_ON_ONCE(hw->state & PERF_HES_STOPPED);
+	hw->state |= PERF_HES_STOPPED;
+
+	ampere_perf_read(event);
+	hw->state |= PERF_HES_UPTODATE;
+}
+
+static int ampere_perf_validate_group(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+	struct ampere_pmu *apmu = to_ampere_pmu(event->pmu);
+	int counters = 0;
+
+	if (leader == event)
+		return 0;
+
+	if (event->pmu != leader->pmu && !is_software_event(leader))
+		return -EINVAL;
+
+	for_each_sibling_event(sibling, leader) {
+		if (is_software_event(sibling))
+			continue;
+		if (sibling->pmu != event->pmu)
+			return -EINVAL;
+		counters++;
+	}
+
+	if (counters > apmu->nr_counters)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ampere_perf_event_init(struct perf_event *event)
+{
+	struct ampere_pmu *apmu = to_ampere_pmu(event->pmu);
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+		return -EINVAL;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	event->cpu = apmu->cpu;
+
+	return ampere_perf_validate_group(event);
+}
+
+
+static int ampere_perf_add(struct perf_event *event, int flags)
+{
+	struct ampere_pmu *apmu = to_ampere_pmu(event->pmu);
+	struct hw_perf_event *hw = &event->hw;
+	int idx;
+
+	idx = ampere_get_counter_idx(event);
+	if (idx < 0)
+		return idx;
+
+	apmu->counters[idx] = event;
+	event->hw.idx = idx;
+
+	ampere_pmu_event_config(event);
+
+	hw->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	if (flags & PERF_EF_START)
+		ampere_perf_start(event, PERF_EF_RELOAD);
+
+	/* Propagate our changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static void ampere_perf_del(struct perf_event *event, int flags)
+{
+	struct ampere_pmu *apmu = to_ampere_pmu(event->pmu);
+	struct hw_perf_event *hw = &event->hw;
+	int idx = hw->idx;
+
+	ampere_perf_stop(event, PERF_EF_UPDATE);
+
+	apmu->counters[idx] = NULL;
+	clear_bit(idx, apmu->counter_mask);
+
+	perf_event_update_userpage(event);
+}
+
+static int ampere_pmu_get_version(struct ampere_pmu *apmu)
+{
+	u32 reg;
+
+	reg = readl(apmu->base + SOC_PMDEVARCH);
+	apmu->id = reg & SOC_ID_MASK;
+	apmu->version = reg & SOC_VERSION_MASK;
+
+	reg = readl(apmu->base + SOC_PMCFGR);
+	apmu->cycle_exists = reg & SOC_CYCLE_COUNTER;
+	apmu->nr_counters = reg & SOC_NR_COUNTERS_MASK;
+
+	if (apmu->nr_counters > SOC_MAX_COUNTERS) {
+		dev_err(apmu->dev, "Unsupported type (%x, %x, counters %d\n",
+			apmu->id, apmu->version, apmu->nr_counters);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static irqreturn_t ampere_pmu_handle_irq(int irq, void *dev_id)
+{
+	struct ampere_pmu *apmu = dev_id;
+	u32 status;
+	int idx, ret = IRQ_NONE;
+
+	status = readl(apmu->base + SOC_PMOVSSET);
+	if (!status)
+		goto out;
+
+	writel(status, apmu->base + SOC_PMOVSCLR);
+
+	for (idx = 0; idx < apmu->nr_counters; idx++) {
+		struct perf_event *event = apmu->counters[idx];
+		int overflowed = status & BIT(idx);
+
+		/* Ignore if we don't have an event. */
+		if (event && overflowed) {
+			ampere_perf_event_update(event);
+			ampere_perf_event_set_period(event);
+			ret = IRQ_HANDLED;
+		}
+	}
+
+	if (apmu->counters[SOC_CYCLE_COUNTER_IDX] &&
+	    status & SOC_CYCLE_COUNTER_BIT) {
+		ampere_perf_event_update(apmu->counters[SOC_CYCLE_COUNTER_IDX]);
+		ampere_perf_event_set_period(apmu->counters[SOC_CYCLE_COUNTER_IDX]);
+		ret = IRQ_HANDLED;
+	}
+
+out:
+	ampere_pmu_enable(&apmu->pmu);
+	return ret;
+}
+
+static int ampere_pmu_probe(struct platform_device *pdev)
+{
+	struct ampere_pmu *apmu;
+	static atomic_t id;
+	char *name;
+	int ret = 0;
+
+	apmu = devm_kzalloc(&pdev->dev, sizeof(*apmu), GFP_KERNEL);
+	if (!apmu)
+		return -ENOMEM;
+
+	apmu->dev = &pdev->dev;
+	platform_set_drvdata(pdev, apmu);
+
+	apmu->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(apmu->base))
+		return PTR_ERR(apmu->base);
+
+	apmu->cpu = cpumask_local_spread(0, dev_to_node(apmu->dev));
+
+	apmu->irq = platform_get_irq(pdev, 0);
+	if (apmu->irq < 0)
+		return apmu->irq;
+
+	ret = devm_request_irq(&pdev->dev, apmu->irq, ampere_pmu_handle_irq,
+			       IRQF_NOBALANCING | IRQF_SHARED,
+			       pdev->name, apmu);
+	if (ret)
+		return ret;
+
+	ret = irq_set_affinity(apmu->irq, cpumask_of(apmu->cpu));
+	if (ret)
+		return ret;
+
+	ret = ampere_pmu_get_version(apmu);
+	if (ret)
+		return ret;
+
+	apmu->pmu = (struct pmu) {
+		.module		= THIS_MODULE,
+		.attr_groups	= ampere_pmu_attr_groups,
+		.task_ctx_nr	= perf_invalid_context,
+		.pmu_enable	= ampere_pmu_enable,
+		.pmu_disable	= ampere_pmu_disable,
+		.event_init	= ampere_perf_event_init,
+		.add		= ampere_perf_add,
+		.del		= ampere_perf_del,
+		.start		= ampere_perf_start,
+		.stop		= ampere_perf_stop,
+		.read		= ampere_perf_read,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+	};
+
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "mcu%d",
+			      atomic_fetch_inc(&id));
+	if (!name)
+		return -ENOMEM;
+
+	ret = cpuhp_state_add_instance(cpuhp_state_num, &apmu->node);
+	if (ret) {
+		dev_err(&pdev->dev, "Error %d registering hotplug", ret);
+		return ret;
+	}
+
+	ret = perf_pmu_register(&apmu->pmu, name, -1);
+	if (ret)
+		cpuhp_state_remove_instance(cpuhp_state_num, &apmu->node);
+
+	return ret;
+}
+
+static int ampere_pmu_remove(struct platform_device *pdev)
+{
+	struct ampere_pmu *apmu = platform_get_drvdata(pdev);
+
+	cpuhp_state_remove_instance(cpuhp_state_num, &apmu->node);
+	perf_pmu_unregister(&apmu->pmu);
+	return 0;
+}
+
+static const struct acpi_device_id ampere_pmu_acpi_match[] = {
+	{"AMPC0100", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, ampere_pmu_acpi_match);
+
+static struct platform_driver ampere_soc_pmu_driver = {
+	.driver	= {
+		.name = "ampere-soc-pmu",
+		.acpi_match_table = ACPI_PTR(ampere_pmu_acpi_match),
+	},
+	.probe	= ampere_pmu_probe,
+	.remove	= ampere_pmu_remove,
+};
+
+static int ampere_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct ampere_pmu *apmu = hlist_entry_safe(node, struct ampere_pmu, node);
+	unsigned int target;
+
+	if (cpu != apmu->cpu)
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&apmu->pmu, cpu, target);
+	if (apmu->irq)
+		irq_set_affinity(apmu->irq, cpumask_of(apmu->cpu));
+
+	apmu->cpu = target;
+	return 0;
+}
+
+static int __init ampere_soc_pmu_init(void)
+{
+	cpuhp_state_num = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+						  "ampere-soc-pmu", NULL,
+						  ampere_pmu_offline_cpu);
+	if (cpuhp_state_num < 0)
+		return cpuhp_state_num;
+
+	return platform_driver_register(&ampere_soc_pmu_driver);
+}
+
+static void __exit ampere_soc_pmu_exit(void)
+{
+	platform_driver_unregister(&ampere_soc_pmu_driver);
+	cpuhp_remove_multi_state(cpuhp_state_num);
+}
+
+module_init(ampere_soc_pmu_init);
+module_exit(ampere_soc_pmu_exit);
+
+MODULE_LICENSE("GPL");
-- 
2.39.2

