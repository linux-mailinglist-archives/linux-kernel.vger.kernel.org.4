Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C9D737E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjFUIxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjFUIwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:52:44 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F164D1B4;
        Wed, 21 Jun 2023 01:52:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QmHMC5gdhz4f43l6;
        Wed, 21 Jun 2023 16:52:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLBWupJkbVnFMA--.53622S4;
        Wed, 21 Jun 2023 16:52:40 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 0/8] md: fix and refactor io accounting and 'active_io'
Date:   Thu, 22 Jun 2023 00:51:02 +0800
Message-Id: <20230621165110.1498313-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLBWupJkbVnFMA--.53622S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KryfGF45Kr18uryfCw4DJwb_yoW8Xr17pF
        WfJ3y3Zw4rJrW3GrZxX3y8AryrJan5GrWDKr1aq3yrZa45ZFy5Jw48JFW8CF97GFyfJF17
        XryUWF1kWF18G3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        TRNgAwUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Changes in v2:
 - fix some typos;
 - add review tag;

This patchset do following things:
 - make io accounting for all raid levels consistent, patch 1, 3-5;
 - enable io accounting for all raid levels, patch 6-8;
 - hold 'active_io' before io start to dispatch, and release 'active_io'
 when io is done, make mddev_suspend() will wait for io to be done, patch 2

This patch set also prepare to synchronize io and raid configuration, make
it possible to use 'active_io' in common layer to judge if normal io is
in flight.

Yu Kuai (8):
  md: move initialization and destruction of 'io_acct_set' to md.c
  md: also clone new io if io accounting is disabled
  raid5: fix missing io accounting in raid5_align_endio()
  md/raid1: switch to use md_account_bio() for io accounting
  md/raid10: switch to use md_account_bio() for io accounting
  md/md-multipath: enable io accounting
  md/md-linear: enable io accounting
  md/md-faulty: enable io accounting

 drivers/md/md-faulty.c    |  2 +
 drivers/md/md-linear.c    |  1 +
 drivers/md/md-multipath.c |  1 +
 drivers/md/md.c           | 78 +++++++++++++++++++--------------------
 drivers/md/md.h           |  6 +--
 drivers/md/raid0.c        | 16 +-------
 drivers/md/raid1.c        | 14 +++----
 drivers/md/raid1.h        |  1 -
 drivers/md/raid10.c       | 20 +++++-----
 drivers/md/raid10.h       |  1 -
 drivers/md/raid5.c        | 70 ++++++++++-------------------------
 11 files changed, 79 insertions(+), 131 deletions(-)

-- 
2.39.2

