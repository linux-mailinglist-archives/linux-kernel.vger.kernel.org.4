Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96495643DF4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiLFIAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLFIAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:00:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA315593;
        Tue,  6 Dec 2022 00:00:15 -0800 (PST)
Date:   Tue, 6 Dec 2022 09:00:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670313613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E1Z9m454oxebSwU8j1D3Js8F7RvRn+TS/GqdCK3hooo=;
        b=FyQJxSH3DQiGYGb+OkB3n5my3UxmPFrB7m2S1DjkNXHHs5414nuxTvAk+oza4KaWRj7w+Y
        indmx29RRgWBQnUBB40QGi86TyzjWj211bTd2M7haGG7NNQkXf7d24ImsaSGCkrjFBptCX
        cv9Hd+bWAbpp4mBFTJCC02cp769JTD6YcVLIY7I5bQXIYUi+nov1zMSzr6+GP2q1KTTr8O
        J64dIBR5ptBijjhjGNDUqAplNFVF4HgVkdDVppw+YmA2WvIziIBxktmp6UnvsRmDmbv8ld
        LmNWmjAQh74+l7qXwIUVoA1d/gSAJ71RBhx9cHIjHVDUbX+fhZKn2lpDXihA4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670313613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E1Z9m454oxebSwU8j1D3Js8F7RvRn+TS/GqdCK3hooo=;
        b=1UULGtv2BOiwDV+6PKDwV3YZmqiT0MDnc5+12x9nWzLYRjn8JWtsJtT1t/fCt7EiNavpYg
        6PTxV4FOpUVU6zCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm/highmem: Add notes about conversions from
 kmap{,_atomic}()
Message-ID: <Y472ipY908pHip+B@linutronix.de>
References: <20221206070029.7342-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221206070029.7342-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-06 08:00:29 [+0100], Fabio M. De Francesco wrote:
> diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
> index 0f731d9196b0..9523e92299f6 100644
> --- a/Documentation/mm/highmem.rst
> +++ b/Documentation/mm/highmem.rst
> @@ -100,10 +101,21 @@ list shows them in order of preference of use.
>    (included in the "Functions" section) for details on how to manage nested
>    mappings.
>  
> -* kmap_atomic().  This permits a very short duration mapping of a single
> -  page.  Since the mapping is restricted to the CPU that issued it, it
> -  performs well, but the issuing task is therefore required to stay on that
> -  CPU until it has finished, lest some other task displace its mappings.
> +* kmap_atomic(). This function has been deprecated; use kmap_local_page().
> +
> +  NOTE: Conversions to kmap_local_page() must take care to follow the mapping
> +  restrictions imposed on kmap_local_page(). Furthermore, code between the
> +  map/unmap operations may implicitly depended on the side effects of
> +  kmap_atomic(), such as disabling pagefaults, migration, and/or preemption.
> +  Such conversions should be changed to make explicit calls for those
> +  requirements.

  Furthermore, code between the kmap_atomic() and kunmap_atomic()
  functions may implicitly depended on the side effects of kmap_atomic()
  namely disabling pagefaults or preemption or both.

> +  [Legacy documentation]
> +
> +  This permits a very short duration mapping of a single page.  Since the
> +  mapping is restricted to the CPU that issued it, it performs well, but
> +  the issuing task is therefore required to stay on that CPU until it has
> +  finished, lest some other task displace its mappings.
>  
>    kmap_atomic() may also be used by interrupt contexts, since it does not
>    sleep and the callers too may not sleep until after kunmap_atomic() is

Sebastian
