Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565B274ADE0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjGGJjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjGGJjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:39:02 -0400
Received: from out-3.mta0.migadu.com (out-3.mta0.migadu.com [91.218.175.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD40B2105
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 02:39:01 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688722740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H8lodFl56b2KExC0gt827b28JNOFi4rlCN2zLgYnfQM=;
        b=LChLQBDKrnKjm1wTuC5RsNjieLetgMS+bReOjGftTGZVrxI3/fBDORG0ipWCNknYLe8Vqp
        IXwX7MzO51p62ijVzcl4oMlw2g2QPZAUz/MtYU+xnlaIdA8JFNl75LYjjMBVfo1zRnaev8
        yulxGymtWYRWQ973u3VprI6V3cr3psg=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v3 0/4] blk-mq: optimize the size of struct request
Date:   Fri,  7 Jul 2023 17:37:18 +0800
Message-ID: <20230707093722.1338589-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

v3:
 - Collect Reviewed-by tags from Ming and Christoph. Thanks!
 - Remove the list and csd variables which are only used once.
 - Fix a bug report of blktests nvme/012 by re-initialization of
   rq->queuelist, which maybe corrupted by rq->rq_next reuse.
 - [v2] https://lore.kernel.org/all/20230629110359.1111832-1-chengming.zhou@linux.dev/

v2:
 - Change to use call_single_data_t, which use __aligned() to avoid
   to use 2 cache lines for 1 csd. Thanks Ming Lei.
 - [v1] https://lore.kernel.org/all/20230627120854.971475-1-chengming.zhou@linux.dev/

Hello,

After the commit be4c427809b0 ("blk-mq: use the I/O scheduler for
writes from the flush state machine"), rq->flush can't reuse rq->elv
anymore, since flush_data requests can go into io scheduler now.

That increased the size of struct request by 24 bytes, but this
patchset can decrease the size by 40 bytes, which is good I think.

patch 1 is just cleanup by the way.

patch 2 use percpu csd to do remote complete instead of per-rq csd,
decrease the size by 24 bytes.

patch 3-4 reuse rq->queuelist in flush state machine pending list,
and maintain unsigned long counter of inflight flush_data requests,
decrease the size by 16 bytes.

Thanks for comments!

Chengming Zhou (4):
  blk-mq: delete unused completion_data in struct request
  blk-mq: use percpu csd to remote complete instead of per-rq csd
  blk-flush: count inflight flush_data requests
  blk-flush: reuse rq queuelist in flush state machine

 block/blk-flush.c      | 24 ++++++++++++++----------
 block/blk-mq.c         | 12 ++++++------
 block/blk.h            |  5 ++---
 include/linux/blk-mq.h | 10 ++--------
 4 files changed, 24 insertions(+), 27 deletions(-)

-- 
2.41.0

