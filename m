Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCC95E909F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 03:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiIYBMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 21:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiIYBMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 21:12:44 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4125E36843
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 18:12:43 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v4so3545623pgi.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 18:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cJzXVCVoc18ABdRcUIsWy2aVUz4QJ6reHu2nO0fOZDw=;
        b=VsbU1C9pj6PrOh7Tpac41c4wwewHJBSRM+9UaR/sO1w9OZnFfCpEg/NcPxW8/rqcRP
         iJPZhhOw3inT2PMKTaJTrmS2xGVeE/MG7AIjiRkdgJ1GZdM6y2vuV565zipUw0y0KZeP
         SV2T5GF372quFshJgZ1uLqpppaA/y52hq2C7svKhpvLLAPHBlLW/lsE/jgwbcVO3m4yY
         MecAri6bE00rb8iLtuZP/qk6gUeMZJHKO3UXP3VT+Rlrlw2mGy5xMbmbXtkutHjVxRR0
         tTqCtwXvnIbdYF16cJRKrqCcF54sPjqTx1FYYsrDws0n8RZfoJtBH4EdiPvyMGrc+kcb
         jwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cJzXVCVoc18ABdRcUIsWy2aVUz4QJ6reHu2nO0fOZDw=;
        b=id7lqoZuzBFSEOGAp2xv94/Ki4DCyWGkts9GTuS/XJs4t7GJxleSjwKeakQtqGD2sn
         vndVmtvQGRf2f9/VBQpHSY2oHYy/tF++YP4ebZQpheZehigpxG2XQbD5Er5FQZZfbSm4
         rxZnuh/RzYBN/te/3IcZFUW+kkiqEzo89mhX37eYrVeuOVfIqk8YhtwTRPyn5CKC+vHM
         clSpkqNznWmHysPKffyHdQvt9V6LUeopsouxrdZC4Lae93CC0A1bgZS0vWblGrHrJUHY
         owPNvy/dPYwyRWPPtHSfc8nBDDbyvlvz/jWkKYGWFVE8kmz/OJNsMFWX7v0og+4JcB//
         sLsg==
X-Gm-Message-State: ACrzQf31qW3quJZA41nMV44a03A4O3LhfpeM7Fow6KqU+ZAHfQgXARMJ
        bbiDkRvjRvD93+SDHwCft9AU7w==
X-Google-Smtp-Source: AMsMyM45145g4oP/BJtlAILxr4h2nhF9pI91GUbxNO76xHDs20ASf5chPRKMDKkDmWvmxFeq3lNTgQ==
X-Received: by 2002:a05:6a00:4106:b0:548:9e0e:f13b with SMTP id bu6-20020a056a00410600b005489e0ef13bmr16645834pfb.0.1664068362624;
        Sat, 24 Sep 2022 18:12:42 -0700 (PDT)
Received: from leoy-huanghe ([39.144.40.86])
        by smtp.gmail.com with ESMTPSA id c36-20020a631c24000000b0043ae1797e2bsm7818324pgc.63.2022.09.24.18.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 18:12:42 -0700 (PDT)
Date:   Sun, 25 Sep 2022 09:12:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf record: Fix segmentation fault in
 record__read_lost_samples()
Message-ID: <Yy+rBbzvoTWOI+SJ@leoy-huanghe>
References: <20220924113346.1110909-1-leo.yan@linaro.org>
 <CAM9d7ci2RJOTz08eGRgLMVpS0TmwN=q=UNA_Z3wbSHCC2pMygQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ci2RJOTz08eGRgLMVpS0TmwN=q=UNA_Z3wbSHCC2pMygQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Sat, Sep 24, 2022 at 09:52:09AM -0700, Namhyung Kim wrote:

[...]

> > In the unprivileged mode perf fails to open PMU event, the function
> > record__open() returns error and "session->evlist" is NULL; this leads
> > to segmentation fault when iterates "session->evlist" in the function
> > record__read_lost_samples().
> >
> > This patch checks "session->evlist" in record__read_lost_samples(), if
> > "session->evlist" is NULL then the function directly bails out to avoid
> > segmentation fault.
> >
> > Fixes: a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Thanks for the fix and sorry for the inconvenience.
> Actually I sent the same fix a few weeks ago.
> 
> https://lore.kernel.org/r/20220909235024.278281-1-namhyung@kernel.org

Thanks a lot for the info and fix.  The patch in above link looks good
to me!  Please ignore this one.

Leo
