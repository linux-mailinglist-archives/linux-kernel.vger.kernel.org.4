Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F301714E92
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjE2Qik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjE2Qii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:38:38 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A5A109
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:38:11 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75affb4d0f9so187671485a.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685378287; x=1687970287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5+bYmjm/h3lSQb6YeDlPhS20QMHi1e0gJPfH5ZggpcM=;
        b=VjcnSTm21NLYuq3Hsb35yyozR88wKTebBbs9dHpvp+dCIlp6iyJHyLrsRWU6vvrkbG
         4gAZcuffjQMzN6ybk3oKLBN9Z/z5P5KXbhxpkTMi9gzG/fJsJEUH4QCeKw3+ykIJr/l+
         X1Eg5LdU/NffGKk4gHN066XjQiqD4YOcxktk+v5ofHaJ2DhiV3/zuawItrLKWvtvVJL2
         kQQ0D/R1LkeiRtRfKLwblI/Hj1DjpRVbHsYa/xUVQpGcwyX186+67q2SrcoIwgFVYjUw
         vMjdmkk99MGrvDd+ZIl3wTn64jx8aypK/3q4Cx+RWIMxyHSk2S8GiCQM71IIuRA7D1p2
         GvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685378287; x=1687970287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+bYmjm/h3lSQb6YeDlPhS20QMHi1e0gJPfH5ZggpcM=;
        b=ZqF44m5WIChL/rzi8+7cV8bqEYxp2uHXZnfSp9AIAQmFV2DzJktYuT32v6UuazzGeC
         jeu52aPx/2vwhpJGTXET/QbVFHo6xuAr4sUVxXyKDg6pDw0YDF1v+P73n3+6fAdyNC5n
         FkWOXeO3CWC0gQTe7H89TcWyytzQpkhQeRQ0UDKW/opNE/49o/DAlIHGKvz1bS86iE3x
         DDzUIuQJLF3zQWnYKb6mKTXAtezT+ytrvMtALSKl1Nl44wi6PWL06kJYEGmrIhsNOMUQ
         vDgjmNMa8ZOIjUc0MDbnnLXSebm5z3Ki7T+zizf8qVRcJ4zEswCa0uyp00FrBC0e+dpo
         ATWg==
X-Gm-Message-State: AC+VfDzGr+FqGsO8YY0o0rwV+wbePrKCZX10yaUPIPQuTeKwEdyNaFlZ
        XrZQNr0ucpqC6HYMXZ8L3whLSb4xaIhyBLMBHi8=
X-Google-Smtp-Source: ACHHUZ7eFEKc4LAfBL2BydTImTW8cO2OyoprqG9Z/iSmHb1f4gXFTT1bFTyReeN1fL6F2fzQ2sGpvA==
X-Received: by 2002:a05:620a:1b92:b0:75b:23a0:e7d9 with SMTP id dv18-20020a05620a1b9200b0075b23a0e7d9mr8117975qkb.58.1685378286917;
        Mon, 29 May 2023 09:38:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8bb6])
        by smtp.gmail.com with ESMTPSA id y23-20020a37e317000000b00759495bb52fsm3450186qki.39.2023.05.29.09.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 09:38:06 -0700 (PDT)
Date:   Mon, 29 May 2023 12:38:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/5] mm: compaction: simplify should_compact_retry()
Message-ID: <20230529163805.GA84971@cmpxchg.org>
References: <20230519123959.77335-1-hannes@cmpxchg.org>
 <20230519123959.77335-3-hannes@cmpxchg.org>
 <1c3c9305-a678-279e-f015-7aed544ab3c8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c3c9305-a678-279e-f015-7aed544ab3c8@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 03:03:52PM +0200, Vlastimil Babka wrote:
> On 5/19/23 14:39, Johannes Weiner wrote:
> > The different branches for retry are unnecessarily complicated. There
> > are really only three outcomes: progress (retry n times), skipped
> > (retry if reclaim can help), failed (retry with higher priority).
> > 
> > Rearrange the branches and the retry counter to make it simpler.
> > 
> > v2:
> > - fix trace point build (Mel)
> > - fix max_retries logic for costly allocs (Huang)
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/page_alloc.c | 53 +++++++++++++++----------------------------------
> >  1 file changed, 16 insertions(+), 37 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 5a84a0bebc37..72660e924b95 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3772,16 +3772,22 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
> >  	 * Compaction managed to coalesce some page blocks, but the
> >  	 * allocation failed presumably due to a race. Retry some.
> >  	 */
> > -	if (compact_result == COMPACT_SUCCESS)
> > -		(*compaction_retries)++;
> > +	if (compact_result == COMPACT_SUCCESS) {
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
> >  
> > -	/*
> > -	 * All zones were scanned completely and still no result. It
> > -	 * doesn't really make much sense to retry except when the
> > -	 * failure could be caused by insufficient priority
> > -	 */
> > -	if (compact_result == COMPACT_COMPLETE)
> > -		goto check_priority;
> > +		ret = ++(*compaction_retries) <= max_retries;
> > +		goto out;
> 
> I think you simplified this part too much, so now once it runs out of
> retries, it will return false, while previously it would increase the priority.

Oops, I'll send a delta fix to Andrew tomorrow. Thanks!
