Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737F26AC0B2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCFNVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCFNVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:21:42 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA162E0E8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:21:17 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PVfNR0TQZz4f3knk
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 21:21:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLDH6AVkOFVrEw--.46662S4;
        Mon, 06 Mar 2023 21:21:13 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     dm-devel@redhat.com
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Ignat Korchagin <ignat@cloudflare.com>,
        linux-kernel@vger.kernel.org, houtao1@huawei.com
Subject: [PATCH] dm crypt: initialize tasklet in crypt_io_init()
Date:   Mon,  6 Mar 2023 21:49:30 +0800
Message-Id: <20230306134930.2878660-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLDH6AVkOFVrEw--.46662S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tw45ZrW7Zry8Zr4kJrWDurg_yoW8Aw1fpF
        W3G3yFyrWrJF47K34Ut3W8CryY9rn7KrW3Cr43C34j9F129F9YgFy2v3y0vF45AFZ5X3W3
        ZFWkta45CF1DArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

When neither no_read_workqueue nor no_write_workqueue are enabled,
tasklet_trylock() in crypt_dec_pending() may still return false due to
an uninitialized state, and dm-crypt will do io completion in io_queue
instead of current context unnecessarily.

Fix it by initializing io->tasklet in crypt_io_init().

Fixes: 8e14f610159d ("dm crypt: do not call bio_endio() from the dm-crypt tasklet")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/md/dm-crypt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 3aeeb8f2802f..caee6ce3b79f 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -238,6 +238,7 @@ static void crypt_endio(struct bio *clone);
 static void kcryptd_queue_crypt(struct dm_crypt_io *io);
 static struct scatterlist *crypt_get_sg_data(struct crypt_config *cc,
 					     struct scatterlist *sg);
+static void kcryptd_crypt_tasklet(unsigned long work);
 
 static bool crypt_integrity_aead(struct crypt_config *cc);
 
@@ -1725,6 +1726,7 @@ static void crypt_io_init(struct dm_crypt_io *io, struct crypt_config *cc,
 	io->sector = sector;
 	io->error = 0;
 	io->ctx.r.req = NULL;
+	tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
 	io->integrity_metadata = NULL;
 	io->integrity_metadata_from_pool = false;
 	atomic_set(&io->io_pending, 0);
@@ -2226,7 +2228,6 @@ static void kcryptd_queue_crypt(struct dm_crypt_io *io)
 		 * it is being executed with irqs disabled.
 		 */
 		if (in_hardirq() || irqs_disabled()) {
-			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
 			tasklet_schedule(&io->tasklet);
 			return;
 		}
-- 
2.29.2

