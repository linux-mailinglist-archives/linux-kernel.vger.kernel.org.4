Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A71C734566
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 10:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjFRIJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 04:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFRIJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 04:09:03 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E595510D7;
        Sun, 18 Jun 2023 01:09:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QkQX83vb2z4f3nyX;
        Sun, 18 Jun 2023 16:08:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZSXu45kz8rjLw--.30784S4;
        Sun, 18 Jun 2023 16:08:58 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC 0/7] blk-mq: improve tag fair sharing
Date:   Mon, 19 Jun 2023 00:07:31 +0800
Message-Id: <20230618160738.54385-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZSXu45kz8rjLw--.30784S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tF48Xw13GryUuFW7uw48Zwb_yoW8Xry8pF
        43ta45Gr4xtrW2vFsxK3y7JFyYvrs3Gr1UGrn7t34Fyrn8Crs3Xr48Ja15AFyxt393AFW7
        Kr1UKr98GF1UJ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
        xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
        x2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi
        Pl1DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

This is not a formal version and not fully tested, I send this RFC
because I want to make sure if people think doing this is meaningful,
before I spend too much time on this.

This patchset tries to refactor how tag is shared:
 - patch 2 delay tag sharing from issue io to when get driver tag faild;
 - patch 3 support to access which queues/hctxs is sharing tags through
 blk_mq_tags;
 - patch 4 move the caculation that how many tags is available from
 hctx_may_queue() to when queue/hctx start or stop to sharing tags.
 - patch 5 record new information that how many times fail to get driver
 tag recently; And patch 7 use this to adjust available tags for each
 shared queue.

Yu Kuai (7):
  blk-mq: factor out a structure from blk_mq_tags to control tag sharing
  blk-mq: delay tag fair sharing until fail to get driver tag
  blk-mq: support to track active queues from blk_mq_tags
  blk-mq: precalculate available tags for hctx_may_queue()
  blk-mq: record the number of times fail to get driver tag while
    sharing tags
  blk-mq: move active request counter to struct tag_sharing
  blk-mq: allow shared queue to get more driver tags

 block/blk-core.c       |   2 -
 block/blk-mq-debugfs.c |   6 +-
 block/blk-mq-tag.c     | 154 ++++++++++++++++++++++++++++++++++++++---
 block/blk-mq.c         |  10 ++-
 block/blk-mq.h         |  39 ++++++-----
 include/linux/blk-mq.h |  24 ++++---
 include/linux/blkdev.h |  13 +++-
 7 files changed, 201 insertions(+), 47 deletions(-)

-- 
2.39.2

