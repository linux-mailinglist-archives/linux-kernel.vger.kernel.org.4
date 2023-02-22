Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A40D69FD0B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjBVUgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBVUgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:36:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114F338B47;
        Wed, 22 Feb 2023 12:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BEN4TQVxNPWEx7hwJvP/GS/RJsdusdDphuNNuthrAYU=; b=fdRbnWiea2gIQFySo8fX/v0ENQ
        V2LYJNL0Jn9pYU50c16nDn7SLpCNtGp2PTS3hVm+4mDVNigekAt8z1QFwcFR5bpWBLpBG2ihM/Mjg
        o49aW6qR7laIfhIOzJdw69ki4jJ6YPpqQVtujwmpHEcrIKRtWq036H8O4HYFArEP4pfYc68AJh6LI
        2w424XyBCkhvpDZL/CXRy3xT4niZuD1MWEsch9zN67Ez9lO63iysFblTgPTghLc+SK3s27e42ad58
        KMPyeAwjn2tLL+BxSC5pa+pNZ7mGJyVgOS0mTHtwmSaN5jMi37DtdovbWHgAuNepuYWzmPrjpl6EK
        NhDKHTrw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUvqE-00Dky7-LY; Wed, 22 Feb 2023 20:35:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 42FF0300193;
        Wed, 22 Feb 2023 21:35:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 257E220D8CD8C; Wed, 22 Feb 2023 21:35:53 +0100 (CET)
Date:   Wed, 22 Feb 2023 21:35:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH v2 1/3] perf/x86/core: Use sysfs_emit() in show()
 callback function
Message-ID: <Y/Z8qUYDXPFlzdsY@hirez.programming.kicks-ass.net>
References: <cover.1676987821.git.drv@mailo.com>
 <719558b8a435a6f942b2cc3f5c0431212be76bc6.1676987821.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <719558b8a435a6f942b2cc3f5c0431212be76bc6.1676987821.git.drv@mailo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 07:36:12PM +0530, Deepak R Varma wrote:
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 85a63a41c471..27c03e6dcb5d 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1896,9 +1896,7 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
>  		if (x86_pmu.hybrid_pmu[i].cpu_type & pmu->cpu_type) {
>  			next_str = strchr(str, ';');
>  			if (next_str)
> -				return snprintf(page, next_str - str + 1, "%s", str);
> -			else
> -				return sprintf(page, "%s", str);
> +				return sysfs_emit(page, "%s", str);
>  		}
>  		str = strchr(str, ';');
>  		str++;

How is this correct ?!?
