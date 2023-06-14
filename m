Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D412572F866
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243834AbjFNIws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243779AbjFNIwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:52:34 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E32B271E;
        Wed, 14 Jun 2023 01:52:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qgzgv5rZRz4f3l7H;
        Wed, 14 Jun 2023 16:52:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbG7f4lks7u0Lg--.65484S5;
        Wed, 14 Jun 2023 16:52:13 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, neilb@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 1/3] md/raid10: record rdev/replacement in struct r10bio
Date:   Wed, 14 Jun 2023 16:47:38 +0800
Message-Id: <20230614084740.1493969-2-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230614084740.1493969-1-linan666@huaweicloud.com>
References: <20230614084740.1493969-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbG7f4lks7u0Lg--.65484S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Xw47Cw43AryDZw4UCr1rZwb_yoW8Jr4Upa
        1DGF13Cr47Wayj9r4DAa1UCa4ftanYy3y8GFWY934aq34avrWDAF4UGrW5urWUZFsxW34I
        vw1DKrZ5G3WUAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU858n5UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

Getting rdev/replacement from mirror is risky. Replacement can replace
rdev while repl_bio pending, which forces us to add some complex code to
handle this scenario, but there are still some bugs left. Record
rdev/replacement in r10bio and get them from r10bio is a better way. It
is easy to ensure that rdev and replacement remains consistent in io
process, which can help us clean up some code and fix bugs.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid10.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index 8c072ce0bc54..261315ffe8c0 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -145,12 +145,12 @@ struct r10bio {
 	 */
 	struct r10dev {
 		struct bio	*bio;
-		union {
-			struct bio	*repl_bio; /* used for resync and
-						    * writes */
-			struct md_rdev	*rdev;	   /* used for reads
-						    * (read_slot >= 0) */
-		};
+		/* Currently just used for normal reads and writes */
+		struct md_rdev	*rdev;
+		/* used for resync and writes */
+		struct bio	*repl_bio;
+		/* Currently just used for normal writes */
+		struct md_rdev	*replacement;
 		sector_t	addr;
 		int		devnum;
 	} devs[];
-- 
2.39.2

