Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D096BB86A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjCOPtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjCOPs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:48:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850FFEB69;
        Wed, 15 Mar 2023 08:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5rsRsnc1diiwP8SBLsG3BIfnjxBFYEa5UNRKm/bD61g=; b=zOwO1tC1hW0MI59eNwcNzzXk0j
        ZX2wAdJdghEZuwuNKIEFZoQ4KZHy9JlG/ULkXH3H6MOhDBOvLUzlIiNLwvKdDv8F088Q2oT2OARtF
        jstfp4iJpSg5TjujtPM8f5etijqSzJjtK+Xqz4LgyXJro9fFwbCZuglJZ5qw/FSY6Pncylnh9a51b
        Jp6bEFYPcPJha/z8HSJKaGmZiskrmbhSRAKJ0Ejq3EzH558Pg7jKlIBGNfcZKR87HFYWVY0F/crsz
        HimFgZ37Edy3xb42Q4bGXtSNvGwWtX4r9Zupana1HlaKx1q4U50hVLoSY2jJs58bpnarHNQuN7f1X
        05qRkicw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcTMm-00DwT5-1h;
        Wed, 15 Mar 2023 15:48:40 +0000
Date:   Wed, 15 Mar 2023 08:48:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] loop: LOOP_CONFIGURE: send uevents for partitions
Message-ID: <ZBHo2AXYM0iVkXvO@infradead.org>
References: <20230312191031.551204-1-hi@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312191031.551204-1-hi@alyssa.is>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 07:10:31PM +0000, Alyssa Ross wrote:
> +	 * Now that we are done, reread the partitions with uevent
> +	 * re-enabled if appropriate to let userspace know about the
> +	 * changes.
> +	 */
> +	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), !partscan_uevent);
> +	if (partscan)
> +		loop_reread_partitions(lo);
> +	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);

What worries me here is that you move the partition re-read out of
the exclusive claim, which is another potentially user visible
change (and user visible behavior changes are a field of landmines
in loop as you have noticed).

But in the end we only need to suppress the events until Lo_Bound
is set.  So something like the patch below that reduces the no even
critical section might do the job?

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
