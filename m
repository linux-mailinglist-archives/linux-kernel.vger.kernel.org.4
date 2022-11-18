Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560DF62F016
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241496AbiKRIwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241591AbiKRIv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:51:58 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2079.outbound.protection.outlook.com [40.107.247.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D6EF2B;
        Fri, 18 Nov 2022 00:51:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh6CUUnFajxLCAnD3pMIketK52LhKV2reWf73TwUYSJDnK9JjlBjJTPQekCE0ZKA5UKja5iI91jY5KdK/FDCso50iIV4sbFsI4waiPKZd6Uxs9MO2OMERp9ynGealjUCS9yq2Z+F8nYOkN1JqN9Mv0rkxMgO/IE9DN8Lf/1L27CENoHGupVUAqLto5VCc7sO7cOP534LhFdu4CDPYdDaMGJS4kQFMkZZJrHZ7jJrRG00y27/Q+edAWbmz9ZyqPaSj+gtm7omAIFDPUKbevrUdHwIazuYqoMawiD3X/yDBUX613ev86KMJiGl7nPCmYO9p1U5eVT3WP9/4Lo0iXluSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkpBjTQLrU/SYz0p299mNmxNibbVm0edBOAvPoLAoQY=;
 b=KMzA/K3RzZfzFyzFZJ8g1TEUZEKme0ulhcfTWEpylCEUWKZgcQhYslHbfnNgZSdZBXktDffGBYAe3ZAV60GXxyjyXEqlDiyaNYJ3bDy055DXZ7g0LDX8gtpjX7Ql1MVixmiSQhBFEtNKlIuNb3zKJga1aIZPge9DStc3BQHBK5rzbEVm48ZGElqwL5UZ8jSQNSh0VSrUDTDXXqmJGCm/A7evPEVAomDMkMl6CQdoFhtvSx+ltVMA+CkVJZgwUaAR96zEK0hJrhm47by5Kl9SwVrNVTr4xZLnH9ybnfxdB7VmFmQBsLaRYRj+nS1IBwm0f8z2XPJXBTDxyUFVIrw8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkpBjTQLrU/SYz0p299mNmxNibbVm0edBOAvPoLAoQY=;
 b=D029+58efF/jha3NtjML5FsJy1+JRqpid8MwWf7TL6wvHD8ZDZ+BuGZkSXdud8+gpXZRKr6uweVPZbfVrzoFFXr+YDk8x66BtWDrjX/4kd3seukvBvV3o/wHMyc1ytcOeVa0M838dcdx2585WZruH8zNxqDJf3di34yUPm8UFB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 08:51:54 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5c78:27ea:319f:d11]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5c78:27ea:319f:d11%3]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 08:51:54 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: try to wakeup vpu core to avoid failure
