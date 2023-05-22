Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E20970BFBD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjEVN2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjEVN1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:27:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B63185
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFvbqoy8ZIFtjuHV8M2vfOYzTQmSjcKA9Gms2SEEaIF7tDAKWxbbQZ4gVT1traG0CuM7o1xCSPCfsPci83KXz848ucysB04vsg9ju/UpU+Lu3kngKch1ItRsMCSc6tksei7xG9c9VJ0sW8uq8o152NWbW/kghBo7D4k5uE3XDDx1stWg+vLL4hdiAKfCE/zNzxqXLAmkpmDo0EMHG0EKi71ih9AJ0Aa/5sd3cJ7aQ6kQTQMn6oN2ypl+mV8Ud93nv3aQtC8EuQVNRh4ad91GWkLan3ZW68YJqDoD5GFM4NLyzbh19ukkbwfHCAo0WRQskTjXGazD0xiYvnxNOJS7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrAlUYHeUtL4gjAn69ALnx0Pg3K5Pqzd2f5iFioh42E=;
 b=GX/F5+A1u1tOoHqJ0YWVl+Edko74i72BFUZRmBlhKBhlURTzLuoZ5VPxuJ4SCC4EMtG273IpQObOQvp4DVStZ7usxpVesWrBlU1+fiSgHEUonxRNwI0uXRNVGceWJiW4Mh7XmEOZ4uz7MSQH7x0DNVvmnrXgwe0LAzcgV5HPbuzjaoKdwIEZk2qhkIsykz0x+/i1xU+29cEzIT51PrtA0RCu0ujT9WeijipOKJz/pk1xkqCIPBHhibilq5nZaYdY3bpwK2rA55FYVwxuYt651t1cqrx6mtq/jUcnTqrIl+zTEiHUD5CMFowm9Y5GmOs6oLgkzm3I/hAKeLJ+vWMo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrAlUYHeUtL4gjAn69ALnx0Pg3K5Pqzd2f5iFioh42E=;
 b=LgMSEegMNMoAO8+Lx7gred81bKYHIun7OFGhjS692h7EFgH0axQCCVEbNW9yjO20VJ7Kp3VMt4uf3Mv94x0NyaIgZIVJxpJ2UcmAG1E14ousd3po6C+M/gXQ0vsfz2ub9+vPr3/6qcnq/lhaJAYo5UEiIEwu+6hfC1y3dsK2hZM=
Received: from MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::26)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:27:18 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::24) by MW4P222CA0021.outlook.office365.com
 (2603:10b6:303:114::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 13:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 13:27:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 08:27:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 08:27:17 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 22 May 2023 08:27:13 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        <mario.limonciello@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 8/9] ASoC: amd: update comments in Kconfig file
Date:   Mon, 22 May 2023 19:01:21 +0530
Message-ID: <20230522133122.166841-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|MN0PR12MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: 27cee10f-5dfa-4d3a-e6db-08db5ac84426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+gJUabAwTIGrWUY5uGWkO6/bxMKFMwX2b7Cstns/StMFBf8V7lZ4Bvi9qV1pTUeRhd9TCQCrteBA+3Nqy/lK/Yh1fMSVAbb754eeWJGNnqh/8/Wbgu/JX/56qyubDSAd/RB76gIjVbxgrpU/GtlM7E1Qwb9ozcUGrlDsS4m3Luhe+ekm2AVUjPqyFcT+SYiBhN7sYUBN6sGv3vxymgfB6c+ZffRL/6tbn5hvQSqvvJ5AMIGeTAMWkwIlAB63978vLeueyMuZIWIGtIZBef2cN+1nc/D1gm0f0WK6WKohH/X63cKsPTkHKO9BMdFlS95lLThYYfp6xSGP8GsPXkQ1OzAh9ofa1lsq7hPU4rv3+gX1z8q0sFc5bfDzUfMjc9YJzNKT+JvgXAt4Q61ZQUADAVaVrItxT/3NgxX+VoPPE35FOgLxu8D9pJFs0psZW/UhO614zPo7Npx4A+VPGFyAlAYjjqVwrahcFCgHnbtosy7zLp3B1HIV//aBFd3LHaBW29GfMNGDRGoTuZDxWaHo0YRtKT6eh/pJDSn+p5PdjRTjlqA1dl9NzdIvn8vyYk9tfF9SSlwhNX/tCM1cPMkquYsuA2n9s4MWX735tJ0ry30yMb97+1zKSGTXNrNLLkXCar1FDSQI48eMcW/Brqp8EymGJvGmD6iC45yG3rHCzlvMjso+ALlLXWdwxC5LtaTO5RbG00p0/xnaaHG8HXf9hjj274Xyk8+VYxGk3yIZ5gk7VdbIPS1l1N/Y8mswbTs9UIzWVSOLOEdqPCDIjdj1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(4744005)(2906002)(15650500001)(5660300002)(83380400001)(8676002)(8936002)(82310400005)(36756003)(70586007)(70206006)(4326008)(6916009)(54906003)(316002)(478600001)(41300700001)(6666004)(40480700001)(7696005)(426003)(86362001)(336012)(26005)(2616005)(356005)(81166007)(82740400003)(1076003)(36860700001)(47076005)(186003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:27:18.5010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cee10f-5dfa-4d3a-e6db-08db5ac84426
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update comments in Kconfig file for Pink Sardine platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 08e42082f5e9..2f0d444b21fa 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -136,7 +136,8 @@ config SND_SOC_AMD_PS
         help
           This option enables Audio Coprocessor i.e ACP v6.3 support on
           AMD Pink sardine platform. By enabling this flag build will be
-          triggered for ACP PCI driver, ACP PDM DMA driver.
+          triggered for ACP PCI driver, ACP PDM DMA driver, ACP SoundWire
+          DMA driver.
           Say m if you have such a device.
           If unsure select "N".
 
-- 
2.34.1

