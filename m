Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE846DCB02
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjDJSrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjDJSq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:46:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4180E211E;
        Mon, 10 Apr 2023 11:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBdqtFx7+csUL5mNLCvLuD7flg/GsqGd0ZifCx3t/AWiuaDFlwtBLpRBT5GVi4pJPVyvGvsElCgAAcDd3xBMklpzwocQ/TfjTOM+ZWCI1E7x/nwN8AuzolVisufLRr3JoVVETxPZFNO3eP0w6tvjnH6Cp2tZnKcszIQy9yA+nVzTyzaJQFOhSttVHJGI2hdr1V8r5Ssnx+q7J9Yx1m4ZDYQPvJtJsIVRHbtkAj2oFqRQo3Q+zx9Sckce9CvXuesEQ2F77gTZWo4rRSwLNLH2EJ/wec8J3FEJqQLPmsah5WNg/sZLb8y3Jn+kikJSsbLkUip0XnziMLXDEY95Pxr2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5d82bpmyF+6P+qy1C97qBN4cXmEmhjcPYdPiNzeQJ4E=;
 b=nIMrL19mVC+23oCVTBoGLkGiNqq63VaAeOHcvuaUcGOw/LzcX52WZ46FR4cejrCnLsqOT9s8qBTDpFrqTANqgPHaoVOmKtvMDcdfDtvh+S3M8KbL1xhyIh5u3Rzwn4E4wfMOceL8kPiX1B0D4LLyU5pHBji5gZlUDrPvxY/p7JNMnQyhSHlIC7v3cV6bQ0B4zHT4saFEuNuxJMfVLnr/EFSzLa4VLJsRsACwiF2lHaiBNX6iiDcifrvXi22pcAuYfvaGhpYmDEyTMDGp1v7eUJhwIHajN0/K6ruYWUfj1U8oJdyU7JxBioBu4V1YhoZEQs0VLl1SvGot9BC6Ik52Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5d82bpmyF+6P+qy1C97qBN4cXmEmhjcPYdPiNzeQJ4E=;
 b=R/FI9via/wh5waoaC1x1RqSm8zEG+WbYTV/z2YZDLmOFyIa/XbktvXV2zT17F27K3ZNB5xb0nqxiwPZUfe53VYmIOSKijS4YFeE7KqXwldPq9/DISxUS+fTZ+bHJlLpgDcNdkwbvfR0e47WhzWGcYB/9SlHQNhLq+Kae3CNd0BY=
Received: from DM6PR21CA0015.namprd21.prod.outlook.com (2603:10b6:5:174::25)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Mon, 10 Apr
 2023 18:46:42 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::8) by DM6PR21CA0015.outlook.office365.com
 (2603:10b6:5:174::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.2 via Frontend
 Transport; Mon, 10 Apr 2023 18:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 18:46:42 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 10 Apr 2023 13:46:37 -0500
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v13 06/15] MAINTAINERS: Add entry for AMD PENSANDO
Date:   Mon, 10 Apr 2023 11:45:17 -0700
Message-ID: <20230410184526.15990-7-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410184526.15990-1-blarson@amd.com>
References: <20230410184526.15990-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e97b79-7071-49c0-7cf0-08db39f3ed79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 49KxCTAHx+iUb5KCyoZWvNF4YEtwnPFYzLB+pCENV9oPa53Rmv2gN0+zBt+y4vCp+vWU6Qs0gHN+/OHcKBvrXbJ6di02sZJ8X5+XsEkwRfAbkC0aXSG5yweIxUi7RGGUX84CAx6Gv8uMrQTesAK5QXEMIxTRUZANedm4NEaNynYy1rbhfqfhfxDjWYbqs/MFd1sWlf5sDOockj/2EAuToAY3bX52kKQLVxvtm5lXYWF6/F1a8nAFoeGEdypltHXCHKHvrzJvNyb0jAiIhRaJJo8teF7I8wkQ1Oh3G4Hj5+YZn+1fh0PgFSgRNkvO3VYWMJ9dgnIjtl9Wne7n76RKTavRS6ndGoTbhyuJ/EnnEaFSz2AONFgteNCZCLD1XBes7+qQqZOQrQe8Hxf8if715dEidmGzdOpNSI28nIWRZPiajw4LqsUwDf0uY6kYQoLSAvF13PV36ZH7fNqOHrYCU2Is28VYIpVu3ViQS7THH4RdMld8MKpfdyENzLMCenPg2ylEYHoqJ0CdZaPZRa/Ceql0rNNdHr1ai9ippjYzQp2mC0yMvolwGqGWBItQ0yNT5x9hUt5G0a3KL5lfIVXvkA/dbXnpgCjbecP9jGP+XpWWXsIk1NRBUu79dfgEiYqMNiTGi+tvDD7Tl8aMSjmKXNAypnqCPGj6UqaEqN18UirQD2FifXbxYBQEil3hMH642blgzYb3pFJZo7VtkF++xrgofqXAgGak85564nc6o3c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(316002)(41300700001)(7416002)(8936002)(54906003)(186003)(2906002)(7406005)(4744005)(478600001)(4326008)(6916009)(70206006)(8676002)(70586007)(47076005)(6666004)(82310400005)(81166007)(26005)(356005)(40460700003)(1076003)(16526019)(83380400001)(36756003)(426003)(336012)(36860700001)(2616005)(40480700001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:46:42.6274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e97b79-7071-49c0-7cf0-08db39f3ed79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for AMD PENSANDO maintainer and files

Signed-off-by: Brad Larson <blarson@amd.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..5e39def215c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1875,6 +1875,15 @@ N:	allwinner
 N:	sun[x456789]i
 N:	sun[25]0i
 
+ARM/AMD PENSANDO ARM64 ARCHITECTURE
+M:	Brad Larson <blarson@amd.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/*/amd,pensando*
+F:	Documentation/devicetree/bindings/soc/amd/amd,pensando*
+F:	arch/arm64/boot/dts/amd/elba*
+F:	drivers/soc/amd/
+
 ARM/Amlogic Meson SoC CLOCK FRAMEWORK
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Jerome Brunet <jbrunet@baylibre.com>
-- 
2.17.1

