Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4F87086BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjERRZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjERRZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:25:22 -0400
Received: from out-51.mta0.migadu.com (out-51.mta0.migadu.com [91.218.175.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9819CE40
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:25:21 -0700 (PDT)
Date:   Thu, 18 May 2023 13:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684430719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKqBpaoltAO/ajrBPZAlORTTSmqeZGbRlc1Dj+Ak9FQ=;
        b=NlHdP7pvitZ3Unyi3tJqwD9jSc6oHRWYCiWz1dHu+mowncFLvy+eVV7dBvr4kRI1yv9R1a
        U4mYOUkAZgQeYRNwANPI8pv4VmrJQmazZk57dwQRetD27qbOsn0DJDzy6/odivs5V/hp3U
        d7zGBr/P30iyQ6pnf1AgvRGyll5+3Co=
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
Message-ID: <ZGZffIc9VHlnDsPf@moria.home.lan>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan>
 <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
 <ZGZZIM0qftr0T59b@moria.home.lan>
 <CAPhsuW4Ccu1oYw1WjqqX0a685VWxiieHZiPui_=BMAn8dV7ivQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4Ccu1oYw1WjqqX0a685VWxiieHZiPui_=BMAn8dV7ivQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 10:15:59AM -0700, Song Liu wrote:
> On Thu, May 18, 2023 at 9:58 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Thu, May 18, 2023 at 09:33:20AM -0700, Song Liu wrote:
> > > I am working on patches based on the discussion in [1]. I am planning to
> > > send v1 for review in a week or so.
> >
> > For reference, here's my own (early, but functioning :) slab allocator:
> >
> > Look forward to comparing!
> 
> This looks similar to the bpf_prog_pack allocator we use for BPF at the
> moment. (search for bpf_prog_pack in kernel/bpf/core.c). I guess we
> can also use bpf_prog_pack for bcachefs for now.

The code in bpf/core.c does a _lot_, my preference would be to split
that up and refactor the bpf code to use something generic :)
