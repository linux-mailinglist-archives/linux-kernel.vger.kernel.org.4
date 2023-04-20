Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770D26E9990
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbjDTQcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjDTQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:32:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC3EE60;
        Thu, 20 Apr 2023 09:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8He5kvcahhzvUmdWcD34foyPxxxrtJnB4tPVsAAtwLJWXPJsxYYn0XVlmB3QoWTQNubWcW7kmUAI6RvMrbywn4gSSOOkGpQlA1L6qo1Ns3FymoOtg4RyK1UWOiG2U/LMTh9tVVDPNRRttWDPvXK2MziK468yWOcIkCxfTGi5YCMVvNUx0w9QRZ8uivk2yuvpCRBaZdop7qkj7gvjZdzLoPdc15bkmiAz5Oq6C/O3i9t/e/TfDc67QDFgpUgMWu5D8W6FDWvI7o/mc/Q+lGy4JOkOS/EoU3gMVVEwdL9tSHeKhtmXKm61wkQwkiMv0lz7uPhXyPKEjMlZPfglu3UBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tT9pMXjLl6E+ougnM0VBeecJpTqYTp3ifuOyQ+Nqe0I=;
 b=i9ZsG6/wvfwc2feY36bU4CftRfnyfIJ1CgzmUP+cRkaenbuGMA9/MKbEYpSd8PwAFD1gq9PxzkLW89EGg8iKtYQ94/lP1wYibBVpi7Ey2rrqVkTF/yDE7phbFRWMh2eQjAgkL4Ekv6Q/54W+MjBpEVekO/7Qnj6vO5Ch0Q0obso0SrdpF278aa97L9j7KuDMJkWd9hbbewF93bsNJd5j5u1vTUTI2tAjBXfm3UIkwRDIbKsbW5NnUS+xqtoHt3SaB/Hno9W9om9AeGGJ/IGlty/vDQ9ZzYILU5FGEt6dxjfHMvN2FSA8ZBcYm4GbTHGT9yh9j9MQOIJpI8ZAdFcNmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tT9pMXjLl6E+ougnM0VBeecJpTqYTp3ifuOyQ+Nqe0I=;
 b=zuRZSb3jnwPj3ehMJVV8Kn6bCStFa+jfjpWaHpNN+ArakT9KbjChlqCf7upsEi1N19Xk9Bgp5g+zvANrCjRQrZ5j4AuOd2x7g1glUHsFOIWS2eniPTW70q4mjXRk/QMWYGrtobBH7BXkYc3x+bTM6rCI/RLUg54ur7xiOfTinhI=
Received: from DS7PR03CA0340.namprd03.prod.outlook.com (2603:10b6:8:55::21) by
 SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 16:32:04 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::6f) by DS7PR03CA0340.outlook.office365.com
 (2603:10b6:8:55::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 16:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.25 via Frontend Transport; Thu, 20 Apr 2023 16:32:03 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 11:31:58 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
CC:     "David S . Miller" <davem@davemloft.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/10] crypto: ccp: Rename macro for security attributes
Date:   Thu, 20 Apr 2023 11:31:29 -0500
Message-ID: <20230420163140.14940-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230420163140.14940-1-mario.limonciello@amd.com>
References: <20230420163140.14940-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT113:EE_|SN7PR12MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 65426dd3-990a-4cc3-da14-08db41bcc5de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cOOAiOYyihBA4HrCWvoLsGyWy35D05UkMYiU0Q2zijZw1MIxAOIG7OaGeyKchB99rtuirHFimUb9lJ+InXcrV8iCEt7vuFFqDWXxKZRu/r+VA7KuxY/uEzrRvzDA/RtdPX+3m/L0PsUfvASsNE5Fj/LfX//yaaym61EJzlzNLvd49UIsRpg+QPlF3+LR0EQ24nP3pOTB8VgoOBpB38Z6l6BN9yr13FmOzxADt0VR4y7O0/UBIWjhlFKoF7L1Zg6neu1CvWniYrzU/uGrf5JvGHbHCduvy5J/TcH+kflAtr1UydDNZELHHupNOfwYIIQepnaY3r5BT0GuQVN23rZ3T5wPbpUoCyovk2Een2dBIJTv6GDMSzpAMnb1eDofPKWL1jzAtGI7v62rmOvAcZ5ltWIj3gr1t4Fls8oqODhFxAODey7IMruq+tKOWrwg1GF1F3dGvpZExLg12SggjrEJ8KArpajNF2WmvRNQWQcsEcnKuAbpN798A24CFlx6Q+sz08kNaPMcgaQV+xX0SysTv+BFW1VOmytzG1IiB4htV91ZMeV8feviF9Ydujw5wX7uvS32bOmL4uW39vjklavIV7yx6QvDIAhTpf6Z/UwkPsvbdE8DBBu95+sfDHDr2WH/raGd8rshcUavORgG6uDI4Vb6EYDHjYESbjAVB7tBhongvbKsWxuqTvVqn+eFFOp4YE8GwDR79ArMyKZw2oWUSQeVAeYq2WjwjXj3EC8mZRI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(6636002)(478600001)(6666004)(8936002)(8676002)(316002)(41300700001)(82740400003)(4326008)(70206006)(70586007)(40480700001)(54906003)(110136005)(81166007)(356005)(186003)(40460700003)(15650500001)(2906002)(16526019)(36756003)(426003)(83380400001)(1076003)(26005)(86362001)(336012)(47076005)(82310400005)(36860700001)(5660300002)(2616005)(7696005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 16:32:03.1649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65426dd3-990a-4cc3-da14-08db41bcc5de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The attribute_show() macro is only valid for determining the availability
of security related sysfs entries. Rename the macro to better show this
relationship.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/sp-pci.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index aa15bc4cac2b..85e3dc8853e2 100644
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

