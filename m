Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5463174079F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 03:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjF1Bac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 21:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjF1Ba0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:30:26 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A812973;
        Tue, 27 Jun 2023 18:30:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QrPCf1l10z4f3vfg;
        Wed, 28 Jun 2023 09:30:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLMtjZtksx7IMg--.35564S5;
        Wed, 28 Jun 2023 09:30:22 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     xni@redhat.com, song@kernel.org, colyli@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 1/2] md: don't quiesce in mddev_suspend()
Date:   Wed, 28 Jun 2023 09:29:30 +0800
Message-Id: <20230628012931.88911-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230628012931.88911-1-yukuai1@huaweicloud.com>
References: <20230628012931.88911-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLMtjZtksx7IMg--.35564S5
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW7ZFyftFyUJw1xtrWkWFg_yoW8Gr15p3
        97tF98JryUJF90yw4UA3Z8Wa45X3WqgrWvyFy3u3yYv3ZFgr95Gr1fua9rXr9rCasayrsx
        Aw4UJr48Ar109rDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHyIUUUUUU=
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

Some levels doesn't implement "pers->quiesce", for example
raid0_quiesce() is empty, and now that all levels will drop 'active_io'
until io is done, wait for 'active_io' to be 0 is enough to make sure all
normal io is done, and percpu_ref_kill() for 'active_io' will make sure
no new normal io can be dispatched. There is no need to call
"pers->quiesce" anymore from mddev_suspend().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index abb616720393..962dacfd98cf 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -453,7 +453,6 @@ void mddev_suspend(struct mddev *mddev)
 		mddev->pers->prepare_suspend(mddev);
 
 	wait_event(mddev->sb_wait, percpu_ref_is_zero(&mddev->active_io));
-	mddev->pers->quiesce(mddev, 1);
 	clear_bit_unlock(MD_ALLOW_SB_UPDATE, &mddev->flags);
 	wait_event(mddev->sb_wait, !test_bit(MD_UPDATING_SB, &mddev->flags));
 
@@ -472,7 +471,6 @@ void mddev_resume(struct mddev *mddev)
 		return;
 	percpu_ref_resurrect(&mddev->active_io);
 	wake_up(&mddev->sb_wait);
-	mddev->pers->quiesce(mddev, 0);
 
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	md_wakeup_thread(mddev->thread);
-- 
2.39.2

