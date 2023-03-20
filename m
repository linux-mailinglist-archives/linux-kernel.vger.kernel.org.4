Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769F96C0A83
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCTGW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCTGW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:22:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7E4C646;
        Sun, 19 Mar 2023 23:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=kADwawNixqcaICDRyDtL0mB8imeCk2jqYVpaKH63jgI=; b=A/OgCFWm0cIkr+Qzit0XL1+4Tz
        rL5i5OQa9fZUH9Eqx/cs+6DdIGxizJekL6tFgcvxz67QGPfLWYKyRSqhO4BdOdHcJJKv+xL8H4hNy
        wZowZTLX5HinGbP0UBCXA1CeNPx8xCL3ZfX4VitR+lFDfnn5UGKBxP/STrnGEfbMJj6uXxxCDscLW
        Svs7j76A6jbghTCAPZa1X7p0G0VZ76WJIVrpLFAf+dckgnHdISHQH8Hu0A3hjkCHPxAv0rEn2SIkE
        STEfVOUmwGAcD2c47WHRIt+htexq12QHE3ek7vN3peCRYXh+vbUGEOrfiZZ+ny2dcHH+FxVN3w4Y4
        q6klqTcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe8uX-008DwH-1A;
        Mon, 20 Mar 2023 06:22:25 +0000
Date:   Sun, 19 Mar 2023 23:22:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] loop: LOOP_CONFIGURE: send uevents for partitions
Message-ID: <ZBf7oYDLoFzOSabH@infradead.org>
References: <20230312191031.551204-1-hi@alyssa.is>
 <ZBHo2AXYM0iVkXvO@infradead.org>
 <20230318015005.czydsbqpw6hnej3z@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230318015005.czydsbqpw6hnej3z@x220>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 01:50:05AM +0000, Alyssa Ross wrote:
> If you say so!  I had trouble understanding which parts of the function
> uevents needed to be suppressed for, so I was trying to move as little
> as possible out of that section.
> 
> What happens next?  I'm still getting up to speed on the kernel
> development process — will you submit this as a patch with a patch body
> and a S-o-b?  Or am I supposed to do something with it?

Given that you're done all the hard work, and I've just reduced the
critical section, I'd prefer to give all the credit to you.  If you're
fine with it, I'll send out this version later:

---
From 4648015b4193c81d3de8c1632876314b4a2ab40d Mon Sep 17 00:00:00 2001
Subject: loop: LOOP_CONFIGURE: send uevents for partitions

LOOP_CONFIGURE is, as far as I understand it, supposed to be a way to
combine LOOP_SET_FD and LOOP_SET_STATUS64 into a single syscall.  When
using LOOP_SET_FD+LOOP_SET_STATUS64, a single uevent would be sent for
each partition found on the loop device after the second ioctl(), but
when using LOOP_CONFIGURE, no such uevent was being sent.

In the old setup, uevents are disabled for LOOP_SET_FD, but not for
LOOP_SET_STATUS64.  This makes sense, as it prevents uevents being
sent for a partially configured device during LOOP_SET_FD - they're
only sent at the end of LOOP_SET_STATUS64.  But for LOOP_CONFIGURE,
uevents were disabled for the entire operation, so that final
notification was never issued.  To fix this, reduce the critical
section to exclude the loop_reread_partitions() call, which causes
the uevents to be issued, to after uevents are re-enabled, matching
the behaviour of the LOOP_SET_FD+LOOP_SET_STATUS64 combination.

I noticed this because Busybox's losetup program recently changed from
using LOOP_SET_FD+LOOP_SET_STATUS64 to LOOP_CONFIGURE, and this broke
my setup, for which I want a notification from the kernel any time a
new partition becomes available.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
[hch: reduced the critical section]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Fixes: 3448914e8cc5 ("loop: Add LOOP_CONFIGURE ioctl")
---
 drivers/block/loop.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 839373451c2b7d..9d61c027185141 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1010,9 +1010,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
 
-	/* suppress uevents while reconfiguring the device */
-	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
-
 	/*
 	 * If we don't hold exclusive handle for the device, upgrade to it
 	 * here to avoid changing device under exclusive owner.
@@ -1067,6 +1064,9 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		}
 	}
 
+	/* suppress uevents while reconfiguring the device */
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
+
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
 	set_disk_ro(lo->lo_disk, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
@@ -1109,17 +1109,17 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	if (partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 
+	/* enable and uncork uevent now that we are done */
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
+
 	loop_global_unlock(lo, is_loop);
 	if (partscan)
 		loop_reread_partitions(lo);
+
 	if (!(mode & FMODE_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
 
-	error = 0;
-done:
-	/* enable and uncork uevent now that we are done */
-	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
-	return error;
+	return 0;
 
 out_unlock:
 	loop_global_unlock(lo, is_loop);
@@ -1130,7 +1130,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	fput(file);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
-	goto done;
+	return error;
 }
 
 static void __loop_clr_fd(struct loop_device *lo, bool release)
-- 
2.39.2

