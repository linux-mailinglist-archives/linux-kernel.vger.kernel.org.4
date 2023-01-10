Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE23664E89
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjAJWLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjAJWK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:10:59 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421BF2653
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:10:53 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230110221052euoutp01fc8073b44c4f32e243290409edb6babd~5Ehz-BoVF3098630986euoutp01t
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:10:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230110221052euoutp01fc8073b44c4f32e243290409edb6babd~5Ehz-BoVF3098630986euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673388652;
        bh=aDwwXnazPVSQ+yvIKpbLVcKE8HhnZcKuDsNRJFw81Qc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QxyBm1eSrsILoV+lArCo4Rf1YKbPmfdhJCZgFHK9wpzC8S69Mjr3WkWe78e5fXUkj
         xBUScD9K5DHTaSneybhy8HNHSyXj4sK7IKW9kt3+GyTD6mw19tW5DNTFXnUVpFt8Wn
         XJMsdOolpZrYBvq9+W7Hf3RKcqaaahS3ufnphR+c=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230110221051eucas1p120137684dafb329829719aa2fedaa151~5EhzfKehp1952319523eucas1p1a;
        Tue, 10 Jan 2023 22:10:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F6.E7.43884.B62EDB36; Tue, 10
        Jan 2023 22:10:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230110221051eucas1p26888130e7de454995a00918456c99bdb~5EhzDy8hm0420104201eucas1p2M;
        Tue, 10 Jan 2023 22:10:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230110221051eusmtrp1a22a8ee2b02baa57e5a4241c6ad47c60~5EhzDNJbE2004620046eusmtrp1L;
        Tue, 10 Jan 2023 22:10:51 +0000 (GMT)
X-AuditID: cbfec7f5-25bff7000000ab6c-97-63bde26b30e8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A9.58.23420.B62EDB36; Tue, 10
        Jan 2023 22:10:51 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230110221050eusmtip10f91a3a1a577cafdf8e70175dc0c5729~5Ehyen3pN1935119351eusmtip1P;
        Tue, 10 Jan 2023 22:10:50 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Rob Barnes <robbarnes@google.com>, dtor@chromium.org
Subject: [PATCH] platform/chrome: cros_ec: Fix panic notifier registration
Date:   Tue, 10 Jan 2023 23:10:33 +0100
Message-Id: <20230110221033.7441-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87rZj/YmGzx/qmkx/cllFou3y+Yx
        Wsxs2s5qcerVMmaLy7vmsFmsPXKX3WLqhdnsFm/nb2K3+H53IpMDp8fshossHgs2lXpsWtXJ
        5vFi80xGj74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4Mr4fXktS8E9oYqN6/waGI8IdDFyckgI
        mEicmPmasYuRi0NIYAWjxL2rk9ghnC+MEvfblrJAOJ8ZJRbe/cTaxcgB1tK3IwIivpxR4t+R
        n4xwHVumzGIDmcsmYCjR9bYLzBYRcJT403CHFaSIWaCBSWLW4Vdgk4QFvCTO/+UCqWERUJW4
        +nQaO4jNK2Aj0Xahjx3iPnmJ1udbWSHighInZz5hAbGZgeLNW2czg8yUENjBIfH47y8WiOtc
        JFZ2x0P0Cku8Or4Fao6MxOnJPSwQ9e2MEgt+32eCcCYwSjQ8v8UIUWUtcefcLzaQQcwCmhLr
        d+lDzHSUuHJeHsLkk7jxVhDiBD6JSdumM0OEeSU62oQgZqhJzDq+Dm7rwQuXmCFsD4m3C7+A
        Q0RIIFbixb77bBMYFWYheWwWksdmIZywgJF5FaN4amlxbnpqsXFearlecWJucWleul5yfu4m
        RmAKOv3v+NcdjCtefdQ7xMjEwXiIUYKDWUmEdyXnnmQh3pTEyqrUovz4otKc1OJDjNIcLEri
        vDO2zk8WEkhPLEnNTk0tSC2CyTJxcEo1ME2cMFXp937OSVfXvA0UMJvu+mXtrsq4ie/e/PEN
        iVxf6WydkPmuwd3kx3xbP8FPkeHBBYXTpp+y2cszk7WS4Y352/PvHlm9l8g1fNYkG+nju9FI
        /pkQS1lviM7Xi2dv/CnddqZlUrF7o6f/g5kZjCu6p4vnxs7gzU66kLKrq7Ykjn3DQZc5DfP8
        n/RttraL+rq8cfFx4e/x2t3bGL//77w13Wmn/9crGeZsVs7fyxSkwye+1mPlmbaie83FK7dZ
        uxOUDzmuy5ffe+f8jt5D392+dB0QW2/3qffRC5FnO13/GdpMsVqp8aXf7U9+2Od5exgefL1y
        P2FW4QL29LZXTlHe352nODFUrTrupXbS/6oSS3FGoqEWc1FxIgCrAIgBsAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsVy+t/xu7rZj/YmG3z9wWkx/cllFou3y+Yx
        Wsxs2s5qcerVMmaLy7vmsFmsPXKX3WLqhdnsFm/nb2K3+H53IpMDp8fshossHgs2lXpsWtXJ
        5vFi80xGj74tqxg9Pm+SC2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXS
        t7NJSc3JLEst0rdL0Mv4fXktS8E9oYqN6/waGI8IdDFycEgImEj07YjoYuTiEBJYyiixafMZ
        li5GTqC4jMTJaQ2sELawxJ9rXWwgtpDAJ0aJyUuMQGw2AUOJrrcQcREBZ4mnp9+zgwxiFmhj
        knjycBkTyAJhAS+J83+5QGpYBFQlrj6dxg5i8wrYSLRd6GOHmC8v0fp8KytEXFDi5MwnYDcw
        A8Wbt85mnsDINwtJahaS1AJGplWMIqmlxbnpucWGesWJucWleel6yfm5mxiBob/t2M/NOxjn
        vfqod4iRiYPxEKMEB7OSCO9Kzj3JQrwpiZVVqUX58UWlOanFhxhNge6byCwlmpwPjL68knhD
        MwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQam3XX2k68UCFzI6b2VqJbL
        XmEaIFTlq3xowYHchFPsBzhbZ/xPX+zM6W9o2t7kOnVZVYnYzave7Bvqtoum3GTJ+uhcwPX8
        8LE1N0VST8rKx4qYaV1r7J847crlr5xrVHfv53nSon3Rs0bHa6qX7cUPE6ed9l3D7Sr60ln7
        0t/pP5wY9waeXrftRde+WyYhyU/7ly/Nv+Jy6MrEB6EXz5WoTdW68+nKdfPvqU/dXldmXRNW
        CDBY4XB95ynu2I3nRBLldTqiDj65330qVnzuuq6yt8ILbvg8Kj/I6S/fMrFSz1ir+eKc6/tU
        Hx8x+Lc6o/TOjFkNvrNWhyy4feKVSq1VouCcC593u+vaSx+/fFj2oRJLcUaioRZzUXEiAJTn
        VacGAwAA
