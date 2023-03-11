Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ADE6B578B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjCKB0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjCKBZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:25:32 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731E319135;
        Fri, 10 Mar 2023 17:25:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUUYSd2YOEPS1kDy1ELlJHPcgndjQLwteJ39snU8311i39VNp87WxdX9f0W8BirL19sP5SYujNHki+DNqrMiM8mxveYhw/HM6J7fgzBrHnMXLUisFb21/ymwn8ubN1Oms2EVT+lq5L9VFhbXmswzEhiQyQpfVmyudigeeNK2XV0Qf/aq1HH02n/GoH6P/RMjFShDtryBHc21GdMJRUAIvDaLL3Dg5KZ/iI4wRCffSvBZnUw2e0Wgwiv3WyB3wfEIyPw5318PZCY2vrdJVFto/FU0RKy5b1WeoRTing0SOTvUnipjuM8qA4fNFVE+n5M6CHYZnvBZOTPK8cddYstyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6jNyKKEMKq2JsmiF1UbknBMFik55x77fbABVtgVr8A=;
 b=WC6dneXsc4eYpdQDqns0xlcoQEA86Z1AuvWfJk9g2xfZAq1MdhQXXIdecSEXMvZz20cWVdVGb1bMhcqoAeKI2YDRM9+/Dn1a74/wE42z2gCXWBvWrkEdgaPBtvddg1lDwBLeXHWgibESwQoiiQJS1yUul2DQbMPgiMUHIQX/T9ZXAXKAP93JfrLje+oFBW+hfONb82isuRJO6Xd8aqyFLaAC7lxu1oR8kbD+aZP5xaLWrgebNhdEu6RKp+m4Dc30CjVrAycvw0knVkZ2DSbF184acTjVpzbKJrm+bdrZGuXXoScjY+LZzGQTQmCuBOPC/ErHEgKbNiQX0qU8xPat8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6jNyKKEMKq2JsmiF1UbknBMFik55x77fbABVtgVr8A=;
 b=427pFTT+7LCOTizruVv0lvwqXGQGTTCa26l92LzP072gLgkeo0xhj0fyRNolPbrAmupA4d1GseQoYn1tcvwbIfTSax2ZNCAKu19hhLnGVvnDFaCkzpGHe4Gs0xfhYOed0G5WvyNpGcBJN8PHas7UWSHcj0qbQoOJMyqyxwFxsC4=
Received: from DM6PR07CA0131.namprd07.prod.outlook.com (2603:10b6:5:330::19)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Sat, 11 Mar
 2023 01:24:29 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::47) by DM6PR07CA0131.outlook.office365.com
 (2603:10b6:5:330::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Sat, 11 Mar 2023 01:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.20 via Frontend Transport; Sat, 11 Mar 2023 01:24:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 19:24:28 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 10 Mar 2023 19:24:27 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <michal.simek@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v5 2/5] mailbox: zynqmp: fix IPI isr handling
Date:   Fri, 10 Mar 2023 17:24:05 -0800
Message-ID: <20230311012407.1292118-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230311012407.1292118-1-tanmay.shah@amd.com>
References: <20230311012407.1292118-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6fb445-9e98-46d8-0dd2-08db21cf5c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHzJwgLGY766Lp56Y5rNKSTgbuQ+KI0FZcbX/P+zL5cvpMuA0qa3dzBBo0vHTwiRu5yGbBaY4RSkT5nZFXSW//TU/M5z6R1nwDEIxeGR/i17ISYSiHwAkC0co2br7pETOZe9LhK6d9iDf/XrMnnpfnq2AnnTXIcop1nARzki914/kthIsZ5ZtnAGuV6AsxV/4uXogHNa3usy0NxbVZzsxccTwfNS57B1i5lasz1Ow/zGsS/earQqDq4N8SyFekmdX99WGqz8ulmgsomGmYGWN+TK9YxZk43gBAs0YZmncCBDOYaz5n3g5E3zHIm9qTyJUqaOxKD/uvqlZ+Yw4nW129Kt4uXPFrDidfbdHspYF1NVwHekKTOk8UAP3LUFtvLh2PmzonXuYyBK+hvTcjKCLUEFTm91I623h9kef1uzhvMM2l71C9lOZlXMsSOLL8N2Muro+8zkt+hdYL7SVxFmSEgaXy3gG4I9ipUZOkjTiZ0dfaMVbzFbHK8PwXYpu/73Z2zCKG18ONZlX5HezLL+GaZHlBx394+Y0iI02HAj4qTlp6FY3pRiBeQQMiQAgX245CmJ8qD39Fuc6ENAll/xcY1tuvlvVSCUVlStCXpidc0Ge43PuK4utGNJBF9Ru9nTohaGppyyUuonNXeUS45RwVR4jJ1Q4Kaw80GOhVAb5w4K1kT3BoJYbVHMF9S6sG27q9fdxBrpITgEI9mjMlKJ/l+2Q0qRJ5zGMWG2kpm5TQg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(36756003)(83380400001)(426003)(47076005)(82740400003)(6666004)(36860700001)(26005)(1076003)(186003)(2616005)(336012)(40460700003)(8936002)(41300700001)(86362001)(70586007)(8676002)(70206006)(4326008)(2906002)(44832011)(5660300002)(15650500001)(356005)(81166007)(316002)(110136005)(40480700001)(478600001)(6636002)(54906003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 01:24:29.0679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6fb445-9e98-46d8-0dd2-08db21cf5c2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple IPI channels are mapped to same interrupt handler.
Current isr implementation handles only one channel per isr.
Fix this behavior by checking isr status bit of all child
mailbox nodes.

Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index ae47fbac38d2..d097f45b0e5f 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -152,7 +152,7 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
 	struct zynqmp_ipi_message *msg;
 	u64 arg0, arg3;
 	struct arm_smccc_res res;
-	int ret, i;
+	int ret, i, status = IRQ_NONE;
 
 	(void)irq;
 	arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
@@ -170,11 +170,11 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
 				memcpy_fromio(msg->data, mchan->req_buf,
 					      msg->len);
 				mbox_chan_received_data(chan, (void *)msg);
-				return IRQ_HANDLED;
+				status = IRQ_HANDLED;
 			}
 		}
 	}
-	return IRQ_NONE;
+	return status;
 }
 
 /**
-- 
2.25.1

