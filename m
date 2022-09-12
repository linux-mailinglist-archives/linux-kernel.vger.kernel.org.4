Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3484A5B56DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiILI6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiILI6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:58:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2467E357EE;
        Mon, 12 Sep 2022 01:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9W+V6nXpsFQ5XGQ9zC2ONQUtZ8is2HOtwAFcCDENyI9wuYHpU2GB85zrVb2R7e8lEyavIdr4eAgfscC8YE473IbLLC+mc4NO2sIskwQgjXeYw1sWpZlkRhs/jj4Wp7rDucAMSq3JGOJ5Ckx3bSH/RHQy3dmvn4UnYDmY0GyxN3NeFLBGc5+rj07LmBgr1dXEpNITZMmXIiLLJNvPj0rUEPYxkKcrOahahxosD85J/jfqnLmI2D1cPxyMqqKZns0DQJCaxu6ox6UhcFC/pjlF8zmaYRkNsSUHGhtn+4kqKT2X5qKmUw3nud5/VjvStZmyTEiTpsfaj2+q+K3hNPpKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyCbu/l72mwyRYeYSWRWBXIVyx4LADLne7kqFNeqjwY=;
 b=NRtFTLpKTjFtYkeVVVN2Sh9YjfB7eVH6r9vwNFa2S3E5azvaMJ25g8g8E+enlFqBqhMdSu2CyPH2ID7FnF9qtI1MeGaupnqzLq/YL5NV4Ftk+OYzkHnmqSTNMMbzKGPyLhDyv2SngZhmRnwoj401uiPKAtDYOszicPxaqZaWiGc1AH37SJhh4XDQ2jpyBGYHLTjTqX00raFessQXebNTem6ezGVLshtYSOxsSATOPg4GDotPb2bDsLdy6yqmj+7VOr0uAfHSPt3QfAOvyhxTmGiE8m61X4jbXKImDxAQfR/9S3PgEUnsEwJFMpAMxn8gyiRUte3ANptGC4LmY0o5cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyCbu/l72mwyRYeYSWRWBXIVyx4LADLne7kqFNeqjwY=;
 b=Nau1eb5OR3onmhzDJDutJ0dw7B65N8eCLWYV55Q7/49IJREFwZWoO/7W7JGvpfzqzoPkisMKngBi4zuqsiEciI1SCcIo6Xj5/MlxOmt+197C9AcSlUcQg4BzRIyKwNweIS/5xHZcSjdc5RoOYNiF4wRMBAweMH2QOLYmi/lIGIc=
Received: from DS7PR03CA0345.namprd03.prod.outlook.com (2603:10b6:8:55::29) by
 BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 08:57:58 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::4f) by DS7PR03CA0345.outlook.office365.com
 (2603:10b6:8:55::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Mon, 12 Sep 2022 08:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 08:57:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 03:57:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 03:57:56 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 12 Sep 2022 03:57:53 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <siva.durga.prasad.paladugu@amd.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH] dt-bindings: usb: dwc3: Add interrupt-names to include hibernation interrupt
Date:   Mon, 12 Sep 2022 14:27:30 +0530
Message-ID: <20220912085730.390555-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|BL1PR12MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 83cef9e4-082b-4bfb-167c-08da949ce384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vvq4wJ1VWIU/19I+MKQtJOk89b4kRBx8+4//5Zn6Efeg+5nZfJvPxmxB51jT8hGHIsbHxsDLcB7aEhjgJKYrxMf3/f6omK6VIIEPAQWWzD3KI6yI6nDmPwFz1IAce1GZGCKKva+i+BSuPyJrJR72ad/pisa7ApM/89Gq67avH+5ZiMdfSpqu6fgu7Um6ndIWQZbCkDbQDHJD/tsFU1amTuFcsEFBxnBDA0nmsnnNcDvj0AE2QYdt0bdzVVTaMSJYTsRtqcBQnobKlfw97N27zbfsqPUt+dPuOa+2TyTGAiy0GXQjPxjh8jOndNlFBPIV8Q8JghBqvGuvTJv+iLkXG2dKUfgLZ3I/tBSMT0jXPwSOoQCtP1ieAAXnVK9DLWoZsgHiRNOn02ROZCw1l+myZtbDTv8GVobVNGXVizbP6Qtm43rsMBFUvjyFC2vYayiPVxErQ4zBu3qNEouovpvQC+pMQV6/nQU+G9cdrGctzRcnOIxkSDft7+SfS0M9TvJWwFeO2B5t/TgRSaU8OsNpdCfdMfolJqSWBJgWclE0yJ0So1n2vE/+FTDpq344DAGmXm+udOY2fNHryfRvuQlvVEu1y/MHmGcqGKaCfSFeU/w0nKr0PToybaazoRqW3REH8e206FFXDOvp1u7qxdAHU1Ns1xV60fc3xPvqCwR6VBYbFObIGiuarFGgZ8WgqxjTnQfWHyLdcjVZ9WvQxW2zfZbzJ+FsozwbURh8OPQbvYg1rCmctMdoD9pSloMCGqJaArmBOIyjmPt8BPKSZlG3y2qeLVQn0j410hmfvUNqqNfMU2TBcI0A9ZWQdz7yzVvS
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(36840700001)(46966006)(40470700004)(4744005)(36860700001)(47076005)(1076003)(8676002)(86362001)(4326008)(82310400005)(70586007)(70206006)(478600001)(8936002)(44832011)(426003)(2616005)(6666004)(5660300002)(336012)(186003)(40460700003)(356005)(2906002)(82740400003)(41300700001)(110136005)(316002)(36756003)(26005)(83380400001)(54906003)(40480700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 08:57:57.8302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cef9e4-082b-4bfb-167c-08da949ce384
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Narani <manish.narani@xilinx.com>

The hibernation feature enabled for Xilinx ZynqMP SoC in DWC3 IP.
Added the below interrupt-names in the binding schema for the same.

dwc_usb3: dwc3 core interrupt-names
otg: otg interrupt-names
hiber: hibernation interrupt-names

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 1779d08ba1c0..618fa7bd32be 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -53,6 +53,8 @@ properties:
       - const: dwc_usb3
       - items:
           enum: [host, peripheral, otg]
+      - items:
+          enum: [dwc_usb3, otg, hiber]
 
   clocks:
     description:
-- 
2.25.1

