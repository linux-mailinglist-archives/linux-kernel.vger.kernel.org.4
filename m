Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6BE5BC104
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 03:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiISB2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 21:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiISB2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 21:28:35 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6927B186EE;
        Sun, 18 Sep 2022 18:28:32 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 07F9A1E80D75;
        Mon, 19 Sep 2022 09:25:34 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sGjsW4Xt2sJy; Mon, 19 Sep 2022 09:25:31 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 1DAAC1E80CAB;
        Mon, 19 Sep 2022 09:25:31 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] block: Remove unnecessary (void*) conversions
Date:   Mon, 19 Sep 2022 09:28:25 +0800
Message-Id: <20220919012825.2936-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The key pointer does not need to cast the type.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 7936e5f5821c..b473efd89b86 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1430,7 +1430,7 @@ static int iocg_wake_fn(struct wait_queue_entry *wq_entry, unsigned mode,
 			int flags, void *key)
 {
 	struct iocg_wait *wait = container_of(wq_entry, struct iocg_wait, wait);
-	struct iocg_wake_ctx *ctx = (struct iocg_wake_ctx *)key;
+	struct iocg_wake_ctx *ctx = key;
 	u64 cost = abs_cost_to_cost(wait->abs_cost, ctx->hw_inuse);
 
 	ctx->vbudget -= cost;
-- 
2.18.2

