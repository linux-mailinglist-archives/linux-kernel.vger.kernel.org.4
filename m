Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FED688924
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjBBVrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjBBVq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:46:57 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A214ED0B;
        Thu,  2 Feb 2023 13:46:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAGZ33bGHXyH2KpCY3X7UHHK/F4ROUJ1MofZdDczWXMPP4LWIKaYXTpJeBDUb/D1jdslPUGZJzCJuqjl2ViRju7gN/kzZqleH2GHo06EoBY13ZCQbUZxwzpn9gszPy/m8QVgoSJWnRENNlMDSaaIphosjKPIqAWwS88+S2BYANxKh+CN8KlAF9fWtXv483JruQG0V+oNR9O2Hgz+I+Ezp3fiXPN86WxIgmvJ9Z6+jF6WjQQsuhZuKiGMqmid+p+DmttwqUaq+sESBI2UtmTdKEvt+Pe8xbofiay9sJQJz4R3IeahDjL75WOaduEla/u7IHmJtpAys6o//BM/uxhRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VqhNhPl+FhyEJHz1Y5v3ZBx/e194yetIualpcXgq+o=;
 b=NIeuLn46gWdqWZRKJiuKqH0iixt8F+Oyr1Ue6kLm/tNSn9Bhk8pokdkMYe28cwz0gHxF4YevPefqmsDFdnGrDMeIUQu/dfJkosvegzQbjxh3J4SVUpuQk/oS2Z8pXVVxtlXc89g0BMe3uqhhVr2Wr6+EliYuw1+7i6C/tk/cmlbdDT/0MQESDbrA9WXim6RGFgZsF5DUzrK/8g/EY0/ABIKOSYXh1fv2B4Q1YZ55fss/BImYctOd3mnxDbSHuAuXVtE5iD2r9nURnvkc2UL+zFLWSGSzJP5MDPlOMRvu5coVP6rLqox46IJes9qTFws92M6ztsclFDRHzqxkBHLccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VqhNhPl+FhyEJHz1Y5v3ZBx/e194yetIualpcXgq+o=;
 b=hdWb0/IZyMak4wlUor5UoTUqVD5KbYj98/b8jwz2P9d9tytLpj2f2Y4d4gz+zLCNOWz7rj3AX/5lTzc+2PI6HaEIdvmIFo5aY74uFaJURHIjN63I9bnCXGwePWlx8XwOLlN6wHi9aF47yrfYYQdavGURTb63oGHUydJaSAz2TsE=
Received: from BYAPR03CA0004.namprd03.prod.outlook.com (2603:10b6:a02:a8::17)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 21:46:50 +0000
Received: from CO1PEPF00001A64.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::df) by BYAPR03CA0004.outlook.office365.com
 (2603:10b6:a02:a8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 21:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A64.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Thu, 2 Feb 2023 21:46:49 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 15:46:48 -0600
Subject: [RFC v2 PATCH 0/7] x86/resctrl: Miscellaneous resctrl features
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>
CC:     <babu.moger@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
Date:   Thu, 2 Feb 2023 15:46:47 -0600
Message-ID: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A64:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 88cf71f8-95d0-4b0c-7f3b-08db0566fd79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1w9BxTvcCtXZOwJB/BIeed1h1bVJzQRpMC6apbLBs1x/JPzfrAp2vhMe7wM4xzpM1SPGx6EFxLSGfh740EaBKBflphIg5tMqx8WX80ucOlpAHIuNdD1Mkn+Todzdph2knJR3zIsbLNECGqnPwX2g7+C8rFrLvgYblaVFDI1BduySHsCt5y1uHUNwcf2W/YjxL0uhMAE+8jYTB7iGXioEjKhgXjR9+VOz9YwU0Am/+6IRROp6de5zDFC0TK3glVRYlL4gToHUImwGW4v3suXClq0ZR/28DiVP5eE8/TJtveRxljkGudnvJGz6DYdnw+9ho6x6kDFgzC0K3UD+ot8hy2HyOCY9mBbz+9ZOd/nBjNfXvHN3zGehguHCn8xOm5YhdQVF4Te7J+9vna/VvJZNTGFDqUuMhiRoA7IdAodea4tVoHjuzsToiIpf2zzNdTyb2/0jY8lEVLp08eWVQ8hX9tCPXmeE4ZHtT1LN59oV6CPP85csTxTHEdlyPw+W/T7ByJddkdMMzwf/i2ZErUL37c9ckcw4xxq8bDyzizG2OHbhtGnWqti6Rd/ZZAWro1h4hJtydB9FUEYrbUFWE6w9+VdzCCgHPKxLJsHWugmHoDOCc2S+dnZP7Tc5xXqSQKB3cJh/7kZyu77EYP6WL+XkqcNoOPOgrKLS2E2ELr3xmdmP5u8w85n4v6k8yvP31stUW+7vXRWCItVqtHhndWlv24K07zb9sQkSRf1FSVtOv8DdP4nmTWJwzPXD+FtpEMHw
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(2906002)(44832011)(103116003)(336012)(33716001)(82310400005)(83380400001)(54906003)(426003)(16576012)(316002)(47076005)(186003)(9686003)(356005)(26005)(8676002)(40460700003)(478600001)(70586007)(8936002)(4326008)(70206006)(81166007)(41300700001)(7416002)(16526019)(36860700001)(40480700001)(5660300002)(86362001)(82740400003)(110136005)(71626013)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 21:46:49.8895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cf71f8-95d0-4b0c-7f3b-08db0566fd79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These series adds support few minor features.=0A=
1. Support assigning multiple tasks to control/mon groups in one command.=
=0A=
2. Add debug mount option for resctrl interface.=0A=
3. Add RMID and CLOSID in resctrl interface when mounted with debug option.=
=0A=
4. While doing these above changes, found that rftype flags needed some cle=
anup.=0A=
   They were named inconsistently. Re-arranged them much more cleanly now.=
=0A=
   Hope it can help future additions.=0A=
=0A=
Code is built on top of tip branch x86/cache.=0A=
=0A=
---=0A=
v2: Changes since v1=0A=
  a. Removed the changes to add the task's threads automatically. It requir=
ed=0A=
     book keeping to handle the failures and gets complicated. Removed that=
 change=0A=
     for now.=0A=
  b. Added -o debug option to mount in debug mode(comment from Fenghua)=0A=
  c. Added debug files rmid and closid. Stephane wanted to rename them more=
=0A=
     generic to accommodate ARM. It kind of loses meaning if is renamed dif=
ferently.=0A=
     Kept it same for now. Will change if he feels strong about it. =0A=
=0A=
Babu Moger (7):=0A=
      x86/resctrl: Add multiple tasks to the resctrl group at once=0A=
      x86/resctrl: Remove few unnecessary rftype flags=0A=
      x86/resctrl: Rename rftype flags for consistency=0A=
      x86/resctrl: Re-arrange RFTYPE flags based on hierarchy=0A=
      x86/resctrl: Introduce -o debug mount option=0A=
      x86/resctrl: Display the RMID and COSID for resctrl groups=0A=
      x86/resctrl: Add debug files when mounted with debug option=0A=
=0A=
=0A=
 Documentation/x86/resctrl.rst          |  28 ++++-=0A=
 arch/x86/kernel/cpu/resctrl/core.c     |   8 +-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |  68 +++++++++--=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 154 +++++++++++++++++++++----=0A=
 4 files changed, 215 insertions(+), 43 deletions(-)=0A=
=0A=
--=0A=

