Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD74B5F9A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiJJHpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiJJHod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:44:33 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F3B237E1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:41:23 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s206so9686822pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2JnzH9JeXylQXqYToVoTmpf1fFyH7mz4dghGkaQnYw=;
        b=GtGCF1PPYgkx7HINRVrRyhEC7hIipoZ9oOupbzr0vHynqY8R73WZTyUhQeFG1rKNNB
         /UI0fyV30Oz3Hsx2aaJu8+xS4xKXsst2uWLc74U4cg+iXNciOxM3t76XD0xOlVRZt4Ul
         YUfoNZ6ddJkT/51fXpsNKVKd4U39/J0NxwoW9svPd/HscCE777kcKWE6f4l8xZfQsw0O
         MTuyb5YV6dMOG9Hjx9WJxVZMk6j88yv53Gy7OHQK6f8L3nQLOGAf6dUS3qRLtabsVK1A
         p26dwBLlpexgDZZ893NpmZreVDF56qy2KGlqgtCTCS70H9LgjYANKGN24c3sZ4rgBATN
         l1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2JnzH9JeXylQXqYToVoTmpf1fFyH7mz4dghGkaQnYw=;
        b=Dfo0PlDtiuaJAXGxKBarMjxsLN2x67fc8UYrLkZSCTASekk6WXpCSb/dFSk2jQjblG
         kdQBlm7WZG1Z1d5S1MK5L17eOJFmK+a3GCkTHro4K80R1pOCSvcC5gfQIeGEIugtefUb
         Zz8AvtPpyAgcF8ONkry6ixv9f9Utu7SM/SS4T/ilTutIEfcqwSumrUYS2xStvoisAwTy
         TyTyQpkA2mzO60cBkZ5ithlNFYfWfdJiiYCuDuRZjvZ4dcvyLFLSbQ3NBlekZYp9bcXP
         bc3s77DlbJGV+VPS4/ojA6/qdNNUlg5BpQ2LGtlaG2qGLzYBaQF3tQ5PaK7x7srIhOO1
         pCgQ==
X-Gm-Message-State: ACrzQf1fe9D7XQ3jZA3HoPnhPtCOfvNaFC10CAc8e8ZjyV+VypERuulu
        XeDBYhPs3+33HFkUFCO2A+STM9Bt4Ug1YR0+BiZwyQ==
X-Google-Smtp-Source: AMsMyM75J3lPTvdozxq0KxMkiqMWb6CfGBOrMv7Ap1ec31pUaSPWfEQ4UzB52IxUSQeHV+i8LPY+Hw==
X-Received: by 2002:a17:902:f707:b0:179:daf6:87bc with SMTP id h7-20020a170902f70700b00179daf687bcmr17871604plo.27.1665387671752;
        Mon, 10 Oct 2022 00:41:11 -0700 (PDT)
Received: from leoy-yangtze.lan (211-75-219-199.hinet-ip.hinet.net. [211.75.219.199])
        by smtp.gmail.com with ESMTPSA id a1-20020aa78e81000000b00540e1117c98sm6209523pfr.122.2022.10.10.00.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 00:41:10 -0700 (PDT)
Date:   Mon, 10 Oct 2022 15:41:03 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, acme@kernel.org,
        suzuki.poulose@arm.com, linux-perf-users@vger.kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Fix test_arm_coresight.sh failures on Juno
Message-ID: <Y0PMj4V4MBh4J/ao@leoy-yangtze.lan>
References: <20221005140508.1537277-1-james.clark@arm.com>
 <Yz7qx+4BxNYOCgvL@leoy-yangtze.lan>
 <cce859cc-f25b-b4e8-70c5-917569aec050@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce859cc-f25b-b4e8-70c5-917569aec050@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 04:11:05PM +0100, James Clark wrote:

[...]

> >> Before:
> >>
> >>   sudo ./perf test coresight -vvv
> >>   ...
> >>   Recording trace with system wide mode
> >>   Looking at perf.data file for dumping branch samples:
> >>   Looking at perf.data file for reporting branch samples:
> >>   Looking at perf.data file for instruction samples:
> >>   CoreSight system wide testing: FAIL
> >>   ...
> >>
> >> After:
> >>
> >>   sudo ./perf test coresight -vvv
> >>   ...
> >>   Recording trace with system wide mode
> >>   Looking at perf.data file for dumping branch samples:
> >>   Looking at perf.data file for reporting branch samples:
> >>   Looking at perf.data file for instruction samples:
> >>   CoreSight system wide testing: PASS
> >>   ...
> > 
> > Since Arm Juno board has zero timestamp for CoreSight, I don't think
> > now arm_cs_etm.sh can really work on it.
> > 
> > If we want to pass the test on Juno board, we need to add option
> > "--itrace=Zi1000i" for "perf report" and "perf script"; but seems
> > to me "--itrace=Z..." is not a general case for testing ...
> 
> Unfortunately I now think that adding the Z option didn't improve
> anything in Coresight decoding other than removing the warning. I've
> never seen the zero timestamp issue on Juno though. I thought that was
> on some Qualcomm device? I'm not getting the warning on this test anyway.

No, on my Juno-r2 board I can observe the timestamp is always zero
from CoreSight trace data, this is why everytime I must use
"--itrace=Zi1000i" for reporting results.

> The problem is that timeless mode assumes per thread mode, and in per
> thread mode there is a separate buffer per thread, so the Coresight
> channel IDs are ignored. In systemwide mode the channel ID is important
> to know which CPU the trace came from. If this info is thrown away then
> not much works correctly.
> 
> I plan to overhaul the whole decoder and remove all the assumptions
> about per-thread and timeless mode. It would be better if they were
> completely separate concepts.

Okay, good to know this.

[...]

> > So here I am suspect that changing to "--itrace=i20i" can allow the test
> > to pass on Juno board.  Could you confirm for this?
> 
> On Juno:
> 
>   ./perf record -e cs_etm// -a -- ls
> 
> With interval 20, 23 instruction samples are generated:
> 
>   ./perf report --stdio --itrace=i20i | egrep " +[0-9]+\.[0-9]+% +perf "
> | wc -l
> 
>   23
> 
> With interval 1000, 0 are generated:
> 
>   ./perf report --stdio --itrace=i1000i | egrep " +[0-9]+\.[0-9]+% +perf
> " | wc -l
> 
>   Error:
>   The perf.data data has no samples!
>   0

Thanks for confirmation.  It's a bit weird that your Juno board doesn't
produce all zeros for timestamp packets.

> I think the issue is that ls is quite quick to run, so not much trace is
> generated for Perf. And it just depends on the scheduling which is
> slightly different on Juno. I don't think it's a bug. On N1SDP there are
> only 134 samples generated with i1000i, so it could probably end up with
> a random run generating 0 there too.

Agreed, changing to smaller interval makes sense for me.

Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks,
Leo
