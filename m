Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A19E625868
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiKKKc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiKKKcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:32:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3008D9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:32:49 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h14so4098398pjv.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fy5PQnQnZm5cRZ5qG1YNPYJdeovnXsDVIy0x21AyY8o=;
        b=PH+k/rdgrWBzPBRNudaM5JiBpiCBfD1gWgQoB6IYO8qJwTyO9sNuRZ3p9yU+KQ/SoZ
         FCFRsX4JqsfBpgp8PWYUih886qdD7FM2MZ2DermrWmOwcSl0HxDR/H8h3KNy2S9aRkY9
         TlzPYcaX1WHy+mbtF/ee/4QwZnSigSwSiYosU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fy5PQnQnZm5cRZ5qG1YNPYJdeovnXsDVIy0x21AyY8o=;
        b=31UbfZkATkXOjBDabg0ZfxNlWdfRRv3FBlMy4D9R+2e+LEQ6PkDy/bignXKnAd1ydI
         VT/+QhkHELbQPEljGJW3PAIq5Hmfdy6WwIOU3/5dRVgzXDacvrI/Uyt7E6Tu25juaEPr
         HAG9qPV+JmZmO0sLtCqJks3SwfQFztxAig5cgVz02Cwhf9mlkzLZy6mMYpkfPt9IPc5d
         +iZkBMf6J+23dss5IGx1OKJD4L5GD+haVgz7yY7MIBIGLmt5R+ZCFzu9YcyWITXRM2GM
         pqwyEMPluhc8cqP5JC9e5jwBtzYKvGJ56lE/JSMef61qcFDu/roHx8hoK6766Yb9Xp9s
         ZXMw==
X-Gm-Message-State: ANoB5pkQEPn8DW8PXc/GN4U/tJDXVj1wnVy4A6DfiQ5PMBjmo6wLE36h
        u7/8/Y/5K1jCAcQDGFCCJDUonOfdtvB9sg==
X-Google-Smtp-Source: AA0mqf49E5wRB42wtD/3QvEvnKyw6j+BzHVe45JiCWYFPzfxUPZqNAtrqGNGJyvuQCbGZuF/apG27g==
X-Received: by 2002:a17:90a:73cf:b0:213:7f5:a972 with SMTP id n15-20020a17090a73cf00b0021307f5a972mr1249702pjk.159.1668162769401;
        Fri, 11 Nov 2022 02:32:49 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d55:c60d:579d:741c])
        by smtp.gmail.com with ESMTPSA id x125-20020a626383000000b00560bb4a57f7sm1287402pfb.179.2022.11.11.02.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 02:32:48 -0800 (PST)
Date:   Fri, 11 Nov 2022 19:32:44 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 6/9] zsmalloc: pass limit on pages per-zspage to
 zs_create_pool()
Message-ID: <Y24kzGHyjY9G0d7T@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <20221031054108.541190-7-senozhatsky@chromium.org>
 <Y22vGNX0yGaAeoDR@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y22vGNX0yGaAeoDR@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/10 18:10), Minchan Kim wrote:
> On Mon, Oct 31, 2022 at 02:41:05PM +0900, Sergey Senozhatsky wrote:
> > Allow zsmalloc pool owner to specify max number of pages
> > per-zspage (during pool creation), so that different pools
> > can have different characteristics.
> > 
> > By default we pass ZS_DEFAULT_PAGES_PER_ZSPAGE which is 4
> > (matches the current order 2 zspages limit).
> 
> How could user decide what's the best size for their workload?

[..]

For starters in a similar manner that I showed during our meeting.
They can run tests, gather stats (zsmalloc objects distribution),
analyze where most of the objects sit, how things change when we
have different cluster configurations, and so on.

But more importantly: they need lots of zramX mm_stat data, which is
perfectly traceable and collectable during fleet A/B testing: when a
number of devices get randomly assigned to different experiments and
receive different zspage len configuration, which they feed to zram
sysfs knobs during system startup (when init script configures zram).
And then look at statistically significant improvements or regressions.

This is how things done in ChromeOS and I'm sure in many other places.

In this regard, finding best zspage len value is not any different from
finding what is the best zram disksize, or what is the best compression
algorithm. Exactly same approach - feed different configuration to devices
and then analyze the data. Look at mm_stat-s before and after experiment,
per device class/type.

We can discuss in more details internally.

> >  static void zs_zpool_destroy(void *pool)
> > @@ -2195,6 +2195,7 @@ static int zs_register_shrinker(struct zs_pool *pool)
> >  /**
> >   * zs_create_pool - Creates an allocation pool to work from.
> >   * @name: pool name to be created
> > + * @num_pages: maximum number of pages per-zspage
> 
> How about "max_page_chain:"? 

OK.

Do you dislike idea of creating a `struct zs_tunables` which will hold
all fields that we can tune? And then zsmalloc users can pass that
struct (a pointer to) to zs_create_pool().

There can be various tunables. Like policy changes: do we use static
zspool configuration, or a dynamic one and so on.

On zram side, we can have a generic sysfs knob: allocator_tuning,
which will accept named params, the same way we did it for
recomp_algorithm and recompress.

	echo "tuneable=VAL tunealbe=VAL" > /sys/block/zramX/allocator_tuning
