Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387D86CCFA3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 03:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjC2BwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 21:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjC2BwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:52:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A5E270F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 18:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3MnHwJCs17lF2336iyATNBK4ALwOsAqRai5TjGGHpDHxRT3hn4ImzOZP/cF2pnBHomkPwlXjCNWdxudruuxPnF78pZt/DsrmkR7j+cYTV9DQNxTSocv3jvjLrcxZlSSYD/6bo+EH1h1L7EEedEpwViA1pHIH1l82g7rpNooWbfnZXxQyhNItHIut7qnPM+C0/yoXUAjnr5UPwJWPWkOpSGOXVjSCJP+PLE65IhfZMqU0BNE+PjNXaz5THSkDil65WQJ60T0jM8kWQuj/z1VqgZOzhL/+cuWBV/+n8NKcT5ym+e7xjG2tqkxtsnnSSF0E/9T7gjPwW6fJvuN85Hgmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoKjHgaz+O6qb9LcdbBmRo8EcqmvbtRPBBiNrkHl9DY=;
 b=Qhqv541z/pWX6rxi8QSvildpznS71Ygi72iBOEZRRsz6Vorboi4sJEifBjtiSBhMdS0zsYpIj5JyUD3JV4VvYmZOG2KsPX4VbAM0XZOWxIPJtsl+NAdZn2zwDxrIRRxYT++hItkzYLEywdJqk3r7RVg+UDu0nc0DgD/wUn1qDoiyYLWJNJEA651SXKJOLxDRWvx0bNoh0s2PCaAGyw0+e7KmMM8S8ap7ohcJHUCgCif6NbPF1x+88O3aiZXMHrxDkkRJwiVbViguBWkioCVAWnMOC/Yq7gveKRalTRRRYeds3HitwEIu/Wjerfj0tpP/6JcA3ELRr/Rjx5xxVP2Fmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoKjHgaz+O6qb9LcdbBmRo8EcqmvbtRPBBiNrkHl9DY=;
 b=A9LzA2InWveFNuu3io1fS5ks1PE4+40kI99FIcQVS/YtTS4xytWyxMLjSri0cZ0p0lx32A6oyQU6VYflTefFZ+EnOtnVkukZexiXw2FGP/fSnQowijPg+DaOUb3pQehHsWLmX8baUDthxWvg0lh5qvsa0ouiascK4yzmEx/+TlE=
