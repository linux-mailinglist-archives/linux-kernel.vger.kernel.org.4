Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50EA74EDC0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjGKMMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGKML7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:11:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::60e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04224E5C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:11:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYHJVUPFlqQkrQ+woeCl94pmbCexJRBOMqORFjqDoNowRyrEsuKf17Kmr2M+IJe12V4JtTmcaQJi+4JqLFsCENrTw60GhX5Z049lr0YkIVLrjfamZ5FFKdp7Qtti6FpkXnoZxNIKj5yxVt7eHZFy1htAfnv29ICA31TfA4W21UtQZCMJvtNAJWA/0eJd0ob5XpDhpj/clu9lcLxoTH3poweyzVdJMZjwJ/6M2HAl3/Qtm1Lk+xTHnH9GDo+xayT2hk3e3/vDwr8qm0MPHaE7MBAr7Mb9M2SYPl0t2+l9TsLHjWZD9vL5DUXnR94cEoImDz4YnEWCIb8Y05SEOR8y6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLrNFMCxVRX0O8KvLO/ex4aoiBGVy2dkSXzIsPr6KF4=;
 b=OJ7bf0xpA9LM6t8/UNKgk4JigHD+WmT2Au5VoWa/I/UtPAQbVQwuoG+sF0Tls3rRcTGZiXPj+aUAe/IP4gUAC2Pp+/q3ml7nYDkAJlEv8YizWh5VKNYzv41gcNz5srbKxmM/2up9XYTJ9X3SIL+kfHbT6zBLvO9vElJvAPdBtTbTQLfIjxgbKPysf+O4psbmtBNSuytTp5+cm7Gmd1EaEZfuHH4rf6/yELnSUWbrhGw+jI2yx9udhgxrRf4mD9jR9iCHF8zLsF10hWw7DEPT2qptV8F/51X3t+EQqZC+DzxYYHVB7vUiB/krGeu1/ZTseL5beKMNsoaFKOmG8kwGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLrNFMCxVRX0O8KvLO/ex4aoiBGVy2dkSXzIsPr6KF4=;
 b=UJlAe7bpje+D70PDjON7pOKK04r0faVxffd/iHW/QsJe8rCAgeglt0IRjyZ3EZ0E0wrMkvKVPYw6VgvpLJEuyyfOP3tqiLBlK7J/zgB1cAaAaW95zoqcwBCOjtw4BV3Vdh8xnH6rHENCyDEGgSQtL7XubXiRO7qvvFApwMEPTkA=
Received: from MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::8) by
 LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 12:11:47 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::fd) by MW4P221CA0003.outlook.office365.com
 (2603:10b6:303:8b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Tue, 11 Jul 2023 12:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 12:11:47 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 07:11:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 11 Jul
 2023 05:11:42 -0700
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 11 Jul 2023 07:11:40 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH 0/4] cdx: provide sysfs interface for cdx device resources
Date:   Tue, 11 Jul 2023 17:40:23 +0530
Message-ID: <20230711121027.936487-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 68fe6947-6f45-4d98-2f40-08db8207ffed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkNBpTDnQE3wkfZhEhjFiDHiFLzHGmeA6OV68uygoEN3jlfwbSyj+QFbY+e0BLMHoX/B6vblphC6zMEUEmP/h0Bw/H1+2iBzFbYO6MVdQv05YBP4J8BeX5fzsB7NwRt2MDO7ztzN8dneFZExL7rsSQP+vmSAp2MX466ihw6L7Z+Aap+SdbDQslhp6lKCFNXIf5SUdPLEA1XjSTAiQhxaMmlZ/FVD4MABrwOjnGDJ+ghyeS7sRyh5RsKucPts59BMStlQqWDcMryNzCxppmxga0Bd6psHunYfycN8qhjt2FsxYHVuGiyAGz20yrV2QZYpbKJZsqGJsgEPuXTR1ev2up4BiKddGcMFMplmXgaOTEgiUiz5eLb2DZDjz2OLSXMhocO+/eDFNSym++J6pmyLai1QhCGMbXz39BzUHek1WeYmR1EKsjE61eA20lzjZr1avCdKTKXlb8+FCtEXDDTo36IW9JxyeLDx3Dywm/Q6AReW80neo1tEtfg3hKHxq6+ghBPfbn1KDHU/+AfPkB7/g1m+eynNgyNRGi57Ifpddlwuu6L7FHN+QwbZKEBA8w/yc4QXVKb8ozapAb5vpOmLbBCskVSTHhMfEU9w/wpax0B17kfdpHoXSR01CkdqRvQn0TCCAZonEcfLBv5zJQ/92nriL/GfEEbp5FyaekvLO7ktHUL0Boe3pBpqomehNuq+PX8MSLk2d5vxGQsicFViAthsAE7XHb7mx+K22comviCXrbjz+yxCz35uMFvKv6Yv5Puoe9wrpana1gddGEDGmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(336012)(82310400005)(316002)(6666004)(44832011)(110136005)(4744005)(81166007)(54906003)(4326008)(40480700001)(478600001)(40460700003)(2906002)(36756003)(356005)(70586007)(70206006)(82740400003)(426003)(2616005)(83380400001)(186003)(36860700001)(5660300002)(8676002)(8936002)(47076005)(41300700001)(86362001)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 12:11:47.1610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fe6947-6f45-4d98-2f40-08db8207ffed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provides sysfs interface to
 - enable and disable of cdx bus
 - reset_all for all the devices on cdx bus
 - resource files for cdx device
 - subsystem, class and revision for cdx device

Abhijit Gangurde (4):
  cdx: add support for bus enable and disable
  cdx: add sysfs for reset_all
  cdx: create sysfs resource files
  cdx: add sysfs for subsystem, class and revision

 Documentation/ABI/testing/sysfs-bus-cdx |  82 +++++++++
 drivers/cdx/cdx.c                       | 223 +++++++++++++++++++++++-
 drivers/cdx/cdx.h                       |   8 +
 drivers/cdx/controller/cdx_controller.c |  27 +++
 drivers/cdx/controller/mc_cdx_pcol.h    |  54 ++++++
 drivers/cdx/controller/mcdi_functions.c |  31 ++++
 drivers/cdx/controller/mcdi_functions.h |  16 ++
 include/linux/cdx/cdx_bus.h             |  43 ++++-
 include/linux/mod_devicetable.h         |  10 ++
 scripts/mod/devicetable-offsets.c       |   4 +
 scripts/mod/file2alias.c                |   8 +
 11 files changed, 502 insertions(+), 4 deletions(-)

-- 
2.25.1

