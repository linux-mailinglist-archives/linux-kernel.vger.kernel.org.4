Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D424B6DAC2F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbjDGL0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjDGLZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:25:49 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606F7A5CB;
        Fri,  7 Apr 2023 04:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2ksQ9kdg5KuDBKuVLQYuLrS0cf2ckvq1prOEeb9Xw/nPaZLn9Q/MlCJT0/fynjxQuDuL+hOW98NnCeoVPLYq3jFU8NrKpQ+RKo3mxl/TIqKgKexefvLdgbToC7Rd/nPv5IqrD5bnkndC+01snJ4moBWfj82a84f3X7sjKOErZf2x6X0xaBqPFuenz0lmMaR3nhzcFPb0EPI1GmyChQVdvvMvtYPKRL0BF7Pg07toXiMpfm0b6eqAGF+sQBPOiRbtyJaV3yu3IxPvJqL+/eE2oxftGjxGprw0YINJa1WGoIUtRbAcbLzb3wcn90jHPa/SqUIGRZQG9zJqS6enj+P4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhMtNOavBG6vCs4WXK7Vi1GD8SWXVyNTdc0iG/AL4qs=;
 b=LPkqYik3GysAvJI/IGupqI3ig05pzGHxFhghl1UeAqYFKx6sGDlJKXNtVD/XaVHnlv3mkghV/fHuG+o62U4Ma7u7T7fjO9XqSudvjWMhItvR4i0m13NOvq/OmErSrl7CmYlQuCydDxAewz4Zss9mQsTKFiFBtFoJydzO0nLSgGqWtjPgvWDemGvfPUjoqDTJ7X/uLhnvuYT8yvAv51pFh8UmrjeRkdbCelTBcWjbwK/J/UUeROltLwqoDIWrDJz1QTno/x6GcrvW+giqCySlwpR1GeHNIRxISclWwSQWTTJUb1zHTQb9R61f1M7mTOXS3sCLY89qi51ya+wxlVf+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhMtNOavBG6vCs4WXK7Vi1GD8SWXVyNTdc0iG/AL4qs=;
 b=amiDErZuIyIDYp/HdC8uqggXDBuDvgjUAQRDSHH8dP2iH5NmxySRKXHu4FK1A1CPyWEQNgrdRPsW680RUmPWYDCvRYgUepVjlhp64sWm+q/ihJZul1YUrG7ub+fM3/i/weKI8qbZ9yDmKV9lHiny8ZmM7DZOUyb1rbIWiTOiPdE=
Received: from MW4PR04CA0196.namprd04.prod.outlook.com (2603:10b6:303:86::21)
 by CY8PR12MB8315.namprd12.prod.outlook.com (2603:10b6:930:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.28; Fri, 7 Apr
 2023 11:25:40 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::58) by MW4PR04CA0196.outlook.office365.com
 (2603:10b6:303:86::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34 via Frontend
 Transport; Fri, 7 Apr 2023 11:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.33 via Frontend Transport; Fri, 7 Apr 2023 11:25:38 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 7 Apr
 2023 06:25:32 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <namhyung@kernel.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@kernel.org>, <eranian@google.com>,
        <kan.liang@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <leo.yan@linaro.org>, <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v3 2/9] perf/mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_NA
Date:   Fri, 7 Apr 2023 16:54:52 +0530
Message-ID: <20230407112459.548-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407112459.548-1-ravi.bangoria@amd.com>
References: <20230407112459.548-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT035:EE_|CY8PR12MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: 2810ca10-5200-4479-cfcd-08db375ad09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYsc8xzhjcLq0rH7B6CTQbqoCDdSmgAuVV6r45g5h1UfFv0CFZ4vyu52NYL2TgKA31vHswFG/zxQ47Lia3+JiKUBFuXRn8O3kxptt7K51FX7YAicwOIri3k6/bh7Pk/aZrJtwh8sPREYW48yG9V0KwFquWCwnbf5qaSD0FfeFn0R+N1S0Vs8zqr5gAhHM68Lc45CYXnjg+QIypah3nteXR3XdmyaTIdbCz0hA6ckVTY9kTE1Wcj9Rqq0WfOQ1xKdzPDoQ1VK6s+3mBwUQoGsxt22Fw5wkpAbOpE2HEEBvAtKw+Lh4VpOebk99j9uLVlsiJ/rTIbfJ/Hn9KSybTQn/V0DO6qBf1hmsX7Y3OjfSHOjTwHXhTHLfRi3XLT+UV6S8ijDnESXSYCZYOiSKAZfHNFFuQ41svJJEF+bAlb8LalrtZtzzPjwpjNvuZBDdo9fSKbNOLy90MiprX7JUkVv87NSlBoaobFXbJRgw7hOIbaZwfqAQobD/5jgMjV7y7x7J+wnZiNQ1NhATUR8+DMdBzjUSD3OaMHHgjnPG699I46WbnWuIfwJk9r3qld1pDcMY72t9lcKssLXS8e+KmDvkKs3oDSGEUn/ephqCPSUA1j+1Mh/naYvEJfwOM+tsnoCg1PMP8u6w5mHq33fJE2/PMV5+CSKuDxtldkw/WeaUGaNuc25qedFnIZMw8FZcvb74PLUjwMDarydL+gC83JPtp6XbdbMUiZjiM0FiMu40r0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(7416002)(8936002)(4326008)(4744005)(8676002)(70206006)(70586007)(82740400003)(5660300002)(41300700001)(81166007)(356005)(86362001)(82310400005)(36756003)(44832011)(40480700001)(36860700001)(2906002)(7696005)(54906003)(16526019)(426003)(336012)(478600001)(83380400001)(316002)(110136005)(2616005)(186003)(26005)(1076003)(47076005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 11:25:38.8147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2810ca10-5200-4479-cfcd-08db375ad09e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8315
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PERF_MEM_LVLNUM_NA wherever PERF_MEM_NA is used to set default values.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 include/linux/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7b5eaa..064c5ad7ff11 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1183,7 +1183,8 @@ struct perf_sample_data {
 		    PERF_MEM_S(LVL, NA)   |\
 		    PERF_MEM_S(SNOOP, NA) |\
 		    PERF_MEM_S(LOCK, NA)  |\
-		    PERF_MEM_S(TLB, NA))
+		    PERF_MEM_S(TLB, NA)   |\
+		    PERF_MEM_S(LVLNUM, NA))
 
 static inline void perf_sample_data_init(struct perf_sample_data *data,
 					 u64 addr, u64 period)
-- 
2.34.1

