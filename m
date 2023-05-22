Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BAF70B825
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjEVI4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjEVIzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:55:48 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC48106;
        Mon, 22 May 2023 01:55:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QPrrG0S7Qz4f4Rr8;
        Mon, 22 May 2023 16:55:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyH9LWtkv1S3JA--.39975S4;
        Mon, 22 May 2023 16:55:27 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH] block: remove redundant req_op in blk_rq_is_passthrough
Date:   Mon, 22 May 2023 16:53:55 +0800
Message-Id: <20230522085355.1740772-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyH9LWtkv1S3JA--.39975S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZry5JF18Gr4fXFWrWr1DGFg_yoW3Krc_u3
        9F9r97ur1fArsxXwsYyF10vr43Ar97J3WUW34kGryavaykW3Z8t393GrZ8XFW7WFZ7uFWk
        Ga10gr92vr47XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4kYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67
        AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAK
        j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwc_TUU
        UUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

op &= REQ_OP_MASK in blk_op_is_passthrough() is exactly what req_op() do.
Therefore, it is redundant to call req_op() for blk_op_is_passthrough().

Signed-off-by: Li Nan <linan122@huawei.com>
---
 include/linux/blk-mq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d778cb6b2112..59b52ec155b1 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -201,7 +201,7 @@ static inline enum req_op req_op(const struct request *req)
 
 static inline bool blk_rq_is_passthrough(struct request *rq)
 {
-	return blk_op_is_passthrough(req_op(rq));
+	return blk_op_is_passthrough(rq->cmd_flags);
 }
 
 static inline unsigned short req_get_ioprio(struct request *req)
-- 
2.31.1

