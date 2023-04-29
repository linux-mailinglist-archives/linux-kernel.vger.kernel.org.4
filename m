Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DC06F222A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347288AbjD2Bom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347167AbjD2Boj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:44:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5512D49;
        Fri, 28 Apr 2023 18:44:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1ABB61CB5;
        Sat, 29 Apr 2023 01:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E4DC433D2;
        Sat, 29 Apr 2023 01:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682732677;
        bh=I063xDCEf57sq9X6LGhxryElZSMY8cOlcd0qMbRJ7Mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tH+bqRGWKKCqR3gQrbloXKcJOL+gNvMiXlaDhUDuHwgbXv9qtjEZPuZaKIvr4535p
         xMPT7vFXGCmWzusrNdFu82pIoOuLkhIYzWPtZjchLI4mcPf1MxATAMX3QnB9A+odJ+
         ey2B9cUsMDLbcdcbTjqyMktC8nPCgXrRR8ObVN26EthcPdKe1IIPukHhd3uW+dgFHw
         oOQcj7FZ7ca0xjaj6yvS9dj3zZ2cKoRuZcJmAFWKdesGflMqXRf7AYs4GQdY5V0+cO
         8hDC6dpAFT5LL2n+Fi3xFpmAteyQESKc/tw+BPVAq7Onq8Rf+yR5uoMMFDQy9SWsG+
         +xL+y5Bxy893w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6BF51403B5; Fri, 28 Apr 2023 22:44:34 -0300 (-03)
Date:   Fri, 28 Apr 2023 22:44:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>
Cc:     Dmitry Dolgov <9erthalion6@gmail.com>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com
Subject: Re: [RFC PATCH] perf stat: Separate bperf from bpf_profiler
Message-ID: <ZEx2gsEOWNxXaY/+@kernel.org>
References: <20230412182316.11628-1-9erthalion6@gmail.com>
 <20230421205610.xawzzfy36iskcoyx@erthalion.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421205610.xawzzfy36iskcoyx@erthalion.local>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 21, 2023 at 10:56:10PM +0200, Dmitry Dolgov escreveu:
> > On Wed, Apr 12, 2023 at 08:23:16PM +0200, Dmitrii Dolgov wrote:
> > It seems that perf stat -b <prog id> doesn't produce any results:
> >
> >     $ perf stat -e cycles -b 4 -I 10000 -vvv
> >     Control descriptor is not initialized
> >     cycles: 0 0 0
> >                 time        counts unit      events
> > 	10.007641640    <not supported>      cycles
> >
> > Looks like this happens because fentry/fexit progs are getting loaded, but the
> > corresponding perf event is not enabled and not added into the events bpf map.
> > I think there is some mixing up between two type of bpf support, one for bperf
> > and one for bpf_profiler. Both are identified via evsel__is_bpf, based on which
> > perf events are enabled, but for the latter (bpf_profiler) a perf event is
> > required. Using evsel__is_bperf to check only bperf produces expected results:
> 
> Any thoughts on this? I would appreciate clarifications if I'm missing
> something.

Namhyung, Song, can you please take a look at this?

- Arnaldo
