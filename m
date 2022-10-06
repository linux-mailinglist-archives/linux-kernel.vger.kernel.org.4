Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0302A5F6AF0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiJFPpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiJFPp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:45:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64435FD23;
        Thu,  6 Oct 2022 08:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKq7pn1HGnVkMgFU6uynu1wkoT5P2YkzCHIbwLec4oK3azdo8aOB7bu7Jex2EyHu0O0KXAZkB5MUKaU1INgf7zFYoWYgR0uIyXl8zaKDfwJyfxau7IJSKJ+v2ojhbx5Nh8x6mg+f7BvxweIIBKWLFJus1RtvvGNElNBKCFLbSCNEbM9uAOJYRyu5RCTZXHrhaq6r3OAPYL7y4Y55IIoGIcqzd8fyRUWAnLux64NijiK/WfLMsb+3EtnnOo/h1QQp0VAXWU/9cRU/q/eBDgEEJY0J/4qy4Hp8z1r1Q6oVFU2gq+vkX2+soCphsk4LarGNPjpagPuX+I2p2W+jNowDQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeI3AcmG1pZYJ4aznKk+wKhZyEIq79yXuMa4OiK3C+0=;
 b=h7wKgqVd/+JwOjNsQJLsNUWdE5yH9n3E6yq5ejDe8xtPSSIamtFVHOsBldpBV2mr0BXqgEERoTcZRGS5OES4dEc4F7XEccnqYfQBTfSt8U7vaabwK2hRwNzjqb9NhYCqqOS/xoA3A9h0fMvf5enq7DDRC95tbZMohC4xssa5e9bkBhVHiWvOFQDMBV/06SKi1SGWHNXCSTH/GfJHtwEP9N/1mpiJ7K4LJxB6QifE2XBMs6C34svi7rlYMmbeFff917ReV2TDsNjVWPODviaWS/SCxrFrEMLIRZDxYrInKLhKLr6bkLP8/wZsDvOWcss71QWyzSW5ykZCpUY882fDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeI3AcmG1pZYJ4aznKk+wKhZyEIq79yXuMa4OiK3C+0=;
 b=iOpNlAPEda3sQfdw0RJuf2vZ2bFQsmxYhI3jFADedKi1GQeknQUYrq+fNgbUOz74X7ClkvZgY6aopfun5VCALsBM3n7tzYvbphOMbGA1MTFZZHw2AZbnNzf5Aza7dRXZnipWIjrjaDYVzm0s8tp3XybCkpAJDaX8PizBkol0LUQ=
Received: from MW4PR03CA0237.namprd03.prod.outlook.com (2603:10b6:303:b9::32)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 15:45:23 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::35) by MW4PR03CA0237.outlook.office365.com
 (2603:10b6:303:b9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28 via Frontend
 Transport; Thu, 6 Oct 2022 15:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 15:45:23 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 10:45:10 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>, <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v4 6/8] perf mem/c2c: Avoid printing empty lines for unsupported events
Date:   Thu, 6 Oct 2022 21:09:44 +0530
Message-ID: <20221006153946.7816-7-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006153946.7816-1-ravi.bangoria@amd.com>
References: <20221006153946.7816-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 831eb3e3-9df3-478e-485b-08daa7b1c829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9e7RhXESV4xL0YRdAp9jgb0amgi5MfvMu5//RcgqWjlWn6xI1hzkJb4YLxXyoJ1FJJAPs4ay1QMZ4hKx88jp9VB3WOM0g88NWbxlPwQjbwEe4lZOtqXMVXMVhSOOiz3aVBqsE6Joac82fsduSGjr45UfDu/6OKVXBKwgBultmLqlKrHL9XZhtriROJ7PK6l7sHBh+ClvZKkYqVVfzwzN93aHHevrM9nKMo29QN3Ig/yB5vi2cK5C7YTy5LwZVs7JUSrfVTM9ugsC0sC13SPldoY69C7pBcWO+zq6CLXsdeo8tIpbV/EhImjsSNvoq9Umr80BmRxUmI2bQbbzw/V8sY89/Bu4vMsXcvKCwWsTeJNT+EuciOmkBn0nBQnXIAksazDigfKyUSPWvHevkPNUd57W96h657EKhtZp3oznxd/gLjFjYtNUR+GssNBFeE4CBfl4X8ULy2DOrLnGwhD++sa2XoqjoThWibxvHgBB+lyCOWcgywTrZPyjOL0+PkLGZFuXssNUQVUIHPxQn0zq6cWSspmN52Cwe0MU4EE0lmrrM9rJZWSdvjmAd/3tbQPILJ0EczF6UMrOeL+QOtLSeuu5AsdigAIHtSHCrjiBjzyAsId9xlJC4K8Ph1dn+ML1X5mX1Td4wPo9s1veRNCs5lRkp9xsCpC7Hg90AmOOQuXzUTEZpfwrHJ5vfW4CbIF9OKDA6CLAYGCxRF9rWr32+6fZy7J/OtVZVduHgimxrXFB2lxufwffXdlnbLA6aE61Sb0ciZbTCXhOsM5JYge7TQ1IDcQr9hckn5+4C3naexA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(478600001)(47076005)(82740400003)(40480700001)(6666004)(7696005)(426003)(26005)(36756003)(336012)(1076003)(5660300002)(186003)(40460700003)(83380400001)(16526019)(316002)(8936002)(7416002)(41300700001)(2616005)(44832011)(2906002)(4326008)(82310400005)(86362001)(8676002)(81166007)(110136005)(70206006)(54906003)(356005)(36860700001)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 15:45:23.3670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 831eb3e3-9df3-478e-485b-08daa7b1c829
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf mem and c2c can be used with 3 different events: load, store and
combined load-store. Some architectures might support only partial set
of events in which case, perf prints empty line for unsupported events.
Avoid that.

Ex, AMD Zen cpus supports only combined load-store event and does not
support individual load and store event.

Before patch:
  $ ./perf mem record -e list


  mem-ldst     : available

After patch:
  $ ./perf mem record -e list
  mem-ldst     : available

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/mem-events.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 8909dc7b14a7..6c7feecd2e04 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -156,11 +156,12 @@ void perf_mem_events__list(void)
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		struct perf_mem_event *e = perf_mem_events__ptr(j);
 
-		fprintf(stderr, "%-13s%-*s%s\n",
-			e->tag ?: "",
-			verbose > 0 ? 25 : 0,
-			verbose > 0 ? perf_mem_events__name(j, NULL) : "",
-			e->supported ? ": available" : "");
+		fprintf(stderr, "%-*s%-*s%s",
+			e->tag ? 13 : 0,
+			e->tag ? : "",
+			e->tag && verbose > 0 ? 25 : 0,
+			e->tag && verbose > 0 ? perf_mem_events__name(j, NULL) : "",
+			e->supported ? ": available\n" : "");
 	}
 }
 
-- 
2.37.3

