Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1961B6A733A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCASPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCASPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:15:31 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562AB28207;
        Wed,  1 Mar 2023 10:15:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wo2QCNQ3USi1Uwz3CcV6p1uJ2Tegfb1BcEIGiMfMYPUcrmfnEYeasMJu2lx6Egd1KzlFSsv9htifNqM4jeLd+eiwoQANb3uO2z6Hk/CfGxOIGe8BKZQIMTS1fVMJCeTj+0/jrVlKknax0TwHZFs6Cm5tKD5uGog9M6jUYnYce+y81DjMtCAvADr8n94wEASzOfab4vYfpFfzgSwzrhqAIlNz5YLyNdYE433iPMd0+YLkmaTq7+qgW6/+xvXRq/sgYN9clhAzeNSPIVk4dvRcXBanfec4XbXtjhFwZ2FvhEWyxu6OUnt6XXAmoJei5CDgcaw0uYMUDoE5d+7386bE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOcBlym5TcADetOq53dWoslVw2WdZKQWtgC35MQBsDw=;
 b=KWX/ZetzAY1tzY4YMbAu6l/nYIpYZWF5v2cBWMPgpcG1EB5QQbY6wJHUQMC0ZwYqRgQlxcxmxgqlCM9jWm9JbVbeDh+w+ovsGfn4W2Zz/piTvfkwTVqlRB+MAsPkVBuC4EfcM98o9OLRRO6d47kWZ6hxBh/AOKppKLKHevFwpqWz79RJd/UZ62XOXQdDOEwG6Gr2RlUQitSgucjLcnbOMcCeKBTL6YGB3p265bkY7+ddDchQjB2OY0GhNW5jOwVPdR+1K6BI/FUgMypcL5cAeGre9NVsuAxkOIn0Ih1t6inktK5wf+s5bFaiagrKxVf93UMsMJHFhU2vNMYtFI2ClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOcBlym5TcADetOq53dWoslVw2WdZKQWtgC35MQBsDw=;
 b=3D7PB+AjmqtaN4F+R6N0qqc9zjFo3Q0m+CNsQ23Fkq6Y5ahRsZpLBQQhxIFiXcJlvtyWJhT0GJy5BN0+EWGlo//xcrshG6dLoMI61yRUnmIY5VL23jFueCPp0kqF1COCv7ibwng8tDD0RsKtOMrrf3XSZAKk099DS3aLxIkRaNc=
Received: from DM5PR07CA0080.namprd07.prod.outlook.com (2603:10b6:4:ad::45) by
 IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Wed, 1 Mar
 2023 18:15:16 +0000
Received: from DS1PEPF0000E651.namprd02.prod.outlook.com
 (2603:10b6:4:ad:cafe::a1) by DM5PR07CA0080.outlook.office365.com
 (2603:10b6:4:ad::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 18:15:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E651.mail.protection.outlook.com (10.167.18.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 18:15:16 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 12:15:10 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
CC:     <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
        <ananth.narayan@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Wyes Karny <wyes.karny@amd.com>
Subject: [RFC PATCH v2 0/2] Enable Core RAPL for AMD
Date:   Wed, 1 Mar 2023 18:14:47 +0000
Message-ID: <20230301181449.14647-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E651:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f1c78a-ff67-41b2-8df3-08db1a80e8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8qKLaXN0g+fR6CSd7IWBHrDrLpOfQrO2AXXK39nZJyyL5W3DS72ndAIvNOdEM46CnVZwZFYnaM+oWkTvXCxT5w6AS4eMezmt0mX5kZ5Dz7nfHjrEqFrB/DRVVKsypDVv1GzXda8E/UuBMdJf3hu3+VZK9WBRNbIt/4UfhcUHw76m0K12jKn6FQafIw+RKh8GhELUZSR+ydYs/4iPOx3NjzclTd+JmMfpsN003RSiTT8y096zp5mnz+DeR0BkfI7VRe69twvdnpjd4AqioZbiNbBWIlUhXlS1rNHu2ywIbLtffx+dE25B4rvIXJd/FOT+VjRE0Bi6sXb/RfpujD8qcDDstz4LbjSBqrp63NKxFOQeYfNH0JaKACdvvWiS5EISPuOa1PQSltBUfvecMWEXoufYHJBsFwkL6IgsQD0l/xJDeFcxmbLZ6SDweGXoHcOt1x0rxQ8CthnC1p4MPg/mdd8QfuqOAPDnKDpwsGffQscr5P/+mC7ME/1MjnQJYimXx6qNRdrj7BAGkFjsMMBOrZndpLEu60LylFDB7zi50bhfSSRhz7YAtQS9bDlDasR48tlbHk3SCDv/m13GIzFUQSs9cXdoYNMT2YLiwuEZifrYQAoMoclKA3CvcHez0kKEXiBxZ09wtpNYvs/R95lhpjoHHNrEwZgnJUlU138/a83GTH4IockuWrQDNJ62IDlVPnyskzmLNb3fxmXIE7AvaXk1h+5judQmugdknqtC8cLuwS7O6AjsLy3MqQdfkEefKS8cbGDrYR3EoEnN7nyuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(40480700001)(356005)(921005)(336012)(1076003)(2616005)(316002)(86362001)(966005)(70206006)(36756003)(7696005)(70586007)(54906003)(478600001)(40460700003)(6666004)(41300700001)(110136005)(82740400003)(8676002)(16526019)(26005)(186003)(4326008)(36860700001)(2906002)(8936002)(47076005)(426003)(44832011)(4744005)(7416002)(82310400005)(5660300002)(81166007)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 18:15:16.3223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f1c78a-ff67-41b2-8df3-08db1a80e8a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E651.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 patch set for enabling per-core RAPL counters through
energy-cores event on RAPL PMU. Added RFC tag because a new patch is
added and this additional patch may need clarification from the
community.

While enabling this support with v1 patch [1], Stephane reported an
issue where for the first reading of energy-cores event for every core was
invalid [2]. This issue is addressed with patch 1 of this series. There
is no change in patch 2.

[1]: https://lore.kernel.org/lkml/20230217161354.129442-1-wyes.karny@amd.com/
[2]: https://lore.kernel.org/lkml/CABPqkBQ_bSTC-OEe_LrgUrpj2VsseX1ThvO-yLcEtF8vb4+AAw@mail.gmail.com/

Change log:
v1 -> v2:
- Added new patch to fix the issue reported by Stephane
- Added RFC tag

Wyes Karny (2):
  perf/x86/rapl: Fix energy-cores event
  perf/x86/rapl: Enable Core RAPL for AMD

 arch/x86/events/rapl.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

-- 
2.34.1

