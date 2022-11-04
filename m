Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56516618F42
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiKDDsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiKDDst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:48:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61EEBF7D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 20:48:47 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id k7so3786734pll.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 20:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4RE+X/RkKiDS4AJLCzo53ynRp9BFAN/2PAvOPFZNf/s=;
        b=aG8LOTs19ztLgbIkoVWI31xW7AfJ4agzyU0E8fQtCtCNU46tWTjOSoHXEj9jSpQS/b
         PHtfEUPnKFOFnvqGWgaU0T1Psw+71JEhSTh6n5/ewDLa3bEpMcfy5E3e6D2WC5yfrVTU
         tZjLF+iwUHeCxK4NyHD0uAOotmz+rddWcUQTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RE+X/RkKiDS4AJLCzo53ynRp9BFAN/2PAvOPFZNf/s=;
        b=kqsOZen3jFSQsQJLeMK/kuAhMwY63FhdBdptG/Uuvakmicen5caO1am5iTPEvZMXn+
         C0BneaoM8tgsU/qk3Ih5qlDAGw+lsqvQEAZ6r/ylk5wyj2Kkn8/beIF8DRi7r3FofmsU
         4F9VGQbCgFmMpuu4L5jWzV/ubqHYbOV6UJyPgz8Ixt503MDB5igHjdCYR6owI751epIz
         uxSWUQkoXifq9ezmPQrfHaCmUmqn7IMNYzR164aTIUTtYdeX6ygsTIVrGXJfMIm8xAHl
         GJrJNZyH9mHjFuakn2tQPjs493jErAYfKTbEIGom0a7P0TJc/TtvBNB6UG3TuongCO/s
         eIzw==
X-Gm-Message-State: ACrzQf0EVsLX8rdOnooxlPmF5C6xkJpK+HOYddwmSj3WkER58+R3BejE
        rFUJ7ZeSxJ4LON9N7rIXXhNGSA==
X-Google-Smtp-Source: AMsMyM46EYkxamSkq+8PpxCgcioaFJWUezswYOfb3hsyxkoNF9n/hHcoODXErjUaAzdT+vhxUwaccQ==
X-Received: by 2002:a17:902:d64e:b0:186:91fa:59cc with SMTP id y14-20020a170902d64e00b0018691fa59ccmr249426plh.44.1667533727268;
        Thu, 03 Nov 2022 20:48:47 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f2f6:8f5:87c8:3aeb])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00186616b8fbasm1513242plg.10.2022.11.03.20.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:48:46 -0700 (PDT)
Date:   Fri, 4 Nov 2022 12:48:42 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 4/9] zram: Introduce recompress sysfs knob
Message-ID: <Y2SLmuxLy8tf1X9m@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-5-senozhatsky@chromium.org>
 <Y2Lbxp6to4QNYyGe@google.com>
 <Y2M0t5etyJiUfeQi@google.com>
 <Y2PzseskzPelrZum@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2PzseskzPelrZum@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/03 10:00), Minchan Kim wrote:
[..]
> > Per-my understanding this threshold can change quite often,
> > depending on memory pressure and so on. So we may force
> > user-space to issues more syscalls, without any gain in
> > simplicity.
> 
> Sorry, didn't understand your point. Let me clarify my idea.
> If we have separate knob for recompress thresh hold, we could
> work like this.
> 
> # recompress any compressed pages which is greater than 888 bytes.
> echo 888 > /sys/block/zram0/recompress_threshold
> 
> # try to compress any pages greather than threshold with following
> # algorithm.
> 
> echo "type=lzo priority=1" > /sys/block/zram0/recompress_algo
> echo "type=zstd priority=2" > /sys/block/zram0/recompress_algo
> echo "type=deflate priority=3" > /sys/block/zram0/recompress_algo

OK. We can always add more sysfs knobs and make threshold a global
per-device value.

I think I prefer the approach when threshold is part of the current
recompress context, not something derived form another context. That
is, when all values (page type, threshold, possibly algorithm index)
are submitted by user-space for this particular recompression

	echo "type=huge threshold=3000 ..." > recompress

