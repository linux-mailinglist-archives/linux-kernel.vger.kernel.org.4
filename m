Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731C65BB6F0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiIQHYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIQHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:24:09 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E3A45F50
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 00:24:05 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220917072359epoutp01bf5a9fd5a6eb45aa9a7a04fffc42f621~VlPonakec2066820668epoutp01S
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:23:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220917072359epoutp01bf5a9fd5a6eb45aa9a7a04fffc42f621~VlPonakec2066820668epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663399439;
        bh=pWnbGJMrRMt/R18/F7egoAjJXBuAmKd68mnyBNIgt5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJ1IIXxmyFmcAiEGGIpW1PqT4KOO42uS2iFoEZKrGs7uqJLuZLOS2hjG54UVBo/dF
         4Hz0A0sjbLDGSDM07BIuUCf1QI71fSVB9tr1tfy/jeTaK9kRanqTgjFL4henS4DRIc
         kDV3DRGTyNuhJOmVrYG24M2S0CwH1Q5n70RexZis=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220917072358epcas1p4cd65db382a4a2ecf63c09b26bc9d751e~VlPoBuR-b2768227682epcas1p41;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.237]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MV2Vj6bb7z4x9Pq; Sat, 17 Sep
        2022 07:23:57 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.40.07146.D0675236; Sat, 17 Sep 2022 16:23:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220917072357epcas1p378e13844913c3c80acd183ddd59de456~VlPm0IIsp0623006230epcas1p3M;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220917072357epsmtrp2a8bc9de9aa8d5ee4470a8bc46851f8c2~VlPmzer2l1654916549epsmtrp2w;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
X-AuditID: b6c32a35-47bfe70000021bea-7b-6325760d1e88
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.45.14392.D0675236; Sat, 17 Sep 2022 16:23:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072357epsmtip2584397d85f2187275bbf735582252e13~VlPml8Cba3199331993epsmtip2Y;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, ogabbay@kernel.org,
        krzysztof.kozlowski@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com, jiho.chu@samsung.com
