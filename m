Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF467257B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbjFGIdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbjFGIc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:32:57 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2102.outbound.protection.outlook.com [40.107.243.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1959A199A;
        Wed,  7 Jun 2023 01:32:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCgeJ1WaOVE1i9+jWkVoPTaWYjcrSjW2U4dRcbNblPkLNTtJVDmBTRhAdgix1FlFQnK1IgvkrQUNJ+yWtaVbCa40n/eo5PYX5TRELiG8AQNydm4PtsjCk2BRQWne2FMe/gCpt5OhsXDgl2fbo52K1M1lvq+j6pVMiuGKpCIxM1Eu6TQMneui0qLNgyE822Pgy99FDoq/wee7Soai4dyWJ/LWFQNyfWXOnSp3tQhxpc0RkcRWlbBk2uGiDHtU03tBv8NRipw2TK4TADIyzeO2pFZhKPjIgkSxqQ6naeep08cNl9tNkAKi0Lu21Ehgf1Q5eRmb8RqV0Vl34zqT4LIlOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0eoh+Vvo8fahUMSQ/WbE/8KYLoyFe/I0uhsa3+sAt4=;
 b=DCEhp/pLzpibRxCja7I4FhfEatjw6bw56YFjUjhXY5bo0Oy0K0Dx6xZBNDUV4uYkx3eOzRs/ERXLLPEQvwsbj+zz5w6F00DK7WIw65hh3tH724EcUYdr51O/CR+PO5zsNQrVf7jnqXmU1kwSAR1JgLC2XaiA0wyRCfrE+v+euCphApUbLE77ZMmJJqP/FGvGD87vhN25VwCrNzCaZg/3PQL4o8WGvqOsHM2E9FK6RplYNaBBWRvZwhIW+IUuQx9xPqYsQ71iiBtHtpBVppnsZMb0TPynwJURQYTs3J8PMQJG6IhGuPO1wZzA2PWDZVcwNxaxbEnWhil7sCe4gzzv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0eoh+Vvo8fahUMSQ/WbE/8KYLoyFe/I0uhsa3+sAt4=;
 b=oz38jWuBYXEBfTzj2RO0sLiw82zJHuPecL73JO4SGV4vxX5I3EELBPhqd37oPDZLWzyYXZF4Jr1VQeQx1l4FVeYYvxsFrqZ9f5JHArHHH1XrbHCQdtE7AUDgbZiCW+a3y51KJ/fPtJP/PuA7whAh3uQxrRvxVpvxIGZA3wqLlVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SJ0PR01MB6304.prod.exchangelabs.com (2603:10b6:a03:297::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Wed, 7 Jun 2023 08:32:46 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:32:46 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v3 2/4] perf: arm_cspmu: Support implementation specific filters
Date:   Wed,  7 Jun 2023 01:31:37 -0700
Message-Id: <20230607083139.3498788-3-ilkka@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: edc0abf7-958b-4da6-976e-08db6731c55e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dCarWHALdyP/0WlcbHtxdJ2LBe+WEeqjuEU2fIeajcYbYyFCB1S/uITYRz4KxL7oTq57F2ExpVSA3u3IR5FQzu3B6801qM4BFvql8i/GLGfzlfFIQCz7Dpd/3FTFNfqqqlJowexD9J5OJztMPx4Waon70+JNsgP4K57udozDUrzIbQryHAW6KhYaEUIMkWcxHY+RBuvPAz3LsRkM5bZU40y0o+T9Jp2IcdZ3LI47M7wRKWCxbF1/PR6o63TEHdnyeY4zeEiMKQDne5Br4XppXh4ZMw2hEDxgsCL7Bv7iSHQ8VQKpXOOCSQo/woPXNU9Bv3CHfNuYyVAPbDmQpU4Lg9w71usLRDuhslho3LTk1Y1QtgYuRDL4FafjnS94B7WoX09m8imkqPrL5HnjgZZ7UB4vdmY9V1e87enq+GQlxTry8EUPL8cml2fySSP1mIgkJ4aIRHOkmIPHHBtL95akKgQ3sR8DP4n1//yiXDv/fjiNdTMb4v/XWvfEC82lweejrynccGEk9JjJ1nnIhYxh2xe6W/B5abfcqdDVxTBtLcde9X1ndZqB0ZijNUkJ5LmQncFBiqXOjU+xMgVOJk5HjntwIa20HE99e9Rm0xBN5kO3UWPIwhu+Ojrss/kSBy1/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(107886003)(6506007)(1076003)(186003)(26005)(6512007)(2616005)(83380400001)(52116002)(6486002)(6666004)(2906002)(8676002)(8936002)(110136005)(478600001)(41300700001)(5660300002)(316002)(38350700002)(86362001)(38100700002)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v0Wsy+ITHFmbbqq0MEbheCfqqosoWjprTArzFbToxiWKKTSZczB6EwzX7eE7?=
 =?us-ascii?Q?7UVAukawyHHiQwFisIm1r3U83zUErPW1U6rdRza9qs6apKZT49UWt7w8cFSh?=
 =?us-ascii?Q?Y8vIUnX2MW/Ii9N2vPyudb4C3Oc47sIss3E6xho+5PvMrjwRBzSxjucMzM44?=
 =?us-ascii?Q?ktw+DM5mcAZdpTUTb2CZQYvjhcAIcPDhiRxQ5NTmvbUme5AeM8dl2SVk+t06?=
 =?us-ascii?Q?RlXR87BghO+2CBbSlfcAjcKnmHJ7OGbWSJQh6buBxPNSJnb+AqkcJurPvXW9?=
 =?us-ascii?Q?HcIBbaJYdr3CMnYFe2I/NDSkqrtgTK2abxW7XMJG1wFbDQQcZ+JuxtVeFwS2?=
 =?us-ascii?Q?wTOnWxtMEQCvKqxawqHOkk62alol6r7GRLVL7kFXYKzPJmLJ3gkKObf8lghw?=
 =?us-ascii?Q?aT2B1w5ZO62x0mzq6Qv2A4c7yU3qql9zIX88symR+lb51Q6IFdsf9C/eaeHK?=
 =?us-ascii?Q?I/eqXqruch/WrVaplgIH1Xv6pB+RoHjHZknK2yPurRD+vCvHwtdu07JYMafQ?=
 =?us-ascii?Q?RAA3VIGuKAFiW0KkiLU9cbphdFuTGdwc1efz54Z5tjQGHznfa0wShbw/0jIY?=
 =?us-ascii?Q?POpgogzIS0I8l90QeBOoA9ZU2djlHH08l1xwBm8mYvXVw5Q7m0ey+aOaAxzH?=
 =?us-ascii?Q?40zAn33pwmT+XgafvfF5X9RK1f/cT2UYBMdpc7cZHPx2YqpbgLOiJMsZUmQx?=
 =?us-ascii?Q?oO+LN/0ch5/m3IutNqh2NQ0NRtKgTpuRgwqtKnf4Mcb+d3VQnxgS2TuvT1i5?=
 =?us-ascii?Q?Gs/dvyHet6FSUFHfV4U3ZgGg+DPk4h+9cUuQyPOdzMENuRQmgH2gGFLXjPc6?=
 =?us-ascii?Q?TikXpRz3yLZ6yeWz1eM9q0xgtIPHTXb8oJkCfPkA5qZOujG1/4y0qlYjcWLW?=
 =?us-ascii?Q?v1dX2/qY95Df+yE5eh6FoWgNM04/BSkHBocVJnecifjGaYDqQk9R76zo2+yi?=
 =?us-ascii?Q?IuJ8Cfz8aG510oKWd7v8Vo/nv2XIflGd1kVl2Z9gGVpsDtLGGuyODpl16bIv?=
 =?us-ascii?Q?JUa5PYNGXx5qEMkmx8urg4CGxnAv8XUiDyD1EVqpwIqNvTW/wJCUZpz9D7Dl?=
 =?us-ascii?Q?vDzVTUHQMEABPlPkl+TJhtkCapdGM9EK80bKARYfABF1Ob/gS0rbxmvvm6xq?=
 =?us-ascii?Q?fmDGoWrSEcQkFdbOIMrTvy86yq4q7OZAQW6ojrSMnkGbkE9tmBmVpNumYM62?=
 =?us-ascii?Q?6ITI49/0Tq8AxDfqw47ytI0XtjIe6T7KrIp+ErYE8bMvZORogYowEN1+wB+M?=
 =?us-ascii?Q?cxtxil8JzIlUPzDnmRsX1Pgw74uvknktFfOd2Vz9WtS9IZrb2EGqOO0n5ybY?=
 =?us-ascii?Q?U6HFLEDGeafVKqGVoYib9/uIIJCfZU+/+VEcmz+1CNUYGBGa8ED11iHHDAfi?=
 =?us-ascii?Q?Ew5Ra7nm4NiWSPTg04u9gH3oyZ83FVSuN3EFPz+mwVG3wVSdBEmnCQFAVOY5?=
 =?us-ascii?Q?62Lr5tvL4fk9/leD8v5IPVctPAfuCqIBLtw79SVcJ0tVqDpM27u+ZUOnc7Ew?=
 =?us-ascii?Q?5XUgLvD3qq0BzGFEdTUzcqY5Le/LGktSb0yEZ8umCboYx9fmW7sjp1oyT43t?=
 =?us-ascii?Q?0czFh1rYGK9HZ7E6bv4Wply2CZ8ZnpOf42Plx2ejnKHeuaPDYlyHEz/mDPoo?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc0abf7-958b-4da6-976e-08db6731c55e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:32:46.6864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omVLUv0nnBTFjFIGr+qZn5cYNJdLCxsuvNIO984HygXu+Who/Lg6Nxhh4qEJjT1fbctt3bMWSIxgFFO8CP1O0L8FvOPaZ42BUfsqSi9krTkyam70F9rRFTcusKUGzXVF
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

Generic filters aren't used in all the platforms. Instead, the platforms
may use different means to filter events. Add support for implementation
specific filters.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 8 ++++++--
 drivers/perf/arm_cspmu/arm_cspmu.h | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index f8b4a149eb88..72ca4f56347c 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -122,6 +122,9 @@
 
 static unsigned long arm_cspmu_cpuhp_state;
 
+static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
+				    struct hw_perf_event *hwc, u32 filter);
+
 /*
  * In CoreSight PMU architecture, all of the MMIO registers are 32-bit except
  * counter register. The counter register can be implemented as 32-bit or 64-bit
@@ -432,6 +435,7 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_type);
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_filter);
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_attr_is_visible);
+	CHECK_DEFAULT_IMPL_OPS(impl_ops, set_ev_filter);
 
 	return 0;
 }
@@ -798,7 +802,7 @@ static inline void arm_cspmu_set_event(struct arm_cspmu *cspmu,
 	writel(hwc->config, cspmu->base0 + offset);
 }
 
-static inline void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
+static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
 					   struct hw_perf_event *hwc,
 					   u32 filter)
 {
@@ -832,7 +836,7 @@ static void arm_cspmu_start(struct perf_event *event, int pmu_flags)
 		arm_cspmu_set_cc_filter(cspmu, filter);
 	} else {
 		arm_cspmu_set_event(cspmu, hwc);
-		arm_cspmu_set_ev_filter(cspmu, hwc, filter);
+		cspmu->impl.ops.set_ev_filter(cspmu, hwc, filter);
 	}
 
 	hwc->state = 0;
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index 51323b175a4a..f89ae2077164 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -102,6 +102,10 @@ struct arm_cspmu_impl_ops {
 	u32 (*event_type)(const struct perf_event *event);
 	/* Decode filter value from configs */
 	u32 (*event_filter)(const struct perf_event *event);
+	/* Set event filter */
+	void (*set_ev_filter)(struct arm_cspmu *cspmu,
+			      struct hw_perf_event *hwc,
+			      u32 filter);
 	/* Hide/show unsupported events */
 	umode_t (*event_attr_is_visible)(struct kobject *kobj,
 					 struct attribute *attr, int unused);
-- 
2.40.1

