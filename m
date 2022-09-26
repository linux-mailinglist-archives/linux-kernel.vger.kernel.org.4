Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C9D5EB121
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiIZTQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiIZTQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:16:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB2A9A6BE;
        Mon, 26 Sep 2022 12:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F139B80D91;
        Mon, 26 Sep 2022 19:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC39DC433D7;
        Mon, 26 Sep 2022 19:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664219802;
        bh=i8EKvkC0Tr2VPkNQzzRCboiKkQ7L74SHdGwxYZgB0zE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jb9lcMcyJ+upkvHXzMW8Akjnqe6cZtfhnDBXsdwLD5EMINm+uU5ljyye4rPM0Wp0i
         e3SCYAwkuYur/jOcGct7P6IukXaCJBeJ5CDE26ozWImL97fCfLn9k6H0E8Y7m3R9Ik
         bWS+JdilMfDtTRjhJvdBltLrrkX9rBHPaF3U+EzKqAJj5H+8WtBW0EPpgGlvSYESRR
         bRbIyPSftQ19Pjk/koyJc8E6OkxQk6L4gM6c6mmMVjGviJiKQgx1jqTMIfWHJlrsxL
         0SgL6Xki0M/yOqJhcIM60aFHOB8xdyM7DUPjkwAUYn/zQixmLrjRo1BMHAW0MXYk2p
         Xt1lvhD1xdVCQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 008A5403B0; Mon, 26 Sep 2022 20:16:39 +0100 (IST)
Date:   Mon, 26 Sep 2022 20:16:39 +0100
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
Message-ID: <YzH6lxeZ2KYfK6lx@kernel.org>
References: <20220924113346.1110909-1-leo.yan@linaro.org>
 <CAM9d7ci2RJOTz08eGRgLMVpS0TmwN=q=UNA_Z3wbSHCC2pMygQ@mail.gmail.com>
 <YzGiMdIRRE8ibCiD@kernel.org>
 <YzG9Mz8t6aNn1ZwX@leoy-huanghe.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzG9Mz8t6aNn1ZwX@leoy-huanghe.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 26, 2022 at 10:54:43PM +0800, Leo Yan escreveu:
> On Mon, Sep 26, 2022 at 01:59:29PM +0100, Arnaldo Carvalho de Melo wrote:
> 
> [...]
> 
> > > > Fixes: a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
> > > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > 
> > > Thanks for the fix and sorry for the inconvenience.
> > > Actually I sent the same fix a few weeks ago.
> > > 
> > > https://lore.kernel.org/r/20220909235024.278281-1-namhyung@kernel.org
> > 
> > collecting it now, and adding that Fixes from Leo's patch, ok?
> 
> Yeah, I think it's good to add Fixes tag.  Just remind, actually
> Namhyung has mentioned Fixed tag in above link:
> 
> "I didn't add a Fixes tag as it's not sent to Linus yet. But in case you want it.
> 
>   Fixes: a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
> "

I'll add it.

Sometimes I think about combining fixes with patches in my tree that
didn't made it into Linus tree yet, so that we avoid having problems
with 'git bisect', but I also try not to rebase acme/perf/core.

Perhaps in the future 'git bisect' will look at Fixes: tags :-)

- Arnaldo
