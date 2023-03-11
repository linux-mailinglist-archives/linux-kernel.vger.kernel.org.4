Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3062F6B5A0C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 10:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjCKJaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 04:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjCKJ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 04:29:55 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D066227B6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:29:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E617961989E6;
        Sat, 11 Mar 2023 10:29:50 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3g_el_QkYBeq; Sat, 11 Mar 2023 10:29:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CA1EA61989EA;
        Sat, 11 Mar 2023 10:29:49 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0uJFQxCAaqwE; Sat, 11 Mar 2023 10:29:49 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (089144204221.atnat0013.highway.webapn.at [89.144.204.221])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 03ECF61989E6;
        Sat, 11 Mar 2023 10:29:48 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Daniel Palmer <daniel@0x0f.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] ubi: block: Fix missing blk_mq_end_request
Date:   Sat, 11 Mar 2023 10:29:29 +0100
Message-Id: <20230311092929.2827-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switching to BLK_MQ_F_BLOCKING wrongly removed the call to
blk_mq_end_request(). Add it back to have our IOs finished

Cc: Daniel Palmer <daniel@0x0f.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Fixes: 91cc8fbcc8c7 ("ubi: block: set BLK_MQ_F_BLOCKING")
Analyzed-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Daniel Palmer <daniel@0x0f.com>
Link: https://lore.kernel.org/linux-mtd/CAHk-=3Dwi29bbBNh3RqJKu3PxzpjDN5D=
5K17gEVtXrb7-6bfrnMQ@mail.gmail.com/
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/block.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 1de87062c67b..3711d7f74600 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -221,7 +221,10 @@ static blk_status_t ubiblock_read(struct request *re=
q)
=20
 	rq_for_each_segment(bvec, req, iter)
 		flush_dcache_page(bvec.bv_page);
-	return errno_to_blk_status(ret);
+
+	blk_mq_end_request(req, errno_to_blk_status(ret));
+
+	return BLK_STS_OK;
 }
=20
 static int ubiblock_open(struct block_device *bdev, fmode_t mode)
--=20
2.26.2

