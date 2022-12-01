Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6021F63F9ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLAVfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiLAVfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:35:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64081C3591
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:35:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E63A66211D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 21:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FD0C433C1;
        Thu,  1 Dec 2022 21:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669930534;
        bh=bPrANl5O/CR6UQ6leZGabXI4wglOYxJwd5Aq1s06nMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=igVVAWmhBrmkKxFznNIj8c2NFs3LakG02IVH0b/MMp2xfjhnqkrGVUYpeukyUMDG4
         HUAim2RAOoQOycE4AwzerzQkQnkwRCIcS00I3nDQAVQK7FJhgqs/jmx3tIMOfqPXcr
         4AUcpUlwXKe20ont5QoxqtV2gdnK/Uxo0mLLCrS86msO7L9z14WVfehI0R0asMr8aV
         twKrtLyQzTyAys8v3Rc0YP03pJUWRSn7s75ASTJCdRcQXNocrWShgagmrX4Q0c/ykt
         WoUwG6VKiSNTots7qaDhlOTjaEWAYSlc2RTm7lgopjrhnO1RTH3XRLmF8scpsZDPpp
         A9L/KImo1obpg==
Date:   Thu, 1 Dec 2022 14:35:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com
Subject: Re: [mm] f35b5d7d67: will-it-scale.per_process_ops -95.5% regression
Message-ID: <Y4keIyIK6OA3nOwT@dev-arch.thelio-3990X>
References: <202210181535.7144dd15-yujie.liu@intel.com>
 <87edv4r2ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1DNQaoPWxE+rGce@dev-arch.thelio-3990X>
 <871qr3nkw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <366045a27a96e01d0526d63fd78d4f3c5d1f530b.camel@surriel.com>
 <Y1GCYXGtEVZbcv/5@dev-arch.thelio-3990X>
 <Y4RX+JZLddDHrLuQ@dev-arch.thelio-3990X>
 <e919e5a3-1118-043e-8bbd-5ee35f2ab411@leemhuis.info>
 <07adee081a70c2b4b44d9bf93a0ad3142e091086.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07adee081a70c2b4b44d9bf93a0ad3142e091086.camel@surriel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 03:29:41PM -0500, Rik van Riel wrote:
> On Thu, 2022-12-01 at 19:33 +0100, Thorsten Leemhuis wrote:
> > Hi, this is your Linux kernel regression tracker.
> > 
> > On 28.11.22 07:40, Nathan Chancellor wrote:
> > > Hi Rik,
> > 
> > I wonder what we should do about below performance regression. Is
> > reverting the culprit now and reapplying it later together with a fix
> > a
> > viable option? Or was anything done/is anybody doing something
> > already
> > to address the problem and I just missed it?
> 
> The changeset in question speeds up kernel compiles with
> GCC, as well as the runtime speed of other programs, due
> to being able to use THPs more. However, it slows down kernel
> compiles with clang, due to ... something clang does.
> 
> I have not figured out what that something is yet.
> 
> I don't know if I have the wrong version of clang here,
> but I have not seen any smoking gun at all when tracing
> clang system calls. I see predominantly small mmap and
> unmap calls, and nothing that even triggers 2MB alignment.

Sorry about that :/ What version of clang are you trying to reproduce
with? I was able to see this with 14.x and 16.x, it is possible that
older versions do not do the thing that is causing this.

I cannot really be testing much on my main workstation but I will see if
I can reproduce this behavior on one of my other test systems or a
virtual machine. Once I do that, if you are still unable to reproduce
it, I can potentially try and help you debug this, although I will
likely need some hand holding.

Cheers,
Nathan

