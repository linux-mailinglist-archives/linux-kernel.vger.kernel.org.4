Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8D76319C1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKUGfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKUGfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:35:18 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130042.outbound.protection.outlook.com [40.107.13.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B4C30F78;
        Sun, 20 Nov 2022 22:35:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5vSUSZsZOTYDDEDMVDX28loSIqICb3YjS4WshmKSinxQ5Yu7dBdE/Sx08dLkkHetrSS4W5gsn8aTfOHOZBwLDL3+V1n+22ZizHkk3ITs+47TYjarHvlXUsLlvbwggjr7dwrYpPGejH5VsEZi+X8AS1MF05W6qH0dBsLVzuHV27vx0fIucUhlJLPaZv8ip1yhL36dWiPoVZiYh6qqQGbacQwQoDHKA0AmcY1zhfOULoo6JFO7ByO1ii119AAl0Rf5IDrcyE6p9PAtEqV9P1fXgUjpbHIFPIo5AtJJpXv6aiBydJcT3ZHMIgAtA29ok5i8yJlgOl+SdO6bTYWYSKkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfhVT7FQpbc86Ob1Ku1QmxqQqk7KeVMCCIN4okjmBAw=;
 b=kN7xG3M8ag3jGidUhvlcajYHgm7YrebnExZRtiJgjdoAxt3USWBf2PJ6dLyS6mN+gYsbCdJdsYTCHkgypMfKK0t5blvnSN9cWP3KzhfDdipmxJAzC8xwW0882wF9nzOzUmugTeo5S8/7RgRuE5aLs58WsHjYDb3VIc5SGHwNqavyrzdYiauQ0ysl7czI/WiSh81yQivrDnIwYL4XktHShdZw0dTE6FBEXb6BJzjh4WYS6cz8b6y+z2n61DGI1YIB1AE/z8r8eHUeflMmcQzEXXclIZLus2JS8UlkrhK5TGuPJ3r5GKTnjVYBg93sD6bGF5q6Lx/8fo/bdXlkDpeOVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfhVT7FQpbc86Ob1Ku1QmxqQqk7KeVMCCIN4okjmBAw=;
 b=gCq2w/RjtUFk4BcBsuLDdQRCV7EW6F3slFLk/amd/9NbRNh612TlyC03WcQyPedvfxMpWAY50DKI/dEXHcSK+YWPgWfGjKAlUNdT2oxBp6gu9S7nNA6sRgbH86kS/kAE1NyDQoJxHu4daXA3076dK2oCevG6SQqs7mRYdJGS9Ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB8736.eurprd04.prod.outlook.com (2603:10a6:102:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 06:35:14 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5c78:27ea:319f:d11]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5c78:27ea:319f:d11%3]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 06:35:14 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: lock and check m2m_ctx in event handler
