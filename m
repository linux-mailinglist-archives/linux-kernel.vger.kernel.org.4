Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACE469BE2F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 03:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBSCla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 21:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBSCl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 21:41:28 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E7611EA6;
        Sat, 18 Feb 2023 18:41:26 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PK8v40QfRz4f3jHn;
        Sun, 19 Feb 2023 10:41:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgBH7utQjPFjPmleDw--.7604S2;
        Sun, 19 Feb 2023 10:41:22 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, jack@suse.cz
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH 00/17] Some bugfix and cleanup patches for bfq
Date:   Sun, 19 Feb 2023 18:42:52 +0800
Message-Id: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH7utQjPFjPmleDw--.7604S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1xJF43JryDtF1xZw1xuFg_yoW8Wr4Dpr
        ySgr1S9r17GrW7XF1ftF4UXFnIq348JF4DJw4agry0qryUAw17ZF1qyr1rGFyIqF92krn2
        qFyDW398W3WDCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
        xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
        x2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjTRCA
        pnUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this series contain some patches to improve in-service queue
preemption, protect max_budget updating race between configuration
and auto-tuning and so on. More details can be found in respective
log message. Thanks!

Kemeng Shi (17):
  block, bfq: properly mark bfqq remained idle
  block, bfq: try preemption if bfqq has higher weight and the same
    priority class
  block, bfq: only preempt plugged in_service_queue if
    bfq_better_to_idle say no
  block, bfq: recover the "service hole" if enough budget is left
  block, bfq: Update bfqd->max_budget with bfqd->lock held
  block, bfq: correct bfq_max_budget and bfq_min_budget
  block, bfq: correct interactive weight-raise check in
    bfq_set_budget_timeout
  block, bfq: start service_from_wr accumulating of async queues
    correctly
  block, bfq: stop to detect queue as waker queue if it already is now
  block, bfq: fix typo in comment
  block, bfq: simpfy computation of bfqd->budgets_assigned
  block, bfq: define and use soft_rt, in_burst and wr_or_deserves_wr
    only low_latency is enable
  block, bfq: remove unnecessary "wr" part of wr_or_deserves_wr
  block, bfq: remove redundant oom_bfqq check for bfqq from
    bfq_find_close_cooperator
  block, bfq: some cleanups for function bfq_pos_tree_add_move
  block, bfq: remove unnecessary goto tag in __bfq_weights_tree_remove
  block, bfq: remove unnecessary local variable __bfqq in
    bfq_setup_merge

 block/bfq-iosched.c | 176 +++++++++++++++++++++++---------------------
 block/bfq-wf2q.c    |   2 +-
 2 files changed, 95 insertions(+), 83 deletions(-)

-- 
2.30.0

