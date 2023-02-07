Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1E568D027
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjBGHJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjBGHJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:09:09 -0500
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9764F2278C;
        Mon,  6 Feb 2023 23:09:07 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vb64zG8_1675753744;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0Vb64zG8_1675753744)
          by smtp.aliyun-inc.com;
          Tue, 07 Feb 2023 15:09:04 +0800
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH RESEND 3/3] ublk: pass NULL to blk_mq_alloc_disk() as queuedata
Date:   Tue,  7 Feb 2023 15:08:39 +0800
Message-Id: <20230207070839.370817-4-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20230207070839.370817-1-ZiyangZhang@linux.alibaba.com>
References: <20230207070839.370817-1-ZiyangZhang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

queuedata is not referenced in ublk_drv and we can use driver_data
instead. Pass NULL to blk_mq_alloc_disk() as queuedata while allocating
ublk's gendisk.

Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 06eddefdf02a..d83fe2c2b3ba 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1578,7 +1578,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 		goto out_unlock;
 	}
 
-	disk = blk_mq_alloc_disk(&ub->tag_set, ub);
+	disk = blk_mq_alloc_disk(&ub->tag_set, NULL);
 	if (IS_ERR(disk)) {
 		ret = PTR_ERR(disk);
 		goto out_unlock;
-- 
2.18.4

