Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BBD612213
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 12:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJ2KCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 06:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2KCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 06:02:38 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 250036918A;
        Sat, 29 Oct 2022 03:02:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.14.30.251])
        by mail-app3 (Coremail) with SMTP id cC_KCgCHjQwl+lxjdEpxCA--.43876S2;
        Sat, 29 Oct 2022 18:02:24 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, nickyc975@zju.edu.cn
Subject: [PATCH 0/3] cleanups for queue freezing functions
Date:   Sat, 29 Oct 2022 18:02:08 +0800
Message-Id: <cover.1667035519.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cC_KCgCHjQwl+lxjdEpxCA--.43876S2
X-Coremail-Antispam: 1UD129KBjvdXoWrWw43Wr4fKF1DWF1kZFyxXwb_yoWxGwc_ua
        4UAFyxtFykGFy3ZFyjkF1UAFyqkw4Utr1jqFWqqrWUAryxAFs8Aw4S9r4kWrs8WanrC3Z7
        Gr1UGr1xJr47XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6c
        xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij
        64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
        uYvjfUOlksUUUUU
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgwSB1ZdtcJ3NgAAsm
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches cleans up non-blk-mq functions in blk-mq.c to build
a consistent blk_mq_* namespace.

Jinlong Chen (3):
  blk-mq: remove redundant call to blk_freeze_queue_start in
    blk_mq_destroy_queue
  blk-mq: remove blk_freeze_queue
  block: hide back blk_freeze_queue_start and export its blk-mq alias

 block/blk-core.c              | 13 +++++++++
 block/blk-mq.c                | 52 ++++++++++++++---------------------
 block/blk-pm.c                |  2 +-
 block/blk.h                   |  2 +-
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c |  2 +-
 include/linux/blk-mq.h        |  2 +-
 7 files changed, 39 insertions(+), 36 deletions(-)

-- 
2.31.1

