Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886E6669590
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbjAMLcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241239AbjAMLac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:30:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EFD8BF21
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n0AXcXCsFPlAjGu9o7oei/FdERzg6c37kBTY02Z4BpE=; b=uokiWcI9H//1Dn6M/QoEj1i9Ok
        Y3EHjyT+XkYYCzazVeTqUNHLxnIjJcNdk9ZOz/08aIqaI1LyVhJ762EupHNVCvLZAIDUjISddAEZQ
        fThvEbXHtejsicb3Jxz2WseKDHMbqMEl31Twi89i3HzygpHzwe2UD1wZnIKrnpDzy8p3u2lSiTXt7
        j4GORiBilj8YHfIAhzpqgle2Q7s8akd6yJSvB64zbIXBZuKLPf4RCPWwDk+SRxe2GkzWvSIfMWRpr
        2BysJnj8+yUaHu+1LrA4ACXQwIi021yhCkOokLHNWJJxLSCtbNKw8WJZMQCJTllLbPLLT6AMwa92u
        McrP23+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGI6g-0062jE-9Z; Fri, 13 Jan 2023 11:20:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91C963001F7;
        Fri, 13 Jan 2023 12:20:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81FFD2CCEBAC4; Fri, 13 Jan 2023 12:20:08 +0100 (CET)
Date:   Fri, 13 Jan 2023 12:20:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>
Subject: Re: [PATCH 5/8] perf/core: Set data->sample_flags in
 perf_prepare_sample()
Message-ID: <Y8E+aPblzA/mH+Vh@hirez.programming.kicks-ass.net>
References: <20230112214015.1014857-1-namhyung@kernel.org>
 <20230112214015.1014857-6-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112214015.1014857-6-namhyung@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 01:40:12PM -0800, Namhyung Kim wrote:

> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7053,6 +7053,14 @@ static void perf_aux_sample_output(struct perf_event *event,
>  	ring_buffer_put(rb);
>  }
>  
> +/*
> + * A set of common sample data types saved even for non-sample records
> + * when event->attr.sample_id_all is set.
> + */
> +#define PERF_SAMPLE_ID_ALL  (PERF_SAMPLE_TID | PERF_SAMPLE_TIME |	\
> +			     PERF_SAMPLE_CPU | PERF_SAMPLE_ID |		\
> +			     PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_STREAM_ID)
> +


>  	__perf_event_header__init_id(header, data, event, filtered_sample_type);
> +	data->sample_flags |= sample_type & PERF_SAMPLE_ID_ALL;

Why not update __perf_event_header__init_id() ?
