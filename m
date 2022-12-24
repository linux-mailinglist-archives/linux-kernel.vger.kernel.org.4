Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F866558CE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 08:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiLXHOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 02:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLXHOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 02:14:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BF210041;
        Fri, 23 Dec 2022 23:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lmUHEYf8bFrxNnNTMUfukWsojK4GI28KYKGOVlj0iYI=; b=2e/jQz6Dv0j0VBQKGvzfghgA8g
        M/ohDLU0ubltlL2vXEOGw5i8/4BarelV2yogFYxjlaTYrRxy7Got8bADvYx3WE6Eup4GOXB/pk3dj
        BVs+5tVQTEm9N0gUOYS9PMLhPPepAHp26sT34g/1Qs3/cSWzWPVnbqozQvHMh2reyDxuxW8dOrtLj
        tqD0maPplQ5JRdiOJbhZkD++Sj5grmwne6ceJJGIWBFvDOeIGbjpT8pL5axVtwZxuecFVNl+TMldR
        Wp/vIs0zgUfIMz3dGWVj2O9+PY4aqSMGkIdDI8nxf7BhVX0hIb1pCacHcE4jLHq9nNTL1iFpSCZ45
        LzRrZjkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8yjf-00FsG8-V5; Sat, 24 Dec 2022 07:14:24 +0000
Date:   Fri, 23 Dec 2022 23:14:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: 6.2 nvme-pci: something wrong
Message-ID: <Y6amzxU7choHAXWi@infradead.org>
References: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 09:24:56PM -0800, Hugh Dickins wrote:
> Hi Christoph,
> 
> There's something wrong with the nvme-pci heading for 6.2-rc1:
> no problem booting here on this Lenovo ThinkPad X1 Carbon 5th,
> but under load...
> 
> nvme nvme0: I/O 0 (I/O Cmd) QID 2 timeout, aborting
> nvme nvme0: I/O 1 (I/O Cmd) QID 2 timeout, aborting
> nvme nvme0: I/O 2 (I/O Cmd) QID 2 timeout, aborting
> nvme nvme0: I/O 3 (I/O Cmd) QID 2 timeout, aborting
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: I/O 0 QID 2 timeout, reset controller
> 
> ...and more, until I just have to poweroff and reboot.
> 
> Bisection points to your
> 0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")
> And that does revert cleanly, giving a kernel which shows no problem.
> 
> I've spent a while comparing old nvme_pci_alloc_tag_set() and new
> nvme_alloc_io_tag_set(), I do not know my way around there at all
> and may be talking nonsense, but it did look as if there might now
> be a difference in the queue_depth, sqsize, q_depth conversions.
> 
> I'm running load successfully with the patch below, but I strongly
> suspect that the right patch will be somewhere else: over to you!

Thanks for the report!  The patch is definitively wrong, ->sqsize
hold one of the awful so called 'zeroes based values' in NVMe,
where 0 means 1, and thus have a built-in one off.  We should
probably convert it to a sane value at read time, but that's a
separate discussion.

I suspect your controller is one of those where we quirk the size,
and the commit you bisected fails to reflects that in the common
sqsizse value.  The patch below should be the minimum fix, and in
the long term, the duplicate bookkeeping for it in the PCI driver
should go away:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f0f8027644bbf8..a73c0ee7bd1892 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2536,7 +2536,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	dev->q_depth = min_t(u32, NVME_CAP_MQES(dev->ctrl.cap) + 1,
 				io_queue_depth);
-	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
 	dev->dbs = dev->bar + 4096;
 
@@ -2577,7 +2576,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 		dev_warn(dev->ctrl.device, "IO queue depth clamped to %d\n",
 			 dev->q_depth);
 	}
-
+	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
 
 	nvme_map_cmb(dev);
 
