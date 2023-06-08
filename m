Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027217287CE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbjFHTM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbjFHTMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:12:46 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF8730CF;
        Thu,  8 Jun 2023 12:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUAlGrSgrREu2kMHVGs1b89GfY3Db81OFUHexEv/a71u9YtpqbCNoF7KZBaZ26uZer/CnWrULXpNnLzmkjEXdALU8S4cM4QI1TrGIslP+CmcC2Uh4e5wf80j+hChNO1GDgodhiBFDWVyk0N1N9lEOpxvaRizchNwQAoYQuQMk+C0ZdJtD3DgKPmdYA1NwyqvUinCPkDkJOLFHs2iIdxk5Ae1eGbxgpNB9RrpTYRk6uf73NO5HxRHosO9nZwvyg+ZzU/SThvxqa7MzrkAM1GaWzq9RBLM5dHI7LRNWhN+gjqWWRqlXNzopwA6mGAl48gALiwIoRdjRf7ez1Bsw+teog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McArOqsmUatZT0/1PIvPXrql42CsdIl3qB5N0XrfNIg=;
 b=gRujwRXRuX/xHCuw6Ck9ypUkYDd1ustYbw4DxrJJC8hh6izjC8i+hRn9mINJAr1W14UwbM5neJ+1Huq6T6iaFR/LnXRUAI+qgooaD8zVsrkuodLajRH+qGRg0sLv6v4AuveWY10r8jFKn+vvBNMON0gEbf7VKbMteWCQhl52Hxs/A1l2jN0kfEC1oPeMskwANZPqS4z/64GFswMGlttbIrwhNgTOuy8pPSaxRGcHY0dZsFeDWe3ijZcLSPhjfmnuKzk/82DT/xIzt1SYzQzyc1WCjn6WdWZ9qL5hk+9UCyDbguHZxyxLHJ8mJMh/N31cB3xhSZ6WpIbMRZ183YWX+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McArOqsmUatZT0/1PIvPXrql42CsdIl3qB5N0XrfNIg=;
 b=PQxVwu9MRfXrkPuCSZMrMeeXcNLeoG4hDMTuhkSCaXgj/rhOI+B9obVhxZeMfH51jhU8DC0n+qAU1zEWMVQqZC50IXvmeZQjNN4vrpbfQQwzV3b4OOQZ1dqpNoXXFGkfmQd1PPirPQUohg/IV0U+goWVZAQT0QgTh+U2d5oJY+E=
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 19:12:30 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::b) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.26 via Frontend
 Transport; Thu, 8 Jun 2023 19:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Thu, 8 Jun 2023 19:12:29 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 14:12:25 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 01/11] crypto: ccp: Rename macro for security attributes
Date:   Thu, 8 Jun 2023 06:17:47 -0500
Message-ID: <20230608111757.32054-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608111757.32054-1-mario.limonciello@amd.com>
References: <20230608111757.32054-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a37ac1d-76e5-4b06-2dc3-08db68544dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlYagklosJbBLF0ad7Tqe1fS9ZXrr7yXIau0nVV9mqo1Z99JjHImR7v9+yUmpzr4ZzTGfWphAAxhlG/20FJ5tJhD94kOj+fU/SY56UPbIvcD2TEUqbtsS3+imhmnVmKPddLB47PyTnd8QuDd3+Qt55fKOsK5LQan+GdvJgFjLyCFNSqoJxHVc48xkmV2sxd+W+elQCqYYn+4s/ZDXpme1Ddc0vq04xat94MQC0Hmkx6OOstKcJhcSeDS2inKpGisV00sWqFLA/Y7MTwahz9xn5s4utGa9hTQf9635Q4GPrwBuc4PHaEbqVoeVnFACJNvFfYR45BzxSs0SGyetmIRlmQvRRgsFw5TgppRSmE8m81VHbm7MoaUL1AKmNz7M2UClMYqN5VlI6NQBUd7/XN06Uwz+13UrWUOAXNM/DTnRy8JZ8yQ7LslBn/XYXClYJph/8bnBheygD8aAdmYTGAW2iqtVs5fmYwEBDYzc+jqDZUlFZItPHKKMf6RVXmVAZNhXhoR7tSry3GIiG6Nyfp3s82QNWt/uH4DdAP+W5jQoamGcEp7zxWqNs4QbjKURmU1Fye50tIW/2yygqTPPz9+M8igF5ad4FLbJEtFtQLDFFE0Kb3vv42S7jOSDdNRio6vv38hMhJePZcW9PS/mQ54PptbewrA+hB1P0vqZWl7DaAmR9sP70fiUbN3InMndHMTws9ripDB3p3zWQE6ht4M+5O5Cm0O/01ZuCZDVPCnlkqkDTDqq7JpBtGaWHeQGJTaKyvFP7MqAP5AwKyCB6aKUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(7696005)(6666004)(81166007)(2906002)(82740400003)(356005)(70586007)(70206006)(54906003)(36756003)(110136005)(5660300002)(44832011)(8936002)(8676002)(86362001)(41300700001)(4326008)(40480700001)(15650500001)(316002)(40460700003)(478600001)(336012)(426003)(2616005)(26005)(1076003)(16526019)(186003)(82310400005)(36860700001)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 19:12:29.6696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a37ac1d-76e5-4b06-2dc3-08db68544dfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Pick up tag
---
 drivers/crypto/ccp/sp-pci.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index b603ad9b8341..c8f075a7f49f 100644
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

