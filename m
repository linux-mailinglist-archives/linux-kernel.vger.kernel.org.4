Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBFE725637
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbjFGHp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjFGHoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:44:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1041FC8;
        Wed,  7 Jun 2023 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OM0BuqqlawJryT9IX33+CW481h0jO+pL7fC3zg1G8M0=; b=Dwam7ai2Hae6B/IyWvM+6/4d4U
        p1tzeI8V42Mp6UhB++W7VYusnoAtCzwBtZk2ORH+/kHpvZjMdvQTWp22BaTT2CT4Asp2/vjwmnDAW
        4+t2O8KUOLuF8mK1xspDlcoWayDBpfhVZF/kaT7mp/sxc4TqtaUdeMQstgztfMxeXljLCKbYtNGm0
        rsaIkR+DqpE2+hmPGKGdoZEojIBhwr5eCe1UOtaQamCLWia8dZv4RQzyuC2WPbII3siuQMYxhT0K/
        6IA0O8xrKNXavDlT9BOuv6sjNWDK6dhQMHfzVCqusXh5VEPi/X2AWFEpueZz7Lly2Oj65xdzkh26O
        L6co5k5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6no3-004mhI-09;
        Wed, 07 Jun 2023 07:42:11 +0000
Date:   Wed, 7 Jun 2023 00:42:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block, loop: Increment diskseq when releasing a loop
 device
Message-ID: <ZIA004HDuhoTQzY/@infradead.org>
References: <20230601222656.2062-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601222656.2062-1-demi@invisiblethingslab.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/block/genhd.c
> @@ -1502,3 +1502,4 @@ void inc_diskseq(struct gendisk *disk)
>  {
>  	disk->diskseq = atomic64_inc_return(&diskseq);
>  }
> +EXPORT_SYMBOL(inc_diskseq);

I really do not like exporting this as a lowlevel function.  If we
increment the sequence it should be part of a higher level operation.

> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1205,6 +1205,12 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
>  	if (!part_shift)
>  		set_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
>  	mutex_lock(&lo->lo_mutex);
> +
> +	/*
> +	 * Increment the disk sequence number, so that userspace knows this
> +	 * device now points to something else.
> +	 */
> +	inc_diskseq(lo->lo_disk);

And I'm not sure why we even need this.  __loop_clr_fd
already calls disk_force_media_change, which calls inc_diskseq.
Why do we need an extra increment?

