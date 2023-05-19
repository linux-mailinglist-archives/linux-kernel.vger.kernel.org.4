Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37871708D49
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 03:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjESBYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 21:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESBYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 21:24:39 -0400
Received: from out-25.mta1.migadu.com (out-25.mta1.migadu.com [IPv6:2001:41d0:203:375::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F61899
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 18:24:38 -0700 (PDT)
Date:   Thu, 18 May 2023 21:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684459475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CxkuaiRuEcb1M9z9WtlkE7aQYUGvPRKev/aoddhrhbo=;
        b=JT/aBHaHjFl2Dp02kpXdGkoH1gI+ffXh3WrzhxdRImncKNfVqjq/9MGQAuevdHmheu4sW1
        WU36TUKiPVnJhzQ99pQz9s5O6FqPCPsmxydT591Bbof8JzxMKks3CJKP9bZUcJYsmafilR
        co2szWS28R7lML9AcPulGFRoBFIGKqc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Song Liu <song@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Message-ID: <ZGbPz109t9Huxrqy@moria.home.lan>
References: <ZGWdHC3Jo7tFUC59@moria.home.lan>
 <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
 <ZGZW0v3nRShO7r+Z@moria.home.lan>
 <CAPhsuW5BbbxinaH2aO=2Wa0aSQ3pkNwvnrgJv7fG4QcPr_j7+Q@mail.gmail.com>
 <ZGZfLHA8vuRJwa0f@moria.home.lan>
 <CAPhsuW6B3O_kWjWwr+UfYO3WRkznFqBNtcecFCSECBSiZBJDsA@mail.gmail.com>
 <CAPhsuW4Mm8z4kbVo8-sPU=QL2B1Sb32ZO7teWT8qienGNuxaeQ@mail.gmail.com>
 <ZGZ5PuQxDnjHlxAY@moria.home.lan>
 <CAPhsuW4A8H00MV=tT9Gs_mtjn7o9KOzPjhwhdWDJMbY_9=9RrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4A8H00MV=tT9Gs_mtjn7o9KOzPjhwhdWDJMbY_9=9RrQ@mail.gmail.com>
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

On Thu, May 18, 2023 at 01:51:08PM -0700, Song Liu wrote:
 
> To allocate memory for text, we will allocate 2MiB, make it ROX, and then
> use it for many small allocations. IIUC, buddy allocator will use unallocated
> parts of this page for metadata. I guess this may be a problem, as the
> whole page is ROX now, and we have to use text_poke to write to it.

The standard kernel buddy allocator does _not_ store anything in the
page itself - because the page might be a highmem page.

That's also why I went with the bitmap for my slab allocator; standard
kernel slab allocator stores a freelist ptr in free objects.
