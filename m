Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208437372CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjFTR1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFTR1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:27:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A343E95;
        Tue, 20 Jun 2023 10:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhhoD+/e/e9ClEIe07LovFKzgRtSGxtB3CPetWDk7fXu3eHToMFeAaeDule/KcEjC/a9xKf6r5PYr1EwBFK0mmlktHUVXGNnm+hM+CQPwZ0APDMDxiZ30JFFbCH1i28tHuoT6WjSvwXr1SeUclVrawWvdQoCbuE1XFVEHq3Ou9QdhrHqxRDiCOl4PHN2WLngfksmCI+hMnhMJnfoh/KSZS2MkNBkM7XGQ39Z1RyNuB4Sb3fO5Wi72ntA1qSU8QIKJQMTIy1RyxLUM3mKhz/YsZNlgFZcPIO4JTr2df5ANZAYkXAmC9n9OK4KJFlDVKgg1qc8j+gQNrJ9mXlLhPDViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YK4Ya++DT9fnoXc3qwOg07w/mkbtsOo8oaM+F7D5Yx4=;
 b=bRKVo31cwbh6tlc3ZSfu/Rgywnqa0ie41ppKrC7+jW0a0W+RTHOfHwHZ8zqBR7FIwvFlzcqzb4Z90tL2bv2EBxT5wLydjseWBSJlzpoBezqdEn7YRFJ+sR0/80WmSBYQ+qQ+lYxdD8Vr21Zee+7N8CsY4MPToLnk0VDuZin4AjrfLOsQEd1sD+e8z5CEp3rymUK7IEJ8rRhii1moShqI1V/rRbZPKGGNYrHssqLwF1kdV8ttkHfxa01zs8UkVOeLa4ddMp6U9YMJZEXIHfuUgUeL4JHbFqHMqdHEIQIER6+e/QWRMTlRxmWyv1Cdw7QJGasBB1oUSlwNNm1061zS2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK4Ya++DT9fnoXc3qwOg07w/mkbtsOo8oaM+F7D5Yx4=;
 b=lYYWW7cTzl0ST91vhmR3qQ3H4/rF0GXoFi8HikHRDigrf46rzR3M7AYV6ZQnAH4qYEOK9SBp36XNQax9NKo6N1u4JA8EMlrTBQn06kv8GF+ykFYjx/zYY+WQUP82ODtK5w4ENccNup2+TDbUJsgD4kjK5ybJ4NSDaC5zrwTVpQY=
Received: from PH8PR02CA0024.namprd02.prod.outlook.com (2603:10b6:510:2d0::16)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:441::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:27:34 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::a) by PH8PR02CA0024.outlook.office365.com
 (2603:10b6:510:2d0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 17:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Tue, 20 Jun 2023 17:27:33 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 12:27:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Len Brown <lenb@kernel.org>, Huang Rui <ray.huang@amd.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Gautham Ranjal Shenoy <gautham.shenoy@amd.com>,
        Wyes Karny <Wyes.Karny@amd.com>,
        Perry Yuan <perry.yuan@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 0/3] Enable amd-pstate active mode by default
Date:   Tue, 20 Jun 2023 12:24:30 -0500
Message-ID: <20230620172433.21325-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbcae36-4e6b-4ca8-7858-08db71b3a241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pAhJzRUBB9rkG2n89+nS31iWSnsW93NsY1gCUWN1IwCBaQ4tGCbxulbRAdj13FyDDDqEmyoqmjTQL6uim+u3/sFy9yf703BNHnClGBvuorEXxNjLDEkiVdwyBadAY9uAbOSHcnyet/QIXGBUjuwZH9rhrEUZlqdevIIdMDzQn1XfJ66AY+e1Ml9RosRTD9Fs9phKDmAhr3qqe83eFM5yb+AXp7os3G1N9AyNH1O/ixgersrA9ojrrm6rbmBbOoMhY5lYmfxuWMpUxd/BMGrmYzd0uoCq+NnhKn41yXDq2aEezhqHeh1tDAoT20dhF4ub7ZvYYCUo91dS0h7OmzqaOQAlNQBquOvQGT7o8WDIZj2EBUA5c16LucIvOU/5N2/WMz4LTZ9bDEmNYe43iYdvTbRDPOS7awFQQtDjHt+jC3ILZqew26BT6sOW5ex0Z55U+WcXL8A7V5OC8W8WAvh1RAoxT1O65c10hjzKSmFzCle9YgAfWUxqKk6OI69TJ+HAHkWzx8vf4jl2ftXmsfbX2OE3nc1MZgJndxiLUVfN5csM8BpolzcU1YnMokAnEWN9p4GETONnmbFMUzKAKTsKaa8PzTorrslzj5Q8jmDkGlWSVAbnvgRnIxY9RaQmsFaXYfxtcZRKM24CaPSxxH6kKNwNeBWahe/FC8mq1hpVNS+nOkvStqcYIs7HvUCPEvk/2nVBXNtxAZ/FYgW/eugEotD+YXFQeWRTzKXe8X8+gyNKWQMQKUev2TpHBvPdt4WIFRhaSRZxHXh1bhDia2dZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(8676002)(8936002)(478600001)(40480700001)(41300700001)(5660300002)(4744005)(2906002)(44832011)(316002)(70206006)(4326008)(6916009)(70586007)(40460700003)(186003)(1076003)(26005)(16526019)(36756003)(54906003)(36860700001)(86362001)(82740400003)(2616005)(336012)(356005)(7696005)(426003)(83380400001)(81166007)(82310400005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:27:33.7560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbcae36-4e6b-4ca8-7858-08db71b3a241
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
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

Active mode for amd-pstate has shown enough success now that it makes sense
to enable it by default on client systems.

This series introduces a new kernel configuration option to set the default
policy for amd-pstate modes for a kernel.

Server systems will by identified by the PM preferred profile and still be
set as disabled by default for now.

v2->v3:
 * Drop patch 4; Intel intentionally doesn't want intel-pstate on SOHO
   server
 * Move symbols from patch 1 into patch 2
 * Add tags
Mario Limonciello (3):
  ACPI: CPPC: Add definition for undefined FADT preferred PM profile
    value
  cpufreq: amd-pstate: Set a fallback policy based on preferred_profile
  cpufreq: amd-pstate: Add a kernel config option to set default mode

 drivers/cpufreq/Kconfig.x86  |  17 ++++++
 drivers/cpufreq/amd-pstate.c | 101 +++++++++++++++++++++++++----------
 include/acpi/actbl.h         |   3 +-
 include/linux/amd-pstate.h   |   4 +-
 4 files changed, 96 insertions(+), 29 deletions(-)

-- 
2.34.1

