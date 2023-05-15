Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179B9702B98
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbjEOLhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbjEOLfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:35:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296291991;
        Mon, 15 May 2023 04:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVFFf0AJj7XdlJPQTY55cUXwDdTtjAvGmeolvZ6n81IE2p0vic6pgMb4qUBkJyqdp9cEoJ4nVwobSG5Pma62UdXgeSHThdq6DeoHk0VAiXvunJy6Z/+oa5JlS4JG062XIhkMK4au+C16oTFBVETIz87TL5QiQHva6CPs8+slNIhGXe5aYTpKZWv1vmEEUUnTwO1xHl/Z95wfrFIc8ihomRPcp/dzLRwtA5Jpxd5n6LX7TuLgRpOe9uAvJqz7RTy9qjYtC5Qi7Dq3z5Nv+zaX+TE2xM8PNdVUqredIjIj3az8SE7uISflHuKmzt7tahnBU0uuY5zPvJg61R7S98VWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8vn2kJWHEK5e0ATd/My3k14ECtfs8la16zk511ewbU=;
 b=HAihfIbDoo3r61TSVsHt+bxeBZAu5rk5THvZ3ImzeyHZ3tiev4UlyC3PhIHbP4q4bDJZYPo+rlB6nV0VNrCT9SCX5O5VjTJ4lnBx4FREpxVEFeXUfMgi0UKWQQdC5EhaMpb1uHFG28HmuUJI4iywg3RQT9BTJszEmD9hbwHd3p1WV8KMWaYjJnVDuoK7ZRVsNP0sRRZx9l++qHr1pFcG5wXn4m/BQwktUxO8I0JSIG5rguZRdKMNv+3sGTXAYbYFzCBd9LLODcfe+JsPC7Rv9zUxAHa3ltNtygCB54KSCRXUlhU9HZQk9GFF0bL1zraSQdnFVAGA6/jEte7bOCRtuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8vn2kJWHEK5e0ATd/My3k14ECtfs8la16zk511ewbU=;
 b=FIQmOvGDBLLRwLd7a8slZzkTRaGbUxJqVfpZSGSIDQ7fy5GhxhCcJ0JFqfQK3YRLJGQ4nu7w/4JFEtwMjGdYbVj3hc72Iii8xb/CgkSf4xDrOCJcNr4dBcsiM3LUVFdikJ02ha20689tPhlw+EBEOOxvRx4sIGUr5gtsk8Q4I0U=
Received: from DS7PR03CA0245.namprd03.prod.outlook.com (2603:10b6:5:3b3::10)
 by DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 11:34:21 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::9e) by DS7PR03CA0245.outlook.office365.com
 (2603:10b6:5:3b3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 11:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 11:34:21 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 06:34:18 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gautham.shenoy@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v3 0/2] cpufreq/amd-pstate: Fix null pointer dereference when frequency invariance is disabled
Date:   Mon, 15 May 2023 11:34:02 +0000
Message-ID: <20230515113404.4259-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|DS0PR12MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: dfed1197-ce55-41f8-17ad-08db553853ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mm37h8KKXBqS0+vAT/Xm8ZEJEku0Htd4o62Vkm5fILKfBr16GoD3cex8NjxNp0wXPItVPOMgjPtoYFgKa8spR6nsR8/uiBb8SO9ZrArRYgRR/y62sNPs0zOhfPWiqzSiFnM3DQCbMfyYGp9IIsnlIOcxdxdkkp/mVLaMZvECPJFtOhZW8nQ+p0pQMO2+kSmidVATHQ/5IamDfOmeVruMgKiqo46X2ZS+K6Cb39FP5x6Gyx5DVdzyKvOfSff0Hi50eq2LT1FsI20Mu8Wd7d3NG/n+XrTtD4OI9f37TNA90ZcZHWCGXawAHFtveQX21Jkmu9pz23vKk90iNzM+ZmSgfTxwbzVeVEMe1V/dEzAgNEkLu6/CtxjNIAxNFJhySTzaPyvySugMNQOBCdz5eW2YfVAYRnYSIK/QFgw+s7oJkKMa162cvUR88K5YtSCbqcCliBazW1mloixp99eRm+yFQWrkNhQHUJV0IIQC/omThTTNaXmS+48VPQNZ8S1n5D9LsE9JC7lBchmVl/1cClBUBcvtipcSa29BwlRJHWgB7wHqbgW4idlK6LhO27DPpWgQ1D5p1JZ11NfXyFKuL6Yk9mByBg2MzaXLJcLOfNGZtUJx/509LqMFCKgBh7+bDg3KIGPwGBCb0jLcHi4sPUz48fuwJ/ppqHmuOZWnZ7Zs3PsMnB0nkbI39gBNIjGUq64/cAOrs7mVlJuOT2S+/x79rIF8d9tXh/zbHYYi8oWpj90ba+0G1Gcn3rFUHeAFHBu3O1wZVLJ52vKA/1cKWD4EuWqHDANMliwzfY1o6kMNPBp6NPkFskHBhateSfp+JH8i
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(83380400001)(426003)(47076005)(966005)(336012)(54906003)(6666004)(478600001)(7696005)(110136005)(2616005)(26005)(1076003)(16526019)(186003)(40460700003)(44832011)(2906002)(36756003)(4326008)(70206006)(70586007)(82740400003)(41300700001)(356005)(8676002)(8936002)(82310400005)(316002)(40480700001)(81166007)(86362001)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 11:34:21.6786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfed1197-ce55-41f8-17ad-08db553853ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, amd_pstate only uses `adjust_perf` and `target` callback
functions to get the frequency/effective utilization data from scaling
governors. But the governor can switch back to fast_switch callback when
frequency invariance is disabled. In that case, if the driver didn't set
fast_switch function pointer, null pointer dereference can happen and
kernel will crash.

Currently, frequency invariance is turned off when any anomaly is
detected with aperf/mperf readings. Which triggers this problem.

Fix this by adding `fast_switch` function in the amd_pstate driver. The
same problem could arise with intel_pstate driver when the driver is in
passive mode and the governor is schedutil.

Additionally, display a warning message if the scaling driver sets
fast_swich_possible flag but not fast_switch function pointer.

Changelog:
v2 -> v3
- Add fast_switch callback in amd_pstate and warn if any driver
  sets fast_swich_possible flag but not fast_switch function pointer.

v1 -> v2
- Remove fast_switch_enabled flag dependency for adjust_perf callback

v1: https://lore.kernel.org/linux-pm/20230410095045.14872-1-wyes.karny@amd.com/
v2: https://lore.kernel.org/linux-pm/20230509180503.739208-1-wyes.karny@amd.com/

Gautham R. Shenoy (1):
  amd_pstate: Add ->fast_switch() callback

Wyes Karny (1):
  cpufreq: Warn if fast_switch is not set

 drivers/cpufreq/amd-pstate.c | 35 +++++++++++++++++++++++++++++------
 drivers/cpufreq/cpufreq.c    | 18 ++++++++++++++++++
 include/linux/cpufreq.h      |  5 ++++-
 3 files changed, 51 insertions(+), 7 deletions(-)

-- 
2.34.1

