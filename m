Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E309B6F4598
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjEBNzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbjEBNzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:55:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C32C180
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 06:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmIt0j1POCGnbHAZUQOPZYjXfEdxWtFXFBTbJyRmR3szVYT3wgH6TFiK5vjdAxJTchNCoTMnDRnsSso4RE9MYHKW74FXwKFNdmanhDAisrna1kxIPmIl83+3Aq+0Uc6jsb1uOt47VmUTU9gMjjx5bNJSB8k7CHndpK/3a3bhztM5lrRjLjXeh7jyHrg/jxb4W7Jyd7QAsUlE86TAjgmOZs4WgmHX0GJr6m684exAttCsDC/WOjviobnVgC0h2B0oFqIQNtqQ9fx4fFcmp16p3BAkq5GcXNchLH0YjG9sWbgY/Am07/+dNOKWCtABMtf/z6b6YxY0HNkkdi/qCY0XpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxcShBJjYvM4SWNhV6wOd+Ma5NXetG3pASdYFiRes84=;
 b=CFSGK3CfeLpSmS1jfaBHQ+LSCH6+cTg5HNwIDgh7GtxYSr9E+bqxpH2EoisMJhLYNn9QQ26Ugt54/Iuhk3R9h8HAvqX5laIqV925/MgZZtIq38DFmcdzCS76yMt3IguNvI/ru4R0z9vgsXRMNX2Xk0HIyMHNea/8f/DWNTdPPt40RDJzPTE17DHJvHkCsoiPfTqV15P1RJqZZfhmDJ8w99SszGsZyg0L3VpHP90pVprl07XrX6UQdEzkJ/D42Zmv7x7wPHE7zu0Bzhjxef3BlkzL4IcnFni8Q5htQCPGbkHnxJdrVMqPzcwBkIztfTYMDpFT432K7fHHkrxiGLRMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxcShBJjYvM4SWNhV6wOd+Ma5NXetG3pASdYFiRes84=;
 b=PujFcEvCWHzt7B93wl9v5kaXCaehvYid5Y7aRwjG5OtA7w7zQyC9Ufi9+hZ/NxxVYXo4S3oxK/+MUur03n6DULAD/LBmPMMKNL7dCqh6z7hQNQiWti6G3mMmT0GrIs5hpCagz5shFqoo5H8+zmFxEjJKPz4B4QUhCbhs7PsOO/4=
Received: from DM6PR01CA0005.prod.exchangelabs.com (2603:10b6:5:296::10) by
 PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 13:55:04 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::2) by DM6PR01CA0005.outlook.office365.com
 (2603:10b6:5:296::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Tue, 2 May 2023 13:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 13:55:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:55:02 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, Kirill Tkhai <tkhai@ya.ru>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Qais Yousef <qyousef@layalina.io>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] MAINTAINERS: Update Michal Simek's email
Date:   Tue, 2 May 2023 15:55:00 +0200
Message-ID: <bd073d026f8c367a9cfb45d26d39f26e40c665dc.1683035692.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d70697c-524c-4054-5b12-08db4b14d4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YaThIhXkx0B/XIogBbBaGdVtkCgQgFZCFQCLpmJqHtP+ycMDwa9tR9Crx2FOjYe+uizCGxQz9xC3l/dVv723juwH9Heg+LF2SijHYNeaRgnzO/gBenJ+SkKxFoBUi7iXcNZygu5077UcjF0NCmm4tRODsBuioetmIqFRTCdIEbcGQLB5NBj034kzt9nxdlwrbSYB2BDVuqRohWHHK/9z83ng+fzd7xdcjQOsQr3w4h+8hGaXJ8Zl0UaB1C1GExVzAzdkRnHP70LTdZdqZNHqCWthGsn0vSvjyvNFe7ZlQrhDJiUiKZxhG/6yHljB17aONnZRCfNS3nITlOvy3U0JEsEq18YygOmyo7a9uM+OHbABhX9xiaYx6IsHNX5NUYHsRPdDypracvgUumLsrdc8Mz6LXYK3j5HQJCjNwDxytJYWtL76mAbRlH9Na1HZWaPvO8Jv/WGy2nJy7nw95mX6yTNeRYaFcyo0XZID/R1Gt8xH9O/18eaczfPucIMIfmDHCBkX22Mcsak60lbgbW/sDvGLsuIVN7JYwwGWALcYOLesRcmyzm7LMU+yzvJctaILpAaNJO4yJeU31msRrEpkhBELyxipY2Ly41dhUbSLUwrUER8YTZ5pUtOKA75ZKp1qBe6PzmsVusmrqaIBclgPih1vMNh2ZXGMI1XJl1XNN+7ITMz7EzjzqsixAMF/Pb5JOTMxsxtnwkBNKPSUWmIpoOCCiH6UOZ8y2pp3mpSfYqmK18GlhsD5HLlEOG+8DjF0
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(356005)(81166007)(41300700001)(2616005)(426003)(336012)(82310400005)(36860700001)(82740400003)(316002)(5660300002)(4326008)(83380400001)(86362001)(7416002)(70586007)(70206006)(44832011)(16526019)(186003)(26005)(36756003)(966005)(40480700001)(2906002)(110136005)(8936002)(8676002)(47076005)(54906003)(478600001)(40460700003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:55:04.4326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d70697c-524c-4054-5b12-08db4b14d4d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@xilinx.com is still working but better to switch to new amd.com after
AMD/Xilinx acquisition.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .mailmap    | 1 +
 MAINTAINERS | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index adfed592f88b..d3eb862f71ab 100644
--- a/.mailmap
+++ b/.mailmap
@@ -328,6 +328,7 @@ Maxime Ripard <mripard@kernel.org> <maxime.ripard@bootlin.com>
 Maxime Ripard <mripard@kernel.org> <maxime.ripard@free-electrons.com>
 Mayuresh Janorkar <mayur@ti.com>
 Michael Buesch <m@bues.ch>
+Michal Simek <michal.simek@amd.com> <michal.simek@xilinx.com>
 Michel Dänzer <michel@tungstengraphics.com>
 Michel Lespinasse <michel@lespinasse.org>
 Michel Lespinasse <michel@lespinasse.org> <walken@google.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 7575d3992fcf..643f9feeb09a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3037,7 +3037,7 @@ F:	drivers/video/fbdev/wm8505fb*
 F:	drivers/video/fbdev/wmt_ge_rops.*
 
 ARM/ZYNQ ARCHITECTURE
-M:	Michal Simek <michal.simek@xilinx.com>
+M:	Michal Simek <michal.simek@amd.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 W:	http://wiki.xilinx.com
@@ -23104,7 +23104,7 @@ F:	drivers/net/can/xilinx_can.c
 XILINX GPIO DRIVER
 M:	Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
 R:	Srinivas Neeli <srinivas.neeli@xilinx.com>
-R:	Michal Simek <michal.simek@xilinx.com>
+R:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
 F:	Documentation/devicetree/bindings/gpio/gpio-zynq.yaml
-- 
2.36.1

