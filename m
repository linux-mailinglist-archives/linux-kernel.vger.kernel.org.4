Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A37D627B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiKNKvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiKNKv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:51:26 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BCCFACD;
        Mon, 14 Nov 2022 02:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DZwhkgbexAAKX9BZyF/psTtU2EJVl4ELavZcHztgZAo=; b=GA0CkS7MIDxpPDY9/3Uiovp2l5
        70JaKqlVq3wG74jikmjDCiAj31wU7nO+sdA2VSmm8YuoJaYuWfPuPGTy803LRfiCFcjmGznVOgtgT
        C8aI3Ku2jwn8e6dqAJ7WAWshOyUMAza4isjjpelfdJGy5W2RfmiPRN6t5JSKTiNjuXiU+1QHGXBS6
        ZXFiW6MkFF9XC9k59D7d3F9nxjW/rfmpHA0+ueV//NLe+O37uY1VCxr38UtEYW59/emmo6Y3OwjLL
        +2Got6arMc1bYv+UNGn3MnPk35APrD/7aVU7STdFz9QMLnxql0DoTUmi6Sjb2dTwo2CC7hLdEKaNB
        mJkmq0ww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouX3X-000oEJ-Tf; Mon, 14 Nov 2022 10:51:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 045B1300642;
        Mon, 14 Nov 2022 11:51:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0F9E2B9781DD; Mon, 14 Nov 2022 11:51:09 +0100 (CET)
Date:   Mon, 14 Nov 2022 11:51:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/pt: Fix sampling using single range output
Message-ID: <Y3IdnRgEPq2FN/ZX@hirez.programming.kicks-ass.net>
References: <20221112151508.13768-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112151508.13768-1-adrian.hunter@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 05:15:08PM +0200, Adrian Hunter wrote:
> Deal with errata TGL052, ADL037 and RPL017 "Trace May Contain Incorrect
> Data When Configured With Single Range Output Larger Than 4KB" by
> disabling single range output whenever larger than 4KB.
> 
> Fixes: 670638477aed ("perf/x86/intel/pt: Opportunistically use single range output mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  arch/x86/events/intel/pt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> index 82ef87e9a897..42a55794004a 100644
> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c
> @@ -1263,6 +1263,15 @@ static int pt_buffer_try_single(struct pt_buffer *buf, int nr_pages)
>  	if (1 << order != nr_pages)
>  		goto out;
>  
> +	/*
> +	 * Some processors cannot always support single range for more than
> +	 * 4KB - refer errata TGL052, ADL037 and RPL017. Future processors might
> +	 * also be affected, so for now rather than trying to keep track of
> +	 * which ones, just disable it for all.
> +	 */
> +	if (nr_pages > 1)
> +		goto out;

This effectively declares single-output-mode dead? Because I don't think
anybody uses PT with a single 4K buffer.
