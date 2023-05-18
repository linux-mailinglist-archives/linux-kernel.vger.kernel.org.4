Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10BA708634
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjERQs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjERQs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:48:27 -0400
Received: from out-45.mta0.migadu.com (out-45.mta0.migadu.com [91.218.175.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E616410E
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:48:25 -0700 (PDT)
Date:   Thu, 18 May 2023 12:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684428504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1BJyFti2GSK6Ojcdhf1oqrHvjDqy4qKVqOaagfZXbM8=;
        b=B69OOOf99KKPTXqHA+bgu5GeyBKcn9r6JhoMGiKzX+giLnBWWwnzh2gd+oX0gtR1U9F5N3
        JPdn5RZdQDHj93zYae1uGFPgQWS+XGqALy1GJDVdowHGLeilE//EZ5Cm/Sanj+u2fymPxM
        e/NCrNvkFDq3i1jNiBH71I5vS36UZ9Q=
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
Message-ID: <ZGZW0v3nRShO7r+Z@moria.home.lan>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan>
 <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 09:33:20AM -0700, Song Liu wrote:
> I am working on patches based on the discussion in [1]. I am planning to
> send v1 for review in a week or so.

Hey Song, I was reviewing that thread too,

Are you taking a different approach based on Thomas's feedback? I think
he had some fair points in that thread.

My own feeling is that the buddy allocator is our tool for allocating
larger variable sized physically contiguous allocations, so I'd like to
see something based on that - I think we could do a hybrid buddy/slab
allocator approach, like we have for regular memory allocations.

I started on a slab allocator for executable memory allocations the
other day (very minimal, but tested it for bcachefs and it works).

But I'd love to hear more about your current approach as well.

Cheers,
Kent
