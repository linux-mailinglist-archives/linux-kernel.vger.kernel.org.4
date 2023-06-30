Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D43743D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjF3OWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjF3OWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:22:52 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DC93582;
        Fri, 30 Jun 2023 07:22:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWN+FLnEPOj5WPChJuG0FFfBy4nt8XO4aNwZE7QBvEEKs0qPD/YRWsKs3bzSAT6NMzb/dcYWhWB13/9johzNIrE4jnLFb/+Axudd5DFiah7DHER0VVtFumT0/2D4Ib5FrannpbM1AHezjoIUIg29/kuC3is+Gqc95DCt3U/BBsrzTZXXwOxttG3WUzYK2sw0wM3NqyLJZTOzw66+xjlm390mLumQvH7zw4uiMpv9NxX2xUTVpOFnRcH7XjhgQvxlhC3foE6WM6+3NkqROHtWJrwgIolCj0tqGyjHra9XzxzVij84j72ULqUYdHQByU8VpV1s15VC+AYN/FDQksq+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrJFtw4rh88Ab9JN5EtsjrEHKZR3L7R8/u+JfWzqBkw=;
 b=IqQA7v2JLGgHr3YtIaCmRWmbaRaWk+gUb1Ikfg48qrV4m3NP6ZixBoxLhUvzcwjSMI1e+V6J9hndxHyWNQ4lXVKSsDRil/clMSZS16osz8WpgF13KbHt0O0S7rvX2By7JAwzWJY55P5IIrogiYYThdos22immqVGD3t9pS2OPWeIJLZDF6Srd2utcVJyrZ9HMtq9KFEzi7NbzgKZzvrgb9IvsOx3mRSR+tBkrhxLec0QLqRP0u7ug0Mf9HpqM19/1bzScFLxoxCx8Hby64zwsjWcoGo+/mZIGe/RdofdwUxmDb0X22DpU5jyX7nkwfYUhOxVtkajIOyv6kQ5sVC11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrJFtw4rh88Ab9JN5EtsjrEHKZR3L7R8/u+JfWzqBkw=;
 b=k0VEBGa7jU3L2HzvbaOu7mcd8r2Vha/43lbx5BnnwPhgdxrQoW3in2fk8NgSxeRs1D9awWI1NzUe3A5V6+vI4ZpSC//4meM/yOdol88tv2Gfr9U6vuLHimSCjHljho0t8sMJNY3UV4t7B+xvYRf1DQ77KnbKqgJiBKnCQPbh2xs=
Received: from DM6PR06CA0033.namprd06.prod.outlook.com (2603:10b6:5:120::46)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 14:22:46 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::94) by DM6PR06CA0033.outlook.office365.com
 (2603:10b6:5:120::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 14:22:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.43 via Frontend Transport; Fri, 30 Jun 2023 14:22:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 09:22:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 09:22:44 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Fri, 30 Jun 2023 09:22:40 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <git@amd.com>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v4 1/2] dt-bindings: mtd: jedec, spi-nor: Add DT property to avoid setting SRWD bit in status register
Date:   Fri, 30 Jun 2023 19:52:32 +0530
Message-ID: <20230630142233.63585-2-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230630142233.63585-1-amit.kumar-mahapatra@amd.com>
References: <20230630142233.63585-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b957189-6f40-4c9b-c363-08db797579b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blesDxf0birZDaj6mKuX++Tny7/Qs6DGjoXmTZfFEbCQ+O1diHsbyyY757sFAJXX2OEkSJKlnhXyGw6hUJAq3setclvIs337FWtUKtxLWhuyywsALSBt1OhXoxSIMr6OD6gv6juNtsnkzJQptlcAtXgKPHCiwio3GhjVFc0kPBGNrLDh3mXgATKWnizJAiORRr5S3HXWNqgMKLKaYeN8lgBFGLiQlIv2d05D+faA+4g725d9yr9IEG8XOZIY1lThuCerdxEtLGgT7pIjqcrpbO64tUNl5DE8Xy6DIp6aCe25P+G1t6rQmodHj+Zz6ZUpqZ9Yu+ylEy2jnmO+WsnOBSzekZpoUd+6ZBW7DFYzEysi0dahzOhBvKmwJxToGN7Qsk0X2vmlIZDieperaWQMLllP1U/vnAmiObEabdCdayJno3qKMpUWJK/eIS86ofEyFKGFmVeX1ftC+8QX4cGu5rGkbfUILvxPYHVTK+VRpZXcXF/8B9kZ2wAkhr2BJp00HXXhmxUH5CmOH7oOcq2zJ8CsX52y7ODEnvCJM2oEXv3GDyyNFVvADW9TEROABfYNf/XZRvzeinj+UZ7eum/yYy8qYnO8kUWSc2sCj0vXDNmYS3Xw3IgfU4YHvOyTnBlm49TGIBEaQnzcrDkTeHr6C5ZMujZK3Ar4NyFek7Elpj0m0ZbvKKsBmuSb/4PCR11GxQk1kGKQ5hdAdHEaTTukl5WyPIDE/mbURWuRj8/87cRtU/sJoi1h9D924tmSeFm4U2DoAi4dU/NSOG87DFatIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(86362001)(54906003)(8936002)(8676002)(5660300002)(82310400005)(110136005)(7416002)(26005)(1076003)(478600001)(4326008)(70206006)(70586007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(47076005)(40460700003)(336012)(426003)(36860700001)(40480700001)(36756003)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 14:22:46.2234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b957189-6f40-4c9b-c363-08db797579b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969
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

If the WP# signal of the flash device is either not connected or is wrongly
tied to GND (that includes internal pull-downs), and the software sets the
status register write disable (SRWD) bit in the status register then the
status register permanently becomes read-only. To avoid this added a new
boolean DT property "no-wp". If this property is set in the DT then the
software avoids setting the SRWD during status register write operation.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Michael Walle <michael@walle.cc>
---
 .../devicetree/bindings/mtd/jedec,spi-nor.yaml    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 89959e5c47ba..97344969b02d 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -70,6 +70,21 @@ properties:
       be used on such systems, to denote the absence of a reliable reset
       mechanism.
 
+  no-wp:
+    type: boolean
+    description:
+      The status register write disable (SRWD) bit in status register, combined
+      with the WP# signal, provides hardware data protection for the device. When
+      the SRWD bit is set to 1, and the WP# signal is either driven LOW or hard
+      strapped to LOW, the status register nonvolatile bits become read-only and
+      the WRITE STATUS REGISTER operation will not execute. The only way to exit
+      this hardware-protected mode is to drive WP# HIGH. If the WP# signal of the
+      flash device is not connected or is wrongly tied to GND (that includes internal
+      pull-downs) then status register permanently becomes read-only as the SRWD bit
+      cannot be reset. This boolean flag can be used on such systems to avoid setting
+      the SRWD bit while writing the status register. WP# signal hard strapped to GND
+      can be a valid use case.
+
   reset-gpios:
     description:
       A GPIO line connected to the RESET (active low) signal of the device.
-- 
2.17.1

