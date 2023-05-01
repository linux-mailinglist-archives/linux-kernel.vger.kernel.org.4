Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B937E6F2D74
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjEADMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjEADKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57B24222;
        Sun, 30 Apr 2023 20:04:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF8A8617AC;
        Mon,  1 May 2023 03:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D73C4339C;
        Mon,  1 May 2023 03:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910220;
        bh=lW38JLU3QFhVbWOQXPhF88T4VJz8JtutIhc3gKjsfPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fv8dm2/IVlNYGt9uaVg23cJLdl5T8Hp+qG25j6sdp1F9eOVm3AjjssBv0lLYDo+lh
         5nf/L4hgC57PGyNBFrqwviwp3SoL/g2m4hBq0jtJHCmQYSSo+lXsvQuws9eH4uIC/O
         G4X81G+zJq3Z7VHrFiGuNanKOqCroIEXVTq0xi4dAxV1EURae24qYnQzo2sI5ex2v8
         GknA13JumHt294/pROxh6Vuw32RXuKCSG1TBU4AlhEicsFsSBXpPP1H1i1lbqJKgWh
         4K7OGJBUDJr/Sod77u2YoWECUlLGQ2qiSurN75rhEnp063E0B/CQdSfcIS7SANTTpK
         DHRinWlA/eZSw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <sashal@kernel.org>, andersson@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 20/33] remoteproc: stm32_rproc: Add mutex protection for workqueue
Date:   Sun, 30 Apr 2023 23:02:14 -0400
Message-Id: <20230501030227.3254266-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030227.3254266-1-sashal@kernel.org>
References: <20230501030227.3254266-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

[ Upstream commit 35bdafda40cc343ad2ba2cce105eba03a70241cc ]

The workqueue may execute late even after remoteproc is stopped or
stopping, some resources (rpmsg device and endpoint) have been
released in rproc_stop_subdevices(), then rproc_vq_interrupt()
accessing these resources will cause kernel dump.

Call trace:
virtqueue_add_inbuf
virtqueue_add_inbuf
rpmsg_recv_single
rpmsg_recv_done
vring_interrupt
stm32_rproc_mb_vq_work
process_one_work
worker_thread
kthread

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Link: https://lore.kernel.org/r/20230331160634.3113031-1-arnaud.pouliquen@foss.st.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/stm32_rproc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 7d782ed9e5896..f618405cf4200 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -287,8 +287,16 @@ static void stm32_rproc_mb_vq_work(struct work_struct *work)
 	struct stm32_mbox *mb = container_of(work, struct stm32_mbox, vq_work);
 	struct rproc *rproc = dev_get_drvdata(mb->client.dev);
 
+	mutex_lock(&rproc->lock);
+
+	if (rproc->state != RPROC_RUNNING)
+		goto unlock_mutex;
+
 	if (rproc_vq_interrupt(rproc, mb->vq_id) == IRQ_NONE)
 		dev_dbg(&rproc->dev, "no message found in vq%d\n", mb->vq_id);
+
+unlock_mutex:
+	mutex_unlock(&rproc->lock);
 }
 
 static void stm32_rproc_mb_callback(struct mbox_client *cl, void *data)
-- 
2.39.2

