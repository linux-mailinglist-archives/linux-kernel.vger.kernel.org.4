Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA01071827F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbjEaNna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbjEaNmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:42:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC541725;
        Wed, 31 May 2023 06:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C7E363B2A;
        Wed, 31 May 2023 13:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D34C4339E;
        Wed, 31 May 2023 13:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540505;
        bh=HlwpPDD095eWKjo4oiJTfkTblpFKG89ZfJEGh62GyPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/AHXEi4gffcFw4H66NjLeAgQNUYA65+rfeyDw9g9EI9otB/vWnYXMywDCAPJM6mC
         5tZlSW4po/mbyAXem2lAlTLjPpUODxdi1rvb2HIJ9ceHBoIQMao9wimysTy4If9eQO
         O4JS4pa+Upf8wMKAibsOJiitfK++uSS6s6ZbcS8l9+6CdnKx2r0o3+6/c9/s8XR+1r
         /WxTGS0PKR3e3Q5uJ57QQpWrStjhjeXT41+URM/KxRmAmg8QGbGJajaTF6O93pT4EQ
         jSHyodjTI48Rr2cR1Z6pBOtecZf13LElNc5IsWyF7Rdne/II5CXCweCYO3cC0dlsIC
         GBAamB3O5GgPA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>, sstabellini@kernel.org,
        roger.pau@citrix.com, axboe@kernel.dk,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 34/37] xen/blkfront: Only check REQ_FUA for writes
Date:   Wed, 31 May 2023 09:40:16 -0400
Message-Id: <20230531134020.3383253-34-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134020.3383253-1-sashal@kernel.org>
References: <20230531134020.3383253-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit b6ebaa8100090092aa602530d7e8316816d0c98d ]

The existing code silently converts read operations with the
REQ_FUA bit set into write-barrier operations. This results in data
loss as the backend scribbles zeroes over the data instead of returning
it.

While the REQ_FUA bit doesn't make sense on a read operation, at least
one well-known out-of-tree kernel module does set it and since it
results in data loss, let's be safe here and only look at REQ_FUA for
writes.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Acked-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20230426164005.2213139-1-ross.lagerwall@citrix.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/xen-blkfront.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 23ed258b57f0e..c1890c8a9f6e7 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -780,7 +780,8 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 		ring_req->u.rw.handle = info->handle;
 		ring_req->operation = rq_data_dir(req) ?
 			BLKIF_OP_WRITE : BLKIF_OP_READ;
-		if (req_op(req) == REQ_OP_FLUSH || req->cmd_flags & REQ_FUA) {
+		if (req_op(req) == REQ_OP_FLUSH ||
+		    (req_op(req) == REQ_OP_WRITE && (req->cmd_flags & REQ_FUA))) {
 			/*
 			 * Ideally we can do an unordered flush-to-disk.
 			 * In case the backend onlysupports barriers, use that.
-- 
2.39.2

