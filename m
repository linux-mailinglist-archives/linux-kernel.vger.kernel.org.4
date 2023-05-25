Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4378371183B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjEYUiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjEYUiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:38:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21968194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:38:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94000612D8
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 20:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28027C433EF;
        Thu, 25 May 2023 20:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685047083;
        bh=i51ujcjCkUGno5zWuS49FNmOut45twOgb5SnLa+ZZd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jU+t0T6qn2GOdIktSugYG53391Zm3n4pxwTLlVTiRwYvcvW9HxM1M/Z/Apdm7A/3x
         RhAv58JX29uv52ZLGe5PgOvtn/StubGB6Rq5TqGIj2yw0GSVtdhjq2pxejX/EOqClm
         39AtplVtdn4OIlnOE0FZB/G+3Top3BI+zmUeqo+2kPd7wqNuqy2zv6LuQsegIqNupT
         COmDqMtNP8muGmiiTePMUv2Yfilf1kj+WkRAPuLjedgbZBskYdL0vI5TKvPx0jbBaw
         +HiagTP13tMhcPp4b/xLdwKnTZJYoHnWNxup5ZE+cdXcfXGuNuyj9Q9tt9NxOuhJrF
         /LyK/49+ix26w==
Date:   Thu, 25 May 2023 23:37:40 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "song@kernel.org" <song@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 0/5] Prototype for direct map awareness in page
 allocator
Message-ID: <20230525203740.GB4967@kernel.org>
References: <20230308094106.227365-1-rppt@kernel.org>
 <e48a7fb1f8ab8d670b0884fd2a5d1e8c1c20e712.camel@intel.com>
 <ZAn34D3hXR7dp8KC@kernel.org>
 <ZGeYgKCFOkzP2fub@google.com>
 <20230519162432.GG4967@kernel.org>
 <ZGe/Md3FXb1ihXwe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGe/Md3FXb1ihXwe@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 11:25:53AM -0700, Sean Christopherson wrote:
> On Fri, May 19, 2023, Mike Rapoport wrote:
> > On Fri, May 19, 2023 at 08:40:48AM -0700, Sean Christopherson wrote:
> > > On Thu, Mar 09, 2023, Mike Rapoport wrote:
> > > > On Thu, Mar 09, 2023 at 01:59:00AM +0000, Edgecombe, Rick P wrote:
> > > 
> > > Would it be possible to drop that assumption/requirement, i.e. allow allocation of
> > > __GFP_UNMAPPED without __GFP_ZERO?  At a glance, __GFP_UNMAPPED looks like it would
> > > be a great fit for backing guest memory, in particular for confidential VMs.  And
> > > for some flavors of CoCo, i.e. TDX, the trusted intermediary is responsible for
> > > zeroing/initializing guest memory as the untrusted host (kernel/KVM) doesn't have
> > > access to the guest's encryption key.  In other words, zeroing in the kernel would
> > > be unnecessary work.
> > 
> > Making and unmapped allocation without __GFP_ZERO shouldn't be a problem. 
> > 
> > However, using a gfp flag and hooking up into the free path in page
> > allocator have issues and preferably should be avoided.
> > 
> > Will something like unmapped_alloc() and unmapped_free() work for your
> > usecase?
> 
> Yep, I'm leaning more and more towards having KVM implement its own ioctl() for
> managing this type of memory.  Wiring that up to use dedicated APIs should be no
> problem.

Ok, I've dropped the GFP flag and made unmapped_pages_{alloc,free} the only
APIs.

Totally untested version of what I've got is here:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=unmapped-alloc/rfc-v2

I have some thoughts about adding support for 1G pages, but this is still
really vague at the moment.
 
> Thanks!

-- 
Sincerely yours,
Mike.