Date:   Mon, 21 Nov 2022 14:34:42 +0800
Message-Id: <20221121063442.8565-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: f69f5862-12b2-4e9b-9241-08dacb8a8beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tn4vCO+TtRiltsEpF6uk858491uvDSCdbQIK/Xff5bLLyQNxacxzQDTD/r4/RB9/pprvRNNI6d96sQeBbMEwgllHGYuJ0vBDpNnyqLFuf1iNthby0/uA418C3n6wnjpidCOdVT7fqlLNdEL0wQkfDxcDr66rKcsbY4zgyYV44BLJ74Yl7WqYkGIZb0V+vk4Lpavm7xKxeM8wL8kriF7GIKmtPYVvRbMVx9jusc07nGw/nPVHIegsTQAZbnoFhaatvlYxydagZ4aBMSbOPw/3BG+ABtdaCNoJK/GRmRZjCbrGTpKxBOibzykGmAL0lvAAYDmj3ZWTz0ztW247qCb0TkHN69ZoPGmgNCR52xp5qBz9yfxtwC2BLkUIsl+JWpkygq67V778IOs33rMOGqHN7w3Ee7NPCtilInVbPZZuqdF2j2ozszMVncxV2ves2pRdUUQgaZogZW/9ERkk999pRq2hCDcnLeP/MEaI2Ouj+6tJ343liCL6ZbR9eJqhPOh5JL+DOrSBFru5VaeKSRZMyVp3lSftJsWzWvfP4wlztj7UOtX+L3Vde2vLKSsLmothrvbJ6JmmxlCP/lTB9a3FbwjcBvIyjlKmxKGdYytTxrvUElM9sjPeibGIevxHObX7Ej3NCJDFl2qCZLpLofBnuWpOSztej7ih+TDOE3aJzWJ5M/iNitMcsIXIo0nD6qHNZV1z6axmlo3na9MSoAlimg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199015)(5660300002)(44832011)(7416002)(6506007)(316002)(52116002)(66476007)(8676002)(4326008)(66946007)(36756003)(6512007)(41300700001)(2616005)(26005)(1076003)(8936002)(186003)(38350700002)(38100700002)(2906002)(83380400001)(86362001)(66556008)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?36lopGQuYesLb3s0tmDaKujGcIaFLu2xlHLRsdCEUVKvBDgyX/7BszAzSCkC?=
 =?us-ascii?Q?c5v6UasYPL5/XbUCFAGEkjYRE1u+0MIte0yYV96LVEwoM9nbrbjN7bu6DWom?=
 =?us-ascii?Q?twEEKqK0umtRcabM9lFUUQoWzDCjryz413twOaKGhnGvk2ATWa3G5CJZmDI5?=
 =?us-ascii?Q?TJSDkgmW47RE46Gwe93y9/yCVLYmsEaQd5A3Cfa1QJvsK+3J4nmntiaxTfP9?=
 =?us-ascii?Q?RThUL4BSnwmf+rMrj9t0sWKTunwdMt5OEHnQhbUFpV/d1rOCdQZTvP/u5SFb?=
 =?us-ascii?Q?WYcM3f7HjC//+VpaWz/NhBwJqhDLN8EATTpIbO4UPauhYUfruDSHgEJ4WaeW?=
 =?us-ascii?Q?kqg7gXGU/t287KO1hLWQkfje/cTef1p7SzxKSHYrvERrNRoDn5+8BPqr1U4O?=
 =?us-ascii?Q?MRgzTV9P0+hoTaBlDnDi19Xg6xJnx1KmT8EikiMDsttxesShFbwyssqKIRFP?=
 =?us-ascii?Q?oIE07RJoJ1ANlDrWZgMPWiluUannI6/A7Oj6W4e/ZuuoACnKHq4sVhqG/sKF?=
 =?us-ascii?Q?XTBZYPZMvVDlcCBdXE9sPBZVt1B4euIHkIc/K5vPeu23N1KKtlRKMWLTbjCD?=
 =?us-ascii?Q?K7Y0OkOgUjgRy+sbU2Si1vVpVEkDDCoOenxSTdrzXPDlmCYBnMK0WkLmPtuY?=
 =?us-ascii?Q?TfAoaHIreB4R36gsDLX70CLOIjBMDs4AZAyZTZkSvHos4nnb0WTa1ne9QZ12?=
 =?us-ascii?Q?nZ/EVxuremJG5RYtIfOeTkwqo4bzQGgCdrOPykoYSldtGKJoFQ/S9s0iKoXb?=
 =?us-ascii?Q?7zXNagGKr9hxzHKIVuQy0CQsJiabz4Vo2Puv5HHXQcelVCCDrCrSpEAJ+9OU?=
 =?us-ascii?Q?7V7ANbTrF0m0t6KxIa5GR4XkWwUVkwgtQ0/+HLbMTb/RtHJvh+F/bwq9MIP/?=
 =?us-ascii?Q?PWkrEC1JWQ0pH2SZWUZ3yjNFH/cltSI38iuhupWa8hyQJovOgh+5tYRT0T/x?=
 =?us-ascii?Q?7L6aHNZg/PT8s1+94Ob62VR60Hp2et2+yY55xpZSGLjEN3iFZGkIU4W2Fp1+?=
 =?us-ascii?Q?1DsZyBUS62bbbZhg/uQujgxVpPThq9wo1sfiE8oi3EdnxDjKf1GWIQvDKa/n?=
 =?us-ascii?Q?IdVNT9+7TsxjAL7iOFsMZVNEd4+5sMqqgzSCySgJonylqiXU9iXv1AMMXTKm?=
 =?us-ascii?Q?zQXVJAr+pIs+NPhUIhIPETkY0W0gIK5WgevqQ9brjA6qAXS7lKtTY15FNF2Z?=
 =?us-ascii?Q?nQYB7Cnnl0H5gshFHiqttJ1kaBL5DIdmX8GMBl8dhcnSClD4XSiLonpskSyq?=
 =?us-ascii?Q?ewQuN4COI/b7YyTQ3J3OSonTmEFVKpDT/sCzJF+9/7inR8ZYkv9cCIKEiBaN?=
 =?us-ascii?Q?9knXt9G9p66AXl5Ljw4fBhP6PuuUTZSfoPlMsUXUSgK6x9sl86L3YBdEYj22?=
 =?us-ascii?Q?0XbOCWQA9v7AhHNW970m1gal4VIXcrKQfNajTudeG9aNk84TEm99jlggvrWO?=
 =?us-ascii?Q?SwNWOhAf7WKYGypN5GfvB9Y3EfKZonYO9vc1U16HeZeBDz8JVVIZ1R//jaIV?=
 =?us-ascii?Q?J+/2+k/LdS5TwLsU/bVgI+PzmNm9v4yr00YzuzxUy3qFEw0jNtI5ad6Q/o8M?=
 =?us-ascii?Q?CVSz3f62raJYOIEL+DZoDSN2RdeP1R+EVXNVPbOY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69f5862-12b2-4e9b-9241-08dacb8a8beb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 06:35:14.1149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5dAdMUfXN34nGS9eYXnEHRLrpmlgZSWcRmWkS5kz9o0xOtrj9FmGIkE5hmNtFmVXBWOFq07GbTh4kGmpbbZIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

