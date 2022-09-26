Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFBD5EA8C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiIZOmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiIZOlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:41:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F17C5F8E;
        Mon, 26 Sep 2022 06:03:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B70360D28;
        Mon, 26 Sep 2022 13:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4537FC433C1;
        Mon, 26 Sep 2022 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664197401;
        bh=edJaC8g1NJfxM/VM8JJRmUgz2AQBoTwZ3IVbR7mOLq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DXTuqS1NXrFWtXtkxtylwVBsmXUV1U+2ku5hyqo+1zO5qQYJLrt5pVYDLZXh2C/ZL
         S/amDgP55wKJ22aTnyjiCEGPfnCfEnExHSA/4e7qHxj3PCTV45CHBul2J0lqL2Urfw
         ZAu6rfg7NbgaX0vQ5V2fT2hTVhw7Prwzyn6s0Yly6au2Adxa9G3d/pgzjmeDZ8t56n
         GzsE6m1jE9DhVFYcbDv++KXyo39Wcx4aVlycEmzNVTMWxk3GQw5g8UjAY5lECAqLb8
         dARMFHo0fyNGNgHSlKb8kkINoTxEZpzE6Za3fzTNy+Dk5ZzcPb5ElgoHHrhLgadX5y
         QzJxhGsN0q7Tg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DBEA3403B0; Mon, 26 Sep 2022 14:03:18 +0100 (IST)
Date:   Mon, 26 Sep 2022 14:03:18 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf record: Fix segmentation fault in
 record__read_lost_samples()
Message-ID: <YzGjFobeqkrilrEj@kernel.org>
References: <20220924113346.1110909-1-leo.yan@linaro.org>
 <CAM9d7ci2RJOTz08eGRgLMVpS0TmwN=q=UNA_Z3wbSHCC2pMygQ@mail.gmail.com>
 <Yy+rBbzvoTWOI+SJ@leoy-huanghe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy+rBbzvoTWOI+SJ@leoy-huanghe>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 25, 2022 at 09:12:37AM +0800, Leo Yan escreveu:
> Hi Namhyung,
> 
> On Sat, Sep 24, 2022 at 09:52:09AM -0700, Namhyung Kim wrote:
> 
> [...]
> 
> > > In the unprivileged mode perf fails to open PMU event, the function
> > > record__open() returns error and "session->evlist" is NULL; this leads
> > > to segmentation fault when iterates "session->evlist" in the function
> > > record__read_lost_samples().
> > >
> > > This patch checks "session->evlist" in record__read_lost_samples(), if
> > > "session->evlist" is NULL then the function directly bails out to avoid
> > > segmentation fault.
> > >
> > > Fixes: a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > 
> > Thanks for the fix and sorry for the inconvenience.
> > Actually I sent the same fix a few weeks ago.
> > 
> > https://lore.kernel.org/r/20220909235024.278281-1-namhyung@kernel.org
> 
> Thanks a lot for the info and fix.  The patch in above link looks good
> to me!  Please ignore this one.

Took that as an Acked-by: Leo, thanks!

- Arnaldo
