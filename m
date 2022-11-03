Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE626174FF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiKCD0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKCDZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:25:49 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D0425D1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 20:25:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y13so472154pfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 20:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I04dPDc9MnFL29tapkgYdT1iRW5mNqRONd22UhYZNlo=;
        b=X6WOwRQIYkixdI04yoGT3QMsLLevs+XFXiPVgrkSvUUk9mHxgcvyUZcpaXDgpgKb9e
         9dGg+U45/cSf8rtPRmKykxdV8wN7AEcvi50j+MgwfIdVP+R2V+hq86yAdFz+nwlxO9xD
         9ylG8bJEU9S7/Rwi+22zzq07R783eKOscpNFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I04dPDc9MnFL29tapkgYdT1iRW5mNqRONd22UhYZNlo=;
        b=WLJaunF3tceST+Esxkm7LGjbj150BTVxhY3KUIwjW2ovFj7951T8n1rYJhX0Nuev5p
         F77J0dwmAMYR/j86Sbu9Ilaf7amwomQE9gYUAb6x4lJVxPoJbD1dQH2j3v/mVXniLHTj
         oDOi51RdjZQQYxE6qC2HcHgxIpSMPlaWZWeCTYQ/qBIzND03Vsry4UWjBCOUYzePdtq6
         lXKxZGJfdfmDe6r3tB4fS15ESeHCBwNSWKxxR0jgDt4tXj8GwZvtKk4LCtj8gRmHMDWJ
         T2YhXVBoSw7YcqtQ75TIWV5I9/JEa/DvUwmisUdfOs15uEuhX96bWoLxgeHHiJx3r0Qr
         2lUA==
X-Gm-Message-State: ACrzQf26XSjG4wK74HIQw+jQN18nPzkQ9LyHrYRMoYWqRncYfxnNF8Xs
        yv3O/IFz8Xhx2OElzIo0QCaUsw==
X-Google-Smtp-Source: AMsMyM6w2kEI3z99mvuTedM827pbUAzCgl2fe5g/iKG1R93ohcZnQUpH5PI2CV3PZIUzL7zum1Y7tQ==
X-Received: by 2002:a62:b609:0:b0:56d:67fa:6b97 with SMTP id j9-20020a62b609000000b0056d67fa6b97mr20051608pff.39.1667445947658;
        Wed, 02 Nov 2022 20:25:47 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f22:e30:374d:5a2b])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ec8500b0016c0c82e85csm9079740plg.75.2022.11.02.20.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 20:25:47 -0700 (PDT)
Date:   Thu, 3 Nov 2022 12:25:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 4/9] zram: Introduce recompress sysfs knob
Message-ID: <Y2M0t5etyJiUfeQi@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-5-senozhatsky@chromium.org>
 <Y2Lbxp6to4QNYyGe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Lbxp6to4QNYyGe@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/02 14:06), Minchan Kim wrote:
> On Tue, Oct 18, 2022 at 01:55:28PM +0900, Sergey Senozhatsky wrote:
> > Allow zram to recompress (using secondary compression streams)
> > pages. We support three modes:
> > 
> > 1) IDLE pages recompression is activated by `idle` mode
> > 
> > 	echo idle > /sys/block/zram0/recompress
> > 
> > 2) Since there may be many idle pages user-space may pass a size
> > watermark value (in bytes) and we will recompress IDLE pages only
> > of equal or greater size:
> > 
> > 	echo 888 > /sys/block/zram0/recompress
> 
> Hmm, how about having seperate knob for threshold?

Per-my understanding this threshold can change quite often,
depending on memory pressure and so on. So we may force
user-space to issues more syscalls, without any gain in
simplicity.

> recompress_threshold
> 
> With that, we could make rescompress 888 and idle/huge
> as well as only 888.
> 
>   echo 888 > /sys/block/zram0/recompress_threshold
>   echo 1 > /sys/block/zram0/recompress
> 
>   or
> 
>   echo 888 > /sys/block/zram0/recompress_threshold
>   echo idle > /sys/block/zram0/recompress
> 
> or we can introduce the threshold with action item.
>   
>   echo "idle 888" > /sys/block/zram0/recompress
>   echo "huge 888" > /sys/block/zram0/recompress
>   echo "normal 888" > /sys/block/zram0/recompress

I like the latter one, when threshold is an optional argument.
I probably would even go a bit further and add keywords:

	type=STRING threshold=INT

