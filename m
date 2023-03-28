Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF786CC87D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjC1Qud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjC1Qua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:50:30 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6CC1025F;
        Tue, 28 Mar 2023 09:49:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYCDPwmiIp8UMkU+2twGoDISShyzzZKWwDuSNwMJBMMmwV5CtV7dnWknLagtOxqs/5uy/v6QjgQ97xqy/MIDpBhBHSCvhHAJa7Ln/HxTSuP2rXTAgBr1OzLc5wCa02IStLMyrQhQ2ClK7/AAjZMM3tC7119wLVVwHZAgB5NnXiP77r6UcpEdBfeNQp/NMEMPjCF3m8h9c7Iz7BmjNyE3p49rOJpaa85iFCdA+H+rQCMdhcJweSrs9gQcTemunmLBGa7rcghJ8vZrk2tYddiwQv4TwhVWzAw5wASFvsiRawHrac6qzxsVbFPIOp/6BGWlV1N5r4T3wpHTKGw1ABXVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGzDELjD1JXsU+fFJ87JsZE+0HoE3FC/fuLUhKJSPo4=;
 b=inVGWjz+PUIXAv2PyIjvZE5zYy2STLt5qaEDMDnMPIFZM0wfzMWEHCRrWiUnikdZZEru9Zlw05o6aDS4iWmevABCLQkquQKf9CMU5LzqSSyImGPJPA2FD9FEmlwPGHs2YclJp+h7UEwWwCSIN7S536ZeqpWGj8lA1KjjWcFuwuso0YjPDntci7pP32UzHaf089ndOn18ubUU18QNmfdKRKARki80El0xBGyc7b4tmDwlq0fVNdltFw9osY4LZ37x4HrPs4f8xBTyhUmhXrSHiBwRvqbew+fAu3pvaRkWWPBdh6WESL4L1rCzTaNxbnHxIgwRKxhY82hshIHTHSrwfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGzDELjD1JXsU+fFJ87JsZE+0HoE3FC/fuLUhKJSPo4=;
 b=UVeI+KXez8s4UuhcvPS4OtZbtFKAcvy43wqn2TLxilFRvfqckUF+jHvbU6tfttleMU8Eb1TRqayLniqi5nIP1y0Vj7EC5XgPBbS18/H+zUPWH1xW28ebitnL+V8sDL2okPo+5DLijRgkB+9c/9UglaZ3+/sauJsjZ4HlwrBap4g=
Received: from BLAPR05CA0035.namprd05.prod.outlook.com (2603:10b6:208:335::16)
 by CH2PR12MB4907.namprd12.prod.outlook.com (2603:10b6:610:68::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 16:49:45 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:208:335:cafe::43) by BLAPR05CA0035.outlook.office365.com
 (2603:10b6:208:335::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Tue, 28 Mar 2023 16:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 16:49:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 11:49:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 11:49:44 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 28 Mar 2023 11:49:44 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v3 0/2] remoteproc: get rproc devices for clusters
Date:   Tue, 28 Mar 2023 09:49:20 -0700
Message-ID: <20230328164921.1895937-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|CH2PR12MB4907:EE_
X-MS-Office365-Filtering-Correlation-Id: f6622305-543c-4b30-77e4-08db2fac6f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hkV4LJtH3XE01v2uAH9/UI6Ygy+JU6tiI7E1wzx/GSyWnYz+CsE7hEHsvvESRmAGsZEHXp541ieegE5V0wUoFQ5e9M641PUI92dSxlEOZK7po7Jh+uuEzLkdueqVE+K7SOau7ewTWsuVu1JeJEO5Qnihf9x3P1YF89rA+TSeTMxgeR/VX51gA5gEBr1Z6ObM42TvmFSSKjCupjeqaB5NY/SybmXIop3mnJ4QaFiTffnn85EXoEOqM2vUTVO6vbifc5ZFSMHTkdFJron4aJbJUMY0T3pjkJXL91o53FH3B7vT0smEP2VdfKfXkPqEPs6gK8juVXr1w5lO0i+fz09+pyPQWBLfEL8pI2g0Rvy/3GNiSYB30FKiwLUgdij/q4onnsJirZNx/2KRRow/TQOQW4Op88ftFYLH5YQ8vx3r+ISsGOxLjKygnEsf7cdRCkDJQpxXAbCLonNrgUSwrVu7BN1loft4Kt0aQXiWmUstsYpEZNgUg3PosoP1iPgoP1dzN7d+M5rwlFwfUqxP6RzR//tUAClTIMSZF4XUfQh5A1gj2BNn5ygg2gd50IQbZMjhQhcBGsGIYnwjxZ2xhnQBmsHUg/r4NTdz8uNRgvaihzMqBUdf0I6+SzhQIYKrNDk8x9h0p5EsTJdQhVNzDxY7g9wYOwV0UIcZPSi2Q7MbI79RqsZarRVa+sU9LXRtgRXPTrw7Rh0ezv8pumCxm1SQNfr4ZnXL3GiwMN6uZ7fwkeQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(316002)(110136005)(40460700003)(36860700001)(478600001)(54906003)(356005)(81166007)(82740400003)(8936002)(82310400005)(36756003)(86362001)(5660300002)(70586007)(4744005)(4326008)(44832011)(70206006)(8676002)(2906002)(41300700001)(40480700001)(426003)(1076003)(186003)(6666004)(26005)(336012)(2616005)(83380400001)(47076005)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 16:49:45.2586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6622305-543c-4b30-77e4-08db2fac6f68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4907
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends original patch and makes rproc_put() work
for clusters along with rprog_get_by_phandle().

Changes in v3:
  - remove module_put call that was introduced in the patch by mistake
  - remove redundant check in rproc_put
  - Add inline comments in rproc_put that explains functionality

Changes in v2:
  - Introduce patch to fix rproc_put as per modified rproc_get_by_phandle

v1 is here: https://lore.kernel.org/all/20221214221643.1286585-1-mathieu.poirier@linaro.org/

Mathieu Poirier (1):
  remoteproc: Make rproc_get_by_phandle() work for clusters

Tanmay Shah (1):
  remoteproc: enhance rproc_put() for clusters

 drivers/remoteproc/remoteproc_core.c | 45 ++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)


base-commit: e19967994d342a5986d950a1bfddf19d7e1191b7
-- 
2.25.1

