Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899C768A97F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 11:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjBDKhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 05:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDKhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 05:37:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C135928869;
        Sat,  4 Feb 2023 02:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sBVk4y8jI2P1MdjQADO2i5z2S1Y3e8OF8T5i6YaW5/s=; b=ZM0DdM2Rzq+Q8iGa8KVah+nR3U
        ZlmIlYPU71shYc60APr0n98pmiA6Urlnc7GE543r1mS2t/EFtQDoSGfPRply+hI+NILtEqMtHaYPi
        AES8YK/07g1WXZQuXNMs4goEcmx7otMwxOhMz64Or7GZnvzXxN9BeoChlm6fQTZJOagGMDq6orDdo
        0VJUqvKdWYbkONExbY2a1ZrWu8iDZUM/yqaKXLnVWqQYKRJGL8XBFVtUfstneJm5rLOmMWDFQyuzD
        LE8zFkiMae8j97fE+UBlPS/R0scF61voClAExpmvWV3+c5oBTgE6dyEDZ8khDYGC/uwSWy8C/3BmA
        +47zhm0g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOFuW-00F6RS-Kl; Sat, 04 Feb 2023 10:36:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 84D3B30068D;
        Sat,  4 Feb 2023 11:36:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6125F20AF917C; Sat,  4 Feb 2023 11:36:43 +0100 (CET)
Date:   Sat, 4 Feb 2023 11:36:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCH v4 7/8] perf: Add perf_event_attr::config3
Message-ID: <Y941O6eVNfpS3F5b@hirez.programming.kicks-ass.net>
References: <20220825-arm-spe-v8-7-v4-0-327f860daf28@kernel.org>
 <20220825-arm-spe-v8-7-v4-7-327f860daf28@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825-arm-spe-v8-7-v4-7-327f860daf28@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 01:26:23PM -0600, Rob Herring wrote:
> Arm SPEv1.2 adds another 64-bits of event filtering control. As the
> existing perf_event_attr::configN fields are all used up for SPE PMU, an
> additional field is needed. Add a new 'config3' field.
> 
> Tested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> There's still an unresolved discussion about validating 'config3' with
> the options laid out here[1].
> 
> v4:
>  - Rebase on v6.2-rc1
> v3:
>  - No change
> v2:
>  - Drop tools/ side update
> 
> [1] https://lore.kernel.org/all/Y49ttrv6W5k3ZNYw@FVFF77S0Q05N.cambridge.arm.com/
> ---
>  include/uapi/linux/perf_event.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index ccb7f5dad59b..37675437b768 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -374,6 +374,7 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
>  #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
>  #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
> +#define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
>  
>  /*
>   * Hardware event_id to monitor via a performance monitoring event:
> @@ -515,6 +516,8 @@ struct perf_event_attr {
>  	 * truncated accordingly on 32 bit architectures.
>  	 */
>  	__u64	sig_data;
> +
> +	__u64	config3; /* extension of config2 */
>  };

Yeah, that was bound to happen I suppose..

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
