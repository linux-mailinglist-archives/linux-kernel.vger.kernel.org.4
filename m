Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2683D62D3F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiKQHTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbiKQHTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:19:37 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597AD6A69C;
        Wed, 16 Nov 2022 23:19:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGhJLVD2MQRvsnDEsCqzYwD00UyUoN1T0wKZaZ0/ND2TPPbM6RGvHLQ2Hu08VWpObfXCyHLbYPDrFeHxf0QQK25dCYonG2WScbMwstiEDFR9ewHXgZrvTDuiE+vp4z+AvDQGlexy4t5M3zvbFuonB5qbHD+zdhADRVcZgIs56GGZEwncKW8nTrhhkqzlabvBsqTLhZ58zr8GP+URiKcAZ2ueiayVHZX+VdKTO1tS2/Lck+C2gmbrV6BbxJBITe1yeOUy1cJ5k2UeDNxdPj6rdSKWoWRYEnHPh9aFJmPif3s8n21W6k4DNSzId7JT6OHzncdazoAX5qe8tU/bE6/hZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tb8H9W00HJobpUfMr4y3PypovyjHyqzDxXDtJbP/xtw=;
 b=GvEjRZhjsnEpBHHjANFgAY7CXlyFXWKmSWd6kqm+Yu8iwVDJ91ZErLl27cr3wUcYb4vTkLxuON0OGBY+979VDrpQ0faled4Txb209KSiAj+VcX2dsTZ1AA1oYAWHpG07YiIYHZZ8LP4yZ/UC9WqyUbqoctbbtjrfStbFD0WHv4cS/qi5EpL5wpVZwYDpYduhqz4pGA++pmkI0a2B4t3Eb1XleHcba2plugy5Dr8A20Gek1tfc9fyyUqz+N/GGr1FDpxg+Sa6uTwE50ZLqmMMXLljUDVlYJ/oQlWL0ob37BY+erPyPMRtwn+I6YLX8KEgW1dgQ8cI103ZNrdNeTCjNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb8H9W00HJobpUfMr4y3PypovyjHyqzDxXDtJbP/xtw=;
 b=cWLSnZuuwKnsSn5cREsDUtmNVgh+QywjmNpEpxXZ3hdy02VlI18CWOgTa5e9N3gVIkpEIdLfC/kjtcTo6fYcARZPmSq89sEpEdsw7p1iBP1/tx11faXCK3ZQ+unNSddN7X30fRaKxE/x+Fw5mzf3qzj4WXyNmv3KgOeG/2D17rE=
Received: from MW4PR03CA0084.namprd03.prod.outlook.com (2603:10b6:303:b6::29)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 07:19:34 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::11) by MW4PR03CA0084.outlook.office365.com
 (2603:10b6:303:b6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18 via Frontend
 Transport; Thu, 17 Nov 2022 07:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 07:19:33 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 17 Nov 2022 01:19:28 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Mario.Limonciello@amd.com>
CC:     <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Deepak.Sharma@amd.com>, <Shimmer.Huang@amd.com>,
        <Li.Meng@amd.com>, <Xiaojian.Du@amd.com>, <wyes.karny@amd.com>,
        <gautham.shenoy@amd.com>, <ananth.narayan@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 0/5] AMD Pstate driver Urgent Change
Date:   Thu, 17 Nov 2022 15:19:05 +0800
Message-ID: <20221117071910.3347052-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5d4603-a312-4042-b066-08dac86c1393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3K6pVMfXdsAmRnkoJKQAAWlqymrHoHY1Z7uxgiDZ1nIBcv0GXcduGwvDvdogsLlz7iFSl2awN8Z3GKUXpNk4aPitHXOX9UACOOpJ2y1UuKvrtdqmYjJimSwF92BUItIUXwSJUlWQD6OMp0oAYMj2RPH0y0riaanMc8LoUU/XB6AlNf7FzcPk/wL9JHQMVmnOuObGfJuX6h55Wf9bRklFK5qVc86cfL0Y2cXafpu0LWuDs1x2eVikDm9oIAzOX/x28mslW/2eUzVuy92gtOtImH0xxQXBChz4w7vYbw6RmYoYapVPB7RcgG65ZZ/B2hZp2+mTpXm8ynnT80S7IyvLAIls0bqZp8Kmzo7//4HfkwecIUBPyistSBvGV2HVnNz7jyJkKsPJCniA5nHsC/V9IcQABRSjp0DAN4Gx1w3TVSXqTBOco4522UXetbHzTc08AByOIIQ3XsRrJfy438I0aySvUAPZyn7byrUB3dhNLDWJYKzZ2CnrdambUHXvXtXlDCqYhMc2cuXzE53PQX6GfhBdvK6B4ncbnTbgPJrYKrSUc0B9uOeDA+939zBWzPxThOLRn16/EvQGRFtp+Hm5ULNejFcj4gZTZNRnfb911BTo7zruwB9griwzL4nZYIr+WbK+eDWZH0EAoetnq5nP/2jFaJZ0U+UKTM1P7RuLz5SD7ERgqSDaPzQHuQl81fhrBHvZ01Z5eLBDYTZXTOWY4y1nnYli2Hz4MCqNrzpl4xTYUn2nf7H9Q/I/8z+XRyor
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(26005)(36756003)(316002)(110136005)(54906003)(6636002)(86362001)(478600001)(6666004)(81166007)(36860700001)(82740400003)(40480700001)(356005)(426003)(1076003)(2616005)(336012)(16526019)(47076005)(186003)(7696005)(83380400001)(8936002)(40460700003)(2906002)(4326008)(8676002)(41300700001)(70206006)(70586007)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 07:19:33.5097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5d4603-a312-4042-b066-08dac86c1393
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset changed amd-pstate driver as built-in type to resolve the
driver loading sequence problem, otherwise the acpi-cpufreq driver will
be loaded as the default cpufreq scaling driver instead of amd-pstate.

Some new kernel parameters are added to allow user to disable pstate driver
and load driver with passive mode which use governors to do the
frequency scaling control.

* `amd_pstate=disabled` or no parameters will not load pstate driver.
* `amd_pstate=passive` will load pstate driver with passive mode.

Set the `amd_pstate` driver disabled by default because of performance
degradation on a number of AMD ASICs in the passive mode driver,
especially the shared memory support processors.

EPP support for the amd_pstate driver is under review. With EPP support,
the said performance issue is resolved. Once that gets upstream,
the `active` mode amd_pstate_epp driver may be enabled by default.

Changes from v1:
 * fix commit info in v1 patch PATCH 4/5 
 * pick up Reviewed-by flag of Gautham R. Shenoy 
 * pick up Tested-by flag of  Wyes Karny 

Perry Yuan (4):
  cpufreq: amd-pstate: change amd-pstate driver to be built-in type
  cpufreq: amd-pstate: add amd-pstate driver parameter for mode
    selection
  Documentation: amd-pstate: add driver working mode introduction
  Documentation: add amd-pstate kernel command line options

Wyes Karny (1):
  cpufreq: amd-pstate: cpufreq: amd-pstate: reset MSR_AMD_PERF_CTL
    register at init

 .../admin-guide/kernel-parameters.txt         | 11 +++++
 Documentation/admin-guide/pm/amd-pstate.rst   | 30 +++++-------
 drivers/cpufreq/Kconfig.x86                   |  2 +-
 drivers/cpufreq/amd-pstate.c                  | 49 +++++++++++++------
 4 files changed, 59 insertions(+), 33 deletions(-)

-- 
2.25.1

