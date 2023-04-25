Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC646EDA2A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 04:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjDYCLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 22:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjDYCLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 22:11:22 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9252855AF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:11:21 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-5ef6b757a60so21859586d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1682388680; x=1684980680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=31GKGL4Chauap4mkqxB57XZFtqbK8WX0Lj3IJsC1Zvs=;
        b=CvSd+IRByNeXlJNjFleErJATFEIPmnD0b95GMz4oKHGdCIS5wXfGsjg9HJL+DTpUxq
         sQ58nqZyrw8cpmZ36qKINt90vTAcNXFRZdRJhNbl4x04GThZxhcuzoPhfVgjnrgMlhej
         ZoNfq1qHYmjPRVyROnbC0RfOAWYLaHb/vDifibCBPS0yqVF6R6VgAT/iIcx77356YVA2
         hjr75Ua1OYkgn1FxLESAN5KhngxKg1bj6WjiDW6pu2SYaGejyiLt2V/0glFf++47faWQ
         ploGKDxTQKzMM9aNFLvgL7B/FeVnhgzTfSaevRA8BdpCXReWHVgtyjCnF6gdIWPgWDKu
         noLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682388680; x=1684980680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31GKGL4Chauap4mkqxB57XZFtqbK8WX0Lj3IJsC1Zvs=;
        b=JGYTRALMMKzmXhiR6fhGwtHS/5jirkzm4c2QUvTkxkuc4FwxneznpOah7k/m9vDzmp
         NT+MTFdB601IyaxsQQR0J1RsEBEOfi1ES/Y0Ak+Qj4RBh6KMGclu47PwrW0225jyi/mU
         iCr5EoD/C+rhKejcIlK8SMmh1K58pzd7vGzQ1xHvV4U4vDl+MQsrmnpSr3u2zpa4Z5HQ
         wu9xYX+I/wPHscMIcpdVx6R4TD8OsO7TrXcFUBnpfS0PK6No0PJ5iuRAshSlA3sBEBiO
         +WE8jNP7Lk1P6wOoMjw+8A6gzS+BLAL0ITtYoOiP08FzK+PYSCyd4bWR2soUmUO5l/GW
         Xe2A==
X-Gm-Message-State: AAQBX9dXmcAJGg3Izo+tQQ2lFuhQXTd/ROhHJIbzZfWVo28w+ojYb4mX
        GS+RaaKLIgO7ikkE0m2iSLytgw==
X-Google-Smtp-Source: AKy350ZVkSOWaA+khiuY2NmVVNh4zLLJkkOMbrIrxmy6o68dJ2Zo14koQ2uR3clfpSqTtHHxutekDw==
X-Received: by 2002:a05:6214:21a5:b0:5f1:6892:743b with SMTP id t5-20020a05621421a500b005f16892743bmr23753699qvc.25.1682388680620;
        Mon, 24 Apr 2023 19:11:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:9fc5])
        by smtp.gmail.com with ESMTPSA id y6-20020ae9f406000000b0074d60b697a6sm3997382qkl.12.2023.04.24.19.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 19:11:20 -0700 (PDT)
Date:   Mon, 24 Apr 2023 22:11:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 14/26] mm: compaction: simplify should_compact_retry()
Message-ID: <20230425021119.GA5666@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-15-hannes@cmpxchg.org>
 <87v8hkkcds.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8hkkcds.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:56:47AM +0800, Huang, Ying wrote:
> Johannes Weiner <hannes@cmpxchg.org> writes:
> 
> > The different branches for retry are unnecessarily complicated. There
> > is really only three outcomes: progress, skipped, failed. Also, the
> > retry counter only applies to loops that made progress, move it there.
> >
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/page_alloc.c | 60 +++++++++++++++++--------------------------------
> >  1 file changed, 20 insertions(+), 40 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index c3b7dc479936..18fa2bbba44b 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4608,7 +4608,6 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
> >  		     enum compact_priority *compact_priority,
> >  		     int *compaction_retries)
> >  {
> > -	int max_retries = MAX_COMPACT_RETRIES;
> >  	int min_priority;
> >  	bool ret = false;
> >  	int retries = *compaction_retries;
> > @@ -4621,19 +4620,27 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
> >  		return false;
> >  
> >  	/*
> > -	 * Compaction managed to coalesce some page blocks, but the
> > -	 * allocation failed presumably due to a race. Retry some.
> > +	 * Compaction coalesced some page blocks, but the allocation
> > +	 * failed, presumably due to a race. Retry a few times.
> >  	 */
> > -	if (compact_result == COMPACT_SUCCESS)
> > -		(*compaction_retries)++;
> > +	if (compact_result == COMPACT_SUCCESS) {
> > +		int max_retries = MAX_COMPACT_RETRIES;
> >  
> > -	/*
> > -	 * All zones were scanned completely and still no result. It
> > -	 * doesn't really make much sense to retry except when the
> > -	 * failure could be caused by insufficient priority
> > -	 */
> > -	if (compact_result == COMPACT_COMPLETE)
> > -		goto check_priority;
> > +		/*
> > +		 * !costly requests are much more important than
> > +		 * __GFP_RETRY_MAYFAIL costly ones because they are de
> > +		 * facto nofail and invoke OOM killer to move on while
> > +		 * costly can fail and users are ready to cope with
> > +		 * that. 1/4 retries is rather arbitrary but we would
> > +		 * need much more detailed feedback from compaction to
> > +		 * make a better decision.
> > +		 */
> > +		if (order > PAGE_ALLOC_COSTLY_ORDER)
> > +			max_retries /= 4;
> > +
> > +		ret = ++(*compaction_retries) <= MAX_COMPACT_RETRIES;
>                                                  ~~~~~~~~~~~~~~~~~~~
> 
> Should be max_retries?

Good catch. max_retries is deleted in a later patch, but this one
should be fixed regardless. Thanks, I will correct it.