X-CMS-MailID: 20230110221051eucas1p26888130e7de454995a00918456c99bdb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230110221051eucas1p26888130e7de454995a00918456c99bdb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230110221051eucas1p26888130e7de454995a00918456c99bdb
References: <CGME20230110221051eucas1p26888130e7de454995a00918456c99bdb@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize panic notifier to avoid the following lockdep warning:

--->8---
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 62 Comm: kworker/u16:1 Not tainted 6.2.0-rc3-next-20230110-00037-g7c2b0426386a #6112
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_unbound async_run_entry_fn
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x58/0x70
 dump_stack_lvl from register_lock_class+0x998/0x9a8
 register_lock_class from __lock_acquire+0x6c/0x2a80
 __lock_acquire from lock_acquire+0x124/0x3f0
 lock_acquire from down_write+0x40/0xd8
 down_write from blocking_notifier_chain_register+0x28/0x58
 blocking_notifier_chain_register from cros_ec_debugfs_probe+0x324/0x3b4
 cros_ec_debugfs_probe from platform_probe+0x5c/0xb8
 platform_probe from really_probe+0xe0/0x414
 really_probe from __driver_probe_device+0x9c/0x200
 __driver_probe_device from driver_probe_device+0x30/0xc0
 driver_probe_device from __device_attach_driver+0xa8/0x120
 __device_attach_driver from bus_for_each_drv+0x7c/0xc0
 bus_for_each_drv from __device_attach_async_helper+0xa0/0xf4
 __device_attach_async_helper from async_run_entry_fn+0x40/0x154
 async_run_entry_fn from process_one_work+0x288/0x790
 process_one_work from worker_thread+0x44/0x504
 worker_thread from kthread+0xf0/0x124
 kthread from ret_from_fork+0x14/0x2c
Exception stack(0xf0a6dfb0 to 0xf0a6dff8)
...
------------[ cut here ]------------

Fixes: d90fa2c64d59 ("platform/chrome: cros_ec: Poll EC log on EC panic")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/platform/chrome/cros_ec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index ec733f683f34..c4345dafec57 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -182,6 +182,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	int err = 0;
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&ec_dev->event_notifier);
+	BLOCKING_INIT_NOTIFIER_HEAD(&ec_dev->panic_notifier);
 
 	ec_dev->max_request = sizeof(struct ec_params_hello);
 	ec_dev->max_response = sizeof(struct ec_response_get_protocol_info);
-- 
2.39.0

