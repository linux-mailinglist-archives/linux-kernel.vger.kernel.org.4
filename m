Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80077086D6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjERR2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjERR2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:28:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644581BC;
        Thu, 18 May 2023 10:28:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRTq6fMM6YQvbiC1KL8PTBz/3JZErGwrOuJp0/fKiukWOmbBwKNdFFXSMJ5BHsVDDf4UmJzPBzUuU/Bm9M9NUBJF7ZRpuY3Ugk3DkjqUUMLo/5ot7nrSoKL7bp2VRsd0XrGeGrOFI62W+NbDHtbYTPXgR5FIEKqurbOxdUmG4pKQe6+4T+MxWVV8wFkzbFuetA0SHOQlD5DyjoEzXFC+KuXiPZG45Ou83XwntATcZw3rvMd7VCMhcrOKRJnMkX6i0SniMtuvLLloEGAWVzSWBxccF6WTYHLsrAWfbStPl3uLQqIs8mEqlhMstDMvfhuufuctTPnBc54KdkMS+SaWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkyMYTdhqw5NUxIPYExhPEeI/HymK78oPliRaTqfyMQ=;
 b=bRVP3H59t5jkFbUFK/xvB6qdfHVeiCDFdf6XZMC7UWRaGc4sLDTbuorAjmcj+k/5OnFlqasG9N8fB0OBqD5Bgvs17uhBod/q/lrbWwoAGpbIeDib/TKYIQ2jPSxYhP0sTlZJUkzg/HMMO48DAUWWxL3S3kyxdHPLfzNhM2ovrTuzoDBlspPbeagfhu6qusdOJgrWklEss0BXr500ilb/N+FkHhlsdKAwebN1ZKj8WSUKas5djgYhjdMervQOPz3WCZ4wPszptRVqKtm2jrXsf7gQ9Ftm+rtnX62mI387LVHJDeRkPHrMMe4vbiNGdP4IH/bPK6W/B7eDzeNT0llpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkyMYTdhqw5NUxIPYExhPEeI/HymK78oPliRaTqfyMQ=;
 b=QAutLpq3vFgL7Dea6uY6MoFaJxqyhB5yy2HqJTtzorAZk+hynTFoTBxopaFN7g/YiUoKKogXEpVyuFn06/l7ly+36NqTPzKLt8sLtkYvUrQqClb8Dt3fU6BWAs2JmmyqWDol/j6DFoIjDnRauuPpnB2vwJctfqF42B7FJ0Tmzqk=
Received: from MW4PR03CA0015.namprd03.prod.outlook.com (2603:10b6:303:8f::20)
 by BN9PR12MB5323.namprd12.prod.outlook.com (2603:10b6:408:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 17:28:38 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::c4) by MW4PR03CA0015.outlook.office365.com
 (2603:10b6:303:8f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 17:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Thu, 18 May 2023 17:28:37 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 12:28:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Shyam-sundar.S-k@amd.com>, <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/4] include/linux/suspend.h: Only show pm_pr_dbg messages at suspend/resume
Date:   Thu, 18 May 2023 12:27:49 -0500
Message-ID: <20230518172752.93322-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518172752.93322-1-mario.limonciello@amd.com>
References: <20230518172752.93322-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|BN9PR12MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: c280f82b-d71d-427a-6eca-08db57c550a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: shFLmDzGsDeDPn63AAs1mGGQJFC13/2t3LR1xqldHgGwzSrEC0otXqD5QwCJAcpjHFhY/F/kOCNzgWCgr7DlAcn3X3kOaGoaSI5kHOil0P9lcIq8GoM8kkr1r2/M6cxmPIKm0l6/zF4TPsuaZH7+1oQqClM5ezpRFtuVLuSQNNP6Yhakbq4QC4aO3zzuO4xe7dgDnZNjlZA2ADPDoRf8zVWf8xp1sjsgOsctnh3CfJPV920so8LtJFmKljrCgNmrzOxC5tc5Psy/hlg6+DthWql3jDIGVQad4SRb/QtaHjhvsv0AcurrMiepYDKYCHEXwUFa/tKnR9Oopjk3hgjucQlCtIHJEzTyjvNLQNkKMFeKPwFLcJA4ksoX0i665lxGA3VX4QQIX0FqF0qLTVBlBJeOrhOlp6ZD5LFDlqPfQkX02nX+8v7txlydigHLlJNjuLbovC0PgU4oMJdWbWxLdQ1mN+BA+ZS/IOz+NzH/3sejiJPgdgSNVlo8rI5Bg0B6OmdU+Ji005JDuWznAL8VdJDT/UNVPhU9+r2xKlPv4jTUo0Iq0+JO4f5MmtCnnPpfj4c5gYbgkgUViEyNp3attAUmbJ1LyJs8nskTCkDsmS9dI9VT37qy1+ZMkzj3uY3rNixpxULOpqXffSSMPaFQTbcrem4/zxdEloZxXeyoe7BZTQ7TgiRKRuOPoC/UPJEScEY7R4mgAhykoxsT1puh71Yyjt9QbUCa/zDChUpH50a+30CPHapipR8WdeexrqE9UW14KYvGeD98OzBKm9qJFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(36756003)(4326008)(2906002)(15650500001)(44832011)(336012)(86362001)(426003)(8676002)(5660300002)(8936002)(110136005)(316002)(6666004)(70586007)(70206006)(40480700001)(54906003)(7696005)(40460700003)(478600001)(16526019)(41300700001)(186003)(1076003)(2616005)(81166007)(47076005)(82310400005)(82740400003)(83380400001)(356005)(26005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 17:28:37.4516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c280f82b-d71d-427a-6eca-08db57c550a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5323
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All uses in the kernel are currently already oriented around
suspend/resume. As some other parts of the kernel may also use these
messages in functions that could also be used outside of
suspend/resume, only enable in suspend/resume path.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 include/linux/suspend.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index d0d4598a7b3f..a40f2e667e09 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -564,7 +564,8 @@ static inline int pm_dyn_debug_messages_on(void)
 #endif
 #define __pm_pr_dbg(fmt, ...)					\
 	do {							\
-		if (pm_debug_messages_on)			\
+		if (pm_debug_messages_on &&			\
+		    pm_suspend_target_state != PM_SUSPEND_ON)	\
 			printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
 		else if (pm_dyn_debug_messages_on())		\
 			pr_debug(fmt, ##__VA_ARGS__);	\
@@ -589,7 +590,8 @@ static inline int pm_dyn_debug_messages_on(void)
 /**
  * pm_pr_dbg - print pm sleep debug messages
  *
- * If pm_debug_messages_on is enabled, print message.
+ * If pm_debug_messages_on is enabled and the system is entering/leaving
+ *      suspend, print message.
  * If pm_debug_messages_on is disabled and CONFIG_DYNAMIC_DEBUG is enabled,
  *	print message only from instances explicitly enabled on dynamic debug's
  *	control.
-- 
2.34.1

