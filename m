Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334406A60DA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjB1VCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjB1VC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:02:28 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A1A23111;
        Tue, 28 Feb 2023 13:02:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOBY0+v+XbJn5XXDdS84N6J06jj/uCHu9CpF1MYlUye08cPYZtEMu1kjAryFJaCzF+BeM+VSLQIWDs3TryG5/4WKiPrmI182MoTp184PRWCbmV3Y43HdKysd0NYkZ1D0G9krvyvpNoCBbNkPZp4ylU+gt4TPTgUP/phXBri3TyGTwjp/DMiPWi0bFZJ8e6E5AeY7zLMZP4kWdRmzQXwjNXi/q0u/EJ85aJtjzUl8MPy12m0Be2En6noiWQddD69glOWpIvfJZqQTl8APOp6R5jSBnJWXvZfoFTf9e7aXcxGjLCGZj5otNVj29Ewswf7nYQy/ht9m8WcujUI+r5LwTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FW/g/aYeDD6QlIeLozEex9991fetDVWFOmaEqyxZ55s=;
 b=oCbUB+aJgxrIuc7JkBsf2OyRwRTecFnI2Yj4pUNJVTkFrP42dSeBbR/UqoGKPAXICxNg+BBJwYK+NO/VdumRZGwdELsXaKuyZykXuMoYs5Pq8frRLG6ImjErTYDSfCA1P9I/j+A6KuObmfkKEwAnTPgXuSrKrCzFhYCY7ddLT79qfV7LXHceWB3H2VGi1g0QDmhgAut7KbEtdPd444QszDdXiBPwUc3/WlOcdZ8VHP+vEjFQWNZLPrecRrmk9qi8moY2XaK7F//pWdvg6je00B5hznRZfurAm/alDzTppoh2BDxvzUeCUoJzmXGYE8ESUIysnUOBqq1YkKH2jer/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FW/g/aYeDD6QlIeLozEex9991fetDVWFOmaEqyxZ55s=;
 b=G0G9Vx6tT7fZJCK+j/NLIF2yBII0SvopPAGcUCxFEkF7CNZEoIE5XIyEQ6Rg65M/ZCTKPWl2ur+0TelByk9oMZHjwsS5VL5Gzv+tm1Jvl5p7Gxw2Ccu0aAsU6inTh4SnlsCOmpp312HZ2Nmd/F5CqKkPB91K6HnqX62yRaSqqr8=
Received: from DM5PR07CA0114.namprd07.prod.outlook.com (2603:10b6:4:ae::43) by
 MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 21:02:24 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::b3) by DM5PR07CA0114.outlook.office365.com
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
 15.20.6156.17 via Frontend Transport; Tue, 28 Feb 2023 21:02:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Feb
 2023 15:02:21 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 28 Feb 2023 15:02:20 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <michal.simek@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v4 1/5] mailbox: zynqmp: fix counts of child nodes
Date:   Tue, 28 Feb 2023 13:02:12 -0800
Message-ID: <20230228210216.447373-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230228210216.447373-1-tanmay.shah@amd.com>
References: <20230228210216.447373-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: f093526b-6881-4b89-e823-08db19cf1791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYPnKj81SKv5WbXWbT2N6/WFGBoFheT7WLp58vLTEUaMsHBQmYdlqPVQXDSJ9I+9R/SIBouRmCNJ3SW4h3L87Hz+CPWUrgaiktic+ZqvupQc9TJyOXzekNPkLnaGyeFps0nTdR4JYlU+CRWhbb6gwGz+348Cm6oCKQr/dAiECjyP9k9++Xag4MiwZVMCyOSEGgxe8FI8pgq9TSNnjbdppiucRlT+kNjg8JqZhiOy+h/2am5MKf/g2N68sRqaHi70Qiza6f1ckmdma0lv+FEwWihAHqJOdQmxYp0S2lRzN6hvYs7jkRkWhzJhjLN2artGxHXRoEDTajfP0AsI/g9hwAUFcf8dbtGBH4a64oxrHuktSp3PTEfFet0E8swwpAuyslS1hI9zahJBzXfziAnguQP+CyAUxEMmDgGEER9kdiApl+Lc5SWuik30Smx2v2SUGKfaGq/5TqX51Ovt7vODQFPM+md8xyQYqqSVIvF0OztrwN4HjJ4ewYI+zwtqkC2VLn/dt3pNIfa81LC4Qx8Rqa261Aj/Cghpir0+PyINOZz2vaZ/TpYPwxvB7X36Eb6ADrK4zZiCMPd0kD6JZF6d4pi2orAUE/9Y7c++fReUCp4nIf7Kryy1PgVFqT7PFKcFnryLhQBGh5jva2s4574BhcT2VwNVjv2Z0uLaC0ie6aRrezJuPaJjVgxondE0c6tF3vlgq0xrOIdL+n+D94ZehkZcPZd5iGhyhMI8PKQCHb8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199018)(36840700001)(46966006)(40470700004)(36756003)(86362001)(70206006)(5660300002)(8676002)(4326008)(15650500001)(41300700001)(8936002)(40480700001)(2906002)(44832011)(4744005)(36860700001)(81166007)(82740400003)(356005)(6666004)(6636002)(478600001)(54906003)(316002)(70586007)(82310400005)(83380400001)(47076005)(110136005)(26005)(186003)(426003)(2616005)(40460700003)(336012)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 21:02:24.6638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f093526b-6881-4b89-e823-08db19cf1791
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If child mailbox node status is disabled it causes
crash in interrupt handler. Fix this by assigning
only available child node during driver probe.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 12e004ff1a14..e287ed7a92ce 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -634,7 +634,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	struct zynqmp_ipi_mbox *mbox;
 	int num_mboxes, ret = -EINVAL;
 
-	num_mboxes = of_get_child_count(np);
+	num_mboxes = of_get_available_child_count(np);
 	pdata = devm_kzalloc(dev, sizeof(*pdata) + (num_mboxes * sizeof(*mbox)),
 			     GFP_KERNEL);
 	if (!pdata)
-- 
2.25.1