Received: from BN6PR17CA0034.namprd17.prod.outlook.com (2603:10b6:405:75::23)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 01:52:05 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::d8) by BN6PR17CA0034.outlook.office365.com
 (2603:10b6:405:75::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Wed, 29 Mar 2023 01:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 01:52:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 20:52:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 20:52:03 -0500
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 28 Mar 2023 20:51:59 -0500
From:   Wenyou Yang <WenYou.Yang@amd.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <Xinhui.Pan@amd.com>, <evan.quan@amd.com>,
        <mario.limonciello@amd.com>, <bp@suse.de>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <kim.phillips@amd.com>, <tglx@linutronix.de>
CC:     <weiyuan2@amd.com>, <richardqi.liang@amd.com>, <ying.li@amd.com>,
        <kunliu13@amd.com>, <gpiccoli@igalia.com>,
        <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Wenyou Yang <WenYou.Yang@amd.com>
Subject: [PATCH v3 2/2] drm/amd/pm: vangogh: send the SMT enable message to pmfw
Date:   Wed, 29 Mar 2023 09:51:49 +0800
Message-ID: <20230329015149.870132-3-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329015149.870132-1-WenYou.Yang@amd.com>
References: <20230329015149.870132-1-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|IA1PR12MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: a14d831e-7859-4c51-5281-08db2ff832f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yflm0ZgqILXKEiibCE9w9WGdWhjHh57K8YPpxoH8/BRNaVlQXain2wKcLP2R5dD7c2gJqVwrjhy3jnrXhS7KDfrJnSb8l7abyX2PfBJI3EMe15oQ+Vphfi6laJEkcyxpa+QieLQnSHPBwfpul5HvZ42LtUOd7sBDn2h+37P4/Xq2MWu4QXoe47TcGOwW8K+3aPizYx0huikNdRzzl/WukkwOw4T5RfD0sgokGb1b211f/C2AvdEir2UO9cTF5Kk4B+rOeqB5YD/On/wSdw8KsuBJQIJOpBiuR3DMRrqXQ5rLz5mD3CcZXgWQtAZlPUTwQ6fta2vCmJY++DGJ0KoJH/yFaYb7kwsYaKaPyXaeyMwogHc78QKzvFap6ywNylCuZfv9xXy43qBhLckNyW2Wg78ZFXvVFU55xiOSbtrBZk5UcVbsZY3/Sf0XBGVBqBqDwHgL94wc5YXb9BSaxIcKF5WB/iuJ0iSbspjeYd9eyCDOy7WQrh4V1AunG7E9c49R1xN/w6ddGfh91jgPAs5yHNsiHhd66b0GzzhHGrR7RYFUNJXZwczBbcqsB8o33S62yx7QHhAYzNArR5tIsbO0t+iMPNz6kyLREPCMgDtzyaQS3RAJvgzAajJLMbpEgSGpMpfzHOuiwTVjHXdWoOkh/LrMEi6N7URe/dqU6G/NCCK75N5vJncyFV5QTGxTmhrASMKhRdROV2Sv2OAmhVWOGsE3QpPQ9S5JJI0lXZ5/bpFwO9WsLohRM/6pOt7IhOWe
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(7696005)(6666004)(1076003)(26005)(54906003)(110136005)(316002)(478600001)(186003)(47076005)(36860700001)(83380400001)(70206006)(70586007)(426003)(336012)(8676002)(2616005)(41300700001)(81166007)(8936002)(5660300002)(921005)(356005)(4326008)(2906002)(82740400003)(15650500001)(40460700003)(40480700001)(86362001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 01:52:05.5180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a14d831e-7859-4c51-5281-08db2ff832f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the CPU SMT status is changed in the fly, sent the SMT enable
message to pmfw to notify it that the SMT status changed.

Add the support to send PPSMC_MSG_SetCClkSMTEnable(0x58) message
to pmfw for vangogh.

Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  5 +++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 43 +++++++++++++++++++
 5 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b5d64749990e..d53d2acc9b46 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -69,6 +69,8 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
 static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
 
+extern struct raw_notifier_head smt_notifier_head;
+
 static int smu_sys_get_pp_feature_mask(void *handle,
 				       char *buf)
 {
@@ -1122,6 +1124,9 @@ static int smu_sw_fini(void *handle)
 
 	smu_fini_microcode(smu);
 
+	if (smu->nb.notifier_call != NULL)
+		raw_notifier_chain_unregister(&smt_notifier_head, &smu->nb);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 09469c750a96..4d51ac5ec8ba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -566,6 +566,8 @@ struct smu_context
 
 	struct firmware pptable_firmware;
 
+	struct notifier_block nb;
+
 	u32 param_reg;
 	u32 msg_reg;
 	u32 resp_reg;
@@ -1354,6 +1356,11 @@ struct pptable_funcs {
 	 * @init_pptable_microcode: Prepare the pptable microcode to upload via PSP
 	 */
 	int (*init_pptable_microcode)(struct smu_context *smu);
+
+	/**
+	 * @set_cpu_smt_enable: Set the CPU SMT status.
+	 */
+	int (*set_cpu_smt_enable)(struct smu_context *smu, bool smt_enable);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
index 7471e2df2828..a6bfa1912c42 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
@@ -111,7 +111,8 @@
 #define PPSMC_MSG_GetGfxOffStatus		       0x50
 #define PPSMC_MSG_GetGfxOffEntryCount		       0x51
 #define PPSMC_MSG_LogGfxOffResidency		       0x52
-#define PPSMC_Message_Count                            0x53
+#define PPSMC_MSG_SetCClkSMTEnable		       0x58
+#define PPSMC_Message_Count                            0x59
 
 //Argument for PPSMC_MSG_GfxDeviceDriverReset
 enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 297b70b9388f..820812d910bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -245,7 +245,8 @@
 	__SMU_DUMMY_MAP(AllowGpo),	\
 	__SMU_DUMMY_MAP(Mode2Reset),	\
 	__SMU_DUMMY_MAP(RequestI2cTransaction), \
-	__SMU_DUMMY_MAP(GetMetricsTable),
+	__SMU_DUMMY_MAP(GetMetricsTable), \
+	__SMU_DUMMY_MAP(SetCClkSMTEnable),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 7433dcaa16e0..07f8822f2eb0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -35,6 +35,7 @@
 #include "asic_reg/gc/gc_10_3_0_offset.h"
 #include "asic_reg/gc/gc_10_3_0_sh_mask.h"
 #include <asm/processor.h>
+#include <linux/cpu.h>
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -70,6 +71,8 @@
 	FEATURE_MASK(FEATURE_DCFCLK_DPM_BIT)| \
 	FEATURE_MASK(FEATURE_GFX_DPM_BIT))
 
+extern struct raw_notifier_head smt_notifier_head;
+
 static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,		0),
@@ -141,6 +144,7 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(GetGfxOffStatus,		    PPSMC_MSG_GetGfxOffStatus,						0),
 	MSG_MAP(GetGfxOffEntryCount,		    PPSMC_MSG_GetGfxOffEntryCount,					0),
 	MSG_MAP(LogGfxOffResidency,		    PPSMC_MSG_LogGfxOffResidency,					0),
+	MSG_MAP(SetCClkSMTEnable,		    PPSMC_MSG_SetCClkSMTEnable,						0),
 };
 
 static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -221,6 +225,9 @@ static const uint8_t vangogh_throttler_map[] = {
 	[THROTTLER_STATUS_BIT_TDC_CVIP]	= (SMU_THROTTLER_TDC_CVIP_BIT),
 };
 
+static int smt_notifier_callback(struct notifier_block *nb,
+				 unsigned long action, void *data);
+
 static int vangogh_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -477,6 +484,9 @@ static int vangogh_init_smc_tables(struct smu_context *smu)
 	smu->cpu_core_num = 4;
 #endif
 
+	smu->nb.notifier_call = smt_notifier_callback;
+	raw_notifier_chain_register(&smt_notifier_head, &smu->nb);
+
 	return smu_v11_0_init_smc_tables(smu);
 }
 
