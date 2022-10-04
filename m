Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D70C5F3C06
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 06:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJDENB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 00:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJDEMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 00:12:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D02D26554;
        Mon,  3 Oct 2022 21:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCfYb4ac9H0j9QaRacc2kZ0F3uVnXEY+bC2MMkX1apUIqVqV+dzO+i/ox9FXXsufsIbWgnFjLUcfXrhrrsuxJ2uzy41hCxd4UQlTaeQBQ7DEjoZjulaTYGbdt5bXGC3JDRzW0spOCrqCLTRwFbAZ4ksFElhCh2oglRHDI2jwLMrituy/EA4bFyu6wL+jF0viTUZvtW9jMmxAzcbg0K4V2OYxiL0+AG+R6IvnOkxkoaCEhQiXXkPKvQlym1X2AUib5nHBwI6xJsI/sp7LMWV5KDgURVblYxVv9rhKjenxzwNk/B/f6lP5r5015Nmf5MIWPBLhmiHm9PpeWSB9We3EYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4C6bFkfjN4Pub7xVIiyiqWZXCFOMHoZz4vJabvFjAE4=;
 b=CiUK6NYoB4JiSMT7/8jqddaa1FitmWy13DXOoCmnKC/4+5oDps2/TsHt02NOle5StOzVp5PH51pDJ+NTuc5etkw5BmFzEIVBc1GoC7BgSn5gAJ7TVoWn00Axaq2x++p8dXu0s3Q1h7IE5/5Y+bNEv7b4f/HBo/gfBGrO+PKUHsF+qZy9zGh5vx4xEn/ODC/AYswrYi98gV/LTJAdSoPBRPEibrSDKc3QUWGXGAUG1VcoJj4G89//mW4PgZGlW9luCifOQAA6LCQwHsRRg8Qn5zroaazMAwPITD1en3VnhtMtktHZf7lDHa/iLfSrQX/l6sD8mCUmDRWjVRijAtos0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C6bFkfjN4Pub7xVIiyiqWZXCFOMHoZz4vJabvFjAE4=;
 b=zCHmlWRnHjY26IFTB/tBgP363ypoG5+73XThGha3NEtAHmqrXrbdW6NYdGY15iIiXK89x9AM2vs5d5TpbW9gz+cMTDPokgK9Auocg8r+rUJv5wOr4MjeoOpGPjRNvzdghgpBdvB7/0EyuJrgKmXwliNdayIScp0bsD4UVy84F10=
Received: from BN9PR03CA0149.namprd03.prod.outlook.com (2603:10b6:408:fe::34)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 4 Oct
 2022 04:12:46 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::92) by BN9PR03CA0149.outlook.office365.com
 (2603:10b6:408:fe::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Tue, 4 Oct 2022 04:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 4 Oct 2022 04:12:46 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 3 Oct
 2022 23:12:45 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC 1/3] thunderbolt: Allow XHCI device links to enter runtime pm
Date:   Mon, 3 Oct 2022 23:12:23 -0500
Message-ID: <20221004041225.1462336-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004041225.1462336-1-mario.limonciello@amd.com>
References: <20221004041225.1462336-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 590ffdbe-ac1f-4731-0b37-08daa5beb188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKADt+Bko918GmouAa68HFuDFYiyyrttjba7Lyx5bKlqlompZccerdG9aaxEDcjtjT/ZuT3j71k/GqPgRhNxMK8Ea6HYdp9m5CyHVTJGm7glM3gPhOOqLpK9KL/VFsd6FINz5gGUXmmSNze531x7XFwYybbYHdgpsjxIpRxANOZdk1tcmKgsPKgwCi4NSvrL7OG/pbuJpPXij81Fz77aQ86WyHVWIcQb4ysW49SVkbJYH+hD7BWXJkfw3Cydg4fnjYj8DJwOQxLyJInZRLMamXs5ndiwAje4Rav9UVHpAQ6ymwvN5wyDHmHDVDR7a9e1HuH32a+S77oQ1L7a0w8oVV/rbarEb29SnDjkSDxpDHywscTSuhfyZfrOxIYVPewxtqgBr+h6HO4DrjmqcCJavtT8j7ltDFKaLTKg6+4w4m5oocmDNx+1nWyX5QOxJjetYPPoO+gigdJdKYbav0ELaWNGPGAHu4Kc/Nk19Lo6iY3osLyaVWwnyQOA7hM01vzgtQ3RL/AHBRjzV+fcvlKUTKoncV37K6sf/gjOLfU6jzv0K3JBj/RZ2zM88MgkQXWMmWsG0UORQAaVu3adTkdzVw0TfaujqRIWirdoNrkzHn8s92QLbpcQWB9mNxaVnb3hNHDeSnDNIvTOAAXZIdfX/2w7Vr+efeudSfIHhD7u0XReFdzR04AC5+hJmJ4C25ql+6nIKL2dK6ZJNPK3RezzCs3eboBEsa5v682VZpZmrfImdpwgeo8uv0zBUq/ysnHaufgQz7SQL+u0lT+paAAUMNkd5xjdhEt1aSo6wXGgU3OCfKYlPZLv4Y9kEeJ6fFoY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(2906002)(356005)(82740400003)(86362001)(81166007)(36860700001)(36756003)(2616005)(47076005)(40480700001)(8936002)(82310400005)(44832011)(1076003)(26005)(186003)(478600001)(16526019)(83380400001)(426003)(336012)(6666004)(54906003)(316002)(6916009)(5660300002)(70206006)(4326008)(70586007)(8676002)(40460700003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 04:12:46.6417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 590ffdbe-ac1f-4731-0b37-08daa5beb188
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both on Intel's and AMD's USB4 designs it's important that the device
link to the XHCI controller used for tunneling is able to go into D3
for appropriate low power consumption features as well as for system
suspend states such as s0i3.

Historically this is accomplished by adding to a hardcoded list in the
XHCI driver, but this requires a change for every single platform.

We have a very good proxy that it's safe to do this since the firmware
has indicated the device link needs to be made.  So opt all XHCI
controllers with these device links into runtime PM.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
index b1f0dc8df47cd..5ffca085a47e3 100644
--- a/drivers/thunderbolt/acpi.c
+++ b/drivers/thunderbolt/acpi.c
@@ -75,6 +75,9 @@ static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
 		 pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))) {
 		const struct device_link *link;
 
+		if (pdev->class == PCI_CLASS_SERIAL_USB_XHCI)
+			pm_runtime_allow(&pdev->dev);
+
 		/*
 		 * Make them both active first to make sure the NHI does
 		 * not runtime suspend before the consumer. The
-- 
2.34.1

