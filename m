Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160226952EC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjBMVTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjBMVS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:18:59 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856321E5F6;
        Mon, 13 Feb 2023 13:18:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ng2FLe8zDxKYbysHELtcGaUi6SEusHcXbnDuARemcLqYNHKEMKheNcWWZkucENztwri0q+szUu0bK9lAly3Dfmk25RGSUdNiN2Iw2kddhXTIdfJxy1ZSbnXerUZcbUbKMiYGcaRntY4Hh/W6WPNBMlRIbm7qZLQrfIIgvjroDbkEzdWe99Vkwo+H9l/EG6AJHKc2nVrxZIxMT1JO5DoHQ8QwjC8C4dX4vSutEHmsdU7BaBu5aozbvLa5JVdKMPmiEyTLxgZQ6ObUZofvAPQPluliiDtWyZO9XBnwPQ+jMp+8e8mDs0KAyDBBMgmCh7ceOUtEGB1bnnhiwuAHozHbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUxTS014iYqypWgDAL3HNgFUleD8BPDybE4UOEA7RnM=;
 b=SOnlfSQNOmEGLfUyXFLIK7oe2KgN0AFo9/n//tEbViZW82rEAeQbeV7MbzoD/YEJTVhrWIrWi9GjjUvYHMdHrsMkVB6Zzmx6sfzk0uX+hQlM7otMxVP5E6vq2BUpAiMw6+oJHoFormYv/K1oN8vfk73uo6DBoOXHTQnuI7PXk0VukS33VcWRWOfMwzQ+iV9WupcgheeO4G4Nhots20JjqhpGr4UmWrxK+ApBkQojC1czawj7rX2bj2HmAlIc4u5j6cHTrFS2HU0QD/ZW43HGuz/6oQS+D+Qnb7AF2HYiPn9V5222w4saH8sJYb2DVmCImZa6MZRfr5+e8VaGQzYJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUxTS014iYqypWgDAL3HNgFUleD8BPDybE4UOEA7RnM=;
 b=3AlhwlBttIQEetDvU3xse3Ll7uquDxP+oWCV+3x8Ao/pZ03+TMs6o8PqUx2VRKZqEY538j/bDbHY4vMvMOAqdnyFVr18dcIDhKFyYJIP7SLxO6EDxFZFqAuxpJyameF2hSV7+983uohtwKdr3yiskqSLMN4NR0OmYDUexhcPwMY=
Received: from CY5PR17CA0056.namprd17.prod.outlook.com (2603:10b6:930:12::10)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 21:18:53 +0000
Received: from CY4PEPF0000C97F.namprd02.prod.outlook.com
 (2603:10b6:930:12:cafe::80) by CY5PR17CA0056.outlook.office365.com
 (2603:10b6:930:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 21:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97F.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.9 via Frontend Transport; Mon, 13 Feb 2023 21:18:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 15:18:52 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 15:18:51 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 13 Feb 2023 15:18:51 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <michal.simek@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v3 1/3] drivers: mailbox: zynqmp: handle multiple child nodes
