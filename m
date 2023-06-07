Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C527257C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjFGIdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239528AbjFGId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:33:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2102.outbound.protection.outlook.com [40.107.243.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0491B1BFD;
        Wed,  7 Jun 2023 01:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXmSFKiKWtP60Nm1shUUTAd1hCx3v49mHIdzJXkNZ4wR/JXj2B/+8E56Psb2m9R/oeI5GpDuG+WqDqPbGHK/LwMQcAbV1Fr+uCAFwoIuaS+xjxBSyLk8ugCIHX6E5fQ7md0/F8jZMSO5TSaDkXoDVVG9xGvsNPbK1/+uDO5TaX94YuTTgIjmUD8v4zvErA9a+MMApzjY5gTSagHA02wEbRIl9mLQt3FIMLWNNupVVj1MBzmtkjveUYgb5zfsn5Vpjou6sraaLRi+RX+q0bmX8ocFcOk5UJBh64rkyI9cgEln77lVU52FD0u8p2/nubfWw+L/WdwZ1S8voL77oyvQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMHx0l0kalUhGd26c392PtqTJJnl0JPQWJmrDNddKio=;
 b=flo9AEINpLXR6pebzN7MV6mR7wKj72gRzU89LVDi3uCsxWdWNQkOPnQioD4sUdVv/Udf8M/jwaZXzSu7uFhHyLcBe+oXtjMNxw5jcB2sWCf8IMzr1xKBPHeYgG3EgyTmM/QFDHkiQuRj4akFo+bdeCS12V523hVf0HKIAybmMx+XtHo5gsR7H+SsAtc7fJ2MANZJF27GE/G0UrAwdym0juj+1wrh5LmYMDtiKrPcZUB7d50mVywcNE6LOwaQXBJPM6UjPvil36aEnEZWgDTDReCSWXS4WAMXh0hxUA+x5trxwF1xWfHTuj6G3AIwE3Y1MlQ1V2rhkJf3ANFW7C90MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMHx0l0kalUhGd26c392PtqTJJnl0JPQWJmrDNddKio=;
 b=DrAW/Nitkmsy2gKYG3+prYPSSS6+5n30/6BMFCmqzgRogoJpzqDh16VmewnfF41AMeLlseUWtE6pAiZMGBt1mLNzxIMPR8U1zLF3k7XK12mK4FhNR5BZw3EV2phT5FbxH0jPC1RPsaf6qm770qAEBTyOW+fuMTQQ2O04UPCenHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SJ0PR01MB6304.prod.exchangelabs.com (2603:10b6:a03:297::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Wed, 7 Jun 2023 08:32:58 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:32:57 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v3 4/4] perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU
Date:   Wed,  7 Jun 2023 01:31:39 -0700
Message-Id: <20230607083139.3498788-5-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607083139.3498788-1-ilkka@os.amperecomputing.com>
References: <20230607083139.3498788-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0009.namprd19.prod.outlook.com
 (2603:10b6:610:4d::19) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SJ0PR01MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ea2b9e-6f57-4743-56ee-08db6731cc0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jL9l2/1nCgevr/sqDzCU9X/IuSMuySqLazS3Lnsm5Nj71vx9HaS9VzGJJgoGu0g6tEubByVlBo6GvUvEYznnkJinlfePdn4P0J8tEjXg07CNeQoR+ynuZRMK4jaQM9Ec01+1lFo+HeKSQRPAlKEZOYDL0k9VsL/jlorvyPS6D5DxSztgOK8EylKX356UiBaTPshqTYvj8O2AWmekUEKI88/LLgfZCwm5fosFiruda6o+tADps+OBH+J5ilbYkbxQzLHSzWzDmGb4mryjIqMxz2wUMj2vU5hTSaBrTPzgkKP+I4HNWKmXvyAad54zCl4UPj6k4/cwm0FspuurqXDlRIQyXU6jVoqFeZdNnHUSOJNfAdyOfcwl2YdT5CA/xXOehKsd2LfWWEducTZyi63RSoTaKAHA0irR7qSZ75Z/GL0PAphxNVw2//F9x2+eHM9Sep1TdTzjGMqYoIY741siseRHcy+Rt+a+K6D6ihmLCVNEaaFVB5ws7JBHHKevO9bz6RNjs8NwAUXxJz4kxDN0Pzkoe0LRmaD2/6lOvivtokD1ULyztv0oK6x7fv1zmPyvmf+e1RthjP3Rgbq+h3YnO9JNSrcqAPaFueHVuI5Ri6sAl58peUsL78z6/+HNDPPY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(107886003)(6506007)(1076003)(186003)(26005)(6512007)(2616005)(83380400001)(52116002)(6486002)(6666004)(30864003)(2906002)(8676002)(8936002)(110136005)(478600001)(41300700001)(5660300002)(316002)(38350700002)(86362001)(38100700002)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9/W+frkZY+CWoKv1oHLKM3gQPe3Ruz5pzCFMX9F9paN2SpTcyksjU+N8DGm9?=
 =?us-ascii?Q?UfUVlAfcFO4LeYMiAbtNeQUHeaeY10VAytLHW+VHpoXTw6P0e7nMpX/DRJGi?=
 =?us-ascii?Q?/MkPib2QdJaQoITqn2hUsSL4yvntTtKjESG2H17IaryJumDYoaWtGSdmk0F2?=
 =?us-ascii?Q?QMH/9lD7H6Es1ACLwDAhlUA6ws2vWewfcKELLlmzjQawRjWicU7sCn2RlmlV?=
 =?us-ascii?Q?5bM+wyRb6tQPJ3QJr7M1Xw5AyOpAuWKvWrW+Ahz8aDoKORQXCylRJCiSbLr5?=
 =?us-ascii?Q?ePt5GCOnQO1HccTOdg31g6Xxd2vkSB8C7DXdxuYInW9bJJloTAjE+vLCfbYE?=
 =?us-ascii?Q?3d5dV7Dm9faqYYsIwZp3hlEDZkD7e1u/REtHi6I+xbOQZ5OrSEf+OK3NIxs0?=
 =?us-ascii?Q?1rhWgQtkuzZZVOX0xijBb2sGPNAH5hqxl+ThezLnSPLVHT0VkkfDEJN3QNbO?=
 =?us-ascii?Q?Yzox7d6+xJC1lFEW1kWd+e2+BbkXStgDZOIe7o8FALxDyl38WckWY3rwasNv?=
 =?us-ascii?Q?4hlyfaFw8jekM7ei6T9MufHr/g204gEmcL0BX9bV4lyI+joPvavOyo4NJFcW?=
 =?us-ascii?Q?aVqSATSOV1PFGF6NxSiNf7O9RN0LmS8RYXbsjsKuJQJLxWyuhYHChWv5B9kU?=
 =?us-ascii?Q?3iVveH3HmvPfVv6/d96kpQOTYWLHh1GVvlYOaRKU+fUBUEY/dzLVrXlw0mcl?=
 =?us-ascii?Q?lrb4p26+RlQ1s5+uKGe2xYNECNzQyusADgu5zv+q60eZbz9G47pf9uF9vXlJ?=
 =?us-ascii?Q?iRJVwZe+750K7IyiVzi2uJpe8gq8Ik0qWzdlrEGoEXP7H05seORG8wA/tETX?=
 =?us-ascii?Q?9++gCIQCrEScV5QoqJxmRqbfozvE6/vt5z8I7kUp1+AujjNPjbQfi7Ce77Xs?=
 =?us-ascii?Q?DlEuqcijhwYSCUk0r9UdXPimz64fCpkd0jMozvNOMRy2JRe94/TwS8XA5ETA?=
 =?us-ascii?Q?duXoXDuUKrzY6yeX/QvieSYOdixxiOyeDHuV8a8tHXiaD2VKnW6v1tdJjaU5?=
 =?us-ascii?Q?KlYf09zI9AdLJkNMkBLOvfq7mEmP8Qb1pbD6n+OKIiNluXcsCZ0ZvhyioBV6?=
 =?us-ascii?Q?BaDAA2mJX0rdJWhw8TrSoBKVEu4muzkG6keiaYGd92NfNFeYUUsAfDdUb8Lb?=
 =?us-ascii?Q?DFz7xu5XjHixKmKNR4U7BlU+oc1voxUO9+PSHIG1qSklMvyXYQSrM7ZSfFYk?=
 =?us-ascii?Q?3OrE1gQNNdkJDp8iPiLNzY9mC3eVogjaVzvh7VteTAHpm9Egy9Rj9uD8m9bh?=
 =?us-ascii?Q?VHsKZwQUeHgECvsm3ad3DrvLsPO4aO1nCi6f8XFoV7J/nNJdnUCLciPQItTB?=
 =?us-ascii?Q?FUnKxzV5caS+vneEToiDV6u0WUD/EGYqv91/DwGSxM9reMafnj4KFZvdSelZ?=
 =?us-ascii?Q?brV5yQmhg9eGvRpoRA5SUzuPCc6hl6kIsELwa8pW+J8Xassg5c/BCsG1oAQw?=
 =?us-ascii?Q?B3BbsJbZHx9hAuIdsuwQSSmsK0FnMgRfiXGkLRe6slhXNgVzbVI/NsM3F8pC?=
 =?us-ascii?Q?HPa/2P8mszpiNnbb7k6/dlcLdKWAHi1MUbP/GTzlcq48LPPPfJLo+cJy1E2w?=
 =?us-ascii?Q?zg0AP7iT8dU5lzILeLHc97/ceOCgQ1D3J0b+6I3hVqjEQ9KJv/z/siXDiXGo?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ea2b9e-6f57-4743-56ee-08db6731cc0e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:32:57.9245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tn+q3x4GVYhSzDaK9sBELVI+dDC/Q0DHsVMZl8SwI5Y5f3UIAJTy3EQAHw7uYXp8tYAaRBvDberwY6bLIRJW2oUAmxJ/v7WADQH7cr+GrGgMuGq6wlrs/9DQdMaPiVzd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6304
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/perf/arm_cspmu/ampere_cspmu.c         | 243 ++++++++++++++++++
 drivers/perf/arm_cspmu/ampere_cspmu.h         |  17 ++
 drivers/perf/arm_cspmu/arm_cspmu.c            |   7 +
 5 files changed, 297 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/perf/ampere_cspmu.rst
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.h

diff --git a/Documentation/admin-guide/perf/ampere_cspmu.rst b/Documentation/admin-guide/perf/ampere_cspmu.rst
new file mode 100644
index 000000000000..94f93f5aee6c
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
+  / # perf stat -a -e ampere_mcu_pmu_0/act_sent,bank=5,rank=3,threshold=2/,ampere_mcu_pmu_1/rd_sent/ \
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
index 000000000000..1c57feb4b6ce
--- /dev/null
+++ b/drivers/perf/arm_cspmu/ampere_cspmu.c
@@ -0,0 +1,243 @@
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
+static int ampere_cspmu_validate_params(struct perf_event *event, struct perf_event *event2)
+{
+	if (get_threshold(event) != get_threshold(event2) ||
+	    get_rank(event) != get_rank(event2) ||
+	    get_bank(event) != get_bank(event2))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ampere_cspmu_validate_group(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+	int ret;
+
+	ret = ampere_cspmu_validate_params(event, leader);
+	if (ret)
+		return ret;
+
+	for_each_sibling_event(sibling, leader) {
+		ret = ampere_cspmu_validate_params(sibling, leader);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ampere_cspmu_validate_event(struct arm_cspmu *cspmu,
+				       struct perf_event *new)
+{
+	struct perf_event *curr;
+	unsigned int idx;
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
+	return ampere_cspmu_validate_params(curr, new);
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
+	impl_ops->validate_group	= ampere_cspmu_validate_group;
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
index 9021d1878250..885393ed993e 100644
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

