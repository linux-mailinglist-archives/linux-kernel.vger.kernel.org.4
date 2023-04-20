Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A956E909C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbjDTKnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbjDTKnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:43:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E2E137;
        Thu, 20 Apr 2023 03:42:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9v12XOtLwDHBLetiHCdkoj50cUBM1h1LBS4+hTnSmULmCV6l/0AP2PGPKzBGPVhumvf3gdjlBUYw9OwcqHk9+6OlOKNzKXSmuj7Lsb6fmU1+KPtqIdgpPzjT5uRtFnbPgPKwVVLybTp52W0Zn7i8aOTB4syjHjH5m2ZX2V1iaP4O4Duk3McQ0L8ex1FD8mALHHEPGfg71VUbb7+LFHme3xE2u+kyW7ZqUjIq6+H2E0O51iGWywN4l6dP+dJ36Vd4z0tvghoO+CEabiNLSGWOJ+FoIsLxlTEcXT5FKWXcGTzFz6ZbetIr+/WKqpuWDs0JsDHEnrZSXtB4/PW7UGLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuV2bNHtLbNtTIYixfe4dbGV3RvGOxiAicMAq1Whx7M=;
 b=dQJFgGzpfAQwdpAdoseBlnPPS1GOfdYg33IG66kSN5s+T2I0M7njdy7mt3HOnsHcaWMkXLOME/YV2LUwnb+P0fCVPgnvu3UHz+xDsrheZURnc9Ny+hN1MijKIFWRzaUAVqMridHTpA/vQCvqWIkSXQus8qnUVK0dnDvEuhmX/Shi/aYtSE8g4wo+nYYB+tltv2gjmyfNvoM6zmeIyvfn5DJjDqaPiG+HVY8QXmLqL2M0tEM3AmuuiT8rca2Qd0I5CozKVdgA8abVQlsPAabMoAPAanh5qetzSyz7HE+/ppfSS2E3lvgwu2IUnZ+C5wo+jPYGSnP7Zie7hSuWwJMZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuV2bNHtLbNtTIYixfe4dbGV3RvGOxiAicMAq1Whx7M=;
 b=AVB/i5ww6G9zXY/XSFioThl3sXi86Z9RbxzXVETTSY9x6Bgn5qOQ77fDeznRVMFC3k4483CM4pwyWkPe3NrG1QScyBYK3pMp8T4L1DZI5b7np1UzKemNVig6wycwCtFHtt1mPYgtg840dcSdOeRHxZaqwtuMLbTwZMNp70RgEZI=
Received: from CY5PR13CA0017.namprd13.prod.outlook.com (2603:10b6:930::29) by
 PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 20 Apr
 2023 10:42:55 +0000
Received: from CY4PEPF0000C97E.namprd02.prod.outlook.com
 (2603:10b6:930:0:cafe::f) by CY5PR13CA0017.outlook.office365.com
 (2603:10b6:930::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11 via Frontend
 Transport; Thu, 20 Apr 2023 10:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97E.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.14 via Frontend Transport; Thu, 20 Apr 2023 10:42:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 05:42:53 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 20 Apr 2023 05:42:49 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <shubhrajyoti.datta@amd.com>, <michal.simek@amd.com>,
        <srinivas.goud@amd.com>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <srinivas.neeli@amd.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>, <neelisrinivas18@gmail.com>
Subject: [PATCH V4 4/4] MAINTAINERS: Add support for Xilinx versal watchdog
Date:   Thu, 20 Apr 2023 16:12:31 +0530
Message-ID: <20230420104231.2243079-5-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230420104231.2243079-1-srinivas.neeli@amd.com>
References: <20230420104231.2243079-1-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97E:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cab9c0-651e-4ddc-7210-08db418bffa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfzPr3vDIskqm5sLn/DWiVf/LsRaVBl4Eb2ARgL2XxkA38f2jMBAdWWD4F3ZmKpXYAT+w4jatZ1Nk/4iu9sayIv2URc7tjuPMisrRmCJ1VIF0aFjeB2szyfolbzfd2gPsEyF5khSPBU12qJDPSPVcv5XU4OqTh4F6Zq9IP/CeyjXlmL1q09FfunHOdzfhZlqt8gXxNc2xBTB3kcurRiswTqk1f7Mzhti0yiv/t97wX/K6+3eJXZbknZfysgbwglzDdR/XOc/jkIzcspThealvl2zxDvofTGCDLr1NQAnlDSVanYLwbcqWemKAt3/y5lOiNtzVlGpWLQs6jmBQEnhrKRHBZmtM2rhahesZhBYu1H5MOi5UPleQC4LqePq2189QPD/Dx1oNCFxZi7Nt4dJc8oZG7huvhrVHcIokxcSmFfsHNAjLWsdKjd8MCORR+P7ODl+/wU2rraYYPViUlBpUwR66P2X+VSVAEbJo4Pv0rKkU/2kyhrKdx5TWzdLaTQ5q2M4df6IF3UdF/khjDkJi0+OydHBa9sszGCBAvzf+gkLxrC/1PYTCyvANvKX4MylBXOKyTOc2FBchIkXTFaR6RHj8t072pZjHVjCyExzgOPXTZqm15ggHxBpYXOEMt7B0RDe0sUAm3W+j5PE2eNZzO4s1CJD0ofmUqb6DuQbFPlE+28n14Ffdy/NKJccIJzAXIw8foR2ho/YzYwlEG4Ue1uMmPtDU/OMDR99A66qlz4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(26005)(1076003)(82310400005)(356005)(36860700001)(47076005)(82740400003)(5660300002)(336012)(426003)(478600001)(40480700001)(81166007)(186003)(40460700003)(36756003)(8936002)(2906002)(4744005)(54906003)(8676002)(110136005)(316002)(6666004)(4326008)(86362001)(70206006)(70586007)(44832011)(2616005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 10:42:54.6927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cab9c0-651e-4ddc-7210-08db418bffa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added entry for Xilinx versal watchdog driver.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Changes in V4:
-None
Changes in V3:
-None
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 327901c9f1d1..388305608418 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23148,8 +23148,10 @@ M:	Srinivas Neeli <srinivas.neeli@amd.com>
 R:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
 R:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
 F:	Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
 F:	drivers/watchdog/of_xilinx_wdt.c
+F:	drivers/watchdog/xilinx_wwdt.c
 
 XILINX XDMA DRIVER
 M:	Lizhi Hou <lizhi.hou@amd.com>
-- 
2.25.1

