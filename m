Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111E05F0409
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiI3FJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiI3FJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:09:17 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CAD1E76BA;
        Thu, 29 Sep 2022 22:09:15 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id w13so3698462oiw.8;
        Thu, 29 Sep 2022 22:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6RM89Byu2LpMlB032kAwVuhcqo3t7ahKn4wTlqPwd5U=;
        b=UL/vEGGlKuK6SlP7pTvrZtS+ktrR2DQ3LEva2sDd3/emiVL6FfpLTDoLcQeDy5Pn7g
         l4J0ke/GDtvj62VrFLRX2iMM7/A7tf2zFcL4CxLYp97iGBhO44TABl/Tk3ZjT8svBhdM
         xl6N71agm51ScRKJWpRk5IVl8S/9U/SXhBlD4NYiROEY+a/fKJ8pCpGTnk7WGOHRbENA
         w6GDHsNU+2YKSdVNkFQseIYCF0mVcVz63pWmuQqqYTbq0HvhvHjQjv4zF+qeqVaUUYjR
         cazlVeDboiBfu0dSOW1LMzmHSjL2z5WsQH+btEm4ioogJDCAHtRvgXAQOdz1WQ5Zn9mI
         9hUw==
X-Gm-Message-State: ACrzQf2RYD/b/CQBfkNCFQd0PbAId30uILfXfX/X98x/SmHPy8AVlF0A
        iOMq6ad7eEqQCKoJTRgb7arQC6wfnjsC1IeKe/U=
X-Google-Smtp-Source: AMsMyM6Ty8bidFRKTuL5JZbxFvpIwTdTEEQKWdmmu/ar5ZFp2hHnsqIIuTVKiOVB7mMvEUOoEAd7NZsdnZmHWm9BbvQ=
X-Received: by 2002:a05:6808:1a09:b0:350:107b:f89a with SMTP id
 bk9-20020a0568081a0900b00350107bf89amr3222806oib.218.1664514554592; Thu, 29
 Sep 2022 22:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220928095805.596-1-ravi.bangoria@amd.com> <20220928095805.596-5-ravi.bangoria@amd.com>
In-Reply-To: <20220928095805.596-5-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 29 Sep 2022 22:09:03 -0700
Message-ID: <CAM9d7chNQsydfqMbVLY5tHFXE9kyjkqDA1SKWtR5vsBCV5u1hg@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] perf/x86/amd: Support PERF_SAMPLE_{WEIGHT|WEIGHT_STRUCT}
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        Leo Yan <leo.yan@linaro.org>, alisaidi@amazon.com,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        dave.hansen@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>, ananth.narayan@amd.com,
        Kim Phillips <kim.phillips@amd.com>, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 2:59 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> IbsDcMissLat indicates the number of clock cycles from when a miss is
> detected in the data cache to when the data was delivered to the core.
> Similarly, IbsTagToRetCtr provides number of cycles from when the op
> was tagged to when the op was retired. Consider these fields for
> sample->weight.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
> Note:
> While opening a new event, perf tool starts with a set of attributes
> and goes on reverting some attributes in a predefined order until it
> succeeds or run out or all attempts. Here, 1st attempt includes both
> WEIGHT_STRUCT and exclude_guest which always fails because IBS does
> not support guest filtering. The problem however is, perf reverts
> WEIGHT_STRUCT but keeps trying with exclude_guest. Thus, although,
> this patch enables WEIGHT_STRUCT support from kernel, using it from
> the perf tool needs more changes(not included in this series).

Yeah, it'd be nice if kernel could expose more pmu capabilities like
no-exclude then tools can skip setting it for them.

Thanks,
Namhyung
