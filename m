Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3B8633512
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 07:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiKVGIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 01:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiKVGIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:08:42 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF7427FD1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 22:08:39 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id l15so8720271qtv.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 22:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xFskJ0PAbtgFIfn0uL3HVp5AGazR7CNgIuFH1JnZjto=;
        b=rw8NlRyuGxY6d5ZNpzVhw9cBBb4EMOWfLG8jrdsZw8IjevwHWns1Yz190g+2obWupB
         Q6BWJCPtrgxPlIujgeEWC7uFYltzkXhkFf+OMGxDrtq4v/jdNVTOiPhbL3TVGieWOS/z
         CQPER3TvXJVG+gv7LWLDLlbwrKUfENrDxBZM6lnkqrDlloWNrAZy2/QIqDj/82CWf2pl
         wlbDPw7QAMLTMBG+nsdnsxY5TPlBBcu6WdbGBdWEvxhCD/fY1kB6QfPJH+3bhqb52xY/
         1Wb+NctFMyUrrNuP3SDJ/JUHgILeZt4QeTChICBQl0+Fejm2v9np6m+4X+GMAZ97jCfd
         1TNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFskJ0PAbtgFIfn0uL3HVp5AGazR7CNgIuFH1JnZjto=;
        b=iDJPUVlku3WB4/YbC/EhrUSVanA+1kGY1hHPgOTau2A8D39icyKp6BNWjiw1H3ExRo
         gDVoXCjB7ehghezVa3YHE5hZhSEWjZqUZ6rPmzMvu8NwfHQfxlEisj80GkHHVgLb9uza
         SPzNzJNlv6TL5NvnBBY8OkwXjuN/NRE+AFlpmm4FKS6w+PnbdDjXieEm+ph0/V+tNKox
         A0e8EFAENga1zQLG9uVO+3gChBPQunXfISP/D/2iajDU7D5yHF7LSzlYFUxmtXBWwJQ3
         EAhZmx2opn4DGD+sq0KDZNdRkw1br8M4XPsjnQWn3HUNsv72BPWU2TugC6jnfP/OH/U4
         xhEw==
X-Gm-Message-State: ANoB5pktk3B4ejcEy3h3H4AeHWrUegiiSBS4ISQKCp+K6vg32qs0TBcY
        4MGykmjl/XQ+fu3tKb0P6aMy3Q==
X-Google-Smtp-Source: AA0mqf4MZyaRJuzNrsDcm7X9RlEVW6mYtPTQ5B8PULH/VPf6LbOJnZurhwxZDwAYGl+JeG7R7LfThQ==
X-Received: by 2002:ac8:7447:0:b0:3a5:75dc:ed0a with SMTP id h7-20020ac87447000000b003a575dced0amr2262440qtr.329.1669097318535;
        Mon, 21 Nov 2022 22:08:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a084c00b006ee949b8051sm9235671qku.51.2022.11.21.22.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 22:08:38 -0800 (PST)
Date:   Tue, 22 Nov 2022 01:09:03 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y3xnf7pR4vI7o9PV@cmpxchg.org>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-7-nphamcs@gmail.com>
 <Y3wwuMSy8YC86QAi@google.com>
 <Y3w+C8ClzP6VbqrA@cmpxchg.org>
 <Y3xFHIgkiZNYCbHi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3xFHIgkiZNYCbHi@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 12:42:20PM +0900, Sergey Senozhatsky wrote:
> On (22/11/21 22:12), Johannes Weiner wrote:
> > On Tue, Nov 22, 2022 at 11:15:20AM +0900, Sergey Senozhatsky wrote:
> > > On (22/11/18 16:15), Nhat Pham wrote:
> > > > +
> > > > +static int zs_zpool_shrink(void *pool, unsigned int pages,
> > > > +			unsigned int *reclaimed)
> > > > +{
> > > > +	unsigned int total = 0;
> > > > +	int ret = -EINVAL;
> > > > +
> > > > +	while (total < pages) {
> > > > +		ret = zs_reclaim_page(pool, 8);
> > > > +		if (ret < 0)
> > > > +			break;
> > > > +		total++;
> > > > +	}
> > > > +
> > > > +	if (reclaimed)
> > > > +		*reclaimed = total;
> > > > +
> > > > +	return ret;
> > > > +}
> > > 
> > > A silly question: why do we need a retry loop in zs_reclaim_page()?
> > 
> > Individual objects in a zspage can be busy (swapped in simultaneously
> > for example), which will prevent the zspage from being freed. Zswap
> > currently requests reclaim of one backend page at a time (another
> > project...), so if we don't retry we're not meeting the reclaim goal
> > and cause rejections for new stores.
> 
> What I meant was: if zs_reclaim_page() makes only partial progress
> with the current LRU tail zspage and returns -EAGAIN, then we just
> don't increment `total` and continue looping in zs_zpool_shrink().

Hm, but it breaks on -EAGAIN, it doesn't continue.

This makes sense, IMO. zs_reclaim_page() will try to reclaim one page,
but considers up to 8 LRU tail pages until one succeeds. If it does,
it continues (total++). But if one of these calls fails, we exit the
loop, give up and return failure from zs_zpool_shrink().
