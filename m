Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C096E06DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 08:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjDMGXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 02:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDMGXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 02:23:54 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777AF6EA7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 23:23:52 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 21so5808897plg.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1681367031; x=1683959031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ux89XlsyFK7f2HcxESYLkY+feFhS2ro/LkG4L+aicTM=;
        b=jd2hnsfdgSD3mvFx8/+fN/+jYUOIJXK3lit+F2/pZkiE9ucIsISc7L0Y3OB8/cqeSU
         W1hZAobo07JWC9JbOYyOm+mWFaFVj5oxhPQRmBa8T4w6F+WGdptJfzmPCOwsFo3SUAi6
         Ux3DCjqscq2MHt12lfUka9M0adJkQ2hPvgzILYwEGwOCe5EXj+2G/1anrhqP4A4qmQYX
         Ggnde6ngmnbbNlbxpBDUKb8S6ITvzaKJTBis2aSm18t3WSNvA5xkYcjAL/TKgpB13n/d
         GHuzXRMtSBfyrD5EtyGKzG862INu4lBHwCwnLCt+X2EQO6Uf7dgYa/fgkkT62hoYUHoT
         6l8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681367031; x=1683959031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ux89XlsyFK7f2HcxESYLkY+feFhS2ro/LkG4L+aicTM=;
        b=GqLiFPm1/UV9uCA6gC2dRAR3ROZ2MIf2WpnIlO4E6exP4q1CYT3arMR4b23VVlSja1
         LHWR1hrFWrHEDJ4ky6+GVW8smEDeAYcS79OpAiSgn3XTGWvsOyUy3EHEnFLyLJ0w5m4f
         +XCUz8EMazbtRlgKbnYG01EWMvHTEzP2xngXNHodtzZAv6OkQo1Kx4WrBvcufDOfandC
         VHnZnTq6UH6GvNvry5ikdW+F5XPBJiQiUdyH8w+0QYdQdFwE4VBubV7BLY3aNx5ucxzS
         Lck0lSDOx+5EUzdrmTpeJdbiV3ojJAHxBpNvk7CjsIMsUSHuuvHpBpJi3/8HfCrAyTEy
         LcLw==
X-Gm-Message-State: AAQBX9fkkw74HI06moU04hJcmYVWEUcimgoJwnyghpCc4lU09ZWRtH2k
        VkOiCPEeOt9PD/UzfxeKnINixw5BVjPa3qc1hg0pfJcleIM=
X-Google-Smtp-Source: AKy350ZhmEyM1TLtK83CprdmPCRPfIDJyvC/ay4XOP/tEBO4h6Z6X+aHfwLYnrhKueWMTKrJUQlgFA==
X-Received: by 2002:a17:902:dac5:b0:1a5:150f:8558 with SMTP id q5-20020a170902dac500b001a5150f8558mr1366914plx.17.1681367031254;
        Wed, 12 Apr 2023 23:23:51 -0700 (PDT)
Received: from bogon.gitgo.cc ([47.243.123.68])
        by smtp.gmail.com with ESMTPSA id q24-20020a170902b11800b0019e8915b1b5sm647980plr.105.2023.04.12.23.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 23:23:50 -0700 (PDT)
From:   Li Feng <fengli@smartx.com>
To:     linux-kernel@vger.kernel.org (open list)
Cc:     lifeng1519@gmail.com, Li Feng <fengli@smartx.com>
Subject: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
Date:   Thu, 13 Apr 2023 14:23:38 +0800
Message-Id: <20230413062339.2454616-1-fengli@smartx.com>
X-Mailer: git-send-email 2.40.0
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

