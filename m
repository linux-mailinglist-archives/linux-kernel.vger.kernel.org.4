Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82F65EDAF2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiI1LBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbiI1LA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:00:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDEB89CC5;
        Wed, 28 Sep 2022 04:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVz15rl4nUIk42Xr1z3SConHVSrRCe3HDe+IaGIkzbZHbLjHnnq76ZJ4aZ5kQqXs4MtsA69GhUquJ9j0SAbuqg35ZoZrIORRA+Tv+IlKmPkTS9A95XkCqHv01YpwubruqFIz2ezco1/snlcwM8mFxTnMxrJvmbfHH+TD+VfJDMNueRfxNPBNMC1hl3/n9K6G5z3SDB+fWT7GUPFU21bV/EM5z59LZV0+5njz+UUTrAXiTiDwhhTSegf+9T82D67A47YeAuYp+QkOoDCcvVapwQqCZfQKqvk8muajxkSiIlt6TlDUHDDV0tj1wQYOWi0jmKH0aL2xrVWIY+4Kmj2ylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S27i9A63gf/BufC6W9H/4oZO7iJ7Laexe619Qc8h4nQ=;
 b=VMl0KO5dY0eon+Ei2O7bobk1ZG2psSGTvQk4u3YXGE2dVm+W/czbGe/LZqJP3/tEqFe/nzJZDU9MpsHIvtHc9Ozo/82HJ3FkJ3GHRPtHUQbqW2s5YFsVfVi3ZvqT0vptLKE/z6gbGSOsoDj78ltYH3pt4GHX9+ShF+eg590V3cfYbl58JTxrcbxN+3g282AzKH0D/Smy7S1LOijcXmNXeFmvEZr+66XMnqmlhbJYwVkrY9PnDGQAUEYcR8VK2A7FvXDVWSfMS0GynTfa/uR6Syr3f8GHVmwOwKbVK/EApark86DvmlJzDHo7U0VnKzztqYUbP1I4KGgirzIORON1Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S27i9A63gf/BufC6W9H/4oZO7iJ7Laexe619Qc8h4nQ=;
 b=GxvqUhi/DE3IbVOSWHdV6vYS5iQnWX2ciJ078Eozu039y65qvmk3wJeGEzs2sM+qsXQks/hwAoRvRR/SWZcrrCdltjtArdvdRHLpwWrVb5K3WDcMJ+wfhw+xXwZatKi/muJyLOmoibjl/LHMwlsKAENAaQTsX3g7PvNi8R7KtbM=
Received: from DM6PR11CA0069.namprd11.prod.outlook.com (2603:10b6:5:14c::46)
 by SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 11:00:20 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::35) by DM6PR11CA0069.outlook.office365.com
 (2603:10b6:5:14c::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.29 via Frontend
 Transport; Wed, 28 Sep 2022 11:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 11:00:20 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 06:00:13 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <like.xu.linux@gmail.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH v2 1/3] tools headers uapi: Sync perf_event.h with kernel sources
Date:   Wed, 28 Sep 2022 16:29:38 +0530
Message-ID: <a3fe725bba24e7c0028a9fd768163cc63e8064c4.1664356751.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1664356751.git.sandipan.das@amd.com>
References: <cover.1664356751.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|SJ0PR12MB5405:EE_
X-MS-Office365-Filtering-Correlation-Id: 272246eb-d1a9-4225-6ef2-08daa140a271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2x04QRIIE8wAbEGPL8BwhIcapbg0bP1xiEcNZuo7clq+leWbbw6LgobteEC+tj9dk01usjoBZgFPTUPMOO8VrJYdk56mueIPiWuPBubYFtry7/FaBa+kkO/QwGJmGPx5Iz9TB76WR2V8+VkdCSM+MPIQk4BEwfY992GQ07TsGPr5VVeRCxHpN5vWGEKg7Ef/D1xMd+sS4gfiaJfXV+V+qPFqnolbf84vxzrIEdHXdgPztj8YRs2Kt6QjYZP6uuTLADMiSBMVkyb8HaPKzHx5HuqIuCPHnC1xT1bd2sqlMnM0Pf0Hm0XcECOptx2jdRLAA2CbRHexW03Oh8lYO174f0iFNcvONNuWtqyLzk707UJRg7cb199TOY7douhSF/tS04UjctuRHP+9dXqvh6adFCK3x1Pc7nzzEsuiUknOPf6/kmFPDDwOxeBzGcW2a3GBEAUA8KbGIOR81L8nN0N/cdETqaBUzsIvvFGeznxXTBFF8G21bSYm/7Ki1Ogszzl0MZMIE/zqTEwgU6vL9Ao4iEKWWBx9IizktNry9NVl7VrYG5IFEyPJk8l6aYW1TkkfFzATKfAle8yY3DJ4ZZc8U8Z6bnX5PE3C6kGpg02tMzUF99lJS7omaiqcTY/mGSihBIe4/NgybtKAtktZptl6qIAdgwWT1diq87chZzecyq9qo9sbcvbY8ASWFgqOTVy9i19z3+8+IK1oIccQkCdhddgTdDBbIX9SfyJcO2675UmnjBQ5cFR8QIQx2t2kq4P1SFdEtF91ObZ6PHCv2I2xZbUaRMrLobkw1rVqzIYwsXlVrPvsj6Wh89G6KitH7oxF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(2616005)(426003)(47076005)(186003)(336012)(16526019)(81166007)(356005)(82740400003)(36860700001)(5660300002)(7416002)(26005)(2906002)(44832011)(41300700001)(8936002)(82310400005)(40460700003)(478600001)(6666004)(40480700001)(4326008)(8676002)(70206006)(316002)(70586007)(54906003)(110136005)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 11:00:20.0574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 272246eb-d1a9-4225-6ef2-08daa140a271
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync perf_event.h with the kernel sources by adding the new "spec" bitfield
to branch entries.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/include/uapi/linux/perf_event.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 49cb2355efc0..9e1ae54b48a2 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -263,6 +263,17 @@ enum {
 	PERF_BR_MAX,
 };
 
+/*
+ * Common branch speculation outcome classification
+ */
+enum {
+	PERF_BR_SPEC_NA			= 0,	/* Not available */
+	PERF_BR_SPEC_WRONG_PATH		= 1,	/* Speculative but on wrong path */
+	PERF_BR_NON_SPEC_CORRECT_PATH	= 2,	/* Non-speculative but on correct path */
+	PERF_BR_SPEC_CORRECT_PATH	= 3,	/* Speculative and on correct path */
+	PERF_BR_SPEC_MAX,
+};
+
 enum {
 	PERF_BR_NEW_FAULT_ALGN		= 0,    /* Alignment fault */
 	PERF_BR_NEW_FAULT_DATA		= 1,    /* Data fault */
@@ -1395,6 +1406,7 @@ union perf_mem_data_src {
  *     abort: aborting a hardware transaction
  *    cycles: cycles from last branch (or 0 if not supported)
  *      type: branch type
+ *      spec: branch speculation info (or 0 if not supported)
  */
 struct perf_branch_entry {
 	__u64	from;
@@ -1405,9 +1417,10 @@ struct perf_branch_entry {
 		abort:1,    /* transaction abort */
 		cycles:16,  /* cycle count to last branch */
 		type:4,     /* branch type */
+		spec:2,     /* branch speculation info */
 		new_type:4, /* additional branch type */
 		priv:3,     /* privilege level */
-		reserved:33;
+		reserved:31;
 };
 
 union perf_sample_weight {
-- 
2.34.1

