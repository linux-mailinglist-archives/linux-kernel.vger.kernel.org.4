Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91587709B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjESPrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjESPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:47:51 -0400
Received: from out-20.mta1.migadu.com (out-20.mta1.migadu.com [IPv6:2001:41d0:203:375::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178AB128
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:47:50 -0700 (PDT)
Date:   Fri, 19 May 2023 11:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684511266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fasz5CKzUC1yAWqOA9RyNvs+D0MVd+kzXi06AjZXfzk=;
        b=AxFce45LR8ceWjWQIf5kqgG5BRwR6+PUEnj0pY00HSyEnOqSZqn0aqvOBCi/BzDY256sHS
        SW50sek0Ah+C50zdyoyQ/4+nd2YbMLyG7V0mcqlbaV45yfmOyjQZvXihZCH1ptG40sxXVd
        HA/eg59DOhs6affhHbmvW06YACgdZms=
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
Message-ID: <ZGeaHpWTWPUSsmxs@moria.home.lan>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan>
 <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
 <ZGZW0v3nRShO7r+Z@moria.home.lan>
 <CAPhsuW5BbbxinaH2aO=2Wa0aSQ3pkNwvnrgJv7fG4QcPr_j7+Q@mail.gmail.com>
 <ZGZfLHA8vuRJwa0f@moria.home.lan>
 <20230519082945.GE4967@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519082945.GE4967@kernel.org>
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

On Fri, May 19, 2023 at 11:29:45AM +0300, Mike Rapoport wrote:
> Your allocator implicitly relies on vmalloc because of module_alloc ;-)
> 
> What I was thinking is that we can replace module_alloc() calls in your
> allocator with something based on my unmapped_alloc(). If we make the part
> that refills the cache also take care of creating the mapping in the
> module address space, that should cover everything.

Yeah, that's exactly what I was thinking :)

Liam was also just mentioning on IRC vmalloc lock contention came up
again at LSF, and that's historically always been an isuse - going with
your patchset for the backend nicely avoids that.

If I have time (hah! big if :) I'll see if I can cook up a patchset that
combines our two approaches over the weekend.
