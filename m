Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746B770E3A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbjEWQuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbjEWQuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:50:08 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E4ACD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:49:18 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-75affe9d7feso10328585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684860557; x=1687452557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3EMNNGlTZuYQJrvyvOENR+PpdBzLBVxLhbFOjcQtI8=;
        b=MMmBq0Xu3x6VAbsvAAUAnQVUqxbmsK21ppFzj7xhXEs4MVAlIsKR6cIW2He5c95smc
         FJXLR1j8HmyaaeYTL532BvZyg3qb82edMUxhHE6Znr78Tx60urBQ5pUIkBn1MQxulYXY
         Ber3Z/lC7EEooQpT6HOZb3/lsu8l9OSCu1qGDUi3XzXh4t3+u/BkgVkxTsRXbAgoqxT8
         iE2TucaYpixcp/mAbvFDG6tcUSyXSJr4uaGa7ndJ3x37uGe5srlc3HkT/iaVXJ5bHDJQ
         akWz+fKINSAi2Nw4XuzwDBdFwG3wv3DXr6TaFi7Blic2T6nCc+GlokqgZsgxNoWYKt3F
         eP5Q==
X-Gm-Message-State: AC+VfDwaTUD1L0SKJayvQuLw7OQUDjUTfPU/L0PGJGOfoDgeblLKBcFk
        UbO0sU2kdKcNyWXAPpbjU1C1
X-Google-Smtp-Source: ACHHUZ60MTd8uQA0xp9MNOc+NSCIw6YiYWa5gikMW79ezh2QPyW9HHZu/QE2R1r4T9c4z9ffo1j2pw==
X-Received: by 2002:a37:458b:0:b0:75b:23a0:de95 with SMTP id s133-20020a37458b000000b0075b23a0de95mr4318585qka.19.1684860557503;
        Tue, 23 May 2023 09:49:17 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id m5-20020ae9e005000000b007578b6d060bsm2619050qkk.126.2023.05.23.09.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:49:17 -0700 (PDT)
Date:   Tue, 23 May 2023 12:49:16 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 19/24] dm: remove dm_get_dev_t
Message-ID: <ZGzujNVLaQD2npwH@redhat.com>
References: <20230523074535.249802-1-hch@lst.de>
 <20230523074535.249802-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523074535.249802-20-hch@lst.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23 2023 at  3:45P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Open code dm_get_dev_t in the only remaining caller, and propagate the
> exact error code from lookup_bdev and early_lookup_bdev.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/md/dm-table.c         | 20 ++++----------------
>  include/linux/device-mapper.h |  2 --
>  2 files changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 05aa16da43b0d5..e997f4322a9967 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -323,20 +323,6 @@ static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode,
>  	return 0;
>  }
>  
> -/*
> - * Convert the path to a device
> - */
> -dev_t dm_get_dev_t(const char *path)
> -{
> -	dev_t dev;
> -
> -	if (lookup_bdev(path, &dev) &&
> -	    early_lookup_bdev(path, &dev))
> -		return 0;
> -	return dev;
> -}
> -EXPORT_SYMBOL_GPL(dm_get_dev_t);
> -
>  /*
>   * Add a device to the list, or just increment the usage count if
>   * it's already present.
> @@ -359,8 +345,10 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
>  		if (MAJOR(dev) != major || MINOR(dev) != minor)
>  			return -EOVERFLOW;
>  	} else {
> -		dev = dm_get_dev_t(path);
> -		if (!dev)
> +		r = lookup_bdev(path, &dev);
> +		if (r)
> +			r = early_lookup_bdev(path, &dev);
> +		if (r)
>  			return -ENODEV;
>  	}
>  	if (dev == disk_devt(t->md->disk))

OK, but you aren't actually propagating the exact error code.  Did
you intend to change the return from -ENODEV to r?

Mike
