Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA39B5BB979
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiIQQlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiIQQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:41:31 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52D82ED4B
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:41:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQ.PTTI_1663432858;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VQ.PTTI_1663432858)
          by smtp.aliyun-inc.com;
          Sun, 18 Sep 2022 00:41:21 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] nvme: request remote is usually not involved for nvme devices
Date:   Sun, 18 Sep 2022 00:40:58 +0800
Message-Id: <1663432858-99743-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

NVMe devices usually have a 1:1 mapping between "ctx" and "hctx",
so when "nr_ctx" is equal to 1, there is no possibility of remote
request, so the corresponding process can be simplified.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 drivers/nvme/host/nvme.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 216acbe..cc21896 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -672,6 +672,10 @@ static inline bool nvme_try_complete_req(struct request *req, __le16 status,
 	nvme_should_fail(req);
 	if (unlikely(blk_should_fake_timeout(req->q)))
 		return true;
+	if (likely(req->mq_hctx->nr_ctx == 1)) {
+		WRITE_ONCE(req->state, MQ_RQ_COMPLETE);
+		return false;
+	}
 	return blk_mq_complete_request_remote(req);
 }
 
-- 
1.8.3.1

