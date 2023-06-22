Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF30373944F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjFVBMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjFVBMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:12:36 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2111.outbound.protection.outlook.com [40.107.95.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19871BD2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 18:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LN+f+7FEwKNVKvk8eLAcDQrO/2lAWqLgNGoh40dpGzROglh1UHib2VfRrmz8cFAokO9ljadh3xtHl5e96NIWU7J/TjUEDp2CT2CbVX8oJQhIjxP/hV7f98Kd1Y1hIp3PCkQuQj+Us7d+ZQ4yK3LuZ9KbddEm7JaD8/trm4Ytmabi8R6VoJU/DbQVqJzEVigi/Apa7Ok29nD96/MgqkemxwJ0iKeKL46MhLpm0XO7j/Ba9guGoku3K8/7lPTaQR9Tx1fsRnpjUGTpPfdsjRaV5yBaUztSa8TDd9PmBWhWMit+UPUlcIA2CRh1mQcIty7WhShtvQgfJ3UTLBdMmcAHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUW8DdEbZGpX9/HSB5buvJTgiz7tmh4Y8yrkYhFvdys=;
 b=KdiIDo1W0JnuRfWmDGUFNSk4dXKs3r7s4VBLSLwPQkpZXsB8Jnava03wCQXIV3/9N9OMDIU1yi43/TXASUED+CiFeIWzimQD/TY9rq59eAROvATEy4PNRJLdhTM0aQy4nIwHtRiS4srMr5iLSYJRaQpUSgMlsdosHaRWf8pTrwa7RRYAtzy01b4zW11z0lATF6elSKcNLofqFor4d5X0FR3lhujvjVhYMhUVdTgicIYizDVvaXn586j/61yirR2iY5VuDem4Ump2jbJE+0YsJuWyU3BjqouqdbNP6C2zdm+BaRnOhmy00d0tY2Sishtw593V9WOTD2TfCNKuRBT8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUW8DdEbZGpX9/HSB5buvJTgiz7tmh4Y8yrkYhFvdys=;
 b=Ru2xvST8vSaE6eAPAuc5VO9EFMIZeiICVHZYXhxQPPSW7P5Z+0nlECEW5hwf6VqK918yvNAA6OVP/PyRmTXqED4sDzO3Hw3OStQbb0J2E9p7ottWw+gPBVkURAEua/qvgjPyR0WbjdohitnbNmdwQJoYROQbaI72t+mSkN8epzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DS7PR01MB7805.prod.exchangelabs.com (2603:10b6:8:7c::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Thu, 22 Jun 2023 01:12:33 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621%4]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 01:12:33 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] perf: arm_cspmu: Support implementation specific filters
