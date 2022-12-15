Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24D864D50F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 02:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiLOBoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 20:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLOBoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 20:44:10 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8372CE28
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 17:44:05 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so1167708pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 17:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WmAkvDBKMNNGormxiR/sVMbcrKMt/tgyZJoKB0gFsB0=;
        b=ijXibnLuHzRzsqBDk+Xk86VZwXDIofKPWnvJrpJv5mIoZ1MCKwUyISd4IpTz6xhsB3
         DAse7DyLkBtjgJ2Mf8YzyfA9h6QaR8xrcN4fz0VHgaMqCg4DjmIUI5/EYqX3M0I7T6TX
         GGhS2V6XP5u5EVFXbu2f/kkDc3MQ8pRkmO4AAa/WdVE1TuW+AkdRMn0xDk51qeOke2Qi
         dvzDkj1Oe+dsEwezKfilIZLsILhVJFfUbTj9j5fxlohHdkySCJYM7bOYVmRrMDq0AqRY
         5jrDvk1pxjB7k/XzrPyAQgrQBncj3JbAjDmak6pkT9Uav/gvIWQN53ruIigm1x64DuE9
         Ed4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmAkvDBKMNNGormxiR/sVMbcrKMt/tgyZJoKB0gFsB0=;
        b=vhH4hSlSPqxwbUW+79BmixUGPTa91zkWzNjrEaZ78FEkdkeCLBwRcJA/wtkYqgpVpR
         iljFL8jcbr8C54qQFZFLrCJKn6r9nxRlS8cS2q+DNI/B1h8iY2aPIDpXubasDocNrUKl
         9SdfjHNii0kui2VXCnT8pllpg9xP3ukuEdc/WbcR5CMudSH1sPkQ3Ax0t/tI6ryTrqbS
         OIFy/EM/OFnh0YqTiVW9a1HDNviCQvlrTDrs0q5sVm7O0uiPWTdiMsER2QFd73DYh+z9
         mNM6NHP55Gh8dVyO0nWYvGL10GTWUsYm7FPFJY5eSog2t/uVZhqg8bRTcPOHgGJJjFF3
         a1ng==
X-Gm-Message-State: ANoB5pnP3Ax2RKnpK13BFl+Nxn5Z7vqfqDqcICOK7wlQjeJNdkQLtmaB
        ccic/F0ZbKYUgyi0hfZ9TUWZCQ==
X-Google-Smtp-Source: AA0mqf7+pQUOfbHT3BZLML0xqnDfuCi4zbmc2bJpy7XuurL1h+qED3gKG8yW2nFnqm74YWJZtVP6ZA==
X-Received: by 2002:a17:90a:384e:b0:212:de1a:3505 with SMTP id l14-20020a17090a384e00b00212de1a3505mr27535065pjf.28.1671068645033;
        Wed, 14 Dec 2022 17:44:05 -0800 (PST)
Received: from leoy-yangtze.lan ([152.70.116.104])
        by smtp.gmail.com with ESMTPSA id k13-20020a17090a910d00b00218b47be793sm1979303pjo.3.2022.12.14.17.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 17:44:04 -0800 (PST)
Date:   Thu, 15 Dec 2022 09:43:55 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kevin Nomura <nomurak@google.com>
Subject: Re: [PATCH] perf stat: Do not delay the workload with --delay
Message-ID: <Y5p723KMYBI2W6vs@leoy-yangtze.lan>
References: <20221212230820.901382-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212230820.901382-1-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 03:08:20PM -0800, Namhyung Kim wrote:
> The -D/--delay option is to delay the measure after the program starts.
> But the current code goes to sleep before starting the program so the
> program is delayed too.  This is not the intention, let's fix it.
> 
> Before:
> 
>   $ time sudo ./perf stat -a -e cycles -D 3000 sleep 4
>   Events disabled
>   Events enabled
> 
>    Performance counter stats for 'system wide':
> 
>        4,326,949,337      cycles
> 
>          4.007494118 seconds time elapsed
> 
>   real	0m7.474s
>   user	0m0.356s
>   sys	0m0.120s
> 
> It ran the workload for 4 seconds and gave the 3 second delay.  So it
> should skip the first 3 second and measure the last 1 second only.  But
> as you can see, it delays 3 seconds and ran the workload after that for
> 4 seconds.  So the total time (real) was 7 seconds.
> 
> After:
> 
>   $ time sudo ./perf stat -a -e cycles -D 3000 sleep 4
>   Events disabled
>   Events enabled
> 
>    Performance counter stats for 'system wide':
> 
>        1,063,551,013      cycles
> 
>          1.002769510 seconds time elapsed
> 
>   real	0m4.484s
>   user	0m0.385s
>   sys	0m0.086s
> 
> The bug was introduced when it changed enablement of system-wide events
> with a command line workload.  But it should've considered the initial
> delay case.  The code was reworked since then (in bb8bc52e7578) so I'm
> afraid it won't be applied cleanly.
> 
> Fixes: d0a0a511493d ("perf stat: Fix forked applications enablement of counters")
> Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Reported-by: Kevin Nomura <nomurak@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
