Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4676771830D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbjEaNq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbjEaNpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:45:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2531BF3;
        Wed, 31 May 2023 06:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B1BF61476;
        Wed, 31 May 2023 13:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C044DC4339B;
        Wed, 31 May 2023 13:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540586;
        bh=MhTyEwAVoWuct1qjPySfzk9ClI6MHygYq9CIndOlE+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sB3Z2VmHxTHfRb+7rhuGyz5ngaAA3wTgwq7Owimr/hkuUc1g80DE30+G+GpdDlXdn
         SGqoJrATvoseMYRoAgMikPdJQ9XrVtqh5QmgM0TktKt4v7NdHyzpBQ8McCp4kxBa0h
         kr+qS8CHAc+J/AkCVN2a08BH8/ucriiqQtPADS3f8eyECV+PIYG+F8hiOiUYAIlA9/
         pC+ZXUYL+ree36oOQenumrj0dA4wd6+GwsvsV0NT2a5Yjd15TxrYx+FW/HcdKJ5b+U
         27wrZsT0Rk+XerAiE3T9mR+OU2O3b+SqecZlUEFXj++DoVlWzPCKgqsxPz4S63m1X5
         sDrg07kTBTVug==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>, roger.pau@citrix.com,
        sstabellini@kernel.org, axboe@kernel.dk,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 30/33] xen/blkfront: Only check REQ_FUA for writes
Date:   Wed, 31 May 2023 09:41:56 -0400
Message-Id: <20230531134159.3383703-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134159.3383703-1-sashal@kernel.org>
References: <20230531134159.3383703-1-sashal@kernel.org>
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
index 35b9bcad9db90..5ddf393aa390f 100644
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

