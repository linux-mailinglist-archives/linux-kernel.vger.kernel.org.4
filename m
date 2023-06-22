Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF6E739451
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjFVBM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjFVBMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:12:49 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2116.outbound.protection.outlook.com [40.107.95.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B93A1BD9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 18:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WL/pf9TTPuUaEze8YYGOkuMyRIcPFEdIohwPIOlscNIsLIEez5Yzx8x6JSjDIIaJMDAOpyqJWPxVrACr44d12TU+JlDMxm4KCHq98GmOsYuovAtVFV5L0NwbkjdlKEDCdPpWb36b2Bm3Qp45ISy7xK29gpYzhGvxZVh396TUmM4azBoud1L+v7Ka72J4AqGoM3IaGRrsLK4oAEiwYgNmjc8LaaWSqqiakPiiDpBv1GlnZ2D8t34B0sg6xMhHBOoadfHI8xnaJj8pUu/Xz4kzeslC3vB87/s0+Ju4Q0j280EqVg+ABouzJEigyy0+BtB4hAasrRJp8a6bJilFyro2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty7h61NH/aqjod1K1j+vBv8EmKWo6p+iMP5xswS5Pic=;
 b=gMdSUJ+bZhZ3bDa/oJTH/+m7NTmdyqmuAdTui/JrefojlFGdjY6g49RQyUAqD/7fpEI02MaEGv66rm3LF/8ff9MTGkP/0M4+EI9CsGQqLdZvTnPQB4hdVnSEfJueJZPXBcXM6YxT5zr8NT5wq+2snFkLn5XuOEnDu2TMY8171gEk9klQtiW+Q6RTAQBB1bwrqB1Dy1WgJfwHhwoqCMMLMS9ucyu+QsyQXV+wCruv3fk6pPcRtK6EMqFqLuwm4PjoXXZ7viSdLVUED5OyLkY8oEPCdMocLyfgkRD1l5XVhCu0AAbWqeaUGR9dTFBR4qJhQv80huEL2CoZ7lyULske2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty7h61NH/aqjod1K1j+vBv8EmKWo6p+iMP5xswS5Pic=;
 b=iX350sP+jZ6mZnoJKrK1Z/LnEAS2z5xL4dJqvwwd38ZQ8I3RcUBq6iDs+qqb78BpXJnI0C+meJ4RgjsDc/fmcGZqkklUGMqAPMVbHrqzffDDeac6S086XJIIo04KJtMjGFYymTevf4Hm3H7KrRAh0f31ZHRg9jqG0UQbpnQH9r4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DS7PR01MB7805.prod.exchangelabs.com (2603:10b6:8:7c::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Thu, 22 Jun 2023 01:12:39 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621%4]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 01:12:39 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU
Date:   Wed, 21 Jun 2023 18:11:41 -0700
Message-Id: <20230622011141.328029-5-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622011141.328029-1-ilkka@os.amperecomputing.com>
References: <20230622011141.328029-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:610:b1::22) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|DS7PR01MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: a9da79b9-ecb1-470f-8486-08db72bdc5c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVAybRCmso13uuuEZDoP8f5bc7w2rZ1P/HkUEjDYF61sD5QVcwhh6mh/Y8sHtJ81eYtWg6Bv+TqCrbSWGt8Cj/nbBBY6GBFjT3fbi4YK2hTCqsQ98h11K2WOupESv7aLhLZlLTuTvu12EaKF0nTHxHGIxgYrbXDrMHZWKn6n1hQT7RpUoq0mkq6kQdsMymrou0HQnnyVNbVHTIX3IDZF4D5TS4OZ3KRvo9oModvZna6ujkGHzuKc1itusNiy/98qva+86JRvOs2LrmRS3+oMShToWkiSzUUgMvstnNKWsrs78hgJOKEU8nBQGw99PRguIpNnxR4kj4XK7qIld/Jc1OwoRbPbWafo9y5RhepXJvTByPltLAZpy5F/YkOVDr5PLzvHm4/zbWSTxHcvn0BHJwRh1M9ebkNeeh5sBqnoJKGD432zkyI+sexVL0fG2aHsFngM7kJDafD7CookGxCJREr5QtV/bpBrKZjUvDMMQ6JelxRjp6tRzr3HDM6k+pm36ZwGQxz8x5Kau/ewmLOFyJ8RThuhcjuihhYkVnXaBlmleIH/4Jgpek1pRb7ik0nN0A3xNghhNlQQ/JjGUaRCJ4CSIJ3G0C+eRBc/ggdIoj6TFPVgTZexnmjJHkrilKpj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(346002)(136003)(366004)(396003)(451199021)(8936002)(41300700001)(186003)(8676002)(26005)(1076003)(6506007)(2906002)(6512007)(86362001)(110136005)(66476007)(66556008)(4326008)(66946007)(6486002)(6666004)(316002)(38350700002)(38100700002)(478600001)(52116002)(2616005)(83380400001)(30864003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?USw9BD6nzBn8P9ApKp37Rvkg7ewLO540zN9RfhdWq+AwI/wQ0VgaOWBrtP+D?=
 =?us-ascii?Q?NU8O/jkvcJF3OSvmnYXRNgXMXUUwEcSH0vD8o0Iyrj09aCpmujNawnhwjJGh?=
 =?us-ascii?Q?vF8Aw52HeXajjF0WjN80wpsuqM/pJI4Pn2rSID41wd7Qry6v/6apBgDP/LiG?=
 =?us-ascii?Q?PfYEJBnxJYZNW3mXfUIeMprj4s9jhvoVyj74Oh7diIR8QiUFDz+ccm7LxqBq?=
 =?us-ascii?Q?+F1MIGAeH3zLM/2DRJ8o7RJ2lCsj4PM/XAo5kxUaMxdXWO8tvTf4U4V0RciH?=
 =?us-ascii?Q?QzGltQ0YAjuoCu3qITQQYMWhXWWMbl70DWvf3Kf1bNPwG461V9oV3+/Kn/aH?=
 =?us-ascii?Q?ABiycriqrDque5X4MmR8uVuf0yRrFtjQIJCFnttYDC3STd2q4bGz5ura6cOi?=
 =?us-ascii?Q?4VnTvvD/2IddD78i8OJEqyZ1yxp3ggsa3Rw6On8f+LhgIHcduMkChFMUpUo2?=
 =?us-ascii?Q?E4frdp1sSJzQ9MFrKqJySG8goMLn5nfLXA8RuvSMYTixPfQd4FA4SLnn5T+i?=
 =?us-ascii?Q?o83YgzEFfhfCiaze0J9VCMYBqXTVUDSObaqbbskI+MCm2Krf1LiyydEd+V0s?=
 =?us-ascii?Q?wrvxn5txJ9v+jzmQCF58PTbutwMdug9jlnA5NN2FXLl5mhgQlKtE3NSHJadu?=
 =?us-ascii?Q?IslyxdLYN9bOO4pRa384UqfKhNO7IMs9mXh2oRyShyvDVA7iR8hVcR05bdya?=
 =?us-ascii?Q?LX3ow6mS75Es8qtwhfrXwiQwejnkE/oJSC89cXZ1iV1DM0QfFLQgFkV2RthJ?=
 =?us-ascii?Q?Yw8fGcZXdfAIuO/jBvbF9zIZH36VOLYjJuQyM7lFQE6o5RYGc9Y7ZMqDeTC1?=
 =?us-ascii?Q?iEV9p8xP2ayrpm/T0a3LuaBmIDyMJyNt4OD69f2ekyMmo9jGz++FX2dhOZVt?=
 =?us-ascii?Q?8IIxPsWf+DryCK2tMcISIk6tfMLOhYvWyNEa2aJiBlsKdlz0snU8RnW25Zyj?=
 =?us-ascii?Q?746NnzgT5VFiWFi9cn/Vzsk2hx1RFrSWtePuYASuKvItBujFVH4TfhiKoXU7?=
 =?us-ascii?Q?BftSC9wbl6Mr1i9lcHufnwXZBZMRcoNHkkqV+bLXWexoU7LmMauWs0QWbQ2h?=
 =?us-ascii?Q?o3vRkXv9xZCL9I563SfnjMBdT0fXSAfIzbjQu9yXyfPWburupMWNDcux+Ivi?=
 =?us-ascii?Q?qrErV+2S36GWeE6RkuKxoBkv4jGy391yK1vYaFq6frgWvqfwbibJPgsR+6K9?=
 =?us-ascii?Q?oorFYik0bvg90jkxsQmwTACxupflaVG+OGuRWV3FQ2VR2o7rKp+Up2sU0s74?=
 =?us-ascii?Q?mkYWgSl4ZmefQ8m1WHad4WMaQ8+Kb6nePNRLwwJatjrDwKDfo+qMIhDYz5XS?=
 =?us-ascii?Q?g51/6rrvgBWHsR6PYXon2Cw1WOLxtt1P1Q4ywoCfVw/4HgQNTmLwfHM4IsM/?=
 =?us-ascii?Q?RawhfbQBrUzUVszJa55ymQ+1l2UDKUx32yLGBzzuOM3KwQbPNo0jMdeXVoHk?=
 =?us-ascii?Q?cJ6nFtlYLfjXXz92kl2a0wGAL03FJEQDaC8kAHe1wj+spSoysWyfI3+OLBr/?=
 =?us-ascii?Q?k7F2wQEfbDEYU+M0k+idRzA+LEWoYIblJsdabNh8oFXZVJd24gztSGDDztCs?=
 =?us-ascii?Q?YeNIqYj8mK9KZC0AvbQXfFGv4wwdz48bY9Y59v3ecp3ARywGsm9fe8ybMaEJ?=
 =?us-ascii?Q?B7AMYgf1FfPoH0q1g9RzygY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9da79b9-ecb1-470f-8486-08db72bdc5c9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 01:12:39.7275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWIaxcTQp/5PQgwSNTeKftj3eeo26Vx7+sn52+m745vtWrSvMUo8eOVyZYMnPyU/9tSk24HsyliH97kB8eRTBV06YigYR1t3QPL+QNLG8W6WvMZm99MH+LxFSJavHXXO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7805
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
 .../admin-guide/perf/ampere_cspmu.rst         |  29 +++
 drivers/perf/arm_cspmu/Makefile               |   2 +-
 drivers/perf/arm_cspmu/ampere_cspmu.c         | 232 ++++++++++++++++++
 drivers/perf/arm_cspmu/ampere_cspmu.h         |  17 ++
 drivers/perf/arm_cspmu/arm_cspmu.c            |   7 +
 5 files changed, 286 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/perf/ampere_cspmu.rst
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.h

diff --git a/Documentation/admin-guide/perf/ampere_cspmu.rst b/Documentation/admin-guide/perf/ampere_cspmu.rst
new file mode 100644
index 000000000000..bf86bffeef63
--- /dev/null
+++ b/Documentation/admin-guide/perf/ampere_cspmu.rst
@@ -0,0 +1,29 @@
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
+Note, that the filters are per PMU instance rather than per event.
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
index 000000000000..62dc893c94c1
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
+	u32 threshold, rank, bank;
+
+	/*
+	 * At this point, all the events have the same filter settings.
+	 * Therefore, take the first event and use its configuration.
+	 */
+	idx = find_first_bit(cspmu->hw_events.used_ctrs,
+			     cspmu->cycle_counter_logical_idx);
+
+	event = cspmu->hw_events.events[idx];
+
+	threshold	= get_threshold(event);
+	rank		= get_rank(event);
+	bank		= get_bank(event);
+
+	writel(threshold, cspmu->base0 + PMAUXR0);
+	writel(rank, cspmu->base0 + PMAUXR1);
+	writel(bank, cspmu->base0 + PMAUXR2);
+}
+
+static int ampere_cspmu_validate_configs(struct perf_event *event,
+					 struct perf_event *event2)
+{
+	if (get_threshold(event) != get_threshold(event2) ||
+	    get_rank(event) != get_rank(event2) ||
+	    get_bank(event) != get_bank(event2))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ampere_cspmu_validate_event(struct arm_cspmu *cspmu,
+				       struct perf_event *new)
+{
+	struct perf_event *curr, *leader = new->group_leader;
+	unsigned int idx;
+	int ret;
+
+	ret = ampere_cspmu_validate_configs(new, leader);
+	if (ret)
+		return ret;
+
+	/* We compare the global filter settings to existing events */
+	idx = find_first_bit(cspmu->hw_events.used_ctrs,
+			     cspmu->cycle_counter_logical_idx);
+
+	/* This is the first event */
+	if (idx == cspmu->cycle_counter_logical_idx)
+		return 0;
+
+	curr = cspmu->hw_events.events[idx];
+
+	return ampere_cspmu_validate_configs(curr, new);
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
+	ctx->event_attr		= ampereone_mcu_pmu_event_attrs;
+	ctx->format_attr	= ampereone_mcu_format_attrs;
+	ctx->name		= ampere_cspmu_format_name(cspmu,
+							   "ampere_mcu_pmu_%u");
+	cspmu->impl.ctx = ctx;
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
+
+MODULE_LICENSE("GPL v2");
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
index 471d6d7ac81a..587515eea0b4 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -29,6 +29,7 @@
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 
+#include "ampere_cspmu.h"
 #include "arm_cspmu.h"
 #include "nvidia_cspmu.h"
 
@@ -114,6 +115,7 @@
 
 /* JEDEC-assigned JEP106 identification code */
 #define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
+#define ARM_CSPMU_IMPL_ID_AMPERE		0xA16
 
 static unsigned long arm_cspmu_cpuhp_state;
 
@@ -388,6 +390,11 @@ static const struct impl_match impl_match[] = {
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

