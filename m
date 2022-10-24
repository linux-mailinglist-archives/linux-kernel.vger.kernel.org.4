Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D282560A19C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiJXLaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJXLaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:30:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB6413F84;
        Mon, 24 Oct 2022 04:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 357FDB81132;
        Mon, 24 Oct 2022 11:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0539C433D6;
        Mon, 24 Oct 2022 11:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666611015;
        bh=wc7q89o37lUAS6YZchaEYz4ZHRKRvZLgc1XU7PqIFLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAmtNEIKG7at+1aB+aMH5nNezIMRI82+4TaMv8rLeiYCxPhGxUHkzZbRoCdCk+2Cc
         sAw4CRqVlluM9fO/8GOWHZm3YLrlPw8Bdcm1Wf8d0FnamerKgpzlGYBNNOYUE1W8zJ
         zOGrGWBo9oTu4zUvrQCj9I4OqEqwUhX0wEouIjI4Eu00D8qyvLQ3c6kX1l29BpOKQi
         n4c4Qb1fIpEvVKrzfLpGTUkakil3waOyYq3NDNn16OHJcSpBSrjtwWlL/Y+Otb6F8s
         tcsQCtAQ0XBjC0UreuL79XQMzu6Gt9V0MNhrjS0kvIoHSMTATDRSt0iPxv+WBCHkPS
         qUB7jt6JVKDmg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 59658404BE; Mon, 24 Oct 2022 08:30:13 -0300 (-03)
Date:   Mon, 24 Oct 2022 08:30:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ian Rogers <irogers@google.com>, Greg Thelen <gthelen@google.com>,
        Anand K Mistry <amistry@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1] perf record: Fix event fd races
Message-ID: <Y1Z3RfP7sVltTfyF@kernel.org>
References: <20221024011024.462518-1-irogers@google.com>
 <Y1X+7FCemionnepj@leoy-huanghe.lan>
 <CAP-5=fWUrwQ187O7d0incvRFQ7RT+1viG30k+F1ZEEU3BEFeFA@mail.gmail.com>
 <Y1ZYCD1LjC5OhWsq@leoy-huanghe.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ZYCD1LjC5OhWsq@leoy-huanghe.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 24, 2022 at 05:16:56PM +0800, Leo Yan escreveu:
> On Sun, Oct 23, 2022 at 10:33:30PM -0700, Ian Rogers wrote:
> 
> [...]
> 
> > > > +static volatile int done_fd = -1;
> > >
> > > Here is a bit suspecious for adding volatile qualifier.  See the
> > > document: process/volatile-considered-harmful.rst.
> > >
> > > I know the document is mainly for kernel programming, but seems to me
> > > it's also valid for C programming in userspace.
> > >
> > > I not sure what's the purpose for adding volatile for done_fd, if we
> > > really have concern for reading any stale value for done_fd, should we
> > > use WRITE_ONCE/READ_ONCE?
> > 
> > We could just switch to C11 and stdatomic. The volatile is consistent
> > with the code above and more consistent with the expectation of
> > writing to a variable that is read in a signal handler.
> 
> Thanks for the info for C11 and stdatomic.h.  The documentation [1] says
> the safe way is for accessing shared data in signal handler is:
> 
>   static volatile sig_atomic_t done_fd = -1;
> 
> It's fine if you want to use another patch to address this issue, this
> patch for fixing errno is fine for me:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>



Thanks, applied.

- Arnaldo

 
> [1] https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

-- 

- Arnaldo
