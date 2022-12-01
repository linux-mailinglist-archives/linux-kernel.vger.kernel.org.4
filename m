Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4618263F9BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiLAVWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiLAVWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:22:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414552316F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:22:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C09FB62129
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 21:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9BAC433D6;
        Thu,  1 Dec 2022 21:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669929759;
        bh=GIsKWp+Z1ekqEUas+5otTGGZ0St38k31vgjqrcnxpmE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ezNAOPx5mJeTaeYSxoCj90/+zMNm6SMoJqzDe1achx9NeQ5aiExRrBPoGbifDVlkO
         pQADvDcok3kxJbGNmwPaggm1laXkxugF8AaKOyZpf1E6q/Ti7UvtcO91u82++JyrtI
         A++mK2NytQbcbxl8sYa0kzZc58Fl3r2xKlSKPtXA=
Date:   Thu, 1 Dec 2022 13:22:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [mm] f35b5d7d67: will-it-scale.per_process_ops -95.5%
 regression
Message-Id: <20221201132237.c55c4bd07ba44463b146882e@linux-foundation.org>
In-Reply-To: <07adee081a70c2b4b44d9bf93a0ad3142e091086.camel@surriel.com>
References: <202210181535.7144dd15-yujie.liu@intel.com>
        <87edv4r2ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1DNQaoPWxE+rGce@dev-arch.thelio-3990X>
        <871qr3nkw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <366045a27a96e01d0526d63fd78d4f3c5d1f530b.camel@surriel.com>
        <Y1GCYXGtEVZbcv/5@dev-arch.thelio-3990X>
        <Y4RX+JZLddDHrLuQ@dev-arch.thelio-3990X>
        <e919e5a3-1118-043e-8bbd-5ee35f2ab411@leemhuis.info>
        <07adee081a70c2b4b44d9bf93a0ad3142e091086.camel@surriel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Dec 2022 15:29:41 -0500 Rik van Riel <riel@surriel.com> wrote:

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

2.8% speedup for gcc is nice.  Massive slowdown in the malloc banchmark
and in LLVM/clang is very bad - we don't know what other userspace will
be so affected.

So I think we revert until this is fully understood.


