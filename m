Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290BE654BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 05:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiLWEAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 23:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLWEAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 23:00:01 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1024140A5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 19:59:58 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so7698826pjj.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 19:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1oKHszNlyPRAoIoEblRlaQjb7vzsMZUlhtQ32+aR420=;
        b=n0qfaq6rARj65lJ/ZVFLaxy257IeqtPIc09HTww6vmAwQGVqL6SYQFReXrfy2pysBd
         ZbChMSfgm14hRYpiN708UhTlzryNEQww62F7Gnw0TNupeN6R2ChAottys+1aZNnpKLWn
         Swb2ySRN1bAKSXkipUPajUG+UT/oXcjZt+IShgOS8agTOdo5WwwHrOuXry86amaMMJEx
         p2Nikb3gGFKUyBezQRyokw6fxyXupzrDduhF785ZoJieh4LMWQd2F7LM38ZCmCOqMIXG
         aZCGWYQ5/YVgM9hHTI7DRdZnhXfAraFlqCxccma+RlJpE/kJ6aDCAcrtcmZ6RTZA52ZS
         Kh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oKHszNlyPRAoIoEblRlaQjb7vzsMZUlhtQ32+aR420=;
        b=KckfQM/XGwbpZEajxNsRzyUSHi7b9KE8Uc8FtT80vX593CFUctvMMtLdF1NMYA/Rtm
         1OYRhMt49bUj3oiQHX5oMVX2vAe1UsCkDWPQeHmzc39zN7JX5Pi5BRC8JCYEhM4LqB63
         f/LiUN0CZYQw+SXY21BX2bhan01XuB70KkIOqqGb5O1xjOVtN7D1lIs9VcGNt9MpLvwu
         1DWn09KfPdsSNfpG4kzCS5wDq6d/+kmtnKFhfM4yDmxJMAQUewrzT5IAGcBqTiOmU1kW
         zztMuCoTUBeIWG4/ObtdW8Ar8lb++Y6jLADTayykhtIxdHtMQAN/oGrnoMeRzI7qQluU
         XQeQ==
X-Gm-Message-State: AFqh2koQJ4GAa0aIplBRPIFUENFH2EkspD7jXTXr5xA9vfOssBYd7Gno
        9nysR89TtSzLBSb/9AEpF0MuDQ==
X-Google-Smtp-Source: AMrXdXsgg1djqZ2NTqSwPGjvrhgRV4B8reoW7ugNdk5CNUZVROGIT2ufNxF43JIP54hpcyqTOSY5Hg==
X-Received: by 2002:a05:6a20:bc95:b0:a3:1ea9:dd13 with SMTP id fx21-20020a056a20bc9500b000a31ea9dd13mr8751967pzb.30.1671767998364;
        Thu, 22 Dec 2022 19:59:58 -0800 (PST)
Received: from leoy-yangtze.lan (n058152048149.netvigator.com. [58.152.48.149])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001896af10ca7sm1256957plh.134.2022.12.22.19.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 19:59:57 -0800 (PST)
Date:   Fri, 23 Dec 2022 11:59:51 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] perf: Use perf_pmu__open_file() and
 perf_pmu__scan_file()
Message-ID: <Y6Unt0E4qM5oqE9+@leoy-yangtze.lan>
References: <20221222160328.3639989-1-james.clark@arm.com>
 <20221222160328.3639989-3-james.clark@arm.com>
 <Y6UkUQ9dcQQwvRpz@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6UkUQ9dcQQwvRpz@leoy-yangtze.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 11:45:21AM +0800, Leo Yan wrote:

[...]

> > @@ -103,8 +103,9 @@ static int test__perf_evsel__roundtrip_name_test(struct test_suite *test __maybe
> >  						 int subtest __maybe_unused)
> >  {
> >  	int err = 0, ret = 0;
> > +	char cpu_atom[] = "cpu_atom";
> >  
> > -	if (perf_pmu__has_hybrid() && perf_pmu__hybrid_mounted("cpu_atom"))
> > +	if (perf_pmu__has_hybrid() && perf_pmu__hybrid_mounted(cpu_atom))
> 
> After change the parameter 'name' to non const type in function
> perf_pmu__hybrid_mounted(), at here we still can pass string "cpu_atom"
> without warning, right?  If so, we don't need to define a local
> variable 'cpu_atom'.

Correct for above statement, I did experiment and confirmed building
failure after change the parameter to non const type and directly pass
string "cpu_atom":

tests/evsel-roundtrip-name.c: In function ‘test__perf_evsel__roundtrip_name_test’:
tests/evsel-roundtrip-name.c:108:64: error: passing argument 1 of ‘perf_pmu__hybrid_mounted’ discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  108 |         if (perf_pmu__has_hybrid() && perf_pmu__hybrid_mounted("cpu_atom"))
      |                                                                ^~~~~~~~~~

But I still suggest we can keep const type for the parameter for
perf_pmu__hybrid_mounted(), this is more friendly for its callers
without define local strings.

Thanks,
Leo
