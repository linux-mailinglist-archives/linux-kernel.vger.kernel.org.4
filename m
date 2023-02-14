Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542396963CC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjBNMqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjBNMqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:46:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7A1265AD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:46:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAA646160D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A2DC433EF;
        Tue, 14 Feb 2023 12:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676378792;
        bh=rvY4akbiWkPYp6q8TWHxBXJMkGaOh5UByiYweshK5tA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FjxqQOiRowx5Ag6MmnJWY6fYnMyjiQGyRcgh+5Pr68OuA7WEiVwZRZqvHobwGGilk
         DlwtE+gG9pN2nP2YsEX8CJ0A5YMyBJg5W7KG6ZXMc6aV1aN8swwKBHMB6L89uHZMYI
         E1WJmP03hDrL3JMXB/VI3kFB8Zl3IfxxfDZsgbay0LyW3YllOtgcbfQIxioWS75m8U
         x7KmzQ8vPmgoJ1HZKTcU0KxDQzBVw3CjFDRrDJgfnU8rF3I4HvAAGP6CpiGllUBmOH
         rW4O/sxWZXV26FCteWRJh/DLEq+X/27QKFLgbCIS4TCrQfExuCH/mL2X3+rJ5wcV7h
         3ArohJk4pKGMw==
Date:   Tue, 14 Feb 2023 14:46:17 +0200
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
        Muchun Song <muchun.song@linux.dev>, x86@kernel.org
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Message-ID: <Y+uCmU0um0VOL9RI@kernel.org>
References: <2484666e-e78e-549d-e075-b2c39d460d71@suse.cz>
 <85af4ada-96c8-1f99-90fa-9b6d63d0016e@bytedance.com>
 <c6908bd0-5f76-47eb-2b77-ce8f7bf9fbff@suse.cz>
 <eefc40e5-a14b-22c5-3480-6786afa1c8f4@redhat.com>
 <Y+tXrK/g1Nrd/q1h@kernel.org>
 <67240e55-af49-f20a-2b4b-b7d574cd910d@gmail.com>
 <22f0e262-982e-ea80-e52a-a3c924b31d58@redhat.com>
 <dbfbd982-27f3-0d72-49e0-d3dd5fe636a8@bytedance.com>
 <4386151c-0328-d207-9a71-933ef61817f9@redhat.com>
 <Y+t0Bhu7BCzH2Dp4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+t0Bhu7BCzH2Dp4@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now added x86 folks for real :)

The thread starts here:
https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/

On Tue, Feb 14, 2023 at 01:44:06PM +0200, Mike Rapoport wrote:
> (added x86 folks)
> 
> On Tue, Feb 14, 2023 at 12:29:42PM +0100, David Hildenbrand wrote:
> > On 14.02.23 12:26, Qi Zheng wrote:
> > > On 2023/2/14 19:22, David Hildenbrand wrote:
> > > > 
> > > > TBH, this is the first time I hear of NODE_MIN_SIZE and it seems to be a
> > > > pretty x86 specific thing.
> > > > 
> > > > Are we sure we want to get NODE_MIN_SIZE involved?
> > > 
> > > Maybe add an arch_xxx() to handle it?
> > 
> > I still haven't figured out what we want to achieve with NODE_MIN_SIZE at
> > all. It smells like an arch-specific hack looking at
> > 
> > "Don't confuse VM with a node that doesn't have the minimum amount of
> > memory"
> > 
> > Why shouldn't mm-core deal with that?
> 
> Well, a node with <4M RAM is not very useful and bears all the overhead of
> an extra live node.
> 
> But, hey, why won't we just drop that '< NODE_MIN_SIZE' and let people with
> weird HW configurations just live with this?
>  
> > I'd appreciate an explanation of the bigger picture, what the issue is and
> > what the approach to solve it is (including memory onlining/offlining).
> > 
> > -- 
> > Thanks,
> > 
> > David / dhildenb
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 

-- 
Sincerely yours,
Mike.
