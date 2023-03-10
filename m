Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0713A6B4E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCJRc0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 12:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjCJRcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:32:23 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75F6125D8A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:32:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7A3C56431C2D;
        Fri, 10 Mar 2023 18:32:18 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1z7O47DOjub4; Fri, 10 Mar 2023 18:32:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1CED36431C2E;
        Fri, 10 Mar 2023 18:32:18 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PgzRtHC7n5Fa; Fri, 10 Mar 2023 18:32:18 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id ED4A56431C21;
        Fri, 10 Mar 2023 18:32:17 +0100 (CET)
Date:   Fri, 10 Mar 2023 18:32:17 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Palmer <daniel@0x0f.com>, hch <hch@lst.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <349964589.230468.1678469537890.JavaMail.zimbra@nod.at>
In-Reply-To: <CAHk-=wi29bbBNh3RqJKu3PxzpjDN5D5K17gEVtXrb7-6bfrnMQ@mail.gmail.com>
References: <1115586887.187161.1677658022188.JavaMail.zimbra@nod.at> <CAFr9PXktRBm66vgVjOnwTeucBD36OuPjDVNd9cH1F8u0nesKrA@mail.gmail.com> <CAHk-=wi29bbBNh3RqJKu3PxzpjDN5D5K17gEVtXrb7-6bfrnMQ@mail.gmail.com>
Subject: Re: [GIT PULL] JFFS2, UBI and UBIFS updates for v6.3-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: JFFS2, UBI and UBIFS updates for v6.3-rc1
Thread-Index: 2Hg5rsNJ6XBCeBp97qB+tTE07fBndw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
>> This seems to be causing one of my machines to lock up during boot.
>> It's using a squashfs root that is on a ubiblock that is located on an SPI NAND.
> 
> Hmm. That commit 91cc8fbcc8c7 ("ubi: block: set BLK_MQ_F_BLOCKING") is odd.
> 
> Christoph - you removed the
> 
>        blk_mq_start_request(req);
>        ...
>        blk_mq_end_request(req, errno_to_blk_status(ret));
> 
> from the workqueue function, but while you added the
> blk_mq_start_request() into ubiblock_read(), the 'end_request()' is
> missing.
> 
> So I suspect the IO has completed, but the change means that nobody
> was informed about said completion, so now trying to mount an ext4
> filesystem on it hangs on the read.
> 
> But I don't actually know this code, that was just from looking at the
> commit that breaks.
> 
> Christoph? Daniel used your infradead address, I don't know if it all
> goes into the same pile, but let's use your regular one. And I can't
> see Daniel's message on lore.kernel.org at all, for whatever reason,
> 

Indeed, I'm able to reproduce the problem and adding blk_mq_end_request()
back fixes it.

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 1de87062c67b..3711d7f74600 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -221,7 +221,10 @@ static blk_status_t ubiblock_read(struct request *req)
 
 	rq_for_each_segment(bvec, req, iter)
 		flush_dcache_page(bvec.bv_page);
-	return errno_to_blk_status(ret);
+
+	blk_mq_end_request(req, errno_to_blk_status(ret));
+
+	return BLK_STS_OK;
 }
 
 static int ubiblock_open(struct block_device *bdev, fmode_t mode)

Thanks,
//richard
