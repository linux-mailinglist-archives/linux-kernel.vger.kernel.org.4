Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B602C628664
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbiKNQ76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbiKNQ7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:59:39 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036BDC4F;
        Mon, 14 Nov 2022 08:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9e5AgUgVzAyNV5aU466g5ziNE/XuCNRUZZc6InKoLck=; b=WyTPzafJ3ucAqaJlfdjyQSwtiK
        ampvsL4FPeGjohstXzkZ7Ixg9KMVAoGG6hYoKPXANEmIX3RNJpswI+IfwBVDtImhvuc3Z/fX5DnbP
        cU7xZfkS/65K/MQfbaEew5HOvcdulcGN5IszKylj3S87XV/w4BsBOwenlHKSJeFLkBoONpryIR78G
        T9api4OsSP9XPrLhBTa8vJh2Rj6uaWjJdVj909+95ErhhntZeFQqoVbVdf0coZXjPVjVfjv0rKEIl
        6kt8el9AoKIGFRDrTySblmknmftnYrFWhw6QRcEcIFkP8JOxsp1idt6nYYL5MmxYDEszyCYNXWwJg
        Dre86OuQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oucmw-000q4h-6P; Mon, 14 Nov 2022 16:58:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D761B300392;
        Mon, 14 Nov 2022 13:59:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8386E201D9E1E; Mon, 14 Nov 2022 13:59:28 +0100 (CET)
Date:   Mon, 14 Nov 2022 13:59:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/pt: Fix sampling using single range output
Message-ID: <Y3I7sIjlhQix81P2@hirez.programming.kicks-ass.net>
References: <20221112151508.13768-1-adrian.hunter@intel.com>
 <Y3IdnRgEPq2FN/ZX@hirez.programming.kicks-ass.net>
 <dfbeecdb-c97c-993f-da03-5f3d1f141c61@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfbeecdb-c97c-993f-da03-5f3d1f141c61@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 01:10:38PM +0200, Adrian Hunter wrote:
> On 14/11/22 12:51, Peter Zijlstra wrote:
> > On Sat, Nov 12, 2022 at 05:15:08PM +0200, Adrian Hunter wrote:
> >> Deal with errata TGL052, ADL037 and RPL017 "Trace May Contain Incorrect
> >> Data When Configured With Single Range Output Larger Than 4KB" by
> >> disabling single range output whenever larger than 4KB.
> >>
> >> Fixes: 670638477aed ("perf/x86/intel/pt: Opportunistically use single range output mode")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  arch/x86/events/intel/pt.c | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> >> index 82ef87e9a897..42a55794004a 100644
> >> --- a/arch/x86/events/intel/pt.c
> >> +++ b/arch/x86/events/intel/pt.c
> >> @@ -1263,6 +1263,15 @@ static int pt_buffer_try_single(struct pt_buffer *buf, int nr_pages)
> >>  	if (1 << order != nr_pages)
> >>  		goto out;
> >>  
> >> +	/*
> >> +	 * Some processors cannot always support single range for more than
> >> +	 * 4KB - refer errata TGL052, ADL037 and RPL017. Future processors might
> >> +	 * also be affected, so for now rather than trying to keep track of
> >> +	 * which ones, just disable it for all.
> >> +	 */
> >> +	if (nr_pages > 1)
> >> +		goto out;
> > 
> > This effectively declares single-output-mode dead? Because I don't think
> > anybody uses PT with a single 4K buffer.
> 
> 4K is the default size for "sample mode" i.e. stuffing 4KB of Intel PT trace
> data into a PERF_RECORD_SAMPLE record that has sample_type bit PERF_SAMPLE_AUX
> 
> e.g.
> 
> $ perf record -vv --aux-sample -e '{intel_pt//u,cycles:u}' uname 2>err.txt
> Linux
> $ grep aux_sample_size err.txt
>   aux_sample_size                  4096

Ah, ok. Not as bad then. Anyway, I'll go queue it for perf/urgent I
suppose.
