Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545D67086CC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjERR2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjERR2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:28:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9151BC;
        Thu, 18 May 2023 10:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFK8vYyhyH3BlzZDr9fcJ7a8in0wT3++38ZEf1Cr1ylhrY3STgO6gbbVj+OREcfjiCvP3pnfHorhss0U4H+SfZyFZLBQV2CtaHpFH+5eE2wAtiim+i7jeuzmRptuoxnWcOf2OlI7wu4QCL5BZ/HVBKa+sGYg5zzNrsTrbkU1ll/Ij3K0OTt+YITxNM+Kii3Nxs3mgNmG+dNftPRHn1OFV+QA5cbbK76ShfugAAUe/P3s5nuBcvd/reNmNFieFXhPpmJEWGtULXTmGUCbLC5wKpBTHFw1h+dOuHUNvrOQtwWv/6X/YXjAFFRdRXvOPnueB/V1x8FYm6NYljIGFpSvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/LWIfrKalGUuvIfgcJBFdyNSY5mZeMpBOTga2nxvi0=;
 b=j2Bo/i++oNYyS+1pYBMA/HQxCPP8kuHm4RPYD2aD5Zyeufe4FWQJ6fbegPN02Kepz41yESHUsr8oNESdBPzRvpDPRafrkjL0Hgl105WtJoM2ZYgT5WvEHolTKjHQ42QL/Avtq5G0FTwtyuB7U103az1Q5ss0ojhtch7Z+a12YslLuNzdOWowrDKQMMKwxRzqTwS18W3KDnHZ09e6WNYGDzzMmQOjE4Fp8WQKF6xsSg3Khx2DoL97ATzOKdU1BduSnp1hhVBAieXaCF+PaRRMHP+rvV+eEo0uxn9tuIvc/ebewt77iG7z7ZliPHTaCiATq8rnEZseabCg4p0VxQygCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/LWIfrKalGUuvIfgcJBFdyNSY5mZeMpBOTga2nxvi0=;
 b=lNzp/s8he/W/UgWmvhYC0BGzSNGrPMD3eDV4yLZ7sv/eO+QstmrAy31OoK3OqdC9+8ahjwvFVEbmJ/8p6CQEJERMG1n4DjHQgoL5I6uqunomBJTQPT9Ns9nmhcdi/71JF9fo4az/VRYgHNbLACRCCS84pBB2CCKgQxu45GMcCFY=
Received: from MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::28)
 by SJ0PR12MB8139.namprd12.prod.outlook.com (2603:10b6:a03:4e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 17:28:36 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::75) by MW4P220CA0023.outlook.office365.com
 (2603:10b6:303:115::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 17:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.20 via Frontend Transport; Thu, 18 May 2023 17:28:36 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 12:28:34 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Shyam-sundar.S-k@amd.com>, <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/4] Add consumers for pm_pr_debug() outside of pm
Date:   Thu, 18 May 2023 12:27:48 -0500
Message-ID: <20230518172752.93322-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|SJ0PR12MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7f75c6-e0a2-434d-48af-08db57c54fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ym+c4MB/U+6ha1erlVyfAUlq5QNvVCogaGjzqU5X4Ew6wVF70sA7b9cl27lUI/PnyhgFWeQY7qmagWFA6A1vA9moQdxqyjDpSU/Rhl8W3a47zp4Bw6/7T7TF27rsnyFGZMrBzrwgzpubLtXN8Zk9Lbtse92Xr/Gfi6nb0PO970xW5fmRxbvlbZMZxsXcF5JUn2bG31bmkL4w6s64+JucE5KL9kq098zEVumkvXlMGiLifF+rPaS8wNkScopzrQUZwaTnNzTbP1Ug37y3MpkW1cXfm+bmmSN6RHlLprjeuNiD14qtFLH+iUMen2j6P7+LVVOx+NVDL7tHhzPSf9JN3BkGds0b8kEgVcgIH/78hy+5ilK/cruvxq36c1Ng76jZpr3siLdSitzX3gKO/RvVwk/YyY5oraqMpuxtT9pUKNB/ev8RNqDJkdug4uGkLeRbBLasWz42NwrDTHcEBpgZwo/hR/gbSAvQuWXISGtCxUGG8h/2lMpaSHVhs8sJujrQ6n+Kbf757Ujw5qS/dXN2Aa4iBBFRjjWwsoZjRuakm9c3ygfphN73JlAEq3HF+JZAoSEyJcSUhn0SqyQsS2QUBV+G1WOtLqWnSjTPUN4xZxMtsMU/3gaToiAe5CsxFsyuUIKgdeBSUZBdfe1C0v0J9J7dFpAkmb4HNZrO/gRiixLe4jQDdOLywv12P9VaSO0MpXtwag0kDv+dTDz0y+a98milmG5JIUBRXDAnATvuvvek35S8ivEBuZQe6IrT9Ewv9eyGLkvJU7Dxym/ubVOkZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(186003)(36756003)(8936002)(40460700003)(356005)(426003)(16526019)(1076003)(81166007)(26005)(36860700001)(83380400001)(336012)(47076005)(82740400003)(82310400005)(70586007)(4326008)(316002)(8676002)(2906002)(44832011)(41300700001)(40480700001)(7696005)(5660300002)(6666004)(2616005)(86362001)(70206006)(478600001)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 17:28:36.1530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7f75c6-e0a2-434d-48af-08db57c54fda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8139
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amd-pmc and pinctrl-amd drivers have messages that are generally
useful for debugging power or wakeup issues, but users need to know to
turn on dynamic debug to get them.

Add support for using the pm_pr_debug() macro outside of pm code so
that other drivers can use it to show messages when a user turns on
`/sys/power/pm_debug_messages`.

NOTE: There aren't hard dependencies that would make this apply to a
single tree, but the pinctrl-amd message is in an IRQ handler.
It shouldn't be applied unless the changes to the macro are included.

Mario Limonciello (4):
  include/linux/suspend.h: Only show pm_pr_dbg messages at
    suspend/resume
  ACPI: x86: Add pm_debug_messages for LPS0 _DSM state tracking
  pinctrl: amd: Use pm_pr_dbg to show debugging messages
  platform/x86/amd: pmc: Use pm_pr_dbg() for suspend related messages

 drivers/acpi/x86/s2idle.c      | 52 ++++++++++++++++++++++++++++++----
 drivers/pinctrl/pinctrl-amd.c  |  6 ++--
 drivers/platform/x86/amd/pmc.c |  4 +--
 include/linux/suspend.h        |  6 ++--
 4 files changed, 55 insertions(+), 13 deletions(-)


base-commit: dac0c6388ff86af74dc6f4dd6e90a7db5a429e3d
-- 
2.34.1

