Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C331646F5F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLHMP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLHMPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:15:54 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8515B65F2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 04:15:53 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id t17so3427975eju.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 04:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQM/pUBudcr6YU8Nrodod0FXPXqDRSlpxJvuQupwvUA=;
        b=NPRpefpW1gveWFHbqzUrmm3OVg6JQy6oNdsnfSDvmcgE05hBIye1v57Y3pI5j/qMin
         xeidj3EzcFrBjNjQq9c73rY3hPqUW/uqmWyWZ1hmChYc3h79JEE7rkn1/CfIaCX4LK7J
         NRImf4vOzwrPpTyi8baTpy3RmNasuWlamquWUAeu8gJm7s4Y+pYp8J2mymNlLBUd77/z
         NPoyIvnFf5mHjWs8TCuQdyebVDMM3s8hIgggB+hJxsARbavTZzGu1ClLhf+5ImXkvbpb
         /EP7KLmMFNblAZjgtgoLC7YRuGmnZ+7x/ua74SGpy2tC94NwFHSFWwmZd6jNw53Defqa
         JCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQM/pUBudcr6YU8Nrodod0FXPXqDRSlpxJvuQupwvUA=;
        b=3cLsXcb4LEy6sbRJGCA393/0V8Uz21qf7EPdVEDMtt11pL1qKrDVG3AEOS7VfcEuAa
         Ypb+UFcdEWHuoIB5k1l0yNR6vdPqr+huf6MqTBSWJLr8Rj8RPPA3+Jl3O1GSrTqqzmUL
         JbEaR8SaQxexEOW71paNpZjyDffsFJo9AizNFewJu0vHRk97Y19IFibc4W8pwQhoGKse
         aNvctkjY/VfSfy6berWp2QpGHnll+Rc8yBrXGc9EFs/bexRld7AK4DTxKMU+cvW5X9QA
         tsFstv1zjMn8aEDJeyukk4qdjHr25i9kf2S3uZ+3GOEbFkS5DP6D9KbpshKPxb0/hgBe
         bbNQ==
X-Gm-Message-State: ANoB5pkxBiYrtdp0yj44ZGR1Fm85PZ27yFUB98DzVk2btTAMWM0RVzSJ
        J2sVxVyudAANovw0N7VnoXg=
X-Google-Smtp-Source: AA0mqf44xnN2FmslEeCLW8mI880+j+ljVisAV+hcyLrKR3sK2ZUCoelmTZmKEJD+Kic1TGphd3ZNUQ==
X-Received: by 2002:a17:906:144e:b0:78d:cd72:8e3e with SMTP id q14-20020a170906144e00b0078dcd728e3emr7838779ejc.212.1670501751858;
        Thu, 08 Dec 2022 04:15:51 -0800 (PST)
Received: from debian ([37.19.195.134])
        by smtp.gmail.com with ESMTPSA id x17-20020aa7d6d1000000b00458dc7e8ecasm3334637edr.72.2022.12.08.04.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 04:15:51 -0800 (PST)
Date:   Thu, 8 Dec 2022 07:15:49 -0500
From:   Petar Gligoric <petar.gligor@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>
Subject: Re: [PATCH v2 0/3] perf: introduce perf based task analyzer
Message-ID: <Y5HVdS3mlDruNyrl@debian>
References: <20221206154406.41941-1-petar.gligor@gmail.com>
 <CAM9d7cizPC3p0-Z1oYsDPofwNfZHyKYiJR5JXEcS31Q=mgzcLg@mail.gmail.com>
 <Y4/AfA2OYtlTkKwo@debian>
 <CAM9d7chLZVDg_-tnUh_qFYzchnpis-e7HYNDVM_OPjj_QXMeKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chLZVDg_-tnUh_qFYzchnpis-e7HYNDVM_OPjj_QXMeKQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thanks for the input! For this patchset we explicitly decided against
> > extending "perf sched timehist" - after some pros and cons. Mainly we
> > didn't want to break existing programs (which might parse the output of
> > perf sched) and also the goal of the task-analyzer is a bit different.
> > E.g what will follow as a follow-up patch, is to show IRQs visually
> > pleasing intermixed with tasks to show potential sources of task
> > latency. This will be offered as an option for the task-analyzer, but
> > would be too much functionality for "perf sched timehist". This was the
> > main reason why we decided against the extension.
> 
> Then you might want to add a new sub-command under perf sched.
> But I guess we can just add a new option for the different output
> format in the perf sched timehist.
> 
> Anyway, "perf script" is a generic tool not targeting specific events.
> This functionality requires sched_switch (and more?) then we need
> the record part to make sure the data has the events.  That's why
> it's natural to have it in perf sched IMHO.
> 
> Thanks,
> Namhyung

We assumed that python scripts should not only be used as a "generic tool".
There are a number of tools like flamegraph, netdev-times, dropmonitor and
other scripts that analyze and look at *very specific* events. The question is
rather, why should this be implemented in C? When using Python - with batteries
included - less code has to be written for the identical result, and it is less
error-prone than C (less technical debt). We have measured the performance,
even for very large perf.data files, and again we see no problems.

But maybe this should be clarified in principle! What do you say Arnaldo, Ian,
...?

Petar

