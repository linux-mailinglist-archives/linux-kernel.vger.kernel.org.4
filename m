Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D157872A865
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjFJCYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjFJCY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:24:26 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9C73AB7;
        Fri,  9 Jun 2023 19:24:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QdMGD44m7z4f3k6H;
        Sat, 10 Jun 2023 10:24:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rHT3oNkRsFjLQ--.44376S4;
        Sat, 10 Jun 2023 10:24:21 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, dgilbert@interlog.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH v5 0/3] fix blktrace debugfs entries leakage
Date:   Sat, 10 Jun 2023 10:20:00 +0800
Message-Id: <20230610022003.2557284-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rHT3oNkRsFjLQ--.44376S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKw4kKr48Kw15KrWfXry8Grg_yoWfXrc_uw
        4DC3s7Gr17WF9YkF4SyF4rJFW09ay09r1UX3Wktry3Zw17Xry3Gayqgw4qq3WakFn8ua48
        Ary7A348Xw1aqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoO
        J5UUUUU
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

Changes in v5:
 - blk_trace_shutdown() can't be used for module, add a new patch to use
 inline function for blk_trace_remove() to fix build warning from v3.
 - add review tag for patch 2,3 that is the same from v3.

Changes in v4:
 - blk_trace_remove() will trigger build warning if blktrace config is
 not enabled, use blk_trace_shutdown() instead.

Changes in v3:
 - add a new patch to handle /dev/sg

Changes in v2:
 - cleanup bltkrace in disk_release() instead of blk_free_queue()

Yu Kuai (3):
  blktrace: use inline function for blk_trace_remove() while blktrace is
    disabled
  scsi: sg: fix blktrace debugfs entries leakage
  block: fix blktrace debugfs entries leakage

 block/genhd.c                | 5 ++++-
 drivers/scsi/sg.c            | 9 +++++++++
 include/linux/blktrace_api.h | 6 +++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.39.2

