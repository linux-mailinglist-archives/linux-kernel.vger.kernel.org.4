Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CE77330C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345082AbjFPMGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbjFPMGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:06:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E4F295B;
        Fri, 16 Jun 2023 05:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QE7SF3gBoZtX9JhmovIMqpQ1vEabFKDNvvFQkw4rUzNO6r8BsdhsYvZ0PUYIxoEzLmD0yH8TX3Qztl3jB0DLiPY5q2HDubx91mX34HpMwx3CC/Up4OaweGhg/sBedvr2y7YnW//K1OtcPcHybVLjRLyBynHkGbKBgGVqdq41QiOPQePP4fw9Y7BKaEafHAeYObUDNkbFz01hvFgpIa0etEEjnoaV8DkXpFmyXhC1detnGakuzpQI35sws4OSmf5rWT7I24RRi9HynC8KhRXij/f88Pp+sGtnpvbNbV1lio+2iNwMOH49xjIIZ7/22qQXNyAu63IFyzdATmlOivPj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiCsVVOoLMxh78BPFRA3vS2UwEnJaZR3ODG4TJh6Oao=;
 b=H4kz0woOQV8wB6pvpOOt2Ts6/ktznPpu8AI1BXZxdYdOWNWSBuiKKuJKz0VAHJ5c+mgMwzyHM9YKG/vNig36yOVxNge9toZ6ds1ZvhMxNLFmXVvUfH6oMqWfcewTSy7eR+t+FNzECAsb5iAaZzEAYXNzyRvSNNzadBQhtfSBWcFVVJvP455GRoYOnezJbodsAeDZ6JXIQeQ352PVUxAIUQ3KfStl+PAcHW45d0FMISN8yzpPeXAKfJLJw8Zl+wusxoGi6+M3hjv9BNuqRtrL05V5jGiqyKFNWabAKX3TRPXwprN4VK2J+6rvfAreP51OJew1kHzwK3EdkkWvumfutg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiCsVVOoLMxh78BPFRA3vS2UwEnJaZR3ODG4TJh6Oao=;
 b=qmkkv4L4bX5eIPK1mQKQclOpfno7TkalWdiBGt6uVlR0xMsSefJjsKY9mGhFf3TKGR48Z6JF6rgQU843bhM6076AUf/LWYGfijvlfTpxsXSD7PX0C9rDoX4IB6w44pDZMYmi6TjoC6DdF8RZlybsGuBVI9IPMwQmcwmNiz4bmZg=
Received: from DM6PR18CA0005.namprd18.prod.outlook.com (2603:10b6:5:15b::18)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 12:06:43 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::6a) by DM6PR18CA0005.outlook.office365.com
 (2603:10b6:5:15b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29 via Frontend
 Transport; Fri, 16 Jun 2023 12:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.29 via Frontend Transport; Fri, 16 Jun 2023 12:06:42 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 07:06:35 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <trenn@suse.com>, <shuah@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <gautham.shenoy@amd.com>,
        <Mario.Limonciello@amd.com>, <Ray.Huang@amd.com>,
        <Perry.Yuan@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v2 0/5] cpupower: Add various feature control support for amd_pstate
Date:   Fri, 16 Jun 2023 12:06:15 +0000
Message-ID: <20230616120620.147643-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 928a94c0-180e-4724-4e67-08db6e6225b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iQEJtL0aR4nqhQG681hRa/3hWJbA5o7D7PH7+m4ynJTMz1sLQI1uJ7AhWTVx6K6+4PelDNxLOcPhxkQhApCdhKuRY+eisJ2qkgo6jplp/RIPqnrFE4nrXFutspIMKpCDyyMLJUIrYc6BfJX+6KKt7+rTY51MfZ56uVkBkoAvfYXgRX2TgddY0r+lpSvrihg3D99Xkep9b4+gmFd5udXgzwzT8IXjytS0KjKIohNS2DExn1mNnryNwJe84q03Ssjrf8HIs+680MYkP3qCCMV+0ITacpEO0AvRvN92aENjnjjWH+oXXwiL6nnXWCbEgFK1/gdKeXwt3Ywvm/h5TMcesXZBFeLstTFQLtJ8L/bP6XmiwPOo8+meQ+SdAMjcpOpkyGOr49YE0m8xMD2A/LrGcg/eXkzEu3KQdQN8ptGY6T9QUWKOSEYDjINU+67E2ARXm/1Iq+F+XIqkoqJPqYgm/nDdTXlSn2AnqvqvyA95v9NgSu8STerZ4XA3yB2cUJr/m4cYIIhUyMKtOLjOUb0G5RQzi4n32J1Gy+3RnvGkFtJs9Xug1TOrgBGF7txdtb7K5RahVi3b1DhKSgUIHPERvKbR8MpaBZEXoi3J5AcXp6Ff8hwq/Ck5ucXoBYAPIFLICmXQoF0qy1HAJeeLKFpnx47lEuU1QOkUqCoEKgmnkYrUPh0HS08+NnwhpYelByCnBK5caUZieL9yqFSvaRr7ZHdwkrAmZcXV5Et3SgSnksPnmQTm20B9Xj0nU4rlFEdGwxjCpeNsHxSz/to/Anj8gA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(110136005)(54906003)(41300700001)(86362001)(7696005)(70206006)(8936002)(8676002)(6666004)(316002)(82310400005)(70586007)(36756003)(4326008)(40460700003)(478600001)(47076005)(44832011)(36860700001)(40480700001)(5660300002)(82740400003)(26005)(83380400001)(1076003)(16526019)(186003)(426003)(2906002)(81166007)(336012)(356005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:06:42.0896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 928a94c0-180e-4724-4e67-08db6e6225b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989
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

In this series, three feature control support for amd_pstate has been
added.

 1. EPP: User can control Energy Performance Preference (EPP) value,
which conveys user's performance vs energy preference to platform. This
feature is present on amd_pstate and intel_pstate active mode.

 2. amd_pstate mode switch: amd_pstate has various working modes such as
'active', 'passive' and 'guided', which can be changed dynamically. 

 3. Turbo boost: Turbo boost feature is present in amd_pstate as well as
acpi-cpufreq. By default this is enabled, but user can control this
feature dynamically.

These features can be controlled with `cpupower set` command. The
options are respectively --epp, --amd-pstate-mode, --turbo-boost

Also, make cpupower recognise amd-pstate-epp driver.

Changelog:
v1->v2:
- Drop patch 1, which was amd-pstate-epp driver rename change.
- Picked ACKs from Ray.

Wyes Karny (5):
  cpupower: Recognise amd-pstate active mode driver
  cpupower: Add is_valid_path API
  cpupower: Add EPP value change support
  cpupower: Add support for amd_pstate mode change
  cpupower: Add turbo-boost support in cpupower

 tools/power/cpupower/lib/cpupower.c          |  7 +++
 tools/power/cpupower/lib/cpupower_intern.h   |  1 +
 tools/power/cpupower/utils/cpupower-set.c    | 65 +++++++++++++++++++-
 tools/power/cpupower/utils/helpers/helpers.h | 11 ++++
 tools/power/cpupower/utils/helpers/misc.c    | 57 ++++++++++++++++-
 5 files changed, 138 insertions(+), 3 deletions(-)

-- 
2.34.1

