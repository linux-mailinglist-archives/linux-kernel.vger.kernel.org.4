Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84D6F450A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjEBNgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjEBNgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:36:00 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9385B85;
        Tue,  2 May 2023 06:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vo7ew1gZSzf66wfGwAkijtwDxW7QGfkeOHUwifpbf4D+SGzaPsKFVWWeT1nqHDy5wcu/GyeXkNXdtCtmR8ftqR08u/osWwbN/yKhOZpLJn1rJuRLMd752sfdpdbCQSOmHQMpL7yFw4HndZ54Actu8EmhGBkMEZ8+GS0wIecI+YSyyUyRejZmTSL4NVSVTrrDV7X0WIcgc/T2hP7qa4rmH7j30SEhz6paqO6TaGw8aGcRYiOYTlNiN0MzZ2GdvAuTHUQziXgnOObpVNQLJ2QCrCqD60oH3UTSjxo5lz9FBtOsKCDoPyTLli3bncJJvdRnKBT8G0XD7pST/YK1V6nu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gAu2754sL0n6XStq37WO6X4+pyRpzOGFM95E1zP0/0=;
 b=jE2qzaHQTtQDFyhXygJ/ym2mMPSe5XmtMMR9WLzjLPUdwhdT2rdLfaAy/1moB6QN0vfxEnv97Q/IJMnDkVPb2dkRYKf3FV2lCMX07s1JpFNSWRTT/vNSeUbY4uIz+rZiHRO1t7o6SgS4oMRtIaXoBbxm9IiRRE0GtzU4vhGV2tMK2o45+dGVJn8AmS7mJ5t8i24Au7iYrGc6q1mCrcll4alb1jk/PL4dpJobUa8mFXwy/ocb+qG20b6zyu7zJlPe2pyF7XWSM6emS8GSXVSXg8EOM9lHip148s1tLT1XSnnl+3OkXu+Hr4+PEJfxl54s1fqfjAEwfe+CuimRsZezvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gAu2754sL0n6XStq37WO6X4+pyRpzOGFM95E1zP0/0=;
 b=35rjDTYfcChaTrbVSMm90mMXgmusxpt2wv3biFqux7pqt6gfX5yk6NpOnnR82u15AvFmr4SRs8rhJks5QSL/c3U+fHej/eBlY13Pf3clSKdA9xpefOEw2L3ScEX365KPX4DhzztMbH0ExxHvOJaYu+PQxJolQ0lwzS3tCbbgnhk=
Received: from DS7PR03CA0333.namprd03.prod.outlook.com (2603:10b6:8:55::15) by
 IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 13:35:56 +0000
Received: from DS1PEPF0000E637.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::5) by DS7PR03CA0333.outlook.office365.com
 (2603:10b6:8:55::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Tue, 2 May 2023 13:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E637.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 13:35:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:35:54 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 00/23] arm64: zynqmp: Misc zynqmp changes