If threshold is a global value that is applied to all recompress calls
then how does user-space say no-threshold? For instance, when it wants
to recompress only huge pages. It probably still needs to supply something
like threshold=0. So my personal preference for now - keep threshold
as a context dependent value.

Another thing that I like about threshold= being context dependent
is that then we don't need to protect recompression against concurrent
global threshold modifications with lock and so on. It keeps things
simpler.

[..]
> > > Let's squeeze the comp algo index into meta area since we have
> > > some rooms for the bits. Then can we could remove the specific
> > > recomp two flags?
> > 
> > What is meta area?
> 
> zram->table[index].flags
> 
> If we squeeze the algorithm index, we could work like this
> without ZRAM_RECOMP_SKIP.

We still need ZRAM_RECOMP_SKIP. Recompression may fail to compress
object further: sometimes we can get recompressed object that is larger
than the original one, sometimes of the same size, sometimes of a smaller
size but still belonging to the same size class, which doesn't save us
any memory. Without ZRAM_RECOMP_SKIP we will continue re-compressing
objects that are in-compressible (in a way that saves us memory in
zsmalloc) by any of the ZRAM's algorithms.

> read_block_state
>     zram_algo_idx(zram, index) > 0 ? 'r' : '.');
> 
> zram_read_from_zpool
>     if (zram_algo_idx(zram, idx) != 0)
>         idx = 1;

As an idea, maybe we can store everything re-compression related
in a dedicated meta field? SKIP flag, algorithm ID, etc.

We don't have too many bits left in ->flags on 32-bit systems. We
currently probably need at least 3 bits - one for RECOMP_SKIP and at
least 2 for algorithm ID. 2 bits for algorithm ID put us into situation
that we can have only 00, 01, 10, 11 as IDs, that is maximum 3 recompress
algorithms: 00 is the primary one and the rest are alternative ones.
Maximum 3 re-compression algorithms sounds like a reasonable max value to
me. Yeah, maybe we can use flags bits for it.

[..]
> > > zram_bvec_read:
> > >     algo_idx = zram_get_algo_idx(zram, index);
> > >     zstrm = zcomp_stream_get(zram, algo_idx);
> > >     zcomp_decompress(zstrm);
> > >     zcomp_stream_put(zram, algo_idx);
> > 
> > Hmm. This is something that should not be enabled by default.
> 
> Exactly. I don't mean to enable by default, either.

OK.

> > N compressions per every stored page is very very CPU and
> > power intensive. We definitely want a way to have recompression
> > as a user-space event, which gives all sorts of flexibility and
> > extensibility. ZRAM doesn't (and should not) know about too many
> > things, so ZRAM can't make good decisions (and probably should not
> > try). User-space can make good decisions on the other hand.
> > 
> > So recompression for us is not something that happens all the time,
> > unconditionally. It's something that happens sometimes, depending on
> > the situation on the host.
> 
> Totally agree. I am not saying we should enable the feature by default
> but at lesat consider it for the future. I have something in mind to
> be useful later.

OK.

> > [..]
> > > > +static int zram_recompress(struct zram *zram, u32 index, struct page *page,
> > > > +			   int size_watermark)
> > > > +{
> > > > +	unsigned long handle_prev;
> > > > +	unsigned long handle_next;
> > > > +	unsigned int comp_len_next;
> > > > +	unsigned int comp_len_prev;
> > > 
> > > How about orig_handle and new_nandle with orig_comp_len and new_comp_len?
> > 
> > No opinion. Can we have prev and next? :)
> 
> prev and next gives the impression position something like list.
> orig and new gives the impression stale and fresh.
> 
> We are doing latter here.

Yeah, like I said in internal email, this will make rebasing harder on
my side, because this breaks a patch from Alexey and then breaks a higher
order zspages patch series. It's an very old series and we already have
quite a bit of patches depending on it.
