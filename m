Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ECD62D13D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 03:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiKQCvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 21:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKQCvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 21:51:13 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C4B429BE;
        Wed, 16 Nov 2022 18:51:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUqmLWtBT7sH46ko0U8DtocQe4XHLQvbb4Pc8J/XKAPQ3F4S0YmutlNFzEhlMAW6mWnwplCZhZKezLTcYIscEO89Gpo32cFARlkcB+zfOUv27Hngw8MOmTTEmdj6BBNr1Z+8kRqs1giufdaD8aRLyfjLE8ANcrV89P9Angd6XFjyMqxjWeyh4pdvb4A4hKfoW9sOUwiPM7q0rfT96ISvJWa6BYhsJ6oz2Fm5UUJ+901O1zm2DDmo3KRT5ygurN/nv+1q88F6r8booSO3zOboeJB0hejoh9/cPjCBMH4GzHYooC0u3YzqECKHkMYmeJGr+512Ty4dEspn1OBy0Lgs4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyciw56gExPehnjWhNnkWa+4bCpkXiUkg36Hj+d6oHo=;
 b=kccdrXwtjAdNDbRp7W5ZDbtL+mcR4og/i8+OQ0/PISE+Ct4mhxqJWu0uO6/kQgtjxlOGm7m6zRiNKTJk66jA3Gx82+mCXAu4XIPD4ZNmxmdkDg+9H5BFG36mo2Eg60U+yEC0hHcr6cAhP0Y3QxdqYflcX7hIadA0vvDyih9H/mi/TYQ079dVYMmtS79UYC54pMh313+JmjtuwbQTJ1Q0DFhwaK0cU4PhE92MgeuUkq96G17YkWVMEyHPgBJMiS/w5OOwWsoSbUKlsIgk07tgSeRJlm6JaUTb4yP4Fmao1hPphMpMEFLfdrFtUelE0HHrBkQyg8YxWIXAjA7P6xMLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyciw56gExPehnjWhNnkWa+4bCpkXiUkg36Hj+d6oHo=;
 b=gA7Xapwx5WQA79yYJOSwRyYMwQtFDuWzDxgCQWWH2j1iRHRQZqEr3zdllY/6Qrayc3J/vtaTvxEKuFSOCoM/36sI8NCFntANwSMirayxWcBtbYJeB5d6q+pDSN191cfgTyIAsDYlwqQffg+Zkp1w2tmkTntger0zh8s8d1kR2sQ=
Received: from BN9P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::24)
 by IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 02:51:09 +0000
Received: from BL02EPF0000EE3C.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::a1) by BN9P220CA0019.outlook.office365.com
 (2603:10b6:408:13e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19 via Frontend
 Transport; Thu, 17 Nov 2022 02:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3C.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Thu, 17 Nov 2022 02:51:08 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 16 Nov 2022 20:51:04 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Mario.Limonciello@amd.com>
CC:     <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Deepak.Sharma@amd.com>, <Shimmer.Huang@amd.com>,
        <Li.Meng@amd.com>, <Xiaojian.Du@amd.com>, <wyes.karny@amd.com>,
        <gautham.shenoy@amd.com>, <ananth.narayan@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 0/5] AMD Pstate driver Urgent Change
Date:   Thu, 17 Nov 2022 10:49:50 +0800
Message-ID: <20221117024955.3319484-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|IA1PR12MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a66214c-c6cd-403d-444c-08dac8469459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eOkt+CjFfVmnKaVZ2vB7Y+2br8MTS/H1EDXyAPmUbaNMOySBtLthodptVd7LxcQvpxMGRvpHjDAlFohnsvMScIRnjd51LWlZEaOVxKO1UWhWDinMjpqF+gSONTCL/HAbN9nuDvQIjKAqMKBVh84vP4/holcYPhGQk3XDJs5tKeydGEQeJ/ySlnVN7bf+CPNyVs0BBcRDRy5yrW7aLk51v4gdkXxJ/HChBwojLh8Wfsm00Lekq3yqqRSq6G4rfpkQipFasmhoIL86dUWkpki5qfKRFLT7p7cRiZYofed669muFHFfWrsoARgrvzgTExTeOnH5A7IDNjq/PPLC3R57yUTB6kN2IXNTQmrT5XWN8O8xD2w8u4xmovrK9MZz748L6KClqk2DZJMxeD5e4rjKhjXZxE56XTkZ5vDYaASa6gjeYVqK23BwUM3vd2+g9R/IYW+nwDB2iIlTezgnMec5hLVi475j1PmvrEbHe8nnOM2FpAASm+F7WshtIffb3uu0/oVMwJjx7MSsd8pBHOGkmMZAZueN5E74dl9BinUz81N/yZFoLm4bm6oaJn88isYumxKZD737Ixxyr8HOhJArKH0uWnGZTyJhLItYptqXKT92twseb4gLFgmKdfPRSGAbIAk/mwbw/qRB2SzRcDz6JVyH3ntYT93fJ6wD3CA4JVqn0Ty0gerWIE2/DNp+/JJHOOYgfJx6iBqiE+P5W4jaEQz4/XBVPq8m9cLKbzOxSUOf0jTgt5j1ynKPEN4N+wQjMhp79JApE3nb3VG87u2Q6fiUA86ASUle8Q+hXsDB4OUmE3B0O4nXPZcscJRtTH8uI1lgN4enzbEedxO1pxaQUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(186003)(16526019)(1076003)(5660300002)(336012)(40460700003)(41300700001)(110136005)(6636002)(7696005)(54906003)(316002)(8936002)(36756003)(2616005)(26005)(4326008)(8676002)(70586007)(70206006)(82310400005)(36860700001)(81166007)(356005)(2906002)(82740400003)(40480700001)(83380400001)(47076005)(426003)(86362001)(6666004)(478600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 02:51:08.8021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a66214c-c6cd-403d-444c-08dac8469459
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6409
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset changed amd-pstate driver as built-in type to resolve the
driver loading sequence problem, otherwise the acpi-cpufreq driver will
be loaded as the default cpufreq scaling driver instead of amd-pstate.

Some new kernel parameters are added to allow user to disable pstate driver
and load driver with passive mode which use governors to do the
frequency scaling control.

* `amd_pstate=disabled` or no parameters will not load pstate driver.
* `amd_pstate=passive` will load pstate driver with passive mode.

Set the `amd_pstate` driver disabled by default because of performance
degradation on a number of AMD ASICs in the passive mode driver,
especially the shared memory support processors.

EPP support for the amd_pstate driver is under review. With EPP support,
the said performance issue is resolved. Once that gets upstream,
the `active` mode amd_pstate_epp driver may be enabled by default.

Perry Yuan (4):
  cpufreq: amd-pstate: change amd-pstate driver to be built-in type
  cpufreq: amd-pstate: add amd-pstate driver parameter for mode
    selection
  Documentation: amd-pstate: add driver working mode introduction
  Documentation: add amd-pstate kernel command line options

Wyes Karny (1):
  cpufreq: amd-pstate: cpufreq: amd-pstate: reset MSR_AMD_PERF_CTL
    register at init

 .../admin-guide/kernel-parameters.txt         | 11 +++++
 Documentation/admin-guide/pm/amd-pstate.rst   | 30 +++++-------
 drivers/cpufreq/Kconfig.x86                   |  2 +-
 drivers/cpufreq/amd-pstate.c                  | 49 +++++++++++++------
 4 files changed, 59 insertions(+), 33 deletions(-)

-- 
2.25.1

