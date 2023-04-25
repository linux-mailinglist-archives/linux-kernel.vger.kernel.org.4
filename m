Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBDB6EE4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjDYPkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbjDYPke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:40:34 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB7BD333
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:40:28 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-5ef6b757a60so24798616d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1682437227; x=1685029227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sz41xh9WX8qoOdIKJmQdrlGwHLiYgLl85XIU3W+xHVw=;
        b=2qVMPflrw0T2LPyFNNegzJLB7Ix+X+y/YwEnVHEFh68utKtzCPTrxVkh+KGE1XsP7p
         423MfaUjxVUhxljQdhfCN7b/6jyUl8aszB9beZFyPkhWwe0lfNN+MEl9zMAGbG35/N78
         97KF8xEr0oha4QiyEkxzcqXkayiVjDbtLubf8GPSdjPeLpvNyJFgP8gz16yrOIAURHfM
         VB58Eg8hAc73o/MEDV5uoSF9TCkzgSLVbYuDZyVMHsnDoDvDrDZWh4dvWLInKfTbfZBl
         b/1GR+dzzWtsU51sZ7MlhPDXZxCJGFs2rntlOKwNLysXWkj72t53CensQdT3boyhoKoX
         eBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682437227; x=1685029227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sz41xh9WX8qoOdIKJmQdrlGwHLiYgLl85XIU3W+xHVw=;
        b=SPrC2c3LoJ4w5AbM4PpcEud4AXgD+IF3EvhrlZXEArBXC7uq6XInI8NrB7qphKzlDT
         sba9ZQrobr8V3ysXqfin7+mA7XVE/q8LZbRUEzOmrZY+sl+NG0WrnuBCySxxN+veyO2X
         O8J+LyDdyM7eO0rHwm83UDXHf8ALYV17+WKzaFqVo8NbQexjgg95fuV9IAv63ZySqWXS
         FunX2/uurX6c1CYxnL2kBwaXiqrKH9pPQ3RKvDSqzQPlUCJCesP+4JTRjs6KJVlcBmjO
         xoCC7REVYi2QlLnRktx89885SW2KaBAImw0t6LfyPBllnYkp+eY0vREfx5QazGmBygdr
         QgXw==
X-Gm-Message-State: AAQBX9ceYYlP9ntAFGgwY+S+T6hA7F08wXkkTTzpIy6alaC0qPbAJyl6
        ioOU8QC1svbr0HcjM8mgty972w==
X-Google-Smtp-Source: AKy350ZuTU2+gfPuqlAYRQHG0DYc6Hd46OaxYvfknDpwSYIfN8LpMy3/mSs14uvFnKehLaoG5YSxZQ==
X-Received: by 2002:a05:6214:242e:b0:5f1:6bee:f58e with SMTP id gy14-20020a056214242e00b005f16beef58emr32598066qvb.35.1682437227122;
        Tue, 25 Apr 2023 08:40:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:9fc5])
        by smtp.gmail.com with ESMTPSA id k14-20020a0cf58e000000b005eac706d223sm4173628qvm.124.2023.04.25.08.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 08:40:26 -0700 (PDT)
Date:   Tue, 25 Apr 2023 11:40:26 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 10/26] mm: page_alloc: allow compaction capturing
 from larger blocks
Message-ID: <20230425154026.GC17132@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-11-hannes@cmpxchg.org>
 <20230421141447.2cw5cfwibb7jxf6n@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421141447.2cw5cfwibb7jxf6n@techsingularity.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 03:14:47PM +0100, Mel Gorman wrote:
> On Tue, Apr 18, 2023 at 03:12:57PM -0400, Johannes Weiner wrote:
> > Currently, capturing only works on matching orders and matching
> > migratetypes. However, if capturing is initially skipped on the
> > migratetype, it's possible that merging continues up to a full
> > pageblock, in which case the migratetype is up for grabs again.
> > 
> > Allow capturing to grab smaller chunks from claimed pageblocks, and
> > expand the remainder of the block back onto the freelists.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> No objections other than we're still in the preparation phase and the
> series needs to be split. Out of curiousity, how often does this actually
> trigger in practice? I ask because superficially, I would expect capture to
> happen while pages are being merged and I'm not sure how much this actually
> helps. If anything the anomaly would be merging !MOVABLE types, capturing
> one pageblock and leaving the adjacent block eligible for splitting as
> UNMOVABLE/RECLAIMABLE which is not necessarily desirable.

Looking at this patch independently, once merging continues to the
full block, a fallback would be allowed to claim it anyway
(can_steal_fallback() returns true). I don't quite see a downside
letting capture apply in this case. The plus is of course avoiding the
indirection through the freelist which risks an opportunist request of
a smaller order fragmenting the block and wasting the contiguity work.

In the context of the full series, this becomes even more
important. Once watermarks are required to be met in MIGRATE_FREE
blocks, and reclaim/compaction recycle full blocks, merging up to
pageblock_order happens all the time - and needs to happen for
allocations to succeed. This applies to all types of direct reclaim:
unmovable request freeing reclaimable/movable blocks, reclaimable
freeing movable blocks, movable freeing reclaimable blocks.

I see your point about smaller orders now always ending the merge at
the pageblock, even when there could be additional merging
opportunities beyond. However, I'm not sure these accidental larger
merges beyond what's needed to fulfill the request at hand are a
preferable aspect over reclaimer fairness, and thus ultimately the
reliability of orders up to the pageblock size.

I'll try to get some numbers for this patch independently, though.
This should manifest in p99 allocation latencies and near-OOM
behavior. Is there anything else you'd want me to look for?

Thanks!
