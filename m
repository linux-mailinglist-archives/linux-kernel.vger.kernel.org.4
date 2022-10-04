Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D585F4C65
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJDXGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiJDXGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:06:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7E4275F9;
        Tue,  4 Oct 2022 16:05:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAt/8bEDcZf3QN/XzkYUDjJwZx3PttzMZQzbHitlMUobHt8TT7LuM8g2BGy6uVjZEIdBwQ36pBLb3CEtXda/vDRa0J4Fbc+4vksBdM2e4AK6X3a0Fb7YTZYHovGhuq0ynpjsWUJEzUVmNTaG5r91K48JSFIS4iHkHZAzST26T/Z8smtt9W6KNQ0o6JJAGg6apUoViw5wKvY2Fg5px2jQSTKEsXzQwnR2fAxKDVtblV3/sa4rxFeCNH/BR2jN0Dz40dP35IsrsTxf/Z9fO7KqfQePk3HCBzMRRst2xq78WUC/s3q+94feOHyByBHGkBl9xf0DUsHZvnnepxE5aE3v1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3rnt9jonHOHo9BAZAKla3Qa4i73V+4RPiN6F53EW8M=;
 b=ZvxLW6tHulHRR17aXSV6fazzkBbcurtWt4/SBe9BMlmXEf5zf3y3TJus2EkZ7WsrTRsY3/CCK+ME19oqJ/sm02fNe+EtxSFPv6Fs0kWsHUufk/NIRnWXdiKGIrxkbDKon++1CLW75jWsZ8u8wrRtjHhygybuuurhaM4JvDaRPcy5Xs6fZFeiErGqzEY2uYLN1hypn6QItbuLuNqij7ejtiwgHwiHEIluVN0UDnnPObcxFoBkGntfkAE5ybuI6FQlfLzys8GkfnBT5uOePsDaRt4l8hoETRztHtHjC82XuYdq5ne1+T4nIu46voI8XMQv59Tr1rriuGXRTlQ49OalhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3rnt9jonHOHo9BAZAKla3Qa4i73V+4RPiN6F53EW8M=;
 b=5uxMobk6XysO9pUt7W5gnKwqahs6/0MMgHpGrZ3ZVANSRlccpeoJbRMdqFVC+aejddLU5kDQMvJ3VbAkKozh4weKCvK5IZPyxQSEDXF9LSK17bPxm1KXxqfPNiJ+CPapbKWPXxWSNIj1i9ZI2GVQnWz7BH81CZgF825g5kdf+ts=
Received: from BN9PR03CA0540.namprd03.prod.outlook.com (2603:10b6:408:131::35)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 23:05:53 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::d6) by BN9PR03CA0540.outlook.office365.com
 (2603:10b6:408:131::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Tue, 4 Oct 2022 23:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 4 Oct 2022 23:05:52 +0000
Received: from ashkalraubuntuserver.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 4 Oct 2022 18:05:51 -0500
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>
Subject: [PATCH] ACPI: APEI: Fix num_ghes to unsigned int
Date:   Tue, 4 Oct 2022 23:05:41 +0000
Message-ID: <20221004230541.449243-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|MN2PR12MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7faab8-b7ea-43bd-dd9e-08daa65cfc85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LW9Wq+CpY88dmjxxCI3+RCz7NRfjWhKHBtMeSTVSuzlxPESSrEYnpmItLmYj3ngJBCS3mtLFJj2PnuaqAbIffRikh4ET0jRAma3++XzhIi8SJewdu6GJFlAotJnUaRs1mt/mzUgAKpzJDrACjT4TgKojLhzYSuhqTFENoF07m2nyezSJSIRecTU3bfbjXu9JeYTrSDYOaBy351mmjdWWEoT9t2dMTU4b9on9lIU2WzCzcl++Q072JVaUekQxNktyCEZXIRvslGWs0Bv1Oo4Qej0UhocyOKXbMun82vboVJvO3dhJ8C07HOUAA8lMGuP/uJLrCw8fKSshRbeoDGYF6ppJEwl4XOZ123Fz04UTtjb0JvKHggvvjFJlSEH8NMiErlG2M90mEYUaaJQBxqIvWbfMTZcqwPPjH+9foEBmGBY2ZI91EY8K0hOqi7PCGIMJiyQJoYPMTUjf8hUEceyTDNHyPCojFQm0P+q6WTc6GUiskA4qYvYo20py5hKC2qf3Ftn3aJX+35Z8R9uzabRYZFsthk15yLq8Z1azy/YG5YlrLVYDHh8XpEk7IGF+K7mpDDl7QBmLF4QPr9NljSEx0/2qfiXU0X+kibC8gDrba8HMWxBIgx/7qv4FN3ZeaFiVMEcT/WG+LFHLV6Xftj37sAnzwV2ILyFTTGsriTMK3+ra6VfCl0Y3hai/jua+Qe8YuZfZEmH3e/aeBIImOiU/ShX+dthbcpk66oAG/JwIb8P6T10Po2AtKT5Mp6lIRZZEPcNl/YEIrTM5AusMEXaEejQJv3BKy7JwJbim8q3pkoAROHQrqabsx7FBQL7NyhFI
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(81166007)(82740400003)(356005)(36860700001)(82310400005)(186003)(83380400001)(86362001)(336012)(47076005)(16526019)(426003)(40460700003)(1076003)(26005)(6666004)(7696005)(5660300002)(478600001)(2616005)(2906002)(316002)(41300700001)(8936002)(70206006)(70586007)(110136005)(8676002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 23:05:52.9555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7faab8-b7ea-43bd-dd9e-08daa65cfc85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashish Kalra <ashish.kalra@amd.com>

Change num_ghes from int to unsigned int, preventing an overflow
and causing subsequent vmalloc to fail.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 drivers/acpi/apei/ghes.c | 2 +-
 include/acpi/ghes.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d91ad378c00d..6d7c202142a6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -163,7 +163,7 @@ static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
 	clear_fixmap(fixmap_idx);
 }
 
-int ghes_estatus_pool_init(int num_ghes)
+int ghes_estatus_pool_init(unsigned int num_ghes)
 {
 	unsigned long addr, len;
 	int rc;
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 34fb3431a8f3..292a5c40bd0c 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -71,7 +71,7 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
 void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
 #endif
 
-int ghes_estatus_pool_init(int num_ghes);
+int ghes_estatus_pool_init(unsigned int num_ghes);
 
 /* From drivers/edac/ghes_edac.c */
 
-- 
2.25.1

