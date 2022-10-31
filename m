Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30096613F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJaUno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJaUnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:43:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887BBDF65;
        Mon, 31 Oct 2022 13:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcC/uNmdw37cq9AWZJisOmerWpM1laPXRFumNEqi1iZwQloBe6Cyp8f27x0GNM1P2l4aiTqh7ffIvKRCwm+3XhaY1KI2ATELekrS6YKW4ULCYn1Dud14Z7Jiw4c6arYeBhJHJAZzKuoEvTBLT44PuRaU3G5IWZM4iLVLP8r0t8QSchkOQHbluuL/0kvygIJh8FFIZkFqQNPH4DtphIUCd3TS9VQjbsqPbPX7oi1e/kIU8gYUs/rNovoRWtR2B4sxI7/mjhrbZiK0RgdDlZod0g3OiETgwEoQknN5KgpqMmeQMzn9SFVgiplAMt1USoGWq/hLDW+jbqPY0MGs9AUDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ujsy5ygMsHN93m56ZUiH/2+RClPJaNLGuoyy+LHimY=;
 b=FaSO7gHZnulMf4YuifgxF34vpVecASDkNJxBgBjoVmN11UKDMdJSKPlPoSD2fXrWjp2Io6xOv1ER9Z9tVCQ7CiGe8lhOPA56lhWajARQ3Gc1SANXmixeiPmK0xSwzTBCo7kzgImWpDvs0xHrDpQbJdwrmVxb44KFXCm/dHIyEAPKTmx/McSt0nRSqCL2BlMnYBeYzria+zCL/DawDbQVfL4MdSwIiUx9j4joa8OClvkNM+bHQ+0/7f59PncqBAi1wS57Y0zXIpIZWZiqf2JSE0z+1ftoeefY6iTBsD5DB4rgvp3K/1HFLzAz8UsDgE2nfZdDbR58SkFBlg+x2F7D4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ujsy5ygMsHN93m56ZUiH/2+RClPJaNLGuoyy+LHimY=;
 b=Bux0Vn9pzkNtVOsZhOUtGn8zTjxluQWsPxOtKcAGYzQtV7G+mtQouWEYQ9b6hHetGi8yGHije3RPnJHa615Q9MIPJ5xZ7y7CiBdN8xvEaMHVVLrzwdHaxe4j/QwyRM7gU5JhsUUtjZMIUALH8dyAGpDZfaj8SgvXrHNaLOOJDzs=
Received: from MW2PR2101CA0028.namprd21.prod.outlook.com (2603:10b6:302:1::41)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 20:43:34 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::8f) by MW2PR2101CA0028.outlook.office365.com
 (2603:10b6:302:1::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.1 via Frontend
 Transport; Mon, 31 Oct 2022 20:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.21 via Frontend Transport; Mon, 31 Oct 2022 20:43:33 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 15:43:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        <rrangel@chromium.org>, Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC 0/3] Introduce infrastructure to report time in deepest state
Date:   Mon, 31 Oct 2022 15:43:16 -0500
Message-ID: <20221031204320.22464-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc44ec7-a780-4ad6-9036-08dabb8093c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnPvM2D+c+A5qJF2pY6Wp0k9l37BTgfmyyYWnmwHKwYLZ2xQK6GlKRnvuyi0mIQpOrJpz2ENTy7F0D1xGt48C42Ohm68gwQEUPTBc9D0F6vA8mzIob2U9l472ZrqO8hsw1riJbsmgD0Sow2O4iAFWk3lvEKDOGAtdpOjD3tHMje7Ps3nVMESxOySiks43SZsZirp2OTB1xkC3Vr2VaI6KrFOhhQ+5deGusYZpF1q3MHIsB2BPYrt346V8mPof09qDdcZo0vna5qNOf9d/0WODGU3hbkGu+urDXE0ZwUx2DsBb2KnpfORsdA050hdXbHK5SfkNZNt7WwJi6/o4D9hsjg/WGDcaTemmUY8UwEHIbgzhzPmr0KbGxozRTY+qyV/5Jed5+z4xcmUL2X4Jb27z7WmRcl0eSmZh111KChanVOk5Bh3mHuamKixD4QmYbvm9jGM+LBoRNXIgWTbyZpLkze2w2zRywgn4UyTxrWcxLN88sB7PwfKvbMlXqLeqDqSmt1eotFaP13VPLcj50JXC6rcyNrG2bkEt+vAoXLkEL6WmuRFq+74x7vHSKLfM87J7gY1Jzhcy88G/+X+T3F2vprZPB5bhjUS1wW32i7z7UnI/mkDHNTuKuMYsxU4vHS9gGafPAyuqkWbr/TJurdSZZ2dQU+gTTmYYnjJwC7/7p7Ilt2vQNZk0skqxNldwDT8C8m4Yt977yDzZnYTT9EqKPV69lvsJrn83nDZ5MXtHVgzOkrNoGuV8GKJ1SiGbnL4q6ShLfUWqH7+lvR1e8JV9dGnDfC3qzlFIhm5PdLRL4NtKkrSh/QIfUM+qWehAUbO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(478600001)(82740400003)(110136005)(86362001)(54906003)(44832011)(5660300002)(7416002)(70586007)(4326008)(8676002)(83380400001)(40460700003)(6666004)(36860700001)(70206006)(186003)(426003)(8936002)(1076003)(36756003)(316002)(16526019)(2616005)(47076005)(81166007)(2906002)(40480700001)(356005)(41300700001)(7696005)(26005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 20:43:33.4165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc44ec7-a780-4ad6-9036-08dabb8093c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824
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

This series introduces a new sysfs file, a symbol for kernel modules to
use to populate it and changes to both AMD and Intel drivers to utilize
it.

The expectation is that userspace could read this file after s2idle
occurred to infer how much of the s2idle cycle was spent in the deepest
hardware state.

Mario Limonciello (3):
  PM: Add a sysfs file to represent whether hardware reached the deepest
    state
  platform/x86/amd: pmc: Report duration of time in deepest hw state
  platform/x86/intel/pmc: core: Report duration of time in deepest HW
    state

 Documentation/ABI/testing/sysfs-power |  8 ++++++++
 drivers/platform/x86/amd/pmc.c        |  4 +---
 drivers/platform/x86/intel/pmc/core.c |  2 ++
 include/linux/suspend.h               |  2 ++
 kernel/power/main.c                   | 14 ++++++++++++++
 5 files changed, 27 insertions(+), 3 deletions(-)

-- 
2.34.1

