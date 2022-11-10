Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8395062415C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiKJL1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKJL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:27:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F3953EDC;
        Thu, 10 Nov 2022 03:27:11 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso1262810pjc.5;
        Thu, 10 Nov 2022 03:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R4JSNtBnOFBc3pGwCyNxt/wdF3MreeTClRovgXRSqJU=;
        b=ovbGQqlcG0M/MlvAYZYDT34I/hzTHDI3pORy74lXMXlFO0ppRNriHlA+0MdN3fvAY3
         NRUR2jJ6FyWek4QIs+bbVh4tv16g5l/vQ2vczEFxA77DgkFiY361iehUU8av2mVZkSK2
         fqrQUwFYxnxc1u7W77JVB3NR+P2bpOdlY3d3ktnfZX4wvc3WdChIzOl/oMaRXhk85lY/
         rhzr6fICE8C72mbnJxX8NPoNvavGAc+VBkpxOV0NY4WtH6mbuBpGT4t8m+ALS8zxaVUc
         Sy60DSabrva+VO3UId5Z3Ytc+qc7qnO+1azVkh/ib8L7Y6tsOyRafcTJ6WinEuj03nex
         2Kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4JSNtBnOFBc3pGwCyNxt/wdF3MreeTClRovgXRSqJU=;
        b=PVeCuvu/EsbWNYJbl/LG9UAgSIjvIBPbAY6Hw3dR/qLemeczB6ZSZ7rwpzc1Ti8mYe
         1cFRsYnOQ/uzj3N+2FM9PgNpn05Msv6ItdWQOn0BTE1SFIF2s8hZueNDGaMPo1prKiRu
         SYBJqZFehW0y+xsltHj4skS99oOxPotrVRURcpLECcsMp95FgEMRP+39R6EBssU3+zJU
         lzhaE5QwziKN99158H4nczCCyd/bkhzI9x0VoP8T9FT/WPBm8QgFNn1ue2hHhfx7FzMi
         1eU5S2bwOGSaQdV9+w6Sd3ZP2I6keciyZJL46sYz7T+mlZYAMiG+P/rwP8DqGYZdO6ew
         uZZA==
X-Gm-Message-State: ACrzQf1KeNQJUg4b1uPcmLvu1iDPaC0ZamPI1ckzfI9oT6czpwCbqDJc
        r6ukZUduuXwAAFFAISm+v5U=
X-Google-Smtp-Source: AMsMyM7lZKjEuk7VTj8aM6WUJmeE4OQptOL+lpmAYJBZDpL0Mm2M7gc9Sp5OPtnTtLvRo3TSG5O/sA==
X-Received: by 2002:a17:903:2490:b0:17f:bf7e:c521 with SMTP id p16-20020a170903249000b0017fbf7ec521mr64440670plw.161.1668079631085;
        Thu, 10 Nov 2022 03:27:11 -0800 (PST)
Received: from VirtualBox.. ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902dacc00b001869f2120a4sm11061939plx.94.2022.11.10.03.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 03:27:10 -0800 (PST)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com, Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v1] block, bfq: do the all counting of pending-request if CONFIG_BFQ_GROUP_IOSCHED is enabled
Date:   Thu, 10 Nov 2022 19:26:22 +0800
Message-Id: <20221110112622.389332-1-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'bfqd->num_groups_with_pending_reqs' is used when
CONFIG_BFQ_GROUP_IOSCHED is enabled, so let the variables and processes
take effect when ONFIG_BFQ_GROUP_IOSCHED is enabled.

Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 block/bfq-iosched.c | 2 ++
 block/bfq-iosched.h | 4 ++++
 block/bfq-wf2q.c    | 8 ++++----
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 2381cf220ba2..5f54091e7fe9 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7051,7 +7051,9 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->idle_slice_timer.function = bfq_idle_slice_timer;
 
 	bfqd->queue_weights_tree = RB_ROOT_CACHED;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 	bfqd->num_groups_with_pending_reqs = 0;
+#endif
 
 	INIT_LIST_HEAD(&bfqd->active_list);
 	INIT_LIST_HEAD(&bfqd->idle_list);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 9fa89577322d..41aa151ccc22 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -197,8 +197,10 @@ struct bfq_entity {
 	/* flag, set to request a weight, ioprio or ioprio_class change  */
 	int prio_changed;
 
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 	/* flag, set if the entity is counted in groups_with_pending_reqs */
 	bool in_groups_with_pending_reqs;
+#endif
 
 	/* last child queue of entity created (for non-leaf entities) */
 	struct bfq_queue *last_bfqq_created;
@@ -491,6 +493,7 @@ struct bfq_data {
 	 */
 	struct rb_root_cached queue_weights_tree;
 
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 	/*
 	 * Number of groups with at least one process that
 	 * has at least one request waiting for completion. Note that
@@ -538,6 +541,7 @@ struct bfq_data {
 	 * with no request waiting for completion.
 	 */
 	unsigned int num_groups_with_pending_reqs;
+#endif
 
 	/*
 	 * Per-class (RT, BE, IDLE) number of bfq_queues containing
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index b02b53658ed4..ea4c3d757fdd 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1612,28 +1612,28 @@ void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
 {
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 	struct bfq_entity *entity = &bfqq->entity;
 
 	if (!entity->in_groups_with_pending_reqs) {
 		entity->in_groups_with_pending_reqs = true;
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
 		if (!(bfqq_group(bfqq)->num_queues_with_pending_reqs++))
 			bfqq->bfqd->num_groups_with_pending_reqs++;
-#endif
 	}
+#endif
 }
 
 void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
 {
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 	struct bfq_entity *entity = &bfqq->entity;
 
 	if (entity->in_groups_with_pending_reqs) {
 		entity->in_groups_with_pending_reqs = false;
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
 		if (!(--bfqq_group(bfqq)->num_queues_with_pending_reqs))
 			bfqq->bfqd->num_groups_with_pending_reqs--;
-#endif
 	}
+#endif
 }
 
 /*
-- 
2.34.1

