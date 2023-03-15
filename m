Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E2B6BA7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCOGTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCOGTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:19:00 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA4E26582;
        Tue, 14 Mar 2023 23:18:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pc0b16Gwfz4f4XQf;
        Wed, 15 Mar 2023 14:18:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyFNYxFklvvMEw--.20241S4;
        Wed, 15 Mar 2023 14:18:55 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 0/5] md: fix uaf for sync_thread
Date:   Wed, 15 Mar 2023 14:18:05 +0800
Message-Id: <20230315061810.653263-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyFNYxFklvvMEw--.20241S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1UKr13Cr45CrW8Kr48Zwb_yoW8AFW3pF
        yfJry3Zr48ArsxZrnrXFyjka45Jw1Igay7KryxCw4fu3W5XrWYqr4YyFWkZF9rZFyfJFsr
        Xr15JF1kuF4DKaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Changes in v2:
 - fix a compile error for for md-cluster in patch 2
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

This patchset do some refactor, and then use a disk level spinlock to
protect md_thread in relevant apis.

I tested this pathset with mdadm tests, and there are no new regression,
by the way, following test will failed with or without this patchset:

01raid6integ
04r1update
05r6tor0
10ddf-create
10ddf-fail-spare
10ddf-fail-stop-readd
10ddf-geometry

Yu Kuai (5):
  md: pass a md_thread pointer to md_register_thread()
  md: refactor md_wakeup_thread()
  md: use md_thread api to wake up sync_thread
  md: pass a mddev to md_unregister_thread()
  md: protect md_thread with a new disk level spin lock

 drivers/md/dm-raid.c      |   6 +-
 drivers/md/md-bitmap.c    |   6 +-
 drivers/md/md-cluster.c   |  39 +++++----
 drivers/md/md-multipath.c |   8 +-
 drivers/md/md.c           | 162 ++++++++++++++++++++------------------
 drivers/md/md.h           |  15 ++--
 drivers/md/raid1.c        |  19 +++--
 drivers/md/raid10.c       |  31 ++++----
 drivers/md/raid5-cache.c  |  19 +++--
 drivers/md/raid5-ppl.c    |   2 +-
 drivers/md/raid5.c        |  48 ++++++-----
 11 files changed, 177 insertions(+), 178 deletions(-)

-- 
2.31.1

