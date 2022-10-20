Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3137960635A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJTOlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJTOk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:40:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29A1144E38;
        Thu, 20 Oct 2022 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6sKArn3fl5+ouv8EYn7A1qXEQs1M7gQhoItikJI0JG8=; b=TxFdT5ShdrFFI1JVzL+bFVTMWP
        /9do5iqXYdMe5lUBOiGbBhoWfJuI0R+/+7if2AvKoB2Kzh5GjErgTwgPQDe1Px8JrQV1QFep4L2+E
        UeUevas2gpKatqsafsmX7JPRqhQ7AIGor6/rd23cHSAKEhk3pcieKGKEcoMnHFqr2WNAuH3BpfFBU
        WmVi8lK7BHvpDHcviVSnt/N6Hxiq4Rpc7sLKL8qirXDNDR/JDWWQJUFkUsN4noEtnzkpcHbxwGy2/
        jidGIha3Zg+HAvYGbFHdkXPzukCLpWeh+8vDlfEveauyRs9Wb2uO2R+aEWSbu7UhiCZ8IALdv85XH
        FL8SVRuw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olWiz-00CRqm-3Q; Thu, 20 Oct 2022 14:40:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B03C300209;
        Thu, 20 Oct 2022 16:40:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 335682BF40BC0; Thu, 20 Oct 2022 16:40:39 +0200 (CEST)
Date:   Thu, 20 Oct 2022 16:40:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com, james.clark@arm.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.ibm.com
Subject: Re: [PATCH] [perf/core: Update sample_flags for raw_data in
 perf_output_sample
Message-ID: <Y1Fd57P5I+aSNT/V@hirez.programming.kicks-ass.net>
References: <20221020070657.21571-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020070657.21571-1-atrajeev@linux.vnet.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 12:36:56PM +0530, Athira Rajeev wrote:
> commit 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> added check for PERF_SAMPLE_RAW in sample_flags in
> perf_prepare_sample(). But while copying the sample in memory,
> the check for sample_flags is not added in perf_output_sample().
> Fix adds the same in perf_output_sample as well.
> 
> Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4ec3717003d5..daf387c75d33 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7099,7 +7099,7 @@ void perf_output_sample(struct perf_output_handle *handle,
>  	if (sample_type & PERF_SAMPLE_RAW) {
>  		struct perf_raw_record *raw = data->raw;
>  
> -		if (raw) {
> +		if (raw && (data->sample_flags & PERF_SAMPLE_RAW)) {
>  			struct perf_raw_frag *frag = &raw->frag;
>  
>  			perf_output_put(handle, raw->size);

Urgh.. something smells here. We already did a PERF_SAMPLE_RAW test.

And perf_prepare_sample() explicitly makes data->raw be NULL when not
set earlier.

So what's going wrong?

