Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1C2625FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiKKRDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiKKRDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:03:44 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A69E716D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:03:43 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b11so4925658pjp.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQ/PiPe5gwho9v25N0iUTKiBMu6FKhYwPA8haVZ5Dt0=;
        b=OB9uTHfmmHr/VG/rxH7BKYU1pTokkElGdk6Yag1OTSn9PxKmJP2ncyvb/VCRppc6Fa
         RhvYHslLRRldC08xAu0eUL4ycYW6RvxkzW+AXrO/+1zX3c8uThmV+82aZCl6e+m8TN0A
         1UGGdAtJd0nqEHbzcs8ITVaBqXaqaBnuqIPpXvOV8NacnDY0eOf0Ens3+UrwsCFRfEW8
         jK/mx8w4iix767nLuTJOxwP3XVF+RQ2ExJWkzadSpjVCdL45WLRliIHVQSVgNKT0Jrx2
         g7nv71DSeMTiwOu4DTlPxcl23QzRZD6uKuzJiIUzhJR1LWTRNgBUdUHlqIGtBJBOqbPx
         G97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQ/PiPe5gwho9v25N0iUTKiBMu6FKhYwPA8haVZ5Dt0=;
        b=kvU/IzWKYmVglBBKovnjd51/BvDxuv5lNRIV6DbRoidQL28xJcgx1LAxmT3Dgsf/g1
         M9iatCX8fP8LPoKa6ZMUnWpi96IXnB02aTIJxRwe2QXJosnPjZS9nvmikxcbTA7ONGfH
         lVufcj6hBsHEVS55L0Q/KtuGjLfx5lXLxfCFppoX8NJF1iEWIi1HznSHevDhascO84UJ
         CzdlsrrEL4ZJ4JE8QPJgRasn5cGLPfMd2uaIGnuSUF4D7QMVZe90/sdXKWEzrPp7hy7T
         NTDKxzn2fGrCgQhGIN05bDyqqtgtK/gAuqIYjLexWJMd6AGzNTMb0KzlpgPT1r2IE1Vy
         dPYA==
X-Gm-Message-State: ANoB5pkuERo06ejnyM9yCz8+R9zHOZwrfI4eGRCcpVaLt8MsTIc2IlMa
        abeSEPhIy4EAomDOrDj6VQo=
X-Google-Smtp-Source: AA0mqf5RI+0G2uvs6dAqgHoAJil4DhW1XY3S79lJ5zYnCXqBsWKCbrFs3MoohzULj8CftcSw/vmGqQ==
X-Received: by 2002:a17:90a:5a85:b0:214:6fd:90df with SMTP id n5-20020a17090a5a8500b0021406fd90dfmr2850362pji.35.1668186222885;
        Fri, 11 Nov 2022 09:03:42 -0800 (PST)
Received: from google.com ([2620:15c:211:201:dab:6951:19b1:b46b])
        by smtp.gmail.com with ESMTPSA id j30-20020a63fc1e000000b0045ff216a0casm1574507pgi.3.2022.11.11.09.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 09:03:42 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 11 Nov 2022 09:03:40 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 0/9] zsmalloc/zram: configurable zspage size
Message-ID: <Y26AbHxhPBJdWZQE@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <Y21+xp52OQYi/qjQ@google.com>
 <Y22dxEcs2g5mjuQ7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y22dxEcs2g5mjuQ7@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 09:56:36AM +0900, Sergey Senozhatsky wrote:
> Hi,
> 
> On (22/11/10 14:44), Minchan Kim wrote:
> > On Mon, Oct 31, 2022 at 02:40:59PM +0900, Sergey Senozhatsky wrote:
> > > 	Hello,
> > > 
> > > 	Some use-cases and/or data patterns may benefit from
> > > larger zspages. Currently the limit on the number of physical
> > > pages that are linked into a zspage is hardcoded to 4. Higher
> > > limit changes key characteristics of a number of the size
> > > classes, improving compactness of the pool and redusing the
> > > amount of memory zsmalloc pool uses. More on this in 0002
> > > commit message.
> > 
> > Hi Sergey,
> > 
> > I think the idea that break of fixed subpages in zspage is
> > really good start to optimize further. However, I am worry
> > about introducing per-pool config this stage. How about
> > to introduce just one golden value for the zspage size?
> > order-3 or 4 in Kconfig with keeping default 2?
> 
> Sorry, not sure I'm following. So you want a .config value
> for zspage limit? I really like the sysfs knob, because then
> one may set values on per-device basis (if they have multiple
> zram devices in a system with different data patterns):

Yes, I wanted to have just a global policy to drive zsmalloc smarter
without needing user's big effort to decide right tune value(I thought
the decision process would be quite painful for normal user who don't
have enough resources) since zsmalloc's design makes it possible.
But for the interim solution until we prove no regression, just
provide config and then remove the config later when we add aggressive
zpage compaction(if necessary, please see below) since it's easier to
deprecate syfs knob.

> 
> 	zram0 which is used as a swap device uses, say, 4
> 	zram1 which is vfat block device uses, say, 6
> 	zram2 which is ext4 block device uses, say, 8
> 
> The whole point of the series is that one single value does
> not fit all purposes. There is no silver bullet.

I understand what you want to achieve with per-pool config with exposing
the knob to user but my worry is still how user could decide best fit
since workload is so dynamic. Some groups have enough resouces to practice
under fleet experimental while many others don't so if we really need the
per-pool config step, at least, I'd like to provide default guide to user
in the documentation along with the tunable knobs for experimental.
Maybe, we can suggest 4 for swap case and 8 for fs case.

I don't disagree the sysfs knobs for use cases but can't we deal with the
issue better way?

In general, the bigger pages_per_zspage, the more memory saving. It would
be same with slab_order in slab allocator but slab has the limit due to
high-order allocation cost and internal fragmentation with bigger order
size slab. However, zsmalloc is different in that it doesn't expose memory
address directly and it knows when the object is accessed by user. And
it doesn't need high-order allocation, either. That's how zsmalloc could
support object migration and page migration. With those features, theoretically,
zsmalloc doesn't need limitation of the pages_per_zspage so I am looking
forward to seeing zsmalloc handles the memory fragmentation problem better way.

Only concern with bigger pages_per_zspage(e.g., 8 or 16) is exhausting memory
when zram is used for swap. The use case aims to help memory pressure but the
worst case, the bigger pages_per_zspage, more chance to out of memory.
However, we could bound the worst case memory consumption up to

for class in classes:
    wasted_bytes += class->pages_per_zspage * PAGE_SIZE - an object size

with *aggressive zpage compaction*. Now, we are relying on shrinker
(it might be already enough) to trigger but we could change the policy 
wasted memory in the class size crossed a threshold we defind for zram fs
usecase since it would be used without memory pressure.

What do you think about?
