Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78B965376D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiLUUPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUUPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:15:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6B8B17
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:15:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72C9061926
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A559AC433EF;
        Wed, 21 Dec 2022 20:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671653718;
        bh=zwS4HPe49H8QrBBgPONoHxkOglzUkSxFJ1Px7xGQnKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ab0ZdPdA6MUyKsyDpZfu1dxZxx3DsrKi3/UdPeM2YjbNOlF4Lw8mXROixUTC9Zbgh
         ix8r1q5X9TyqaO0W75Bbmx23d7XPGvSwnJTHnaUrgXVelNuWUGmq75GNCygkybe+xx
         rd4ff15BOGMtwZ4v/B7IWUwsxJB2tm4zu6jcsgmi8CGllg8D2WXeQjw4PWLgt/Aes4
         o7OKupwvSy36sQUReGGrqMxV5Tgv5V+ESQcyzK5irsRqCuqqi7rBzREIfk/LoB0KyQ
         ZuTBSj8zg0E/sCJyvpk2s1A2BITsKW64OEdspb2/dMqCUNJp1mbidBznSPAIqI7YUy
         +jAZSwqi1c0dQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C7A6D40367; Wed, 21 Dec 2022 17:15:15 -0300 (-03)
Date:   Wed, 21 Dec 2022 17:15:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Hans-Peter Nilsson <hp@axis.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH] perf arm64: Fix mksyscalltbl, don't lose syscalls due to
 sort -nu
Message-ID: <Y6NpUyLRR0f9sQ9C@kernel.org>
References: <20201228023941.E0DE2203B5@pchp3.se.axis.com>
 <20201229030933.GC28115@leoy-ThinkPad-X240s>
 <Y4Cspv98j8TqwCqZ@axis.com>
 <Y4C66dg+9wwiXdVs@leoy-yangtze.lan>
 <98978f82-eb78-4fa7-901e-76c3070362e3@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98978f82-eb78-4fa7-901e-76c3070362e3@app.fastmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 25, 2022 at 02:56:31PM +0100, Arnd Bergmann escreveu:
> On Fri, Nov 25, 2022, at 13:54, Leo Yan wrote:
> > On Fri, Nov 25, 2022 at 12:53:10PM +0100, Vincent Whitchurch wrote:
> 
> >> It looks like this patch was never applied?  AFAICS it is still needed
> >> on current HEAD and it still applies cleanly.
> >
> > Thanks a lot for bringing up this.
> >
> > Before there have a discussion [1] for refactoring Arm64 system call
> > table but it didn't really happen.
> 
> I actually worked on this last week and did a new series to convert
> the old asm-generic/unistd.h header into the syscall.tbl format,
> and change arm64 to use that.
> 
> You can find my work in the 'syscall-tbl' branch of my asm-generic
> tree [1]. This has only seen light build testing so far, and is
> probably still buggy, but most of the work is there. The missing
> bits are the Makefiles for the other seven architectures using
> asm-generic/unistd.h, and checking the output to ensure the
> contents are still the same.
> 
> > I think it's the right thing to merge
> > this patch, @Arnaldo, could you pick up this patch?

So I'm adding the provided:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

 
> That sounds fine to me.

And taking this as an:

Acked-by: Arnd Bergmann <arnd@arndb.de>

ok?

- Arnaldo
 
>     Arnd
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/
