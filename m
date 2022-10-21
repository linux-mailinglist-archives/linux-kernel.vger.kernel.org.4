Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5CC607E71
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJUS4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJUS4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:56:36 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2084.outbound.protection.outlook.com [40.107.96.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950DB2764C1;
        Fri, 21 Oct 2022 11:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxEkFB55DnzPo1BTK3SOT3X48EpnNeRgJuPq11fVO8JkLeVTzh2NCjBe/iGsdHPhYQxIsXrkklCuTfatLv+aufq7zIcLpl44d3FEGrNeOGveddtJWfzEFyEZOnvOHOBUzblFMRmUdJertkjMrB4SjpGBjx9SKel4FNflIeVdH87oXiiKLJCvkKVfRyENJ+pK1C4htw4Shv8eZNA8nMal5Fu2QrQyWCbeW5g6AIo605He2OjMLoF6jOMnoyemGFT6u6VjFdyVTZWgNqYsM3yu6PvfsYdTKCdBw67TULm+HaUxKgnGTr5hxji1MRr54fCff+//z4CKG0/IWan8uOqWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAtCwXB+tdj0y5nj+SlhChXbhHBEB+p+yA8uRqWcyKM=;
 b=cBKoZuO0dqQ9jwZ1bsq0UzJxk9ZafJdHhjE4tUP5FM39LMPg4owPFlMLjQKdE6aEV5TXnHz/t1OLZEbESYLIcTwXrt3h6Q9iI9KbyQUH1xfkzqVbDG5P63sJORNGw8km3YRidhjYEKqybhxOAvUkmZ6o5RA2WVcV9chtQnjAmrLlycQindMj01YfaPF5dD3OslV8AQqkrTperq1wXiUE7XSz0LY3930SaZisWo+FxxJauR4+vkaZofpOlxMAAiBr/FNfxKoJSht/0aRsRNguVpi7OIVfqbbYoWhumRYiND+DA2qyO1bRTopXttoXi9AllcgBIsxMdALdPR+E3zM4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAtCwXB+tdj0y5nj+SlhChXbhHBEB+p+yA8uRqWcyKM=;
 b=zKDptJLcBqsQHKnf7Pvq6faX7bo1gcbN/F8/mGMiMHZzEabfRRD0A7xQV7jCEA31en28LjOiRtivqNiBG+RDB1saPXTKm2HDgVWNl8Xc85GXkS0vFxXjORUgq4mbgoTGq0WlQa7DZLfH0yolYrzGEChmrxJxYuLsGf4ZtY86c0M=
Received: from BN9PR03CA0088.namprd03.prod.outlook.com (2603:10b6:408:fc::33)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 18:56:33 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::8) by BN9PR03CA0088.outlook.office365.com
 (2603:10b6:408:fc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.37 via Frontend
 Transport; Fri, 21 Oct 2022 18:56:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 18:56:33 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 13:56:31 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
CC:     <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        <rafael@kernel.org>, <lenb@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <rrichter@amd.com>
Subject: [PATCH 1/5] cxl/acpi: Set ACPI's CXL _OSC to indicate CXL1.1 support
Date:   Fri, 21 Oct 2022 13:56:11 -0500
Message-ID: <20221021185615.605233-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021185615.605233-1-terry.bowman@amd.com>
References: <20221021185615.605233-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT053:EE_|CY5PR12MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: a0832e09-4206-4961-6717-08dab395f8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwxvs1hFAGvKoEYyw4m23rVmbz24JgC72ZBXz/PYePqH7daEFCqvfwrSyns8y9zNSJjMAvKQJHNBcmEQgLiABvpWH8QermyUhRtNgYrOOouaTEg/AfImmWJwg1q4dEcqN0Rw7P7KcBRse1RMqSJ/w0QQYZhPSjweMAzt7+3SCWTRD6QcB3DINGKBBONYpeK4zj3WKS262Eca6rRFCEO5G27NM+AL1/uB8wYhrdiWegM//zZAMEgWqAFyXqLDh7TR+HGfQIZ/2GWMG9RjqQtVX5IKwGrHwZgC8AlSWKShzae5TeCog9ZornTx+E3IvppYU7IQOuTk7z0Sj6gkpri6ApAL3hkrGYKN/DTcd3breDcZGbTNaidO3zCosMRqovA/ztkYjw/Vs3UYbJby/J0lZnPL17ck97SezzAUfN2ciCF0CwX4UAaUSgQI7zOIArkDZ6tKEN/jqRvNgHkT/A9pvA/7m0/q8CIijIYWY9xjNJ1yRFfNoSFTOpdB28fSj3BdMygPLbfmKD2kV6B+ATxFqqrND8WH1NY4qDwz4MohK2qUH0MmUuDV0VFc6za+LPBsq/3gVHogpLoXCFadQpMTcjLQpVwgIcv5zl0/g1FoFlAQA2WPyvfnd28fAL+Awn+5EjIEKnDI30cIq8hyAmCSTHgdYlJWQOmKI5b04O8ZcD8q/HtxTAUwgW6FPgqTsPyOD34TiDpiU0brtTMkqJzOnywfOinpZS5dbnnIVXFpWdibHl7cCp79Las2Qb6F/mbK4962e+eetHn/T25rM7iKfQrMLNu/eJ7atD1Ejuza+Cuv9lyHMc6YpmWRzHEHvTsX
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(8676002)(54906003)(36860700001)(110136005)(316002)(40480700001)(8936002)(7416002)(2906002)(2616005)(26005)(44832011)(426003)(47076005)(5660300002)(186003)(40460700003)(336012)(6666004)(70206006)(16526019)(70586007)(1076003)(4326008)(41300700001)(83380400001)(86362001)(7696005)(356005)(81166007)(82310400005)(82740400003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 18:56:33.3578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0832e09-4206-4961-6717-08dab395f8e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI includes a CXL _OSC support method to communicate the available
CXL support to FW. The CXL support _OSC includes a field to indicate
CXL1.1 RCH RCD support. The OS sets this bit to 1 if it supports access
to RCD and RCH Port registers.[1] FW can potentially change it's operation
depending on the _OSC support setting reported by the OS.

The ACPI driver does not currently set the ACPI _OSC support to indicate
CXL1.1 RCD RCH support. Change the capability reported to include CXL1.1.

[1] CXL3.0 Table 9-26 'Interpretation of CXL _OSC Support Field'

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/acpi/pci_root.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index c8385ef54c37..094a59b216ae 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -492,6 +492,7 @@ static u32 calculate_cxl_support(void)
 	u32 support;
 
 	support = OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT;
+	support |= OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT;
 	if (pci_aer_available())
 		support |= OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT;
 	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
-- 
2.34.1

