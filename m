Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B7270883C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjERTQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERTQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:16:21 -0400
Received: from out-45.mta0.migadu.com (out-45.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1570F183
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:16:20 -0700 (PDT)
Date:   Thu, 18 May 2023 15:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684437378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TIEsHmDJw+wUcZzTUBFJVwH5tzQA4gCbpTuGCgFIn34=;
        b=demm8gH/vvzwO5FuJLw8rlh2o4nyCGHOs0ZsRUwVEFxYcDxBsCYHkP+ADd6hknzEEC5tYv
        uMvnMcwKEEu+TkmXY2WBFQA1yhtpXI9VJ2dEEoRCK8W41lcuB5OLvGtCLcrDrjtFaVcP9E
        bsXjvc965z+E7Sp0cNcT6Zdu/iYt59s=
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
Message-ID: <ZGZ5f00iemeG3GpC@moria.home.lan>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan>
 <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
 <ZGZW0v3nRShO7r+Z@moria.home.lan>
 <CAPhsuW5BbbxinaH2aO=2Wa0aSQ3pkNwvnrgJv7fG4QcPr_j7+Q@mail.gmail.com>
 <ZGZfLHA8vuRJwa0f@moria.home.lan>
 <CAPhsuW6B3O_kWjWwr+UfYO3WRkznFqBNtcecFCSECBSiZBJDsA@mail.gmail.com>
 <CAPhsuW4Mm8z4kbVo8-sPU=QL2B1Sb32ZO7teWT8qienGNuxaeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4Mm8z4kbVo8-sPU=QL2B1Sb32ZO7teWT8qienGNuxaeQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:03:03PM -0700, Song Liu wrote:
> > Second, bitmap based solution cannot handle > 2MiB allocation cleanly,
> > while tree based solution can. For example, if a big driver uses 3MiB, the
> > tree based allocator can allocate 4MiB for it, and use the rest 1MiB for
> > smaller allocations.

2 MB is just a good default size for the initial unmapped allocations if
the main consideration is avoiding mapping fragmentation. The approach
can work with larger allocations if required.
