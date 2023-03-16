Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD06BC417
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjCPDCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCPDCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:02:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012EEB5AAF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 20:02:15 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id ja10so323294plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 20:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678935735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7EWiKEbOPUDyB/zyzM3aKt/kTkta+HN39sJbR4GK64=;
        b=zda6cwqWDW/ZoGfEs0UKEVqsEmth82V2Op4mAzethVMRg93zU57nyUl68JRhzcpOQv
         YN+splHI4ZJWsS/7IuLDd6eQ6IhqAmExpcMDGFcJH74LsNLvy7nFyJgX8l5XKJPzU29y
         etx3nvUnF9kQc3+2d644rev8b8j42vSrpcNryJtfor1+0OHitsM1CFkBqQUtMOQTjUMW
         Ci73rGO108SF3gs5JFXg0tOcVZDwiwQgpLwLDtZ8TkNv8TjbSiyJbfxg7QmfYjCWfzdl
         xVk2AWAn4INbBEb0vx1Tc4vcGVxouJHGcexIDc6fd6n25NJ45gABMovrDxFO2Pt4S3Oc
         0JNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678935735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7EWiKEbOPUDyB/zyzM3aKt/kTkta+HN39sJbR4GK64=;
        b=ElXBj7Yx8DijtIYo1rGaljx0Wt7wjK6MrPqFJtwbkPAqMhr10DQZBpSnMFZgWpk98J
         eXLXfBU5A/fMFRjBclWMH8+lfaudq1MJqasByIafpjxRcu/l1cEa5v9kvloL1JszCHIk
         PWyyDI2YZHQzfZZ14VCDD/voLqpm1bdrkvvcvYr+dwzZCwbQ4At4kEqnaZq6bOPs5dX+
         wzBTgCfmdzXsA1ouayGLqH+x1zeczsoVz9iaJj3e3abLAuPDT5sPhXApggdI16kKpOF1
         faQ4HfRTtOn/P4l7kabeldRsXJ7MK+rj9111E+GYG/gsBuFo5/frcJH0TH7KFHzKthnK
         WKgg==
X-Gm-Message-State: AO0yUKUnC9yu42b6rh9JX1LntQ5h328tGwWtSeSjmBO+E8P55bHpk++l
        RFbDrybyHRocN5BZidnH4wb9cw==
X-Google-Smtp-Source: AK7set8c5ZrGL+nvSbQvYycqwXtRzHVmOwi5GpQiW2J6MANXBQteRhZRjSlj0F7wF52H79vCfsNpFQ==
X-Received: by 2002:a05:6a20:729c:b0:cc:eb3b:56e9 with SMTP id o28-20020a056a20729c00b000cceb3b56e9mr2856563pzk.1.1678935735350;
        Wed, 15 Mar 2023 20:02:15 -0700 (PDT)
Received: from leoy-yangtze.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id c20-20020aa78814000000b005907716bf8bsm1729115pfo.60.2023.03.15.20.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 20:02:14 -0700 (PDT)
Date:   Thu, 16 Mar 2023 11:02:06 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 06/16] perf kvm: Introduce histograms data structures
Message-ID: <20230316030206.GB2267252@leoy-yangtze.lan>
References: <20230315145112.186603-1-leo.yan@linaro.org>
 <20230315145112.186603-7-leo.yan@linaro.org>
 <ZBIgcX0TmC0tyFR0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBIgcX0TmC0tyFR0@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, Mar 15, 2023 at 04:45:53PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> Had to add:
> 
> 
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index c4cb34df155fec67..b06c11d306a11cab 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -85,7 +85,6 @@ static struct kvm_event_key keys[] = {
>  	DEF_SORT_NAME_KEY(time, mean),
>  	{ NULL, NULL }
>  };
> -#endif // defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
>  
>  struct kvm_hists {
>  	struct hists		hists;
> @@ -100,6 +99,7 @@ static int kvm_hists__init(void)
>  	perf_hpp_list__init(&kvm_hists.list);
>  	return 0;
>  }
> +#endif // defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)

Thanks for fixing up, this is fine for me.

Seems to me it is not a good practice to use macros (and nested macros) to
mute or unmute big chunk code.  I will try to refine the building
builtin-kvm.c and prepare patches based on current code base.

P.s. I saw this series has been picked up into your branch
acme/tmp.perf-tools-next, if you want me to follow up anything, please
let me know.  Thank you!

Leo
