Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896685E5496
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiIUUk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIUUky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:40:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E6E9DB45;
        Wed, 21 Sep 2022 13:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dErV3K0VrZeoq/x3Vef2oJc9QzekeuKJM4Kh9WFnzhDmSTvoLuHjP02NAADfiGm8fanRKJGTaFtSfaC6KP3KMnOY/vXARcauUY/IWZuAaSh3psRGWky62BI9LMbr+MAiS/r1GTqdSNES0g5h1VRRJS5M7JoJGMFyIPp4rfpoP/+6cq7BMfCzhNNcLggigMkPlLITBmeKPJBaT43VwTb7L5fCOSrl9As20yAJPAtbCg2CeO3zM5fNKf2YzR4NUjNopJKJaogEKT78TMjeqKHrro2gucb8nLU+S+zniogQlYKHb0PaGaA30nCbeMiJR5P2SU0+F8azaZ0vPvb+uVH0dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ESXk04IureZducMcYAfaiyiI2wJugqfuTspc5CLquQ=;
 b=kL4+lnBETroESlPDPYxZZ/3WUcS8F/SxoPrEdtTaPZjs4cqt1Qo8bARLpIt92ga8/40QghdwriEx4mhGQKjvqzz+V81P/T3TYI29Xs8Cfk2Og5DZ0oNhcy2XyjrEFpPN3DTupeccvXvLa95iMS4AJoh5qsJuBpvMFCBeaDqsVlowV4X4bZEFZymH/R4OzBi9ftOC3Ys3hPk+xmy301nObr4KunB206Redwjc9OkENMvjFP5HJ77jCi14iC6JfrveyhoiKX0yyh/UXf5uB+DZcPhxl2vn2oZ6D5NPiaBj2nMKU5oxEHG/5WkTFlk8aJvAVijAS0KIn9aITITJKkAUjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ESXk04IureZducMcYAfaiyiI2wJugqfuTspc5CLquQ=;
 b=WgjEh2QgOpApcKCJlzJtIC50yNCos3t8BGUf5ALO7VQ2K/0XaCrGzlz8oZPMcrwQkv5z3JZPlcPjZ91vO7z1u5sCQoZOK05XIRmwCzIzJYwiLz0sQJ0Imn3c3WO03Q8V4ljT8meV09xIpR3Z/qj1IIjweNV0gDfACt0pqYR3GC4=
Received: from DS7PR05CA0087.namprd05.prod.outlook.com (2603:10b6:8:56::9) by
 CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 20:40:50 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::ed) by DS7PR05CA0087.outlook.office365.com
 (2603:10b6:8:56::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.6 via Frontend
 Transport; Wed, 21 Sep 2022 20:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 20:40:50 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 15:40:48 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>
CC:     <travisghansen@yahoo.com>, <catalin@antebit.com>,
        <Shyam-sundar.S-k@amd.com>, <ruinairas1992@gmail.com>,
        <philipp.zabel@gmail.com>, <iam@decentr.al>, <hdegoede@redhat.com>,
        <davidedp91@gmail.com>, <marko.cekrlic.26@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/7] Fixups for s2idle on various Rembrandt laptops
Date:   Wed, 21 Sep 2022 15:40:47 -0500
Message-ID: <20220921204055.22889-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2346fa-6aec-430d-d464-08da9c1191ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5W9m1feXKoNHsKWLaH+578HHNQ5/0I2rjUmZd3dAEc5mkplWJ1PNZas/SxjEc6Z5lHH3lhhbn05D59kOvaYSCSTQa5FaiFSgy9RELEx6Oi5SAWGHq0ICqU7SWGMSH0qSrw1P/Qb3BGOt5oFRZytjwZgHzvYhUVHQrmOYRkmvCaxtZFmWvPoji8mqooIB4c5cRNRBDck8hVnZcjuEvmffWFxjh5oz9MOd/4zrOjwlOUqyhGZgdHTfDy1CdRulwsfznWl3F9F60kqRcSFsTZm5ncSoQCRYNBtmgTOauflThXkpawxPfSQsCVnBcTOss01S+tA1mq6Ar18SfmqbvokdDe7wAeGeFha0Rd9Afx9xT3U001CHts5l4Nmm5zswt1aLPM+FfVuZRHgTYjNmsc8I3bMzz5xQZDSXhdw56UiC3D8qp34Xojw/8jwoFXIe8wW+rntvO0CFmTkjBuV1TOAh3sf+BKDna+DjHNk0yYj5eke4nE5pt2SGEj0SOvhh8aGOQUl1v0VdN5gYe7KHdo7CdxrVUd56fUU+VK7OW+8m6+7tIWkC80NIYrP5i6BwfP2AYNTXcVvlNJS/SrbXMejEE77qZ3wAnbAHG3+9wqYTl68YM8P7rtKP0qHxuOdpEyr2q4zQ6QTXLjovBqN5Yu9cpSTbkEo3y9PKnmrta3gz+eztZsLIIFUR1iNDW3YgRtUMiMjuV/jcaxldWoqaWai82dxqS6kgk/2NPLiY4VjOEqoRcyIBsX7cH9uTCY1CE/gwA7sFepXnpumDiSlua7FgzmDFh65SARGzbpfm1dbljNQeyRY3zAnK3l6dDi3tQ5T
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(186003)(2616005)(7416002)(1076003)(44832011)(2906002)(4326008)(8676002)(70586007)(70206006)(41300700001)(26005)(8936002)(36756003)(5660300002)(316002)(7696005)(40480700001)(36860700001)(82310400005)(82740400003)(81166007)(356005)(86362001)(40460700003)(16526019)(336012)(83380400001)(47076005)(426003)(6916009)(45080400002)(478600001)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 20:40:50.3248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2346fa-6aec-430d-d464-08da9c1191ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that an ASUS Rembrandt laptop has problems with seemingly
unrelated ACPI events after resuming from s2idle. Debugging the issue
proved it's because ASUS has ASL that is only called when using the
Microsoft GUID, not the AMD GUID.

This is a bug from ASUS firmware but this series reworks the s2idle
handling for AMD to allow accounting for this in a quirk.

Additionally as this is a problem that may pop up again on other models
add a module parameter that can be used to try the Microsoft GUID on a
given system.

This module parameter intentionally applies to both Intel and AMD systems
as the same problem could potentially exist on Intel systems that support
both the Intel GUID or the Microsoft GUID.

v3->v4:
 * Absorb tags
 * minor URL correction
 * Rename module parameter per Rafael's request
v2->v3:
 * Add more systems
v1->v2:
 * Add two more systems that are reported to be helped by this series.

Mario Limonciello (7):
  acpi/x86: s2idle: Move _HID handling for AMD systems into structures
  acpi/x86: s2idle: If a new AMD _HID is missing assume Rembrandt
  acpi/x86: s2idle: Add module parameter to prefer Microsoft GUID
  acpi/x86: s2idle: Add a quirk for ASUS TUF Gaming A17 FA707RE
  acpi/x86: s2idle: Add a quirk for ASUS ROG Zephyrus G14
  acpi/x86: s2idle: Add a quirk for Lenovo Slim 7 Pro 14ARH7
  acpi/x86: s2idle: Add a quirk for ASUSTeK COMPUTER INC. ROG Flow X13

 drivers/acpi/x86/s2idle.c | 136 +++++++++++++++++++++++++++++++-------
 1 file changed, 112 insertions(+), 24 deletions(-)

-- 
2.34.1

