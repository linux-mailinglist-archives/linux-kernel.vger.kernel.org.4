Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B2D64E6AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 05:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiLPEYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 23:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLPEYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 23:24:04 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17E45FB9A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 20:24:01 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NYGFR3QPHz4f3kLC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:23:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD3Z9Xc8ptj4ChDCQ--.22309S4;
        Fri, 16 Dec 2022 12:23:58 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     dm-devel@redhat.com
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        linux-kernel@vger.kernel.org, houtao1@huawei.com
Subject: [PATCH] dm: remove unnecessary check when using dm_get_mdptr()
Date:   Fri, 16 Dec 2022 12:23:53 +0800
Message-Id: <20221216042353.3132139-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3Z9Xc8ptj4ChDCQ--.22309S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4DKFWUArWkJF1DGr4fuFg_yoW8AF4Dpr
        4YgrWavrykJFsFgr4jvanxuF90gw1Yk3yUGryIk34Y93W5u3WUWay5GF92qFyrKFZ7AFWY
        gF1Ig3y5AF4DJwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

__hash_remove() removes hash_cell with _hash_lock locked, so acquiring
_hash_lock can guarantee no-NULL hc returned from dm_get_mdptr() must
have not been removed and hc->md must still be md.

__hash_remove() also acquires dm_hash_cells_mutex before setting mdptr
as NULL, so in dm_copy_name_and_uuid() after acquiring
dm_hash_cells_mutex and ensuring returned hc is not NULL, the returned
hc must still be alive and hc->md must still be md.

So removing these unnecessary hc->md != md checks when using
dm_get_mdptr() with _hash_lock or dm_hash_cells_mutex acquired.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/md/dm-ioctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 3bfc1583c20a..2a86524661d1 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -772,7 +772,7 @@ static struct dm_table *dm_get_inactive_table(struct mapped_device *md, int *src
 
 	down_read(&_hash_lock);
 	hc = dm_get_mdptr(md);
-	if (!hc || hc->md != md) {
+	if (!hc) {
 		DMERR("device has been removed from the dev hash table.");
 		goto out;
 	}
@@ -1476,7 +1476,7 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
 	/* stage inactive table */
 	down_write(&_hash_lock);
 	hc = dm_get_mdptr(md);
-	if (!hc || hc->md != md) {
+	if (!hc) {
 		DMERR("device has been removed from the dev hash table.");
 		up_write(&_hash_lock);
 		r = -ENXIO;
@@ -2128,7 +2128,7 @@ int dm_copy_name_and_uuid(struct mapped_device *md, char *name, char *uuid)
 
 	mutex_lock(&dm_hash_cells_mutex);
 	hc = dm_get_mdptr(md);
-	if (!hc || hc->md != md) {
+	if (!hc) {
 		r = -ENXIO;
 		goto out;
 	}
-- 
2.29.2

