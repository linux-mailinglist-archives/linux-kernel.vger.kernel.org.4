Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7F46D0486
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjC3MVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjC3MV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:21:28 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AACF7A8B;
        Thu, 30 Mar 2023 05:21:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PnMwL4mShz4f3kpq;
        Thu, 30 Mar 2023 20:21:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLC5fiVkFoZ2GQ--.46838S4;
        Thu, 30 Mar 2023 20:21:24 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     logang@deltatee.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v3 0/3] md: fix uaf for sync_thread
Date:   Fri, 31 Mar 2023 04:20:43 +0800
Message-Id: <20230330202046.795213-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLC5fiVkFoZ2GQ--.46838S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw15CrW7XF4xuFWDJr18Krg_yoW8Gw4xpa
        4fJry3Zw40yr43ZrnrX3Wjka45Gw1Sgay7Kry7Gw4fWa45urW5Xr4jyFWkXF9rZFyfJFsr
        Jr15JF1ruF1DtaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7sRi
        Pl1DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.4 required=5.0 tests=DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Changes in v3:
 - remove patch 3 from v2
 - use rcu instead of a new lock

Changes in v2:
 - fix a compile error for md-cluster in patch 2
 - replace spin_lock/unlock with spin_lock/unlock_irq in patch 5
 - don't wake up inside the new lock in md wakeup_thread in patch 5

Our test reports a uaf for 'mddev->sync_thread':

T1                      T2
md_start_sync
 md_register_thread
			raid1d
			 md_check_recovery
			  md_reap_sync_thread
			   md_unregister_thread
			    kfree

 md_wakeup_thread
  wake_up
  ->sync_thread was freed

Currently, a global spinlock 'pers_lock' is borrowed to protect
'mddev->thread', this problem can be fixed likewise, however, there might
be similar problem for other md_thread, and I really don't like the idea to
borrow a global lock.

This patchset do some refactor and use rcu to protect md_thread.

Yu Kuai (3):
  md: pass a md_thread pointer to md_register_thread()
  md: refactor md_wakeup_thread()
  md: protect md_thread with rcu

 drivers/md/dm-raid.c      |   4 +-
 drivers/md/md-bitmap.c    |   6 +-
 drivers/md/md-cluster.c   |  31 +++++----
 drivers/md/md-multipath.c |   8 +--
 drivers/md/md.c           | 129 ++++++++++++++++++--------------------
 drivers/md/md.h           |  11 ++--
 drivers/md/raid1.c        |  15 +++--
 drivers/md/raid10.c       |  29 ++++-----
 drivers/md/raid5-cache.c  |  17 +++--
 drivers/md/raid5-ppl.c    |   2 +-
 drivers/md/raid5.c        |  45 +++++++------
 11 files changed, 139 insertions(+), 158 deletions(-)

-- 
2.39.2

