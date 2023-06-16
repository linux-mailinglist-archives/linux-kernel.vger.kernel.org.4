Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A30732A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244151AbjFPIzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244839AbjFPIzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:55:33 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEB830E5;
        Fri, 16 Jun 2023 01:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9th9zGJp0pah9OMCdRs43cJmrwR4q4U296q/6pD2pihXrFs1a3xH/0qrOD3IjyH2uJ8+Tjvrj+qaQ8GrS66+FrIYndO1WblTtMRepSjVsI2Z9RW0B3gWDczOEixq68oL+YfT1lxeNZt1rH0HlDuX6ilW9Vk+/WmBzolPCTHW4Re9reOiK5+IxX/YzaTtkrJ7Mj2t75lBeYGqkesFfsAadnuYAzH3Q3k30L9C8RN/Bp7Z5aZq5c/EkJTDAz/me+e74yXhj4EWowY6yZEow6uBusGpgZbelrmEwlL/rjW9tOlPoysYSyHBdZA89MPrrcGHvJX8Qk2a1+UpVleyyil0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTR6TjeDspJmp5Fo9pYiiKi+3nOC4nkqCcykXGpJGp8=;
 b=WN7frlfvDPsovDsWXYw+e5L81gwWJbWU4mw5KYxSCNNiB7kBB43senLKGsnxPpKFj+RQKtf2hDW8nYDM9Gm/gLH9KcOilwKbCYIJx34OEGIZsW72fncJW7xjxqe+GjOT2d64IYaw5agHARXpp2nf6KiPQKr4kZtEFzD17p7g/qXoBbgknntpe19MxC81NKZPRJRigJTtforq4/KfQ2zdY6EVHhAx960qnrSAI3Grayvv9GsPnb9zwtosIHlsjznThwZgRD1tqPDduBm3s6hP9qJvz/mas3sPgMiwdiNhrtJ1Q65ITApstHL72w2xxrDDe5nx+8JieM5x553s+n03WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTR6TjeDspJmp5Fo9pYiiKi+3nOC4nkqCcykXGpJGp8=;
 b=q39AeUUmZdIoXniJCZihSYuz13sypSYybUqVISIqBxTCaqcq7ba0dmBRgEPzBeEQa0reDhZ+ZFdqafSJUg+158rNzR/SflN775gqedQgj3BFdOJtOu9ltCgBrluSNXY4mbJUpV54usjTbssK6VzJ7PijTwJishpROlrE2eiqiAA=
Received: from DS7PR05CA0062.namprd05.prod.outlook.com (2603:10b6:8:57::8) by
 DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.29; Fri, 16 Jun 2023 08:55:29 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::a8) by DS7PR05CA0062.outlook.office365.com
 (2603:10b6:8:57::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.12 via Frontend
 Transport; Fri, 16 Jun 2023 08:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Fri, 16 Jun 2023 08:55:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 03:55:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 03:55:23 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Fri, 16 Jun 2023 03:55:19 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <git@amd.com>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v2 1/2] dt-bindings: mtd: jedec, spi-nor: Add DT property to avoid setting SRWD bit in status register
Date:   Fri, 16 Jun 2023 14:25:12 +0530
Message-ID: <20230616085513.17632-2-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616085513.17632-1-amit.kumar-mahapatra@amd.com>
References: <20230616085513.17632-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 815ed521-7859-49f6-0371-08db6e476f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kR4E7+pN9e2u7nWFPksyWaE368X/cXebXm8HFDwKOzZWQGSgHFzaRHQAdpY+JxotX6h+PaUMNR8Yns0MtQdXkfDQOXHN3U9SD4meWdbowFt97NOOJe5sJcuyq8fVRy7ConMznn0pN+Xm16SVLngusrJHNkinEC0OBcVFcPjdXKr2bVi3oAPvhdzD3i1vBakNwlrxUgL4D8E2EEgOObMDdfLaB/7EE3fZoJOEhqh4Um0vahzt1ppFxqObOhho8cuLK1GWdyQ5oUumldqUz7tLMJ5TnUAOSMt7OLpawMtwEiPIwwlBahBWDhE4T84Ge92IbHJCqKSLeRKBgbYXoOjV0pV0Pw6IRlfievn2s8mt5YvqIt8rQlc9jBrmyMsuSKLBbhP7hz896S5tzwmeGf0NzwsLJsZOUlZRI1Qu4d90ClItW5/6DyEWqVv2FfbURLDHaQ1wyPO6jJae7GBhYw9V9aLyF7gYle8xwhJ0YbPGcQeQXaSJ4dvtw9A6BFFTnbJuYxDyQgP9kraO2nVuDL96sbrbV4v8hysUjuZQzbvn6oEeJ5/joVfdkbm8kFSlnVeU0ZO+36otGrF7j+U/s8I5BuGsOBn6TTYWImxWoL36lFhNOip+RpILr9N9cMIXUDXB6pESjiaMcTqgI86Fqil2BOK0s0KeATD9DdoKr9Xi/YK12UPUPhC2fiHdTBoDt3DGrZlOshqk7Wmqv9b2CWGDyzy5Y5VX2KbsZWIND9K+YWJjBW95siYDHdzxOIdjZaaJAVPFyX97LBAWOzN52ojVZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(1076003)(26005)(4326008)(316002)(70206006)(70586007)(36860700001)(426003)(2616005)(47076005)(336012)(186003)(6666004)(356005)(81166007)(40460700003)(110136005)(478600001)(54906003)(82740400003)(40480700001)(7416002)(8676002)(8936002)(5660300002)(86362001)(82310400005)(41300700001)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 08:55:29.3112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 815ed521-7859-49f6-0371-08db6e476f6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229
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

If the WP signal of the flash device is not connected and the software sets
the status register write disable (SRWD) bit in the status register then
thestatus register permanently becomes read-only. To avoid this added a new
boolean DT property "broken-wp". If WP signal is not connected, then this
property should be set in the DT to avoid setting the SRWD during status
register write operation.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/mtd/jedec,spi-nor.yaml    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 89959e5c47ba..10a6df752f6f 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -70,6 +70,21 @@ properties:
       be used on such systems, to denote the absence of a reliable reset
       mechanism.
 
+  broken-wp:
+    type: boolean
+    description:
+      The status register write disable (SRWD) bit in status register, combined
+      with the WP signal, provides hardware data protection for the device. When
+      the SRWD bit is set to 1, and the WP signal is either driven LOW or hard
+      strapped to LOW, the status register nonvolatile bits become read-only and
+      the WRITE STATUS REGISTER operation will not execute. The only way to exit
+      this hardware-protected mode is to drive WP HIGH. If the WP signal of the
+      flash device is not connected then status register permanently becomes
+      read-only as the SRWD bit cannot be reset. This boolean flag can be used
+      on systems in which WP signal is not connected, to avoid setting the SRWD
+      bit while writing the status register. If the WP signal is hard strapped
+      to LOW then it is not broken as it can be a valid use case.
+
   reset-gpios:
     description:
       A GPIO line connected to the RESET (active low) signal of the device.
-- 
2.17.1

