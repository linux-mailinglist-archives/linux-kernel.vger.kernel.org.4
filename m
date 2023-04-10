Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827A96DC55B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDJJvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjDJJvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:51:18 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7461701;
        Mon, 10 Apr 2023 02:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=il8JM6eF8abgg2tAmy7ELL+IWgU+RXUQfYa/pYirBPNhKWrViVMJY+ZwmcVCjfdPibWTe3wtJiXydyucn8jEJcl4W7ScAlA0DVxVvNx+3EwpDoydOX2QCUjMBudQodsYFRQVTe/pQsWfSl6qCSqcUt1hxqLJkLH6+BYEYe2x723uEOcR6ymRmY3vCJP5V/CZSiiewDybiYem54thd/5z1ABR9Fx4bJC5CwCghtUzUbQrYE7inpyU7g96QaUoOtmKW6tbHni3z6Jbg1EiJmQesYwvk2sTmtoccGN/PBdT2qPdDIKG53tbSe/hLFbXP2I1A0hnReNPtr8mUxfARVBVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhemcWV/Gt1r9EcyLbje435qGndJNZhmSPNlYL2EG64=;
 b=iK/9uM9yXr4jZ1iBV/Cy6jh8f2YGFJYTBz+Tq3NVI36hFtuns8rnBfKVPz1h8lmBNpqLXo51tJpocZu35q7VofupmQ0fd/zXlXJ67q4dHccq28se42aNOvd1ebK/gAAvehShxlcc9+5eKQiPNaac7R+cq0odYtyVEWpcHos39TcOTyObZoagNB4k/cBxFL9BamIyCVSBEb/VxHJcZn0Brqw4abl84HDTvjRiqt9yqMwsJugyFOSzutgW84bL2jsjG4/hqimESPdJU0patHCG6bwT0vG7rhgTMCm09uAPU7pONrmG0D1aM1jny6k9UhMvo7vP4g1KKBPdezvpSQJZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhemcWV/Gt1r9EcyLbje435qGndJNZhmSPNlYL2EG64=;
 b=SRDw8p80JKEolFk3eu2fscL3xpupXLTmDSPoxpd15PO6ThvyfpegvrdMoIYFjkqLXmqTMDW8z0YfVc7TTK9JI1V5ljL/trILnT0WXDQ++KJwcBuRVyZ345xo2NfWheP17KNozuekmTXDkA9WYGsq9S8QsAsqevsncX6ILF83iaU=
Received: from MW4PR02CA0009.namprd02.prod.outlook.com (2603:10b6:303:16d::20)
 by BN9PR12MB5225.namprd12.prod.outlook.com (2603:10b6:408:11e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 09:51:14 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::62) by MW4PR02CA0009.outlook.office365.com
 (2603:10b6:303:16d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 09:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.20 via Frontend Transport; Mon, 10 Apr 2023 09:51:13 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 10 Apr
 2023 04:51:06 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <joel@joelfernandes.org>,
        <gautham.shenoy@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH 0/2] cpufreq/schedutil: Fix null pointer dereference in sugov_update_single_freq
Date:   Mon, 10 Apr 2023 09:50:43 +0000
Message-ID: <20230410095045.14872-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT029:EE_|BN9PR12MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 921fe078-ff79-42e8-bef1-08db39a91f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYP6Y77LZ54Pe0a0HVDuOhDXhF/O++TaK4q7SdkNeUXq+z+PeiY849Z8lTPfM+lJVcXeUTDUTpqsktFn2eiHiwW7vbXAM3v7un2V5ONFr3pMz1B8LnGUjd4oaJ+1FXT9RTTSBiFJw0R8Azt21G3OkMzE2ntoQTvDezWHWNwH2fZD7Ye6DtIlsoHOl4wuxV3OdBd4jvTnk2dXZ2gPuw7bMbfDE+Dy4P/7vYtzaA6t/0uwBTLo7/Ai+TxL6ejEp+0GtCwAAIIvviO5l0ulhLMkxL9VQ92IjrIchCTvd3y04SBCbGRFEhXINA4ErWBVvDFf15pY9P8ACId4d+2hUP1eF8hocHXxIJBs6xfodDn7i/UMrbRcwQ4YiQ4gvxR/xBcEqF7iZ6VHiR8AEUSuh5JK6JnEvJQN4ZJ6aRLBy6EHBKPvL2leqvGTeFIjJX284RaB0+/5F88qkm4CZO7Hrz9yYAEw/vFJ9KlyG1PmpoY2wp6AWCTLi1678DBw4yBe48l2vfSGKuldWOS/ezNzrZhb1Hq6kF4XtMdgCZRAssG6K0GTBcMNIsusl/Ay3srir8MwNTYKk5WSG14QSULJ0BM3nVl/6gW9sk8w+TUeb4B6RrIA7jNWqLxvnOp/dEeDp/k/tTCdsE60wjrLYi6ZZ/m8rkUtPsPbZnSkX5zAnUFlZRus6r8mmeAn9KtA3oN2Shd/3ZMu3/LWQN3IHw0B/Zw/H/UE16H0bxVTPwefq6iW7hysNA0TJYHrQa8xzItDGquY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(36756003)(316002)(110136005)(41300700001)(8676002)(70206006)(4326008)(478600001)(7696005)(70586007)(54906003)(40480700001)(82310400005)(5660300002)(2906002)(7416002)(44832011)(8936002)(47076005)(36860700001)(82740400003)(356005)(81166007)(16526019)(186003)(6666004)(1076003)(26005)(2616005)(336012)(83380400001)(426003)(40460700003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 09:51:13.6318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 921fe078-ff79-42e8-bef1-08db39a91f25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

Fix this by adding a NULL check before calling `fast_switch` in
`sugov_update_single_freq`.  But this will force schedutil to take a
slower path to update frequency.  Therefore to fix this add fast_switch
function on amd_pstate to take advantage of fast frequency update.

Gautham R. Shenoy (1):
  amd_pstate: Add ->fast_switch() callback

Wyes Karny (1):
  cpufreq/schedutil: Add fast_switch callback check

 drivers/cpufreq/amd-pstate.c     | 33 ++++++++++++++++++++++++++------
 drivers/cpufreq/cpufreq.c        | 11 +++++++++++
 include/linux/cpufreq.h          |  1 +
 kernel/sched/cpufreq_schedutil.c |  2 +-
 4 files changed, 40 insertions(+), 7 deletions(-)

-- 
2.34.1