> > Yang Shi, Andrew, what's your option on this? I ask you directly,
> > because it looks like Rik hasn't posted anything to lists archived on
> > lore during the last few weeks. :-/
> > 
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker'
> > hat)
> > 
> > P.S.: As the Linux kernel's regression tracker I deal with a lot of
> > reports and sometimes miss something important when writing mails
> > like
> > this. If that's the case here, don't hesitate to tell me in a public
> > reply, it's in everyone's interest to set the public record straight.
> > 
> > > On Thu, Oct 20, 2022 at 10:16:20AM -0700, Nathan Chancellor wrote:
> > > > On Thu, Oct 20, 2022 at 11:28:16AM -0400, Rik van Riel wrote:
> > > > > On Thu, 2022-10-20 at 13:07 +0800, Huang, Ying wrote:
> > > > > > Nathan Chancellor <nathan@kernel.org> writes:
> > > > > > > 
> > > > > > > For what it's worth, I just bisected a massive and visible
> > > > > > > performance
> > > > > > > regression on my Threadripper 3990X workstation to commit
> > > > > > > f35b5d7d676e
> > > > > > > ("mm: align larger anonymous mappings on THP boundaries"),
> > > > > > > which
> > > > > > > seems
> > > > > > > directly related to this report/analysis. I initially
> > > > > > > noticed this
> > > > > > > because my full set of kernel builds against mainline went
> > > > > > > from 2
> > > > > > > hours
> > > > > > > and 20 minutes or so to over 3 hours. Zeroing in on x86_64
> > > > > > > allmodconfig,
> > > > > > > which I used for the bisect:
> > > > > > > 
> > > > > > > @ 7b5a0b664ebe ("mm/page_ext: remove unused variable in
> > > > > > > offline_page_ext"):
> > > > > > > 
> > > > > > > Benchmark 1: make -skj128 LLVM=1 allmodconfig all
> > > > > > >   Time (mean ± σ):     318.172 s ±  0.730 s    [User:
> > > > > > > 31750.902 s,
> > > > > > > System: 4564.246 s]
> > > > > > >   Range (min … max):   317.332 s … 318.662 s    3 runs
> > > > > > > 
> > > > > > > @ f35b5d7d676e ("mm: align larger anonymous mappings on THP
> > > > > > > boundaries"):
> > > > > > > 
> > > > > > > Benchmark 1: make -skj128 LLVM=1 allmodconfig all
> > > > > > >   Time (mean ± σ):     406.688 s ±  0.676 s    [User:
> > > > > > > 31819.526 s,
> > > > > System: 16327.022 s]
> > > > > > >   Range (min … max):   405.954 s … 407.284 s    3 run
> > > > > > 
> > > > > > Have you tried to build with gcc?  Want to check whether is
> > > > > > this
> > > > > > clang
> > > > > > specific issue or not.
> > > > > 
> > > > > This may indeed be something LLVM specific. In previous tests,
> > > > > GCC has generally seen a benefit from increased THP usage.
> > > > > Many other applications also benefit from getting more THPs.
> > > > 
> > > > Indeed, GCC builds actually appear to be slightly faster on my
> > > > system now,
> > > > apologies for not trying that before reporting :/
> > > > 
> > > > 7b5a0b664ebe:
> > > > 
> > > > Benchmark 1: make -skj128 allmodconfig all
> > > >   Time (mean ± σ):     355.294 s ±  0.931 s    [User: 33620.469
> > > > s, System: 6390.064 s]
> > > >   Range (min … max):   354.571 s … 356.344 s    3 runs
> > > > 
> > > > f35b5d7d676e:
> > > > 
> > > > Benchmark 1: make -skj128 allmodconfig all
> > > >   Time (mean ± σ):     347.400 s ±  2.029 s    [User: 34389.724
> > > > s, System: 4603.175 s]
> > > >   Range (min … max):   345.815 s … 349.686 s    3 runs
> > > > 
> > > > > LLVM showing 10% system time before this change, and a whopping
> > > > > 30% system time after that change, suggests that LLVM is
> > > > > behaving
> > > > > quite differently from GCC in some ways.
> > > > 
> > > > The above tests were done with GCC 12.2.0 from Arch Linux. The
> > > > previous LLVM
> > > > tests were done with a self-compiled version of LLVM from the
> > > > main branch
> > > > (16.0.0), optimized with BOLT [1]. To eliminate that as a source
> > > > of issues, I
> > > > used my distribution's version of clang (14.0.6) and saw similar
> > > > results as
> > > > before:
> > > > 
> > > > 7b5a0b664ebe:
> > > > 
> > > > Benchmark 1: make -skj128 LLVM=/usr/bin/ allmodconfig all
> > > >   Time (mean ± σ):     462.517 s ±  1.214 s    [User: 48544.240
> > > > s, System: 5586.212 s]
> > > >   Range (min … max):   461.115 s … 463.245 s    3 runs
> > > > 
> > > > f35b5d7d676e:
> > > > 
> > > > Benchmark 1: make -skj128 LLVM=/usr/bin/ allmodconfig all
> > > >   Time (mean ± σ):     547.927 s ±  0.862 s    [User: 47913.709
> > > > s, System: 17682.514 s]
> > > >   Range (min … max):   547.429 s … 548.922 s    3 runs
> > > > 
> > > > > If we can figure out what these differences are, maybe we can
> > > > > just fine tune the code to avoid this issue.
> > > > > 
> > > > > I'll try to play around with LLVM compilation a little bit next
> > > > > week, to see if I can figure out what might be going on. I
> > > > > wonder
> > > > > if LLVM is doing lots of mremap calls or something...
> > > > 
> > > > If there is any further information I can provide or patches I
> > > > can test,
> > > > I am more than happy to do so.
> > > > 
> > > > [1]:
> > > > https://github.com/llvm/llvm-project/tree/96552e73900176d65ee6650facae8d669d6f9498/bolt
> > > 
> > > Was there ever a follow up to this report that I missed? I just
> > > noticed that I am still reverting f35b5d7d676e in my mainline
> > > kernel.
> > > 
> > > Cheers,
> > > Nathan
> > > 
> > 
> > #regzbot ignore-activity
> > 
> 
> -- 
> All Rights Reversed.


