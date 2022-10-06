Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB325F65E1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiJFMWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiJFMWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122779E0D2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665058939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VyLNJ3Q8dO/0vKh1HIe/nO5H/c5qCfiPxqiFfqkNSWk=;
        b=A1ePRC5HKMowZ0/giYexFf3tx/ZdLi2yFa7PNcdlwPGl7N+57LAqp0BD4mgDXuKXbKSqFi
        yza5H335XZ+iyMrhSH52Rzfue+lMlyaOu5Ek+qoHzO4oc5VML/dsV++vI2Vau+me2AD/mB
        fr73Oa2duTn9Rl70UWJcBISXjWIGoGg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-481-gozsNrFrNJqAEfZRQZIqoA-1; Thu, 06 Oct 2022 08:22:18 -0400
X-MC-Unique: gozsNrFrNJqAEfZRQZIqoA-1
Received: by mail-wm1-f71.google.com with SMTP id v191-20020a1cacc8000000b003bdf7b78dccso954602wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyLNJ3Q8dO/0vKh1HIe/nO5H/c5qCfiPxqiFfqkNSWk=;
        b=QsxHdj8jQGkxsoK8qeKzYXBbsAUYDK+TxvFQnwU9rTLpdVD/tbqDnET9RZQvVVHzDk
         zaP15JP+p4CCHz66uynBXM9YGrGjd1lH1YV1cil558qzEIcbXGh/1VtSv5udshSI3J2l
         iJSN+znLhIUpQnKdanaqJF+Rj5sBuvq4O7ueErbA33rWGd++iGp0ehMIFuNWYPSulP+v
         HOHTiJ/AHWit8Hia8DSV8B3UqJON/AP2/H/ycYHDhLiiM+BttgafGE/HrGEtg2jrzNYS
         chV9KlNLU9zvcBkMiOCyI9/sew3hNk4QvpxOChuN9DnVvbF3AJ+9UvrrsuSzTjtBY+1y
         HJng==
X-Gm-Message-State: ACrzQf2ZXEeEe1kCmt8q+IVamCd7hfqJQaP1+OA+V5PIwebYU5Qd3K0L
        iXzhBIZpRhvCiGGv93vVVwM2tAKi0cYI3E0DiG24z6jWq8ypE520QSDm/QK3JMkK3tLHw57KVWU
        /fBMmIqog8281SimCQSrvrK2v
X-Received: by 2002:a7b:cb56:0:b0:3b3:4ad8:9e31 with SMTP id v22-20020a7bcb56000000b003b34ad89e31mr3011936wmj.87.1665058936811;
        Thu, 06 Oct 2022 05:22:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7qWsAUUYKzD5ctEpWK6L/j4O461FW/w/5nPtaXdKtNtdlZORmxI4PlTdF8RnFxVcoKWbiuLg==
X-Received: by 2002:a7b:cb56:0:b0:3b3:4ad8:9e31 with SMTP id v22-20020a7bcb56000000b003b34ad89e31mr3011921wmj.87.1665058936626;
        Thu, 06 Oct 2022 05:22:16 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003bdd2add8fcsm5004841wmq.24.2022.10.06.05.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:22:15 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH bitmap-for-next 4/4] blk_mq: Fix cpumask_check() warning in blk_mq_hctx_next_cpu()
Date:   Thu,  6 Oct 2022 13:21:12 +0100
Message-Id: <20221006122112.663119-5-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221006122112.663119-1-vschneid@redhat.com>
References: <20221006122112.663119-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_mq_hctx_next_cpu() implements a form of cpumask_next_and_wrap() using
cpumask_next_and_cpu() and blk_mq_first_mapped_cpu():

[    5.398453] WARNING: CPU: 3 PID: 162 at include/linux/cpumask.h:110 __blk_mq_delay_run_hw_queue+0x16b/0x180
[    5.399317] Modules linked in:
[    5.399646] CPU: 3 PID: 162 Comm: ssh-keygen Tainted: G                 N 6.0.0-rc4-00004-g93003cb24006 #55
[    5.400135] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[    5.405430] Call Trace:
[    5.406152]  <TASK>
[    5.406452]  blk_mq_sched_insert_requests+0x67/0x150
[    5.406759]  blk_mq_flush_plug_list+0xd0/0x280
[    5.406987]  ? bit_wait+0x60/0x60
[    5.407317]  __blk_flush_plug+0xdb/0x120
[    5.407561]  ? bit_wait+0x60/0x60
[    5.407765]  io_schedule_prepare+0x38/0x40
[...]

This triggers a warning when next_cpu == nr_cpu_ids - 1, so rewrite it
using cpumask_next_and_wrap() directly. The backwards-going goto can be
removed, as the cpumask_next*() operation already ANDs hctx->cpumask and
cpu_online_mask, which implies checking for an online CPU.

No change in behaviour intended.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 block/blk-mq.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c96c8c4f751b..1520794dd9ea 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2038,42 +2038,29 @@ static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
  */
 static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 {
-	bool tried = false;
 	int next_cpu = hctx->next_cpu;
 
 	if (hctx->queue->nr_hw_queues == 1)
 		return WORK_CPU_UNBOUND;
 
-	if (--hctx->next_cpu_batch <= 0) {
-select_cpu:
-		next_cpu = cpumask_next_and(next_cpu, hctx->cpumask,
-				cpu_online_mask);
-		if (next_cpu >= nr_cpu_ids)
-			next_cpu = blk_mq_first_mapped_cpu(hctx);
+	if (--hctx->next_cpu_batch > 0 && cpu_online(next_cpu))
+		return next_cpu;
+
+	next_cpu = cpumask_next_and_wrap(next_cpu, hctx->cpumask, cpu_online_mask, next_cpu, false);
+	if (next_cpu < nr_cpu_ids) {
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
+		hctx->next_cpu = next_cpu;
+		return next_cpu;
 	}
 
 	/*
-	 * Do unbound schedule if we can't find a online CPU for this hctx,
-	 * and it should only happen in the path of handling CPU DEAD.
+	 * No other online CPU in hctx->cpumask.
+	 *
+	 * Make sure to re-select CPU next time once after CPUs
+	 * in hctx->cpumask become online again.
 	 */
-	if (!cpu_online(next_cpu)) {
-		if (!tried) {
-			tried = true;
-			goto select_cpu;
-		}
-
-		/*
-		 * Make sure to re-select CPU next time once after CPUs
-		 * in hctx->cpumask become online again.
-		 */
-		hctx->next_cpu = next_cpu;
-		hctx->next_cpu_batch = 1;
-		return WORK_CPU_UNBOUND;
-	}
-
-	hctx->next_cpu = next_cpu;
-	return next_cpu;
+	hctx->next_cpu_batch = 1;
+	return WORK_CPU_UNBOUND;
 }
 
 /**
-- 
2.31.1

