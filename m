Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95A65B3D4D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiIIQr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiIIQrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:47:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB760145FD7;
        Fri,  9 Sep 2022 09:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOlekUrbLM+JNNhLXp6qOuIdbMRRXJfiBWaV5mYuZYxRxg6d2Xmn6YI7EGsnTFYHBETZU2rRCXGFLd8qzl8oE9qayxBogwKD1C7mOvAaFTEOJxz9PSi0XdFr3VQceFx5eJw9+/uPWkcrV9cqBNp5Slj+2pc1sJl17tMJE9zKrHcAzt0Gk/EOJsKhba3dEcvt1mN0wt+1IeUrf35JcgRoR98iOT0c0m11e9hE1jCvW0f6CI2eL5iPU+fyVD7vcdDk+rhEH7w9rvVckDFUelMmCb1LDZjgQRIfRj8ncvHP7oFDK2qEYXUSRbvYaDTY7HsJ94FTAfcksveVWffKvdSGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/cGtf9+VESY5wZ93GklyFOBnmXyxals8K0wmhUcUXY=;
 b=XX0UlTebJ+VEVV/ar2ohqGc8T2I+uQrRR8CVKColWnH8LteNhdLgfJaZgMR6KxIh5DAH99rEzi1vD1kM1rUibD3VeTsKh8Z9hdyccDBOQyKFJgoqEFJcVap8YRyiLfsWOX1crCwovBdJ7Ct37j0ZYv9nK38+Kqlg1TPOPhIh47H6ojfTocP8GogPk83sVt2HskQpqZchUOcIT7VgKLZM6ocnVNQuYDC6FLoewbhhJuUO9bxiVCf/rdlhFVC7ItaQo7osK10zI/byD3ELZ0MFV8p0DY43B2IFww9KobUEdZAksYtCc0kyn5Wa6paIRYtY2ZBDp591SMSOgFBDpUZ5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/cGtf9+VESY5wZ93GklyFOBnmXyxals8K0wmhUcUXY=;
 b=qOQLw92GVafMSmHuHD/Sd07z13o/xGzYiKW2Rp1+wWvWzvC7SXYQ3vuf+TRGp4PZTWj8Fks1SOz0kzLjjpJkC3t8DcQBeoO6BrpIMp4AmbFnXnOBOyrrtMWEze3LFoLDh5OWSG/O/OQ3vrKjTwAQISRzjNM1A1nR4SJqen3r8DQ=
Received: from BN9PR03CA0361.namprd03.prod.outlook.com (2603:10b6:408:f7::6)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Fri, 9 Sep
 2022 16:47:05 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::db) by BN9PR03CA0361.outlook.office365.com
 (2603:10b6:408:f7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 16:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 16:47:04 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 9 Sep 2022 11:46:59 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 2/7] cpufreq: amd_pstate: add module parameter to load amd pstate EPP driver
Date:   Sat, 10 Sep 2022 00:45:29 +0800
Message-ID: <20220909164534.71864-3-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909164534.71864-1-Perry.Yuan@amd.com>
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 0acbfed9-cec1-439f-0def-08da9282ed25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w97IpLXTO+ovwcIfBrmkAs/0v35DpK0NxJFOMh7Eth5prkh/C5hBv0GaQmuUI5+LDAKNJ3bv3McfBX/2CQS8FLGOYa2hJ6BlZf7rUfp2elqft6QHbjvMESWLMj5qwtNXc4jmDGKZHJzLU8ys02g5xURBG3tXgrXBRLbx5+rNUfnRRD+qIKy5JHBdfUdW6xM1eqJf2Q3etrP2QKwyDoiwj6w26QqDHIYduh1WEkO/Zfe93uxCvxATglfhKlVDSSZ9dE1qWBjq2uiNFYAnlS7wMpYBL6JGrVIKIPJI4UIXDWVtDlLxSROEDCSbqRyMtDkhTiVCX+uCl8qC0YcY1eBEHGo8dH16OcqRsYSKv8vVIn5URnQFAwTms8+iTgV1StubzzlKvlTK+2EXNaf9GdpVC80B63qy6D2403JdTGsFLDKrQDGiNI1E6H/J3zFmmGZsRhUChmk2K3JorsU/28YfbZCrALsDV1MRBglxNo47hqiI42ecuf3frfbWr0lrRwSgOoxEv8GOVIgbpXssf7yIei81EM/uct27tKx2wZ44NtHztKbB08TA6Aq0M2HcdwiC+kLT3jXaqgdqiK2wLH/oMO1/qrxG4qEP7M5IuxdvuB1UktJ2xcvo9iIr9V8Kl7U/bHybFn6u+IJ6Ti4bbh4miwdh46pEx6kbrJTjbvkmXtOox09qL8F1hXI7I9U9WT18xmD6sE98oGOQLayUMMJ+iJSsjSfI5zvuq3gHz2J/Ypmq0CZL7uDW4+W/MvzhpA13+4i6pmJFlofMkkxwc+XLbA+a1oYa6kF98iGSgcJ6EbscI/I7lLA/YqQ99nvGDM7u91acHB2r5ymUeR62ar8bjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(36840700001)(40470700004)(46966006)(83380400001)(82310400005)(36860700001)(40480700001)(82740400003)(36756003)(4326008)(110136005)(316002)(54906003)(70586007)(478600001)(70206006)(8676002)(5660300002)(336012)(16526019)(1076003)(47076005)(186003)(40460700003)(6666004)(426003)(8936002)(26005)(41300700001)(81166007)(356005)(7696005)(86362001)(2616005)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:47:04.7753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acbfed9-cec1-439f-0def-08da9282ed25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amd_pstate mode parameter will allow user to select which amd pstate
working mode as booting mode, amd_pstate instance or amd_pstate_epp instance.

1) amd_pstate instance is depending on the target operation mode.
2) amd_pstate_epp instance is depending on the set_policy operation mode.It
   is also called active mode that AMD SMU has EPP algorithm to control the
   CPU runtime frequency according to the EPP set value and workload.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a2463f785322..451295284a26 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -58,6 +58,12 @@ module_param(shared_mem, bool, 0444);
 MODULE_PARM_DESC(shared_mem,
 		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
 
+static bool epp_enabled = true;
+module_param(epp_enabled, bool, 0444);
+MODULE_PARM_DESC(epp_enabled,
+                "load amd_pstate or amd_pstate_epp (true = amd_pstate_epp driver instance (default), false = amd_pstate driver instance)");
+
+
 static struct cpufreq_driver amd_pstate_driver;
 
 /**
-- 
2.34.1

