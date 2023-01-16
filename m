Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5272966B557
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 02:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjAPBxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 20:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjAPBx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:53:29 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3217D44B4;
        Sun, 15 Jan 2023 17:53:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NwFRN4hyZz4f3nTH;
        Mon, 16 Jan 2023 09:53:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD3rbERrsRj9iw3Bw--.37368S2;
        Mon, 16 Jan 2023 09:53:23 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     jack@suse.com, damien.lemoal@opensource.wdc.com,
        paolo.valente@linaro.org, axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] A few bugfix and cleancode patch for bfq
Date:   Mon, 16 Jan 2023 17:51:45 +0800
Message-Id: <20230116095153.3810101-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rbERrsRj9iw3Bw--.37368S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1fXF45GFyfGFWkXF4Dtwb_yoW8WF17pr
        4fur4a9F4rJry3XFy3A3W8Zrn3t34ftasrXw1ag3s5XryDZwnFqFyqk3yFkFyftF93CFs3
        Xa40q3s5Wr1rAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
        tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
        0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
        80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0VnQUUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this series contain two patches to fix bug in request injection
mechanism and some random cleancode patches.
Thanks!

---
V4:
 -Thanks Jan and Damien for review. Collect Reviewed-by from Jan and
Damien. Now all patches get Reviewed-by tag.
 -Make patches based on latest code and fix conflicts of patch 1/8
"block, bfq: correctly raise inject limit in bfq_choose_bfqq_for_injection"
and 5/8 "block, bfq: remove unnecessary dereference to get async_bfqq"

---
V3:
 -Thanks Jan for review. Remove unnecessary brace in patch "block, bfq:
remove unnecessary goto tag in bfq_dispatch_rq_from_bfqq" according to
recommend from Jan and collect Reviewed-by tag from Jan for rest
patches.
 -Drop patch "block, bfq: remove redundant bfqd->rq_in_driver > 0 check
in bfq_add_request" and "block, bfq: remove check of
bfq_wr_max_softrt_rate which is always greater than 0".

---
v2:
 -improve git log.
---

Kemeng Shi (8):
  block, bfq: correctly raise inject limit in
    bfq_choose_bfqq_for_injection
  block, bfq: remove unsed parameter reason in bfq_bfqq_is_slow
  block, bfq: initialize bfqq->decrease_time_jif correctly
  block, bfq: use helper macro RQ_BFQQ to get bfqq of request
  block, bfq: remove unnecessary dereference to get async_bfqq
  block, bfq: remove redundant check in bfq_put_cooperator
  block, bfq: remove unnecessary goto tag in bfq_dispatch_rq_from_bfqq
  block, bfq: remove unused bfq_wr_max_time in struct bfq_data

 block/bfq-iosched.c | 40 +++++++++++++++-------------------------
 block/bfq-iosched.h |  2 --
 2 files changed, 15 insertions(+), 27 deletions(-)

-- 
2.30.0

