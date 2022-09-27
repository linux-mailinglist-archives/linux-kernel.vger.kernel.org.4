Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8395EC60B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiI0O2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiI0O23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:28:29 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16988EFA70
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:28:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso10253995pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=7fxxodm6Uc10NCATntYEYAoIWbFhWooHWpZkEhM0U3o=;
        b=C4nNDQj2shmROWVpH9DekLDwM2qKZFQL+yqsJ9MDkb3cdATbmDVXj/Mp3orWEdFyFA
         ESLTAO/deZLerJfwPV9WNMILLW+nL8nCRCDHkJTYrpe/B7z7O9SsrR0716+hlbkWSrfl
         TBP4wK9msxRroKNnjdOqiaBeZvRC0a/LB1c9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7fxxodm6Uc10NCATntYEYAoIWbFhWooHWpZkEhM0U3o=;
        b=Buie0lh4YLiUspJIkgBW+0AtaCDmFYeICdJIg+WdiwzlfJtJEP4aNNl0j7wDcvgdnW
         JzGQuBBrnpz6GFVBIRqi8aRJq3ds9bRl7KVd14J9syeeZEAcPlSNJsJs5V1nXn5BWajE
         3fkHv8JL0hD+Fc7ExjHNs7yW4FaIrV8AfRsu56cZtfUhCgWleaP7rOdvkjH6h/N3z1tG
         bPlZiWTFgp/LSfW4yHmy2djYw3vAVrPg2OUhDaZE1UoocMTZRRAfh9o5BzQehznY478n
         4VOTFW8Ur9MefwlL9PrViGMzsvaZmRU7oGc/7eHryNCNO1mnQQyf/8BGftuM161Azu3u
         h1TQ==
X-Gm-Message-State: ACrzQf30qiWc3vFjzlHw/55ZVET4YQwReIt2b23loh2CeVO/Y7++Y8kQ
        aqG3jwoR5w+Cde5c8IeF3zCBy2NsH8DPeA==
X-Google-Smtp-Source: AMsMyM6y5feYrRzbOlXq4mkoZYG+cqyH/FHaKfjFhGb9yCqaskz0NaWpYM9/ehN/59rF4f3XrkSI8Q==
X-Received: by 2002:a17:903:1c3:b0:177:ef4b:c614 with SMTP id e3-20020a17090301c300b00177ef4bc614mr27253993plh.17.1664288907594;
        Tue, 27 Sep 2022 07:28:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j11-20020a63550b000000b004388ba7e5a9sm1585432pgb.49.2022.09.27.07.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:28:26 -0700 (PDT)
Date:   Tue, 27 Sep 2022 07:28:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v3] random: split initialization into early step and
 later step
Message-ID: <202209270728.5FE3CB0@keescook>
References: <CAHmME9q3w1XHyS5QpyW79xK9xjnZmzyBr-Pk3QOsp=mJ_Loauw@mail.gmail.com>
 <20220927110957.1620347-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927110957.1620347-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 01:09:57PM +0200, Jason A. Donenfeld wrote:
> The full RNG initialization relies on some timestamps, made possible
> with general functions like time_init() and timekeeping_init(). However,
> these are only available rather late in initialization. Meanwhile, other
> things, such as memory allocator functions, make use of the RNG much
> earlier.
> 
> So split RNG initialization into two phases. We can give arch randomness
> very early on, and then later, after timekeeping and such are available,
> initialize the rest.
> 
> This ensures that, for example, slabs are properly randomized if RDRAND
> is available. Without this, CONFIG_SLAB_FREELIST_RANDOM=y loses a degree
> of its security, because its random seed is potentially deterministic,
> since it hasn't yet incorporated RDRAND. It also makes it possible to
> use a better seed in kfence, which currently relies on only the cycle
> counter.
> 
> Another positive consequence is that on systems with RDRAND, running
> with CONFIG_WARN_ALL_UNSEEDED_RANDOM=y results in no warnings at all.
> 
> One subtle side effect of this change is that on systems with no RDRAND,
> RDTSC is now only queried by random_init() once, committing the moment
> of the function call, instead of multiple times as before. This is
> intentional, as the multiple RDTSCs in a loop before weren't
> accomplishing very much, with jitter being better provided by
> try_to_generate_entropy(). Plus, filling blocks with RDTSC is still
> being done in extract_entropy(), which is necessarily called before
> random bytes are served anyway.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks for the updates!

-- 
Kees Cook
