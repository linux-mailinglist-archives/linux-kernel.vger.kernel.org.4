Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6E06DD56A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjDKI2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjDKI1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:27:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCC535B5;
        Tue, 11 Apr 2023 01:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d94WdOGKlgyLCpmEE9HUoxzwVon/CWYc2gTA65rEkLw=; b=jwr3fWUoxFDQwdNXMgNZGsAiWH
        6uBwAeaj6fBLAhSU+ikjoqf87c6dT3y2vd5fZlDFOPRWproxKmvueJ/3+ZsYYSd6XnSh6sw/yGRJx
        AmOa2Dhke3+kgUwvEBuXucMJKy7hFVUsSJqNeIcODQ/psk71Bw2vPuqjo7V2uB5fj38hYCaNpoTOx
        tmgtu2B0GHPTWKkaWfEE3GTMz6OWQEgS09eEg8x1eWSQK3TQTqOuT1oPEogMbWlZ+h8bElUM2Rzrq
        luHsX9j9ikDe/W+1N0O2BfgijPgZUyqjl/C9XIc/+4DJS/d3kFPC+CeAm/vF37dGUoitW044un5S5
        W8fuFwyQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pm9Jv-005g72-Ka; Tue, 11 Apr 2023 08:25:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B037E300244;
        Tue, 11 Apr 2023 10:25:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 696412CB2BF7D; Tue, 11 Apr 2023 10:25:38 +0200 (CEST)
Date:   Tue, 11 Apr 2023 10:25:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, jgross@suse.com, andrew.cooper3@citrix.com,
        Jason@zx2c4.com, thomas.lendacky@amd.com, puwen@hygon.cn,
        x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/Documentation: Add documentation about cluster
Message-ID: <20230411082538.GA578657@hirez.programming.kicks-ass.net>
References: <20230410163527.1626-1-kprateek.nayak@amd.com>
 <20230410163527.1626-3-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410163527.1626-3-kprateek.nayak@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 10:05:27PM +0530, K Prateek Nayak wrote:
> x86 processors map cluster to the L2 cache. Add documentation stating
> the same, and provide more information on the values and API related to
> CPU clusters exposed by the kernel.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  Documentation/x86/topology.rst | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
> index 7f58010ea86a..35991d8cdef1 100644
> --- a/Documentation/x86/topology.rst
> +++ b/Documentation/x86/topology.rst
> @@ -33,6 +33,7 @@ historical nature and should be cleaned up.
>  The topology of a system is described in the units of:
>  
>      - packages
> +    - cluster
>      - cores
>      - threads
>  
> @@ -90,6 +91,27 @@ Package-related topology information in the kernel:
>          Cache. In general, it is a number identifying an LLC uniquely on the
>          system.
>  
> +
> +Clusters
> +========
> +A cluster consists of 1 or more threads. It does not matter whether the threads
> +are SMT- or CMT-type threads. All the threads of a cluster share the same L2
> +cache.

I'm not quite sure that's a correct discription of what a cluster is.

Yes, SMT will fundamentally share core-level caches (and should we not
always have SMT share all cache topoligies?)

But there is also x86 where L2 is shared between multiple cores -- while
the above seems to suggest L2 is single core only.
