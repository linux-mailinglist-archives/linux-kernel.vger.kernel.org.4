Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68036B9FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCNT2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjCNT2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:28:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0A520078
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IM4khn4GtbmqwaIsQOUzIWmrkPO0gB55gbrq4UdSVUU=; b=hd7xzvj2rEQPbxHw2RDegC5Wjx
        peASnKn4Dlcp6Vt4q31NNRGjoha1gaqRlH1ti8Dkw4nRA13kRHjlUbvBqX0kVBsnGxUzVTPBexbUZ
        G2Vbi+xF6OS5xWGP5FnZVsnN5XFjpNFCmtRypGvkl+rTqBe2wT2RV69vOa8RttlDBR+eUpQasAp/6
        3KEvuCyjis6/Go95vtWNOX5OrSP7orRygBDx3DRC6LN8CeYZ4gyW7rdp9/GuddxuMUFyAIO5Ggwdn
        fcprzZGQX8JcOUxOFyGv06VP9klMhqr39FyfdaoGQEG2ayvVOMDJRyjxX/SesMJrCnCJ0bThTdjhX
        29XABf+A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pcAJC-001sca-1U;
        Tue, 14 Mar 2023 19:27:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E539F3001F7;
        Tue, 14 Mar 2023 20:27:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B888024083AA3; Tue, 14 Mar 2023 20:27:40 +0100 (CET)
Date:   Tue, 14 Mar 2023 20:27:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Timo Beckers <timo@incline.eu>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf core: apply calculated padding to PERF_SAMPLE_RAW
 output
Message-ID: <20230314192740.GQ2017917@hirez.programming.kicks-ass.net>
References: <20200519132616.794171-1-timo@incline.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519132616.794171-1-timo@incline.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 03:26:16PM +0200, Timo Beckers wrote:
> Zero the amount of padding bytes determined in perf_prepare_sample().
> This prevents garbage being read from the ring buffer after it has wrapped
> the page boundary at least once.

But it's user garbage, right? And they should be unconsumed anyway.

> Signed-off-by: Timo Beckers <timo@incline.eu>
> ---
>  kernel/events/core.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 80cf996a7f19..d4e0b003ece0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6807,8 +6807,16 @@ void perf_output_sample(struct perf_output_handle *handle,
>  					break;
>  				frag = frag->next;
>  			} while (1);
> -			if (frag->pad)
> -				__output_skip(handle, NULL, frag->pad);
> +			/*
> +			 * The padding value is determined in
> +			 * perf_prepare_sample() and is not
> +			 * expected to exceed u64.
> +			 */
> +			if (frag->pad) {
> +				u64 zero = 0;
> +
> +				__output_copy(handle, &zero, frag->pad);
> +			}
>  		} else {
>  			struct {
>  				u32	size;
> -- 
> 2.26.2
> 
