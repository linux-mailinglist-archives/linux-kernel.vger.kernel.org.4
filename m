Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154E363A162
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiK1GlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiK1GlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:41:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9C4A187
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 22:40:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B0B560FB3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1939CC433D6;
        Mon, 28 Nov 2022 06:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669617658;
        bh=ryGZdOEL0/JhMmu+OkrwTiHR2hFwcw5urUHIeZXSzFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sFTSrIkhRwNM2GVriqZotxOF2R2ZVzbSfmav/+QrBT3UIbubljJ4UJxqlrB9H/GcD
         MgCJhF8KWbORIo6jx55CMY9ScAQ+YoxmD4UbenT0UFb4QF10L/+Bs0zr/VtvWc8Cjm
         Z72AIitgAVBEB2HgH85m+cG4keSnQH4osWZZDhhgEmGmvfRKSaA+cnnXebRdu2mEKx
         RQsgBAt2rs29d2KbHiA9QTdPCurWpaADjJX9ievRL03+QPEFQUJbhh5FcYRDbo0KmT
         UMlDFBia3b8/lXdwMn9aYNcVlBSyvO2/qgC5a2fJBeZZ5pbZN2PbTPe+qtZpbmL4YD
         P+1IGjVBA/m1Q==
Date:   Sun, 27 Nov 2022 23:40:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com
Subject: Re: [mm] f35b5d7d67: will-it-scale.per_process_ops -95.5% regression
Message-ID: <Y4RX+JZLddDHrLuQ@dev-arch.thelio-3990X>
References: <202210181535.7144dd15-yujie.liu@intel.com>
 <87edv4r2ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1DNQaoPWxE+rGce@dev-arch.thelio-3990X>
 <871qr3nkw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <366045a27a96e01d0526d63fd78d4f3c5d1f530b.camel@surriel.com>
 <Y1GCYXGtEVZbcv/5@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1GCYXGtEVZbcv/5@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

On Thu, Oct 20, 2022 at 10:16:20AM -0700, Nathan Chancellor wrote:
> On Thu, Oct 20, 2022 at 11:28:16AM -0400, Rik van Riel wrote:
> > On Thu, 2022-10-20 at 13:07 +0800, Huang, Ying wrote:
> > > 
> > > Nathan Chancellor <nathan@kernel.org> writes:
> > > > 
> > > > For what it's worth, I just bisected a massive and visible
> > > > performance
> > > > regression on my Threadripper 3990X workstation to commit
> > > > f35b5d7d676e
> > > > ("mm: align larger anonymous mappings on THP boundaries"), which
> > > > seems
> > > > directly related to this report/analysis. I initially noticed this
> > > > because my full set of kernel builds against mainline went from 2
> > > > hours
> > > > and 20 minutes or so to over 3 hours. Zeroing in on x86_64
> > > > allmodconfig,
> > > > which I used for the bisect:
> > > > 
> > > > @ 7b5a0b664ebe ("mm/page_ext: remove unused variable in
> > > > offline_page_ext"):
> > > > 
> > > > Benchmark 1: make -skj128 LLVM=1 allmodconfig all
> > > >   Time (mean ± σ):     318.172 s ±  0.730 s    [User: 31750.902 s,
> > > > System: 4564.246 s]
> > > >   Range (min … max):   317.332 s … 318.662 s    3 runs
> > > > 
> > > > @ f35b5d7d676e ("mm: align larger anonymous mappings on THP
> > > > boundaries"):
> > > > 
> > > > Benchmark 1: make -skj128 LLVM=1 allmodconfig all
> > > >   Time (mean ± σ):     406.688 s ±  0.676 s    [User: 31819.526 s,
> > System: 16327.022 s]
> > > >   Range (min … max):   405.954 s … 407.284 s    3 run
> > > 
> > > Have you tried to build with gcc?  Want to check whether is this
> > > clang
> > > specific issue or not.
> > 
> > This may indeed be something LLVM specific. In previous tests,
> > GCC has generally seen a benefit from increased THP usage.
> > Many other applications also benefit from getting more THPs.
> 
> Indeed, GCC builds actually appear to be slightly faster on my system now,
> apologies for not trying that before reporting :/
> 
> 7b5a0b664ebe:
> 
> Benchmark 1: make -skj128 allmodconfig all
>   Time (mean ± σ):     355.294 s ±  0.931 s    [User: 33620.469 s, System: 6390.064 s]
>   Range (min … max):   354.571 s … 356.344 s    3 runs
> 
> f35b5d7d676e:
> 
> Benchmark 1: make -skj128 allmodconfig all
>   Time (mean ± σ):     347.400 s ±  2.029 s    [User: 34389.724 s, System: 4603.175 s]
>   Range (min … max):   345.815 s … 349.686 s    3 runs
> 
> > LLVM showing 10% system time before this change, and a whopping
> > 30% system time after that change, suggests that LLVM is behaving
> > quite differently from GCC in some ways.
> 
> The above tests were done with GCC 12.2.0 from Arch Linux. The previous LLVM
> tests were done with a self-compiled version of LLVM from the main branch
> (16.0.0), optimized with BOLT [1]. To eliminate that as a source of issues, I
> used my distribution's version of clang (14.0.6) and saw similar results as
> before:
> 
> 7b5a0b664ebe:
> 
> Benchmark 1: make -skj128 LLVM=/usr/bin/ allmodconfig all
>   Time (mean ± σ):     462.517 s ±  1.214 s    [User: 48544.240 s, System: 5586.212 s]
>   Range (min … max):   461.115 s … 463.245 s    3 runs
> 
> f35b5d7d676e:
> 
> Benchmark 1: make -skj128 LLVM=/usr/bin/ allmodconfig all
>   Time (mean ± σ):     547.927 s ±  0.862 s    [User: 47913.709 s, System: 17682.514 s]
>   Range (min … max):   547.429 s … 548.922 s    3 runs
> 
> > If we can figure out what these differences are, maybe we can
> > just fine tune the code to avoid this issue.
> > 
> > I'll try to play around with LLVM compilation a little bit next
> > week, to see if I can figure out what might be going on. I wonder
> > if LLVM is doing lots of mremap calls or something...
> 
> If there is any further information I can provide or patches I can test,
> I am more than happy to do so.
> 
> [1]: https://github.com/llvm/llvm-project/tree/96552e73900176d65ee6650facae8d669d6f9498/bolt

Was there ever a follow up to this report that I missed? I just
noticed that I am still reverting f35b5d7d676e in my mainline kernel.

Cheers,
Nathan
