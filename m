Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29037183DB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbjEaNwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbjEaNuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAEF2D7C;
        Wed, 31 May 2023 06:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E1A663B7F;
        Wed, 31 May 2023 13:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77B2C4339B;
        Wed, 31 May 2023 13:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540731;
        bh=p/IgxmZZFrxBdPYVbroxVgHz0FMQYuzCL/FQBFsDPeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gsP/PpgZHs3JyUBeO4WmELP+CM81s9Hiotlsj3drW6kgRnoApYPP4gwPRoGlxiToN
         2HQ/VxH88YGyziOO7f5vP2d3jGDWpc9ZyHqXnGridTKFGsiwI3RmL1oUSPhIniFVOB
         XW0CE3vz1QVXahSOtTRh98XWhpLruunBjXDrQytm1i/+XefEIXcnuojAxs951Cuqw3
         GZJupS/PLGEAZhy4/UdY1OIQkLxxGMQYdUB+3tLgaCqyEd1aw9aK1C8mX6F3dtsEkT
         WpbY+g9tk43wKb7AxxI9YjQDJonXqT9opxC7z+dRHFQ2ST34LgtY43QUVpRqzATJ3L
         Ns6uxmx64+BRw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>, roger.pau@citrix.com,
        sstabellini@kernel.org, axboe@kernel.dk,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 16/17] xen/blkfront: Only check REQ_FUA for writes
Date:   Wed, 31 May 2023 09:45:00 -0400
Message-Id: <20230531134502.3384828-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134502.3384828-1-sashal@kernel.org>
References: <20230531134502.3384828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index d0538c03f0332..da67621ebc212 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -779,7 +779,8 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
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

