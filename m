Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72D7709C39
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjESQPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjESQPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9557D10FD
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:14:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7A6065912
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971B8C433EF;
        Fri, 19 May 2023 16:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684512869;
        bh=cj9XLln61NnV+iOtJGxKSspk1kIfcgYZKJDT3am1C1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eufy765D0jvm/ghu+mPlpSqSY5QRnhPl/E1ytFy0IkOma2vMgd21YFe5ivcmxAF6i
         bXQrLIDGSPVIn3PwHk4jhjfSx/433XuH5DO7GTA9qFKiKmYQx9zOAZ59EEBt6qIq27
         fLTm7kZXVp3+60dzEEtsvuds4JY3GqfgCBg8fThbiQ2+d0KpFqwbegxPp2cSER8uvm
         AEEO88GrS5L9tEOwoFa7u2O7Ajj4Fuz96itWjYsiqXboee4CZsbi6dmSqzbN3wAzVN
         JpwXnC9LW/FvtyhAylJVBdT+fciGQ0Lz63JxKigbeuIKr5y9jBKsywHtrVeBw0cEjm
         BrjRBD2jWgFQQ==
Date:   Fri, 19 May 2023 19:14:14 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Song Liu <song@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Message-ID: <20230519161414.GF4967@kernel.org>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan>
 <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
 <ZGZW0v3nRShO7r+Z@moria.home.lan>
 <CAPhsuW5BbbxinaH2aO=2Wa0aSQ3pkNwvnrgJv7fG4QcPr_j7+Q@mail.gmail.com>
 <ZGZfLHA8vuRJwa0f@moria.home.lan>
 <20230519082945.GE4967@kernel.org>
 <ZGeaHpWTWPUSsmxs@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGeaHpWTWPUSsmxs@moria.home.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 11:47:42AM -0400, Kent Overstreet wrote:
> On Fri, May 19, 2023 at 11:29:45AM +0300, Mike Rapoport wrote:
> > Your allocator implicitly relies on vmalloc because of module_alloc ;-)
> > 
> > What I was thinking is that we can replace module_alloc() calls in your
> > allocator with something based on my unmapped_alloc(). If we make the part
> > that refills the cache also take care of creating the mapping in the
> > module address space, that should cover everything.
> 
> Yeah, that's exactly what I was thinking :)
> 
> Liam was also just mentioning on IRC vmalloc lock contention came up
> again at LSF, and that's historically always been an isuse - going with
> your patchset for the backend nicely avoids that.

Unfortunately not because we still need to map the pages in the modules
area which is essentially a subset of vmalloc address space.
 
> If I have time (hah! big if :) I'll see if I can cook up a patchset that
> combines our two approaches over the weekend.

Now there is also an interest about unmapped allocations from KVM folks, so
I might continue pursuing unmapped allocator, probably just without a new
GFP flag and hooks into page allocator.

-- 
Sincerely yours,
Mike.
