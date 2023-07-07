Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E162274AB14
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGGGZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjGGGZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:25:36 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08EE8F;
        Thu,  6 Jul 2023 23:25:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qy3Kz2RLsz4f3lY0;
        Fri,  7 Jul 2023 14:25:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgCHK5_Xr6dkxLOXNQ--.9805S4;
        Fri, 07 Jul 2023 14:25:29 +0800 (CST)
From:   Zhong Jinghua <zhongjinghua@huaweicloud.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, zhongjinghua@huaweicloud.com,
        yi.zhang@huawei.com, yukuai3@huawei.com
Subject: [PATCH -next] nbd: get config_lock before sock_shutdown
Date:   Fri,  7 Jul 2023 14:22:56 +0800
Message-Id: <20230707062256.1271948-1-zhongjinghua@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHK5_Xr6dkxLOXNQ--.9805S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1DWw1xGryfWr1UAw1fZwb_yoW8Ww45pF
        4UCF4DGr4rXa1S9FZ8J34xWr1UJ342gay7GryUZ3Z0vr93CrW7Zrn8KF1fCr1UtwsrXF45
        XFyrKF95Cas5JrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: x2kr0wpmlqwxtxd6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Config->socks in sock_shutdown may trigger a UAF problem.
The reason is that sock_shutdown does not hold the config_lock,
so that nbd_ioctl can release config->socks at this time.

T0: NBD_SET_SOCK
T1: NBD_DO_IT

T0						T1

nbd_ioctl
  mutex_lock(&nbd->config_lock)
  // get lock
  __nbd_ioctl
    nbd_start_device_ioctl
      nbd_start_device
       mutex_unlock(&nbd->config_lock)
         // relase lock
         wait_event_interruptible
         (kill, enter sock_shutdown)
         sock_shutdown
					nbd_ioctl
					  mutex_lock(&nbd->config_lock)
					  // get lock
					  __nbd_ioctl
					    nbd_add_socket
					      krealloc
						kfree(p)
					        //config->socks is NULL
           nbd_sock *nsock = config->socks // error

Fix it by moving config_lock up before sock_shutdown.

Signed-off-by: Zhong Jinghua <zhongjinghua@huaweicloud.com>
---
 drivers/block/nbd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c410cf29fb0c..accbe99ebb7e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1428,13 +1428,18 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd)
 	mutex_unlock(&nbd->config_lock);
 	ret = wait_event_interruptible(config->recv_wq,
 					 atomic_read(&config->recv_threads) == 0);
+
+	/*
+	 * recv_work in flush_workqueue will not get this lock, because nbd_open
+	 * will hold nbd->config_refs
+	 */
+	mutex_lock(&nbd->config_lock);
 	if (ret) {
 		sock_shutdown(nbd);
 		nbd_clear_que(nbd);
 	}
 
 	flush_workqueue(nbd->recv_workq);
-	mutex_lock(&nbd->config_lock);
 	nbd_bdev_reset(nbd);
 	/* user requested, ignore socket errors */
 	if (test_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags))
-- 
2.31.1

