Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C18E74347B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjF3Fl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjF3FlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:41:16 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1753AAC;
        Thu, 29 Jun 2023 22:40:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aX0nypdn0UXyLuFfpc1Q2u0acBIpdJVlr4CTq3OjiPXYOo+l02QRJM4pOK/obYGTsvR9oV40fT6/xyBml9/lO4W9IawXCcqCcEpNpF3fYy6C3LFLFtsk7+G+XEGL153o/bt95wkTaPa5VQ1Pj+Uq1yt9bd9+KCPUAr4a8194Lzd0b9EYeEOdpW5gCqnNMbtwVaI9+dzYEaYo6BlJFj0WxRvFKBgIjWIvucewimfzTiVKnSBRQjKBdbARSj8+oyPdgB0vNOf0VfMK/r2FK/Lu1AQE2hBMf0LP+dFZw2p4Z9xUo4n4MjdXvtqD/R+PECz9+otUgaBvoakOI5GADAxplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/nzAasz3m5gqnTR10emgKTOqVc4xNwxix9ew2EjSoQ=;
 b=hs8jNJZeugbixWduEcEyBBI7Pm36Xh69xjRdKkGdDp96gMR7TuXE9SumKs3fnNT+bRyTXd/bNR65l2uVc4G0O5Nv/nA7UYeVJiAGalUskinPupMQn/2+IT4/r1xroB4qSJNfvSQwzycD6ffH36DJcsFFrk8hjwF9wTNTGKpr1yUOw6cJ6pWb7EGsgJRollXsYrgCC6OzLWwgZddpdmBMHrUneZcrJTNQpRGrtOn/HxrSUsLjv2Gq1tcT1cjnMe9u+4KErqXH7R2DZYqsGbyJnEUIotyWZUCpf46rdDb1WDgSkQ2S8JwM89/nIiX1xQip8OUYsZ11KgXV6+ih/POX7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/nzAasz3m5gqnTR10emgKTOqVc4xNwxix9ew2EjSoQ=;
 b=OpqU153MtY7QJV9Q3KsjMpedYZyQ8xEjRK+GJkf6GnxrXfgnBe+D24++A3fbC5M1tuymnYe3lUVM4xeCT6jshC2cwqiGlQ3i20SlJlj0r+hvOvGudqtxLWsCg/YwXBnoD2DCQ0PAUjjoAqAKN8l6Dh5lvUigUC27wbQalpnbyc8=
