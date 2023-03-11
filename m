Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9783F6B578F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCKB0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCKBZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:25:38 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA4E13E50D;
        Fri, 10 Mar 2023 17:25:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKRX6fY3A8MaKAIJebBCdPywgqlAMMOpVjCKIjBNlf6UtMdkoLfTqVUHe0QLw0zgjQNWMLYVz8Dj3P6Gh9rtrMT9X4x3NkYMtbosbEvbnk7NOiSEE1H2ovc62fnymkQr0MVSK4iZH0D2bQnEamR59+loKZm8hgh/w7N31fhUB+LKpvMYaJl8J+MxbCoPMdH7z+OZKvloEA56IQicI7RZmfVjgMwpwqPSF3qV/7lw2H62+KVUH7AyCegh+9rbgMKw0O0srkp/k1nVLOxg2HwbVkDvRap1x8L3YdUgVYtmNddMKsKzNPXvsAz2qoEZDyR/R0e9dbQMZZuMJpZZ0nOPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ntPHILyKl2B6cfodi6MlDi1IviUtfZyL+6c62G5yqY=;
 b=AMrclQ/OwtJaKXQ2Wm0/3KvIm9sX0MqFFOlYf1E6XdAsmHSfnQlGHzRBInseYt6lMvF4l71bx6MNkJkhaHp4S29dFh5F0JpNN6D6SxMv91ArW63BVoOklFG22bfa6mx10ZT9H2fcQiqZcVk7yhEO+hR6NyvpZGuja0le4zdran8DGIylwu7z6sM5MCSmJXNNkKLNxxqIGaF5uM0i0VlIFmk8R4tlmB6giJijVwJZ2PuU+KvflEGWr0baRynIUvyjPxOTV11yi45ZKar9f+l2zczpD7fOZLYktX17LfGo3QvzdjRX4f9I11QCM16vxZZzkKgxTgj8p+RtNz13qtDthw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ntPHILyKl2B6cfodi6MlDi1IviUtfZyL+6c62G5yqY=;
 b=be3F53iwmslp2uqnd8tuLFoP+cR/HQex44+oDLdrU96PtO+LFkpGOeM//oE4B54+/cb3ldPVWIHkLhPnDdnlohnWrYfi+dzTyXiO5BJf57VaBYSfjgreboKMeuEPCjMBOKxHHOWRGXMjmr3o1Sq1fNIeIugnssQ7/1qUR4wDSpg=
Received: from DM6PR14CA0048.namprd14.prod.outlook.com (2603:10b6:5:18f::25)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Sat, 11 Mar
 2023 01:24:28 +0000
Received: from DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::87) by DM6PR14CA0048.outlook.office365.com
 (2603:10b6:5:18f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Sat, 11 Mar 2023 01:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT114.mail.protection.outlook.com (10.13.172.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.22 via Frontend Transport; Sat, 11 Mar 2023 01:24:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 19:24:27 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 10 Mar 2023 19:24:26 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <michal.simek@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v5 1/5] mailbox: zynqmp: fix counts of child nodes
Date:   Fri, 10 Mar 2023 17:24:04 -0800
Message-ID: <20230311012407.1292118-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230311012407.1292118-1-tanmay.shah@amd.com>
References: <20230311012407.1292118-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT114:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 81debf0d-7d45-43e9-532b-08db21cf5ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zlsMHE4zgO7LvboKST9Uc5uMZZzqodIwK7WKlqD04EkI6lSgFxEWIMoxFMXSD0QXEe1O2Y6rqX6LsPBb8bTlke/VPqdKF1uiHlIIctlDgTQbrPxCjbDOHszV4OvSZpvYz57avSgx6jsbU0mvcbTxP/KWmTwep9dR2o3T7XKCxc2mnRTFxS585OSbYvXa0rQB9glvsQIjoI3GqPiJJbPqf20AD1Oqp461rz0oTkyPFyBwZEztt2A0xxx9o01fjO3wKyE84MWBMtHDHWshxXE0RqP2R2IUNVlohnCtljNlfhZIy3liAb6TrSTneQA0qiyOkBl85Idp0IUNVsB+LhtTcOsciAox++Mr/oqVS6m3fnPeqPBTOpHTpYYsr3Tf2RfgHOXpw3GZ6fwWkAGjG+qz1QGKZSBLvWxhz1SaD89Z4S30ylHiApnU0riQmyhP9Ripjjv/nRgFo1hzCIb0H/74OPKgnBn88qvJQYWoW6dujTnYpV1BEyrJBsKsftFbhI9OhVFgJ7UGW0PZVvMEN5JhPBpv3CvW+LuoyDwmNirL/GReW5SM+4QcHtRhWaCBICYsY1crOdEfsSfhsdoNRfj93YKDNdMCJtGAjAGDkNGDTgWLoBsSAQOcvdr0scsnpdZ1BfeqQY3+n+onOB48S4uP09ZBn0jQzSxLXaR3ErOiHvJ7snNqfka+qVIHOdgPA4CKuytQddNtSpg9y0jBz0bgfiVKy9NMyqICY7MBT4jkY3M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(44832011)(15650500001)(5660300002)(26005)(2906002)(8936002)(36756003)(4326008)(70206006)(70586007)(8676002)(316002)(110136005)(1076003)(356005)(41300700001)(40480700001)(6636002)(86362001)(478600001)(54906003)(40460700003)(6666004)(36860700001)(81166007)(82740400003)(336012)(186003)(2616005)(426003)(82310400005)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 01:24:28.1849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81debf0d-7d45-43e9-532b-08db21cf5ba6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If child mailbox node status is disabled it causes
crash in interrupt handler. Fix this by assigning
only available child node during driver probe.

Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v5:
  - mailbox node count should not be 0 for driver to probe

 drivers/mailbox/zynqmp-ipi-mailbox.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index a4c8d23c76e2..ae47fbac38d2 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -634,7 +634,12 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	struct zynqmp_ipi_mbox *mbox;
 	int num_mboxes, ret = -EINVAL;
 
-	num_mboxes = of_get_child_count(np);
+	num_mboxes = of_get_available_child_count(np);
+	if (num_mboxes == 0) {
+		dev_err(dev, "mailbox nodes not available\n");
+		return -EINVAL;
+	}
+
 	pdata = devm_kzalloc(dev, struct_size(pdata, ipi_mboxes, num_mboxes),
 			     GFP_KERNEL);
 	if (!pdata)
-- 
2.25.1

