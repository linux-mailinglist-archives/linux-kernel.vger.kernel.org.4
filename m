Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C6E66BE51
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjAPMzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjAPMy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:54:57 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5285D1EFE7;
        Mon, 16 Jan 2023 04:52:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NwX3v0y71z4f419B;
        Mon, 16 Jan 2023 20:52:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgBH7uuMSMVjYH02Bw--.361S2;
        Mon, 16 Jan 2023 20:52:29 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     jack@suse.cz, axboe@kernel.dk
Cc:     kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, shikemeng@huaweicloud.com
Subject: [PATCH v3 0/5] A few bugfix and cleanup patches for sbitmap
Date:   Tue, 17 Jan 2023 04:50:54 +0800
Message-Id: <20230116205059.3821738-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH7uuMSMVjYH02Bw--.361S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw15Zr18uw43Jw1DCF1UGFg_yoW8Jw4fpr
        1fKF1fGwn3KFy7Xr17A343JFySyw4kKrnxJw1IkF1ruF1UAF9IkrWkKFWfA34UJFy3tFW7
        JF1rXr18Kr1UZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0p
        RVc_3UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this series contain a bugfix patch to correct wake_batch
recalculation to avoid potential IO hung and a few cleanup patches to
remove unnecessary check and repeat code in sbitmap. Thanks.

---
v3:
 -Thank Jan for review. Collect Reviewed-by from Jan for all patches.
 -some cleanups according to recommends from Jan:
   1)Add Fixes tag in patch 2/5 "sbitmap: remove redundant check in
__sbitmap_queue_get_batch"
   2)Avoid lines over 80 characters in patch 3/5 "sbitmap: rewrite
sbitmap_find_bit_in_index to reduce repeat code"
   3)Remove pointless line in patch 4/5 "sbitmap: add sbitmap_find_bit
to remove repeat code in __sbitmap_get/__sbitmap_get_shallow"

---
v2:
 -add patch "sbitmap: correct wake_batch recalculation to avoid potential
IO hung"
---

Kemeng Shi (5):
  sbitmap: remove unnecessary calculation of alloc_hint in
    __sbitmap_get_shallow
  sbitmap: remove redundant check in __sbitmap_queue_get_batch
  sbitmap: rewrite sbitmap_find_bit_in_index to reduce repeat code
  sbitmap: add sbitmap_find_bit to remove repeat code in
    __sbitmap_get/__sbitmap_get_shallow
  sbitmap: correct wake_batch recalculation to avoid potential IO hung

 lib/sbitmap.c | 102 ++++++++++++++++++++++----------------------------
 1 file changed, 45 insertions(+), 57 deletions(-)

-- 
2.30.0

