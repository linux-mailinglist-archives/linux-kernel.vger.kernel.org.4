Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6442B642691
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiLEKSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiLEKSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:18:18 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6D91181D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:18:16 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NQfYK5PzbzkXn3;
        Mon,  5 Dec 2022 18:14:45 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 5 Dec
 2022 18:18:14 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <david@fries.net>, <gregkh@linuxfoundation.org>
Subject: [PATCH] w1: fix WARNING after calling w1_process()
Date:   Mon, 5 Dec 2022 18:15:58 +0800
Message-ID: <20221205101558.3599162-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following WARNING message while removing driver(ds2482):

------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=1 set at [<000000002d50bfb6>] w1_process+0x9e/0x1d0 [wire]
WARNING: CPU: 0 PID: 262 at kernel/sched/core.c:9817 __might_sleep+0x98/0xa0
CPU: 0 PID: 262 Comm: w1_bus_master1 Tainted: G                 N 6.1.0-rc3+ #307
RIP: 0010:__might_sleep+0x98/0xa0
Call Trace:
 exit_signals+0x6c/0x550
 do_exit+0x2b4/0x17e0
 kthread_exit+0x52/0x60
 kthread+0x16d/0x1e0
 ret_from_fork+0x1f/0x30

The state of task is set to TASK_INTERRUPTIBLE in loop in w1_process(),
set it to TASK_RUNNING when it breaks out of the loop to avoid the
warning.

Fixes: 3c52e4e62789 ("W1: w1_process, block or sleep")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/w1/w1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 8b35fae4cd61..4a2ddf730a3a 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -1195,8 +1195,10 @@ int w1_process(void *data)
 		 */
 		mutex_unlock(&dev->list_mutex);
 
-		if (kthread_should_stop())
+		if (kthread_should_stop()) {
+			__set_current_state(TASK_RUNNING);
 			break;
+		}
 
 		/* Only sleep when the search is active. */
 		if (dev->search_count) {
-- 
2.25.1

