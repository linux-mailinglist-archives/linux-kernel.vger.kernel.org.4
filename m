Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077FA745137
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjGBTpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjGBTnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:43:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CE830C1;
        Sun,  2 Jul 2023 12:42:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFA1D60C7A;
        Sun,  2 Jul 2023 19:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93045C433C9;
        Sun,  2 Jul 2023 19:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326868;
        bh=FjJ6FW31syxeWUyhKx4k1aiKMPw5gGnc4GzHlWTbudM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cz7eK3G98lQ10lUgl3bGCavAZYP8/xosmbm6sKJCp5ZmMmYdDm6rLc6GHvHnPjbUQ
         /1IyWtV1sIMqHx4qt1k2g8DAIub/sT420WLC5ZFbTIimmjqVivdI5h3vcQC1Gr/XyS
         WsiU8djVxvzDyB7T3h3M5bBmTvoyk6Toj2t+RIG92lW0h+JxyqsBGR7t7VayuYK6vs
         Sy3q1p4OSVzv3vGctZQB9LPmohJz0/VLIz9lWFyjsSWc8LO9SZrekMMDjRtEciAO86
         9wb0t3ook7O0XzVETqru+DXQXrymI5x0xlL6G0x5Ktan5fQtRwm2N7Vso0yP+nY9nD
         tv+dVYG6fv3nw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 09/14] blk-mq: fix NULL dereference on q->elevator in blk_mq_elv_switch_none
Date:   Sun,  2 Jul 2023 15:40:48 -0400
Message-Id: <20230702194053.1777356-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194053.1777356-1-sashal@kernel.org>
References: <20230702194053.1777356-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.11
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 245165658e1c9f95c0fecfe02b9b1ebd30a1198a ]

After grabbing q->sysfs_lock, q->elevator may become NULL because of
elevator switch.

Fix the NULL dereference on q->elevator by checking it with lock.

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20230616132354.415109-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f2e2ffd135baf..e5f885ff018b0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4633,9 +4633,6 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 {
 	struct blk_mq_qe_pair *qe;
 
-	if (!q->elevator)
-		return true;
-
 	qe = kmalloc(sizeof(*qe), GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
 	if (!qe)
 		return false;
@@ -4643,6 +4640,12 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	/* q->elevator needs protection from ->sysfs_lock */
 	mutex_lock(&q->sysfs_lock);
 
+	/* the check has to be done with holding sysfs_lock */
+	if (!q->elevator) {
+		kfree(qe);
+		goto unlock;
+	}
+
 	INIT_LIST_HEAD(&qe->node);
 	qe->q = q;
 	qe->type = q->elevator->type;
@@ -4650,6 +4653,7 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	__elevator_get(qe->type);
 	list_add(&qe->node, head);
 	elevator_disable(q);
+unlock:
 	mutex_unlock(&q->sysfs_lock);
 
 	return true;
-- 
2.39.2

