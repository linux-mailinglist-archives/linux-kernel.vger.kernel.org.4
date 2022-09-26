Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8D95EA7AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbiIZNxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbiIZNwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:52:44 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EA51F8C1B;
        Mon, 26 Sep 2022 05:08:34 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DEB3C1A902E;
        Mon, 26 Sep 2022 14:07:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A71A71A9027;
        Mon, 26 Sep 2022 14:07:18 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7F028180222C;
        Mon, 26 Sep 2022 20:07:17 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: [PATCH] remoteproc: imx_dsp_rproc: Add mutex protection for workqueue
Date:   Mon, 26 Sep 2022 19:48:13 +0800
Message-Id: <1664192893-14487-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue may execute late even after remoteproc is stopped or
stopping, some resources (rpmsg device and endpoint) have been
released in rproc_stop_subdevices(), then rproc_vq_interrupt()
access these resources will cause kennel dump.

Call trace:
 virtqueue_add_split+0x1ac/0x560
 virtqueue_add_inbuf+0x4c/0x60
 rpmsg_recv_done+0x15c/0x294
 vring_interrupt+0x6c/0xa4
 rproc_vq_interrupt+0x30/0x50
 imx_dsp_rproc_vq_work+0x24/0x40 [imx_dsp_rproc]
 process_one_work+0x1d0/0x354
 worker_thread+0x13c/0x470
 kthread+0x154/0x160
 ret_from_fork+0x10/0x20

Add mutex protection in imx_dsp_rproc_vq_work(), if the state is
not running, then just skip calling rproc_vq_interrupt().

Also the flush workqueue operation can't be added in rproc stop
for same reason.

Fixes: ec0e5549f358 ("remoteproc: imx_dsp_rproc: Add remoteproc driver for DSP on i.MX")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/remoteproc/imx_dsp_rproc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 899aa8dd12f0..95da1cbefacf 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -347,9 +347,6 @@ static int imx_dsp_rproc_stop(struct rproc *rproc)
 	struct device *dev = rproc->dev.parent;
 	int ret = 0;
 
-	/* Make sure work is finished */
-	flush_work(&priv->rproc_work);
-
 	if (rproc->state == RPROC_CRASHED) {
 		priv->flags &= ~REMOTE_IS_READY;
 		return 0;
@@ -432,9 +429,18 @@ static void imx_dsp_rproc_vq_work(struct work_struct *work)
 {
 	struct imx_dsp_rproc *priv = container_of(work, struct imx_dsp_rproc,
 						  rproc_work);
+	struct rproc *rproc = priv->rproc;
+
+	mutex_lock(&rproc->lock);
+
+	if (rproc->state != RPROC_RUNNING)
+		goto unlock_mutex;
 
 	rproc_vq_interrupt(priv->rproc, 0);
 	rproc_vq_interrupt(priv->rproc, 1);
+
+unlock_mutex:
+	mutex_unlock(&rproc->lock);
 }
 
 /**
-- 
2.34.1

