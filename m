Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C82E73BE63
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjFWSbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjFWSbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:31:42 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2F0271F;
        Fri, 23 Jun 2023 11:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBh/NMDV1KGdT1DXTsSwvd/lm9iFP7IkJNeBC/tzZRCkA2Dpog8jV5O+6I8DxDABI/5CeR/RHArY2Q59XGL8dic5unLD1J+NtIgwGee47t4IETu6xuRXEfSOTDAeWMuusTa9dxWlXMqQIKuz7BRpvC3DLyI1obtp9oxfizArE6e4eOHVX8sbOXDfnVorFqOh1lNtuvun6NjPXtGNqrJ1WV0kbpT+ABrVjnaytCq+kxGR56RvK7qnC0do0QYIuwM8ndu4/RG+oxw1N0cUS1iLn+szkIs2cGtbC5ULRIUWZ8hD+u207Q1e79ViRWouN3IQ5/lU5xTEl4QpR/iBsHB8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63gLjc6DoFoLBycn3sColfuDTY1sT7xAsRgZo48WJrQ=;
 b=Vdz+2DI30x1G+ggbCTgToK1cOluHOBhH8kZTLbGDYBN95QREJj+Q+y23y8irC103bSJA5C9PzkFKI6A8RJVgr3SJI/EbwQb4X4Si47K+B/ZChUknilMlF7jvdQdVUVUvwA4IQkpn+mLCVxeSOfEhH6+lFN1jWIA1wpoOjozP+h9JXVgLb7u+19+u/6uOhz1tyLejQ/4pkOijdeMNgdLS+BSRHigI1zMz7ssBSscCSB4dA2GfBY1YROgkz3uW6c6xhHeCKmuy8gTVIugUR3yacbwrmNa8MgdhA7n5bWesULQX2e20LHaklVjzYCtp7pibkMUfAbPqf2F4HnmAwYCOeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63gLjc6DoFoLBycn3sColfuDTY1sT7xAsRgZo48WJrQ=;
 b=c5U3wQuR9F4/zi+uIcS9cZ/XftEqzmJaP4lJNr5WtICPiYzsiT49OrmCifv6iKoQKuIy5UL+wCMPHCiSfluvryrGd++a2KhVCyglbIil7EQZkNpm9WIFHR1cWldEHmy97HGaVB7kzQA3C+fB80ndH59FoegBjZJYssS024IcVzs=
Received: from BL1P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::27)
 by DM4PR12MB5150.namprd12.prod.outlook.com (2603:10b6:5:391::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Fri, 23 Jun
 2023 18:31:35 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::3a) by BL1P221CA0026.outlook.office365.com
 (2603:10b6:208:2c5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 18:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Fri, 23 Jun 2023 18:31:33 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:31:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 01/11] crypto: ccp: Rename macro for security attributes
Date:   Fri, 23 Jun 2023 08:49:51 -0500
Message-ID: <20230623135001.18672-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623135001.18672-1-mario.limonciello@amd.com>
References: <20230623135001.18672-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|DM4PR12MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a700fa3-4b81-465c-2f03-08db74181264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVvAONk4RLtyyrQ37oRz7q8BTrRv3ZX0y7yEiZgycDsDHbT5dNkU8vFqccXThJxrTPGGiT2H7XTmFaxrmB+9w1q9b/UHemC1N4JBJDbDTSu7m6vs26W+Mo6cL9PIPqfX8ocV7ZCYr5BSg51CJLZtriGH4V6WgjmFY6nsh8ew3elbpW6yJzyzdV/9nZM0NOugzOmQoka3OnoO1hsiMoofTEZhuB9fCum2SvtBbTGTj1EO2k/edv/m+IgeLYmnfRWID5RmA9r4/zDzJfX7MhjPR/BaUY0ic+k9Nn9fkDLrF4DBRbM/Lk3HDzmhi+j54CpxM2o0X1N7UgzyvWfkYja02/lAQ2LOfvYWReOq/DLS3WUaeyVTQ4Zsk8ToY1uAgMqzvOqUUsms/PyNFKQA8e/tcxJtTWy2BZhQibqeAvP4wV1k7s9WJ05/dkcWNX44a5bcz/Sj06MjlnTaKEVDMr6NeE2IZpnutlzCDqoiYW26sRSVkYaurtLJ31hwYt36FYnpmPBipVt5nX/eOncohkI/KghOxWQynXUvfbLPui+fr+KlwtIEvtD/iH8ilQXqIJUGfwn/RZbK+BdZMmtWAQQmeYhrOhChAc6MawsvWQurR/NV+gtreZ8mO9lrm1/pDiQOf88eMweePKc5/5aAZrJGCUwRGBKQteHB5yRgPfJ7mnpZH6eHP7wGX6uE9r3qKAGe/1vKSEPjCeO+DTW3+hhKoD/pQpelcVI2rKVMB8NqCVDSCIuWShKxkiWmk8AjBE3/a+NnuPxupG16aXlgaeneAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(16526019)(36860700001)(15650500001)(1076003)(36756003)(4326008)(316002)(70206006)(44832011)(70586007)(5660300002)(2906002)(8676002)(8936002)(41300700001)(40460700003)(40480700001)(82740400003)(478600001)(54906003)(7696005)(47076005)(110136005)(86362001)(82310400005)(426003)(26005)(186003)(356005)(81166007)(2616005)(336012)(6666004)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:31:33.9181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a700fa3-4b81-465c-2f03-08db74181264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5150
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The attribute_show() macro is only valid for determining the availability
of security related sysfs entries. Rename the macro to better show this
relationship.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Pick up tag
---
 drivers/crypto/ccp/sp-pci.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index b603ad9b8341b..c8f075a7f49f8 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -32,7 +32,7 @@ struct sp_pci {
 };
 static struct sp_device *sp_dev_master;
 
