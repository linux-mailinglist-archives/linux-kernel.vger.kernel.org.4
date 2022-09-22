Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8135E6878
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiIVQcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIVQcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:32:19 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77F253D30
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:32:18 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-127ba06d03fso14652084fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+3TzsNVY7iYdcanfUV/aboTbt4XNfCYgLErrvCARcKs=;
        b=464R1CC8EcxRXFtVzWyF+61ZLIRNkDnbNfhEt7MmgITRGVK5SJtOh4iANzQGh0YinR
         tAGhYLSwMTxorhek/zq7zVbmaKIM11L0vaaN0xgphO4yT/K4uezmMeIhiJwxM7o04vnJ
         Ah3uI1q3CmDivDsjrW7antOoUO+WMn+jya9yipNzmYTVt/Yog7EBTrylsD4msQlTv2+Q
         NgcgPNOcTakFgU0fnKV3ePtttICkvVa+EJs7L2qZhqcAwFq9dMlgd5fbFCQC07DL2i1G
         rQWeKMmE8XWIRpK7EjaZD2LKxYfjRFIWhUclIAnLtwSjCAUFfCZxtWaf1e3qId5Rhj6w
         Yriw==
X-Gm-Message-State: ACrzQf2/aRHzBlRlaW7V8LCrUymUhNCkCCm3WdqUOQCMPMhYZktyr/+K
        n0PNwt9RPk43zsUTQBxQbBPA+Zhe9cFYebLLBG0L3e8s
X-Google-Smtp-Source: AMsMyM7VNeJ/Ys1k7t9r01h732ovkdaitK51eWp+JLmVs8TC6w5HvZMUOWwXee84ySD5qKsHT+VhFphip945OwFNxkg=
X-Received: by 2002:a05:6870:524b:b0:12c:cfd2:81c0 with SMTP id
 o11-20020a056870524b00b0012ccfd281c0mr2476748oai.209.1663864337974; Thu, 22
 Sep 2022 09:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220921220032.2858517-1-namhyung@kernel.org> <Yyx1wv06cL0pkQ6H@hirez.programming.kicks-ass.net>
In-Reply-To: <Yyx1wv06cL0pkQ6H@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Sep 2022 09:32:06 -0700
Message-ID: <CAM9d7cgDTy96eeCAARufSKZJFMvAAo6QSLAoEQv_zUFD-Rf+Lw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf: Use sample_flags for addr
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>
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

Hi Peter,

On Thu, Sep 22, 2022 at 7:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Sep 21, 2022 at 03:00:31PM -0700, Namhyung Kim wrote:
> > Use the new sample_flags to indicate whether the addr field is filled by
> > the PMU driver.  As most PMU drivers pass 0, it can set the flag only if
> > it has a non-zero value.  And use 0 in perf_sample_output() if it's not
> > filled already.
>
> So no objection to the general idea; just a question
>
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 368bdc4f563f..f4a13579b0e8 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -1028,7 +1028,6 @@ struct perf_sample_data {
> >        * minimize the cachelines touched.
> >        */
> >       u64                             sample_flags;
> > -     u64                             addr;
> >       struct perf_raw_record          *raw;
> >       u64                             period;
> >
> > @@ -1040,6 +1039,7 @@ struct perf_sample_data {
> >       union perf_sample_weight        weight;
> >       union  perf_mem_data_src        data_src;
> >       u64                             txn;
> > +     u64                             addr;
> >
> >       u64                             type;
> >       u64                             ip;
>
> Is there a reason you placed the variable where you did?

No I just followed the previous change.

>
> I'm thinking we should look at what perf-tool thinks is the common set
> of SAMPLE flags and make sure those fields are grouped in as little
> cachelines as possible.
>
> Things like @ip and @type, which are basically *always* set, should
> definitely be on top, no?

Yes, you're right.  With this change we can move the optional fields
and group the common fields on top - like ip, period, pid and so on.

Will send a patch to do the move on top of this, ok?

Thanks,
Namhyung
