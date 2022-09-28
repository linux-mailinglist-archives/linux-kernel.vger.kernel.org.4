Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386CA5ED9AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiI1KBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbiI1KBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:01:02 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B10AC27A;
        Wed, 28 Sep 2022 03:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqOCdH9DB+ANCH6wZ42LQg872N5qTFgffhbXZUUnTBd7x2+mn6AegfUX8B+CO+MBcBxfSBQ+rIHeHcYpC1eR6KMBF3Q4qFOk3YshMKr8ACzkMtdNCzSPfj/ftMmAP75gRot0tnpCBCir+vj1Ze+A0yaZjmu1tUn+48hPC0bAfkJqSzQV7OMNNjZXxeSKkxQprtVXACM/3s0LxW70J2hqxilZVxfcsRn2Ppvdc7n/EcZR03gMo0GnPukcCsphLvHK5wy1Jvht69oPqDArOitOs0INFKzndwAcsQtKZwdHUIdoj67mNOZ42q6bGb6qyh5pDJ/sv+BiQ4qPXeFNACj3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWw+huf1q/ey7cXwz8l1RPbD4i3uF699cWslk/ASavQ=;
 b=WEHn5oB8UJ8BhrHfl84XV7hlMVXW+mMqI2lJnf8SjMiabxTYkHOVdpm1JWEt9UUrCkefxcrfGYP+fTQmmdH+T1jA1iMqvESWW5FAMv4zQU0O7U5ibq+ibnvpbrfITiNXFfIZSwiR70DSpl/TrRFT83gECmOy26ofigQkasbNwCT8QgWhy7OtWUw2hRTcEFi4u5PIwDPAI4NAEspczcnGMPSKvoB/qdtq42a+v60sYGQC7GVSl9ZUfcjdaEIsLe62tRFWxX0Cttv0izTVhY7U+aJk+JsfuAAW9DdAnl/vxoRU9ybYIZ6KaI2R7y2h0+w/ZuJjYq2dwiJKRwklVXuBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWw+huf1q/ey7cXwz8l1RPbD4i3uF699cWslk/ASavQ=;
 b=XU+TlhkwYvQRW/9WgQajJEB05Cr+YsI1ZYpPPSu01eFJ0/71hCOejqbjFzXPVNhMol2WuzyB39AWmRUY2aP3EfXaTBcZWEb7HG54fRfDo0+/ToI0L7p4VyqXld3Sk0HuBcLJJswSKaOrHqYO3kpQ3jhsR221keo5PMqUBfwBe6g=
Received: from MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::7)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Wed, 28 Sep
 2022 10:00:47 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::32) by MW4P222CA0002.outlook.office365.com
 (2603:10b6:303:114::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 10:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 10:00:47 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 05:00:29 -0500
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
Subject: [PATCH v3 10/15] perf mem: Add support for printing PERF_MEM_LVLNUM_{EXTN_MEM|IO}
Date:   Wed, 28 Sep 2022 15:28:00 +0530
Message-ID: <20220928095805.596-11-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cee6be-db87-425e-c13d-08daa13850e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJXZ6WmHjIDqSbaFN1nZeC1Pm/GtVDAvd3PgcvmdIyOEJGN2HVr+t21g20YypnzLWSa5UaPGdK5U5JvlSqaNXDEt/XE5UNQ1WT2z+42SX1+jpheOaRkZgnFX6AGe1p/IjVd9A3by/X5M/ZN/jikyvqhsGYJG4oUOTWcCxg4qx55Od9Bgon1m5Si+K+srHmQTagrTxwcBM37H1d+wmKcwQK3KCJ93OIyx/rERqPQYIwfLIUrSy4PjqhoTYOYzHWLVPmkyM/3tVxR8dnoGVuHEHikDtVgBS1h7lCD0tIZiHPaM9DCB8H398FlFLQ6YQdqr+jqfSGMf4Sql8Qxvzu2ptkLv0cZIJkhoWsfWogsZAEqt7oEKHvINI++6LFXJOOgBSom6Z/hJmtr5OkEgpKtOlPutdugQSXTB6x79v4G86q/bJriPgPgpR/OWhF+e88ukFaHjGsfaL90C7d/Ju0uqEn99yoNfl9GgPZzoAWS8Z2mBncRXZ7ouZCleOLQbFu8BdioRXrqzmeTOWLVhf/tV7qFhXlnoGwv4lQoEtCe0N8wv5w4vmcWsUCyW0rp9GkDaUqU51F3KTsHIzhIyJ+Q1qSa/H7Tr+Eu5I9+nrs+5cy+PvXwq9R2LtB9AWiiFJnrOJ4/bGMP3ixtWEwVHv38kxCnXjuR1YVcH3wJJNByuVc9v/lUYwAEmIvPMKpvqNLk5E7LeJupi5y28TqFd6OX0cA72CAjzHHjsvdPcESv/3TMpybi7REILsyoBBL8tF2PLcDuTbKyELI0yAxmGpAKxh4puYEbFxn7Y9NGAFJAebOiL94N+KGig8CBK8cmaCasdMAsPlX+FEfhBn8fSm/tlTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(40460700003)(41300700001)(82740400003)(2906002)(6666004)(478600001)(7696005)(36756003)(36860700001)(7416002)(5660300002)(336012)(16526019)(26005)(2616005)(8936002)(186003)(1076003)(4744005)(44832011)(47076005)(54906003)(8676002)(316002)(426003)(356005)(86362001)(81166007)(70206006)(70586007)(82310400005)(4326008)(110136005)(40480700001)(83133001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 10:00:47.2102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cee6be-db87-425e-c13d-08daa13850e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for printing these new fields in perf mem report.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/mem-events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 764883183519..96a15b6dbfa3 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -294,6 +294,8 @@ static const char * const mem_lvl[] = {
 };
 
 static const char * const mem_lvlnum[] = {
+	[PERF_MEM_LVLNUM_EXTN_MEM] = "Ext Mem",
+	[PERF_MEM_LVLNUM_IO] = "I/O",
 	[PERF_MEM_LVLNUM_ANY_CACHE] = "Any cache",
 	[PERF_MEM_LVLNUM_LFB] = "LFB",
 	[PERF_MEM_LVLNUM_RAM] = "RAM",
-- 
2.31.1

