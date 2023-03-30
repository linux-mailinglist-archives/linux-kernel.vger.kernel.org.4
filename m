Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149F66CFE57
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjC3Icf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjC3Ibu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:31:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3F5265A1;
        Thu, 30 Mar 2023 01:31:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B49512F4;
        Thu, 30 Mar 2023 01:32:17 -0700 (PDT)
Received: from [10.57.18.220] (unknown [10.57.18.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFC3B3F73F;
        Thu, 30 Mar 2023 01:31:32 -0700 (PDT)
Message-ID: <b2a9b1eb-e8a4-31c2-db33-5fa8ecc862da@arm.com>
Date:   Thu, 30 Mar 2023 09:31:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] perf bench numa: Fix for loop in do_work
Content-Language: en-US
To:     Andreas Herrmann <aherrmann@suse.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20230330074202.14052-1-aherrmann@suse.de>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230330074202.14052-1-aherrmann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/03/2023 08:42, Andreas Herrmann wrote:
> j is of type int and start/end are of type long. Thus j might become
> negative and cause segfault in access_data(). Fix it by using long for
> j as well.
> 
> Signed-off-by: Andreas Herrmann <aherrmann@suse.de>
> ---
>  tools/perf/bench/numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Example of segfault (with 6.3.0-rc4) is:
> 
> # ./perf bench numa mem -d -m -p 2 -t 12 -P 25425
> ...
>  threads initialized in 6.052135 seconds.
>  #
> perf: bench/numa.c:1654: __bench_numa: Assertion `!(!(((wait_stat) & 0x7f) == 0))' failed.
> Aborted (core dumped)
> # dmesg | grep segfault
> [78812.711311] thread 1/3[43215]: segfault at 7f07936c9ec0 ip 00000000004ab6d0 sp 00007f0acb1f9cb0 error 4
> [78812.711309] thread 1/9[43221]: segfault at 7f08bda71a70 ip 00000000004ab6d0 sp 00007f0ac81f3cb0 error 4
> [78812.711316] thread 1/4[43216]: segfault at 7f07ccf76a08 ip 00000000004ab6d0 sp 00007f0aca9f8cb0 error 4
> [78812.711325] thread 1/2[43214]: segfault at 7f08be2f44b0 ip 00000000004ab6d0 sp 00007f0acb9facb0 error 4
> [78812.711328] thread 1/8[43220]: segfault at 7f06d3096b20 ip 00000000004ab6d0 sp 00007f0ac89f4cb0 error 4
> [78812.711345] thread 1/6[43218]: segfault at 7f0774b46a18 ip 00000000004ab6d0 sp 00007f0ac99f6cb0 error 4 in perf[400000+caa000] likely on CPU 6 (core 8, socket 0)
> [78812.711366] thread 0/0[43224]: segfault at 7f08a936b130 ip 00000000004ab6d0 sp 00007f0acc9fccb0 error 4 in perf[400000+caa000] likely on CPU 1 (core 1, socket 0)
> 
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index 9717c6c17433..1fbd7c947abc 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -847,7 +847,7 @@ static u64 do_work(u8 *__data, long bytes, int nr, int nr_max, int loop, u64 val
>  
>  	if (g->p.data_rand_walk) {
>  		u32 lfsr = nr + loop + val;
> -		int j;
> +		long j;
>  
>  		for (i = 0; i < words/1024; i++) {
>  			long start, end;

Reviewed-by: James Clark <james.clark@arm.com>
