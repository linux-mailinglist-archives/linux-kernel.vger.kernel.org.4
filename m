Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3D572DD68
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241831AbjFMJPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240910AbjFMJPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:15:01 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84EB18E;
        Tue, 13 Jun 2023 02:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Onx+YviQZooKxNskRa/8F6u8XfYM3uyVIaIpUESn7+5nPdmZ3ZUGRcw7aHa/5stUo9TPvMkPr6lRjuvh8eG0R5U7rAMl84t0YTGlgEdp+VLFUCCKKK4zShSeTly57Upo+1jM/yRCOyssxNmBurSLQqhnG62KLVcRCJC8OflmyB+nUhIGA4kgLbnHrU/kWH4MfHA4qtiW07al5E+hlNqCnH3xpLEt2extrhlgd0TCVdRCpt0Iw/IsGKD+oOB8jtmAfAzcw5w8SSEz+6UsX8qwONhzgbbUbVXHne15BQETMnRmkHdkmoMjeS4QJylabQpdSKCHPKQt1M6WdndCtfxQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AM2PtbcFDMDxN34Bj4aAyNZfiRnFXYbh5T8Wb4ig9ao=;
 b=J+yUQ+R6jko9yf3QXFqT0lXJPMU9ZJxX0z/fC7QT+gPlIUHK1UtmXao34QideQPOm/1yichAXzMUZ4xjXNAw3ufRIMVLVh4nUd3if85HBTWeqhWZPCkFklDUTliYpkRLIeC73wmOebmKPSvk5k3HlXl8SPDTw7XwpF3CWal9c5Fj+YIDW77SC7DlBgbZjYXeE+LsfMd7KQmx2t6wyv5YJirrxoVM9Hgjbzw7opKmaTn9eSsfEohawkSOrnFjPJPzMvxho5xUzsjDeo1zAyR1O9tkkTZ9xd1KGmfiNC14mL1E/g+fyjwfOc/Tu+9S92FJSm8XSiR64PIM97EoaonkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AM2PtbcFDMDxN34Bj4aAyNZfiRnFXYbh5T8Wb4ig9ao=;
 b=ITG3RDRUk+0hg1hHwWkZvo39E5WxT5cOEjVUucArIUctl9Bsdb1LvKWFBwxWva4DpHRV4bjsn0zB42XV42g0Bmro2AcC0TxkBDXOhGAWJjj4iAAQ+A0wBKlr0Argg38m5F8e8BkBJkvnX0VT38eZOzNCPKHvnaHahDFic50fspg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAWPR04MB10008.eurprd04.prod.outlook.com (2603:10a6:102:38b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 09:14:56 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::79f2:2888:dbd7:ad6f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::79f2:2888:dbd7:ad6f%7]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 09:14:56 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: add helper function to get id name
