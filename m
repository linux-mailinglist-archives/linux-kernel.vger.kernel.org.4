Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492E65B6675
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiIMETq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiIMETF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:19:05 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F401154675;
        Mon, 12 Sep 2022 21:19:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VPccyJH_1663042738;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VPccyJH_1663042738)
          by smtp.aliyun-inc.com;
          Tue, 13 Sep 2022 12:19:01 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V3 7/7] ublk_drv: do not run monitor_work while ub's state is QUIESCED
Date:   Tue, 13 Sep 2022 12:17:07 +0800
Message-Id: <20220913041707.197334-8-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

START_USER_RECOVERY release task_struct of ubq_daemon and resets
->ubq_daemon to NULL. So in monitor_work, check on ubq_daemon causes UAF.
Besides, monitor_work is not necessary in QUIESCED state since we have
already scheduled quiesce_work and quiesce all ubqs.

Do not let monitor_work schedule itself if state it QUIESCED. And we cancel
it in START_USER_RECOVERY and re-schedule it in END_USER_RECOVERY to avoid
UAF.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3a3af80ee938..044f9b4a0d08 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1143,10 +1143,13 @@ static void ublk_daemon_monitor_work(struct work_struct *work)
 	/*
 	 * We can't schedule monitor work after ublk_remove() is started.
 	 *
-	 * No need ub->mutex, monitor work are canceled after state is marked
-	 * as DEAD, so DEAD state is observed reliably.
+	 * We can't schedule monitor work after ub is QUIESCED because
+	 * ubq_daemon may be NULL during user recovery.
+	 *
+	 * No need ub->mutex, monitor work are canceled after state is not
+	 * UBLK_S_DEV_LIVE, so new state is observed reliably.
 	 */
-	if (ub->dev_info.state != UBLK_S_DEV_DEAD)
+	if (ub->dev_info.state == UBLK_S_DEV_LIVE)
 		schedule_delayed_work(&ub->monitor_work,
 				UBLK_DAEMON_MONITOR_PERIOD);
 }
@@ -2016,6 +2019,7 @@ static int ublk_ctrl_start_recovery(struct io_uring_cmd *cmd)
 		ret = -EBUSY;
 		goto out_unlock;
 	}
+	cancel_delayed_work_sync(&ub->monitor_work);
 	pr_devel("%s: start recovery for dev id %d.\n", __func__, header->dev_id);
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
@@ -2064,6 +2068,7 @@ static int ublk_ctrl_end_recovery(struct io_uring_cmd *cmd)
 			__func__, header->dev_id);
 	blk_mq_kick_requeue_list(ub->ub_disk->queue);
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
+	schedule_delayed_work(&ub->monitor_work, UBLK_DAEMON_MONITOR_PERIOD);
 	ret = 0;
  out_unlock:
 	mutex_unlock(&ub->mutex);
-- 
2.27.0

