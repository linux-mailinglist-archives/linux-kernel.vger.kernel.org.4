Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76388706E27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjEQQ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjEQQ2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:28:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670748A78;
        Wed, 17 May 2023 09:28:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vw3DZla6AWy1vVE5lviYPmUHaYm4sWqduB58oYu68DqSr7GPR06146x3TAFkLmzbBmpRzrGZ5zfV4STmgllOsqlzrBfR5WrUftouMhLE/M5EmWF2ysDiS/r0zytWldThNYkvKO9MvRNkS3qQIiDzQ0HdKhbOQiuaRg5KS8aos7FPlqOwD2zkSvj8Vo7B/R5NbcwqBk/ei+jB9X2QubvDV5t+nLSnOAUTtaNuXeM5CJu3lJe8/R04dcxO22hhRbTxqeYLuCOzfyJmK/kpK8d3e0q6DWfBoOIMm2cynsBAGcohvuLbsMYC8ReVk9mGW6JZSvi/ORv/vjc0Puec19skfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoyPpKFq9KsvS7Kb7sR2LZ9N7PPYqZ7kLKJOSlZmrOY=;
 b=VunBt0YS2o+kX+SW3ry8rtk73xkfwA0V/zFweM9vv26RXbyj++W56lo3HRn19KdEojWbJxT5B73Bo2UhU0wLIPD+C2U7gvjG+CxYlVLJA/cyGy9HqdgHmOuoHlltrnbEIdJP2/uKbm8cI6ZyPC9Ja6iHGuA1gn0RGbI7idxiPcF2Qpl45t3uEmdT1S2wueAcjCHVayzSNFwDSRyuIupbeZIw+Jal0ecEs9L2Z0xKi4IhlnVz0cHaa96AEyMBx0mCzGB/+KJz3RHZZptS0mJZQeOZkHS5Yl7JuOHyMoaPDL+arSvZ7tG0ckRLQSuZDbhr+wTMmIIBltSyXvxlgl1aZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoyPpKFq9KsvS7Kb7sR2LZ9N7PPYqZ7kLKJOSlZmrOY=;
 b=D8+ox+zzOSpZqVOQOqZ/+phJCnsdaJrb76pmnWCCVc0bb3mQGGSLXsDzPF66iAThim47hpaMron00zdS6TRvxoYr7RcKfz926utGpeDDEafwhuWcmBb/lNV1cza0Qsta3M/hjoebSBxdDHaFCtooLZWzYnJrfSSIazsU1hOJxTE=
Received: from BN9PR03CA0901.namprd03.prod.outlook.com (2603:10b6:408:107::6)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 16:28:33 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::90) by BN9PR03CA0901.outlook.office365.com
 (2603:10b6:408:107::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Wed, 17 May 2023 16:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 16:28:33 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 11:28:30 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gautham.shenoy@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v4 0/3] cpufreq/amd-pstate: Fix null pointer dereference when frequency invariance is disabled
Date:   Wed, 17 May 2023 16:28:14 +0000
Message-ID: <20230517162817.8538-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: f8211065-4cb4-4bdb-c4aa-08db56f3c213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gxOauhvFUbTu+xt0yGj0o04Z65DlGCk7No0Pfjlp/pzgbYuNBs4kpwkb0I7dRAlClsZ5ML1eOPJipNPT7RDkKF1GwFnv4jTEenWTwMa4lXpzkZoAqjLYhx78NksckDMvsl2te1/r6GW7+4u8caH5WQWBeQUsojityd67BqTp7icLp0g1ztm/vSIGEzY6KTpil3VDLWD8ETa68N8uERjlz92ZTcy1/YShBLwwxgK5AiXQRnW+O9/t8D25sorRaArqKDjqo78TBN6nGtpKiLYy9VB4l7TkCxV3BwqgVoYlVUPB5Cv19AE3DjEJ2Ix3MHJxh3h9myxUli8C6xX3IW2O97rrj8kFwswO8R3xWo949IHm6zXrYfoakfU+M8gDJbg8y+jdDUFs51AgVH2vynl5OkdzUTR5yeyryT/V29MS8g08w6F/wkwANNKMNFoz0MvWqEbPuCtP4U+x1fmUliafHl884ANXalJhxG02GuPAbWIOX1GxM7UHSM9sdVRXBmnLfHpl/ygjfojzuot+7ZuV0ZCZ5p0Abxh5qXfwl+J3uSA4VRQ9qezv9dOWcs8TRcFBS5DlQftP0SIBhMVeYWd6w7Yahryp/9rh+/lgfgV/2PPP0DmbQ5t1kEWyy5DyBhrXITd6osYsaSiiBFqXPXG8FmlEzKpaf/7shAUmaiIy5LjUro7/QOSPFMnoOcqfZSs03uQDSxaVL+CskSCs5mSpNw9nwfNS8dU8G/C6rkuskpdOSL/xbezqIVuKaX3r3ssZuDHsYsDLXHlZ2rJBGIMIXU8QNaW5fe/oA0libPXcTv/nHcJxorvwWnvzuzon1yKv
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(36860700001)(47076005)(426003)(966005)(336012)(7696005)(110136005)(54906003)(478600001)(2616005)(6666004)(26005)(186003)(1076003)(16526019)(44832011)(8936002)(5660300002)(8676002)(36756003)(40460700003)(41300700001)(356005)(82740400003)(81166007)(4326008)(40480700001)(82310400005)(70206006)(70586007)(2906002)(86362001)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:28:33.5705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8211065-4cb4-4bdb-c4aa-08db56f3c213
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
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
governors. But the governor can switch back to fast_switch (as
fast_switch_possible is set) when frequency invariance is disabled. In
that case, if the driver didn't set fast_switch function pointer, null
pointer dereference can happen and the kernel will crash.

Currently, frequency invariance is turned off when any anomaly is
detected with aperf/mperf readings. Which triggers this problem.

Fix this by adding `fast_switch` function in the amd_pstate driver.

The same problem could arise with any scaling driver which doesn't set
fast_switch but sets fast_switch_possible.  Return failure while loading
such drivers.

Changelog:
v3 -> v4:
- Add extra patch to remove fast_switch_possible flag from amd_pstate
  active mode driver.
- Fail to load such drivers which sets fast_switch_possible flag but not
  fast_switch.

v2 -> v3
- Add fast_switch callback in amd_pstate and warn if any driver
  sets fast_swich_possible flag but not fast_switch function pointer.

v1 -> v2
- Remove fast_switch_enabled flag dependency for adjust_perf callback

v1: https://lore.kernel.org/linux-pm/20230410095045.14872-1-wyes.karny@amd.com/
v2: https://lore.kernel.org/linux-pm/20230509180503.739208-1-wyes.karny@amd.com/
v3: https://lore.kernel.org/lkml/20230515113404.4259-1-wyes.karny@amd.com/

Gautham R. Shenoy (1):
  amd_pstate: Add ->fast_switch() callback

Wyes Karny (2):
  cpufreq/amd-pstate: Remove fast_switch_possible flag from active
    driver
  cpufreq: Return failure if fast_switch is not set and
    fast_switch_possible is set

 drivers/cpufreq/amd-pstate.c | 38 ++++++++++++++++++++++++++++--------
 drivers/cpufreq/cpufreq.c    |  5 +++++
 include/linux/cpufreq.h      |  4 +++-
 3 files changed, 38 insertions(+), 9 deletions(-)

-- 
2.34.1

