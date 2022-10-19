Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C986045CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiJSMtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiJSMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:49:00 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E088140FC;
        Wed, 19 Oct 2022 05:31:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mspvx4m1WzKHg0;
        Wed, 19 Oct 2022 19:50:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgCX0DAq5U9jgItmAA--.58124S4;
        Wed, 19 Oct 2022 19:53:16 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, ebiggers@google.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v5 0/6] blk-wbt: simple improvment to enable wbt correctly
Date:   Wed, 19 Oct 2022 20:15:12 +0800
Message-Id: <20221019121518.3865235-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX0DAq5U9jgItmAA--.58124S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw15Kw15tFyUuw4DJw4UXFb_yoWDurgEqa
        yUK3s5WFn8XF1rCFZxJF1UJFWj9rs5Zr15Xa47tr9YyryfJF4jyw4ktr4Uu3s8ZF4Ik3Z0
        y3yUurWrur1IqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

changes in v5:
 - code adjustment in patch 4, as suggested by Christoph.
 - add review tag by Christop.

changes in v4:
 - remove patch 3 from v3
 - add patch 2,3 in v4

changes in v3:
 - instead of check elevator name, add a flag in elevator_queue, as
 suggested by Christoph.
 - add patch 3 and patch 5 to this patchset.

changes in v2:
 - define new api if wbt config is not enabled in patch 1.

Yu Kuai (6):
  elevator: remove redundant code in elv_unregister_queue()
  blk-wbt: remove unnecessary check in wbt_enable_default()
  blk-wbt: make enable_state more accurate
  blk-wbt: don't show valid wbt_lat_usec in sysfs while wbt is disabled
  elevator: add new field flags in struct elevator_queue
  blk-wbt: don't enable throttling if default elevator is bfq

 block/bfq-iosched.c |  2 ++
 block/blk-sysfs.c   |  3 +++
 block/blk-wbt.c     | 26 ++++++++++++++++++++++----
 block/blk-wbt.h     | 17 ++++++++++++-----
 block/elevator.c    |  8 ++------
 block/elevator.h    |  5 ++++-
 6 files changed, 45 insertions(+), 16 deletions(-)

-- 
2.31.1

