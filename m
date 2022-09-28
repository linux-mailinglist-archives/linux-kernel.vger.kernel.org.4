Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A49F5ED9B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiI1KDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbiI1KC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:02:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2F28E9B3;
        Wed, 28 Sep 2022 03:02:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lU+Bdme6uiTBO2epzMduIrYXjiuLcUW0Obj8JdQPmADCQ03oUV19FcSCTBkGsvCo6gXcWq4BDw9GI48kmPtwty3zygtEN/olaphyCaNJeivzXeE3CogHRmf5ikQoSAeMfMbnWuCZ6h+ynhn+bm2/dS+t8J2A7uKcZ8FG579pvdGZVn7nKiUb4UMvQPohC06aqrwuvcoSjQAHPSQkXWsJC6eMIlCOoqmit6w8/dtaP/ELO6oOws2bGg2VTJNCDm+NxkXrKXtTcHTXPFBWeuurhY+xq3RPR29i21z/3zkCOHjFuezz1jqsGm8XwgOCB3kXlOqPXx2h+imB9azOD1e+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7I5XGDHE1MwwLkHpU7s6hNGhiLr+/3+k35qC0Yv5Jg=;
 b=MxEKC0s1C0Y1LzPz0xx2wROK04ZuF1y8cjQgbHdiGuBzHoDLy9N1xZVaVZ1Vz0EGZ7WgtrF9vRZzylCv3vZY/4yK/Sorij0VZDhz8x+bXDRq/dyBE0NbY51ONG8TUD4+JPb1/bVtBHEtBnA1TYN/XzCK+SCfFVCUtzbwChJLvs+0iTdZZCV/if8lifLJ5RM8uWI0SDVuv7p5ej4dt2lxKgLCKxzZRgO2L8A7AmvN+FBo47x++L/kDpKoyzos84Mj9TggJKGDM/tXCre3c8NFFWTsqPtn1Mgax3TJLQE1LbKnDn0mH2yW42ESInRABJahxoTIhy/r5euazAigAKv9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7I5XGDHE1MwwLkHpU7s6hNGhiLr+/3+k35qC0Yv5Jg=;
 b=rNbZhGdr4L/tQU4N/Yv7g2fuLGmjdKHv99g1zRtPfnRcoO9NFrPzj0GTorbUqcK7HRE3kW14ckU0dznHlyFQQDqRxshcWREfTXHQp89BAIHh/dEPusNs+Ff0rQqXGrk0c6+73jRh+elOED+fGEY+6KuuRhOGEvdjNj1KftBeeQ4=
Received: from MW3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:303:2b::33)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.16; Wed, 28 Sep
 2022 10:02:00 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::fd) by MW3PR05CA0028.outlook.office365.com
 (2603:10b6:303:2b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9 via Frontend
 Transport; Wed, 28 Sep 2022 10:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 10:01:59 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 05:01:34 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
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
Subject: [PATCH v3 13/15] perf mem/c2c: Avoid printing empty lines for unsupported events
Date:   Wed, 28 Sep 2022 15:28:03 +0530
Message-ID: <20220928095805.596-14-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928095805.596-1-ravi.bangoria@amd.com>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 9160ac62-2884-4308-cb02-08daa1387c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFfQLpYBnBCT4tHATeYdHVLplqJ+1UuL+ZMrqa1PprIdtZysbrA6d/zAWJxg90Ou+6Ck+ivTS2l6+iu4pKbtxmnuuqfqxi2qNgymhR1GBdDQ8JeOifrOOdYISA5WYHZp4f3nBcLelkAdRj3O241FOg0PZGrItWzVczMYSNljR1J30i/iRU9Rq2Hjxvj55oydcnqSg6DnvK4PJqVlBixf/o/lRGM8s8fvOK8yJy/DpQrvn/MjIUV+2uGHOrwPq0AF6sr518YUGdrEKHH97W4ctSNyCBiTmWoUq6uNf0lGtwjtT05c0RrupMjJ8bM2t78siKgQU0rzoH//u3czSWpynbXTzOvcyEIwbhikgOD2iifTsrHbaSvOKtQYsn63zp/Y6ZUXxgzdyQb2Q4mt5s00oiSRQrtobLPd3GiWY8L84QDkh+HdwW67SnLhWO5IreGjMAEE7lqAEX9dgoZ1blEMhy7Q8fvqojDCd1IBIHwg9KAAvYTqMXdVn+RMloYoG20e9V756vzeHY1d27d47OLkuimn07Fc8afK9luVBEBvM8MTb97QBcnw2DfTAKVd2ORLHrhGbvRI7aH1Fh8y5qIjXOrEcjEZ63e02JleCv2cV25/R8RCyNsdvCBO9n7zD+QGbsyyVeU0/0a7/WDr34lzuaBUWdzOlYAb09g3lBqH9XYb6ZAUrE/BEOFOgywbuozUUG1cHSrPCfvmQndrbjDOUNYyN0TN7o3bc3SRBr/kGbZ5aLUz7f5goMO2IEvPQ6bLEM8cjdKISk0e9pIgW/3k+V7o+2mNqn2oE0ggr/uPk9s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(82740400003)(54906003)(44832011)(110136005)(316002)(7696005)(86362001)(2906002)(356005)(81166007)(26005)(6666004)(8936002)(41300700001)(40480700001)(40460700003)(4326008)(70206006)(70586007)(8676002)(336012)(47076005)(7416002)(186003)(478600001)(16526019)(426003)(2616005)(5660300002)(1076003)(83380400001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 10:01:59.7170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9160ac62-2884-4308-cb02-08daa1387c1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434
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
index 96a15b6dbfa3..4553b4389b17 100644
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
2.31.1

