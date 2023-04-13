Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003CD6E0EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjDMNak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDMNad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:30:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F114683
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:30:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mq14-20020a17090b380e00b002472a2d9d6aso573966pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1681392603; x=1683984603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4DTAdqVpW5zvcBkZu175H3BHMe4k/6Dkx1pmXMIM5U=;
        b=tujX/TjriV2EXeDcQeiSaMykmam+Sh+rcS20J6bQD0n2DvMxj0XC2I3nyyDHy7K2p0
         JZd0cWNbeDXxFakoGiuwX+/MU9aVtCGRyVBoTcsk7h1OlpbvtOCleVWlcurrMjbADDcq
         X8x4sikMWMKYTV6nvY/IIG/DAH/DkmWqxOWGVxq9F9lWOAwo8IoTzOujhCb8BALhlSYH
         Cu6kQEjwj6IL5x55pdkjSQ+TgN+M74FgDGUA7TCoSJj/3vF/lseEzNZxAxaeH4cjPZ2C
         J4JvxPz5Kfe+B8akcPZWk/FB+3tv5wdFqlyZVcFjbq8gQKm9ZS/4qgh4cRqrzJ6CpAts
         2mAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392603; x=1683984603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4DTAdqVpW5zvcBkZu175H3BHMe4k/6Dkx1pmXMIM5U=;
        b=WY7vLGAxCrBKZSpAYylCkdYQG9lrSCF6Al3Rri44+HX6etdJlO4ntJGvJ7tu99SoEj
         Q/vyxiw+6hCS8TZ+nkqqdwrnwa92aSfU1HLWKqdA0GSnrm5s3TDbVbv5dlxUrGsxlbSo
         2e0Xr0DVhntJziZNIXS/oCCQOOE9VVgfivnoIuZbok8tX+rTPPJr9AsADoRx0nvhjfgV
         QWkFP0mfb8oROIcAFoQW/HyCtqg2sNwMzPTFSxKgXf/jnnteOn/ti4Tyh+kWRgsvMrXt
         3f15euYf4JWY+fCV3/DC3qaqezNR6dhoh/J2pqrq4gp8uSOrevsFg+AGKEKE5W/iLSlr
         05uw==
X-Gm-Message-State: AAQBX9dD+vDtWhrEcBhwCksxMwqJsBceYUeXG/PXLF6N54yIUHES1d7H
        JH2OSgryHUFjQmGT5gcu6Vfzpw==
X-Google-Smtp-Source: AKy350ZaOW14CYFP6VD7mRkXUxJXzITWQ88A5W3EStgQABkf570+KojusOpXvm2ss3M/bLsLUpf2HQ==
X-Received: by 2002:a17:902:e884:b0:1a6:8ee3:4e2e with SMTP id w4-20020a170902e88400b001a68ee34e2emr1670819plg.33.1681392603237;
        Thu, 13 Apr 2023 06:30:03 -0700 (PDT)
Received: from localhost.localdomain.cc ([47.75.78.161])
        by smtp.gmail.com with ESMTPSA id z18-20020a170902ee1200b001a4fe00a8d4sm1487836plb.90.2023.04.13.06.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:30:02 -0700 (PDT)
From:   Li Feng <fengli@smartx.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     lifeng1519@gmail.com, Li Feng <fengli@smartx.com>
Subject: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu affinity
Date:   Thu, 13 Apr 2023 21:29:41 +0800
Message-Id: <20230413132941.2489795-1-fengli@smartx.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230413062339.2454616-1-fengli@smartx.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default worker affinity policy is using all online cpus, e.g. from 0
to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
have a bad performance.

This patch adds a module parameter to set the cpu affinity for the nvme-tcp
socket worker threads.  The parameter is a comma separated list of CPU
numbers.  The list is parsed and the resulting cpumask is used to set the
affinity of the socket worker threads.  If the list is empty or the
parsing fails, the default affinity is used.

Signed-off-by: Li Feng <fengli@smartx.com>
---

V2 - Fix missing static reported by lkp

 drivers/nvme/host/tcp.c | 54 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 49c9e7bc9116..47748de5159b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -31,6 +31,18 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
 
+/* Support for specifying the CPU affinity for the nvme-tcp socket worker
+ * threads.  This is a comma separated list of CPU numbers.  The list is
+ * parsed and the resulting cpumask is used to set the affinity of the
+ * socket worker threads.  If the list is empty or the parsing fails, the
+ * default affinity is used.
+ */
+static char *cpu_affinity_list;
+module_param(cpu_affinity_list, charp, 0644);
+MODULE_PARM_DESC(cpu_affinity_list, "nvme tcp socket worker cpu affinity list");
+
+static struct cpumask cpu_affinity_mask;
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -1483,6 +1495,41 @@ static bool nvme_tcp_poll_queue(struct nvme_tcp_queue *queue)
 			  ctrl->io_queues[HCTX_TYPE_POLL];
 }
 
+static ssize_t update_cpu_affinity(const char *buf)
+{
+	cpumask_var_t new_value;
+	cpumask_var_t dst_value;
+	int err = 0;
+
+	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
+		return -ENOMEM;
+
+	err = bitmap_parselist(buf, cpumask_bits(new_value), nr_cpumask_bits);
+	if (err)
+		goto free_new_cpumask;
+
+	if (!zalloc_cpumask_var(&dst_value, GFP_KERNEL)) {
+		err = -ENOMEM;
+		goto free_new_cpumask;
+	}
+
+	/*
+	 * If the new_value does not have any intersection with the cpu_online_mask,
+	 * the dst_value will be empty, then keep the cpu_affinity_mask as cpu_online_mask.
+	 */
+	if (cpumask_and(dst_value, new_value, cpu_online_mask))
+		cpu_affinity_mask = *dst_value;
+
+	free_cpumask_var(dst_value);
+
+free_new_cpumask:
+	free_cpumask_var(new_value);
+	if (err)
+		pr_err("failed to update cpu affinity mask, bad affinity list [%s], err %d\n",
+			buf, err);
+	return err;
+}
+
 static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
@@ -1496,7 +1543,12 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	else if (nvme_tcp_poll_queue(queue))
 		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
 				ctrl->io_queues[HCTX_TYPE_READ] - 1;
-	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
+
+	if (!cpu_affinity_list || update_cpu_affinity(cpu_affinity_list) != 0) {
+		// Set the default cpu_affinity_mask to cpu_online_mask
+		cpu_affinity_mask = *cpu_online_mask;
+	}
+	queue->io_cpu = cpumask_next_wrap(n - 1, &cpu_affinity_mask, -1, false);
 }
 
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
-- 
2.40.0

