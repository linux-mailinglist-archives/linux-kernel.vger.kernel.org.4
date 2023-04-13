Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F736E0C89
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDMLd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjDMLd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:33:27 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BED113;
        Thu, 13 Apr 2023 04:33:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PxyBS2JZNz4f3wgy;
        Thu, 13 Apr 2023 19:33:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCH77KA6DdkC6FCHQ--.33135S4;
        Thu, 13 Apr 2023 19:33:22 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     dm-devel@redhat.com, song@kernel.org, logang@deltatee.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v6 0/5] md: protect md_thread with rcu
Date:   Thu, 13 Apr 2023 19:32:12 +0800
Message-Id: <20230413113217.1934353-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77KA6DdkC6FCHQ--.33135S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4rXrW3GF15GFWfGr48JFb_yoW8WF4kpF
        ZIgF9xZw4UCr43ZFsxZa42ka45G3WrGayUKryxA34ruFy5ur98Jr1UJFy8WF9rWFyfJa9F
        qF15Jr1DCF1UtaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Changes in v6:
 - remove first patch from v5, and use rcu_asign_pointer() directly from
 caller.
 - always use rcu_read_lock/unlock to protect mddev_set_timeout().

Changes in v5:
 - use rcu_dereference_protected() instead of rcu_access_pointer() where
 rcu_read_lock/unlock is not required.
 - add patch 4,5 to handle that bitmap timeout is set multiple times.

Changes in v4:
 - remove patch 2 from v3
 - fix sparse errors and warnings from v3, in order to do that, all access
 to md_thread need to be modified, patch 2-4 is splited to avoid a huge
 patch.

Changes in v3:
 - remove patch 3 from v2
 - use rcu instead of a new lock

Changes in v2:
 - fix a compile error for md-cluster in patch 2
 - replace spin_lock/unlock with spin_lock/unlock_irq in patch 5
 - don't wake up inside the new lock in md wakeup_thread in patch 5

Yu Kuai (5):
  md: factor out a helper to wake up md_thread directly
  dm-raid: remove useless checking in raid_message()
  md/bitmap: always wake up md_thread in timeout_store
  md/bitmap: factor out a helper to set timeout
  md: protect md_thread with rcu

 drivers/md/dm-raid.c      |  4 +-
 drivers/md/md-bitmap.c    | 43 +++++++++++--------
 drivers/md/md-cluster.c   |  7 ++--
 drivers/md/md-multipath.c |  4 +-
 drivers/md/md.c           | 88 +++++++++++++++++++++------------------
 drivers/md/md.h           |  8 ++--
 drivers/md/raid1.c        |  7 ++--
 drivers/md/raid1.h        |  2 +-
 drivers/md/raid10.c       | 21 ++++++----
 drivers/md/raid10.h       |  2 +-
 drivers/md/raid5-cache.c  | 22 ++++++----
 drivers/md/raid5.c        | 15 +++----
 drivers/md/raid5.h        |  2 +-
 13 files changed, 126 insertions(+), 99 deletions(-)

-- 
2.39.2

