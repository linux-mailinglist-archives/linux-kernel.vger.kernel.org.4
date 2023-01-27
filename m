Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26FB67EA4C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjA0QDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbjA0QCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:02:53 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84D6875BD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:02:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtjClxGnO/b4ngMiPwEB5sxki2mETt5PfSYzNvBK5triXrJRiywsYXyEYw7bu7MtTDWDF/jCGXsvxaDALi8l2ESphZ01ELkel5b3sfE6iM3/qlWsMFusQRO5BS2T8Oj9od1d7fQLA1B6fhVYdfJBrYQ7eVQIeg8suIVyOC/1kS4IkC4eH/pKYTMB1kyaGVhaB+lmxix5xPRstBOG4czGfQkGKdFRAt1Ek/9Z/AzWpigA6NO9YPODGRi9DV4ZIQVXZY8jLWTrM6UyaO4rUvz6VHm31woaqMrPPD4Rhfv1R8KkuosyMAvX7oQywvcGpDSQ6WWhcyQP64Dhs43IWLl98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7Ffe7h6WJTFENl5vmNJb6e4ngOGSJ21xGhKV/p8Y0A=;
 b=RDhAmd2qa61jZ27hx7fWwsnGtMmw0gsK3z4OiwIF4qyU6zRl2rLWFai9tF33xseQe5ytQlDx+vsdLH93tYM8HFETUEi3fwoWCkiEkR4x+mKYz0RjuuyqQYnCksCRX6r4tU75jrIFz8dlHk62iVCQhaKwC4BquNW06fJtXKj9RC3l8UU/slNUsywHqvQSNFd8HxI8CycTDW5sIOrxHDexF4rRh4gsdLqbVDCQbJ5jnZabmhzsoz7FzllTm+GvacNZsSui9F/385WDMlgbGy2ClkBitEkCt34E28F+NTtWM61fnDVfW2s42qPSe7KGe+EkVHU8hhvZZfSeS0mKoFpGhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7Ffe7h6WJTFENl5vmNJb6e4ngOGSJ21xGhKV/p8Y0A=;
 b=bltZzQ4BKMPQN00t1iExMI+MjhW1MvhuEFJhIsb+zhWb9sDwHCrAHP/JyRpw2l3DrD6T0u2ZARTyOtntjQhfDKObn7x43a83Fsx0BUifWUCbBFTTFeHkAyqI3pvys++v/zkqIFbX5YMd7exzMx000UPEbxIHC5XcGKL5Og7c7+A=
Received: from MW4PR03CA0179.namprd03.prod.outlook.com (2603:10b6:303:8d::34)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 16:02:11 +0000
Received: from CO1PEPF00001A5F.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::9d) by MW4PR03CA0179.outlook.office365.com
 (2603:10b6:303:8d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 16:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5F.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.10 via Frontend Transport; Fri, 27 Jan 2023 16:02:11 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 10:02:10 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Jaroslav Kysela <jkysela@redhat.com>,
        Mukunda Vijendar <Vijendar.Mukunda@amd.com>,
        Saba Kareem Syed <Syed.SabaKareem@amd.com>
CC:     Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] Fix default DMIC gain on AMD PDM drivers
Date:   Fri, 27 Jan 2023 10:01:27 -0600
Message-ID: <20230127160134.2658-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5F:EE_|BL1PR12MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: e5baa7e6-1248-44e2-f047-08db007fd9b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2u4AWoF8ZzVf4YOQlcvVf9Q5q42yv5HWHGKudM9kY3NaDDrefvbLZ7gZ2u15s0fqRz0BEjxb4IhhyNnTmz+CDsLDWsCexbC7l8iUK2rKHfiNyR2keiV3iQsE3X8aTsbObB+TY7YZKwg9nPiURNdG9hYdiZlmoGHA7vrSFikPAf5D1Bt1+PkLMiVJG4HzTJ9EarFv8UyXHDvCBWefIO4/65+qaX8CJ2paOlWNCWCAoTi9F7k5RvhwTrUQjKWgLZ5Y11DodlzI4laECKeEIsS6nv+QtDEBChUiirKR5TD4GgJMac21EPTzdpvlW1SgnPD+HTHdwngtMDiF7E40j6N2vW+orv38QPFUyajQkyZd9Q3KYPRy9eJEpfDTUgx7Yh7gvO2Nkrfd68rBpPGI87olqdXAHXuzO26gDTROiWeNWmEXmr3ifM0VDurZ9wTAUgUJRKBnlcK4W9rTE5RNHoymKpsRWspPdT3MbTYlnkfPD7qHF2rWpmUHVeaf8AcJudoaYLiVsutSBk48yLOBRBQ3iYMy4VhcffQfsVJ+FIHsUqpiyxD3AvMeq1eIP8nteFKRW2MM9n23U12fPXhIzMz/IKbzeRwykomXmLBW13jLhUeiOm0MZBZ0nRTainDCnK4T370BURZF+Dhzz9ddjlImg37h8W6CfF0PQubaF+9COIxw3uLusslSra0TC/fvaEuPqVkPRNOvWtEkYQEK8m51fKjhnTJQTiLVIRvK/vnyA8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199018)(46966006)(36840700001)(40470700004)(47076005)(66899018)(8676002)(36756003)(40460700003)(7696005)(54906003)(40480700001)(356005)(336012)(16526019)(110136005)(81166007)(36860700001)(26005)(2616005)(83380400001)(86362001)(82310400005)(426003)(186003)(44832011)(6666004)(478600001)(6636002)(316002)(1076003)(70586007)(41300700001)(82740400003)(8936002)(70206006)(5660300002)(4326008)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 16:02:11.4986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5baa7e6-1248-44e2-f047-08db007fd9b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been reported that a number of laptops have a low volume
level from the digital microphone compared to Windows.

AMD offers a register that can adjust the gain for PDM which is not
configured at maximum gain by default.

To fix this change the default for all 3 drivers to raise the gain
but also offer a module parameter. The module parameter can be used
for debugging if the gain is too high on a given laptop.

This is intentionally split into multiple patches for default and
parameter so that if the default really does behave better universally
we can bring it back to stable too later.

Mario Limonciello (6):
  ASoC: amd: yc: Adjust the gain for PDM DMIC
  ASoC: amd: yc: Add a module parameter to influence pdm_gain
  ASoC: amd: renoir: Adjust the gain for PDM DMIC
  ASoC: amd: renoir: Add a module parameter to influence pdm_gain
  ASoC: amd: ps: Adjust the gain for PDM DMIC
  ASoC: amd: ps: Add a module parameter to influence pdm_gain

 sound/soc/amd/ps/acp63.h             | 2 +-
 sound/soc/amd/ps/ps-pdm-dma.c        | 7 ++++++-
 sound/soc/amd/renoir/acp3x-pdm-dma.c | 7 ++++++-
 sound/soc/amd/renoir/rn_acp3x.h      | 2 +-
 sound/soc/amd/yc/acp6x-pdm-dma.c     | 7 ++++++-
 sound/soc/amd/yc/acp6x.h             | 2 +-
 6 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.34.1

