Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B279606E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 05:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJUDjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 23:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJUDi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:38:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560181EEF35;
        Thu, 20 Oct 2022 20:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1XY73f1kjOU4NdkwAVhndbgqvAKzNMKeh42X8Tt0Wkw=; b=jPWpIVKYoxvDDgxbcKiw/lXPPT
        1LEj3moZ+xR5z103bB9Dbe/R0y8xz42AMGxzKRoBtVA1STPNlx3rPPKEEi4/IIkDH0LBlru86x02f
        O24rRi97bFyMhvrK/fDNvBve6BdXyyAlnQyplqqzBqqaKBk8LGLFY0rBEpwjGxX4BS0Fg3N9x/tMG
        sKCmeytDq8T3+azeoGdA/oOfOE3inboL/Peuo+A8L0dNv63o3A4lJFZ3iC5VjsIB/NcFyi0yPS/0+
        6bsTiWGhYVdpi4WUjEynekfJj3rk3vxFFfLSvwe3qCYmO5fnoIZVxywahWn9ytz4R1MQ5Hf1Y1ctd
        oU2kAutA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olirY-00CrCi-Qx; Fri, 21 Oct 2022 03:38:24 +0000
Date:   Fri, 21 Oct 2022 04:38:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v14 08/14] mm: multi-gen LRU: support page table walks
Message-ID: <Y1IUMDJFScAMrCS5@casper.infradead.org>
References: <20220815071332.627393-1-yuzhao@google.com>
 <20220815071332.627393-9-yuzhao@google.com>
 <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net>
 <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com>
 <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com>
 <Y1FXpHdyvXjrjbLw@hirez.programming.kicks-ass.net>
 <CAHk-=whQchubuDpRGFabhmcZuzdt13OOF8wznXb+Dbi3GzBQhQ@mail.gmail.com>
 <Y1GZjPO+szk7X0wP@hirez.programming.kicks-ass.net>
 <CAHk-=wikUaRM5H_y1Bc+QyvGi40dKDL8fnCTyz7ECbwK7aHNPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wikUaRM5H_y1Bc+QyvGi40dKDL8fnCTyz7ECbwK7aHNPQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 07:10:46PM -0700, Linus Torvalds wrote:
> Maybe we should just bite the bullet, and say that we only support
> x86-32 with 'cmpxchg8b' (ie Pentium and later).
> 
> Get rid of all the "emulate 64-bit atomics with cli/sti, knowing that
> nobody has SMP on those CPU's anyway", and implement a generic x86-32
> xchg() setup using that try_cmpxchg64 loop.
> 
> I think most (all?) distros already enable X86_PAE anyway, which makes
> that X86_CMPXCHG64 be part of the base requirement.
> 
> Not that I'm convinced most distros even do 32-bit development anyway
> these days.
> 
> (Of course, if we require X86_CMPXCHG64, we'll also hit some of the
> odd clone CPU's that actually *do* support the instruction, but do not
> report it in cpuid due to an odd old Windows NT bug. IOW, things like
> the Cyrix and Transmeta CPU's did support the instruction, but had the
> CX8 bit clear because otherwise NT wouldn't boot. We may or may not
> get those cases right, but I doubt anybody really has any of those old
> CPUs).
> 
> We got rid of i386 support back in 2012. Maybe it's time to get rid of
> i486 support in 2022?

Arnd suggested removing i486 last year and got a bit of pushback.
The most convincing to my mind was Maciej:

https://lore.kernel.org/lkml/alpine.DEB.2.21.2110231853170.38243@angie.orcam.me.uk/

but you can see a few other responses indicating that people have
shipped new 486-class hardware within the last few years (!)
