Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A4B5EEE06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiI2GsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiI2GsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:48:10 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E155129696
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:48:09 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d82so615854pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Y2jtn+YsX5psuE/71sdgLvbCvSb2B8wIQO3pPPOaBMU=;
        b=DGMv8gpt078xYbXObstLocpu9x9DdBibz3qT7uIeJPUOznSsVgwQntQ+WJdvY9fTwS
         dVAHay4BA6NHfzzWyRvqpFaKOC1KHwqW6fDSE1vbhjShXptPMOk+SRV4JCPrwDGE5yBa
         vMjEaYkAG66Casvyiry8jguN6Zq63E7VL8XD3hJYlvr7lQUJFyn/lEytlLwgihHGOgX3
         hZSVvPh1Km+uE8bLB/U+uDsJ6QEj2VAw8SeBkPg3czg0jKnlnFplsDmnfXAOGR8ryzcv
         SJ3qS8ysSyVMKSOKfDI9quQTRn/zt1nkffIVSHjeVcKaBGauAFNFLXx7XVRCtP1G9axu
         MbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Y2jtn+YsX5psuE/71sdgLvbCvSb2B8wIQO3pPPOaBMU=;
        b=Ax/3cqvDQDIBv6URXIF+E7Z3iDYn92JpbDb0pO2lr5skBlSVFFgjtFnhHIEA+GP02g
         NmQRxPv5cseRBpBioUJmRQT/G/+sCy4oCUpNezouYFevUlYuEe2et040QRMwSXbdml3B
         hTulzuZkEtikFfVTBLcVSG7MxTZAf+11fUk77eWL3Keg/Fz2zn3JagqONicYN7AahEe+
         h+1ZlkwbQjj+CS9PtysPQWpwkObgCm6I26nN97YdQr+tl+M59ft1kVTFn9FO2KvZDm1X
         8HFj9ILeFIPTdKXybtM4xUSgbLRzo3wAX1sdfSwHo4Q4JjAUFXoRDYyuurJRU8Ogj3OY
         DIiQ==
X-Gm-Message-State: ACrzQf1pDqZaDINpoLS2Y/Jhq7cU5DC1O0ooEcjix3Fy9JGjH8klU/fu
        32JISAWXB/r8h7xfBGYwVmj9wQ==
X-Google-Smtp-Source: AMsMyM5j6SlieS8WhzXlMCDit/9ENlLW9wBz60DdYObn9/Dux3ybEv8MDhzasmfU6daWQYDJmzQJnQ==
X-Received: by 2002:aa7:88c7:0:b0:542:3229:8d11 with SMTP id k7-20020aa788c7000000b0054232298d11mr1909374pff.41.1664434088793;
        Wed, 28 Sep 2022 23:48:08 -0700 (PDT)
Received: from leoy-yangtze.lan (173.242.120.49.16clouds.com. [173.242.120.49])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709027fcd00b00176be23bbb3sm4979563plb.172.2022.09.28.23.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 23:48:08 -0700 (PDT)
Date:   Thu, 29 Sep 2022 14:48:03 +0800
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
Message-ID: <YzU/o3kxS/BYpJhn@leoy-yangtze.lan>
References: <20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org>
 <20220914-arm-perf-tool-spe1-2-v2-v3-1-8189fc04dcc6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914-arm-perf-tool-spe1-2-v2-v3-1-8189fc04dcc6@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Sep 14, 2022 at 03:08:34PM -0500, Rob Herring wrote:

[...]

> +void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
> +{
> +	struct perf_pmu_format *format;
> +
> +	list_for_each_entry(format, &pmu->format, list)
> +		if (format->value >= PERF_PMU_FORMAT_VALUE_CONFIG_END) {
> +			pr_warning("WARNING: '%s' format '%s' requires 'perf_event_attr::config%d'"
> +				   "which is not supported by this version of perf!\n",
> +				   pmu->name, format->name, format->value);
> +			return;
> +		}
> +}

Though I saw you and Namhyung have discussion in underway, this patch
set is fine for me.  I validated the patches at my side (with a bit
hacking in Arm SPE driver for faking invert filter).  You could add my
tested tag for this patch set:

Tested-by: Leo Yan <leo.yan@linaro.org>

But I want to remind two things after I used "perf test" to validate
this patch set:

  $ ./perf test list
  6: Parse event definition strings
  6:1: Test event parsing
  6:2: Test parsing of "hybrid" CPU events
  6:3: Parsing of all PMU events from sysfs
  6:4: Parsing of given PMU events from sysfs
  6:5: Parsing of aliased events from sysfs
  6:6: Parsing of aliased events
  6:7: Parsing of terms (event modifiers)
  $ ./perf test -v 6

The first one is this patch set introduces segmentation fault for the
case "Parsing of aliased events" (See tests/parse-events.c).  But the
issue is caused by the test case itself; we need to add below line into
test_event_fake_pmu() for initialisation list header.

    INIT_LIST_HEAD(&perf_pmu__fake.format);

The second question is for testing config3 in "perf test".  You could
see the file tests/parse-events.c has included several test cases for
config/config1/config2.  It's good to add the same testing for config3
as well, please see test__checkevent_pmu() and test__checkterms_simple()
for relevant code.

Thanks,
Leo
