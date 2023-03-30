Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66FC6CFBFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjC3GxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjC3GxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:53:16 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F20123;
        Wed, 29 Mar 2023 23:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zr1FgGUzG251TjgeIIY8kiyPF+PM2M5JkVYWKBHyZ4aoEictwDrRWDMtEJSortMfjHyvJZYiEsstTGmad0sFC6xXm8PqhPsv5ATm0WUeoN4TFaThgcMuiSJeXtD8P53Guqm6HRpzX4hn1kdcuzPMZRaBL36tPozn+yxLP3amjT6ZalN/t3spO+00s1z1ycYC23JWbBqnJ0pdGTJTw9sf/kKtoX/eWaN4nd9wTpWP8uWZKC3UahiWTdNPAzqkJQ081qY/sUAy09GCe654dHL7d+/SOBcpOZP5c1XHhoYxBfcN4lhd/LBzcPIW7GoBRv6IgbXdpNOb8bnMv9Sr/QwvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUBrrwBShNPW3KISla3XxgQXW3xGgogKfqJolTDAvcE=;
 b=nNp3QmeGjNPceBxpFDGpvV7IgL/aC954nbj6s33nVt1v+jGf15Sa4b0GWXPMuPwfNuOktg8YTZeVodhUm/5SclOQ0NWCZ4n1bq8/e9ocZEJM1OTOxFM1cu64WMxM8RZiATC4NwEvY1LghkcCUA3a3zXpOmMGbQ28ZSqlp0XHF9hmS1Lwd03xwttJyYFX99wEyVeQMyEIZ9peDvawUHFBwGLpaVddGeD18zraFCmFzZmr5ymDn+3/1zuFuk/XNqCL+U3sS1SDp/w5642JKdoT+kyvNXWcdb0iI3y4zk3VqFCmdipHuGlDacf2GzQ2LqCRP0xOGyzn32FXTrMnp3BWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUBrrwBShNPW3KISla3XxgQXW3xGgogKfqJolTDAvcE=;
 b=ItAJaX7UtRWSo24l3nV0gBMDaohLD29OSpv4EiLsv974LgJvAbAarIiiSgblFmqH45BEtzJ/k/6ZvEQPoVMQ2mxkKWHhXowLAaMT1acgpXr8OUPjx/88TMhyAJQaWaM28b2kFCBSoI+OEBOcFesCmT4vknN8A3H33GhApBmWDC4=
Received: from BN9P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::10)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.31; Thu, 30 Mar
 2023 06:53:12 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::e8) by BN9P222CA0005.outlook.office365.com
 (2603:10b6:408:10c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 06:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Thu, 30 Mar 2023 06:53:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 01:53:11 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 30 Mar 2023 01:53:08 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <saikrishna12468@gmail.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH v2 0/2] mmc: sdhci-of-arasan: Add eMMC5.1 support for Xilinx Versal Net
Date:   Thu, 30 Mar 2023 12:22:38 +0530
Message-ID: <20230330065240.3532010-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 81cf9b11-1094-445c-f8e4-08db30eb6db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7PjuRXMkgztWNrqKxXCFSoTIB6w5RUGoRmexEWQN2+LsMioiwVPOdzcthyzyDeFjmutWV8wHTRHajgGC022hv9ueblZzHGJlm8ZNAFXPp2vZrX83saL9ZipJWfbDvt/SX4ca21mw6tNsKawd/QaodN4UO1rvp0N+nat4cOwL3yY2oNWtgtVTdpGSpEjeDp1k/dldcExa5U9rlXN+zK+p8uL2emtwPdVdBDC7PbT4M6Twtov3CVvFWrta37c36vrMmpmIuaewrNbNUhMVgeP+K3DyMt7+Kokj+bJ3jjX/39HJLLD004CV7DT0+KViNYSqU15DJPPO1Y2Cuh9s/fxnbk/DzI8unSPuWWrxm4sTNPhHwg2llPaBHw0/yunI5aF5tT2fAItm0dJ9ccH5JBRr1l079fIFUrM4MuXkdTuJ/reg7UfXIrRpnSD+jPNmwITCGOgrOWGA42/zVc92fRfposOo4peI43jaWkpmctuP52+d1OY8sIkHDYvHJrqni9IxRqm3ogJ/XZNYSFEugRwq32hwZQyAt0cdan6gvAL11gihHdAUDjYC5Lwgsm63pzmMlk+tffwVJT6ZzKf9ezv3jvyxjoi26jP5Nc0lce3/CI7n9n6AXH0bQ7CC2YrUJq3wp80lpQxwFsejvpjtsFRnBhlNELF55pH9VICOL0dGgFOtnTZp9v9RqT6LrwCAc/pal9VqeHZpcIPPtSw74DCpu1UyYUXnSsupGIGyuLBNUa2xsVbQLNla+MtZpD1/zeIo5BsctrJRqODJ549KdPWKLC0ofVacaQmTMx9ytodbPo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(86362001)(36756003)(82310400005)(103116003)(478600001)(40480700001)(40460700003)(54906003)(82740400003)(110136005)(70206006)(70586007)(36860700001)(4326008)(8676002)(41300700001)(6666004)(26005)(336012)(1076003)(186003)(47076005)(2616005)(426003)(83380400001)(316002)(8936002)(356005)(2906002)(81166007)(5660300002)(4744005)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 06:53:11.8547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81cf9b11-1094-445c-f8e4-08db30eb6db3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
X-Spam-Status: No, score=1.3 required=5.0 tests=AC_FROM_MANY_DOTS,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add eMMC5.1 support for Xilinx Versal Net platform which has PHY within
the Host Controller space.
Also, add Xilinx Versal Net compatible for eMMC5.1 in DT binding.

changes in v2:
-> 1/2 - Removed v5.1 from compatible string as suggested by Krzysztof.

Sai Krishna Potthuri (1):
  dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net compatible

Swati Agarwal (1):
  mmc: sdhci-of-arasan: Add support for eMMC5.1 on Xilinx Versal Net
    platform

 .../devicetree/bindings/mmc/arasan,sdhci.yaml |   5 +
 drivers/mmc/host/sdhci-of-arasan.c            | 237 +++++++++++++++++-
 2 files changed, 241 insertions(+), 1 deletion(-)

-- 
2.25.1