> > 3) HUGE pages recompression is activated by `huge` mode
> > 
> > 	echo huge > /sys/block/zram0/recompress
> > 
> > 4) HUGE_IDLE pages recompression is activated by `huge_idle` mode
> > 
> > 	echo huge_idle > /sys/block/zram0/recompress
> > 
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  drivers/block/zram/Kconfig    |  15 +++
> >  drivers/block/zram/zram_drv.c | 196 +++++++++++++++++++++++++++++++++-
> >  drivers/block/zram/zram_drv.h |   2 +
> >  3 files changed, 210 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> > index d4100b0c083e..3e00656a6f8a 100644
> > --- a/drivers/block/zram/Kconfig
> > +++ b/drivers/block/zram/Kconfig
> > @@ -78,3 +78,18 @@ config ZRAM_MEMORY_TRACKING
> >  	  /sys/kernel/debug/zram/zramX/block_state.
> >  
> >  	  See Documentation/admin-guide/blockdev/zram.rst for more information.
> > +
> > +config ZRAM_MULTI_COMP
> > +	bool "Enable multiple per-CPU compression streams"
> 
> per-CPU is implementation detail. Let's do not mention it.

OK.

> > +	depends on ZRAM
> > +	help
> > +	This will enable per-CPU multi-compression streams, so that ZRAM
> 
>       indentation

OK. A question: does this matter? I don't see any problems in menuconfig.

> > +	can re-compress IDLE/huge pages, using a potentially slower but
> > +	more effective compression algorithm. Note, that IDLE page support
> > +	requires ZRAM_MEMORY_TRACKING.
> > +
> > +          echo TIMEOUT > /sys/block/zramX/idle
> > +          echo SIZE > /sys/block/zramX/recompress
> > +
> > +	SIZE (in bytes) parameter sets the object size watermark: idle
> > +	objects that are of a smaller size will not get recompressed.
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index 94c62d7ea818..da11560ecf70 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -1282,6 +1282,12 @@ static void zram_free_page(struct zram *zram, size_t index)
> >  		atomic64_dec(&zram->stats.huge_pages);
> >  	}
> >  
> > +	if (zram_test_flag(zram, index, ZRAM_RECOMP))
> > +		zram_clear_flag(zram, index, ZRAM_RECOMP);
> > +
> > +	if (zram_test_flag(zram, index, ZRAM_RECOMP_SKIP))
> > +		zram_clear_flag(zram, index, ZRAM_RECOMP_SKIP);
> 
> Let's squeeze the comp algo index into meta area since we have
> some rooms for the bits. Then can we could remove the specific
> recomp two flags?

What is meta area?

> I am thinking the feature to work incoming pages on the fly,
> not only for recompress manual knob so it would be good
> if we could make the interface abstract to work something
> like this(I may miss something why we couldn't. I need more
> time to look into then)
>
> zram_bvec_write:
> 
>     for (i = 0; i < MAX_COMP_ALGO; i++) {
>         zstrm = zcomp_stream_get(i);
>         zcomp_compress(src, &comp_len);
>         if (comp_len > threshold) {
>             zcomp_stream_put(i);
>             continue;
>         }
>         break;
>     }
> 
> zram_bvec_read:
>     algo_idx = zram_get_algo_idx(zram, index);
>     zstrm = zcomp_stream_get(zram, algo_idx);
>     zcomp_decompress(zstrm);
>     zcomp_stream_put(zram, algo_idx);

Hmm. This is something that should not be enabled by default.
N compressions per every stored page is very very CPU and
power intensive. We definitely want a way to have recompression
as a user-space event, which gives all sorts of flexibility and
extensibility. ZRAM doesn't (and should not) know about too many
things, so ZRAM can't make good decisions (and probably should not
try). User-space can make good decisions on the other hand.

So recompression for us is not something that happens all the time,
unconditionally. It's something that happens sometimes, depending on
the situation on the host.

[..]
> > +static int zram_recompress(struct zram *zram, u32 index, struct page *page,
> > +			   int size_watermark)
> > +{
> > +	unsigned long handle_prev;
> > +	unsigned long handle_next;
> > +	unsigned int comp_len_next;
> > +	unsigned int comp_len_prev;
> 
> How about orig_handle and new_nandle with orig_comp_len and new_comp_len?

No opinion. Can we have prev and next? :)

[..]
> > +	if (sysfs_streq(buf, "idle")) {
> > +		mode = RECOMPRESS_IDLE;
> > +	} else if (sysfs_streq(buf, "huge")) {
> > +		mode = RECOMPRESS_HUGE;
> > +	} else if (sysfs_streq(buf, "huge_idle")) {
> > +		mode = RECOMPRESS_IDLE | RECOMPRESS_HUGE;
> > +	} else {
> > +		/*
> > +		 * We will re-compress only idle objects equal or greater
> > +		 * in size than watermark.
> > +		 */
> > +		ret = kstrtoint(buf, 10, &size_watermark);
> > +		if (ret)
> > +			return ret;
> > +		mode = RECOMPRESS_IDLE;
> > +	}
> > +
> > +	if (size_watermark > PAGE_SIZE)
> 
> nit: How about threshold instead of watermark? 

OK. MM uses watermarks everywhere so I just used the same term.
Can change to threshold.
