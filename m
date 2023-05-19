Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFCE709E10
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjESR3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjESR3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:29:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0820E52;
        Fri, 19 May 2023 10:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeCnaNHZ7WxrQzTS3iQjhN1TnAHC/WM7NFabKn2FxTo83Rk/QtuGENuDspwQXWcpEiDvdpk0SouPgBEDEDdS3vHQaG8STm6PL1i0UTAjNQR30h0CrWXccYNxHizB6gIHDOqWJ+JfHqFxaUMBkwuk00K0CwBC4p7M7lMiEo5ErLeMkpXoLQ49wthE6qhjRO45o9kDJeww1SoPwRcsXDiGyPvdv2AwacJjkAZz396sD/uxU22Lz2BPoeUPuW+ckOoBu7WxBMHCBRb9/0l9gjpdx5izXZeSLwRbhHlbzkxOFldP99uBkBbYaWCE0btIlDXXQhpkC1ELX7iNEReD8yW6vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McArOqsmUatZT0/1PIvPXrql42CsdIl3qB5N0XrfNIg=;
 b=RV3o2DvYBwQmFDFz56n76cTYmg4pf6or0kSIYeV1T6ySsFt+g5Bpx9D+gCY6g8IGyktOj+sydHRAHhG8xlHzLEOPAG0k1dWY2OipVctz3GVV3CrYWlKsj89yM6UxQ5yrXTxVFTN9o6YErRYXwPb9TAZ6YZAfr1JX0mYjEpY6kGjbW8sU3w6nm+uZuWWxpL/raVj/uuRvlYKmWmV8kzNtIbdrfxIdXK0uqAKa2ALi30J+tS8bQl5vRsbx88huzyTinI8RvvM4o5QOUs23VoK36fl60wtxSbbF1saG90coz1VSRKKK0LAP6ld7raUzPPWm5OkT6Hi5IW5G83JF5V/3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McArOqsmUatZT0/1PIvPXrql42CsdIl3qB5N0XrfNIg=;
 b=e85q6l3hk8XXlVSlrcwgcoKb0xV9HP08Zfs0/IOKY8A9EXl47aBZ8ac2OGkI2E0Lfk7dVFiggLywrSdt0z9+n0THn5nErwQWzfATyw2TZDAlA7yEcOQuc4VEC98yG0gii344/mcd2qHfHDH1g2phJo1Ui8bivbfkW1IBiwom7os=
Received: from DS7PR05CA0013.namprd05.prod.outlook.com (2603:10b6:5:3b9::18)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 17:29:01 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::32) by DS7PR05CA0013.outlook.office365.com
 (2603:10b6:5:3b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.6 via Frontend
 Transport; Fri, 19 May 2023 17:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 17:29:01 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 12:28:58 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     John Allen <john.allen@amd.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 01/10] crypto: ccp: Rename macro for security attributes
Date:   Thu, 18 May 2023 22:24:39 -0500
Message-ID: <20230519032448.94279-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519032448.94279-1-mario.limonciello@amd.com>
References: <20230519032448.94279-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 429cc0b5-f168-4ee6-2567-08db588e895b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBaJb/hbPJI2UytMrXvrkML55kLb13wj/dvZHhXuUFYcJrwsMb0jbe9J9Z9xCMOB7GUxgmbruAeVmlTH4q4yMc8TOf38jBNUBdkWemw68/aQy3b8Y4Yfl9P0GGBSIXwr3k301N3v8w7EQnSgTC69FwlmATZPtmA06fVYpd/+v+wm0D3gL7rnZx97636n/SxfqeLUfAbl2VGiAQmvP1boexfIOHBOZPkUOc+n+VFCgeh+tLVo33qy3z2v/eny2Jh1z4dAinfMtlE7C8pqP2v5XmMb02n5QDnr/ymCLk5fAvBKQHPAjijKtoXnR4J5pTbW7hVykyn/mwS5kRGRTUvzHy9nYFTsVDFz54BYlNmfQ0BKNvTbPRXU3CbhauhcewrvqvzWbar/Hky8SjDzgiO+BkcBtXr5Pwz4BGuvQH1v/HK+AiMcrUGevVFokL4dIwx25Ag8eJan5LV6dSOmtCSvAbCir1WOHxYFTw5VOOJwMwTvjvDAbk4N766fi046oBH/1cjoaECjRlQ5a5YQmTyk9AdEOaLiBAVsDo5lCRtw13Sf79HnI8WmZ3ruHN9qzewAObnyzrp5TpJIxVtGWmdZmVDbwl17P4TxvADkVB5b8cJByN3r7ANx14rJmTxHxaI1ajz5QwOnkuDuQoqqWTwYzea6Uv8Cpbngfm2wLGYQDZTHbEUIAf4PxX89NoEdRC86qjXa/DrLNCDvN8U27cmYw/yhXo67RcASN0lbo5IUxtNcGmXxiU+sPaG0X1sohwhTXsUwyQ8W9rEU8LSgGF54og==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(16526019)(70206006)(70586007)(4326008)(110136005)(54906003)(82740400003)(8676002)(8936002)(40480700001)(478600001)(316002)(6666004)(41300700001)(7696005)(40460700003)(2906002)(86362001)(15650500001)(81166007)(356005)(26005)(44832011)(47076005)(2616005)(83380400001)(1076003)(36860700001)(186003)(426003)(336012)(36756003)(5660300002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:29:01.5484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 429cc0b5-f168-4ee6-2567-08db588e895b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
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