Date:   Wed, 21 Jun 2023 18:11:39 -0700
Message-Id: <20230622011141.328029-3-ilkka@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: a9518d6d-9893-4859-586b-08db72bdc244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVY61FUD5ltH0pLckkpZCp42l5iq/edZshy52EYpcVSkqyELajnr4oMkPuYGJudwBGp78VZBSJB9K15KtMpKouy+vrxh+6kxhrub7YjSX55dSUmmUYgZPLeizYfVgr2kk1V5lmUMio9/aqmtRIjNiGjzoA1ZyvudsaRnPyy6SieXasxbR/2vc9y5HrilBMxqtic4+1vySLCoDFhrRp0gR+CydQ5/ZEo9a7O86OEv8tII8SBQAKg+EQxJqZ715eeQ45mgOVpdAVoqUxAx46MPU4KdwzMCz9vGNIUv8ThDGTdKnmdjFO+chcVSmbaKzk+YItllO19Y2m6YMFytEQnOxMzV3S91lrXRFsUKWlJKTgHI/Z6mUqRu8dXeXOuv5y04GuJZwxXDvPjIYACFOeBRSQZWi0kiIzd9KeUVzz6xwcIhjjUKyLxBIqBI1zOZ81zvwkLsiWHHPxEyWATLS410/nbR53N4gjbDrtgQxAOFkAESwf5ZMeOxmnW+UiCHRLUrHDx9uxFyRBgebqhmCYxZ+kVHCEnWdxWiNSnQAbGusZ5DME8R/rumuAfZ3QU6RZn45ItL4vXvZs5QCXqUOjQ6nD062t4L5ovK5vVV5u6g4w+bMic2imWO3CaN6wW7jIC/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(346002)(136003)(366004)(396003)(451199021)(8936002)(41300700001)(186003)(8676002)(26005)(1076003)(6506007)(2906002)(6512007)(86362001)(110136005)(66476007)(66556008)(4326008)(66946007)(6486002)(316002)(38350700002)(38100700002)(478600001)(52116002)(2616005)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pkuPsPkdfHTIPp1JCqsfhkeh9TwBRcUS6FbgYHCG4WdygQh5nU+9hhROIgB8?=
 =?us-ascii?Q?IhTcVqNW72yWhPOB0MjY0BXehW0mIh7dPi1aIaL/JNAJSuDNWSQSIl+rIyKD?=
 =?us-ascii?Q?Ivilcu5btfXSmyfvsG00vAPDBOGv8vZEseDCd0N+R+LjV3qRlrekKCuthBLu?=
 =?us-ascii?Q?PAFQGAlmORstrBde6SFjgDbnHLTTxQfKvVhqNUxvgsRmTFT7Z4ESLBamoKUl?=
 =?us-ascii?Q?i/qxznYcgKo/kowVSYqqJCcO97qnsY6HMlYKJCW0+vLnPchIfvJLkvo67041?=
 =?us-ascii?Q?npd07nkCqDOb6yYZatz4asIHuyHQUR1vVS+6GTlcnOt0W0CoqQS/PAQ+xHfV?=
 =?us-ascii?Q?7lDzMBA6iBLLLx/vsb8osNkJ+Pi3HiWUXzZjb48jTtQJKEbsLFh/NTSo9K7U?=
 =?us-ascii?Q?CzX72TL6YijZUM0r6+lgVDdEym4+ytXCN5BW4mk7oIXC9xzpLiHskl3H3DAI?=
 =?us-ascii?Q?S/Mfzhkz0bLchYNM0a4dWwuObCyitj2oESVgyeO5JKrmfymg7UUwujhDmz1S?=
 =?us-ascii?Q?F1fNHS6Sh7PoXgEaCEGAfwG+yyTXS3B+pC7UOwqjIYaSdk4bRZCk+/jORfJH?=
 =?us-ascii?Q?ROsDZjg0TIaT4d9tOo6jBP8QRBU1DNKeb5UQwQnf/voD8EivXPOWdi3bNTew?=
 =?us-ascii?Q?Jp1dBEk17EV2UV36Olc5g4+FFoVt9R/LIybG+dNC5zZgUETvZfc03TU0GXnB?=
 =?us-ascii?Q?wDvN5nf9RnpHXDA9/v4mO1T8a/yQ3KL2JqAgM/qX5KHX73oqc13U98XrB5Po?=
 =?us-ascii?Q?tOOBh9wcLUMFtqQoE05Yye+ZiCvpU3mOfRc6/CXOFiW89VOz1NB/cR1Oz2ms?=
 =?us-ascii?Q?DauLOVMXJiYfj1gk5ZQynK5epT0vObUuSR2lOi57HcOl5CjpEo0oCko4XNrv?=
 =?us-ascii?Q?J9gmDTcdLDKBn3rQ0PTeNVdMKufCcCvEXD+wuUy9n1nmrdwEmGKUoNqUY/N3?=
 =?us-ascii?Q?psH3S0SNg2ltC8BsRRFgHX6HqBTMAAAKs1Xv+2pbRFGLxvw3j4UQh82vzHo2?=
 =?us-ascii?Q?ovWdsHZfH7aKwVdAMZKfB3oSyyFFGHncNkSCdWJeBPQHkQWWB7mdZ9s2JT2W?=
 =?us-ascii?Q?F02hVkGLWQIL5j6bS8AJ+YVRQ/6/DkxhgopNS+svfaBhl7muI0/at5YLEBK2?=
 =?us-ascii?Q?XjA8M1iZ3OX9u3Dh5auL28C/JInCDm4yMvp4cxMci08osVpbAfFgaPuL8Mz4?=
 =?us-ascii?Q?Mc8Z2I4/CFUB6d4Q3RWNuiFKgYSqvFcvukSlJWRbuMEDDbcThp+vUym23fcX?=
 =?us-ascii?Q?JxZJJXWOEj0yU7VxUt7/tf0IGglXNr5XE/c0NFg2AkBcOBybs+sNNrjkAM3P?=
 =?us-ascii?Q?j7cCnWFQl7OaiDlr3nZK6StolmHX6iX5x6AfIYt8raRYDaarv/t+LiwEyHDK?=
 =?us-ascii?Q?8Cii/guNDSdtNnmOD1Ya4lk0FeZh39kDf/AYGIeyEpLVWDlt8Az+6SlIGeXe?=
 =?us-ascii?Q?v9bnT1h/jFyfqXVvAQ3HknfJGqj+N7IdI4gum/6p4D4Q1YYCCGNeJatYNKEr?=
 =?us-ascii?Q?FkCSpfMdvvYbIZQbNSTIQHZlPS4L7nMMpGs3/9dSfkTdq95gjnMlZ5pFHnv2?=
 =?us-ascii?Q?JMRgm61qZQwnPIJy8h6KhzaBeGTS/YJDWZmioTzJk5xWmrg8hL/IGp///8zW?=
 =?us-ascii?Q?bXq94brsjr/SDR6H9KSTVt4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9518d6d-9893-4859-586b-08db72bdc244
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 01:12:33.8197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gR3n2WQPHFt219mW6tdgwqEb/sZm7z6wDWZCtK+MqaKrlDI9rbKxmHkj4/VJ2U9YxQLZt9ovzI0MgbIijIUr9Ntsn2OPNyZeMWenpaJpviYgRAGF/tD/0QTpCHPV31W
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

