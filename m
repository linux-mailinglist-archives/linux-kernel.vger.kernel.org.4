Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE3709C52
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjESQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjESQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:22:33 -0400
Received: from out-18.mta0.migadu.com (out-18.mta0.migadu.com [91.218.175.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E210E5A
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:22:09 -0700 (PDT)
Date:   Fri, 19 May 2023 12:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684513327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jS7N446BC55zApIMrZSFqvh6pbEWEIcLk2UIU31xdu4=;
        b=lN2zfw8gNO/OMqfbr0uYHztfhitfdx5e/hNJOHTSoJ9Us95i+ewAfHw6KQ9Q/u9C+HNJ1j
        VU7xmtRTFb5O8Pl8N2aVNIKousjfCya6jyDU4VX7pipCVR1APNoOVtpRdX7StjFnlZv/nT
        XXkUhl3F9TViAyUvX7/fb9/hIKHj8Zk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Song Liu <song@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Message-ID: <ZGeiJhIo3J5atZHV@moria.home.lan>
References: <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan>
 <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
 <ZGZW0v3nRShO7r+Z@moria.home.lan>
 <CAPhsuW5BbbxinaH2aO=2Wa0aSQ3pkNwvnrgJv7fG4QcPr_j7+Q@mail.gmail.com>
 <ZGZfLHA8vuRJwa0f@moria.home.lan>
 <20230519082945.GE4967@kernel.org>
 <ZGeaHpWTWPUSsmxs@moria.home.lan>
 <20230519161414.GF4967@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519161414.GF4967@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 07:14:14PM +0300, Mike Rapoport wrote:
> Unfortunately not because we still need to map the pages in the modules
> area which is essentially a subset of vmalloc address space.

Why wouldn't we be doing that once per 2 MB page?

>  
> > If I have time (hah! big if :) I'll see if I can cook up a patchset that
> > combines our two approaches over the weekend.
> 
> Now there is also an interest about unmapped allocations from KVM folks, so
> I might continue pursuing unmapped allocator, probably just without a new
> GFP flag and hooks into page allocator.

Cool - it does seem like a generally valuable capability :)
