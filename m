Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ECA6EF01F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbjDZIW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239964AbjDZIWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:22:25 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92CD198C;
        Wed, 26 Apr 2023 01:22:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q5sL31NZnz4f4MCX;
        Wed, 26 Apr 2023 16:22:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP2 (Coremail) with SMTP id Syh0CgBnW+k430hkUexVIA--.50201S4;
        Wed, 26 Apr 2023 16:22:18 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, akpm@osdl.org, neilb@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 0/7] limit the number of plugged bio
Date:   Wed, 26 Apr 2023 16:20:24 +0800
Message-Id: <20230426082031.1299149-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBnW+k430hkUexVIA--.50201S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF15GFy7ZFWfArWrZw17Awb_yoW8XFWUp3
        y3G34agwn7A347A3Z3Zr48XFy5Jw48Jry2qrn3tr4rCFy5ZFWUZF1xGayrGr9rAry3Ja42
        gr45JryUGF1UtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Changes in v2:
 - remove the patch to rename raid1-10.c

This patchset tries to limit the number of plugged bio for raid1 and
raid10, which is done in the last patch, other patches are some refactor
and optimizations.

This patchset is tested with a new test [1], this test triggers dirty
pages writeback for 10s, and in the meantime checks disk inflight.

Before this patchset, test will fail because inflight exceed threshold
(threshold is set to 4096 in the test, in theory this can be mutch
 greater as long as there are enough dirty pages and memory).

After this patchset, inflight is within 96 (MAX_PLUG_BIO * copies).

[1] https://lore.kernel.org/linux-raid/20230426073447.1294916-1-yukuai1@huaweicloud.com/

Yu Kuai (7):
  md/raid10: prevent soft lockup while flush writes
  md/raid1-10: factor out a helper to add bio to plug
  md/raid1-10: factor out a helper to submit normal write
  md/raid1-10: submit write io directly if bitmap is not enabled
  md/md-bitmap: add a new helper to unplug bitmap asynchrously
  md/raid1-10: don't handle pluged bio by daemon thread
  md/raid1-10: limit the number of plugged bio

 drivers/md/md-bitmap.c | 55 +++++++++++++++++++++++++++++++++----
 drivers/md/md-bitmap.h | 10 +++++++
 drivers/md/raid1-10.c  | 62 ++++++++++++++++++++++++++++++++++++++++++
 drivers/md/raid1.c     | 29 ++++----------------
 drivers/md/raid10.c    | 47 +++++++-------------------------
 5 files changed, 136 insertions(+), 67 deletions(-)

-- 
2.39.2

