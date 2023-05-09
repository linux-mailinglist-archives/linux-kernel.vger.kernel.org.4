Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F6A6FCD34
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjEISFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjEISFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:05:31 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD29944B0;
        Tue,  9 May 2023 11:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYu+TrtxE/O9YQd5wpEah3Kt/N05SWut1iBLdzWAVjPzxtAfC5HzcwiyWUbsKwounS46v3AJWgjpj+OYCVeA88so4FS7++TnOgt2Y/IkP49FWFFYaTgNpHXBslD5cj0v/Uy8gEP6n01/gnRny0uF1lRCeY9S9BPuX7kqkkDl8vnKPbRtC9FMxhcnNQvxT1vP52FZNJCIljz19cvjiiFXFrczToaL94jZikanO5Flvhh2HqqEOPTVu0Wp03SdOBqjIs9xaQfXpWII2IGakiPguFeVowATRtcTnf/8jxu6edWQA7gyuFoc5mj1bAz1+BXWxw1fdGrbdnHfqevNL66xKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHt99vA/XKC1UR+xrhJqz937+6u/cZV1lA4Xq7/2E9g=;
 b=bIpn1wXGOWfIL2Mf97VQeCZryqeyIkkqo2537ZtUZxeYjaFYEdYEH0J5CQO1NhnQAfKiVF8ery81kyLuUR7G8r66CKwhAzBCrg0VecQ2wm8EWC1T39I8PpMZ1szWMJ4jxK9wU9CjBC/bHdx0uzSY7+sSi3pRXhjNL6zw40dwd9jKAScNdwnOClFDPv/4ku8H+hh91DQj5rkOIvkLvzn4ykOx6ao3W/bLTeZ0ikp72Z5pUUzG5MGWvatFpATsrZG3qRy4eAP6aP4zNFXBpU/nledMVe24/J0xhxU5dMXf/jGvJ9ZHz++YuFUufN6vGQeuExP/J0ZsVjkj8GRrKAcAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHt99vA/XKC1UR+xrhJqz937+6u/cZV1lA4Xq7/2E9g=;
 b=qrchPSGuBWAhE5YTij0nh89GdO/SC4OOsLlBgZKGCpqcT8ftVeDExPsZ4t2Q1yBja3CGgR1HlRumQauhgz8f3QhT8gpnyw757yNlD2QgiLZDUs38mr6Ovhs+1eE2KsOUECiikPrLN1P+rG++90Qx+8qxhKRKYlFVgGDiYjwKIwY=
Received: from CH2PR07CA0062.namprd07.prod.outlook.com (2603:10b6:610:5b::36)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 18:05:26 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::59) by CH2PR07CA0062.outlook.office365.com
 (2603:10b6:610:5b::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 18:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.19 via Frontend Transport; Tue, 9 May 2023 18:05:23 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 13:05:18 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <srinivas.pandruvada@linux.intel.com>,
        <lenb@kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <joel@joelfernandes.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v2 0/2] cpufreq/schedutil: Fix null pointer dereference in sugov_update_single_freq
Date:   Tue, 9 May 2023 18:05:01 +0000
Message-ID: <20230509180503.739208-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 25aa7dbd-ab7b-4a38-d9d9-08db50b7f5f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RvEYNUOmUTIcCGSukhzEn8qx1LE/y0lFVRbFoDU3CAIbYOPSQ+48ZOpRmI/3lTuMzjc0G8YXFnmr64dm24uizvMqZI3ibO9rEsUbWZ1iAYiKNQYNuTu5fRklaJ7i6Y4KM5bPtwDMSWb+1veIQzESZKxswa68sT8v3ed98McUMggL4QlreWGxBLlQmxBi3aqBUYW4C8TEx3iMxt+ifqnkvpJ+r+6Sn3CRvTExfnA1qnAhFgBL9HUnRlbavMPhaD9CZUFyE3tfaGjDW78bViOic6JLBv5yhHVSlcNE1fM70+mkmNfjg6k3bx75Niu1j8K1fOkMrrY+EgyGHD8GHf4rrxPo0Crmh90YXCpviCgPfpt6VdYtI4XK2h/0NgO6yVIFtuJKUwLg07zFKnrkHYErES7znM3eu2w1GbRBQe1hNq+BautWlKDvf6DKXGhQUTg1FRYjT9xN61Gb9wO8cNNYH66BFRNP/I7VTJQmpOEdfreE3AB0O7U3jmReHZJ/CaTc+RoM/p4g9/7TcCJ1Du2y4ZWMnaunDrhJ06uyEmsFMPPh3p0q0GH96kYpmCwIBpMtprD0MRSt08TBfDPXHPupZ8SW8+VBdmni8BF5lWRh5D2RerBLx3wJ+2Pu4VS/SY/afVsnauvN61DgxlU8UuOZwN4Hn5IgxQj1bTAH/PW0A+i7HrTErIdrs75MIQQ12f8Grz2btW/JY94mQ/kXXRYfO8ib2wmNoZL6BuYVbwBrBALJiA0NH4h25g5KC1l0MrA
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(8936002)(5660300002)(44832011)(7416002)(8676002)(54906003)(110136005)(7696005)(6666004)(316002)(966005)(41300700001)(1076003)(26005)(2906002)(4326008)(70586007)(70206006)(478600001)(47076005)(40460700003)(63350400001)(83380400001)(63370400001)(16526019)(426003)(336012)(2616005)(36860700001)(356005)(82740400003)(81166007)(40480700001)(186003)(86362001)(82310400005)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 18:05:23.6777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25aa7dbd-ab7b-4a38-d9d9-08db50b7f5f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192
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

Currently, amd_pstate only uses `adjust_perf` and `target` callback
functions to get the frequency/effective utilization data from scaling
governors.  Schedutil generally avoids calling `target` and `fast_switch`
functions if `adjust_perf` function pointer is set for the driver. But in
some rare cases, schedutil tries to call `fast_switch` function even the
function pointer is not set. This happens when frequency invariance is
turned off.  When frequency invariance is turned off schedutil falls
back to `sugov_update_single_freq` which currently relies on the
`fast_switch` callback.

Currently, frequency invariance is turned off when any anomaly is
detected with aperf/mperf readings. Which triggers this problem.

Fix this by disabling `fast_switch_enabled` flag if `fast_switch`
callback is not set and removing `fast_switch_enabled` flag dependency
for adjust_perf callback.  But this will force schedutil to take a slower
path to update frequency.  Therefore to fix this add fast_switch
function on amd_pstate to take advantage of fast frequency update.

Changelog:
v1 -> v2
- Remove fast_switch_enabled flag dependency for adjust_perf callback

v1: https://lore.kernel.org/linux-pm/20230410095045.14872-1-wyes.karny@amd.com/

Gautham R. Shenoy (1):
  amd_pstate: Add ->fast_switch() callback

Wyes Karny (1):
  cpufreq/schedutil: Remove fast_switch_possible flag if driver doesn't
    set fast_switch

 drivers/cpufreq/amd-pstate.c     | 46 +++++++++++++++++++++++++-------
 drivers/cpufreq/cpufreq.c        | 20 +++++++++++++-
 drivers/cpufreq/intel_pstate.c   |  3 +--
 include/linux/cpufreq.h          |  1 +
 kernel/sched/cpufreq_schedutil.c |  2 +-
 5 files changed, 59 insertions(+), 13 deletions(-)

-- 
2.34.1

