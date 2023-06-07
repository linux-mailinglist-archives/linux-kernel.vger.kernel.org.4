Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CDE7257C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbjFGIdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238858AbjFGIdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:33:07 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2102.outbound.protection.outlook.com [40.107.243.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDD01730;
        Wed,  7 Jun 2023 01:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cL8aH1h/1sL4INO5HupaiXjZzDIsSRpFI7s+44RCoeaCJ+nMOWaxmps12TYp/RFu7CpnS87oAB5mHtr8Sdz2XpLfsx4u7HbXcytWkr109eqs8czTxMcsIvrhYRKbEjvk/RnYMaZkQ//QTK9cdc1Q63/7Xm4fUkizMXluYM645jJaSc47/Z5udOODC93MBr+k6+6GZbXphLB1rCF0j33mtIts5ReE97G5KjcggMeTK126byQ7KJBMYYBrigXDt9vOV3oI5HVZOxlxmDap6ujR/C9hySpf3JX15iKLu0REApnzkpldv4Wsr971qhov1kdO+L82Mi0OeHdFeBSJrniv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjxAoSfZQ8qgcO7MR9/+POxtx+TQexaZJm7xrMM5Wyc=;
 b=C/4zFXMHDLNs2il30mDWEEfs2twSq6HJAn5HH5TofiHfF+vixewENKjvmwOGtTKpGqNg8WhhHRmjW+hE8SGi5X/ib1G2yiA7tXz6kLYHQ9LouQcoLTNlLUYmunFjfaS778DNlqZjGub0aBg8lQaP9SDt9ze5qjQLKwVSW5IjTKZh6sH99P839pkku3R7ucnPQ5f27Modl2P8tUi+uIHOX8WCve6mh8AIpOK2SjKiKKbCykTLShWL82UWbk6lAPsIu3whI9coVbhD8+H92OghQQhLacaBdxngwXIEArlxYSCNkIXsa2PP8KmK9mul/IQ50gzkO0jenC07BECh7RALEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjxAoSfZQ8qgcO7MR9/+POxtx+TQexaZJm7xrMM5Wyc=;
 b=Q1OJgEx3t4wzdAy9u59HL2tvxbCtDMo+uwsjyM9EYaoWsnu0HyqcpHuug8JC5ENTru6Q1l9hvYRnf57oIxgmGktz88LwDnzzV0TzFqUJ8DPJXUo8J9BgdccoBVNPmkAG6HwH7ZWjH8JnA8INN5BmzQmP7JuCln4VUvIIYTQyQ64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SJ0PR01MB6304.prod.exchangelabs.com (2603:10b6:a03:297::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Wed, 7 Jun 2023 08:32:51 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:32:51 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v3 3/4] perf: arm_cspmu: Support implementation specific validation
Date:   Wed,  7 Jun 2023 01:31:38 -0700
Message-Id: <20230607083139.3498788-4-ilkka@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 475f0c83-cc23-4494-1a7d-08db6731c857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k3oG+wrTuXUQ+/9UTCWe3zc7snU3Sh6bOVYOIGRDQQfmfCRLHLb6Wku92jrs3VkGUqVP3OSgw8yljf5jkR3oTuVDTHXXedOgoomheRL4IbgvE6zcOjMrZWhpNagNVoWMF+F+3/4C42IEooX4dgQiZugqZdaL/QLrClOZAM70BG8vpb3Vvr7iUn/SGhEFNd3K/HyzPLys8p27e9kRbzxGnfzYTcnkNMJWKKFYHUc4xdlOnnzVxUNK1Lx0C2ECvX9QOiARFVkASAR7cEhV5A+5Ep0ExIUOD4UOgHc4maHNBMq1NqMzpOagWK7j4hYAEHS3+VHKLiCFnazKlbT/GozIEtf+YCZJw+AcgV8dO5VixCU5AcHxl1z2SUTLgQ7H6/AYhCEJVtCKYCkiMWSD3jijKG0rdrw08MjZ4rmCyYZrGCJN/0VVJMoMT6g/ihjekeePVNjrGW+dwxTyxAHyE+fqu4LUVWXcYvQ+BkeFR9aFORmKFZoGUzWs3oJsdTJZv9gqvZmQI6PhyJZCsNQQN0jqQ281wpVudaPwuYeXMlKRyPxVZ2ikUVWKjf4AJz96hGErUJK8k+D86FtTlVnWhsxPYuMNBG2ZTDJWicLTB0GMEKIuQ4NRA8F98QJD1x3WQSk/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(107886003)(6506007)(1076003)(186003)(26005)(6512007)(2616005)(83380400001)(52116002)(6486002)(6666004)(2906002)(8676002)(8936002)(110136005)(478600001)(41300700001)(5660300002)(316002)(38350700002)(86362001)(38100700002)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L2MWHXjPDdRdBTZU7dnEyPvxgwfZ4UXU4OsyZjeLj0s5wDhlxhF/2OxQQB0t?=
 =?us-ascii?Q?ZfDq6E7TxkkXgQWMu9uebz3HVd5jEI9ZULp/UcSZEo6Xm0vbOTNXRRLLOfbR?=
 =?us-ascii?Q?ph8yqjuHYbGLHsso1tIv2+mQZajlKVu++t1Y05ZbSPq7/OrFFPm4lACnQOL8?=
 =?us-ascii?Q?igIlp+ZWEZKJa2Qh8WerPJ7yb8QgCWrVKlk+UC+CWU9mWlLU5pBEHiyG7WIP?=
 =?us-ascii?Q?UtSl5iZTBbIiSpY6tlJac7JpGewnaYvTk2WT9W8soHK2PBxXG9C9fQTbj60n?=
 =?us-ascii?Q?L8GHAtSx/EPHvcdotR/mLFQvqFOawLQ3gVdYytmgrNMQf149RwI6xo+Pfkex?=
 =?us-ascii?Q?pNNKOab05qCOMxeIPTIFFNf2mPWehMlYjBfKwTuGAjiACucCEkO+Q18In71a?=
 =?us-ascii?Q?lcLpNUtKaIj/uq6w4+ROwV4RJAZvxmlVu6XSK6bSkmDg25R7t+w5MN7mzgou?=
 =?us-ascii?Q?4QH3UbeL152VvEKPbbXURUr9iG7qcPffdwRydKVJkE9AhueO2PsEc273e5W4?=
 =?us-ascii?Q?k/bHeP7HZDkJsDMB15/xKVzM9mfzmdI3DVYXMHKyyhuk0HtrvapuR2w0qZOQ?=
 =?us-ascii?Q?sNC3kXILV6OslKrOQJumu5KIFF7ljU2XYn2Gs3ddEfCNBi3v0UdM7vAFd3E+?=
 =?us-ascii?Q?bJL4oRAhu4IprHyyZo0LVsiBdOjN0ocXYG1TBlgMgZVxdpFnMcKQKLOaafpD?=
 =?us-ascii?Q?t9q2H0wVB30CjLTB9gX88PxzH7TMEB8UGVGKbcD92c2QStFf0uxW+RYn3FCR?=
 =?us-ascii?Q?KYA5cXBnWIDFFWETMXfjckgAoN3sWXoaQEIFiD9gvajMP5FIhhC980OmDZlc?=
 =?us-ascii?Q?pyb+kMOK0OMHf+sIJftXwKJQ832YCTNI47wDwWtTyT4mxTyikm9zev4UNjR2?=
 =?us-ascii?Q?NwUA/bIUHKDsAN7f7aX4uoxdRtk+CD4ViFq4ptEBIezvaGoIAlFAyHC1zld5?=
 =?us-ascii?Q?Ax95ka/27mlfj7FL6TtF3I1aw4G59XkyxZXYoX2G+yqPi3EMvBWEpRKc14Rl?=
 =?us-ascii?Q?IkDqXaAAZKwuC0tGz3Fdi79m596TITGHM3G8wHmXF0NIH5KnL4EJ27UWcH4G?=
 =?us-ascii?Q?bCyHNJCdw78PtNm3k05MD68SSzdAUEYMANgNn3kFhmeRrnehrZMC3v8wFomm?=
 =?us-ascii?Q?QNSgO/O9tnXbdXeqR/mLUF3SMUUc1NVcCq3xDu7yo7NPmWd+3I/mnaTxhyde?=
 =?us-ascii?Q?jkGvJYNBN0G4+5HPRYKQ1OPrdL7RiUOH5tCBgGdG9tqtQ5nAskiJFb6kC8YN?=
 =?us-ascii?Q?EDK8tLeLMxv9qBO7VGSgfhMNCnKCKsY8lUeaaansPSeTE1c0iBdo7p9kvdsa?=
 =?us-ascii?Q?B4wgfEri1rhFAIBnlBdB1LjtdLMoaAct5LsXLFS53B5Mrd2Iq33Dq67aYJIC?=
 =?us-ascii?Q?XYNMF67ZXNkcXEo8DqGcwSaHa5aMDRXFM+Z0L1mP77JhYQfv5BJzzP/K6F8x?=
 =?us-ascii?Q?NfXJOcRalp6gl6Fy+k45bpIIDBRLQ12oYgS1f28nkj7R/ftiwfbBavnzZawu?=
 =?us-ascii?Q?eP+6tR7t/7Pe5hmwoicFvw22qH/Q8i5mFmEjGsghLvAdWPgOHOrW1GBlS439?=
 =?us-ascii?Q?OdgY+rM/HIi4nsYgC4gtSxJJenJyTHMHImJVz/BQzhDVKs2MEQ7s7sedcEnl?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475f0c83-cc23-4494-1a7d-08db6731c857
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:32:51.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ogIkfR074TxTPQS3Pv205KYCImmD/BVogpcSmkSbu3B1YI4o2CySygF4JWuEw0487VUDoS8ElJ5pfmwbICzjQPCyRgiU21q5VSqVmPsSYtJUv7vk1pKpH6FK382SDS2
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

Some platforms may use e.g. different filtering mechanism and, thus,
may need different way to validate the events and group.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 13 ++++++++++++-
 drivers/perf/arm_cspmu/arm_cspmu.h |  4 ++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 72ca4f56347c..9021d1878250 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -559,7 +559,7 @@ static void arm_cspmu_disable(struct pmu *pmu)
 static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
 				struct perf_event *event)
 {
-	int idx;
+	int idx, ret;
 	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
 
 	if (supports_cycle_counter(cspmu)) {
@@ -593,6 +593,12 @@ static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
 	if (idx >= cspmu->num_logical_ctrs)
 		return -EAGAIN;
 
+	if (cspmu->impl.ops.validate_event) {
+		ret = cspmu->impl.ops.validate_event(cspmu, event);
+		if (ret)
+			return ret;
+	}
+
 	set_bit(idx, hw_events->used_ctrs);
 
 	return idx;
@@ -618,6 +624,7 @@ static bool arm_cspmu_validate_event(struct pmu *pmu,
  */
 static bool arm_cspmu_validate_group(struct perf_event *event)
 {
+	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
 	struct perf_event *sibling, *leader = event->group_leader;
 	struct arm_cspmu_hw_events fake_hw_events;
 
@@ -635,6 +642,10 @@ static bool arm_cspmu_validate_group(struct perf_event *event)
 			return false;
 	}
 
+	if (cspmu->impl.ops.validate_group &&
+	    cspmu->impl.ops.validate_group(event))
+		return false;
+
 	return arm_cspmu_validate_event(event->pmu, &fake_hw_events, event);
 }
 
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index f89ae2077164..291cedb196ea 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -106,6 +106,10 @@ struct arm_cspmu_impl_ops {
 	void (*set_ev_filter)(struct arm_cspmu *cspmu,
 			      struct hw_perf_event *hwc,
 			      u32 filter);
+	/* Implementation specific group validation */
+	int (*validate_group)(struct perf_event *event);
+	/* Implementation specific event validation */
+	int (*validate_event)(struct arm_cspmu *cspmu, struct perf_event *new);
 	/* Hide/show unsupported events */
 	umode_t (*event_attr_is_visible)(struct kobject *kobj,
 					 struct attribute *attr, int unused);
-- 
2.40.1

