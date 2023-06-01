Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD65E7190CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjFADD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjFADDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:03:03 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2115.outbound.protection.outlook.com [40.107.101.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B206A1BB;
        Wed, 31 May 2023 20:02:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9k+FFJP3jkMEnzKwhPYKhCkL5VruMniYmiQst81OTBKaBI+MRdC4xthUUn16rWWXh7tKsdzovGeaQOnUA55uU4cfLDJX7gr7FvWzIYF0RsnGp2P93fjSWBX/rzejOpz0kcpFG5jKKUhxDE2BVkyKNqSrzj5YAm35q5JT3T9zhJ6eDVE0VwN8ey1SNnE14p2pE+lA7E2tA3tqew1DQdhoMYt3Ah4F3pBUNOLmatbvOb3U7v1X8TUyMB5SuTV96bDeWel15TcGV29BsotPWSjXTR1kOekAhMhoZU+x2Z6ARamCOEfUnrQnW3Gsxo93QnvXQlhuOLWRiwXVyiJ7bngag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UjSodCwLS8AaxYzf9ECGf++pnN8WLNx5JYymRZDKrU=;
 b=OGcVNh74codWHgiRpn5FS0qF5LOdVBcWw+XvfZd3UtIwGPFDb9wxeo1/7+JHVltMhNQJTuj6dMSGtEpE4giRQuNJiSkptMMUweG7g0cLCTsXDut/XYfAsBeBtg5NnxT4etBpLidPZot6K3FcetQrONAtaa3IxRA86KwM6aFW2W0WNyYl7B2D9b9MT8noiHtK6QN1Rsg1SteuVIc9QFVw8OymBzTVtP+GBZCsjdpjG2WTxmlTEgoaxbIP0/vwX6PF7yh6ojB+Kcspt39JBP6HCHRBiFtoaYQ1tDGQXA2NAl8EsjHMZFZ/s/a6kVQsA5jo3Jkchc9k4KHmUFoNJnuHhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UjSodCwLS8AaxYzf9ECGf++pnN8WLNx5JYymRZDKrU=;
 b=cYFsuYHJko4v3Fi+8neYLluicMGjYZZFXQqz5fkehUjgDQ2Tl0BLSzpbYmEQu7nbiE6OZA9HUJGq3xdFWlieAMt7gTR0gnPuK0tMdiXfGGwTf8cuDT5+OL8SAS0eVHX2bNN2QmOoAcO0w/q23rUxOHZkAvyXMMuwluPkJ4FV5m8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CO1PR01MB6709.prod.exchangelabs.com (2603:10b6:303:f9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22; Thu, 1 Jun 2023 03:02:51 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 03:02:51 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v2 5/5] perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU
Date:   Wed, 31 May 2023 20:01:44 -0700
Message-Id: <20230601030144.3458136-6-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601030144.3458136-1-ilkka@os.amperecomputing.com>
References: <20230601030144.3458136-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:610:33::20) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|CO1PR01MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f52922-5a1b-4fa3-9855-08db624cb016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIme0IpDLg3ZF8KGNG+lCAQTXvPHX2Qe9xDcm0slqbAKF0SAkABTNhfttoLI8EnWYeCSRvkQ9zono+B+v0Eg1G3v+nZ2KkGWBxluCLw2/C2zOlVZ2zfveNQIqTTjHQnf/bgkenNoYbXyhhX1QY9ppCPAGW6/znnp1ly40/rI3CgCjf3Vu2OK9JJ1oZH7ZMOfSxAP067EFm01FET2o4Sma9eiimAeYJQxU/rBxHXECDnemB3Tbe1EDYGhSzur+a7j/M6RadIgL2FG+8ts9gXIc21XXfU/w+pfABKszAfKAynMDY1HgKeXYkQ+YdjbJ/7WMU4B4nbupvHqGkz7CdB/y4Vu2jusQp+xCAWOfvx0hs1rfeoue9wVNmerLIhOj/5bP/F2FUGrwJdgOl1B4aCqaHi5Ad8qG7o/3FgSduL8WmMDbPKN62ITn8i9mxBP4DaTaIQa6C99KvQIbZDf0zkj21mv4GLz14mvWog3MZ82ple0WCBv5L9sWAN3gECM1eeBOAGZv5tmouLqzq/d3Of2dTcQgOGV0ZaS/sZ/eZik45IrQb4m6gZIF/TSk1z53ZfI19XJvjPfFk+W51rs0NSteZW6nzib6AlFGolsgCSfHs5Wu7Y3oqFp+ovl2IhKspES9eForenV18bWrTqx/vf1yv80a3HQht9IgdtaXt8fUJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(316002)(30864003)(83380400001)(2906002)(110136005)(6506007)(1076003)(38100700002)(26005)(6512007)(66556008)(66476007)(4326008)(38350700002)(66946007)(86362001)(2616005)(478600001)(5660300002)(186003)(6666004)(41300700001)(52116002)(6486002)(8676002)(8936002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wR5xUETBLi6+5ei0RQt/9GTf5qpziHJNBNNOvW3bSa2Vav1N77mHXYYnWPno?=
 =?us-ascii?Q?ahZxeFAep8cyOqReRg1S0YF88+S0f6DuQ1wRyE0ovTj+6m7Q6/NSLYa65ok3?=
 =?us-ascii?Q?0gCFuW9XhLAp+gfZj16BP4Vwox1U7hQnYSNFuQyTsD+QcdADCLuq6DdYz0T4?=
 =?us-ascii?Q?uGOb6d3iyaVUv6M+yiYPckxWdAbcaabTTLbOYiyD7dTstebOt4uHGt2pLE0H?=
 =?us-ascii?Q?LsNSlyVFWAxNkU1S3Fcffz2RFCBsmr4ROBqJg8vxlCIkgoYBpUttY4UGQjLV?=
 =?us-ascii?Q?oGJCrovR9owGcLItAjSygbfHtIrMsEU6FqGZasHOy2BF0EV3NqHbHFVOOsiO?=
 =?us-ascii?Q?8XplcXA4xmqah/0uRQGBokGRoIlOW+ne2UqAd0j5dkm3VvNoFKeh9595zIur?=
 =?us-ascii?Q?4Ng9dCjzhVIeUt7Km5hEtWFt4C4v5hTNWVcZ5GDpsqvdaPGpKkYm50yb4hNu?=
 =?us-ascii?Q?p60djhF/feeF+vossNZsfxmJH9ev3xM8zl597LELaDHkFoNS5eQ3U/0gcYcU?=
 =?us-ascii?Q?TLtPyLNpr8BFCtl69rX3EdBTt/hs1b2OJmz3LQOSYv7MfpLcOzVzoQ9fBc4K?=
 =?us-ascii?Q?l6GhTXQtsdijLUkPl3F5/oB/M9jOAAcOXXS1vzBaCoUSPLmk7lnLCcCxT8G3?=
 =?us-ascii?Q?GMtqqZXCc0/TSnQHp15Dhhz0+StlmBznSIcyXQDNTzUXqJYlqlJGoXClFLf/?=
 =?us-ascii?Q?IIfab24eVXodIrTDtlIZMHdn8lt+lBlSe8YrraHRl2y4FLRtF4Fho0KOn881?=
 =?us-ascii?Q?Kt6horhZRB6V8wT/ANo7L9hLY8crS9FYV2059ruEeJYf0+j3Q7X4pxLUYQ1H?=
 =?us-ascii?Q?rxGEQhZ6PC4MEegIMmbBklHOT9aTUPal3qeu9z/5Iq5j/3IgtHV9khayX5DY?=
 =?us-ascii?Q?30wzdieFk8cL8mGyAagB7A5k/iDw3lan++dTeHxr04ItX4PwFmv87RcQyMcy?=
 =?us-ascii?Q?a10m68lImj0IzwFz13mQ8e2m4KXfwJB2KxY5mKHkqL+o/c6LLCuAUeys1dHX?=
 =?us-ascii?Q?V4Pnj+NlcBQlAgG/YV+BKUZfs7/8R6Uqyyz0Six4MzFOe/Dx1t2tlcLxbccx?=
 =?us-ascii?Q?jg+JW3Ye6IIpKk+TSJ/K5AneTa8RPkMpL3g1svGeXcT9YSVSe81FgkOLNJF1?=
 =?us-ascii?Q?flY5wqxu7R3U9FsTGESkmtG8Wu2z2ryV4PMqqKyuoJc8k84GhOYirQ/yntOg?=
 =?us-ascii?Q?tvzfFN11IMa1nUjP9bwjWvbhS+uR0SLviyg6F2iYbUBR8r1BBWH68+ZtXE6C?=
 =?us-ascii?Q?B+2Zr65bbfhr01Ndg2GkunSfny2051ET3OA2LPPCey3Xk+7GrekJ/yIjcXtn?=
 =?us-ascii?Q?J58+CAjz2hrkE7E+MjcgCUI0nWK87uWpYTPQHNM22kfpgf0ZBlZz7Ic4Ul12?=
 =?us-ascii?Q?vKqE7FbUKpsbXygWRL7dDBGFc+jNiKybM6LzilxAB9hhIoEJ6eblimgmbPYF?=
 =?us-ascii?Q?KKP4DHl3yFHqry0JN55l+gAL6GaR2mppLUDRerJ4XFJ+2wCqLsHJtiBeCkvI?=
 =?us-ascii?Q?qohr6hCMMAKsTyH9ytJ6nTUL0wzZSAJZjmf0Rc826+MdW/Ty1Xmlbrj9hbqt?=
 =?us-ascii?Q?oy8gtO1y+d7grvJr1m8H1nf9p1W3grAkpFXc3yLgpH/O3WK1UbWRc8eM1Krp?=
 =?us-ascii?Q?khJmYxGM1oRxOssyMuPwui4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f52922-5a1b-4fa3-9855-08db624cb016
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 03:02:51.6045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JqitznBlr9i1GSRRfJpBTLJNa3JtYLcAzF+NVoLSxTmOx4a9vQPWOv25bA5pcV3vygHxObtZlkkTZSFrq+rynAfD2zoOA3rydPr97Bzf5nMiHJmz3xJHF9W2iFELkN3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6709
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ampere SoC PMU follows CoreSight PMU architecture. It uses implementation
specific registers to filter events rather than PMEVFILTnR registers.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../admin-guide/perf/ampere_cspmu.rst         |  30 +++
 drivers/perf/arm_cspmu/Makefile               |   2 +-
 drivers/perf/arm_cspmu/ampere_cspmu.c         | 232 ++++++++++++++++++
 drivers/perf/arm_cspmu/ampere_cspmu.h         |  17 ++
 drivers/perf/arm_cspmu/arm_cspmu.c            |   7 +
 5 files changed, 287 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/perf/ampere_cspmu.rst
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.h

diff --git a/Documentation/admin-guide/perf/ampere_cspmu.rst b/Documentation/admin-guide/perf/ampere_cspmu.rst
new file mode 100644
index 000000000000..8da877f2a8c3
--- /dev/null
+++ b/Documentation/admin-guide/perf/ampere_cspmu.rst
@@ -0,0 +1,30 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================
+Ampere SoC Performance Monitoring Unit (PMU)
+============================================
+
+Ampere SoC PMU is a generic PMU IP that follows Arm CoreSight PMU architecture.
+Therefore, the driver is implemented as a submodule of arm_cspmu driver. At the
+first phase it's used for counting MCU events on AmpereOne.
+
+
+MCU PMU events
+--------------
+
+The PMU driver supports setting filters for "rank", "bank", and "threshold".
+Note, that the filters are per PMU instance rather than per event. To enable
+filters, one needs to set "filter_enable=1".
+
+
+Example for perf tool use::
+
+  / # perf list ampere
+
+    ampere_mcu_pmu_0/act_sent/                         [Kernel PMU event]
+    <...>
+    ampere_mcu_pmu_1/rd_sent/                          [Kernel PMU event]
+    <...>
+
+  / # perf stat -a -e ampere_mcu_pmu_0/act_sent,filter_enable=3,bank=5,rank=3,threshold=2/,ampere_mcu_pmu_1/rd_sent/ \
+        sleep 1
diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
index fedb17df982d..b80a8bd8da54 100644
--- a/drivers/perf/arm_cspmu/Makefile
+++ b/drivers/perf/arm_cspmu/Makefile
@@ -3,4 +3,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu_module.o
-arm_cspmu_module-y := arm_cspmu.o nvidia_cspmu.o
+arm_cspmu_module-y := arm_cspmu.o nvidia_cspmu.o ampere_cspmu.o
diff --git a/drivers/perf/arm_cspmu/ampere_cspmu.c b/drivers/perf/arm_cspmu/ampere_cspmu.c
new file mode 100644
index 000000000000..9101e0446a68
--- /dev/null
+++ b/drivers/perf/arm_cspmu/ampere_cspmu.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ampere SoC PMU (Performance Monitor Unit)
+ *
+ * Copyright (c) 2023, Ampere Computing LLC
+ */
+
+#include "ampere_cspmu.h"
+
+#define PMAUXR0		0xD80
+#define PMAUXR1		0xD84
+#define PMAUXR2		0xD88
+#define PMAUXR3		0xD8C
+
+#define to_ampere_cspmu_ctx(cspmu)	((struct ampere_cspmu_ctx *)(cspmu->impl.ctx))
+
+struct ampere_cspmu_ctx {
+	const char *name;
+	struct attribute **event_attr;
+	struct attribute **format_attr;
+};
+
+#define SOC_PMU_EVENT_ATTR_EXTRACTOR(_name, _config, _start, _end)        \
+	static inline u32 get_##_name(const struct perf_event *event)     \
+	{                                                                 \
+		return FIELD_GET(GENMASK_ULL(_end, _start),               \
+				 event->attr._config);                    \
+	}                                                                 \
+
+SOC_PMU_EVENT_ATTR_EXTRACTOR(event, config, 0, 8);
+SOC_PMU_EVENT_ATTR_EXTRACTOR(threshold, config1, 0, 7);
+SOC_PMU_EVENT_ATTR_EXTRACTOR(rank, config1, 8, 23);
+SOC_PMU_EVENT_ATTR_EXTRACTOR(bank, config2, 0, 31);
+SOC_PMU_EVENT_ATTR_EXTRACTOR(filter_enable, config2, 32, 32);
+
+static struct attribute *ampereone_mcu_pmu_event_attrs[] = {
+	ARM_CSPMU_EVENT_ATTR(cycle_count,		0x00),
+	ARM_CSPMU_EVENT_ATTR(act_sent,			0x01),
+	ARM_CSPMU_EVENT_ATTR(pre_sent,			0x02),
+	ARM_CSPMU_EVENT_ATTR(rd_sent,			0x03),
+	ARM_CSPMU_EVENT_ATTR(rda_sent,			0x04),
+	ARM_CSPMU_EVENT_ATTR(wr_sent,			0x05),
+	ARM_CSPMU_EVENT_ATTR(wra_sent,			0x06),
+	ARM_CSPMU_EVENT_ATTR(pd_entry_vld,		0x07),
+	ARM_CSPMU_EVENT_ATTR(sref_entry_vld,		0x08),
+	ARM_CSPMU_EVENT_ATTR(prea_sent,			0x09),
+	ARM_CSPMU_EVENT_ATTR(pre_sb_sent,		0x0a),
+	ARM_CSPMU_EVENT_ATTR(ref_sent,			0x0b),
+	ARM_CSPMU_EVENT_ATTR(rfm_sent,			0x0c),
+	ARM_CSPMU_EVENT_ATTR(ref_sb_sent,		0x0d),
+	ARM_CSPMU_EVENT_ATTR(rfm_sb_sent,		0x0e),
+	ARM_CSPMU_EVENT_ATTR(rd_rda_sent,		0x0f),
+	ARM_CSPMU_EVENT_ATTR(wr_wra_sent,		0x10),
+	ARM_CSPMU_EVENT_ATTR(raw_hazard,		0x11),
+	ARM_CSPMU_EVENT_ATTR(war_hazard,		0x12),
+	ARM_CSPMU_EVENT_ATTR(waw_hazard,		0x13),
+	ARM_CSPMU_EVENT_ATTR(rar_hazard,		0x14),
+	ARM_CSPMU_EVENT_ATTR(raw_war_waw_hazard,	0x15),
+	ARM_CSPMU_EVENT_ATTR(hprd_lprd_wr_req_vld,	0x16),
+	ARM_CSPMU_EVENT_ATTR(lprd_req_vld,		0x17),
+	ARM_CSPMU_EVENT_ATTR(hprd_req_vld,		0x18),
+	ARM_CSPMU_EVENT_ATTR(hprd_lprd_req_vld,		0x19),
+	ARM_CSPMU_EVENT_ATTR(prefetch_tgt,		0x1a),
+	ARM_CSPMU_EVENT_ATTR(wr_req_vld,		0x1b),
+	ARM_CSPMU_EVENT_ATTR(partial_wr_req_vld,	0x1c),
+	ARM_CSPMU_EVENT_ATTR(rd_retry,			0x1d),
+	ARM_CSPMU_EVENT_ATTR(wr_retry,			0x1e),
+	ARM_CSPMU_EVENT_ATTR(retry_gnt,			0x1f),
+	ARM_CSPMU_EVENT_ATTR(rank_change,		0x20),
+	ARM_CSPMU_EVENT_ATTR(dir_change,		0x21),
+	ARM_CSPMU_EVENT_ATTR(rank_dir_change,		0x22),
+	ARM_CSPMU_EVENT_ATTR(rank_active,		0x23),
+	ARM_CSPMU_EVENT_ATTR(rank_idle,			0x24),
+	ARM_CSPMU_EVENT_ATTR(rank_pd,			0x25),
+	ARM_CSPMU_EVENT_ATTR(rank_sref,			0x26),
+	ARM_CSPMU_EVENT_ATTR(queue_fill_gt_thresh,	0x27),
+	ARM_CSPMU_EVENT_ATTR(queue_rds_gt_thresh,	0x28),
+	ARM_CSPMU_EVENT_ATTR(queue_wrs_gt_thresh,	0x29),
+	ARM_CSPMU_EVENT_ATTR(phy_updt_complt,		0x2a),
+	ARM_CSPMU_EVENT_ATTR(tz_fail,			0x2b),
+	ARM_CSPMU_EVENT_ATTR(dram_errc,			0x2c),
+	ARM_CSPMU_EVENT_ATTR(dram_errd,			0x2d),
+	ARM_CSPMU_EVENT_ATTR(read_data_return,		0x32),
+	ARM_CSPMU_EVENT_ATTR(chi_wr_data_delta,		0x33),
+	ARM_CSPMU_EVENT_ATTR(zq_start,			0x34),
+	ARM_CSPMU_EVENT_ATTR(zq_latch,			0x35),
+	ARM_CSPMU_EVENT_ATTR(wr_fifo_full,		0x36),
+	ARM_CSPMU_EVENT_ATTR(info_fifo_full,		0x37),
+	ARM_CSPMU_EVENT_ATTR(cmd_fifo_full,		0x38),
+	ARM_CSPMU_EVENT_ATTR(dfi_nop,			0x39),
+	ARM_CSPMU_EVENT_ATTR(dfi_cmd,			0x3a),
+	ARM_CSPMU_EVENT_ATTR(rd_run_len,		0x3b),
+	ARM_CSPMU_EVENT_ATTR(wr_run_len,		0x3c),
+
+	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
+	NULL,
+};
+
+static struct attribute *ampereone_mcu_format_attrs[] = {
+	ARM_CSPMU_FORMAT_EVENT_ATTR,
+	ARM_CSPMU_FORMAT_ATTR(threshold, "config1:0-7"),
+	ARM_CSPMU_FORMAT_ATTR(rank, "config1:8-23"),
+	ARM_CSPMU_FORMAT_ATTR(bank, "config2:0-31"),
+	ARM_CSPMU_FORMAT_ATTR(filter_enable, "config2:32"),
+	NULL,
+};
+
+static struct attribute **
+ampere_cspmu_get_event_attrs(const struct arm_cspmu *cspmu)
+{
+	const struct ampere_cspmu_ctx *ctx = to_ampere_cspmu_ctx(cspmu);
+
+	return ctx->event_attr;
+}
+
+static struct attribute **
+ampere_cspmu_get_format_attrs(const struct arm_cspmu *cspmu)
+{
+	const struct ampere_cspmu_ctx *ctx = to_ampere_cspmu_ctx(cspmu);
+
+	return ctx->format_attr;
+}
+
+static const char *
+ampere_cspmu_get_name(const struct arm_cspmu *cspmu)
+{
+	const struct ampere_cspmu_ctx *ctx = to_ampere_cspmu_ctx(cspmu);
+
+	return ctx->name;
+}
+
+static u32 ampere_cspmu_event_filter(const struct perf_event *event)
+{
+	return 0;
+}
+
+static void ampere_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
+				       struct hw_perf_event *hwc,
+				       u32 filter)
+{
+	struct perf_event *event;
+	unsigned int idx;
+	u32 threshold = 0, rank = 0, bank = 0;
+
+	/*
+	 * At this point, all the events have the same filter settings.
+	 * Therefore, take the first event and use its configuration.
+	 */
+	idx = find_first_bit(cspmu->hw_events.used_ctrs,
+			     cspmu->cycle_counter_logical_idx);
+
+	event = cspmu->hw_events.events[idx];
+	if (get_filter_enable(event)) {
+		threshold	= get_threshold(event);
+		rank		= get_rank(event);
+		bank		= get_bank(event);
+	}
+
+	writel(threshold, cspmu->base0 + PMAUXR0);
+	writel(rank, cspmu->base0 + PMAUXR1);
+	writel(bank, cspmu->base0 + PMAUXR2);
+}
+
+static bool ampere_cspmu_validate_event(struct arm_cspmu *cspmu,
+					struct perf_event *new)
+{
+	struct perf_event *curr;
+	unsigned int idx;
+	u32 threshold = 0, rank = 0, bank = 0;
+
+	/* We compare the global filter settings to existing events */
+	idx = find_first_bit(cspmu->hw_events.used_ctrs,
+			     cspmu->cycle_counter_logical_idx);
+
+	/* This is the first event */
+	if (idx == cspmu->cycle_counter_logical_idx)
+		return true;
+
+	curr = cspmu->hw_events.events[idx];
+
+	if (get_filter_enable(new)) {
+		threshold	= get_threshold(new);
+		rank		= get_rank(new);
+		bank		= get_bank(new);
+	}
+
+	if (get_filter_enable(new) != get_filter_enable(curr) ||
+	    get_threshold(curr) != threshold ||
+	    get_rank(curr) != rank ||
+	    get_bank(curr) != bank)
+		return false;
+
+	return true;
+}
+
+static char *ampere_cspmu_format_name(const struct arm_cspmu *cspmu,
+				      const char *name_pattern)
+{
+	struct device *dev = cspmu->dev;
+	static atomic_t pmu_generic_idx = {0};
+
+	return devm_kasprintf(dev, GFP_KERNEL, name_pattern,
+			      atomic_fetch_inc(&pmu_generic_idx));
+}
+
+int ampere_cspmu_init_ops(struct arm_cspmu *cspmu)
+{
+	struct device *dev = cspmu->dev;
+	struct ampere_cspmu_ctx *ctx;
+	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
+
+	ctx = devm_kzalloc(dev, sizeof(struct ampere_cspmu_ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+
+	ctx->event_attr		= ampereone_mcu_pmu_event_attrs;
+	ctx->format_attr	= ampereone_mcu_format_attrs;
+	ctx->name		= ampere_cspmu_format_name(cspmu,
+							   "ampere_mcu_pmu_%u");
+	cspmu->impl.ctx = ctx;
+	cspmu->impl.split_64bit_access	= true;
+
+	impl_ops->event_filter		= ampere_cspmu_event_filter;
+	impl_ops->set_ev_filter		= ampere_cspmu_set_ev_filter;
+	impl_ops->validate_event	= ampere_cspmu_validate_event;
+	impl_ops->get_name		= ampere_cspmu_get_name;
+	impl_ops->get_event_attrs	= ampere_cspmu_get_event_attrs;
+	impl_ops->get_format_attrs	= ampere_cspmu_get_format_attrs;
+
+	return 0;
+}
diff --git a/drivers/perf/arm_cspmu/ampere_cspmu.h b/drivers/perf/arm_cspmu/ampere_cspmu.h
new file mode 100644
index 000000000000..9b3e1628d1d6
--- /dev/null
+++ b/drivers/perf/arm_cspmu/ampere_cspmu.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Ampere SoC PMU (Performance Monitor Unit)
+ *
+ * Copyright (c) 2023, Ampere Computing LLC
+ */
+
+#ifndef __AMPERE_CSPMU_H__
+#define __AMPERE_CSPMU_H__
+
+#include "arm_cspmu.h"
+
+/* Allocate AMPERE descriptor. */
+int ampere_cspmu_init_ops(struct arm_cspmu *cspmu);
+
+#endif /* __AMPERE_CSPMU_H__ */
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index a26f484e06b1..42b57f353777 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -30,6 +30,7 @@
 #include <linux/platform_device.h>
 #include <acpi/processor.h>
 
+#include "ampere_cspmu.h"
 #include "arm_cspmu.h"
 #include "nvidia_cspmu.h"
 
@@ -119,6 +120,7 @@
 
 /* JEDEC-assigned JEP106 identification code */
 #define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
+#define ARM_CSPMU_IMPL_ID_AMPERE		0xA16
 
 static unsigned long arm_cspmu_cpuhp_state;
 
@@ -394,6 +396,11 @@ static const struct impl_match impl_match[] = {
 	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
 	  .impl_init_ops = nv_cspmu_init_ops
 	},
+	{
+	  .pmiidr = ARM_CSPMU_IMPL_ID_AMPERE,
+	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
+	  .impl_init_ops = ampere_cspmu_init_ops
+	},
 	{}
 };
 
-- 
2.40.1

