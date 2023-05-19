Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69A5709019
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 09:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjESHAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 03:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESHAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 03:00:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE27E64;
        Fri, 19 May 2023 00:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqJzFxmTWdcSiqfMCmw/t48kWCG3BQCIpqiO8cZuJZg0bUpDz6cDqSREX5ouIut5BTsfKgAopNrLVsnqT5E9H/cdLyn00fyrPES1AHvihFEGdAyGPMqpJq8TOWXIdZKlZUA2okJufahQYVPvGK77mIsoJuewUhlubfQ3+B8cK/tm/4cOU5kgdSioOI1Tgfghj9K0/xOu5ANHPmrQX74FTJd+Ge8SKWv8V3B/haBiI7pDKDmpqoDnh8UyyQgr1Zy9bKtG8yi9OpVHdtW4D7l5g+PPH/6A18bJZBz5h3TLn6cnRCR20FycY7rf5+1cqcBJha6PTir/0pPVC6mxyRNVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btToigA3Nyz+U6Ya7P+Za1Bey3pUvEFusDBPy6ZHFe4=;
 b=cdrDAmvB14775dqrZ0mgryuz1B3/B2IpuOeHXFaB+v00AzFT5yOl89rQ+POVAV6HtTRSPzQBghZj8Pw81sjD+2GjU925PY4ZMsOICuhv8Vwh+Rc7mJUhbrsN4Kdr+elVqB8RO87n0kiKvAJMPY88XQeZ7tJSwfc7djTW2ecnjpV0coAsXYrXDLQ8WtMhEbyjTz2bZFr8RWIL1aP8E/x5mUyWwPLvMEZlsKoXGHenXYkceYIDhiba6+/Gaj50vkL4q/w1hdqeGgAsZ4ZDPpA+75IvNv90m/BTkV3C5Kf6D5MdGW2oRHp27Z6KgfO+H8AaB6Arh1onnD5rO00Xh4GQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btToigA3Nyz+U6Ya7P+Za1Bey3pUvEFusDBPy6ZHFe4=;
 b=SL84Ch/MeAlfZQMMFiQgxfbhS2yWNGuX4LUuw2l8dITUC54wyHlqxIpXTkLdU5CWjA57/uz59REVgp0/s8E0A9Dp53fuaThNWaFdcM3AQ1w+2mb3HtQ90mFTen3yzBbVI/051fSDB0G4ebnxgMioBNLgetf9OsTGhDtmtVwSE1Q=
Received: from MW4PR04CA0295.namprd04.prod.outlook.com (2603:10b6:303:89::30)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 07:00:15 +0000
Received: from CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::67) by MW4PR04CA0295.outlook.office365.com
 (2603:10b6:303:89::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 07:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT098.mail.protection.outlook.com (10.13.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 07:00:14 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 02:00:13 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 00:00:13 -0700
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 19 May 2023 02:00:09 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <balbi@kernel.org>, <michal.simek@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <siva.durga.prasad.paladugu@amd.com>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V3] dt-bindings: usb: dwc3: Add interrupt-names property support for wakeup interrupt
Date:   Fri, 19 May 2023 12:29:40 +0530
Message-ID: <20230519065940.2190786-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4d144a-bd18-4c6f-04a6-08db5836b259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbuONg+88SJjNSZBB9gwha6SRs+ENKcTj6lL3GyBbogF0eN8XLXFGPF1swl03a/0EZCIlnT96b1Pw6fsY4nTzz9wUJkpfdioZhnswn2A0yMkL6+MKuvn8Xpjf0x7X/phdEz0NKQXtokjoHb7SJKxiX3uEnL/rs3kOdGx3iY8VUsouyZuGXWv41kmK9XNPce/dh+dOwxmYO/Okb01X7CwkeWITLHt6eLYE7opVsMKz40WIMAVJ0/MClP+0W1UeLT0oD1dgh4hs4vkjnBTbjnrz8hbE/uJoYegre4dL0opJ6cfeJUZBDNKbzjo5GU8k/F6Nocv5VxvmmsPeKmF0jH2RkiWhlKH2YqRqxZUN3bVIvLdKhTeySHqtwcg/9UUY2UyCFapMxUB3JDVIn87dlne06U5BNhmw2ysGKhPXHjIczUCbpP7AhRRB/NrGdGDc5Tm/cRVDatnTcHikId88XR1KU9BF/aoWpQmdyBtMHwJpP6qDdrmBJCpiteZCayJydhmjD1vnVTO+AWtLVHSK9kYZemdmvnwtBmuYDzPOKaNx7ua4YBTqRSelUOCgePbnCk8CmqGN2Kmo/yhuq0uY3AzSPsuXd2rQu7sI1Ff/QX6OuCOcgfqjmiBY8VSvt0BVHfLW+5ZtCCbIb23Yj4OjYSopoigyGxzQ1gzC7DrgQo1Egr9uZmkAFQ6xO55pKKmK9iEA4dES17HA95WqvzaZ4RK0dBIeuZMRxUycAugjQJLQC6I+6Q0rwhUTK2rT9FedqlONpQt2Lfsa0FNj1p79BzTOg2JzaTQlMgBgzsussvAm3g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(966005)(40460700003)(82740400003)(70206006)(70586007)(54906003)(110136005)(2906002)(5660300002)(44832011)(86362001)(41300700001)(356005)(36756003)(4326008)(81166007)(316002)(82310400005)(8676002)(8936002)(40480700001)(6666004)(478600001)(336012)(426003)(36860700001)(83380400001)(2616005)(186003)(47076005)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 07:00:14.5307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4d144a-bd18-4c6f-04a6-08db5836b259
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
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

The hibernation feature enabled for Xilinx Versal NET SoC in DWC3 IP.
As the DWC3 IP supports the hibernation feature, to handle the wakeup
or hibernation interrupt, add host mode "wakeup" interrupt-names
optional property in the binding schema to capture remote-wakeup and
connect/ disconnect event in the hibernation state.

We have a dedicated IRQ line specifically for the hibernation feature.
When the "wakeup" IRQ line is triggered, it initiates a hibernation
interrupt, causing the system to wake up from the hibernation state.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
Change in V2:
-  Addressed ROB review comments
 - Updated name of interrupt-names property with "wakeup"
 - Move interrupt-names property from dwc3-xilinx core to dwc3 core.

Link: https://lore.kernel.org/all/CAL_JsqK6_7XD7+w+EQvPPmbmSOpfo3JDb0xDN4StuHUm1kgchw@mail.gmail.com/

Change in V3:
-  Addressed Krzysztof Kozlowski comments
 - Update binding schema enum.
 - Upadet commit message.

Link: https://lore.kernel.org/all/76dfbf27-8ad2-6e09-5354-b006b9e81af1@linaro.org/
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 50edc4da780e..771bd9ab71d9 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -53,6 +53,8 @@ properties:
       - const: dwc_usb3
       - items:
           enum: [host, peripheral, otg]
+      - items:
+          enum: [host, peripheral, otg, wakeup]
 
   clocks:
     description:
-- 
2.25.1