Date:   Tue, 13 Jun 2023 17:14:08 +0800
Message-Id: <20230613091408.7676-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAWPR04MB10008:EE_
X-MS-Office365-Filtering-Correlation-Id: c7da34e8-1c5d-46b3-3ed9-08db6beea7ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 305ax0MzF3+u1W4hnr0qAPrn57xueagvMOCaly3p6g6yj+ojYmjpYYVYtcDPXlU/Ty9DrH7skHSaHlnmVHtHfy8+Q28OeIImbiR4NZPl5KjA9+KmmfW62adO3Y5kAwcB91r8pkxS8LCTXWZpx5MtroO7ACY+/egc3Hq6ejq9/mYnU3w07GEgBIS+UO0jZfwhQkFZaqQA5sZmLX3ONuj13/ns/RVn/2LcGRvwGYV0M7+M9wIsHOqeifls55/x7Jaz+4yiYeknSBpDJW2qrSzkjp1WKLP68WJOfAe4aTaC61U6UqRwp8FZLITNUbHtDpOQJ2wMZocURZ8hH967GfV8qIzCth/lSgZWYALI37u9M4KoW71/2ukx3U17rilkvj9MseqAt3mexgHLkSaKHUXqxBQmjCDGB5teigOkRN51Z7asIyrizbAUBG+oR7OmV1YdCyx3Hi4qFXRl0IBpqL1PKPaBYDpPcqkXkQVccyWGocGekqQT09HdyrNvh21RlHffyRu03iFVyZv2b9YMsVoY0KDVSUG32clmNlCu1EWPMzQOH6yeJ0oteLkaBSXADS5hrr7c8tpz7sfxJ7ldOkrXuXMAlXIEKVuPgrWIr1kNEFiUECoCJc5SrU3AMfqgk3C1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199021)(2616005)(83380400001)(38350700002)(36756003)(38100700002)(86362001)(478600001)(44832011)(4326008)(6666004)(6486002)(8936002)(8676002)(2906002)(5660300002)(7416002)(52116002)(66556008)(66476007)(66946007)(41300700001)(316002)(186003)(6512007)(6506007)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pMZeTyfFFYM1/2rujH0Wabf9UhNlC9y9Sfyg++i3KwkcnuhX7PHXIY+h0rEZ?=
 =?us-ascii?Q?T/DyOpDsI8GSQXJdvzjsgV75p4S4Odss1dIbWW7HSe2eshNiS1SoMIChse4p?=
 =?us-ascii?Q?1EkfntCnT1AS1YtimRdpHHvh1b29MSZ0L/1urixcVxAa5ZezPFqdRf9eRKZb?=
 =?us-ascii?Q?DXZie/zt/3pS6guZ39HOlMbMujdeSIRuXpMIzlWQWy5LvQVR0s74YTpYW/AB?=
 =?us-ascii?Q?6BwMqNJ9s64eeyzzeDi47rxj0RXlXg/hlR36PcOeKzK4Gu3bxfI8Up0WXxaU?=
 =?us-ascii?Q?oXrsWqZhAI020O2Jc+IOOhDUDKzx5K0JrnMqh+LkwU8jVMxNQfnth0Ruwz3Q?=
 =?us-ascii?Q?ciiufUAV+xIM5NwC2dZ0QBXR++WI/zH0oHJ74hRXGKbysEN6aXX8tib/FVIh?=
 =?us-ascii?Q?eBM/ClGTAXki4UHFBMyfmwdSn/A6jplxyNQObbOfVZcvOxnF9Vxh/kENXARh?=
 =?us-ascii?Q?G7zmIdlcCUBZQekTbDHf09KMDJhAC5iHa2U3OtbTP6vU08Q6j3EpisCOplPo?=
 =?us-ascii?Q?nbdo9c9Nt7shtc/s5q9vkEcmzIPy5EUz4tw97fkDnlKk/izgDqjXvpxVBkJ4?=
 =?us-ascii?Q?2Ki/qKi2PJ/EelJpzkpcq+k0/uCZJrcGmHb1u9XdgxExlt1v8ZPUFRcVF42d?=
 =?us-ascii?Q?ZXZa4ZiNFMCJJuks1Gp7GVi/flFI2OXZ6dH/xSP5d2Fag8qEugaw3BuphxK8?=
 =?us-ascii?Q?wMeeV06fAIF3HTfvUKyLbc/gBE1nmH2Jm/EqnH5OyYrzW+MzeD9rNUA7NxZL?=
 =?us-ascii?Q?Y1BsZX2m56bk4jc/xnWWmpqeMPbFm4ClYQjV2KQCV6oD9UMsE7OZrzLHNLcV?=
 =?us-ascii?Q?LRIFXZfRcCNEBnN+IlMYLAav975CNhs7SeO6MU7gMV0VpsMh7c43ewnGrKBc?=
 =?us-ascii?Q?74kKs0Bpv7OiiKmP6/RnHrQ4Fvu5EODFz9tlX/bCq1JZDKrCOtISHW88i3XF?=
 =?us-ascii?Q?xfhpgFMQCSe16w7f4I9L/64OuVs1SfztnB1jof3yhIN9LArs9xBfupUJWxLd?=
 =?us-ascii?Q?mQ3pYio3k/dmCL2eqKpxdgu3ga/fbS2CMt6Y/AcJ69JIDMkOe3BPLvUKf+4h?=
 =?us-ascii?Q?5Jl/AtoBoxGUP2tM7SaUmI1Bqj3S0giTDQNqfNMeCFrreWdzIAjKNJCic54Q?=
 =?us-ascii?Q?CWL2EBhz4O0tVjsZIzAKny/ZhJ3TaD3ppISoH84/HCz5c7e1aTku6bFSkK6y?=
 =?us-ascii?Q?M/ljspoW44NHHLvyEQhiFp3fhhGwz9Emh1rpeDAfkm4Y2vhA1Up1Z3KQzj51?=
 =?us-ascii?Q?dG1MZlmcCuquQz0J/CspxHMvg07v5c338yetj2nEpsbnbrHKL6xqqfTybyMT?=
 =?us-ascii?Q?lMgD/8MjZ10oz2R8GWLvL8W8sjYZE3aABiUNSgtPiwHAicLarYJhtQTOodfh?=
 =?us-ascii?Q?PM51uVrk7EZ6fw0qIz/PfSCFlui5zuP2LMRO1CtAApjMJajyEF4JLhZDI+PC?=
 =?us-ascii?Q?puvd1G5ZxoN23DsyZO4rRRkLVAJ0JrSPWVoSjrPanytbPef/RbwRoMqEL7yb?=
 =?us-ascii?Q?hxjKhSWdUgOqwQFxTN+Z2AIzCEPYLEfa+emOqSMt6wnzkkvn4Up2d31jWS2k?=
 =?us-ascii?Q?nSqOVUUxrICS0ClLrHmpmcn2/6//YF4HaPdGB8T4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7da34e8-1c5d-46b3-3ed9-08db6beea7ce
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:14:56.7377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITZhG/LBz9kTY/9bTr+VBz2cepdpLSOkOPrZYgW0BDKcE6EcL+NVC5yeLDq+mSx3xSFIOCxlqYn0v+8tibdqGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert numbers into meaningful names,
then it can improve the log readability

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c        |  9 +--
 drivers/media/platform/amphion/vpu.h         |  3 +
 drivers/media/platform/amphion/vpu_cmds.c    | 11 ++--
 drivers/media/platform/amphion/vpu_dbg.c     |  6 +-
 drivers/media/platform/amphion/vpu_helpers.c | 61 ++++++++++++++++++++
 drivers/media/platform/amphion/vpu_msgs.c    |  2 +-
 6 files changed, 79 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 56c4deea4494..60f3a73c6a8a 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -299,7 +299,8 @@ static int vdec_update_state(struct vpu_inst *inst, enum vpu_codec_state state,
 		vdec->state = VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE;
 
 	if (inst->state != pre_state)
-		vpu_trace(inst->dev, "[%d] %d -> %d\n", inst->id, pre_state, inst->state);
+		vpu_trace(inst->dev, "[%d] %s -> %s\n", inst->id,
+			  vpu_codec_state_name(pre_state), vpu_codec_state_name(inst->state));
 
 	if (inst->state == VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
 		vdec_handle_resolution_change(inst);
@@ -1037,8 +1038,8 @@ static int vdec_response_frame(struct vpu_inst *inst, struct vb2_v4l2_buffer *vb
 		return -EINVAL;
 	}
 
-	dev_dbg(inst->dev, "[%d] state = %d, alloc fs %d, tag = 0x%x\n",
-		inst->id, inst->state, vbuf->vb2_buf.index, vdec->seq_tag);
+	dev_dbg(inst->dev, "[%d] state = %s, alloc fs %d, tag = 0x%x\n",
+		inst->id, vpu_codec_state_name(inst->state), vbuf->vb2_buf.index, vdec->seq_tag);
 	vpu_buf = to_vpu_vb2_buffer(vbuf);
 
 	memset(&info, 0, sizeof(info));
@@ -1400,7 +1401,7 @@ static void vdec_abort(struct vpu_inst *inst)
 	struct vpu_rpc_buffer_desc desc;
 	int ret;
 
-	vpu_trace(inst->dev, "[%d] state = %d\n", inst->id, inst->state);
+	vpu_trace(inst->dev, "[%d] state = %s\n", inst->id, vpu_codec_state_name(inst->state));
 
 	vdec->aborting = true;
 	vpu_iface_add_scode(inst, SCODE_PADDING_ABORT);
diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platform/amphion/vpu.h
index 3bfe193722af..5a701f64289e 100644
--- a/drivers/media/platform/amphion/vpu.h
+++ b/drivers/media/platform/amphion/vpu.h
@@ -355,6 +355,9 @@ void vpu_inst_record_flow(struct vpu_inst *inst, u32 flow);
 int vpu_core_driver_init(void);
 void vpu_core_driver_exit(void);
 
+const char *vpu_id_name(u32 id);
+const char *vpu_codec_state_name(enum vpu_codec_state state);
+
 extern bool debug;
 #define vpu_trace(dev, fmt, arg...)					\
 	do {								\
diff --git a/drivers/media/platform/amphion/vpu_cmds.c b/drivers/media/platform/amphion/vpu_cmds.c
index fa581ba6bab2..647d94554fb5 100644
--- a/drivers/media/platform/amphion/vpu_cmds.c
+++ b/drivers/media/platform/amphion/vpu_cmds.c
@@ -98,7 +98,7 @@ static struct vpu_cmd_t *vpu_alloc_cmd(struct vpu_inst *inst, u32 id, void *data
 	cmd->id = id;
 	ret = vpu_iface_pack_cmd(inst->core, cmd->pkt, inst->id, id, data);
 	if (ret) {
-		dev_err(inst->dev, "iface pack cmd(%d) fail\n", id);
+		dev_err(inst->dev, "iface pack cmd %s fail\n", vpu_id_name(id));
 		vfree(cmd->pkt);
 		vfree(cmd);
 		return NULL;
@@ -125,14 +125,14 @@ static int vpu_session_process_cmd(struct vpu_inst *inst, struct vpu_cmd_t *cmd)
 {
 	int ret;
 
-	dev_dbg(inst->dev, "[%d]send cmd(0x%x)\n", inst->id, cmd->id);
+	dev_dbg(inst->dev, "[%d]send cmd %s\n", inst->id, vpu_id_name(cmd->id));
 	vpu_iface_pre_send_cmd(inst);
 	ret = vpu_cmd_send(inst->core, cmd->pkt);
 	if (!ret) {
 		vpu_iface_post_send_cmd(inst);
 		vpu_inst_record_flow(inst, cmd->id);
 	} else {
-		dev_err(inst->dev, "[%d] iface send cmd(0x%x) fail\n", inst->id, cmd->id);
+		dev_err(inst->dev, "[%d] iface send cmd %s fail\n", inst->id, vpu_id_name(cmd->id));
 	}
 
 	return ret;
@@ -149,7 +149,8 @@ static void vpu_process_cmd_request(struct vpu_inst *inst)
 	list_for_each_entry_safe(cmd, tmp, &inst->cmd_q, list) {
 		list_del_init(&cmd->list);
 		if (vpu_session_process_cmd(inst, cmd))
-			dev_err(inst->dev, "[%d] process cmd(%d) fail\n", inst->id, cmd->id);
+			dev_err(inst->dev, "[%d] process cmd %s fail\n",
+				inst->id, vpu_id_name(cmd->id));
 		if (cmd->request) {
 			inst->pending = (void *)cmd;
 			break;
@@ -339,7 +340,7 @@ static int vpu_session_send_cmd(struct vpu_inst *inst, u32 id, void *data)
 
 exit:
 	if (ret)
-		dev_err(inst->dev, "[%d] send cmd(0x%x) fail\n", inst->id, id);
+		dev_err(inst->dev, "[%d] send cmd %s fail\n", inst->id, vpu_id_name(id));
 
 	return ret;
 }
diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index 44b830ae01d8..adc523b95061 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -67,7 +67,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
 	num = scnprintf(str, sizeof(str), "tgig = %d,pid = %d\n", inst->tgid, inst->pid);
 	if (seq_write(s, str, num))
 		return 0;
-	num = scnprintf(str, sizeof(str), "state = %d\n", inst->state);
+	num = scnprintf(str, sizeof(str), "state = %s\n", vpu_codec_state_name(inst->state));
 	if (seq_write(s, str, num))
 		return 0;
 	num = scnprintf(str, sizeof(str),
@@ -188,9 +188,9 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
 
 		if (!inst->flows[idx])
 			continue;
-		num = scnprintf(str, sizeof(str), "\t[%s]0x%x\n",
+		num = scnprintf(str, sizeof(str), "\t[%s] %s\n",
 				inst->flows[idx] >= VPU_MSG_ID_NOOP ? "M" : "C",
-				inst->flows[idx]);
+				vpu_id_name(inst->flows[idx]));
 		if (seq_write(s, str, num)) {
 			mutex_unlock(&inst->core->cmd_lock);
 			return 0;
diff --git a/drivers/media/platform/amphion/vpu_helpers.c b/drivers/media/platform/amphion/vpu_helpers.c
index 019c77e84514..af3b336e5dc3 100644
--- a/drivers/media/platform/amphion/vpu_helpers.c
+++ b/drivers/media/platform/amphion/vpu_helpers.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include "vpu.h"
+#include "vpu_defs.h"
 #include "vpu_core.h"
 #include "vpu_rpc.h"
 #include "vpu_helpers.h"
@@ -447,3 +448,63 @@ int vpu_find_src_by_dst(struct vpu_pair *pairs, u32 cnt, u32 dst)
 
 	return -EINVAL;
 }
+
+const char *vpu_id_name(u32 id)
+{
+	switch (id) {
+	case VPU_CMD_ID_NOOP: return "noop";
+	case VPU_CMD_ID_CONFIGURE_CODEC: return "configure codec";
+	case VPU_CMD_ID_START: return "start";
+	case VPU_CMD_ID_STOP: return "stop";
+	case VPU_CMD_ID_ABORT: return "abort";
+	case VPU_CMD_ID_RST_BUF: return "reset buf";
+	case VPU_CMD_ID_SNAPSHOT: return "snapshot";
+	case VPU_CMD_ID_FIRM_RESET: return "reset firmware";
+	case VPU_CMD_ID_UPDATE_PARAMETER: return "update parameter";
+	case VPU_CMD_ID_FRAME_ENCODE: return "encode frame";
+	case VPU_CMD_ID_SKIP: return "skip";
+	case VPU_CMD_ID_FS_ALLOC: return "alloc fb";
+	case VPU_CMD_ID_FS_RELEASE: return "release fb";
+	case VPU_CMD_ID_TIMESTAMP: return "timestamp";
+	case VPU_CMD_ID_DEBUG: return "debug";
+	case VPU_MSG_ID_RESET_DONE: return "reset done";
+	case VPU_MSG_ID_START_DONE: return "start done";
+	case VPU_MSG_ID_STOP_DONE: return "stop done";
+	case VPU_MSG_ID_ABORT_DONE: return "abort done";
+	case VPU_MSG_ID_BUF_RST: return "buf reset done";
+	case VPU_MSG_ID_MEM_REQUEST: return "mem request";
+	case VPU_MSG_ID_PARAM_UPD_DONE: return "param upd done";
+	case VPU_MSG_ID_FRAME_INPUT_DONE: return "frame input done";
+	case VPU_MSG_ID_ENC_DONE: return "encode done";
+	case VPU_MSG_ID_DEC_DONE: return "frame display";
+	case VPU_MSG_ID_FRAME_REQ: return "fb request";
+	case VPU_MSG_ID_FRAME_RELEASE: return "fb release";
+	case VPU_MSG_ID_SEQ_HDR_FOUND: return "seq hdr found";
+	case VPU_MSG_ID_RES_CHANGE: return "resolution change";
+	case VPU_MSG_ID_PIC_HDR_FOUND: return "pic hdr found";
+	case VPU_MSG_ID_PIC_DECODED: return "picture decoded";
+	case VPU_MSG_ID_PIC_EOS: return "eos";
+	case VPU_MSG_ID_FIFO_LOW: return "fifo low";
+	case VPU_MSG_ID_BS_ERROR: return "bs error";
+	case VPU_MSG_ID_UNSUPPORTED: return "unsupported";
+	case VPU_MSG_ID_FIRMWARE_XCPT: return "exception";
+	case VPU_MSG_ID_PIC_SKIPPED: return "skipped";
+	}
+	return "<unknown>";
+}
+
+const char *vpu_codec_state_name(enum vpu_codec_state state)
+{
+	switch (state) {
+	case VPU_CODEC_STATE_DEINIT: return "initialization";
+	case VPU_CODEC_STATE_CONFIGURED: return "configured";
+	case VPU_CODEC_STATE_START: return "start";
+	case VPU_CODEC_STATE_STARTED: return "started";
+	case VPU_CODEC_STATE_ACTIVE: return "active";
+	case VPU_CODEC_STATE_SEEK: return "seek";
+	case VPU_CODEC_STATE_STOP: return "stop";
+	case VPU_CODEC_STATE_DRAIN: return "drain";
+	case VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE: return "resolution change";
+	}
+	return "<unknown>";
+}
diff --git a/drivers/media/platform/amphion/vpu_msgs.c b/drivers/media/platform/amphion/vpu_msgs.c
index 92672a802b49..f9eb488d1b5e 100644
--- a/drivers/media/platform/amphion/vpu_msgs.c
+++ b/drivers/media/platform/amphion/vpu_msgs.c
@@ -210,7 +210,7 @@ static int vpu_session_handle_msg(struct vpu_inst *inst, struct vpu_rpc_event *m
 		return -EINVAL;
 
 	msg_id = ret;
-	dev_dbg(inst->dev, "[%d] receive event(0x%x)\n", inst->id, msg_id);
+	dev_dbg(inst->dev, "[%d] receive event(%s)\n", inst->id, vpu_id_name(msg_id));
 
 	for (i = 0; i < ARRAY_SIZE(handlers); i++) {
 		if (handlers[i].id == msg_id) {
-- 
2.38.1

