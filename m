Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A90B6D24A4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjCaQJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCaQJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:09:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D3110274;
        Fri, 31 Mar 2023 09:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwJlEwU2QYQChuuI3v8s5JcN67uAd95tDQiDlvtbepCsdRdKzIETHfAetkYnVM+bYwPj3S4GlXJIB1K96xDC87Z5v4WabAZ376Wf2RSaA24lbuUojJuEANv4mThRUGPRJE7XZ94vw5KqTD6qKZFacmbPA7UMgYu8JYW4RPLaVrX0gEIf36Wc8ZiPGDQPMndHMdhCCTqaWz42A3sk0xeGGslSftZoYhN07Kj7kTN1ye29cpg4wZuyvh02koxtugifPskqgUUtmTnkpQfJnbi4sk7jhcEjzXvqBQRS9YSLBzYifMLZFGWkFKldvtG2mXcBV25lkIYjuS/RuSKFg1PbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ildR3zT2nPxdncwQUFM7mO2ztga/esrkc7IYWLPKxzg=;
 b=U06wnX6UTxOa6K8TujQjRoaDKEMIbV4waHG2rynLmRnQX2Bf/wqbhbi/HNjwg+ZHhlhyMzc3xshVZg7jneplrUVQACvBcqftywsiHePZRYHeqQrNXmVGBnQI0KuQBuk1AHXhM5yu8nFBC/wuWxcvm6b4jmMhTY5bfebZpZQCVOw3+7tFVpm6Bx9SB1kLb6efQ33u5M/yUZxMBOu4k670RvUmbd0fDQoxElaLP2buzVYDKi6zGkmRD1ORZbXB2rpqRcgpGp1sRZZvi4uqLtxpCiho5ZbJJgtEyuSLcmseVedqBvLvGr5WzlA4ncdPClVs+gZa7woTq4wmq2zBAbQw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ildR3zT2nPxdncwQUFM7mO2ztga/esrkc7IYWLPKxzg=;
 b=RN1iaXnXuAEvslUv3qSwJWeqrLXFh5NCGZ/OaBPcRigAl9fIfmkR2+KIP6ARD6/0uviE4avEyQDdrAbQp06b1x7UgEvw2vtaakR4+/n3f2hWVLhnfRf9Nj6ShL9ILgc+i3ux0mt/J5QzmYW1eAd3rHh+NoIyO/5o8FohjD1xn5E=
Received: from MW4PR03CA0279.namprd03.prod.outlook.com (2603:10b6:303:b5::14)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 16:09:01 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::d2) by MW4PR03CA0279.outlook.office365.com
 (2603:10b6:303:b5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 16:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.26 via Frontend Transport; Fri, 31 Mar 2023 16:09:01 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 11:08:59 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        Stuart Axon <stuaxo2@yahoo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH] ACPI: x86: utils: Add Picasso to the list for forcing StorageD3Enable
Date:   Fri, 31 Mar 2023 11:08:42 -0500
Message-ID: <20230331160842.7817-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 7180e8b6-8794-4d04-aa06-08db32023df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERDHzIo+MbF3QLwV4frPpIob15f8EM+S9e69ra2igkldeocd7sEl6zcomSKTRjSUpeXhSw/hir+88vF9um5sRpF9Ev9NPE/NzitWWxs0cAmD8gvjzL6VA3W1x7KI54f7lo97gGVAfeEsnAO0VyMez7aXqXo+mbyzI23K04jemCALx7YK9fY1EFdBe5wYAQPZcbWhfBJDTB+Um8+IlJR/6suc03urujfPKMX866GyqhW4shtGSBotvYDgsm1urJzaYPlFFUP1/dyYBazfEBIdYaaX1aK7I89aYFdeT+v4RJI4QPoUV0y/gLxrqL6bnsTHmis2BemTest0wXHndT9Jx08oSJsSXW7LHjI1U6nGyGXtq+Eh41FiXYBBPm0DyVf2OVSARIoddWdoSJVQ+Kh/B4MEu46LRND6R1ckH7EFXSMyeEhM5/DG05JhPNslTiHD9+nIRg0hHZxj7aKNZQ+65QFDfBb4lAIhz0/1H6M0oQ3QN69YnJGvm1FjqlgMwWbrDEO67JuKrG2UQxlh2rbvLuTBZ1I/QYPT47Yp4xru/50luL0rhTdiOezF52/dH5D22gJqtoqUi0f+gYn5HNnVworh/AX0/UUwma5+ZlkRErkS6a6/3vKr+9i9NNPY8tFTYVw8n18zg0QeRAys46m5MFG20USs6hefDVLOd24LByYzIp5NsixqyZvYskcis9qk
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(8936002)(5660300002)(82740400003)(356005)(41300700001)(81166007)(40480700001)(44832011)(86362001)(40460700003)(2906002)(6666004)(1076003)(26005)(7696005)(966005)(47076005)(36756003)(426003)(336012)(186003)(16526019)(82310400005)(2616005)(316002)(70586007)(70206006)(8676002)(6916009)(4326008)(478600001)(36860700001)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 16:09:01.2040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7180e8b6-8794-4d04-aa06-08db32023df3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Picasso was the first APU that introduced s2idle support from AMD,
and it was predating before vendors started to use `StorageD3Enable`
in their firmware.

Windows doesn't have problems with this hardware and NVME so it was
likely on the list of hardcoded CPUs to use this behavior in Windows.

Add it to the list for Linux to avoid NVME resume issues.

Reported-by: Stuart Axon <stuaxo2@yahoo.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2449
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index da5727069d85..ba420a28a4aa 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -213,6 +213,7 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
       disk in the system.
  */
 static const struct x86_cpu_id storage_d3_cpu_ids[] = {
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 24, NULL),  /* Picasso */
 	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),	/* Renoir */
 	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),	/* Lucienne */
 	X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL),	/* Cezanne */
-- 
2.34.1

