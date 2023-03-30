Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F916D10AB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjC3VQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjC3VQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:16:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2544C19A6;
        Thu, 30 Mar 2023 14:16:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDED8621AE;
        Thu, 30 Mar 2023 21:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1023C433EF;
        Thu, 30 Mar 2023 21:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680210978;
        bh=ooDK8+6y9Kfl0/zn/9ZI2cFoW7WtHh5MrFLIEToNiIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uNYvhDsrd/8GYB4SrpR4BA1Vfz2wk8PiEsL9XRLUpzDFfMoMls1tgud9ukrx0azHj
         JvzJkEnzphOTnxtfBRgaQ5PIfQzkq/JDRnTAO8zTdvrgLmuf3krSiosoGpIeVKBnZ7
         Gqa04fN9aWWXGsZbWYJuQyeVdE1qfsMOWgKBsLKGhjDGGEbEa0QaifrwktZmC3JTh3
         PboJCO8b6NNrcngCMt00P8DTIZvFB+BDNUlKoCaFBY+iiOSa7v34nuzNjqSW4Cu8U1
         gmR7v3tj3XO2IV1pLRQO5cZEa0duPe2Qd9bPP63wJB7YpmSY/zBzsW5cWBkyffMQlh
         1K2ObDSWMGRnQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A6B004052D; Thu, 30 Mar 2023 18:16:15 -0300 (-03)
Date:   Thu, 30 Mar 2023 18:16:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Andreas Herrmann <aherrmann@suse.de>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bench numa: Fix for loop in do_work
Message-ID: <ZCX8H9LsUOd+tL6A@kernel.org>
References: <20230330074202.14052-1-aherrmann@suse.de>
 <b2a9b1eb-e8a4-31c2-db33-5fa8ecc862da@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2a9b1eb-e8a4-31c2-db33-5fa8ecc862da@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 30, 2023 at 09:31:31AM +0100, James Clark escreveu:
> 
> 
> On 30/03/2023 08:42, Andreas Herrmann wrote:
> > j is of type int and start/end are of type long. Thus j might become
> > negative and cause segfault in access_data(). Fix it by using long for
> > j as well.
 
> > Signed-off-by: Andreas Herrmann <aherrmann@suse.de>
> > ---
> >  tools/perf/bench/numa.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Example of segfault (with 6.3.0-rc4) is:
> > 
> > # ./perf bench numa mem -d -m -p 2 -t 12 -P 25425
> > ...
> >  threads initialized in 6.052135 seconds.
> >  #
> > perf: bench/numa.c:1654: __bench_numa: Assertion `!(!(((wait_stat) & 0x7f) == 0))' failed.
> > Aborted (core dumped)
> > # dmesg | grep segfault
> > [78812.711311] thread 1/3[43215]: segfault at 7f07936c9ec0 ip 00000000004ab6d0 sp 00007f0acb1f9cb0 error 4
> > [78812.711309] thread 1/9[43221]: segfault at 7f08bda71a70 ip 00000000004ab6d0 sp 00007f0ac81f3cb0 error 4
> > [78812.711316] thread 1/4[43216]: segfault at 7f07ccf76a08 ip 00000000004ab6d0 sp 00007f0aca9f8cb0 error 4
> > [78812.711325] thread 1/2[43214]: segfault at 7f08be2f44b0 ip 00000000004ab6d0 sp 00007f0acb9facb0 error 4
> > [78812.711328] thread 1/8[43220]: segfault at 7f06d3096b20 ip 00000000004ab6d0 sp 00007f0ac89f4cb0 error 4
> > [78812.711345] thread 1/6[43218]: segfault at 7f0774b46a18 ip 00000000004ab6d0 sp 00007f0ac99f6cb0 error 4 in perf[400000+caa000] likely on CPU 6 (core 8, socket 0)
> > [78812.711366] thread 0/0[43224]: segfault at 7f08a936b130 ip 00000000004ab6d0 sp 00007f0acc9fccb0 error 4 in perf[400000+caa000] likely on CPU 1 (core 1, socket 0)
> > 
> > diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> > index 9717c6c17433..1fbd7c947abc 100644
> > --- a/tools/perf/bench/numa.c
> > +++ b/tools/perf/bench/numa.c
> > @@ -847,7 +847,7 @@ static u64 do_work(u8 *__data, long bytes, int nr, int nr_max, int loop, u64 val
> >  
> >  	if (g->p.data_rand_walk) {
> >  		u32 lfsr = nr + loop + val;
> > -		int j;
> > +		long j;
> >  
> >  		for (i = 0; i < words/1024; i++) {
> >  			long start, end;
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, applied.

- Arnaldo

