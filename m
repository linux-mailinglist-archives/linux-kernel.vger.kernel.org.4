Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321DC6E0703
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 08:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDMGe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 02:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMGeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 02:34:25 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13617DB3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 23:34:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id ke16so13952084plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 23:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1681367664; x=1683959664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux89XlsyFK7f2HcxESYLkY+feFhS2ro/LkG4L+aicTM=;
        b=LtC+9EwMzJbtSHFZIQviDd1y3nzmCThnC0E1KOYAmdnfuZCqEJ9qi/6IS751ntRkYv
         KHR3ymKcBOnQ7oH2NDGGW68XPIVEBc22qXn968J8kbS1nWU54o0M63DHUdfpdYn36BEK
         MahOSjk0y8xRIZNfZapEdJ48np/WVezsqnsEuD2KAgp+s1h9uEZlveYyggePUkrrANAB
         04jMQDlAOppFQ3zTxHB2d85Up3YrN4uPx4U4TpgTTrRE2d1xKTNOoA2Ns2fVgANslCv4
         aGa66sKTZUsDOJiy3jQsBlx2iYA5gA/CZoVBG0wuLc7WI3vrkiU/SQ2cfKrGIOtamjeq
         Zv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681367664; x=1683959664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ux89XlsyFK7f2HcxESYLkY+feFhS2ro/LkG4L+aicTM=;
        b=gOgs0d67r+zCXuSiPj2BJvt7W9vmUsQ7yginTm7yzLJzJnWAM/lFVAx2iPHvpnwkQN
         EcOBxXDqCRlq7mC5217XT5ajaNoluXc6FLFrWG0bGgPHqQi7QO5JWFQtlfujflk+93uW
         QvANFsiwOd1IoIXB5UPHe9MZwK1T0xRjn+pDf6LW5zsZ7AqLBar5kmP629Aq9uilPZl9
         A3ui7eVt1hrBTQDOHkG730lER5HdP5WbfL+TAVQqrY5hG2n+zrW0q/hsorFNw1NGa8l+
         pOBP0EYyANmI9rmv3TDLGdfn2Myl/KC1DUXXGdQ9B0u3YNVejemz/c/bbS49HpLwQoev
         /RGA==
X-Gm-Message-State: AAQBX9d1ai+XtQQAyWkhxkL4u/ZQdNGamIvrbp95Jo92XXGa/pZpXfUU
        xRGQ+tzM/Te6MBXEvW+UsrtKIw==
X-Google-Smtp-Source: AKy350bXyTEx3noUhrYt3iXoek2M9Hy6O2MKG8caOPBdyazZul+2hfnEF8nCHJnvZEg+ScZzsE/3SQ==
X-Received: by 2002:a17:903:1211:b0:19a:9890:eac6 with SMTP id l17-20020a170903121100b0019a9890eac6mr1212997plh.24.1681367663912;
        Wed, 12 Apr 2023 23:34:23 -0700 (PDT)
Received: from bogon.gitgo.cc ([1.202.18.10])
        by smtp.gmail.com with ESMTPSA id p24-20020a1709028a9800b001a66c4afe0asm649896plo.255.2023.04.12.23.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 23:34:23 -0700 (PDT)
From:   Li Feng <fengli@smartx.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     lifeng1519@gmail.com, Li Feng <fengli@smartx.com>
Subject: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
Date:   Thu, 13 Apr 2023 14:33:17 +0800
Message-Id: <20230413063317.2455680-1-fengli@smartx.com>
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
 drivers/nvme/host/tcp.c | 54 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 49c9e7bc9116..a82c50adb12b 100644
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
+struct cpumask cpu_affinity_mask;
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

