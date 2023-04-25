Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4536EDA34
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 04:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjDYCQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 22:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDYCQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 22:16:01 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69121A249
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:16:00 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3ef3887e3c0so22273751cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1682388959; x=1684980959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3CUi8Pu2aq3PZJRR6Wmf7E6lNE8E6L2aFBDpceT4KFs=;
        b=m2OuU8z6lXuImyl6itdLMAK9t4leD5YS4aq2+/YRI09MklwI98oBG9WDJoN/meMbNB
         eXdMPeb70Hyf0Kus4sor21h3pwJdOI4uU/xQbuydlx4t4C9pCoOidXyfSrODYtWhSz4x
         I3ZyMIZQezTs4wqX8+fHlJKKAMmciZ4FOW7A3GCT5e+N7pML/L56xxy/Qc6oM76Wh7zQ
         POYWwVViWSYTJig7BlcY8Gtji4T3hG3BeIPajyITtxA2ZKt0Neg+3cGXqlXGHnleM7gG
         USp3aD4UYLhUYIXvCX/cD+ys/zRWcsqM+r0HzK1Gkgb65TOzlcgKqSjWLoe/Lk5Gm8kM
         27og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682388959; x=1684980959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CUi8Pu2aq3PZJRR6Wmf7E6lNE8E6L2aFBDpceT4KFs=;
        b=FDF0jddRVrzuws4/xUsEQQw5QNWzoAG0u94Aakz+JdUgI5DBI55XJ/5IcZhE81JByG
         vqA+rqZl8ji08xGJ1xYST1vPZ5Pep8fKxjkm3fXkxdQEjaILmKKv5ofeeox4wQqKwlNH
         6P2fjakHPK9SGgifGBWceZDaA1gz27h+SHSHri2Kz3yImFBgq7TX37A9cigd6Z4tF/Pa
         /V63R1pV5kOpVzoM+KtBsf6eZkSp5HZr2Nf/4fau09XXqTxOdyhDHvZX/9mMBAi8pviY
         7XeEvL7RpDZQniJS1eVNvsykpyuU2Zs0OL9/6K4ac2TCsglsQPOLMdEzhs6JztANxM+1
         /XQA==
X-Gm-Message-State: AAQBX9dbAvVhGM3HCnagrBB4mpUZjQ/bmp/+M8L/+w+XiHLHw2WZ2evx
        BY9VlMGqA22/U4q7mNlqUH7RdQ==
X-Google-Smtp-Source: AKy350Y1l9vZ8aSitNTEyliRuPSOSXC2TggqdvnlTDYsZZz27IVvS/tI6xxrM7Cr/jakm2DIBOzbMQ==
X-Received: by 2002:ac8:5c46:0:b0:3ef:58f5:9ff7 with SMTP id j6-20020ac85c46000000b003ef58f59ff7mr25700800qtj.53.1682388959560;
        Mon, 24 Apr 2023 19:15:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:9fc5])
        by smtp.gmail.com with ESMTPSA id v17-20020a05620a091100b0074e003c55f0sm3993712qkv.102.2023.04.24.19.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 19:15:59 -0700 (PDT)
Date:   Mon, 24 Apr 2023 22:15:58 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 14/26] mm: compaction: simplify should_compact_retry()
Message-ID: <20230425021558.GB5666@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-15-hannes@cmpxchg.org>
 <20230421143654.g6ta3kd6ea7fsmp6@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421143654.g6ta3kd6ea7fsmp6@techsingularity.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 03:36:54PM +0100, Mel Gorman wrote:
> On Tue, Apr 18, 2023 at 03:13:01PM -0400, Johannes Weiner wrote:
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
> 
> Think this breaks build because of trace_compact_retry and max_retries is
> declared in a different scope on the next hunk.

Right you are. Will fix. Thanks!