Subject: [PATCH v2 04/13] trinity: Add schduler module
Date:   Sat, 17 Sep 2022 16:23:47 +0900
Message-Id: <20220917072356.2255620-5-jiho.chu@samsung.com>
In-Reply-To: <20220917072356.2255620-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTT5e3TDXZYMFuA4u/k46xW0x9+ITN
        onnxejaL9927mS32vt7KbnF51xw2i9uNK9gs9vV8ZLR4Pu06iwOnx+9fkxg9Nq3qZPO4c20P
        m8f+uWvYPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkh
        LzE31VbJxSdA1y0zB+gqJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BaYFecWJu
        cWleul5eaomVoYGBkSlQYUJ2xp/mPuaC7wkVp/tmMTYwnvDvYuTkkBAwkVi/fA9zFyMXh5DA
        DkaJjU0LGEESQgKfGCVOrnSGSHwDSjxcygjTcWx/J1THXkaJRR+uQTmfGSVmb9rEDFLFJqAq
        MXPGGnYQW0SgXKJ54wkwm1kgR+LJnSawGmEBM4krt56xgNgsQPWfV3xhArF5BawldvVdB9vG
        KWAjcXNTEwtEXFDi5MwnLBBz5CWat84GWywh8JZdYsmeb0ANHECOi8SaByUQlwpLvDq+hR3C
        lpL4/G4vG4SdLTGlYxELhF0gce75VmaIVmOJiytSQExmAU2J9bv0ISoUJXb+nssIsZVP4t3X
        HlaIal6JjjYhiBIliSV/DkMtkpCYOuMbE4TtIdHT9wgaOv2MEm1vX7BOYJSfheSZWUiemYWw
        eQEj8ypGsdSC4tz01GLDAkN4nCbn525iBKdLLdMdjBPfftA7xMjEwXiIUYKDWUmEV9VTJVmI
        NyWxsiq1KD++qDQntfgQoykweCcyS4km5wMTdl5JvKGJpYGJmZGxiYWhmaGSOK+eNmOykEB6
        YklqdmpqQWoRTB8TB6dUA9MKX6785X4+c0Mq3+YIJfld/RR0qnTRL8dKl5frzNhbyyX2eIbO
        7OhUrjJy/n6puUXhk/z0zXME1qrder/idEopp+Ly+hBjuV8vv7P+DXWf49Wf+JtPyDvQQ2Bp
        na6KzlbG/dnSGa9enVOQn+DRvspE1JzffduRkgY5wQV6S7P/H5n2I+7cm+qcvKCtpat+5XXu
        /MoZ+brvQPuxazMFmS+Ephe6XLZfa+tyq6Db3S2X+1jUvo8blebGdG8LuCu7qHFh2Xor00W3
        79v7LeEINZPL9L4t/XHaRcOiO8fdUs4phbaxJE/X6oi3XpWgwvw0aaY/qxsfS3laJKfvq85d
        ub5s3Qff7xA/8dmA41WLEktxRqKhFnNRcSIAbEvkryAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSvC5vmWqywaStshZ/Jx1jt5j68Amb
        RfPi9WwW77t3M1vsfb2V3eLyrjlsFrcbV7BZ7Ov5yGjxfNp1FgdOj9+/JjF6bFrVyeZx59oe
        No/9c9ewe/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGn+Y+5oLvCRWn+2YxNjCe8O9i5OSQ
        EDCROLa/k7mLkYtDSGA3o0TP71NMEAkJiU33lgMlOIBsYYnDh4tBwkICHxkl1j2sALHZBFQl
        Zs5Yww5iiwjUShw8Op8ZxGYWKJCY/XQmC4gtLGAmceXWMzCbBaj+84ovYON5BawldvVdZwSx
        OQVsJG5uamKBmG8tMXv6XKgaQYmTM5+wQMyUl2jeOpt5AiP/LCSpWUhSCxiZVjFKphYU56bn
        FhsWGOallusVJ+YWl+al6yXn525iBAe2luYOxu2rPugdYmTiYDzEKMHBrCTCq+qpkizEm5JY
        WZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDE8t+P/cXWbyS6oES
        XyobHHNVOOU7Vk/1nBAb1zk9YffGvhJdTnebQ/dfmxXVebwMzmOzf3TWZ73EjCSL7rdPLO49
        jvopoqZU69u/OXWyfSvvJ0beyKhHdkoRa2OXW95e9+j82fu2dsstNKXaTzH+MJRL6tx9+rv0
        royWVukdP0UPX+Ob8DXIemKyIYN4iHuOyoa9c/P/59lebPM692ZJWeqT1ybpJeL+RatFLvtv
        cu2IjNL7Lmy+8viSje8Pue8RPZ9n75C8xF8mWu7DofQN6t5OTj43hRo2lmr+KvMMs+5lt/GJ
        3qMj9PJyX4NsL7PDUeVQn6Jnh6LztPTjzXjnvy96fT7UTK+3oZVVTImlOCPRUIu5qDgRAOzl
        BYvbAgAA
X-CMS-MailID: 20220917072357epcas1p378e13844913c3c80acd183ddd59de456
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072357epcas1p378e13844913c3c80acd183ddd59de456
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072357epcas1p378e13844913c3c80acd183ddd59de456@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes NPU scheduler interface.

Tasks can be pushed to the NPU in order by the scheduler. The default
schduling algorithm is provided using Priority policy.
When the requests are invoked, it calculates priority with remained time to
timeout, and it submits requests to NPU in priority order. It waits
until complete interrupt arrives from NPU, and pushes a next request.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/misc/trinity/Makefile              |   1 +
 drivers/misc/trinity/trinity.c             |   1 +
 drivers/misc/trinity/trinity_sched.c       | 338 +++++++++++++++++++++
 drivers/misc/trinity/trinity_sched.h       |  24 ++
 drivers/misc/trinity/trinity_vision2_drv.c |   1 +
 5 files changed, 365 insertions(+)
 create mode 100644 drivers/misc/trinity/trinity_sched.c
 create mode 100644 drivers/misc/trinity/trinity_sched.h