-#define attribute_show(name, def)						\
+#define security_attribute_show(name, def)					\
 static ssize_t name##_show(struct device *d, struct device_attribute *attr,	\
 			   char *buf)						\
 {										\
@@ -42,24 +42,24 @@ static ssize_t name##_show(struct device *d, struct device_attribute *attr,	\
 	return sysfs_emit(buf, "%d\n", (psp->capability & bit) > 0);		\
 }
 
-attribute_show(fused_part, FUSED_PART)
+security_attribute_show(fused_part, FUSED_PART)
 static DEVICE_ATTR_RO(fused_part);
-attribute_show(debug_lock_on, DEBUG_LOCK_ON)
+security_attribute_show(debug_lock_on, DEBUG_LOCK_ON)
 static DEVICE_ATTR_RO(debug_lock_on);
-attribute_show(tsme_status, TSME_STATUS)
+security_attribute_show(tsme_status, TSME_STATUS)
 static DEVICE_ATTR_RO(tsme_status);
-attribute_show(anti_rollback_status, ANTI_ROLLBACK_STATUS)
+security_attribute_show(anti_rollback_status, ANTI_ROLLBACK_STATUS)
 static DEVICE_ATTR_RO(anti_rollback_status);
-attribute_show(rpmc_production_enabled, RPMC_PRODUCTION_ENABLED)
+security_attribute_show(rpmc_production_enabled, RPMC_PRODUCTION_ENABLED)
 static DEVICE_ATTR_RO(rpmc_production_enabled);
-attribute_show(rpmc_spirom_available, RPMC_SPIROM_AVAILABLE)
+security_attribute_show(rpmc_spirom_available, RPMC_SPIROM_AVAILABLE)
 static DEVICE_ATTR_RO(rpmc_spirom_available);
-attribute_show(hsp_tpm_available, HSP_TPM_AVAILABLE)
+security_attribute_show(hsp_tpm_available, HSP_TPM_AVAILABLE)
 static DEVICE_ATTR_RO(hsp_tpm_available);
-attribute_show(rom_armor_enforced, ROM_ARMOR_ENFORCED)
+security_attribute_show(rom_armor_enforced, ROM_ARMOR_ENFORCED)
 static DEVICE_ATTR_RO(rom_armor_enforced);
 
-static struct attribute *psp_attrs[] = {
+static struct attribute *psp_security_attrs[] = {
 	&dev_attr_fused_part.attr,
 	&dev_attr_debug_lock_on.attr,
 	&dev_attr_tsme_status.attr,
@@ -83,13 +83,13 @@ static umode_t psp_security_is_visible(struct kobject *kobj, struct attribute *a
 	return 0;
 }
 
-static struct attribute_group psp_attr_group = {
-	.attrs = psp_attrs,
+static struct attribute_group psp_security_attr_group = {
+	.attrs = psp_security_attrs,
 	.is_visible = psp_security_is_visible,
 };
 
 static const struct attribute_group *psp_groups[] = {
-	&psp_attr_group,
+	&psp_security_attr_group,
 	NULL,
 };
 
-- 
2.34.1

