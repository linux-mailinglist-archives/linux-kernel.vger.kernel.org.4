Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4940468283B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjAaJHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjAaJHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:07:23 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5D649010;
        Tue, 31 Jan 2023 01:03:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqSpE4cg5C99W31ND4nFI1n0gwAzyZRO4YQfLYLmjGQBV+xc/DFLxQ5eqk/moP/bgvkGtmZJE52Qq42ULgc2hE897a7DGRpfmwTHOGPk1CzmN+8SSrfso7PIL+D5hO1YqC2u4P91tYhcPasWrVSHwkbAPkmUCDPX5breScheMokbpMnQ+hblbFN/gmjUdZStH6kQOX8C1FlxICQiw6kzxailbcFjkOfhPYBx2MIXpxNY598dX76EkaY09Vq06d7hVczlHV2mrj1IAo/m1H1lOVQjN5u9P8DdUl1O2BBprG5QPAxTd2CuwhrZ1UrCcrXlSUAHs+oWn8uPk+PIUwnkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmm4ywHS4JzGivsVlQvG68U9p0Eu7vANkrG+JXG3zcc=;
 b=UW/YTFzdM63Nf4OUSAxVjCrD7wMjyyXARgcJ2EMKNXgan0ePMaZyaznwyag7BaS1/sBrlo07M82wvRcbdv+PSP6wZbwUDXgE7GPmDMZrZUcELyFah/hbikuzFbQXoD/nub0tOz9xBRerh7r49EicJ7J0XiWJUq5GiVVkH4OZokwdsQ7KD78/ru3r9rVoGGPVN7smDwgQCtYu1fYByRubn3Kh6yhHVV81Dhl6h8+IR6sr/1x3Z8V/r6eIurnKXlT/mhybMi1MxoXC9GYJlVrXuo89MNsLNQ6N7JdQKQ5e2Tb9dBBTov5DZ9UYs7ka/RO84JbY2FCMcThjz/0GUPwkUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmm4ywHS4JzGivsVlQvG68U9p0Eu7vANkrG+JXG3zcc=;
 b=f0tLxey79ACUUlPv5TmAW2VmE7kuLoRtaA1m9gDb/d7VycIHyrkHpNEqOpadw1viiiFqjoLTJNKugQ53dQCX5AGzl+AZaZtDz2J5rKB9etTQIPNIQeD6pyNX/Ub75kGNjHUUe+znO2qpGaLvQY2+sFOLxW3Y44kNaVfs5U9aJ0Q=
Received: from MW4PR03CA0039.namprd03.prod.outlook.com (2603:10b6:303:8e::14)
 by CO6PR12MB5396.namprd12.prod.outlook.com (2603:10b6:303:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 09:01:16 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::d0) by MW4PR03CA0039.outlook.office365.com
 (2603:10b6:303:8e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 09:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.28 via Frontend Transport; Tue, 31 Jan 2023 09:01:16 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 31 Jan 2023 03:01:12 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 09/11] Documentation: introduce amd pstate active mode kernel command line options
Date:   Tue, 31 Jan 2023 17:00:14 +0800
Message-ID: <20230131090016.3970625-10-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131090016.3970625-1-perry.yuan@amd.com>
References: <20230131090016.3970625-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|CO6PR12MB5396:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ed03d0-97d6-4981-cf3a-08db0369b5fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DEocPV4PraFJ9PcP60srMbTWMt2CnGA3qnr1+TBD8GxVm6oj/6wkarzK0Uc/WQ77/7aFDjmcMJYp4g+OVf7vRTTwOBx9yhpDmgP+wylw3wpr2I2S/Ix9pwSgcngwL5CM85I1yq+yKxW49C56pG4plaCBAa7Sn3tkysxzabZCgsG+hTIsb3p8W86av/xD38QzbkNEeLv0ZE8szEAkXn4m3fdSnZvmj+4Ul53hq06QvDSj6Xev3qEY6dCHYKBJTMFWIjwqbG8+T0iNf4J5P44cGPKZizra05sWhuHq661SyEb4JwkuywqkP8fAvQ2+4oFhf5FSfpiVau3ZCW80b5VwhvVfyiXox31DYs+DmnFvLu51aB1QWJdCzA8lrjHehRjJG2DaalInI4VfBWZjuoCSxSRtCjheGied7rCkkx8AM5IHg98uVQIW7LzjLjEcYoBWJ55jYfEs7SGelFe0kp3oaP12ig/p96UlQDKCSoDtbXtd8s+E4phcds6bV6plfJVPS+yOM+NjvemMmDv1KcxNOrcZSf4RRjECXq53UQZKRDE0oCjBWA6AP+obtR9fq/CXYjJ8OfwCrPzBXEj80xzNjovNaIQ/0qVOXts/6BTzTEsWrF4KqmQOPsvvw24wGUSoKXBT7natzOJJ8oRQbOJqNFfXrNKwr0LRfksuFvUdjhYjMWlxoHnIs/Ef6DPYsWhQLT3EN/brLj3sx31b51jjjojKunbMZJSkBM0Ql8GoxIw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(82740400003)(86362001)(110136005)(54906003)(5660300002)(356005)(44832011)(36756003)(40460700003)(1076003)(81166007)(186003)(26005)(16526019)(2616005)(316002)(2906002)(82310400005)(83380400001)(47076005)(40480700001)(70206006)(7696005)(426003)(8676002)(336012)(478600001)(8936002)(70586007)(4326008)(36860700001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 09:01:16.1057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ed03d0-97d6-4981-cf3a-08db0369b5fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5396
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Pstate driver support another firmware based autonomous mode
with "amd_pstate=active" added to the kernel command line.
In autonomous mode SMU firmware decides frequencies at runtime
based on workload utilization, usage in other IPs, infrastructure
limits such as power, thermals and so on.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..e3618dfdb36a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7020,3 +7020,10 @@
 			  management firmware translates the requests into actual
 			  hardware states (core frequency, data fabric and memory
 			  clocks etc.)
+			active
+			  Use amd_pstate_epp driver instance as the scaling driver,
+			  driver provides a hint to the hardware if software wants
+			  to bias toward performance (0x0) or energy efficiency (0xff)
+			  to the CPPC firmware. then CPPC power algorithm will
+			  calculate the runtime workload and adjust the realtime cores
+			  frequency.
-- 
2.34.1

