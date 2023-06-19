Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077F5735DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjFSTF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjFSTF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:05:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C9C9C;
        Mon, 19 Jun 2023 12:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWbD+gj6h3vsEuj3pHavcbgEhqys0jcehjEh7IykLjkMltD/l8GUMxzeFXaygV30oyK2b5Xt9oMoru1QdvCNTWgaYmNXfIISpyAgRSeI2n9ady/l1WhLHzbQCji4I4lHSihZMKmN7inIXA4ZQbDS7X5yM8Nxe+vSnsj9hAKE4uZK+7yg/J0bJHyzKUrosLEAZFhCaEQ4mOUYulA1JqhjAbe+7hXflNa83TOhlL5WjD2TV8ITJaWHxjg2ftgwUA1XD9GGzXZ4yyo0rv75ADxO3a5p9F5+/sbIgmdrl9U6vVDzmVACgO+f0vO7cHjFXvE8xCIsN+59j4JIskqRs2lLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJcSdy2Dc1Nq679aM2Hm9CfnatOxrA9w5sao2uIC1ZU=;
 b=gUZAnpvg6k9sJ85DV6dS4dm93kUEX139q9UcrpsH8qt7ObCUJTnJpjFwC/lKMzbZMP4dJ61/lZ4i/jK2Gj1ktD863YmF/CDnyrnV426iVinHxs8mt1Cr/Pg/N2BxwG9h0fuzY3EIdO6AMant+NrHZ1mTBpEiJlme17vpugSz5/Jicv+6ItNoATRHrjhlV+Ku5hb1R2OPS5W2XbpblGQqXYHr7ay7Xc9nVHaqYfWFBYAW8PSa+U2PrDIfJ5kyIBKuokYLRK4QF4TC7JHzNDs2NT/TRfDHLif19Xd4p6WgZw71Zis60VCtOBMOX4hrOupO9gYR6RmHzQluI+ARBBEBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJcSdy2Dc1Nq679aM2Hm9CfnatOxrA9w5sao2uIC1ZU=;
 b=HxfR7Ib1kCqLIl3cr+DnDTvFnyJFDVuLSI1YHDRnxWnOEK/V//cPwj07FNIbJdEWyg7UX9uqNHQkToxVkBpmJDWAY+WLLBbjmX0T+60bnhunLuuWHo07dHozTukRGMb3+qtugD2yMHZ8fJI6CauAdvkYSVJEa9uffyvieUb04+o=
Received: from SA1P222CA0107.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::28)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 19:05:21 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::a6) by SA1P222CA0107.outlook.office365.com
 (2603:10b6:806:3c5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.44 via Frontend
 Transport; Mon, 19 Jun 2023 19:05:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Mon, 19 Jun 2023 19:05:21 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 14:05:17 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <trenn@suse.com>, <shuah@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <gautham.shenoy@amd.com>,
        <Mario.Limonciello@amd.com>, <Ray.Huang@amd.com>,
        <Perry.Yuan@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v3 0/5] cpupower: Add various feature control support for amd_pstate
Date:   Mon, 19 Jun 2023 19:04:58 +0000
Message-ID: <20230619190503.4061-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: a60e0303-9c32-407e-f5fe-08db70f82149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4EhcPWv0t7R0zZ/KP/bZk78Q+97x6cBINbvztd2EtO15jWYNlKq7e9R8+e+uYz6o+dIB9GGN30d+nX9PQuabVnH4vBh3t4MCAmiIIklbHOcOxNae1cikdlDPkGX2PzjN0XlV5DeBVs6Vsfp1EQTUTZ7SKBhSxj/v9V8fz7FRK9ti3gjMNGcz9KkWSELXKQ76uLNB5nzVUhRxQI7CIf777V6CY6Y4SxP43zDgxnHE2rAQU8JtJZhhbVfanmU2ZDmiicSp0eyVx2pswg5nQEG1f8kN55KsbhWTtweSBk+JqvsP6Ls/L5NVCTF1q3g361zsE6fj4VPvRqXBWE8rcNA0iuaoJjsW+UR0pwFcS3a4CxxHZXKUp/E73QU6wDADeuaIdK5Ry6RJ0qMSe7BTgNTh9PLGWheAMP+wAu4YEC8vS0AgCWWyor9Rvv7D+uokyNNuXdBSCnN6J8vNaAH1uWaSElzXF2w42mrhfmX//xKAoYKHdRxzpErYn5fEi4RFx/bGm7fArwfuRau8fvblB3IebtxLAhbdqp46gTm6WsuyC3RKaDCOjz3X0nCP6J3LwtITNwdzDwc3ANqwMfxKiCdPcm9BOWm/i934xuTJhTuG6BkzlzTUFEJr/4wwEhBTLoQGfJaOUmOdF7CdikdeqhDmjus5xSD6A4CiwYNNY0x8DgVkJO5Rcc8NCYPHXOSb22XK8ci48Z1hvCegmg4KIlIM3sz4q1umtreVlMopG+p4CaixMxzupNm1p9q5x395xhgMeg1GsORsu27uARD8IqslEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(44832011)(8676002)(8936002)(82310400005)(4326008)(70206006)(316002)(70586007)(41300700001)(40480700001)(86362001)(40460700003)(2906002)(36756003)(7696005)(6666004)(336012)(426003)(186003)(16526019)(1076003)(26005)(2616005)(356005)(81166007)(36860700001)(83380400001)(110136005)(54906003)(478600001)(82740400003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 19:05:21.4502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a60e0303-9c32-407e-f5fe-08db70f82149
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this series, three feature control support for amd_pstate has been
added.

 1. EPP: User can control Energy Performance Preference (EPP) value,
which conveys user's performance vs energy preference to platform. This
feature is present on amd_pstate and intel_pstate active mode.

 2. amd_pstate mode switch: amd_pstate has various working modes such as
'active', 'passive' and 'guided', which can be changed dynamically. 

 3. Turbo boost: Turbo boost feature is present in amd_pstate as well as
acpi-cpufreq. By default this is enabled, but user can control this
feature dynamically.

These features can be controlled with `cpupower set` command. The
options are respectively --epp, --amd-pstate-mode, --turbo-boost

Also, make cpupower recognise amd-pstate-epp driver.

Changelog:
v2->v3:
- Use common prefix to recognise amd-pstate-epp driver.
- Picked up review tag from Mario.

v1->v2:
- Drop patch 1, which was amd-pstate-epp driver rename change.
- Picked ACKs from Ray.

Wyes Karny (5):
  cpupower: Recognise amd-pstate active mode driver
  cpupower: Add is_valid_path API
  cpupower: Add EPP value change support
  cpupower: Add support for amd_pstate mode change
  cpupower: Add turbo-boost support in cpupower

 tools/power/cpupower/lib/cpupower.c          |  7 +++
 tools/power/cpupower/lib/cpupower_intern.h   |  1 +
 tools/power/cpupower/utils/cpupower-set.c    | 65 +++++++++++++++++++-
 tools/power/cpupower/utils/helpers/helpers.h | 11 ++++
 tools/power/cpupower/utils/helpers/misc.c    | 57 ++++++++++++++++-
 5 files changed, 138 insertions(+), 3 deletions(-)

-- 
2.34.1

