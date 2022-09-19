Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129CE5BCA09
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiISKy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiISKx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:53:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C5765B4;
        Mon, 19 Sep 2022 03:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guwgKaJVVTcbD50WzUnbldSQkGO5Yy818SDy36aimAhyDdtCJo8H7ZTybTj6+N2e/lItziIF4izv5rqnnfOwBMQzoWtxXBdpyXfjC9kUtglAQSu+p/BZbmSjA/IfeHt0OHmTE8dj/+Wl/cJrXDdqPfiAaoQY9lYqouszg42rEfDpCg0Ze1naVLlep5ct3ROBrEzAdoELJ7Ni/FBvDj98SAKN9Il6mI+aSias1nUc9c3kGQ/8iTAYJbtvLVkR83GOYHXnsguh6bRvE01E3+60q+4RAxw6JDh4yWGJaSOcC6IyN1bR62FpKWdKjnZTEEMCh9dEaB8e+jIFavwLLxCV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBNf7qw7/qSqSE1d4Bn4MPM1QJonNz//cQe3VBAwn+I=;
 b=U2qB3/KsY8LkPCZz3j5lAwvWTB9G+rNEhqI3Opx/q32eeevjVEnYL2OsH1Gjqgm/otl5tKZmsF3gkF7gSWHxYd5T7ZPrGUQJ5XfeB//jvHmDt6nJQjnJznNSRcRVbDTCKxmq2krG3Ftt/10QRE3maqRmMo0OLxU1rfFAkvINelSQANiGqwSramB2oNXT/UHumOxmF+iF2+pwgrseMB3Eyp3YuY5UKq/qP1sDPIvlXhy8FEws0vS1bG9QZ1xESowVtr/5d03Kk5c9kIv2WbQNf9WhsSwEQxK4IeNjVX8oOQOdHRzlnlJUBjN5Hoamjk56vzwl4bUmrhFisQa0Fdf3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBNf7qw7/qSqSE1d4Bn4MPM1QJonNz//cQe3VBAwn+I=;
 b=jwzemyXKFTlwLrkmkVbvgu9b/hBmPbGoe2JgQey2zw6cKefR6BvLxzYsk6fwfcWQUlcAMSYjxlTYVQvC+trypq4aQxkwwr1VDuX04t94VcuCA1tewycHWGqiAlBzF1TUL0twvU6z/Btf6tbfV95zQ5TFJzdhGesSoh4o+x0eydc=
Received: from MW4PR03CA0061.namprd03.prod.outlook.com (2603:10b6:303:b6::6)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 10:49:10 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::57) by MW4PR03CA0061.outlook.office365.com
 (2603:10b6:303:b6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 10:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 10:49:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 05:49:06 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 19 Sep 2022 05:49:03 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <balbi@kernel.org>,
        <linux-usb@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <michal.simek@amd.com>,
        <siva.durga.prasad.paladugu@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V2 1/2] dt-bindings: usb: snps,dwc3: Add 'snps,resume-hs-terminations' quirk
Date:   Mon, 19 Sep 2022 16:18:15 +0530
Message-ID: <20220919104816.4075019-2-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919104816.4075019-1-piyush.mehta@amd.com>
References: <20220919104816.4075019-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|PH0PR12MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec9a768-a5df-4e9f-ad48-08da9a2c952a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qusQVYleykpKbMKdP46r6BudXWuY9QB03gt2hdReDnSoksZIp7AcjZlaf04qzjXbogpVkwuXCo6b6m5N6lcHTRpqPnwIlZ8MML9eH1xjPjAXSxz92XIzmKMcEpEBFHSBdVjgvnr4K8m4OCLeA51CIqxv0308JixO0AhnT9IbBzLRsC12franI/dC3pT8mYoHewmZOmjmRL6RhwP5UUffHbNha+14SQL/xlfGitLejzi2NFFvcSCwhFsl/aZbv3j1Dd9E+RVifoqMw+6E1VPfBFKkbFuGq8M1Lnz0NODhoF78qyUkUCV6GrIlTQ9Rc/3jJwZ63sxxBXXwZhoyU2DDvuzoINk+uUqSOHQvtd8gZACMVfLD+1MNb82X+GHSU1xtvQYhPswkd3FTCXHefgjO0hQfWjeRaKMi491d95xoLHlzP6mYrIO4D1iNTbes09uPTWAFaiLD9Xdq3dokTNH7roSn8TAj8PFDVIVzEL4CuZCTo04AKAgRE9ZUeqB2jClac2JR1pate7l6OXCWQ9gKSZ9Mz9DskBO97UvHH3uiAkct8YAEdCkntdV6KKGN59D4QB7o1vN+zVKa/1FWEFiI/WLsTiLprPk1E/40eUAUm3HnDZKA2JEpHX1SXQ650ZjUuSdlVS0/7ndCVpe52aGMV1AAscFV9MuO22xG/4Ofbmr3eGJxgucP75QLUq50hDaG5WJOCeImogwrkkk6VqPvLhCbTsDfPBWP09zvM3UKBSPuagzwslTmHEfFlxklZ3QeeJ48N11oKGTr9rv9qGoYPe1X2I8v7FYG4j5keMn8XltP5xgfBaZkWHqJopeXHRMEXU+b8JCz3xbaI3wFP7qpEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(2616005)(44832011)(966005)(41300700001)(356005)(36860700001)(6666004)(82310400005)(40480700001)(8676002)(4326008)(70586007)(83380400001)(70206006)(110136005)(54906003)(336012)(40460700003)(316002)(1076003)(426003)(36756003)(5660300002)(86362001)(47076005)(186003)(478600001)(8936002)(26005)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 10:49:09.6312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec9a768-a5df-4e9f-ad48-08da9a2c952a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piyush Mehta <piyush.mehta@xilinx.com>

Add a new 'snps,resume-hs-terminations' DT quirk to dwc3 core to resolved
issue of CRC failed error.

On the resume path, U3/U2 exit controller fails to send proper CRC checksum
in CRC5 field. As result Transaction Error is generated. Enabling bit 10 of
GUCTL1 will correct this problem.

When this bit is set to '1', the UTMI/ULPI opmode will be changed to
"normal" along with HS terminations and term/xcvr select signals after EOR.
This option is to support certain legacy UTMI/ULPI PHYs.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
Changes in V2:
- Addressed Krzysztof Kozlowski review comments
 - Update the quirk name and No underscores in properties.
 - Modified the quirk description. 
Link: https://lore.kernel.org/all/e15168ac-b5a1-0c15-cfb3-34fb518e737f@linaro.org/
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 1779d08ba1c0..534f5b42e056 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -234,6 +234,13 @@ properties:
       avoid -EPROTO errors with usbhid on some devices (Hikey 970).
     type: boolean
 
+  snps,resume-hs-terminations:
+    description:
+      Fix the issue of HS terminations CRC error on resume by enabling this
+      quirk. When set, all the termsel, xcvrsel, opmode becomes 0 during end
+      of resume. This option is to support certain legacy ULPI PHYs.
+    type: boolean
+
   snps,is-utmi-l1-suspend:
     description:
       True when DWC3 asserts output signal utmi_l1_suspend_n, false when
-- 
2.25.1