Date:   Tue, 2 May 2023 15:35:28 +0200
Message-ID: <cover.1683034376.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E637:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb4b0f9-40a7-4549-7781-08db4b12282d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAHGkiOa9u4aVE5YBSW4u9ipiqtU/O6fLPKWGJhn1EDkRI8SRquxgd6ZD0P/s3mP42YyExkFx3MLQQ4QxGNsev3zxrg7ODxOuDiI4YhVrEleTDmGycNlWSC+FzEAXGEwpc9XsC2FMab6KHBli5I04E6HE6OwfjnO4XiyLBm30nwXXz19pPHd8q59zqAekCxC2DdeQ25xMN5QF3+/25AQXNBLcYueKmzTA1f7PrHNSnuYVKOKJsWHGf1iySsJirOWYdUOzOFSW4myBs5GVOGGaHh07CUJd5/kT9yRDvn+FFMNHVyA1Y6THJHzPTRzII7GUYAbz9N1rsUfhrfRLHaGJEACyEjAcWCfbfNC69+8z1YfwXWskmNtmQRb2CbqldUWKD0KgT0GO2sSYHK8HeU3TdAfo9H/7r5e7DSAerHIYp+6AcONUHUOLn6iblUINKG71qMsRdOWxEJpCX5DW37J6hIEn1j/IFmVhFhLVVXr+vqWL3DZu6pecA32jaNDt7SYuc1sjvylqDWncfmhrLB3KoY5YEjopnQgNfgMj1ONLWfBiuVzlk9YbnWISpivGOGxyHyOALXVq6oJuTB6p9aDhRFtiVu6tVi8l0LZnL0Qt1exvvxIqY9hlSisL1yRUoo3fupe9WE9/Dg0j4p6EyIqS9dY9UOgcXMtVeRIelUX3gFh8FuuNRjmjFalyLcnBgj7P81vS81ZhVBfCuCLTWbSkRWQUX79JbMLJ7kmAXZwWYgsV9Aela5MCToxb38X223C
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(110136005)(336012)(426003)(26005)(54906003)(2616005)(2906002)(47076005)(36860700001)(83380400001)(44832011)(186003)(16526019)(7416002)(81166007)(82740400003)(70206006)(70586007)(356005)(40460700003)(5660300002)(966005)(8676002)(8936002)(41300700001)(40480700001)(36756003)(86362001)(316002)(82310400005)(6666004)(478600001)(4326008)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:35:55.7838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb4b0f9-40a7-4549-7781-08db4b12282d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E637.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the series is syncing the latest dt changes based on board status and the
latest DT schema.
The patches are based on
https://lore.kernel.org/all/20230321070619.29440-1-parth.gajjar@amd.com/

Thanks,
Michal


Amit Kumar Mahapatra (2):
  arm64: zynqmp: Set qspi tx-buswidth to 4
  arm64: zynqmp: Add mtd partition for secure OS storage area

Ashok Reddy Soma (1):
  arm64: zynqmp: Fix usb node drive strength and slew rate

Michal Simek (15):
  arm64: zynqmp: Describe TI phy as ethernet-phy-id
  arm64: zynqmp: Fix usb reset over bootmode pins on zcu100
  arm64: zynqmp: Sync node name address with reg (mailbox)
  arm64: zynqmp: Add dmas, dp, rtc, watchdogs and opp nodes for SOM
  arm64: zynqmp: Use assigned-clock-rates for setting up SD clock in SOM
  arm64: zynqmp: Used fixed-partitions for QSPI in k26
  arm64: zynqmp: Add gpio labels for modepin gpio
  arm64: zynqmp: Add pinctrl emmc description to SM-K26
  arm64: zynqmp: Switch to ethernet-phy-id in kv260
  arm64: zynqmp: Setup clock for DP and DPDMA
  arm64: zynqmp: Enable DP driver for SOMs
  arm64: zynqmp: Rename ams_ps/pl node names
  arm64: zynqmp: Enable AMS on SOM and other zcu10x boards
  arm64: zynqmp: Describe bus-width for SD card on KV260
  arm64: zynqmp: Add phase tags marking

Piyush Mehta (1):
  arm64: zynqmp: Disable USB3.0 for zc1751-xm016-dc2

Radhey Shyam Pandey (2):
  arm64: zynqmp: Add L2 cache nodes
  arm64: zynqmp: Add pmu interrupt-affinity

Sai Krishna Potthuri (1):
  arm64: zynqmp: Add resets property to sdhci nodes

Srinivas Neeli (1):
  arm64: zynqmp: Add linux,code for gpio button

 .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  15 +-
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso |  20 +-
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso |  20 +-
 .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 321 +++++++++++++-----
 .../boot/dts/xilinx/zynqmp-zc1232-revA.dts    |   2 +-
 .../boot/dts/xilinx/zynqmp-zc1254-revA.dts    |   2 +-
 .../boot/dts/xilinx/zynqmp-zc1275-revA.dts    |   2 +-
 .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  10 +-
 .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |  10 +-
 .../dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |   2 +-
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |  32 +-
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |  42 ++-
 .../boot/dts/xilinx/zynqmp-zcu102-revB.dts    |  25 +-
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |  42 ++-
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    |  42 ++-
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    |  29 +-
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    |  29 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  33 +-
 18 files changed, 513 insertions(+), 165 deletions(-)

-- 
2.36.1