Generic filters aren't used in all the platforms. Instead, the platforms
may use different means to filter events. Add support for implementation
specific filters.

Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 8 ++++++--
 drivers/perf/arm_cspmu/arm_cspmu.h | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 0f517152cb4e..fafd734c3218 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -117,6 +117,9 @@
 
 static unsigned long arm_cspmu_cpuhp_state;
 
+static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
+				    struct hw_perf_event *hwc, u32 filter);
+
 static struct acpi_apmt_node *arm_cspmu_apmt_node(struct device *dev)
 {
 	return *(struct acpi_apmt_node **)dev_get_platdata(dev);
@@ -426,6 +429,7 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_type);
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_filter);
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_attr_is_visible);
+	CHECK_DEFAULT_IMPL_OPS(impl_ops, set_ev_filter);
 
 	return 0;
 }
@@ -792,7 +796,7 @@ static inline void arm_cspmu_set_event(struct arm_cspmu *cspmu,
 	writel(hwc->config, cspmu->base0 + offset);
 }
 
-static inline void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
+static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
 					   struct hw_perf_event *hwc,
 					   u32 filter)
 {
@@ -826,7 +830,7 @@ static void arm_cspmu_start(struct perf_event *event, int pmu_flags)
 		arm_cspmu_set_cc_filter(cspmu, filter);
 	} else {
 		arm_cspmu_set_event(cspmu, hwc);
-		arm_cspmu_set_ev_filter(cspmu, hwc, filter);
+		cspmu->impl.ops.set_ev_filter(cspmu, hwc, filter);
 	}
 
 	hwc->state = 0;
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index 83df53d1c132..d6d88c246a23 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -101,6 +101,9 @@ struct arm_cspmu_impl_ops {
 	u32 (*event_type)(const struct perf_event *event);
 	/* Decode filter value from configs */
 	u32 (*event_filter)(const struct perf_event *event);
+	/* Set event filter */
+	void (*set_ev_filter)(struct arm_cspmu *cspmu,
+			      struct hw_perf_event *hwc, u32 filter);
 	/* Hide/show unsupported events */
 	umode_t (*event_attr_is_visible)(struct kobject *kobj,
 					 struct attribute *attr, int unused);
-- 
2.40.1

