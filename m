Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E677442E0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjF3Trh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjF3Trf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:47:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C8319A9;
        Fri, 30 Jun 2023 12:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyASoy29YLPYyf2L4o7sMcv4gp415CGaV4rBD94xdKgJNUHB9l5U8YIivp21aH7+qpv53Rn7cSgcSlzXqhw9zTRozcNh12KdA1IfDytlMy/wshhNm4bxDGCSrX0L97BNFmGBaz7mmYAN4FPzeBKZITzo7/P1VipNAiP2TCGwPPHuSsDRaNeNbDSMojkQ9pk82BBSNOSpkkiQKCT+WeqQC2pM61RYPy1XT65FVOCXki+vZfDeNPXGDWPNQn5ZMV0bP7tiwUvZRtDePxvYnprhrgHEFV+4wM0ADPNuPteZUft+2Q6PBGVlysZW33sF4dIQGoPBhDTJx3hJtgYBlY1Uyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh78ZFYHs4g2zn57QeMd3pl2itbup0r50sK66LoUL4s=;
 b=lRxr+J8HPQJu9XaGEuZAg8RCGMxrdFgpKkKVkrViiaruwhmZ4o00OQfIHZQjypRhbNC7IWUt6sXIppkfG/S00G80U7vOAtCjyZz2P0Dp2sL4NtrsrJTxUeqZyFArHFTKMQZJOBGIGPIiqlH8kkdw+lyo7UYw7HC6zCYLtHZIMbsVeNo5GAa816H4BkIpERNLPMrbmuwv7d2Tk4edYXto1xf6zoHk3HHPkk4e5knnQnce/lc6y6Lp8GSr1mXq5i2qoyYctADuqZE01RHh15nSTNVTKZFvVAu9YFWoilQSAnG0T3b/Mz5pZ3odKWG7aRhNQIThbs8repwwFVj7h/+TyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh78ZFYHs4g2zn57QeMd3pl2itbup0r50sK66LoUL4s=;
 b=GTGbjvGD9gGkq4aPIvNrCq2QBcU62XyP2SncvH+mzeawBZ0JiMA4B+Z1ZtfpAzF/heQn5I/AQw8VdWniYURySyBfsOZ3HEmX980RGAnuO62iC0DaolSaPJH5OjFrNQe6v8p/+7U6ik4BltK6Hqo0nE3kqfGY9CbBvE2O7tyXYyc=
Received: from SJ0PR13CA0107.namprd13.prod.outlook.com (2603:10b6:a03:2c5::22)
 by PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 19:47:31 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c5:cafe::38) by SJ0PR13CA0107.outlook.office365.com
 (2603:10b6:a03:2c5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.10 via Frontend
 Transport; Fri, 30 Jun 2023 19:47:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Fri, 30 Jun 2023 19:47:31 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 14:47:29 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <Basavaraj.Natikar@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <linus.walleij@linaro.org>
CC:     <npliashechnikov@gmail.com>, <nmschulte@gmail.com>,
        <friedrich.vock@gmx.de>, <dridri85@gmail.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/4] Fix for interrupt storm on ASUS TUF A16
Date:   Fri, 30 Jun 2023 14:47:12 -0500
Message-ID: <20230630194716.6497-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|PH7PR12MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: fe64854f-4e1f-47b8-763a-08db79a2d798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Uk5prZaYqWXbb4QQlScse/zcxnlj58EZGfjEY9pQXG4GOf8t9c/AkDns7JIWWtVUgnbohs+LUXTSzmGS6Q1ioglZlOt5H2OREVUxELPKP7RTs31geVSYPNC8cjUCiCe7WCVSFEeFNL+Gk+mr5ZaPXTC+uhwPxcUrcdJufY6NhIpMDc+DBQiW20//w1UDetWgn8nZh/YQECG5Hx60kBMXK3952aQHeIFR2Ir1YUP9VMosdPXLOuox9b2yQj9ZMQ8e16EF015ttTADv5FOmn2y9xS2GG88oSxQUm/E9eBGRqT4pjU4rdtVlrlKshmRmBS7SG8LH4Ji2h7Ssq6ERVgCV9I7f4OMLQUgE6nHwaTe4jjYAnRkSiwB4p0abHF9DXq1RL/H0AEYKmdZ0beH1++nu/4+WUt+zPMDwoEGp5a/3EDN9VeIRfmcOIvclPyR7bf9u1DF3riNeGNU8CP3VrgM9tB31nc7ScsBJjZQP9Fp4enTfpHHOxoijpC7nBmyA2DyoHAAiqlgltS7SraJB6cdlfUcwrG9E+YZquK1GgMXVB415w236uFxHe/fxqvuqh5ydcMYec/csI2EGUZx/L1IX/DXfTlaJdgULItsBZyBbq67PvVesTQFlB3LejbgPEAnbPb5rb4ikLIi6bVfKxXP9dUizPA3xvHrZOlJMrcaNW+ZMpadB2hi4RTeV+dRZnPD8bMzR+OrmTQPy1fDsDxdXM+kctohI8JPL48gQYoOdthzHt1LTV5OMjAUz2G7Wovqb9JHlIQME8E1YUisge2Ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(186003)(26005)(1076003)(40460700003)(82740400003)(2906002)(16526019)(40480700001)(83380400001)(36756003)(81166007)(47076005)(426003)(336012)(2616005)(356005)(36860700001)(5660300002)(86362001)(41300700001)(8936002)(8676002)(6666004)(7696005)(44832011)(478600001)(54906003)(110136005)(70206006)(316002)(4326008)(70586007)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 19:47:31.0094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe64854f-4e1f-47b8-763a-08db79a2d798
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An interrupt storm is reported for the GPIO controller on ASUS TUF A16
but only on Linux.  In comparing the GPIO registers from Windows and
Linux the configuration for several bits specified in _AEI() was never
actually loaded into the hardware on Linux.

This meant that many values were taking the default hardware strapping
for pull up/pull down.

This series reworks the programming of various bits to unify the
expectations for the hardware.

It's confirmed to fix the interrupt storm on this system.
This series is based off of the tag pinctrl-v6.5-1.

Mario Limonciello (4):
  pinctrl: amd: Only use special debounce behavior for GPIO 0
  pinctrl: amd: Drop pull up select configuration
  pinctrl: amd: Unify debounce handling into amd_pinconf_set()
  pinctrl: amd: Use amd_pinconf_set() for all config options

 drivers/pinctrl/pinctrl-amd.c | 59 +++++++++++++----------------------
 drivers/pinctrl/pinctrl-amd.h |  1 -
 2 files changed, 22 insertions(+), 38 deletions(-)


base-commit: 9f0648f13e34a01f2e1a7a0d5801988a7bca6988
-- 
2.34.1

