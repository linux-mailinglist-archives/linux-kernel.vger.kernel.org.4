Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94976ADBE6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjCGK24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjCGK2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:28:20 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E82738B0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:27:50 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id n5so7678483pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 02:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678184870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dv5j2DsmDu3Yb1JRFX4IQEnGdnBbycQk+oJCDIPvAFI=;
        b=zo1v3ikcfUI+GubGQU8tya1ijnKgZ2pNPOFD1vjqgJu3uExapCupfSvLkc+XVHJKiO
         Qdh1xds0oZ6Mc25g15TcqfpEFW85T2n+amhENjvdNuYS70Gxk86+krfC5wMo0cN1uBac
         mGtZday9/rh9haZdWwdwdQMTiGsqksnyak9W5mA0JVWcNei4VTdEL0kDUAKoFuTJsRC3
         2x+uOg4ePz2SRuqehUw2Lvb1Xftq/5C8UBqSSFSZoWymxt8UTngCa7DDg7obezL8OHEW
         ZIkDZmcQJAhCESix9grlqFON8i8BNoiq8CXHkDFTq9Dy0v5HnHzHNto7pybXnaxrBnpP
         LMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678184870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dv5j2DsmDu3Yb1JRFX4IQEnGdnBbycQk+oJCDIPvAFI=;
        b=karalMfanHJOGnkyj88iQ3C+i3v6bVGzErYlqbfzDFOsJKtC05ss1oIo9vEUEhDFo8
         +FQYML6JRM2vuPNrCTeFflr6x7CbDxAyapGzHbLMMFQDy+QzAzBZEQbEM1mizhm1sQIY
         q7OaICPW2iSSTigPF4M3R9utgbrsvf5VoQWZaCvjqnHhVKUrvq8GEIW+BZ73rjtgz9F+
         9+feQYw0PXaZyHhLTAqXCO/C+sN876ntMQmYA/EfAQ6jLW0FncqvouvdrfzBR7nagBdu
         tA093NsFUB04LA86qNz8z/apJQjN+mg32yoRHyWs1PzsJnobaGpGLCXMgt0NSWkHBCBM
         DLsQ==
X-Gm-Message-State: AO0yUKUuSEaB66HKPHioTDDB+EyP3WyB7z0ZTvpGIH5i5wwou+OqKMAa
        GhQrsaD3+Lo0up+6eNlVmrWWs5jkaKwhKBe4KdV3+g==
X-Google-Smtp-Source: AK7set8pxiYUjOBwEZaB6JHNa5lc5aPwgDf8yb5RjYMs7pEgJudwNRo7sa/8RRpkdSEZL+jfszYIteC1LDCMr9vTegA=
X-Received: by 2002:a63:7512:0:b0:4fb:933a:919 with SMTP id
 q18-20020a637512000000b004fb933a0919mr4862971pgc.3.1678184869732; Tue, 07 Mar
 2023 02:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20230306132521.968182689@infradead.org>
In-Reply-To: <20230306132521.968182689@infradead.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Mar 2023 11:27:37 +0100
Message-ID: <CAKfTPtA9DYJ5=VYGpS_XBzzmvgJeYcmmG261A1cby_sT7kHdYg@mail.gmail.com>
Subject: Re: [PATCH 00/10] sched: EEVDF using latency-nice
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 at 15:17, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hi!
>
> Ever since looking at the latency-nice patches, I've wondered if EEVDF would
> not make more sense, and I did point Vincent at some older patches I had for
> that (which is here his augmented rbtree thing comes from).
>
> Also, since I really dislike the dual tree, I also figured we could dynamically
> switch between an augmented tree and not (and while I have code for that,
> that's not included in this posting because with the current results I don't
> think we actually need this).
>
> Anyway, since I'm somewhat under the weather, I spend last week desperately
> trying to connect a small cluster of neurons in defiance of the snot overlord
> and bring back the EEVDF patches from the dark crypts where they'd been
> gathering cobwebs for the past 13 odd years.

I haven't studied your patchset in detail yet but at a 1st glance this
seems to be a major rework on the cfs task placement and the latency
is just an add-on on top of moving to the EEVDF scheduling.

>
> By friday they worked well enough, and this morning (because obviously I forgot
> the weekend is ideal to run benchmarks) I ran a bunch of hackbenck, netperf,
> tbench and sysbench -- there's a bunch of wins and losses, but nothing that
> indicates a total fail.
>
> ( in fact, some of the schbench results seem to indicate EEVDF schedules a lot
>   more consistent than CFS and has a bunch of latency wins )
>
> ( hackbench also doesn't show the augmented tree and generally more expensive
>   pick to be a loss, in fact it shows a slight win here )
>
>
>   hackbech load + cyclictest --policy other results:
>
>
>                         EEVDF                    CFS
>
>                 # Min Latencies: 00053
>   LNICE(19)     # Avg Latencies: 04350
>                 # Max Latencies: 76019
>
>                 # Min Latencies: 00052          00053
>   LNICE(0)      # Avg Latencies: 00690          00687
>                 # Max Latencies: 14145          13913
>
>                 # Min Latencies: 00019
>   LNICE(-19)    # Avg Latencies: 00261
>                 # Max Latencies: 05642
>
>
> The nice -19 numbers aren't as pretty as Vincent's, but at the end I was going
> cross-eyed from staring at tree prints and I just couldn't figure out where it
> was going side-ways.
>
> There's definitely more benchmarking/tweaking to be done (0-day already
> reported a stress-ng loss), but if we can pull this off we can delete a whole
> much of icky heuristics code. EEVDF is a much better defined policy than what
> we currently have.
>
>
