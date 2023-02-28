Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD186A60D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjB1VCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjB1VC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:02:28 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06CA22DF9;
        Tue, 28 Feb 2023 13:02:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=melNJdv5iDz4Gvu0YbIyEjc3K2R3O1FcfGpbrOXWiNm8bEHTRo0Gi+0STcbsMoXMby7Cny+rzd7UWg/tohjuuQOFym0MQmbflgx9FTSF8GND3nvH5mfhGETcQ0HUgkfRPoT3MVYdGAyoU5YfFODEswQTRkV7kjpoOZfLd2PFnk4FKKKslY4oI1DaJ8hYPCEIAJQ3d+E48afdNda9t/OQo9bOHUfvx92SBuFyOc476pX5Bpj3e9W1CRlktjsYEZtBaGTzyh6ZxkuNbMhGotB3gDbbWS/C/jx2jiBrte3QSHg67V+cv6polfHN1plt7lXX9eoUg9tlEc8xwFNXaoyWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x/9TElmRpGPCoM+/DoMDVSByaz7gzcCEbux+li4YOk=;
 b=KhJUT+O2vHefYswv4YW1yKvcH8xL+a1zqhnAcaAR8PMIbC1gPGRy/Hc17PdbyM0vjpQ1Z1xwiHVQjc8mqdZACiE04YNQ4J8NXDECbTSyJRZn95YLYn5TYqVu0jtbDh1P25OPEDqLDJztvkwB+xiUTJsFUZR9bVaoNXG+EdozAIChmbXQIbDYb2wCHSjca7TkQIdp6EdHlvPn/RcL7bMYYVrL6vk56HBPfDOhLx229MuY5KX1x80Opp+DCLfn3g/eJ02U57ORnMcO3L9pVuo56GELq5gpLizWH9kl/tkEYAOHcj1IqRg+9wkx+5m03v6fJdHmzaaXVjmKzLZ+qz5sUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1x/9TElmRpGPCoM+/DoMDVSByaz7gzcCEbux+li4YOk=;
 b=OgAjGR9ClVc6i86NFmuTVK48tFJ40on6qxl07O0HhR1h27X9Wrnn7Nsib4KnG1j7JKb9NYzW0mwoWa1F+DRUsjAiBoT1hLXoawILMTqYImMnDVQNLBKTT3tH+BonW4y5sldPWlKUMm9VxtzfGA+XV7mYoPHWqzOAvQAfO0SGxhg=
Received: from DM5PR07CA0114.namprd07.prod.outlook.com (2603:10b6:4:ae::43) by
 DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.30; Tue, 28 Feb 2023 21:02:24 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::49) by DM5PR07CA0114.outlook.office365.com
 (2603:10b6:4:ae::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Tue, 28 Feb 2023 21:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.17 via Frontend Transport; Tue, 28 Feb 2023 21:02:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Feb
 2023 15:02:20 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 28 Feb 2023 15:02:19 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <michal.simek@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v4 0/5] drivers: remoteproc: xilinx: add mailbox support
Date:   Tue, 28 Feb 2023 13:02:11 -0800
Message-ID: <20230228210216.447373-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 510de03d-3dee-4ae0-ec27-08db19cf1753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BKo/RppRdJKtyOV+Q3OCKmGLyr3BLuh97FZoYAyfv+Ve0xsrocsQgLYdkvd9n/q+bXxefoxnV7ALpLmEyjEDrNaO/3dVXaD8q+8CZC0rjspFSlGxuAJiwkN5aYcBsVHdhyrbcn7dEqksX89skioF0wbPez7gIS/d+X7rmi17iQ6E2BoeE7CtKJzg6gNx04ZRGUNH12Tk36k5JJ5XcDpXec1ViIPpcktUxS+FFxv/CJ7SVmFjF2NNReaItvM3lihJx2fiNxvvaN8vJ4pVAN0t1DxMGGZQmKbwqujqXOJNLVvyqNoAWUa0YPOeveWdca6Vi0QPEccrEAnUjQXTchvR1M7EW/75165F8ACVK6WJYL+LpCJ3h9qWA0OPs8KrIcy5iCjTwtNx1Y0fF282LnneMBL8zY4De42abctJNkqgqOCD+sdrdxKxOYlr0RHM2OJM41Hb81nBki+DWUBb26iKy54bpjKLsV0tiJrO5qxeVQm3Y8vT7prriDPGiFBMIoau1pvOeNL5YWXtX7ZfDz6xk9OMP9lCWfh5RLz68mtaDh+wCcE991yoodSZvC0tKu5vjIHWtD2r/Crp/KIDACw1WIWZEIM5e0w2+M7/PJnJaDHFLZ23ZmqG3Q3Gnd5mCq7AVO1j+h805n58KIJdfbUZRoavkyG/IGyYwxruZJTAGD1U6XA0HRYDzauuRhIZZh+w0K+ZZHvue+x1q9cVZ3ncLHZdLCJcA8gImBA6+1TFWmc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199018)(36840700001)(40470700004)(46966006)(316002)(6636002)(54906003)(83380400001)(40480700001)(47076005)(426003)(336012)(86362001)(2616005)(356005)(82310400005)(82740400003)(81166007)(36860700001)(478600001)(966005)(1076003)(26005)(6666004)(186003)(110136005)(36756003)(40460700003)(15650500001)(2906002)(41300700001)(44832011)(8936002)(5660300002)(8676002)(4326008)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 21:02:23.9139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 510de03d-3dee-4ae0-ec27-08db19cf1753
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds mailbox support required for rpmsg communication
in Xilinx remoteproc driver. It also fixes few bugs in Xilinx
zynqmp-ipi driver that handles corner cases.

Changes in v4:
  - split mailbox driver patch into 3 different patches
  - use of_phandle_iterator_next to get memory-region nodes
  - move zynqmp_r5_setup_mbox from zynqmp_r5_add_rproc_core to
    zynqmp_r5_cluster_init

Changes in v3:
  - split single patch into multiple patches
  - add appropriate fixes tag for patches fixing previous bug in the driver
  - make enhancements in zynqmp-ipi driver that handles corener cases
  - fix memory-region carveout names
  - fix multi-line comment format
  - do not mixup mailbox information with memory-regions
  - fix redundant dev_warn for split mode
  - Setting up mailboxes should return an error code
  - Move mailbox setup during driver probe
  - Add .kick function only if mailbox setup is success

v2: https://lore.kernel.org/all/20230126213154.1707300-1-tanmay.shah@amd.com/

Tanmay Shah (5):
  mailbox: zynqmp: fix counts of child nodes
  mailbox: zynqmp: fix IPI isr handling
  mailbox: zynqmp: fix typo in IPI documentation
  drivers: remoteproc: xilinx: fix carveout names
  remoteproc: xilinx: add mailbox channels for rpmsg

 drivers/mailbox/zynqmp-ipi-mailbox.c       |   8 +-
 drivers/remoteproc/xlnx_r5_remoteproc.c    | 317 ++++++++++++++++-----
 include/linux/mailbox/zynqmp-ipi-message.h |   2 +-
 3 files changed, 250 insertions(+), 77 deletions(-)


base-commit: c7d00a6f6e4c14b2e00bcf027e7c25057c7f2d3f
-- 
2.25.1