Received: from DM6PR05CA0037.namprd05.prod.outlook.com (2603:10b6:5:335::6) by
 BN9PR12MB5227.namprd12.prod.outlook.com (2603:10b6:408:100::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Fri, 30 Jun 2023 05:39:13 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::b4) by DM6PR05CA0037.outlook.office365.com
 (2603:10b6:5:335::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.8 via Frontend
 Transport; Fri, 30 Jun 2023 05:39:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 05:39:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 00:38:54 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 30 Jun 2023 00:38:50 -0500
From:   Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <sbhatta@marvell.com>, <linux@armlinux.org.uk>,
        <michal.simek@amd.com>, <radhey.shyam.pandey@amd.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>, <sarath.babu.naidu.gaddam@amd.com>,
        <git@amd.com>
Subject: [PATCH net-next V4 1/3] dt-bindings: net: xlnx,axi-ethernet: Introduce DMA support
Date:   Fri, 30 Jun 2023 11:08:42 +0530
Message-ID: <20230630053844.1366171-2-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630053844.1366171-1-sarath.babu.naidu.gaddam@amd.com>
References: <20230630053844.1366171-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|BN9PR12MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bed9fa-1f78-44fa-f8f6-08db792c55ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hA3WI+vHy7sKsMz8kt/fCmw4Yysll1iJaKwMWxaQIclboqYrir3ZSktNp40qZmXlW0r43DxwNzdE5Lg3A6AaY/iclJRivkIxFnzC/H4du7uz0KK1Dy2Ntkx89rEHUxKLnYQVgadWgaASCtweilHyb1ZRK3nWfEF9l0okFw6J9jyi92knO61eZHW95fKt7dogz43UsQYyom23zXmYVnqmNVSm70zcAXf4JLgBfwPpQVl0xE78U8Kr8BvQlQ/wWpRn38+H2+eTlC+0d48hQt3Z7pbq1SfYYFTHN9m+f5/tj9ZmbQVTevqHe6aSOJDA1VawYuxaLgPf7WZmmiqAQDXTtwO3PxiHuZTGtNH0NCpQ7gPOpmKjshNaU2D2Rd2O14e+3J4qzdGwpCQurnp1koc2eURMQhdPsmPMMW6OLL9sn5S8HRU7lmXo0fxvHzsP3gvqiHqrb9ePaM1mgbvJX62qHgv1ep65nRzSyMP5GRqFBMgH5sebm+VPgTyOi6oPvwXKw8hjQ9FUqhbDDTCqKbIdmoaq14GYkDgCvFXX/cArRGQNLnCh6MhFy0WrEblrgwv7Kn1IOJzz73wyuJVoZRvWe4sBtYJroupBFEzdJddAsXiKz8BJ5CIrjUp7eKXeuw5YbaUeT0cBTkAoz2nqBqEpdEISvj/lJsfQ8K4z5Mdh+NGi8qL/ad5QlNkWYnXhEBfXuIigqBBk9CI5iJNjJmLoCXoJWSvLipw881G07VPRF/dYq7fNnuStAXlnqGT84zzvx+rvznDmLK6Rd5Khj2Czow==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(8676002)(316002)(70206006)(186003)(4326008)(26005)(1076003)(336012)(8936002)(110136005)(54906003)(40460700003)(6666004)(41300700001)(70586007)(82310400005)(5660300002)(7416002)(2906002)(40480700001)(478600001)(2616005)(81166007)(356005)(82740400003)(103116003)(86362001)(83380400001)(36860700001)(36756003)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 05:39:13.0636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bed9fa-1f78-44fa-f8f6-08db792c55ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5227
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

The axiethernet will use dmaengine framework to communicate
with dma controller IP instead of built-in dma programming sequence.

To request dma transmit and receive channels the axiethernet uses
generic dmas, dma-names properties.

Axiethernet may use AXI DMA or MCDMA. DMA has only two channels
where as MCDMA has 16 Tx, 16 Rx channels. To uniquely identify each
channel, we are using 'chan' suffix. Depending on the usecase AXI
ethernet driver can request any combination of multichannel DMA
channels.

Example:
dma-names = tx_chan0, rx_chan0, tx_chan1, rx_chan1;

Also to support the backward compatibility, use "dmas" property to
identify as it should use dmaengine framework or legacy
driver(built-in dma programming).

At this point it is recommended to use dmaengine framework but it's
optional. Once the solution is stable will make dmas as
required properties.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>

---
Changes in V4:
1) Updated commit description about tx/rx channels name.
2) Removed "dt-bindings" and "dmaengine" strings in subject.
3) Extended dmas and dma-names to support MCDMA channel names.
1) Remove "driver" from commit message.
2) Use pattern/regex for dma-names property.

Changes in V3:
1) Reverted reg and interrupts property to  support backward compatibility.
2) Moved dmas and dma-names properties from Required properties.

Changes in V2:
- None.
---
 .../bindings/net/xlnx,axi-ethernet.yaml          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
index 1d33d80af11c..ea203504b8d4 100644
--- a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
+++ b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
@@ -122,6 +122,20 @@ properties:
       and "phy-handle" should point to an external PHY if exists.
     maxItems: 1
 
+  dmas:
+    minItems: 2
+    maxItems: 32
+    description: DMA Channel phandle and DMA request line number
+
+  dma-names:
+    items:
+      pattern: "^[tr]x_chan[0-9]|1[0-5]$"
+    description:
+      Should be "tx_chan0", "tx_chan1" ... "tx_chan15" for DMA Tx channel
+      Should be "rx_chan0", "rx_chan1" ... "rx_chan15" for DMA Rx channel
+    minItems: 2
+    maxItems: 32
+
 required:
   - compatible
   - interrupts
@@ -143,6 +157,8 @@ examples:
         clocks = <&axi_clk>, <&axi_clk>, <&pl_enet_ref_clk>, <&mgt_clk>;
         phy-mode = "mii";
         reg = <0x40c00000 0x40000>,<0x50c00000 0x40000>;
+        dmas = <&xilinx_dma 0>, <&xilinx_dma 1>;
+        dma-names = "tx_chan0", "rx_chan0";
         xlnx,rxcsum = <0x2>;
         xlnx,rxmem = <0x800>;
         xlnx,txcsum = <0x2>;
-- 
2.25.1

