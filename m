Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A12E72C341
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjFLLlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjFLLla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:41:30 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D134695;
        Mon, 12 Jun 2023 04:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPwZvheqHfmiscBpLA9VZwQ9K0yUC9i5WbCxUrQ+RJkzHWLj/hp8epHd1nGufof/x9vxNMglcqHDE75UU010Tlf7gAGZ+z4nVNR82x7LYMyunyWb+H7g6giTfWLtu58JIZqMucUUJBGOvf1CtB1ayBBbe9QtiYPaPp6M0MDKtkTiMlu2vCI2RTwXDW9j7zaIEAaHWhrdmakvf6Yp9iuQSuC2RfgPR9vXT/KkqVyv6lJJFmA6E5amqh74tvA6Tw989vWur7hMgDzXMj5x7jw6aPrhA+urT6Z7Dx37VmB38iaNgTxaHdKiU4IAsgXwInGjnDwC8TUCpzCEE3TcV6dV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4R9ZPDsLI6vpZ3eW2jsHPS//RjlAuuzNp3i7IIXduog=;
 b=eX0BDdl+BTLcj0rU5GsvYbpUXReXQSFqg14w0QfRjf/5lSm5Cfm5DWhuWcp032KV+MHx0oNbpAt2RQUSzA9shNeeKeY9p3xEk1E5z63c/cL3Dnb3QiqFO4KAKLioBJD+oDC4J5UC2YSPgJ/KBzHNNyv79Kv+IcLxwoye80X/17w2+jz4CFX4E3/ArHL5MqgoMhZD6EBdvwaf7AqmnIsmukTnxGYMZMjpiIcLn0b1d5S+kQGc+EIq7VLjF4Vgjmvz1zJ02Zu3wAmbISzvDcep44JzMbJte7IsFh8ZAWHYgYsUUVEdDWQURGp0wyFe2M4axCT5CwJdvjUJ+zh5yBc96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R9ZPDsLI6vpZ3eW2jsHPS//RjlAuuzNp3i7IIXduog=;
 b=GJcA8O+MmESDRvWjfEI+jPRTMTbprBl8qvOSfB/16sKYpmO/NbEbjag9FitXfQ7RmYrvlhxqSPw2yYku2uMZGWO6okqtb4vTYILMyI+w1ygl5GyyitF9QvbMkCTr/1kW+tqiDNb1EC+zwmr6EOoW4V7GlThMkycY46WuzN9OeaU=
Received: from BN8PR16CA0004.namprd16.prod.outlook.com (2603:10b6:408:4c::17)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 11:36:37 +0000
Received: from BN8NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::74) by BN8PR16CA0004.outlook.office365.com
 (2603:10b6:408:4c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 11:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT103.mail.protection.outlook.com (10.13.176.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.21 via Frontend Transport; Mon, 12 Jun 2023 11:36:36 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 06:36:33 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <rafael@kernel.org>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <trenn@suse.com>, <shuah@kernel.org>
CC:     <gautham.shenoy@amd.com>, <Mario.Limonciello@amd.com>,
        <Perry.Yuan@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH 0/6] cpupower: Add various feature control support for amd_pstate
Date:   Mon, 12 Jun 2023 11:36:09 +0000
Message-ID: <20230612113615.205353-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT103:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: b730aa93-41ef-4267-c1a7-08db6b3947e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ww2mPcff6KwWak7kusG9rlOLlTCafHsOLy4jkFiXFwzuEeDo90XsPWVJNdo1EZvy5c1/mNO3gBnHiwz+ucioKq4Dg9pOOmz5nefN7weLneQm0rE6mQG6dZgUZDmVlv/tIeLYDeSYUz0ZhRoY7JtX+8Xej+lPYWjwj/t5MIjWSugzrgmWiZztOJ+0ZuCCVZeYWYHDEbGwBtcVfrUjhCBAq/bDpz7iUmFESYDkoQMyRr8u0RXdiH9IGJyUiCpfg9rYQhSlov0+G2dc4CkVHahvx+1pkMoi7vhWH4qxyvvSemIZ6e8v2/6HEw0Q8TUWxQuIj4hJiIMq/N81CBJg1vROivCWytP+vSvW5DBRdzbEBammajKEt5RVayjwON6LhCOuW4w2benRer52WVTzGWUv6pYKvTe2psX4u3jZD46INDVe8kuE6fkOX86kXzt0SDJESVec9uZYROvzLfZ474RqYenSluLdXNr+bG+l/x783+1rNp9ando3+kdWX5ePdY9qWhJe+6yfJhOr+BidliKwf3GsD8JBliAJOz49LdlcWLka69fLoOypni4J1oeUb8hvvFzbTOxCUasKO56Br131pw4XovrrrCw0uCi7U2N9W+WYovZUp4d4CGY/1wR5YFLfxakWO25MgN/ARuAgeXnCxvWdgPoSgCKOGo14wwCY4l8xp54IiCqeKulLvP6jCyrX+n1cLI1xf5nYeVygXeU53nmutLdUCtSp2/xw0lQ62ur60dtmjleRwkkh7x+pf9GE01LdEaLweeMUR+nu+3LLMcLehgiwZbdSALNko2VAsns=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(110136005)(54906003)(81166007)(82740400003)(356005)(70586007)(478600001)(5660300002)(41300700001)(8936002)(8676002)(70206006)(4326008)(316002)(2616005)(426003)(16526019)(186003)(36860700001)(83380400001)(6666004)(47076005)(7696005)(1076003)(336012)(26005)(86362001)(82310400005)(44832011)(2906002)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 11:36:36.6135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b730aa93-41ef-4267-c1a7-08db6b3947e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Also, fix amd-pstate-epp driver name and make cpupower recognise
amd-pstate-epp driver.

Wyes Karny (6):
  amd-pstate: Make amd-pstate epp driver name hyphenated
  cpupower: Recognise amd-pstate active mode driver
  cpupower: Add is_sysfs_present API
  cpupower: Add EPP value change support
  cpupower: Add support for amd_pstate mode change
  cpupower: Add turbo-boost support in cpupower

 drivers/cpufreq/amd-pstate.c                 |  2 +-
 tools/power/cpupower/lib/cpupower.c          |  7 +++
 tools/power/cpupower/lib/cpupower_intern.h   |  1 +
 tools/power/cpupower/utils/cpupower-set.c    | 65 +++++++++++++++++++-
 tools/power/cpupower/utils/helpers/helpers.h | 11 ++++
 tools/power/cpupower/utils/helpers/misc.c    | 57 ++++++++++++++++-
 6 files changed, 139 insertions(+), 4 deletions(-)

-- 
2.34.1

