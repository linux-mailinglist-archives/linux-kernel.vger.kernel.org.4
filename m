Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A546F67165B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjARIfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjARIfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:35:00 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D5E7E685;
        Tue, 17 Jan 2023 23:55:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+emd4Y7YF8M9/f+BHvaxTHZwJn1zILURuLemTYiuL9pS6AeuZjOwC/V15jPb/SV6LpEFf6nwNYmVh+98JHqbmiuh3JUG1tMjUxV4BRGfWvoTjcsl7yDjKtDXlr7MCdKNq1293j8RdIFiJN9UHP2rd2SpFh7kI0T0BkHTm1yfZGYdGxOeSJK9FANUPP7D+t8D5Acu0iA4hU9f79ps9Y4EJko3RdnCKx5iSP1SOLYO1gmz6o445gO1WUBlohO9Ryk1KdMZJMEaxEH8Gjz2Ee8I5sjkGjrFJT4S/Oi5dnqL5Xtt3t/E1ZgJqE5OvgW212K1ZUYoCSMvwQAFQmoXgFe3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUSe1i5OPPJzwoPGgnbIn1pCp1Owlinq3a453rgR2AY=;
 b=gW3SUy61NklzthpB/Ql1piX8ySePR0a7PwEAX7HPhJPHUKUnoMjFHyTlF0yZVo0ECNEXX3Vda0UiDyoAhJjG9Jhqmx1K9YqAcJjQPIUtEjk9K29NrOAWOzsCeaVUcCcUHUmFuwdmQR3RjTE5wb++6czodvtukwFy42Y6yBESDZQe+fzsf+vr4/NGwjxKFewmBXqELFmi+2MNItwcaZhrCMAafT/EosW9eT394Ke/kg0uOO22ZvKyZWMCrTrCjOYbWt5teSJ/w8N6zsY9dCr/RU9VU0SqiqWEbpB5siwwQfTUOA8Q7c/zKXaMWcoTtomtDaW3x1vbXy4E5W7Z1fNKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUSe1i5OPPJzwoPGgnbIn1pCp1Owlinq3a453rgR2AY=;
 b=WYLAHqcHcEW10kbhXHbsF2jLW044AyPgik0jXJE/1I6uXa64VintnomccVcm35dGJu14KzjxDxszUdtKayuCm2CRJFgSVwIecd8If43jUn6WmFbDwQaX4YhdnhvEutpog6lASU8hbvDF8kZPZntKp71Yy+N6dL0R73CpLwAoi3o=
Received: from MW4PR04CA0350.namprd04.prod.outlook.com (2603:10b6:303:8a::25)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Wed, 18 Jan
 2023 07:54:02 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::4b) by MW4PR04CA0350.outlook.office365.com
 (2603:10b6:303:8a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 07:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Wed, 18 Jan 2023 07:54:02 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 01:53:20 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 11/11] Documentation: amd-pstate: introduce new global sysfs attributes
Date:   Wed, 18 Jan 2023 15:52:10 +0800
Message-ID: <20230118075210.447418-12-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118075210.447418-1-perry.yuan@amd.com>
References: <20230118075210.447418-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: efc1bcc4-394d-4168-339c-08daf9292a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XT6RrkMeXqJsPPMw/58+7zrMJOmMhKWevQPT9Svi9b1IQAOxRWimSTbYDUnrwBHpbN42WwnhQViCcdCqcW9rW5NhsjQ5j3IHqCtNcHhJPCCY6hv0RJYEEMOCtc2KDNuBUlZlDuKC4ZUSQI6IoQAgqjyIh7u2qUK5UAXedPzIo26cEFMRpWrlov2wh+L3Yr30AO0SPKsr2wgcmtXlfSjxg+R9va1bd2qyRvvsiShA2Z3vwXBWZod9kIcqfIfpwnAzHz3fcdKp5gu+B5ALSRLrYzhiFhDXfZ6VGLqeUhEF/5zw9bBWhjxIsL81DEL0Rw0KiY6lzO2BveI70AjJxsNB6ckNAxrrNTA2Sf8je9jQC+YseoemPMT52Dodysk7ZX2eTbB4Bt3+dJ6jgXaIBD53J/JFAG22tKHKefrvdVylifpfpo7wD9vC7u/VBlFbrztoNdXZgt9nSgNvXP31qsFt/ApnPbFB0Amntk59vtzY03tH8ZNHSZbxetBso8yfABbv31VI/ccJE/+8T0mKGtqFmgwt93HXOzgEscjj68544ADmm47P2GR05S7Onoq2ekvXeVZYh7MgtLOFtrCDOnAshh2g4nrmqxd9HhQsMs3o/YpCFSoEoXt7qtgaKJRd9F1XOpQuU/12gYl28Lqj7AsalW8HmigJbz6dwBzI61ITDbAYe5XPS03kAjfaYD9gpbfMraQw9ZHisskC0/vzSrPNv3cRJvcdqm0raFbmgn32SBE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(6666004)(478600001)(8676002)(110136005)(36756003)(54906003)(4326008)(70206006)(1076003)(41300700001)(70586007)(7696005)(316002)(36860700001)(82740400003)(356005)(40480700001)(81166007)(82310400005)(40460700003)(2616005)(16526019)(26005)(336012)(47076005)(426003)(86362001)(44832011)(186003)(5660300002)(83380400001)(2906002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:54:02.0538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efc1bcc4-394d-4168-339c-08daf9292a1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amd-pstate driver supports switching working modes at runtime.
Users can view and change modes by interacting with the "status" sysfs
attribute.

1) check driver mode:
$ cat /sys/devices/system/cpu/amd-pstate/status

2) switch mode:
`# echo "passive" | sudo tee /sys/devices/system/cpu/amd-pstate/status`
or
`# echo "active" | sudo tee /sys/devices/system/cpu/amd-pstate/status`

Acked-by: Huang Rui <ray.huang@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 29 +++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index b6aee69f564f..5304adf2fc2f 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -339,6 +339,35 @@ processor must provide at least nominal performance requested and go higher if c
 operating conditions allow.
 
 
+User Space Interface in ``sysfs``
+=================================
+
+Global Attributes
+-----------------
+
+``amd-pstate`` exposes several global attributes (files) in ``sysfs`` to
+control its functionality at the system level.  They are located in the
+``/sys/devices/system/cpu/amd-pstate/`` directory and affect all CPUs.
+
+``status``
+	Operation mode of the driver: "active", "passive" or "disable".
+
+	"active"
+		The driver is functional and in the ``active mode``
+
+	"passive"
+		The driver is functional and in the ``passive mode``
+
+	"disable"
+		The driver is unregistered and not functional now.
+
+        This attribute can be written to in order to change the driver's
+        operation mode or to unregister it.  The string written to it must be
+        one of the possible values of it and, if successful, writing one of
+        these values to the sysfs file will cause the driver to switch over
+        to the operation mode represented by that string - or to be
+        unregistered in the "disable" case.
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1

