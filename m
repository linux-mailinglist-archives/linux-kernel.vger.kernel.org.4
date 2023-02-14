Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9AE6962A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjBNLoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBNLoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:44:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136046E84
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:44:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 978FA60EB7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE338C433D2;
        Tue, 14 Feb 2023 11:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676375062;
        bh=q0Ur6EqsdYguRoKZUYKbZ/d3FIdm1SPvTdEyMXa0spA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hNu2bJp2JUvI3QkRXK6/SQ2nkmC5w5Fh1H9YD4hrKbPoIN3Fq+ldd8hhjkhCWSvYI
         V39OEZBsYL2sKN83x9XQYBD0tGXpHtFfp6V5n6C1H944Q3aHNW15NaTJGlqXm2DRN+
         ESU9rmmZZh2m384tQqLmUddopMCEgb8g1it0GuRfKO4r3SjqPqchr7f2wX+s8T4SYW
         GniPQw17Cnr1tpI41oVFCDJ79RHVFF7Zc2D/m8s/cHgmICuaWyTGaiTFxGcCUkD2re
         UzyPUbqN32MazJ0BKCInOtvMvVykL1QGAlQxIJuZY4b81wg0SKKCsS9dhV1sa88F5g
         F+ZGLpmnOMyNQ==
Date:   Tue, 14 Feb 2023 13:44:06 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Qi Zheng <arch0.zheng@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Teng Hu <huteng.ht@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Message-ID: <Y+t0Bhu7BCzH2Dp4@kernel.org>
References: <20230212110305.93670-1-zhengqi.arch@bytedance.com>
 <2484666e-e78e-549d-e075-b2c39d460d71@suse.cz>
 <85af4ada-96c8-1f99-90fa-9b6d63d0016e@bytedance.com>
 <c6908bd0-5f76-47eb-2b77-ce8f7bf9fbff@suse.cz>
 <eefc40e5-a14b-22c5-3480-6786afa1c8f4@redhat.com>
 <Y+tXrK/g1Nrd/q1h@kernel.org>
 <67240e55-af49-f20a-2b4b-b7d574cd910d@gmail.com>
 <22f0e262-982e-ea80-e52a-a3c924b31d58@redhat.com>
 <dbfbd982-27f3-0d72-49e0-d3dd5fe636a8@bytedance.com>
 <4386151c-0328-d207-9a71-933ef61817f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4386151c-0328-d207-9a71-933ef61817f9@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(added x86 folks)

On Tue, Feb 14, 2023 at 12:29:42PM +0100, David Hildenbrand wrote:
> On 14.02.23 12:26, Qi Zheng wrote:
> > On 2023/2/14 19:22, David Hildenbrand wrote:
> > > 
> > > TBH, this is the first time I hear of NODE_MIN_SIZE and it seems to be a
> > > pretty x86 specific thing.
> > > 
> > > Are we sure we want to get NODE_MIN_SIZE involved?
> > 
> > Maybe add an arch_xxx() to handle it?
> 
> I still haven't figured out what we want to achieve with NODE_MIN_SIZE at
> all. It smells like an arch-specific hack looking at
> 
> "Don't confuse VM with a node that doesn't have the minimum amount of
> memory"
> 
> Why shouldn't mm-core deal with that?

Well, a node with <4M RAM is not very useful and bears all the overhead of
an extra live node.

But, hey, why won't we just drop that '< NODE_MIN_SIZE' and let people with
weird HW configurations just live with this?
 
> I'd appreciate an explanation of the bigger picture, what the issue is and
> what the approach to solve it is (including memory onlining/offlining).
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
