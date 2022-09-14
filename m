Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF65B7E69
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiINBi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiINBiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:38:18 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFAB6C121;
        Tue, 13 Sep 2022 18:38:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MS2x422Tfz6S2p1;
        Wed, 14 Sep 2022 09:36:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgDHGXOGMCFj24dCAw--.23886S4;
        Wed, 14 Sep 2022 09:38:16 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, logang@deltatee.com, guoqing.jiang@linux.dev,
        pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v2 0/4] md/raid10: reduce lock contention for io
Date:   Wed, 14 Sep 2022 09:49:10 +0800
Message-Id: <20220914014914.398712-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHGXOGMCFj24dCAw--.23886S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW7ur1fZrW8WrWkuFyxuFg_yoW8AryDpa
        1fJF1SvFsFyr1IvrZIgr17Jry5Z3WrX398Cr97G34fZFW5ZFW8JF18JFWkWryDXF9aqa17
        J3WUKayrWFyUAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
        AvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Changes in v2:
 - add patch 1, as suggested by Logan Gunthorpe.
 - in patch 4, instead of use spin_lock/unlock in wait_event, which will
 confuse lockdep, use write_seqlock/unlock instead.
 - in patch 4, use read_seqbegin() to get seqcount instead of unusual
 usage of raw_read_seqcount().
 - test result is different from v1 in aarch64 due to retest from different
 environment.

Test environment:

Architecture:
aarch64 Huawei KUNPENG 920
x86 Intel(R) Xeon(R) Platinum 8380

Raid10 initialize:
mdadm --create /dev/md0 --level 10 --bitmap none --raid-devices 4 /dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1

Test cmd:
(task set -c 0-15) fio -name=0 -ioengine=libaio -direct=1 -group_reporting=1 -randseed=2022 -rwmixread=70 -refill_buffers -filename=/dev/md0 -numjobs=16 -runtime=60s -bs=4k -iodepth=256 -rw=randread

Test result:

aarch64:
before this patchset:		3.2 GiB/s
bind node before this patchset: 6.9 Gib/s
after this patchset:		7.9 Gib/s
bind node after this patchset:	8.0 Gib/s

x86:(bind node is not tested yet)
before this patchset: 7.0 GiB/s
after this patchset : 9.3 GiB/s

Please noted that in the test machine, memory access latency is very bad
across nodes compare to local node in aarch64, which is why bandwidth
while bind node is much better.

Yu Kuai (4):
  md/raid10: cleanup wait_barrier()
  md/raid10: prevent unnecessary calls to wake_up() in fast path
  md/raid10: fix improper BUG_ON() in raise_barrier()
  md/raid10: convert resync_lock to use seqlock

 drivers/md/raid10.c | 165 +++++++++++++++++++++++++++-----------------
 drivers/md/raid10.h |   2 +-
 2 files changed, 104 insertions(+), 63 deletions(-)

-- 
2.31.1

