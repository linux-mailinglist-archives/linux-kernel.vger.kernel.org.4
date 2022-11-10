Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA92B623C13
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiKJGtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiKJGtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:49:11 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979F72CC95;
        Wed,  9 Nov 2022 22:49:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArAxXYQTv19xG0HQ97G5kIykezyq1mBXtgfd5wPYzE5zoeDr6Sli4wCYx/BxUmkjsgetbC3z+ThHbl7BsaQfe3DX6KvHW6kqPfxs0s6kBNxtgVsE0eHWhiQVvA50iwkVpiS2UTsJap+vXUS9Q5PUWrlN+t66k6Rcg/m/W+RRh6958MWfLaDnI9Zn4xE2HM2S9uNl7K2Dd0iuB563C8Lu690bXzjl5mBakPwQfCSPo1vtSWA0FiTuDc4nithPfQeG42eVBgkW2o8kOFbZaWkWtksq/LP/uhQzxhv7k9qITKf6gnjB8i2EuzWcGvsVMO4zIqujwJtTRRtJGi0Ex8W3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uds4sGnpnXs60IdvtLB36YztlrtpeI1IpC17pfnWYTE=;
 b=H6qU8EeRv0zPyKZx5FHssrWw4GYU+X75qi8fb3zy/c3pp2YxQhoIVw5F8L6a/IOhGNhSravpDifY2StV6j8c3zQLQKyfTSQjdl/TkKqvPlYdAvt/wpnJKvtuDq3IEV9tO0qDyiMab6gDWpvOA6v7PI1T6cBqcQkkfAeWXfbCCbCcfqQ9wsWRW8lLAEnO1v7cVHqsPRJ9dugGn0b7PcW/FRcfqBeb5Q0PT8YKlCs3f+xem3FZru/+LMsdoAxvmBUFJ/XHUHzB5ZOPzu/s+lKxTp6GsHev7WGXzBwpBlfWamYcy7be3ppVL3q7dYX2jL/UPiEt7N9QrF4Gmccfi3H1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uds4sGnpnXs60IdvtLB36YztlrtpeI1IpC17pfnWYTE=;
 b=XFXOHHDIzJPkcat8idcGZKbq8P+g1vAFi/oMEJgbAO0fspfjOBeIcKPC8tTw8zAPZc4mKl26H1R54NpDyJGrLHuObLw923xlGAvCpcB/4sEEI4wP3XP9p8k+IzHpGpdUOvNdQvQ/Lj1lC0oWYoq7khvG+nSBNm4DRUJILml97sc=
Received: from MW4PR03CA0018.namprd03.prod.outlook.com (2603:10b6:303:8f::23)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Thu, 10 Nov
 2022 06:49:07 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::f) by MW4PR03CA0018.outlook.office365.com
 (2603:10b6:303:8f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12 via Frontend
 Transport; Thu, 10 Nov 2022 06:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 06:49:07 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 00:48:08 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        <rrangel@chromium.org>, Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC v2 0/3] Introduce infrastructure to report time in hardware sleep state
Date:   Thu, 10 Nov 2022 00:47:20 -0600
Message-ID: <20221110064723.8882-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: ec52ec94-80d5-4854-6e9e-08dac2e7aa06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpV3n71Sk0cZxcLNqpCuIW8+GQn15xVaZ+K1gDmVmBPTurHQUVPzGJqsTBVAKQvZ/lnTGa+ThiUEQ0xQdMvuevTGbjiIt9yYEqqY9D7Xpjl1yeQK19Z+i0dXfmeolICKnUcvmdTESbxk3l/ZSiTXL2lmNCKxsV+B0avh/SECcDCjaS0Qybo642ZzRTOC+KUltG4w7L+un3CW8qvWe4hFk+h3WrQ+hO3OyzB94GtRTAglUI9dBGb4AI3Mio19IRGd5UY9F6Goe096YAREjAKjAlyCrHGFXhS4gL8XGulgqR79/z5HUDMZjzpNj0D96+kGvLQIwu7PR0idtK+xdrBopBX1N0psf6eZHrh447S0lHO0E9Wtm5MUZm99baxsxYrv+GfM8TUMitimI7+Amudfqhl/cv1MyZdaWYI3vEWM8ECwFkkrTJBPPan8cNxe7ur/qp8pwQ1NQFUZyy6GStt3taFd5UO4bpPwO/r+h8N/GP62d37uYDlBFOlWAjV3ylMpMOKPITCwdXwlPL5M2LTLA8mtbuEAhjt/nUkwqTn6FlsaFWCzA8uMmHVfgoB1xqaZE4PRZvvHaTjFB0EnOtar14awMK0iIYGBzrDeLa5x8i50yltAY3OuoWPFLGT1SEL/1th5H4Z+khX2w8fFOgE6Eok/PWJQF7ndYJ18BJzR4PhQkN3CNfgs2fcwNtswBfuMq+SgC1YIgDz7/q3vPnX5aaAPBLGrcuEBHKci0LoFjmrwgjLRZ2xYYxLVPuLyUpCu3JRHUYrBy4v4T5Aw30GiH9UvpVtSxuoDEM5CPOM75gFnAI+TxWNFJmK1AJ1LvA1G
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(81166007)(83380400001)(7696005)(1076003)(186003)(336012)(16526019)(36860700001)(40480700001)(2616005)(356005)(40460700003)(82740400003)(47076005)(70206006)(7416002)(44832011)(36756003)(86362001)(426003)(26005)(2906002)(5660300002)(8936002)(41300700001)(82310400005)(6666004)(316002)(8676002)(110136005)(54906003)(4326008)(478600001)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 06:49:07.0566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec52ec94-80d5-4854-6e9e-08dac2e7aa06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven van Ashbrook brought a patch to the kernel mailing list that
attempted to change the reporting level of a s0ix entry issue to a
different debugging level so that infastructure used by Google could
better scan logs to catch problems.

This approach was rejected, but during the conversation another
suggestion was made by David E. Box to introduce some infrastructure
into the kernel to report this information.

As it's information that is reported by both AMD and Intel platforms
over s2idle, this seems to make sense.

This series introduces new sysfs files representing duration in a hardware
sleep state and total sleep duration.

The expectation is that userspace could read these file after s2idle
occurred to infer whta percentage of time was spent in a hardware sleep
state.

RFC v1->v2:
 * Rename sysfs file for time in hardware state
 * Export a sysfs file for total time in suspend
 * Only export sysfs file for hardware state if system supports low
   power idle.

Mario Limonciello (3):
  PM: Add a sysfs files to represent sleep duration
  platform/x86/amd: pmc: Report duration of time in deepest hw state
  platform/x86/intel/pmc: core: Report duration of time in deepest HW
    state

 Documentation/ABI/testing/sysfs-power | 17 +++++++++++
 drivers/platform/x86/amd/pmc.c        |  4 +--
 drivers/platform/x86/intel/pmc/core.c |  2 ++
 include/linux/suspend.h               |  5 ++++
 kernel/power/main.c                   | 42 +++++++++++++++++++++++++++
 kernel/power/suspend.c                |  2 ++
 kernel/time/timekeeping.c             |  2 ++
 7 files changed, 71 insertions(+), 3 deletions(-)

-- 
2.34.1

