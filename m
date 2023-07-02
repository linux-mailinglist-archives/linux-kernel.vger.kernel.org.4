Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF86745100
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjGBTns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjGBTnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:43:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4F81FDB;
        Sun,  2 Jul 2023 12:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 299FB60D33;
        Sun,  2 Jul 2023 19:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCDFC433CA;
        Sun,  2 Jul 2023 19:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326863;
        bh=cEeFawSGtFwo6zua+qk5x1zyKvWqEF/YF/YPshZrmb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fg5STtJoec53f48nzs1eVfRdIYOtM5KBdhWPIXAR8J6yeo1UPi/Da4DT02083eAmk
         DO+xXAdafBQ1TF3BVfbxjff4fdb0HTK2caDwCw2IfRlLBjH2A61RHFNnxGbk1ibhf0
         l9pnRC/6i5xX578awQ0khGeXCbLndXWiV/wXQAHTC+jqqrIzqP/tfearwpKd8qx1y9
         WHrQj2CB452uhqAYpCJTMeXsqUz2zKkCd4D913Pq9fwpSPocR7vieWXIWi7xTlY6Rx
         pK+U/kWDLbXgcnxH11kGsr5b/73alJ/EabHacJNB7RABmqUB0sJKERa7ZDdgbkDq1Z
         nwJ+EK3XoJ0rg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhong Jinghua <zhongjinghua@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, josef@toxicpanda.com,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 6.3 05/14] nbd: Add the maximum limit of allocated index in nbd_dev_add
Date:   Sun,  2 Jul 2023 15:40:44 -0400
Message-Id: <20230702194053.1777356-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194053.1777356-1-sashal@kernel.org>
References: <20230702194053.1777356-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.11
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhong Jinghua <zhongjinghua@huawei.com>

[ Upstream commit f12bc113ce904777fd6ca003b473b427782b3dde ]

If the index allocated by idr_alloc greater than MINORMASK >> part_shift,
the device number will overflow, resulting in failure to create a block
device.

Fix it by imiting the size of the max allocation.

Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230605122159.2134384-1-zhongjinghua@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index dd0adcf745ff5..f0cdc5c576d9d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1776,7 +1776,8 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 		if (err == -ENOSPC)
 			err = -EEXIST;
 	} else {
-		err = idr_alloc(&nbd_index_idr, nbd, 0, 0, GFP_KERNEL);
+		err = idr_alloc(&nbd_index_idr, nbd, 0,
+				(MINORMASK >> part_shift) + 1, GFP_KERNEL);
 		if (err >= 0)
 			index = err;
 	}
-- 
2.39.2

