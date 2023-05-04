Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844D76F696D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEDLCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjEDLC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:02:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EE959FD;
        Thu,  4 May 2023 04:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6YEY7yF9+VAsFJY5RD5cqlI4z0uJcMUs+YEbnFg+yVYVwP04WrS+4khHrOz0rJX1sjXg6OqI5JHtkGufLOh7xL5sffl8LKlv4n3Ox1u09ub7V8VNOD/b9bWiqs1z1810BlPwTG3RNYcoLVflWIpnK/IIfnV28edziCQKr3MRJhtK1Uxb2o73WvLeeVCelsc5gVfbCVksI2Wj4SfmJAsTW4x0L9Nitpn33vVm8qk2FpR1Z4HrBeViMa55UbGBnMz7kHbGINxqCVp2VCmDQlmuig79Eu1vb2s9ICGA1lG/3xVTQlLizjjPbGmj82s4Ru6Me1jYP0al50EthIrzjPv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aszvLJQiGOQO75sFEywwAPply2wiTLvpAfsxhKWgV8=;
 b=aSsutr9hGKgsENh2fH8VFgSN9S+Jk5LHc1FzEd7qYaXjq6oDU9B7ZfDEVc1LKceC9woB1ThXjWXi3cV/QxEmYxKOrR8c1oXOQKPmxqk16YJesUc8xMyzm5RHwZXWZ4+jRy2zioVXLYZQXXnIZZByOKxSR0WclOr3Cq+6lqu2oG6wAnV1uL3ccPfgobozKKwrDMhQimaHP8deZocYak/XVZKEsABg8flAI1PiewAuizd7xi1wDAK+BtIRK09XYSzWGWgrpT205AUajbliMHn926h0QekSESv1yR3/17rtLePcFbIyzwzC48VlMd2UW+XrRpTr5zhWPNejQgqRcqAWbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aszvLJQiGOQO75sFEywwAPply2wiTLvpAfsxhKWgV8=;
 b=uvLmw+gq1A6Wc7OF7jICsk2ceyNTJO536sRkUIt2k+0sf1JqOCklsFJ+xRjDA5YWfQciG9/RbFjOOMzlVBC6WUvVmf/ZKKecaszZYQkSdVWRAMM3zbJZm7Rd7n4GatxHYqKy8FaPETVyGJb2FYk3xuz2p3odZpPQXicgaLWKpOk=
Received: from SJ0PR05CA0174.namprd05.prod.outlook.com (2603:10b6:a03:339::29)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 11:02:06 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:339:cafe::bf) by SJ0PR05CA0174.outlook.office365.com
 (2603:10b6:a03:339::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.11 via Frontend
 Transport; Thu, 4 May 2023 11:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.26 via Frontend Transport; Thu, 4 May 2023 11:02:05 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 4 May
 2023 06:01:58 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <namhyung@kernel.org>,
        <eranian@google.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@kernel.org>, <irogers@google.com>, <bp@alien8.de>,
        <kan.liang@linux.intel.com>, <adrian.hunter@intel.com>,
        <maddy@linux.ibm.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v4 3/4] perf/core: Remove pmu linear searching code
Date:   Thu, 4 May 2023 16:30:02 +0530
Message-ID: <20230504110003.2548-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230504110003.2548-1-ravi.bangoria@amd.com>
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd4861e-c8fa-45f1-9c6f-08db4c8eff44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94sJIh8rDCBx67eNscstiyZAm/8g6jDlyE8QjHawH5/L5ZkHSBc1YOuxGhTGFQVdIVMeTRRuzqzxfEfQcogvGCSoifOC5Li2XxXgmMsuEPPEeu7WyWQRkDpFsLIoA/hmyy+/z9RdYhb9KrEXmZOVy+NHdQhKU8cnYID9HIWeN870oWutF+dQT5RaViklEPdUisGledP4syc8MvQrROllcwfQKxvW+eLCBE//bvE9Px17oX9kXmnjM0xqNX4wnQ9k+YaJqkv8UnVNtkM6fLJv0xrjL6HlxayLj/OCiFPpJFMkiuWq8yE/I1E3qTClGOV5AQYGdzSVyUVwU+0Xsbq4oEdVER7QfMmDXvdasGi/cIRNtbuxTfmB3wNA2FSC1fS9nK/vgwFpIX+B6veP3yvz9JCmnHcToaP0u/IJa3CA1ijxQ9bLeTvLxVZi1OqBkIQLxhb5f+UWaKedH3emN8oMWBbdFtOA9PueKwSnID5UWIrxOI5Magv01yahE3b3ckTH+P9XbDAPj6KVpGrwFfRuqGJsY8QOSoX8EXAexQZm71yWFQnR5wwrYjS4t8M9ttv0UASKPipsrizj0EnfRddAr2wbXEyCzVSvDXfLffXQNZ3mZSSxBnf2H0dS2/ufZpFiMfxHt8aCU1lW+3e1NWoy5puRYsBMNTiIXJtmD+V7M5Nt8zRvJxa/ZyUs4oTDpzO5DD2G/t1YFmPz4Qf/3nLGxlkNRn+aOTO0x8XK3jl1xaU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(82310400005)(8936002)(36756003)(7416002)(1076003)(8676002)(426003)(336012)(2616005)(26005)(316002)(70206006)(356005)(54906003)(4326008)(5660300002)(478600001)(41300700001)(6916009)(70586007)(7696005)(81166007)(86362001)(6666004)(82740400003)(36860700001)(47076005)(83380400001)(44832011)(2906002)(16526019)(186003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 11:02:05.4029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd4861e-c8fa-45f1-9c6f-08db4c8eff44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Searching for the right pmu by iterating over all pmus is no longer
required since all pmus now *must* be present in the 'pmu_idr' list.
So, remove linear searching code.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 kernel/events/core.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0695bb9fbbb6..eba2b8595115 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11630,38 +11630,27 @@ static struct pmu *perf_init_event(struct perf_event *event)
 	}
 
 again:
+	ret = -ENOENT;
 	rcu_read_lock();
 	pmu = idr_find(&pmu_idr, type);
 	rcu_read_unlock();
-	if (pmu) {
-		if (event->attr.type != type && type != PERF_TYPE_RAW &&
-		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
-			goto fail;
-
-		ret = perf_try_init_event(pmu, event);
-		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
-			type = event->attr.type;
-			goto again;
-		}
+	if (!pmu)
+		goto fail;
 
-		if (ret)
-			pmu = ERR_PTR(ret);
+	if (event->attr.type != type && type != PERF_TYPE_RAW &&
+	    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
+		goto fail;
 
-		goto unlock;
+	ret = perf_try_init_event(pmu, event);
+	if (ret == -ENOENT && event->attr.type != type && !extended_type) {
+		type = event->attr.type;
+		goto again;
 	}
 
-	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
-		ret = perf_try_init_event(pmu, event);
-		if (!ret)
-			goto unlock;
-
-		if (ret != -ENOENT) {
-			pmu = ERR_PTR(ret);
-			goto unlock;
-		}
-	}
 fail:
-	pmu = ERR_PTR(-ENOENT);
+	if (ret)
+		pmu = ERR_PTR(ret);
+
 unlock:
 	srcu_read_unlock(&pmus_srcu, idx);
 
-- 
2.40.0