driver needs to cancel vpu before releasing the vpu instance,
so call v4l2_m2m_ctx_release() first,
to handle the redundant event triggered after m2m_ctx is released.

lock and check m2m_ctx in the event handler.

Fixes: 3cd084519c6f ("media: amphion: add vpu v4l2 m2m support")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_msgs.c | 2 ++
 drivers/media/platform/amphion/vpu_v4l2.c | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_msgs.c b/drivers/media/platform/amphion/vpu_msgs.c
index d8247f36d84b..92672a802b49 100644
--- a/drivers/media/platform/amphion/vpu_msgs.c
+++ b/drivers/media/platform/amphion/vpu_msgs.c
@@ -43,6 +43,7 @@ static void vpu_session_handle_mem_request(struct vpu_inst *inst, struct vpu_rpc
 		  req_data.ref_frame_num,
 		  req_data.act_buf_size,
 		  req_data.act_buf_num);
+	vpu_inst_lock(inst);
 	call_void_vop(inst, mem_request,
 		      req_data.enc_frame_size,
 		      req_data.enc_frame_num,
@@ -50,6 +51,7 @@ static void vpu_session_handle_mem_request(struct vpu_inst *inst, struct vpu_rpc
 		      req_data.ref_frame_num,
 		      req_data.act_buf_size,
 		      req_data.act_buf_num);
+	vpu_inst_unlock(inst);
 }
 
 static void vpu_session_handle_stop_done(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 33aaa86d465f..6773b885597c 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -327,8 +327,12 @@ int vpu_process_capture_buffer(struct vpu_inst *inst)
 
 struct vb2_v4l2_buffer *vpu_next_src_buf(struct vpu_inst *inst)
 {
-	struct vb2_v4l2_buffer *src_buf = v4l2_m2m_next_src_buf(inst->fh.m2m_ctx);
+	struct vb2_v4l2_buffer *src_buf = NULL;
 
+	if (!inst->fh.m2m_ctx)
+		return NULL;
+
+	src_buf = v4l2_m2m_next_src_buf(inst->fh.m2m_ctx);
 	if (!src_buf || vpu_get_buffer_state(src_buf) == VPU_BUF_STATE_IDLE)
 		return NULL;
 
@@ -351,7 +355,7 @@ void vpu_skip_frame(struct vpu_inst *inst, int count)
 	enum vb2_buffer_state state;
 	int i = 0;
 
-	if (count <= 0)
+	if (count <= 0 || !inst->fh.m2m_ctx)
 		return;
 
 	while (i < count) {
-- 
2.38.1

