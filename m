Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B8D5B5908
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiILLK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiILLKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:10:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05B01BEBA;
        Mon, 12 Sep 2022 04:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUReH6nfX4LMDY4kygbZVsTDxuLiOciy1ldZ7s2ie85PghWC5FesTnAI3l+6UAZrHSNBYKsAyFcee78W45hsmr/Z4EIxl8E8LnXDImdAhl03/riHleb+X/TPilPj7b2rAB8Ug2nPWaa0kSwSXindu1StVBCeda7yQTeWWbRcvT+KoqFHhq0v17KIPO63YhJOgDiWauudtmHnvTsnCg9RnrwAZq1WlAaN+oC6XhuqvaweODk9lOQxU8lFQ6KrVHozYW5Izpn4DZ10wd15Qr++hB78lA6Zbky+dqz7nKe8rnPXvzw5NMB/Sr5AWX1DQB5WAbMfSBn8h5fpEc8Ygp8OYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vq6IWRbaCjj8DJ+AUcQzFA7LZEfjJ9B5DeHyqys6wQQ=;
 b=h87lHUgBl/iS5LDl3UsfC+EINg9SHy5FKdW4xhm/eQFPhwewf1+kH9Zheyh3blRMA8XQVphaRdfNi8C7R11u3+QU2fj8d3+CsP07+L6D70ci0M6iN3DvoHvHw5CPypQbAghjgEKsGrxRSZAMlBXQi9an9jkOB1Uk0FDnMa9oM3MZqvW42A0j7H/EEbCxt+/VvXE+MeXhpOLDBh/vvK1tnH6mV6FjIPNpjWphyfwf8xYmu3GgZO/vFFLwuGhTADVdxxntdmo/IP8w0lcbtPwaQBsS+VJLTjymy1hSiuBVzd/F9nHmiUpXhMPQMFto+ZZ+AUCXDw3oPYa0kT2uThB/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vq6IWRbaCjj8DJ+AUcQzFA7LZEfjJ9B5DeHyqys6wQQ=;
 b=RYXYbRt1YyXI+V6baDxIGLx6ailoPPRrvEhvIWID1Na94yrS2q7gtvFMF7JkaaMTdTt/paRCQxcrKCQqJMfKz40JLmCb0WyVZPSBLcOJsiBY/8L3mVno3qE4gmQV52GU7kccZhhwd37NDAoL8lXlGGGxCJqiSxMnzePFkWx9bwY=
Received: from MN2PR10CA0015.namprd10.prod.outlook.com (2603:10b6:208:120::28)
 by SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 11:10:48 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:208:120:cafe::65) by MN2PR10CA0015.outlook.office365.com
 (2603:10b6:208:120::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Mon, 12 Sep 2022 11:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Mon, 12 Sep 2022 11:10:47 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 06:10:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 04:10:34 -0700
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 12 Sep 2022 06:10:31 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <michal.simek@amd.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <siva.durga.prasad.paladugu@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 0/2] usb: dwc3: xilinx: add power management ops support
Date:   Mon, 12 Sep 2022 16:40:15 +0530
Message-ID: <20220912111017.901321-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C409:EE_|SA0PR12MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac280b1-ec54-4ac1-7462-08da94af720d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WA9hQztYeL/Ra62snEBbv5VTJkCFvGtVJLGc1LETkE6cEcwQxZGTG+3cgGbErm6LC8vS+GkKxa97+77MJwmZFZqadoso5C+A2xYyQQ+jZKzSWPphwx/67IJsEdjuMsWsTm63L84e3Dj7F/DQTDtHZejI4K4U7i2yk7TAVhgV6dK8KjT19Oh6O4fOYV3JQl4EYzUoIkEqWinSzLdHsxXPPOKCQOc12+9x+GLZBD4QJOLSrX/10TTSK8TPOld9PB619yA5jQMSvR8j79UiWINmQIgVabcNMu/wHEBq5yu16OMCmhURk/IoUPv/QoAXV3rPHmH0/+JrwHFbyqu2INvZZw+3Q/WVpAvggjXCcUNhoSGZ9V19Cga9EoDUFopVrZ2FdlJ7PSvraCLbckiBAwnDmiDVTPdM+bWtg0j5qZ0x48F95hfw8HEFFldRaoGtIc0cVLoVBoiM9H/XI1UgK0W8r8MvWO2bVQFhb/yJleTkKWs4PcGNmu8S68UUvT/wWBhYl5fwd9b5YvkvJ5ra47VyTb0fEHnkMZ6O5fQSm3wKPmIdC/H6+6OLEX+XHJmsRnohxQGbx3zon805pbBh7TT5NNi1ppMVE1+wD0V76umLFKBS+qNACpGjgZjzVhrMnHsjIkbTa98gY5uGlXUmIqWd2TMDwvVhp5L4NKJNCmmpiuysvfWKkp24qAVzfreGe+tAKd1d/RfguqZsiaTE+zOqc3YpiVUKO0jY13+OVP4lbfcpi0ujazJwUPxVi4fKj1CGCZtZAdybEzUiNDSihMKv7FYVhsOTwqbI+mkGHdsCbq/5jV5W3jWQCmHaYhbxZCwQGwUZwExWL6EU8ed4KdWNAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(40470700004)(36840700001)(46966006)(316002)(336012)(47076005)(26005)(54906003)(186003)(40460700003)(2906002)(6666004)(83380400001)(40480700001)(426003)(2616005)(81166007)(82740400003)(36756003)(1076003)(110136005)(41300700001)(478600001)(8676002)(4326008)(356005)(4744005)(44832011)(70206006)(70586007)(8936002)(82310400005)(36860700001)(86362001)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 11:10:47.9393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac280b1-ec54-4ac1-7462-08da94af720d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch of the series does the following:
- Added power management ops support,
- Updated phy initialization,
- Added phy re-initialization on resume logic to resolve the usb3
  non-wakeup source resume-failure. USB devices are not detected
  after the resume on host.

Piyush Mehta (2):
  usb: dwc3: xilinx: add power management ops support
  usb: dwc3: xilinx: fix usb3 non-wakeup source resume failure

 drivers/usb/dwc3/dwc3-xilinx.c | 63 +++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 13 deletions(-)

-- 
2.25.1

