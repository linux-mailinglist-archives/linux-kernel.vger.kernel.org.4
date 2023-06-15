Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E82E731754
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbjFOLlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344270AbjFOLlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:41:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDF6212C;
        Thu, 15 Jun 2023 04:39:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 985A4639DD;
        Thu, 15 Jun 2023 11:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35FFC433BC;
        Thu, 15 Jun 2023 11:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829134;
        bh=pC9I6e0OWmAUP6vgtjaR7+ZgsLgeZHz9GxRxlURUdvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WlXEJo+CzNj6Ai3idWQrgZRGPSrOC5Yp0jST/fGosBNNUn/YfinqLNxJgHeCt8Xac
         J0P0T+q74gFqPzoOjYQj8DlyS8YR41zh1VYmnKuGLtnuCNdrhlTxPiKsbKuZtx77sy
         cDxjk1l1FipPXudd28FY4yHLrI/6W9nMETjAzS23iR9NkXc4lMFdgVZca2A20ck0OW
         p1POzMflHisqzi2hILJFISF1NCNef0j/o7wErqYAxbuEekH1xREO1zAvRb1It+yAIc
         5bxOZk4/t963Gb8dfz858O13NkAfK73XfinSHhGtOISyBkhDbrkDUV4wH67/2oikxt
         l2rPrYSFC1dPg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Uday Shankar <ushankar@purestorage.com>,
        Costa Sapuntzakis <costa@purestorage.com>,
        Randy Jennings <randyj@purestorage.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 16/16] nvme: improve handling of long keep alives
Date:   Thu, 15 Jun 2023 07:38:16 -0400
Message-Id: <20230615113816.649135-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113816.649135-1-sashal@kernel.org>
References: <20230615113816.649135-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uday Shankar <ushankar@purestorage.com>

[ Upstream commit c7275ce6a5fd32ca9f5a6294ed89cf0523181af9 ]

Upon keep alive completion, nvme_keep_alive_work is scheduled with the
same delay every time. If keep alive commands are completing slowly,
this may cause a keep alive timeout. The following trace illustrates the
issue, taking KATO = 8 and TBKAS off for simplicity:

1. t = 0: run nvme_keep_alive_work, send keep alive
2. t = ε: keep alive reaches controller, controller restarts its keep
          alive timer
3. t = 4: host receives keep alive completion, schedules
          nvme_keep_alive_work with delay 4
4. t = 8: run nvme_keep_alive_work, send keep alive

Here, a keep alive having RTT of 4 causes a delay of at least 8 - ε
between the controller receiving successive keep alives. With ε small,
the controller is likely to detect a keep alive timeout.

Fix this by calculating the RTT of the keep alive command, and adjusting
the scheduling delay of the next keep alive work accordingly.

Reported-by: Costa Sapuntzakis <costa@purestorage.com>
Reported-by: Randy Jennings <randyj@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 06dd1c0780bfc..4e4203c327114 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1234,6 +1234,20 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 	struct nvme_ctrl *ctrl = rq->end_io_data;
 	unsigned long flags;
 	bool startka = false;
+	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
+	unsigned long delay = nvme_keep_alive_work_period(ctrl);
+
+	/*
+	 * Subtract off the keepalive RTT so nvme_keep_alive_work runs
+	 * at the desired frequency.
+	 */
+	if (rtt <= delay) {
+		delay -= rtt;
+	} else {
+		dev_warn(ctrl->device, "long keepalive RTT (%u ms)\n",
+			 jiffies_to_msecs(rtt));
+		delay = 0;
+	}
 
 	blk_mq_free_request(rq);
 
@@ -1252,7 +1266,7 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		startka = true;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
-		nvme_queue_keep_alive_work(ctrl);
+		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 	return RQ_END_IO_NONE;
 }
 
-- 
2.39.2

