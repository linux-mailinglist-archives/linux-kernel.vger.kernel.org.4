Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0326174510B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjGBTn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjGBTnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:43:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1901717;
        Sun,  2 Jul 2023 12:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6273360C98;
        Sun,  2 Jul 2023 19:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CC3C433C7;
        Sun,  2 Jul 2023 19:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326887;
        bh=RxlXsflnEp7RFLDuPs5gHmCCdiUpNwwE5gg2pzW0CMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H26PcLGbuNivctog+BnYo/Kav57typu08hMQ4SbfM2Ntj7NdZrAzvREIhOAAsxTqu
         sd/TuUG/43YrELeVLRHkhf1+cri4+z0ffZCv3GjtI2MCmP5dOde5rnlLinUUOv9btY
         4i4pfwOsLIZhzkmFs2dQ0O/moEsEslk1ibWq0j+h/fa5RQ/luwn+DRLYDxP4G6BhgC
         aY7aJgxUrRdesdyfyH1OiZhyRBuJePTEc9queDJBkBDKgzulZA0ZY3agxwCVfO9FZN
         nQnAQSpKlMvNbPipp8LGe1aw/7qPgeXF+0kYnEAu8zqVHaVDqKj5pBaIg0q/jB4588
         62MIqVu1k0Upw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhong Jinghua <zhongjinghua@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, josef@toxicpanda.com,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 6.1 05/12] nbd: Add the maximum limit of allocated index in nbd_dev_add
Date:   Sun,  2 Jul 2023 15:41:10 -0400
Message-Id: <20230702194118.1777794-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194118.1777794-1-sashal@kernel.org>
References: <20230702194118.1777794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.37
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 7718c81e1dba8..8d75faa25076d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1775,7 +1775,8 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
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