Date:   Mon, 13 Feb 2023 13:18:24 -0800
Message-ID: <20230213211825.3507034-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213211825.3507034-1-tanmay.shah@amd.com>
References: <20230213211825.3507034-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97F:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a89218-4513-4ab1-047d-08db0e07e83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SM335i4OP2OwEcx+rlCTqIwsuX6Y8dEGqbjPB9XVkV2/mdXmGBz5A2dHhX6ySwYWwc4Lplk14fAhVxJJXAs0xZcT/qNN2CsTrEHeAw+WVPwK65ZhdGdEoZ7Bu2lFWnoeCeh+NazZF04RAUte4eXinysgM7iEKofrsZXRJUI2DoZRUHalfC7L8qa7piN9iTcWUXspNnQsCJgkyPn6sshWO7I9Z+Aq3EmELoZHUzZMfAcpEZI5PD7/AtqSdPVdS+0QxyqldSaak4QAPpbdda8jCaeoYLamGLLKy0Op5Kh0ancH+vhD+Qnpu6rG6+iXllKu+4OhEASvCQdf2tkBrhEM5g/4j8eIJDwwgAMO8ippGERcjY+fRCnR7V+1XtzFeru4P+J278Rs84Z9U4J108ctLtQuy/lIuaUOlnUy6VPYE97Iv/JHkOVJBPh0jpR9GLHrjXwYo5xUt15p5QJNmVdk8qkYavF1bzkF4XqyPEZnwXhwMmaZRpLXWoKqp4NxIpBWw6YifPhEEMtrTBI0RaQXwoWryYsWvScEJRzckOpJB9AbdS8QUoJreBWcjMKkth+eKyFWkvIhxojIYt6jW1jzZaasM90sreeyTFeilpoGUVN9uaNdPXOeOvUJUjt3SFA20WlHC8BzOdHtyYA6T+1RoRZhOdD4ZTCX+ow1ogb3IomvW0KACXgP4VVnnRdg+ZUxMuSn/QlZteomZVaxgefUyKmkjWy3D1MCcI1J0sV96U3j4eE1/ai7ND4zHob9vjb5AopTMhRskEUIaX0Qhep9hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(36756003)(5660300002)(2906002)(15650500001)(44832011)(83380400001)(47076005)(426003)(26005)(186003)(336012)(356005)(2616005)(36860700001)(82740400003)(81166007)(70586007)(70206006)(4326008)(8936002)(54906003)(316002)(8676002)(6636002)(41300700001)(6666004)(478600001)(40460700003)(40480700001)(1076003)(86362001)(82310400005)(110136005)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 21:18:52.5836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a89218-4513-4ab1-047d-08db0e07e83d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of now only one child node is handled by zynqmp-ipi
mailbox driver. Upon introducing remoteproc r5 core mailbox
nodes, found few enhancements in Xilinx zynqmp mailbox driver
as following:

- fix mailbox child node counts
  If child mailbox node status is disabled it causes
  crash in interrupt handler. Fix this by assigning
  only available child node during driver probe.

- fix typo in IPI documentation %s/12/32/
  Xilinx IPI message buffers allows 32-byte data transfer.
  Fix documentation that says 12 bytes

- fix bug in zynqmp-ipi isr handling
  Multiple IPI channels are mapped to same interrupt handler.
  Current isr implementation handles only one channel per isr.
  Fix this behavior by checking isr status bit of all child
  mailbox nodes.

Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changelog:
  - This is first version of this change, however posting as part of the series
    that has version v3.

v2: https://lore.kernel.org/all/20230126213154.1707300-1-tanmay.shah@amd.com/

 drivers/mailbox/zynqmp-ipi-mailbox.c       | 8 ++++----
 include/linux/mailbox/zynqmp-ipi-message.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 12e004ff1a14..b1498f6f06e1 100644
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
@@ -634,7 +634,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	struct zynqmp_ipi_mbox *mbox;
 	int num_mboxes, ret = -EINVAL;
 
-	num_mboxes = of_get_child_count(np);
+	num_mboxes = of_get_available_child_count(np);
 	pdata = devm_kzalloc(dev, sizeof(*pdata) + (num_mboxes * sizeof(*mbox)),
 			     GFP_KERNEL);
 	if (!pdata)
diff --git a/include/linux/mailbox/zynqmp-ipi-message.h b/include/linux/mailbox/zynqmp-ipi-message.h
index 35ce84c8ca02..31d8046d945e 100644
--- a/include/linux/mailbox/zynqmp-ipi-message.h
+++ b/include/linux/mailbox/zynqmp-ipi-message.h
@@ -9,7 +9,7 @@
  * @data: message payload
  *
  * This is the structure for data used in mbox_send_message
- * the maximum length of data buffer is fixed to 12 bytes.
+ * the maximum length of data buffer is fixed to 32 bytes.
  * Client is supposed to be aware of this.
  */
 struct zynqmp_ipi_message {
-- 
2.25.1

