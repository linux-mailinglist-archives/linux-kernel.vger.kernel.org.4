Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4146C73FBC4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjF0MJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjF0MJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:09:37 -0400
Received: from out-51.mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8F41BDF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:09:35 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687867774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/O8YJWAa7A//A8YJ1hLAuWA8H/d3IRDfJMQYLuFl59Q=;
        b=BKYs2RGGfguSyGgb3IkV0RPbcq3qcyqARGTaYepvA/FA23tWcM1aCKi9+krWCYMIr76uDo
        0rexnwxqzl8F4RZ+cp2FB7HOANASVMlE9UM3j94Z0oNZIF2TrJ5THWKMJPYTCCYgFm75hz
        mfYbjzBSr1YbbergYLsysrTqqxOQqg0=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, tj@kernel.org, hch@lst.de, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 4/4] blk-mq: delete unused completion_data in struct request
Date:   Tue, 27 Jun 2023 20:08:54 +0800
Message-Id: <20230627120854.971475-5-chengming.zhou@linux.dev>
In-Reply-To: <20230627120854.971475-1-chengming.zhou@linux.dev>
References: <20230627120854.971475-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

After global search, I found "completion_data" in struct request
is not used anywhere, so just clean it up by the way.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/blk-mq.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 96644d6f8d18..ab790eba5fcf 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -158,13 +158,11 @@ struct request {
 
 	/*
 	 * The rb_node is only used inside the io scheduler, requests
-	 * are pruned when moved to the dispatch queue. So let the
-	 * completion_data share space with the rb_node.
+	 * are pruned when moved to the dispatch queue.
 	 */
 	union {
 		struct rb_node rb_node;	/* sort/lookup */
 		struct bio_vec special_vec;
-		void *completion_data;
 	};
 
 	/*
-- 
2.39.2

