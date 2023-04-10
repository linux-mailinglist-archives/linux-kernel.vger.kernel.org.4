Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885E86DC650
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDJLhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDJLg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:36:58 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BAD44BE;
        Mon, 10 Apr 2023 04:36:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pw6Pw2lsMz4f4FSF;
        Mon, 10 Apr 2023 19:36:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbDT9DNk0tNvHA--.50875S4;
        Mon, 10 Apr 2023 19:36:53 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     logang@deltatee.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v5 0/6] md: fix uaf for sync_thread
Date:   Mon, 10 Apr 2023 19:35:53 +0800
Message-Id: <20230410113559.1610455-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbDT9DNk0tNvHA--.50875S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1DXF43tr4DAF4kXFykGrg_yoW8XFy3pF
        Wagr9xZw4UCrsxZFsxZFyjka45G3Wrtay7KryxC34rZa45uFWUJr4UGFWkWF9ruFyfJa9r
        Xr15Jr18uF1jyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

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

Yu Kuai (6):
  md: pass a md_thread pointer to md_register_thread()
  md: factor out a helper to wake up md_thread directly
  dm-raid: remove useless checking in raid_message()
  md/bitmap: always wake up md_thread in timeout_store
  md/bitmap: factor out a helper to set timeout
  md: protect md_thread with rcu

 drivers/md/dm-raid.c      |   4 +-
 drivers/md/md-bitmap.c    |  50 +++++++++++------
 drivers/md/md-cluster.c   |  11 ++--
 drivers/md/md-multipath.c |   6 +--
 drivers/md/md.c           | 110 ++++++++++++++++++++------------------
 drivers/md/md.h           |  15 +++---
 drivers/md/raid1.c        |   9 ++--
 drivers/md/raid1.h        |   2 +-
 drivers/md/raid10.c       |  25 ++++-----
 drivers/md/raid10.h       |   2 +-
 drivers/md/raid5-cache.c  |  20 +++----
 drivers/md/raid5.c        |  19 +++----
 drivers/md/raid5.h        |   2 +-
 13 files changed, 148 insertions(+), 127 deletions(-)

-- 
2.39.2

