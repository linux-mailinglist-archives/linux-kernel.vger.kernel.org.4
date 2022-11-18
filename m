Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A6562FF66
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiKRVfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiKRVfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:35:04 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F119594A7D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:35:03 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 140so6071260pfz.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlURkaIkyM/L0R6Qo7JiH0N7DN4WgUDEtFjAiaM+3Hg=;
        b=E+89iQFvWsm/dYStxTy1p50NxPbkEC21OJNKdRLnYxscmnzr4o8jee0C56/8hbFFbx
         latrROfoVCq7eJ+CowWUBxEbWfb+9QAYjQ7lnhRgNTAXHdOGcBU860ocmVIsA2dgjx9P
         hclBlWxQoLoJg+7BxHe6oNXNz5WyoIU1jx6BXNhVf5qf5f/7s6vQkE0bu2Zj54GJx1GE
         AAN1wkqT4hUK2yd/h1lFeyZGMbUkmWt+fK5JkbR5x6VQk8gqHmzTDjPwhV22wxFwvou1
         Q3MSU7xXHJrZyGPnU0tyRIhg1r/xLbWGgyUj0WjLuCo6j1vgLzK+rtZfd1TVbvylMZCq
         oOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlURkaIkyM/L0R6Qo7JiH0N7DN4WgUDEtFjAiaM+3Hg=;
        b=byfPY82/YC75LCbLBCxUSmE/GbasjAVA3MDdzLPfBCHHM3u/WNVnB7Xvg5+VOiFRWg
         Z9O0qE6rh2le7DZ64aB0N2eVwjquipcGQOnX0fmp7Th0JwICx/WO8d3uK/+TP5F/wK99
         1xKmKZ0UU2z1oa1tIWmSYxZirdxc2xXmnHxaVa2AYlmA4S2XvGB5ycun9Fpdu45A+5b0
         l6NrOa00J0TobMpC2wTrp1LVsNy6gzTYNbJR2LFDC7gc8czzGE0v+6ITRy9ZZHQUATA9
         hDHyQoejTo7MPi3U3L98zV9wX3360JxiMHY7XdbTIVB/O8EyNLjiZYbjA3rrpPlOcDRP
         GipQ==
X-Gm-Message-State: ANoB5plYZqpD6r8gKF38A/8pvG5/QWu6xf+SO8uFO5Jef48IMIr3PJHg
        tdt+nt5vHQeN0MBX+e2Xia0=
X-Google-Smtp-Source: AA0mqf7b+VUxMrDj2BqA4zvdsg4N/uHejeliIhBO/+a501WGCoOxiSV93/5vTCyi9XVd3o9u08eF5A==
X-Received: by 2002:a62:19c8:0:b0:56b:f390:36f with SMTP id 191-20020a6219c8000000b0056bf390036fmr9852779pfz.2.1668807303411;
        Fri, 18 Nov 2022 13:35:03 -0800 (PST)
Received: from google.com ([2620:15c:211:201:bba9:9f92:b2cc:16a4])
        by smtp.gmail.com with ESMTPSA id g24-20020aa796b8000000b0056c814a501dsm3774521pfk.10.2022.11.18.13.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 13:35:03 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 18 Nov 2022 13:35:01 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v5 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y3f6habiVuV9LMcu@google.com>
References: <20221118182407.82548-1-nphamcs@gmail.com>
 <20221118182407.82548-5-nphamcs@gmail.com>
 <Y3fdsTDFgCzhcDwo@google.com>
 <Y3flcAXNxxrvy3ZH@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3flcAXNxxrvy3ZH@cmpxchg.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 03:05:04PM -0500, Johannes Weiner wrote:
> On Fri, Nov 18, 2022 at 11:32:01AM -0800, Minchan Kim wrote:
> > On Fri, Nov 18, 2022 at 10:24:05AM -0800, Nhat Pham wrote:
> > > @@ -1444,6 +1473,11 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> > > 
> > >  	/* We completely set up zspage so mark them as movable */
> > >  	SetZsPageMovable(pool, zspage);
> > > +out:
> > > +#ifdef CONFIG_ZPOOL
> > > +	/* Move the zspage to front of pool's LRU */
> > > +	move_to_front(pool, zspage);
> > > +#endif
> > >  	spin_unlock(&pool->lock);
> > 
> > Please move the move_to_front into zs_map_object with ZS_MM_WO with
> > comment with "why we are doing only for WO case".
> 
> I replied to the other thread, but I disagree with this request.
> 
> The WO exception would be as zswap-specific as is the
> rotate-on-alloc. It doesn't make the resulting zsmalloc code any

That's true but at least, zs_pool allocators have the accessor so
that's fair place to have the LRU updating. I guess that's why
you agreed that's better place. No?

I understand that's zswap-specific that the bad design keeps
pushing smelly code into allocators and then "push to take it
since other were already doing" with "we will take them off with
better solution in future". I am really struggling to understand
this concept. Johannes, Is that really how we work over a decade?

> cleaner or more generic, just weird in a slightly different way.
> 
> On the other hand, it makes zsmalloc deviate from the other backends
> and introduces new callchains that invalidate thousands of machine
> hours of production testing of this code.

Do you really believe the trival change makes invalidates
the testing?

        ret = zpool_malloc(entry->pool->zpool, hlen + dlen, gfp, &handle);
        if (ret == -ENOSPC) {
                zswap_reject_compress_poor++;
                goto put_dstmem;
        }
        if (ret) {
                zswap_reject_alloc_fail++;
                goto put_dstmem;
        }
        buf = zpool_map_handle(entry->pool->zpool, handle, ZPOOL_MM_WO);
        memcpy(buf, &zhdr, hlen);
        memcpy(buf + hlen, dst, dlen);
        zpool_unmap_handle(entry->pool->zpool, handle);