Date:   Fri, 18 Nov 2022 16:51:29 +0800
Message-Id: <20221118085129.15412-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: c0481b34-c878-4e6c-9934-08dac9422421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 44wicaAc7fLPpMow9WBoP6K8vHLRGSoxdAirBf297t1nmYnl4G1Hv00BH4S2oe0mXgT26dDPjbI1ZEvbGDLd+vgnJsYbOKkrKoMyOHeQY6O7LCaBKuwXuLSF55PM8QBFr45UI0Vi6odsqYZUKO2JQfVAkMfGlLeCQUz+WViLgX7EQtzr/TncXcnrX2HweI6yUanirRf6ydkgJFV6PLH7S10JEnwB++1qb9lt9+U3BSUP3PQ2XMkB892G9EjAuLgm1F6k87z8KWewl20+KfWSblxL3bqpPLyNkJj3UiE/U6/SBmIldAiSrWBfaSDgnshmMcpSm39Mq29nr8UxOghgMk8JJcgh2W00MptZnG9yDR/u19cxngpmU6UIHKFOYmToLX3ymSzNJdXMGnknBJkDNU3d0jqDakSZ1dFX6cZK1oCvFZIm6/wSU7if/QfyWIL8Zp5zws/qeSmfzHoiboINvnOrpMgaNQ/mVFzQ8JKAFXEB+3MPR+vqh9hBELLAeOf1H5AtU9xVWbJh9KxMocshegp4MWA9nH9ZtCmuXMe1am3d/tod9XDNYmFtjFEdg5dfL4wrF2og7yRSwuRsKvzz0JXDXj4ZpXGhWOtToaMRddbSLdzwdo4vAr985yt0NolZy7lC0JAWJORyYqgDhwvo4nv+2eFpj1vxlFk0LNZgnae0YkZRBnQ2SwldkkKW6GPeF9tNI6H1rrX6FyA760vXpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199015)(38100700002)(38350700002)(36756003)(86362001)(6512007)(66946007)(6666004)(26005)(52116002)(6506007)(316002)(478600001)(6486002)(7416002)(186003)(5660300002)(44832011)(2906002)(83380400001)(41300700001)(66476007)(4326008)(8676002)(66556008)(1076003)(8936002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AFEtgPCyV1aAHf/Rt417BQuq1SFe4Z7QBazjRScO01spdCLQ0COrVApr79W8?=
 =?us-ascii?Q?AI6MMJErLN9QMzWM43pL7MPr4V/fEGROEwdln4iZB9uZNZJbgyW/g2NsXxhG?=
 =?us-ascii?Q?ABRWNFVu+Yf3+mriftGOF78kMOVciLPqtLWBkezwGhSsTR/vVnCfGAKt4yGp?=
 =?us-ascii?Q?bpUcyDYHKvvsU8XNRDg4LYusrAsNR8KZbQYFink9jTxPBNOWe92w7reIdNhf?=
 =?us-ascii?Q?WxxfuqSv/kNeOjWoLaiDgae8ppBZbv+pDGZuTy8rluUpFww/aobD6ahzpT5H?=
 =?us-ascii?Q?ONlb7D16TRkFBuGg0FZnMEMYr2X7p9/Usug9zPeZGNfrPVb6qUW8Y/rxCsiU?=
 =?us-ascii?Q?3HpuWWx/sVELovvkAh3X7wuI1BPUx1P8Du7CtrhRA/ptwNLZbrRO9QFR4Qlc?=
 =?us-ascii?Q?++5N8zjnkTyuRGw4SWVeF+oC/nz9B90ut0uGLWF7qJGko6CNBhiabTalNfYl?=
 =?us-ascii?Q?nyzkjJHYHcQGO8nFBzPbSNfhcHxQmfCClTtKEVc1LqcssAPEZShf/j1kbca4?=
 =?us-ascii?Q?lQTWmL1puCRR3yvibv9Qj2cNx3spRo6n5flQo3MsMgXZ4kOkmMq5c1xYCEvf?=
 =?us-ascii?Q?cRMeBdNBmq7+4gMg8Me+tVWfByIEDiR3Cg8Fq2whizW8cSO0pcrLFrwt5lRZ?=
 =?us-ascii?Q?kWEZXJtdc7uhdyU/HYLPy02dLA3qs5OjnC2DbW99RY3Qv9Iy0WAMoOxwbQr9?=
 =?us-ascii?Q?+Uw8Sfb7qKyhiinL3RRjjfxXY9xr6pIEVQsjMNj+/4US0yPh2Kf8vxnygy9q?=
 =?us-ascii?Q?yJBis1gtZcF3McgVXdzIHRDxscfPBvJjBlfawARMSrlzQ1qI59X9J3+SsM6n?=
 =?us-ascii?Q?vXpOKO8Id6Dz75nE7Hp22IGwynYmabuAHNiQeq+aJM+kyi1COa/WOxVhcaOa?=
 =?us-ascii?Q?y0960EqVTJXr48Ibu0glXhgkRtJJAdnJwC5c8TmpiXqVtTLQqS+Je6EEiGM1?=
 =?us-ascii?Q?so8y76A9grQyGUSVVY+eFBk7T+/skIUKbSt1b7QoM9AB734rIRzC4gFiO6Kf?=
 =?us-ascii?Q?/gYWLLcogTK9SAgOvOB95l8GaH9Qlm971rCQ2C7tFKH39crbha+DOJIZN+3a?=
 =?us-ascii?Q?DyREpFlL5RL8y1iHUHL8SZ3yTlQWuOd5ADEU6k1AC89OVPgw3/uEIy+RL1/c?=
 =?us-ascii?Q?6GI3PsG1T40KpI793m0b4woExFFs9LmpjE1Wr+MNvy8GNRUqBDkCshS/Jm9+?=
 =?us-ascii?Q?9dmPmWur6ZM9c3dAw5eHvndcd8kerqgiIQi4fxKQ8ttaFU6clonOnisOW+tp?=
 =?us-ascii?Q?h4rp3fxFFh+xrbf5eYgoS7T7YMBN+/k9RlL/UxFh3rImZYakQsFSuJIIbON/?=
 =?us-ascii?Q?6ADYqE4l7m+scwy3FQFYtm0ezOy1CnlRKAhhb8o2ccw4K6igL1Ra17O8jrne?=
 =?us-ascii?Q?7/rXSOFbG+O/LZx+dg40ldg0AQ7Sjbo4Fypc1pk2vf+lhLnTzCxG/nMBMOWL?=
 =?us-ascii?Q?1QZs5DGgENLJWYsnOvqabLyeli7KtdoLP6gtpXvtpMGlgIbl0mepFxggb6iO?=
 =?us-ascii?Q?zPgboSoq68nyKmKVdpGaD1QnihqO307PeMPsKyV2cAMy7OSAfPzhLChoeXjS?=
 =?us-ascii?Q?djwoHxDN9Odi1zQX/WsFzrFwCiSI36p5b1M6SpWm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0481b34-c878-4e6c-9934-08dac9422421
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 08:51:53.9427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNce3icmP4UjqPwW8iKv+yZ953RFmnQSmYqhPTwKCspZJV1op1pnPfSx10Lc+gdLlFTuclIntEPm6fQBTMrIZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7586
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

firmware should be waked up by start or configure command,
but there is a very small chance that firmware failed to wakeup.
in such case, try to wakeup firmware again by sending a noop command

Fixes: 6de8d628df6e ("media: amphion: add v4l2 m2m vpu decoder stateful driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu.h         |  1 +
 drivers/media/platform/amphion/vpu_cmds.c    | 39 ++++++++++++++++++--
 drivers/media/platform/amphion/vpu_malone.c  |  1 +
 drivers/media/platform/amphion/vpu_windsor.c |  1 +
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platform/amphion/vpu.h
index 73e34b3ec0e3..3bfe193722af 100644
--- a/drivers/media/platform/amphion/vpu.h
+++ b/drivers/media/platform/amphion/vpu.h
@@ -13,6 +13,7 @@
 #include <linux/mailbox_controller.h>
 #include <linux/kfifo.h>
 
+#define VPU_TIMEOUT_WAKEUP	msecs_to_jiffies(200)
 #define VPU_TIMEOUT		msecs_to_jiffies(1000)
 #define VPU_INST_NULL_ID	(-1L)
 #define VPU_MSG_BUFFER_SIZE	(8192)
diff --git a/drivers/media/platform/amphion/vpu_cmds.c b/drivers/media/platform/amphion/vpu_cmds.c
index f4d7ca78a621..fa581ba6bab2 100644
--- a/drivers/media/platform/amphion/vpu_cmds.c
+++ b/drivers/media/platform/amphion/vpu_cmds.c
@@ -269,7 +269,7 @@ static bool check_is_responsed(struct vpu_inst *inst, unsigned long key)
 	return flag;
 }
 
-static int sync_session_response(struct vpu_inst *inst, unsigned long key)
+static int sync_session_response(struct vpu_inst *inst, unsigned long key, long timeout, int try)
 {
 	struct vpu_core *core;
 
@@ -279,10 +279,12 @@ static int sync_session_response(struct vpu_inst *inst, unsigned long key)
 	core = inst->core;
 
 	call_void_vop(inst, wait_prepare);
-	wait_event_timeout(core->ack_wq, check_is_responsed(inst, key), VPU_TIMEOUT);
+	wait_event_timeout(core->ack_wq, check_is_responsed(inst, key), timeout);
 	call_void_vop(inst, wait_finish);
 
 	if (!check_is_responsed(inst, key)) {
+		if (try)
+			return -EINVAL;
 		dev_err(inst->dev, "[%d] sync session timeout\n", inst->id);
 		set_bit(inst->id, &core->hang_mask);
 		mutex_lock(&inst->core->cmd_lock);
@@ -294,6 +296,19 @@ static int sync_session_response(struct vpu_inst *inst, unsigned long key)
 	return 0;
 }
 
+static void vpu_core_keep_active(struct vpu_core *core)
+{
+	struct vpu_rpc_event pkt;
+
+	memset(&pkt, 0, sizeof(pkt));
+	vpu_iface_pack_cmd(core, &pkt, 0, VPU_CMD_ID_NOOP, NULL);
+
+	dev_dbg(core->dev, "try to wake up\n");
+	mutex_lock(&core->cmd_lock);
+	vpu_cmd_send(core, &pkt);
+	mutex_unlock(&core->cmd_lock);
+}
+
 static int vpu_session_send_cmd(struct vpu_inst *inst, u32 id, void *data)
 {
 	unsigned long key;
@@ -304,9 +319,25 @@ static int vpu_session_send_cmd(struct vpu_inst *inst, u32 id, void *data)
 		return -EINVAL;
 
 	ret = vpu_request_cmd(inst, id, data, &key, &sync);
-	if (!ret && sync)
-		ret = sync_session_response(inst, key);
+	if (ret)
+		goto exit;
+
+	/* workaround for a firmware issue,
+	 * firmware should be waked up by start or configure command,
+	 * but there is a very small change that firmware failed to wakeup.
+	 * in such case, try to wakeup firmware again by sending a noop command
+	 */
+	if (sync && (id == VPU_CMD_ID_CONFIGURE_CODEC || id == VPU_CMD_ID_START)) {
+		if (sync_session_response(inst, key, VPU_TIMEOUT_WAKEUP, 1))
+			vpu_core_keep_active(inst->core);
+		else
+			goto exit;
+	}
+
+	if (sync)
+		ret = sync_session_response(inst, key, VPU_TIMEOUT, 0);
 
+exit:
 	if (ret)
 		dev_err(inst->dev, "[%d] send cmd(0x%x) fail\n", inst->id, id);
 
diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index 69d9a2269fce..2c9bfc6a5a72 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -693,6 +693,7 @@ int vpu_malone_set_decode_params(struct vpu_shared_addr *shared,
 }
 
 static struct vpu_pair malone_cmds[] = {
+	{VPU_CMD_ID_NOOP, VID_API_CMD_NULL},
 	{VPU_CMD_ID_START, VID_API_CMD_START},
 	{VPU_CMD_ID_STOP, VID_API_CMD_STOP},
 	{VPU_CMD_ID_ABORT, VID_API_CMD_ABORT},
diff --git a/drivers/media/platform/amphion/vpu_windsor.c b/drivers/media/platform/amphion/vpu_windsor.c
index a454f142ae17..b245ff6a1102 100644
--- a/drivers/media/platform/amphion/vpu_windsor.c
+++ b/drivers/media/platform/amphion/vpu_windsor.c
@@ -658,6 +658,7 @@ int vpu_windsor_get_stream_buffer_size(struct vpu_shared_addr *shared)
 }
 
 static struct vpu_pair windsor_cmds[] = {
+	{VPU_CMD_ID_NOOP, GTB_ENC_CMD_NOOP},
 	{VPU_CMD_ID_CONFIGURE_CODEC, GTB_ENC_CMD_CONFIGURE_CODEC},
 	{VPU_CMD_ID_START, GTB_ENC_CMD_STREAM_START},
 	{VPU_CMD_ID_STOP, GTB_ENC_CMD_STREAM_STOP},
-- 
2.38.1

