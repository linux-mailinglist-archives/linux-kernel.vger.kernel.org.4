Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791545F0417
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiI3FMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiI3FMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:12:07 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495BB3C8CA;
        Thu, 29 Sep 2022 22:12:07 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id u3-20020a4ab5c3000000b0044b125e5d9eso1527535ooo.12;
        Thu, 29 Sep 2022 22:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=78/bHk+OuS7djDBRddAmPd8q1x7mvF1xbm11TXxIBb8=;
        b=eSdLjKzR3DdSfjk6FnXUIWLiC968bVENYFnkP8ZUX5ZwQ/ZbS2AF8841TZj/E2Zasm
         3wV0ea2ShuipkrNoDoic6XpDqk7Yk3W1B+fBY12hiBsuMThT0DMvCPV6+E7f7ENN10oF
         LiNNmQPMOyo1nD/6+WYKDu/5d1OS6pa9sAGsOAEoMmQh97XM2/39gFg6YyfLQ1knpzQC
         kWpkQjQoor8DSbQ3regGeyywGVlt5okMjAy90BUSl9Kq5XRhbex/btca/oPtq0iYy6/L
         4GCzq7kX0QgnWPgz3OfVK9Gc6PfBf55NcRTyweoPWgoGopa/6Lie1pu5h+zu+jE6zLZ8
         R+ww==
X-Gm-Message-State: ACrzQf2SxlCGsE7bD5NDI0CEoYKxtNuh8xSuJbBqpjcCkG4MxzwiHFCY
        oRPuG4YKXsGPeVW6sm+V2swhjl5/oyCir9WEyOw=
X-Google-Smtp-Source: AMsMyM7h15FHkg48g9EJFRYbg5UbdADOdsK7bR7HGEnFB8+SxP4DGD5LV4vwtoo1qz7P4P4lNfypTlcce0MHFy6q8+w=
X-Received: by 2002:a9d:6e0f:0:b0:655:f372:f18b with SMTP id
 e15-20020a9d6e0f000000b00655f372f18bmr2953809otr.206.1664514726565; Thu, 29
 Sep 2022 22:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220928095805.596-1-ravi.bangoria@amd.com> <20220928095805.596-3-ravi.bangoria@amd.com>
 <CAM9d7cjVcGLn+dmajox6ASxx=YQYv9Viv+wzSXdaqCEJrow56w@mail.gmail.com> <aa91fc2d-319c-bbb2-d011-e60f7c04d776@amd.com>
In-Reply-To: <aa91fc2d-319c-bbb2-d011-e60f7c04d776@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 29 Sep 2022 22:11:55 -0700
Message-ID: <CAM9d7ch3gEn15g7zZOHNUcEJ0aO-Gu2+7nz9QD45+WeY0fcgyg@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] perf/x86/amd: Add IBS OP_DATA2 DataSrc bit definitions
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 9:49 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> On 30-Sep-22 10:11 AM, Namhyung Kim wrote:
> > Hi Ravi,
> >
> > On Wed, Sep 28, 2022 at 2:59 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >>
> >> IBS_OP_DATA2 DataSrc provides detail about location of the data
> >> being accessed from by load ops. Define macros for legacy and
> >> extended DataSrc values.
> >>
> >> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> >> ---
> >>  arch/x86/include/asm/amd-ibs.h | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >>
> >> diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
> >> index f3eb098d63d4..cb2a5e113daa 100644
> >> --- a/arch/x86/include/asm/amd-ibs.h
> >> +++ b/arch/x86/include/asm/amd-ibs.h
> >> @@ -6,6 +6,22 @@
> >>
> >>  #include <asm/msr-index.h>
> >>
> >> +/* IBS_OP_DATA2 DataSrc */
> >> +#define IBS_DATA_SRC_LOC_CACHE                  2
> >> +#define IBS_DATA_SRC_DRAM                       3
> >> +#define IBS_DATA_SRC_REM_CACHE                  4
> >> +#define IBS_DATA_SRC_IO                                 7
> >> +
> >> +/* IBS_OP_DATA2 DataSrc Extension */
> >> +#define IBS_DATA_SRC_EXT_LOC_CACHE              1
> >> +#define IBS_DATA_SRC_EXT_NEAR_CCX_CACHE                 2
> >> +#define IBS_DATA_SRC_EXT_DRAM                   3
> >> +#define IBS_DATA_SRC_EXT_FAR_CCX_CACHE          5
> >
> > Is 4 undefined intentionally?
>
> Yes, Here is the snippet from PPR (Processor Programming Reference) doc:
>
>   Values | Description
>   ---------------------------------------------------------------------
>   0h     | No valid status.
>   1h     | Local L3 or other L1/L2 in CCX.
>   2h     | Another CCX cache in the same NUMA node.
>   3h     | DRAM.
>   4h     | Reserved.
>   5h     | Another CCX cache in a different NUMA node.
>   6h     | DRAM address map with "long latency" bit set.
>   7h     | MMIO/Config/PCI/APIC.
>   8h     | Extension Memory (S-Link, GenZ, etc - identified by the CS
>          | target and/or address map at DF's choice).
>   9h-Bh  | Reserved.
>   Ch     | Peer Agent Memory.
>   Dh-1Fh | Reserved.

Thanks for sharing it.  It's a bit confusing since it was available before.

Anyway, is the PPR for Zen4 publicly available now?

Thanks,
Namhyung
