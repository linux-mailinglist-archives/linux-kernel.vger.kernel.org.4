Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33A768C0DF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjBFPBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjBFPBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:01:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931E9CC3A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:01:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 232BB60F2C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556BCC433EF;
        Mon,  6 Feb 2023 15:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675695707;
        bh=2LRKdKOaNqCC85NunxrVKFXipExY9FqqQHiKzen8y1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RK6XyJp5fYrRFxV8w0YIO42iN3t5UpMTp+tTpekZDVd1Uy8sO2WYIeBCz0AlcvW8I
         t6G8LL7H+gf1RbCtUZWTsZyfS6bKcImVnov5Mf5E5oEiVfHYcVIhUkd9RlzZqQDJUz
         wPZDs8PoN8M32/hju3zFftQT9FgeVdXsAzyZLCIRTQ6ab2tQYxco8zGLHKdv3jvE0n
         SclI64eEM5iE7v2IvVGDUSFhO6mqMWp8ubCcWPDgecIFoWuJg4bHBaK5rPhwPrpFX3
         qvSY3+X0MJ5xUIBb0RDydtX8mPnYvI5yP/hoDV5k8UEC7+ZNC4sLcF6/6cxqNPhTv6
         FuDRYmQW2y8Bw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9ABFF405BE; Mon,  6 Feb 2023 12:01:44 -0300 (-03)
Date:   Mon, 6 Feb 2023 12:01:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com, irogers@google.com
Subject: Re: [PATCH V3 3/3] perf test: Support the retire_lat check
Message-ID: <Y+EWWLaBj1OPrkLo@kernel.org>
References: <20230202192209.1795329-1-kan.liang@linux.intel.com>
 <20230202192209.1795329-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202192209.1795329-3-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 02, 2023 at 11:22:09AM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Add test for the new field for Retire Latency in the X86 specific test.

Is this passing 'perf test' for you?

[root@quaco ~]# perf test -v "x86 sample parsing"
 74: x86 Sample parsing                                              :
--- start ---
test child forked, pid 72526
Samples differ at 'retire_lat'
parsing failed for sample_type 0x1000000
test child finished with -1
---- end ----
x86 Sample parsing: FAILED!
[root@quaco ~]#

- Arnaldo
 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 
> New patch since V2
> 
>  tools/perf/arch/x86/tests/sample-parsing.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/x86/tests/sample-parsing.c b/tools/perf/arch/x86/tests/sample-parsing.c
> index 690c7c07e90d..a061e8619267 100644
> --- a/tools/perf/arch/x86/tests/sample-parsing.c
> +++ b/tools/perf/arch/x86/tests/sample-parsing.c
> @@ -27,8 +27,10 @@ static bool samples_same(const struct perf_sample *s1,
>  			 const struct perf_sample *s2,
>  			 u64 type)
>  {
> -	if (type & PERF_SAMPLE_WEIGHT_STRUCT)
> +	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
>  		COMP(ins_lat);
> +		COMP(retire_lat);
> +	}
>  
>  	return true;
>  }
> @@ -48,6 +50,7 @@ static int do_test(u64 sample_type)
>  	struct perf_sample sample = {
>  		.weight		= 101,
>  		.ins_lat        = 102,
> +		.retire_lat     = 103,
>  	};
>  	struct perf_sample sample_out;
>  	size_t i, sz, bufsz;
> -- 
> 2.35.1
> 

-- 

- Arnaldo
