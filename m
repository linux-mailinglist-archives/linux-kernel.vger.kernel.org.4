Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E7E68282E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjAaJGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjAaJF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:05:28 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77EE1D938;
        Tue, 31 Jan 2023 01:01:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL+g2H2z/3sAKymJQGGAGYa098Bdv2LZWNUsMz+J6LHX7t4ta9YHE60jMQal9A+LXNlMioAJdKNqBJA4rCJ2L6R9bTH2iCvTC5Bt1lCFoV9OltC/GPzVpibVCIwtljkDOTc47m0mdj3bl/v4zXaWX1dkd6zSCp8irksQX7P5ZPnUSQS70I/Wzx4PndFIEfay2WdbiGEoZLC5stkAoonNH+keQxr6BR6SPd2gCBCRzZ+OwTLUTq39U9a07z8N5uqCoqtyIdp49Xc5/jAHUOu8pSOZ1LJYjk9sWrgED7GQQWtMBhQ2zxeTVlJVtv0O91q5P2Smmsb4lwyq2ya8dXriLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Noen4OCHV20exX3SkQuvyAz5WIkB8aTweLqLsdGjQI4=;
 b=as6c3xMX7Vt0vZuw/mWkhS4KHWh6M5PmuSXcVolJdtl1TaI0tVXvhJoyOavq/RYAB7iuHuJDeeg9fWwD+2BJv7duBz/2ukrXr8KEcKnBIlL18Hol/wrbUihMlTdj+3UfhP2Gbry3xpzWn5PVrs158cAFFLwA0fDmChlIBmDXZZOCqqbGa3yMcTX4dyAr9nhNntYdNCTm5HcSKJDuYXXE08Dbs8MWcXFP/e99otfb3/qWetUfQAk+CZJRZMRDSLnE8CFMGCF2zLjwnunBHbb4iVZkoP8gmZtg5wQka6mWJ6sutddKYlTOCY++OoBEYRDFGN/4jzWbkSvgnkXw8gRFJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Noen4OCHV20exX3SkQuvyAz5WIkB8aTweLqLsdGjQI4=;
 b=0299HKv+OYn09+Hse/yEIq2lxOyRbEhNh/0yE8tNZVCP3Wg8q8umKej8VKbpxdFSMvWN7B50c7NRRp5cTQWl97gTkXCa919vf+OxK7yQvZP+IWLDJvzFlbtc1mZhMDlYVZi+u+bZzy/6WJ68xvK0LVMZlEYxwi2FKbO4LKw19LQ=
Received: from MW4PR04CA0117.namprd04.prod.outlook.com (2603:10b6:303:83::32)
 by SA3PR12MB8000.namprd12.prod.outlook.com (2603:10b6:806:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 09:01:23 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::78) by MW4PR04CA0117.outlook.office365.com
 (2603:10b6:303:83::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 09:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Tue, 31 Jan 2023 09:01:22 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 31 Jan 2023 03:01:18 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 11/11] Documentation: amd-pstate: introduce new global sysfs attributes
Date:   Tue, 31 Jan 2023 17:00:16 +0800
Message-ID: <20230131090016.3970625-12-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131090016.3970625-1-perry.yuan@amd.com>
References: <20230131090016.3970625-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|SA3PR12MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff5bbab-5b3e-4404-c5b8-08db0369b9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odUHlkWadRm9/XoIQjY+/bVyajqG9Msb6IezeNAgqgqQa9LH0y7YBJz8349bxmgLoAGikH6f71SxenbhS0+fRYf8KueLZGDRsh8O6sh/jkaeZmsncYNFwMNm3fKU0aJWoAKhWUjfpvyRmFoBkcQhWXfAo6HzEbcKyQ39thwPaLjH7kfukyoDjNY72PjeICe3El/2uE6qs91Z8rTDAINwPFaxezQw002zr+YhOD6cuECCi227ixEtI9ibixz2OXrKqdwRry/Eep4IxCQp+xyII3gCvOrNcHRVZ3EWmqQVQbrQeWo3L+HA6gICjSC/sujPST9ZTQ9GtSvLSsaz7BMJzeOXOKpaR4iB3OXTu46YbtRF5IYvlxDAqdFKYprsAUQ0C+xgdh19gOoRHfvWn1DmbR1u7wvGZh2lpM3XQcjNFdefVS5Nvf1G2+PosF959UGpnNyygcv9Kh1ReCrh5o50axI6+ytx/Y+gh24zn8i+P4Ns7wNOEO1OYoCKfPD+ry7E1wxiOdoDgemlHTXzmCTQt6/d6QyJx1ZRT1sVYUUquX2d/0F80pYNpOUJrJy0CH7OtisCjpKhmLP9Njuwnvm48TlyQ7CmoLYeLQQyfaIsOQ/FiaC8EIXjXNVlJLhROHPpssm2IFpD1MM6wXUu4lupIlaEsYsb1s/O64/jn6RZfRN8GWcoeintYzwHm3QuKau8k65GPJOnbMXgfyKOBqeowSV6YxJdDaY3GCtG+4EIISs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199018)(36840700001)(40470700004)(46966006)(8936002)(2906002)(8676002)(4326008)(44832011)(336012)(478600001)(36756003)(40460700003)(5660300002)(186003)(16526019)(26005)(7696005)(2616005)(40480700001)(86362001)(1076003)(426003)(47076005)(41300700001)(82310400005)(356005)(81166007)(83380400001)(70586007)(70206006)(82740400003)(316002)(36860700001)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 09:01:22.8360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff5bbab-5b3e-4404-c5b8-08db0369b9fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8000
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
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

