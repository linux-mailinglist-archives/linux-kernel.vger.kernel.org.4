Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693BB665312
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjAKFDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjAKFDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:03:34 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211E7CE3A;
        Tue, 10 Jan 2023 21:03:32 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NsFv152Q5z4f3p0f;
        Wed, 11 Jan 2023 13:03:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDX9S8fQ75jGl2gBQ--.10280S2;
        Wed, 11 Jan 2023 13:03:28 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com, jack@suse.cz
Subject: [PATCH v3 00/14] A few bugfix and cleanup patches for blk-mq
Date:   Wed, 11 Jan 2023 21:01:45 +0800
Message-Id: <20230111130159.3741753-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX9S8fQ75jGl2gBQ--.10280S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1xXF4kAFW8Jw4xAry7Jrb_yoW8uryrpF
        W3Ka13Gw4fXr17Xw1Syw47ZF9ayws7GrW7Xw13G3s5Xr4DCr18Gr4Iqa1fAFy0yFZ5Ca17
        JF4Fv345KF1v937anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E
        3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
        0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z2
        80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j7NVkUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this series contain several bugfix patches to fix potential io
hung and a few cleanup patches to remove stale codes and unnecessary
check. Most changes are in request issue and dispatch path. Thanks.

---
V3:
 -Collect Reviewed-by from Christoph
 -Add new patch "blk-mq: make blk_mq_commit_rqs a general function for all
commits" suggested-by Christoph
 -Move patch "blk-mq: remove unncessary from_schedule parameter in
blk_mq_plug_issue_direct" forwad. This is because of some abandoned
work, no influence anyway. No special attention should be paied.
 -Make patch based on rewriten blk_mq_commit_rqs.

V2:
 -Thanks Christoph for review and there are two fixes in v2 according
to recommends from Christoph.
  1)Avoid overly long line in patch "blk-mq: avoid sleep in
blk_mq_alloc_request_hctx"
  2)Check BLK_MQ_REQ_NOWAIT and BLK_MQ_REQ_RESERVED in two WARN_ON_ONCE
---

Kemeng Shi (14):
  blk-mq: avoid sleep in blk_mq_alloc_request_hctx
  blk-mq: remove stale comment for blk_mq_sched_mark_restart_hctx
  blk-mq: wait on correct sbitmap_queue in blk_mq_mark_tag_wait
  blk-mq: Fix potential io hung for shared sbitmap per tagset
  blk-mq: remove unnecessary list_empty check in
    blk_mq_try_issue_list_directly
  blk-mq: remove unncessary from_schedule parameter in
    blk_mq_plug_issue_direct
  blk-mq: make blk_mq_commit_rqs a general function for all commits
  blk-mq: remove unncessary error count and commit in
    blk_mq_plug_issue_direct
  blk-mq: use blk_mq_commit_rqs helper in blk_mq_try_issue_list_directly
  blk-mq: simplify flush check in blk_mq_dispatch_rq_list
  blk-mq: remove unnecessary error count and check in
    blk_mq_dispatch_rq_list
  blk-mq: remove set of bd->last when get driver tag for next request
    fails
  blk-mq: use switch/case to improve readability in
    blk_mq_try_issue_list_directly
  blk-mq: correct stale comment of .get_budget

 block/blk-mq-sched.c |   7 +--
 block/blk-mq.c       | 147 ++++++++++++++++++++-----------------------
 2 files changed, 71 insertions(+), 83 deletions(-)

-- 
2.30.0

