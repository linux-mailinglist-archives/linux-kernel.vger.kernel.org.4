Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121317190C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjFADDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjFADC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:02:59 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2115.outbound.protection.outlook.com [40.107.101.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1BC126;
        Wed, 31 May 2023 20:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0nloie8MgHPcYKjAtMhK9c4102aaUTlpbQg7crnkkpLOjWhAa4ZYBDkZyOajM1w4YMfT7UOxTLoPg2NvL8mBLiyba0ukcwmLcUta9uxUFjkZ9clWEo2ON1dJUPChHhAmXp9obo9yDwQdY519BkJSCJOffwdUk0f9pVctKvSDakaHGtvZR8eKD1jQDIOxTUoljXVvxSqpetvQynjLZKATtD2myWbTfGoqThxcxqoWGUVwevbjRrVuydalntSbVAhJ6hswJiEBzcnj2/ED8JWFjfmsKs8rz/a7JEbulSizd7YWVRQMYyrUvG2PFalLrv0MDFuTwvCVxH7dlo7LDF7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlCrTF6C2+up+uJwUz/+2GQjwEbJPa3IZKxxzBeUoXE=;
 b=CiANRHIw8kVRRlCLenSd+DO1gVTgNOtdApCjPj9p7yhyzLOLVscL/ujl1relfF1ZeSCX9/jyH7miC5XUh6TJyr8VrBkKCPdNxmpi36KVL6IrBCM7xu7yHK7AwJYp0SPFaAbU27BMbjaCsFiP1UCkYBFazfPkE2lcn1+TQMuDxp9T7nBuCiwvDLCFrjhFraF/zBFj1NWBq/UrDeuekXGYYufCor6CatA3XCEx0QJc6N+vbL5E34J4iZRnpcACqX37JRxuX7s9VOtxtGkCcErYRotEOVylcc4HLMJtYrhxS0j4pm0rTee4O3W5nszMfudoWBlGtecKldOqnUX+PLwdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlCrTF6C2+up+uJwUz/+2GQjwEbJPa3IZKxxzBeUoXE=;
 b=HVL6ZH4CkeWlKSDgx4fu2ZPVM+g+/fVtyTwNDEQQXJ3X3fRyGOzzvgR2xBsrij9S8+vyjPNR8c5/tsHUXG9JMyaRtzKV9rnLBNIRT60okeGt+wEcKaHRrTnJ8P1LN0fwKXISUMe8pBtmkUMdPhfmFLDikV7Wr8v3EvI0BYp/eiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CO1PR01MB6709.prod.exchangelabs.com (2603:10b6:303:f9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22; Thu, 1 Jun 2023 03:02:46 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 03:02:46 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v2 4/5] perf: arm_cspmu: Support implementation specific event validation
Date:   Wed, 31 May 2023 20:01:43 -0700
Message-Id: <20230601030144.3458136-5-ilkka@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: c046a792-e1dd-490b-3e1b-08db624cad06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jABTIAZk2xCzdtSGHYRJ0W4m2jqkQfB1h+8l4Xey0nI/hYzgF1kaZciGa+KYfxg7YskqnVQFjux4b8Zl6Mm1Y88q3/agYvtWoftZDA+l8ZcIqyXaFqxRVGhXXhiB41ZZEN8ihhZfILfHLQYF0UBak0BMCrk+S4GgNyy4r0bY2ExahHZqFaUzAgq3WuxPCJ42v/fHCCrH/6cl5WyfCrJ8OqTvW6jXUay36R/zA3MbZsJWkn/g8h1r9J7DkUreWJhUx/yWheXSea8GynNb2K6gK8axoh2bnW93YOC6kmgFse7iNnxuMQ3WDoA98WrICZcFyis08l8j4o+RVCsNYuA4+PllIvmqgKl1W60kloKRzmSrD33otpwFlp8YDKij3nTyQk9RFU2h5GwdHUtZoMCXVOlQmAwQwx2mtn6bcYTpubrVaNwj8INjIDVzYOWfLuviQ1mxL7a4vjwkJmeKuPbX+4V5obGToS//3nYbFTUTAxukWe3+tZEHCDEshdY9m15KgpdXUR1/x19ja7RoRuttgjc7p5ILNO6SX0wprFQGw5cyJfy92sg6W4mePV7pYXc4vcvNmqyFRflMALQJ19YesrEO8inEKZVHQvaOohi15RIECxdAjbOJv4Vv7Z9tmHL8cxLPX6Ap09vXiozemZ0jQfYJsuIqJYA/fJUYp4P8b8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(316002)(83380400001)(2906002)(110136005)(6506007)(1076003)(38100700002)(26005)(6512007)(66556008)(66476007)(4326008)(38350700002)(66946007)(86362001)(2616005)(478600001)(5660300002)(186003)(6666004)(41300700001)(52116002)(6486002)(8676002)(8936002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GaZ2/dinyw/19s2oqrnfp/E20hQ2GTysaNpFDOHo1I2FewjOIMrglvqJL7bb?=
 =?us-ascii?Q?UQN++UXvZhc/5MQrBudRLfH5Zylywi/w4lsM60EgzkZIfjv54lMzOm8+pJQr?=
 =?us-ascii?Q?9E+gAtqE7vHW9/ZtBryLP9B3E+LqsTfudskOmShMJW0ySJizH4kwzADCmEVH?=
 =?us-ascii?Q?TnMLCiAaRs8YLKFCjHNXe5nbJm8JAGE5jwVakoygBeczzXuSOSir1+pxburm?=
 =?us-ascii?Q?QA854ZMpl8R5uJCBfz1ULGFP4eSlXzuqF0e1QtUGxm185594ZG6gRW5Iji0q?=
 =?us-ascii?Q?OAOkBlX6eTK6290PPNcEB9qMv8MAm85xG1AUf+kZv9MV92g7uyjMvDtLlxYG?=
 =?us-ascii?Q?LD2tI3a/THK5dHc6l0/bIpnRK2I1s6nUTLqrXjEyDTMiCmqnPc4sghEcqGRB?=
 =?us-ascii?Q?+7KQWEjMFL8jDpXeX1l7EY6032ajulAlXiArFJp/72x2AhKIqkefcGGWNiE1?=
 =?us-ascii?Q?A8Wblj4KhVv47fduuBrx1L3q45qwtoRjJm81JmvHH8azIG/5Zr8xLa1VxziK?=
 =?us-ascii?Q?594c9pZcPviDKH+Gy7xPS0M2hbvetFMHDdCzwZ8I+40wej3ienqaT6zvusen?=
 =?us-ascii?Q?9zkiebeCEiFMcBo8FtWsWfRP45y7G7y/MjLCLmX9ZLbc4mnF1fCp48zgkosQ?=
 =?us-ascii?Q?yoJjztLhOEgRd34F9SM/Ut8lmpUJEBavOjDNncc9qjLt86KW7EuJwiXF+JDF?=
 =?us-ascii?Q?4IAJNb3au+ENJOK/ahZtxqwrfVObjQWAWBINz0f+a63yfvOR+Zb/kat5coc3?=
 =?us-ascii?Q?2H1OXjjhRDTcsDTXltgUyMtyQXREm5RTQHgnERzHj+XsvGjYXhDqt9sDIMve?=
 =?us-ascii?Q?RitQeyC6C3iPW0I7iKYTyuGTP2DPGQ1NuIlEKIfzbapoKduxLN75vxhAalY/?=
 =?us-ascii?Q?95oNgx1cIJCI6Ra/98zzTpMcHvyY7xHwgN2k7/fv8QlPO/QcUDFmQeYKnPyx?=
 =?us-ascii?Q?RmGh1NrzDDSFukdJyPlc3HbWSW91STmTgbNzpcvdYA7rXaAXEuFnUj3S95gE?=
 =?us-ascii?Q?GOFbaJG9SUqMVjyLgYOzMVpY7Gb+GN8QZeP5lE4puhSWBjvHdztxgpRVb0HG?=
 =?us-ascii?Q?YGzZ8moSgVOFXaRwvnM255dA7k+Putqdqe6u98Op9OyvhBZ70sV+sO+GJJSR?=
 =?us-ascii?Q?WBN+1JEjfNZ8N9SaAmcfzu/rylirUuTj63snuw+Ee9N1BfC6RApcz6SG2GuR?=
 =?us-ascii?Q?I1oijXVIWE3grNI4fvuQmCNIWyqubAqz7Khrcglx6lA4MssBpqwEu6adqoI4?=
 =?us-ascii?Q?YP23MZBdPMb/vMqPUSj40ghTx8CGD9VK6EbHpwjSQsiem/Xp7Bxh1zSEwI83?=
 =?us-ascii?Q?B7ZLrLsCiDBqXa5JjYOMQ/iN7WG5uFr51TlYqK3n4i1JlRNds7/wL2gXmPyP?=
 =?us-ascii?Q?wDkXZpF9JvMwub4eAqfTQwF2tMqXH9yZm4FYWqmhHt4Ct7oZZmkbP3lBYUpj?=
 =?us-ascii?Q?0Mka2GPmip/FPfJJs9s6R9T7HjwDDQFOaIyeVg2yHtLrcS1exgS0vSaRDyNM?=
 =?us-ascii?Q?UpMxcVkxGJHzTgpE8ZBmgZNaykz5IWhUqwergP0RHcwZq3bu+MwFE3d1oN7b?=
 =?us-ascii?Q?ipUiEpX8aMEtt4Udhosl7l37c273YfawBJyotoACCQhiC4Nc8lhEWd7MGLUH?=
 =?us-ascii?Q?zs+o6MrJi0JTSG93c3e17I4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c046a792-e1dd-490b-3e1b-08db624cad06
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 03:02:46.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+S9Uj10Icce90UndLwZS1N6xtVkKxuuUb4F4UK4AVUqZMdkTdJCsjyA852dskSRvjKv8jPmY5D0ML294STTURL4BrAlgvKgCmIkZBp0pPfTnYMpkqXx/IJ5NMgMre9d
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

Some platforms may use e.g. different filtering mechanism and, thus,
may need different way to validate the events.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 4 ++++
 drivers/perf/arm_cspmu/arm_cspmu.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index b4c4ef81c719..a26f484e06b1 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -593,6 +593,10 @@ static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
 	if (idx >= cspmu->num_logical_ctrs)
 		return -EAGAIN;
 
+	if (cspmu->impl.ops.validate_event &&
+	    !cspmu->impl.ops.validate_event(cspmu, event))
+		return -EAGAIN;
+
 	set_bit(idx, hw_events->used_ctrs);
 
 	return idx;
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index 4a29b921f7e8..0e5c316c96f9 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -106,6 +106,8 @@ struct arm_cspmu_impl_ops {
 	void (*set_ev_filter)(struct arm_cspmu *cspmu,
 			      struct hw_perf_event *hwc,
 			      u32 filter);
+	/* Implementation specific event validation */
+	bool (*validate_event)(struct arm_cspmu *cspmu, struct perf_event *new);
 	/* Hide/show unsupported events */
 	umode_t (*event_attr_is_visible)(struct kobject *kobj,
 					 struct attribute *attr, int unused);
-- 
2.40.1

