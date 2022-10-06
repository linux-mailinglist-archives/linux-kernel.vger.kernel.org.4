Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D925F60BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiJFFpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiJFFpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:45:13 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2186A32A93
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 22:45:13 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y15so155438pff.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 22:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=zHiKWHLUiEejnPGH1G2wAyZsdKfADMIbnHWjWlmRMao=;
        b=tl8RJsAPTOLZS/YMGLNBH1ch7H4kbv9Y1gZtT9Ull0r5CBiD6eUdSipUWpN81KZD4o
         1B2B7DnDh1UkERW85Kpuwu94+gpahq9tgcUK4bAZ41sM2gdyAWdR2yJhde597K3T5ijb
         YS57MhN2YnsOTLUhB3XmjywOZZt5msHmyPjDnzU59v1fugjfQsSY+YSnS8pav99+URgn
         sYfh2wSV3xu5ZxiuZm1tXH5eiWYCU9Dp85BfZ53BPIeArxaaCU7CqPt/ZeEykdqZnLAj
         E1tdx37CJ8wfwINyGwIOe5cu1NhW9vHO71MVVQqWE5tOQFJ4WS7XTmRL9xuMyzRc13Bk
         Q9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zHiKWHLUiEejnPGH1G2wAyZsdKfADMIbnHWjWlmRMao=;
        b=jWswM6VL3C2wkXfzoYe5w67R35RPiy08HMYt/AdMEdUX5LeYo6PlIFmO7jtAQzk2ui
         ObGZ4ghouygf1LRo8WBrQv5KZhcDpaAL3NB6fmklTZhhRW+vuNVAobsdAM+agnxaxocp
         MOz5V/v8a27jvYWzlqCWgPdlcMeuHnmCYEbS7/kpOHEwhDEPB+cSgAXxvu8W/1eTYEta
         8YKYiIawL42Awpaexcg6O86379CMiSQaBDSXzl0njXQc1H12nLK/D/YLzugCt28vJIm3
         5IgzEHnW6Ami/9AZbou6jcAqs5xYhIptFnfCxllxjCqWdrivOhyAbOzqOXFSC1CF0ivF
         AqRg==
X-Gm-Message-State: ACrzQf06Kb1Y40zq6T9jGwbSLFkToYraQZ2QvQEnd6dxAkRJEwxseTGi
        dtUahIg3SGZ1OIHBFGCWWCmfOA==
X-Google-Smtp-Source: AMsMyM5vd8OGf+eWFBFD9UvRzJr7NaLqmbEhXMZTxTI6ty50qCKgo7J7kWQc4x+BqzwP5m3G5NO1pQ==
X-Received: by 2002:a05:6a00:cd6:b0:546:d03:3dd7 with SMTP id b22-20020a056a000cd600b005460d033dd7mr3034708pfv.19.1665035112497;
        Wed, 05 Oct 2022 22:45:12 -0700 (PDT)
Received: from leoy-yangtze.lan (45.78.17.119.16clouds.com. [45.78.17.119])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902710f00b0017f9021ddc6sm584474pll.289.2022.10.05.22.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 22:45:11 -0700 (PDT)
Date:   Thu, 6 Oct 2022 13:45:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] perf: Skip and warn on unknown format 'configN'
 attrs
Message-ID: <Yz5rYU/sWtJcRZ7B@leoy-yangtze.lan>
References: <20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org>
 <20220914-arm-perf-tool-spe1-2-v2-v3-1-8189fc04dcc6@kernel.org>
 <YzU/o3kxS/BYpJhn@leoy-yangtze.lan>
 <CAL_Jsq+3pt_yr5LLFNR-DsXQycD-_gd5fum8QbfxUzHPR-zfJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+3pt_yr5LLFNR-DsXQycD-_gd5fum8QbfxUzHPR-zfJw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 12:07:30PM -0500, Rob Herring wrote:

[...]

> >     INIT_LIST_HEAD(&perf_pmu__fake.format);
> 
> I ended up fixing this in perf_pmu__warn_invalid_formats() instead as
> the test dealing with internal stuct pmu details didn't seem right:
> 
> +       /* fake pmu doesn't have format list */
> +       if (pmu == &perf_pmu__fake)
> +               return;
> +

Good point.  It would be even better to fix it in the first place
rather than checking fake PMU in perf_pmu__warn_invalid_formats(),
how about below fixing in util/pmu.c?

-struct perf_pmu perf_pmu__fake;
+struct perf_pmu perf_pmu__fake = {
+       .format = LIST_HEAD_INIT(perf_pmu__fake.format),
+};

Thanks,
Leo