@@ -2428,6 +2438,12 @@ static u32 vangogh_get_gfxoff_entrycount(struct smu_context *smu, uint64_t *entr
 	return ret;
 }
 
+static int vangogh_set_cpu_smt_enable(struct smu_context *smu, bool enable)
+{
+	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetCClkSMTEnable,
+					       enable ? 1 : 0, NULL);
+}
+
 static const struct pptable_funcs vangogh_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
@@ -2474,6 +2490,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.get_power_limit = vangogh_get_power_limit,
 	.set_power_limit = vangogh_set_power_limit,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
+	.set_cpu_smt_enable = vangogh_set_cpu_smt_enable,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu)
@@ -2486,3 +2503,29 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
 	smu->is_apu = true;
 	smu_v11_0_set_smu_mailbox_registers(smu);
 }
+
+static int smu_set_cpu_smt_enable(struct smu_context *smu, bool enable)
+{
+	int ret = -EINVAL;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->set_cpu_smt_enable)
+		ret = smu->ppt_funcs->set_cpu_smt_enable(smu, enable);
+
+	return ret;
+}
+
+static int smt_notifier_callback(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct smu_context *smu = container_of(nb, struct smu_context, nb);
+	int ret;
+
+	smu = container_of(nb, struct smu_context, nb);
+
+	ret = smu_set_cpu_smt_enable(smu, action == SMT_ENABLED);
+
+	dev_dbg(smu->adev->dev, "failed to set cclk_pd_limit for SMT %sabled: %d\n",
+		action == SMT_ENABLED ?	"en" : "dis", ret);
+
+	return ret ? NOTIFY_BAD : NOTIFY_OK;
+}
-- 
2.39.2

