Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16B46F1E42
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346270AbjD1S4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjD1S4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:56:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600C930D6;
        Fri, 28 Apr 2023 11:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5a5tCTKlA58DlsZY8aPWoKCU2FYfL4c7iqUauaI8f9hIUM/iFiRtRN4p+Ad+uWbdzL2+leG5VSaOA0RUkC2sNC4f4swB+W2tnql1S+SSMZLYx4OUI2lYGAXzD6OQJviPdEDoVhTfEVHBFgYBI4ev2SpgjO4Q6pczgoxQJ8ppQNcsugEixbsPKCgX3jFucueJqB0XGvu9t6FYnuVvKk1FXmiUNTGmNfoHPmM5WR5AUr+pOYlbADcWnC/1I4rPff/McRb2eE/gmxqtrndZgJQP3WMjuecYNGCYF0PK2NEBABWKeODcA1E9zemuZv1mXCMQjNItesmuyiQKJxu+nbvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tT9pMXjLl6E+ougnM0VBeecJpTqYTp3ifuOyQ+Nqe0I=;
 b=LmYnFa34qnGcQSV5pUGA/vd4IYhXWEgnsBX4/xEPKNtdLLS0qYQGu/sKbVsWbQI1ke+odHgCF9FwrPzS73/BZ5w/CpmZfETK+y4g4z/XuQbWSOueH2BsidnPt6RMcHunDEFkX02BzlN0jRbiQOoSnL43jvVbQ63Jouzr81oFf2iqxbBxFqmubWPw+ChPUnUCUPx1+wELYMO0bVwtCTm039FWQoWwF/+Mz4cC01aiDl8znhGKKOL3r1HEkqYXfAd5eUqGyI96iiTTaMKcPwxHEoqEw0zfDixJbn0YJhYYY2/u5RtKmLk+WehMqc0MZhTjhdtenMJWyjqwY34knsxlmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tT9pMXjLl6E+ougnM0VBeecJpTqYTp3ifuOyQ+Nqe0I=;
 b=tfqb0Svrtv8kDaXVpNnRS5krd1Pyz9W1RxCkzR0tRu+RwwPXh4Iwf9y4xGfu17RrP/USDmq1TRob68gyYjLDXjGXbSN1U6IogYsgCo2brfIF2OArWVDg18j6didlJbx7jwIeRYcjMvRiXGq3Wm/apgrFucQ3B4ZrRt20g1IUvsI=
Received: from DM6PR02CA0120.namprd02.prod.outlook.com (2603:10b6:5:1b4::22)
 by PH0PR12MB8797.namprd12.prod.outlook.com (2603:10b6:510:28d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 18:56:01 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::20) by DM6PR02CA0120.outlook.office365.com
 (2603:10b6:5:1b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 18:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.24 via Frontend Transport; Fri, 28 Apr 2023 18:56:00 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 28 Apr
 2023 13:55:58 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
CC:     David S Miller <davem@davemloft.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/10] crypto: ccp: Rename macro for security attributes
Date:   Fri, 28 Apr 2023 13:55:31 -0500
Message-ID: <20230428185543.8381-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230428185543.8381-1-mario.limonciello@amd.com>
References: <20230428185543.8381-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT042:EE_|PH0PR12MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a1398b-7fe0-4a4d-f878-08db481a35ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57UjEe45Qm4W2sI/ljlgc5+ATqtq0EsQJUCUT58m/vKX9j9nj7gV+drDlOQ2VDr80DBfJyjWfCvXCAg49pN03ErZ+3bsCHeuFEqwV9zMAc2c7T2WP9okugDnolNX9a7XZ5UGJm9jglKFzhZYczxYJJdsYT2sFGzgwXcIrjwXz6Oqv1cH3lr4hj7QBmyA27pgiWHQ6Jp71eyU+aOn7U7Ta8GvDqZtI9FTlqrUd3QqjrjfSSlBwehH2C1YpVEHd4B907PSGdB/vlB/cGuhl78d6jb6YhLA0LzPwZQiBF0AcBI+YCtLGDVtN7cyKGejUmIK3NM5tR4USWZNaqz85RQP1aUDk9YchUhMAT9KzxyAlTGIK+Y3aVB+4nF5kZb12Iz2dLwDZvgPe5VtwUKRVJUvA1H3d/gy4Uv647IAOPy3ALqXCirV/o4VDRZYGZ7/oG6yzNh3w22o5USW1pO6iO/4n7N+vew+jiQ/rlJ7AUQFzxltVxgVRzEcg+DKxf3ggBskSklwV3ljiETiZ6wXdUOVpkuwGmFJua2VWnEGSdartjkIIsOytcB18rRc/01lm2bvW0/z2/LLADSE1kF2zXriAbGdDaMgku2Uqvh+Vl/9n9VPWcQFDKJnMh8kdea/ZgnvRs2o1oR4LL9TK5t4cQQO06/IRXWMYC8guWuOe9h2a7Gdfb1HREfC84bGD3flX8+Idb35hq/3xGCoMYkO3ooR8ZlyCRZw0E6IE/2YDPtsrBE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(110136005)(4326008)(54906003)(6636002)(478600001)(70586007)(70206006)(316002)(41300700001)(81166007)(82740400003)(8676002)(8936002)(356005)(5660300002)(336012)(16526019)(83380400001)(2616005)(426003)(186003)(6666004)(7696005)(36860700001)(15650500001)(26005)(1076003)(40460700003)(36756003)(2906002)(44832011)(82310400005)(47076005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 18:56:00.9284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a1398b-7fe0-4a4d-f878-08db481a35ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8797
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

