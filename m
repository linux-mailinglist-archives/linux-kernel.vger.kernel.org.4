Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C056E715B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 04:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjDSCz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 22:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjDSCz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:55:56 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9842468E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 19:55:54 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id a23so26990518qtj.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 19:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681872954; x=1684464954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LcgMWY9Egw7upTgiRyX9Ji+eQ7ZeBYypgCETacQZMO4=;
        b=XM39AUliYsnb3m2d6jTi1Ke0fqpB6LqbRk8Py1DEzIC4JG2a58fvM9VWLh6P3XySe+
         YJD5aF8prsuEJQ9gwy1UZiJSzN8E87gSv/2sBJfGXmmHeMe3LP2btSQ9f/PA1U/dlF+T
         65/vHxEfZ3ZC177MorXwTXUqJIjYf3wGPT/ldiiofrNyY1o7TiMBzNQBxJ1CQrl6KT3b
         CPe0/CgtCn67rqB2fgPoG+LMykLKLtp2WJFh90BsaPX4redKQn8I3QqYxXxCNhNojA30
         1uTJ17lGO5DwCRpm1NNVC/PtNH9ugDi8p1BeA1F8/78NtnBixkWqaLIYdqNbDtsfq8TU
         S91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681872954; x=1684464954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcgMWY9Egw7upTgiRyX9Ji+eQ7ZeBYypgCETacQZMO4=;
        b=jyo0Lb+57IpXBgX5oK3nECt/3pLRjpyPMBLSpD7BtxmQUf2vfEkfUt2cp3xscYzwcz
         +VQ36IvvRcTxYeiL2XvG2PcnobVkU+DtzSMZAcpBtg63e9cNJhDiif3oCyvMxZm/4SFI
         lUz1eXhsV2Rije6ssQ0k6A1cWXHLniksvwGTf6oqQZsmF6VxLL+aPHxCt62MGyuD5XHw
         ryuXC2fK2/fZ7SVb2/Tr2yO0KLbj9Cu5WKS17dN8J/HYJPMTS77T/fY1ZWCOFR+puT16
         F1rscV5CG4yTrYcUAk9G+ThddcVjWiGzi7gnmGU/8gNMb04v9OXpdMF59LLLosFEZ+PD
         Agyw==
X-Gm-Message-State: AAQBX9chGgZI9zXExQjiM1Phrx0dpb0u/GB2yHbeMB/ECWk3kqp1ZagX
        xhQ/omlTRezOVQyn4/y9hjrBPw==
X-Google-Smtp-Source: AKy350aTwN5NADIBxWpDONKKP92OfmBIrgt7goEPYjvtgMWJHQujIfXZRHcTEgy6Kq/EftdB6TL2IA==
X-Received: by 2002:ac8:590b:0:b0:3ef:3fcd:3c1c with SMTP id 11-20020ac8590b000000b003ef3fcd3c1cmr3125596qty.63.1681872953863;
        Tue, 18 Apr 2023 19:55:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id k15-20020a05620a414f00b007463509f94asm4325549qko.55.2023.04.18.19.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 19:55:53 -0700 (PDT)
Date:   Tue, 18 Apr 2023 22:55:52 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 03/26] mm: make pageblock_order 2M per default
Message-ID: <20230419025552.GB272256@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-4-hannes@cmpxchg.org>
 <20230419000105.matz43p6ihrqmado@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419000105.matz43p6ihrqmado@box.shutemov.name>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 03:01:05AM +0300, Kirill A. Shutemov wrote:
> On Tue, Apr 18, 2023 at 03:12:50PM -0400, Johannes Weiner wrote:
> > pageblock_order can be of various sizes, depending on configuration,
> > but the default is MAX_ORDER-1.
> 
> Note that MAX_ORDER got redefined in -mm tree recently.
> 
> > Given 4k pages, that comes out to
> > 4M. This is a large chunk for the allocator/reclaim/compaction to try
> > to keep grouped per migratetype. It's also unnecessary as the majority
> > of higher order allocations - THP and slab - are smaller than that.
> 
> This seems way to x86-specific.

Hey, that's the machines I have access to ;)

> Other arches have larger THP sizes. I believe 16M is common.
>
> Maybe define it as min(MAX_ORDER, PMD_ORDER)?

Hm, let me play around with larger pageblocks.

The thing that gives me pause is that this seems quite aggressive as a
default block size for the allocator and reclaim/compaction - if you
consider the implications for internal fragmentation and the amount of
ongoing defragmentation work it would require.

IOW, it's not just a function of physical page size supported by the
CPU. It's also a function of overall memory capacity. Independent of
architecture, 2MB seems like a more reasonable step up than 16M.

16M is great for TLB coverage, and in our DCs we're getting a lot of
use out of 1G hugetlb pages as well. The question is if those archs
are willing to pay the cost of serving such page sizes quickly and
reliably during runtime; or if that's something better left to setups
with explicit preallocations and stuff like hugetlb_cma reservations.