diff --git a/drivers/misc/trinity/Makefile b/drivers/misc/trinity/Makefile
index 5d2b75112482..2a8c4fed135e 100644
--- a/drivers/misc/trinity/Makefile
+++ b/drivers/misc/trinity/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_TRINITY_VISION2) += trinity_vision2.o
 
 trinity-y := trinity.o
 trinity-y += trinity_dma.o trinity_hwmem.o
+trinity-y += trinity_sched.o
 
 trinity_vision2-objs := $(trinity-y) trinity_vision2_drv.o
diff --git a/drivers/misc/trinity/trinity.c b/drivers/misc/trinity/trinity.c
index 3e8157dd4664..0c75eb13967c 100644
--- a/drivers/misc/trinity/trinity.c
+++ b/drivers/misc/trinity/trinity.c
@@ -14,6 +14,7 @@
 #include <linux/of_reserved_mem.h>
 
 #include "trinity_common.h"
+#include "trinity_sched.h"
 
 #define TRINITY_PADDR_BASE (0x0)
 
diff --git a/drivers/misc/trinity/trinity_sched.c b/drivers/misc/trinity/trinity_sched.c
new file mode 100644
index 000000000000..6e19841b345d
--- /dev/null
+++ b/drivers/misc/trinity/trinity_sched.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NPU scheduler for trinity requests
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#include <linux/kthread.h>
+#include <linux/spinlock.h>
+
+#include "trinity_common.h"
+
+struct trinity_sched_data {
+	struct llist_head req_queue;
+	wait_queue_head_t wait_queue;
+	struct task_struct *sched_thread;
+	struct mutex lock;
+	unsigned long suspended;
+};
+
+/**
+ * sched_calc_pri() - Calculate priority using timeout
+ */
+static unsigned long sched_calc_pri(struct trinity_req *req)
+{
+	ktime_t elapsed_time;
+	int64_t priority;
+
+	if (req->input.config.timeout_ms == 0)
+		return 0; /** @todo need preemption */
+
+	elapsed_time = ktime_to_ms(ktime_sub(ktime_get(), req->time_started));
+	WARN_ON(elapsed_time < 0);
+
+	/**
+	 * if the elapsed time exceeds the timeout of req,
+	 * its priority value is set to the minimum (highest).
+	 */
+	priority = req->input.config.timeout_ms - elapsed_time;
+	if (priority < 0)
+		priority = 0;
+
+	return priority;
+}
+
+/**
+ * sched_pick_req() - Pick the top-priority request from request queue
+ */
+static struct trinity_req *sched_pick_req(struct llist_head *queue)
+{
+	struct trinity_req *req, *req_prev;
+	struct trinity_req *top_req, *top_req_prev;
+	int64_t top_priority = S64_MAX;
+	unsigned long priority;
+
+	if (llist_empty(queue))
+		return NULL;
+
+	req = req_prev = NULL;
+	top_req = top_req_prev = NULL;
+
+	/**
+	 * llist is not a double linked list, and sorting is not easy
+	 * because llist provides only limited APIs.
+	 * it could be better than sorting if there are a few pending reqs.
+	 * Note that each user application can submit only one req at once.
+	 */
+	llist_for_each_entry(req, queue->first, llist) {
+		priority = sched_calc_pri(req);
+		if (top_priority > priority) {
+			top_priority = priority;
+			top_req = req;
+			top_req_prev = req_prev;
+		}
+
+		req_prev = req;
+	}
+
+	if (top_req_prev) {
+		WARN_ON(!top_req);
+		top_req_prev->llist.next = top_req->llist.next;
+	} else {
+		/** it's first entry */
+		top_req = llist_entry(llist_del_first(queue), typeof(*(req)),
+				      llist);
+	}
+
+	return top_req;
+}
+
+/**
+ * llist_last() - Get latest node from list
+ */
+static struct llist_node *llist_last(struct llist_node *first)
+{
+	struct llist_node *last = first;
+
+	while (first && first->next) {
+		last = first->next;
+		first = last;
+	}
+
+	return last;
+}
+
+/**
+ * trinity_sched_run_req() - Schedules a req to the target from the req queue
+ *
+ * @req: Request information to be submitted.
+ *
+ * Return: 0 on success. Otherwise, returns negative error. Additional status of
+ * the submitted req could be passed by req->status.
+ */
+static int32_t sched_run_req(struct trinity_req *req, struct trinity_sched_data *sched)
+{
+	struct trinity_driver *drv = req->drv;
+	struct device *dev = drv_to_dev_ptr(drv);
+	int32_t err = 0;
+	int32_t ready;
+
+	/** setup is only allowed in ready state */
+	ready = drv->desc->get_state(drv);
+	if (ready != TRINITY_STATE_READY) {
+		dev_err(dev,
+			"Cannot setup NPU when it's in a non-ready state");
+		err = -EPERM;
+		goto out;
+	}
+
+	if (req->stat->status != TRINITY_REQ_STATUS_PENDING &&
+	    req->stat->status != TRINITY_REQ_STATUS_FINISHED) {
+		dev_err(dev, "Invalid req status: %d",
+			req->stat->status);
+		err = -EINVAL;
+		goto out;
+	}
+
+	req->stat->status = TRINITY_REQ_STATUS_RUNNING;
+	err = drv->desc->invoke_req(drv, req, NULL);
+out:
+	if (err != 0)
+		req->stat->status = TRINITY_REQ_STATUS_ERROR;
+
+	return err;
+}
+
+/**
+ * sched_thread_func() - Scheduler thread function
+ */
+static int sched_thread_func(void *data)
+{
+	const unsigned long MAX_RETRY_COUNT = 100;
+	struct trinity_sched_data *sched;
+	struct llist_head local_queue;
+	struct llist_node *new_first;
+
+	sched = data;
+	init_llist_head(&local_queue);
+
+repeat:
+	if (kthread_should_stop())
+		return 0;
+
+	/** extract requests from global queue without locking */
+	new_first = llist_del_all(&sched->req_queue);
+	/** new and pending requests could be located together */
+	if (new_first) {
+		struct llist_node *new_last = llist_last(new_first);
+
+		llist_add_batch(new_first, new_last, &local_queue);
+	}
+
+	/** flush requests in the queue */
+	while (!llist_empty(&local_queue)) {
+		struct trinity_req *req;
+		int32_t ret;
+
+		/**
+		 * pick the top-priority request from the queue.
+		 * first and last node pointers are updated
+		 */
+		req = sched_pick_req(&local_queue);
+		if (!req)
+			goto repeat;
+
+		mutex_lock(&sched->lock);
+		ret = sched_run_req(req, sched);
+		mutex_unlock(&sched->lock);
+
+		/** do not modify or access for 'req' except on an error case.
+		 *  it could be released by the interrupt.
+		 */
+		if (ret == -EBUSY) {
+			if (req->submit_retry >= MAX_RETRY_COUNT) {
+				/** give up to handling this req*/
+				complete_all(&req->complete);
+			} else {
+				req->submit_retry++;
+				/** push again and restart the loop */
+				llist_add(&req->llist, &local_queue);
+			}
+			goto repeat;
+		} else if (ret != 0) {
+			/** let's notify this unknown error */
+			complete_all(&req->complete);
+		}
+	}
+
+	/** ensure the local queue is empty */
+	WARN_ON(!llist_empty(&local_queue));
+
+	wait_event_interruptible(
+		sched->wait_queue,
+		kthread_should_stop() ||
+			!llist_empty(&sched->req_queue));
+	goto repeat;
+}
+
+/**
+ * tirnity_sched_ready() - Check scheduler is ready
+ *
+ * @drv: an instance of trinity driver
+ */
+bool trinity_sched_ready(struct trinity_driver *drv)
+{
+	struct trinity_sched_data *sched = drv->sched_pdata;
+
+	return (test_bit(1, &sched->suspended) != 1);
+}
+
+/**
+ * trinity_sched_submit() - Submit request to scheduler
+ *
+ * @drv: an instance of trinity driver
+ * @req: request to be submitted
+ *
+ * Return: returns 0 on Success, otherwise returns negative error
+ */
+int32_t trinity_sched_submit(struct trinity_driver *drv, struct trinity_req *req)
+{
+	struct trinity_sched_data *sched = drv->sched_pdata;
+
+	if (!req)
+		return -EINVAL;
+
+	if (!trinity_sched_ready(drv))
+		return -EAGAIN;
+
+	llist_add(&req->llist, &sched->req_queue);
+	wake_up(&sched->wait_queue);
+
+	return 0;
+}
+
+/**
+ * trinity_sched_notify() - finishes and notify the request handled
+ */
+void trinity_sched_notify(struct trinity_req *req, bool timeout)
+{
+	req->scheduled = false;
+	req->timeout = timeout;
+}
+
+/**
+ * trinity_sched_suspend() - Suspend scheduler
+ *
+ * @drv: an instance of trinity driver
+ */
+void trinity_sched_suspend(struct trinity_driver *drv)
+{
+	struct trinity_sched_data *sched = drv->sched_pdata;
+
+	if (!test_and_set_bit(1, &sched->suspended))
+		mutex_lock(&sched->lock);
+}
+
+/**
+ * trinity_sched_resume() - Resume scheduler
+ *
+ * @drv: an instance of trinity driver
+ */
+void trinity_sched_resume(struct trinity_driver *drv)
+{
+	struct trinity_sched_data *sched = drv->sched_pdata;
+
+	if (test_and_clear_bit(1, &sched->suspended))
+		mutex_unlock(&sched->lock);
+}
+
+/**
+ * trinity_sched_init() - Initialize trinity task schedulers
+ *
+ * @dev: an instance of the device
+ * Return: returns 0 on Success, otherwise returns negative error
+ */
+int trinity_sched_init(struct device *dev)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+	struct trinity_sched_data *sched;
+
+	sched = devm_kzalloc(dev, sizeof(*sched), GFP_KERNEL);
+	if (!sched)
+		return -ENOMEM;
+
+	init_llist_head(&sched->req_queue);
+	init_waitqueue_head(&sched->wait_queue);
+
+	mutex_init(&sched->lock);
+	clear_bit(1, &sched->suspended);
+
+	sched->sched_thread =
+		kthread_run(sched_thread_func, sched, "trinity_sched_thread");
+	if (IS_ERR(sched->sched_thread)) {
+		dev_err(dev,
+			"Failed to create a thread for scheduler");
+		return PTR_ERR(sched->sched_thread);
+	}
+	drv->sched_pdata = sched;
+
+	return 0;
+}
+
+/**
+ * trinity_sched_exit() - Exit trinity task schedulers
+ *
+ * @dev: an instance of the device
+ */
+void trinity_sched_exit(struct device *dev)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+
+	if (drv->sched_pdata)
+		devm_kfree(dev, drv->sched_pdata);
+}
diff --git a/drivers/misc/trinity/trinity_sched.h b/drivers/misc/trinity/trinity_sched.h
new file mode 100644
index 000000000000..751d82d4374e
--- /dev/null
+++ b/drivers/misc/trinity/trinity_sched.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NPU scheduler for trinity requests
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#ifndef __DRIVERS_MISC_TRINITY_SCHED_H__
+#define __DRIVERS_MISC_TRINITY_SCHED_H__
+
+bool trinity_sched_ready(struct trinity_driver *drv);
+int32_t trinity_sched_submit(struct trinity_driver *drv,
+			struct trinity_req *req);
+void trinity_sched_notify(struct trinity_req *req, bool timeout);
+void trinity_sched_suspend(struct trinity_driver *drv);
+void trinity_sched_resume(struct trinity_driver *drv);
+int32_t trinity_sched_init(struct device *dev);
+void trinity_sched_exit(struct device *dev);
+
+#endif /* __DRIVERS_MISC_TRINITY_SCHED_H__ */
diff --git a/drivers/misc/trinity/trinity_vision2_drv.c b/drivers/misc/trinity/trinity_vision2_drv.c
index 4bfc7f97769c..70b8b6fd5843 100644
--- a/drivers/misc/trinity/trinity_vision2_drv.c
+++ b/drivers/misc/trinity/trinity_vision2_drv.c
@@ -16,6 +16,7 @@
 #include <linux/utsname.h>
 
 #include "trinity_common.h"
+#include "trinity_sched.h"
 #include "trinity_vision2_regs.h"
 
 #define TRIV2_DRV_GET_PDATA(drv) ((struct triv2_pdata *)(drv->pdata))
-- 
2.25.1

