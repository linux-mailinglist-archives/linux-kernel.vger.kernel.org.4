Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE965F9FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJJOGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiJJOGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:06:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD1E6AE87;
        Mon, 10 Oct 2022 07:05:59 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f11so17233151wrm.6;
        Mon, 10 Oct 2022 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WfbmCh4Xd7NmHwkQp27IHc6Fb0+tmSJSyPcW5XETK5Q=;
        b=pDGlnjksJk7ui6SeN4AwbZpBz1s9v9uzLet0dSGEZHmpOFOEYeKtNxmIng2BLHbMYC
         J9VqjpuMmkw5HMFmeuZBt1y1FXWmFmS/o/BZg1bat8Ce+HiInTrEAmwoex9JHgip8jJ+
         iCM50d7iBdDeN8kDwWSwN6cNeJn1SOYrCkI2IMwRHpaGaCamLh0IZoRNRyhLeO4yUyF4
         Dy4sZfobz2wprMEfOvXEIX143ya1cBhcw7lcN+8qAFLpNbX1nIj9V/TRKobHi/xbfvRD
         y7eDYD+CsoWG30vGFenBCl+ShkPO2Zn+y0ugnx159lJPyi+E1U0BD5db3TiCv10BQ3ei
         gViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfbmCh4Xd7NmHwkQp27IHc6Fb0+tmSJSyPcW5XETK5Q=;
        b=3ah9KlawwhfMh+DatMFeUo000XScRMlZKOaAH2rDjRhk4+ZQCbdIaLveF5xIYQK+gt
         FlOFEPe3LSEWHRnc6gOdlPqAd7rZxn8kKtdV5vKv7qlrqbO+mm+7IJGiAzVi52GT+jJj
         dztqatJiNtag6FagLXPzwDdbi/LvxgirBagDWI03B+8fyK2//XZyg+624r93RykUyf+4
         o8S07k2cVM5PXqnXuT4g8AXeJ+Nbds+IZMH1rQW0J0rqja4oAfU9EX/YmyMva/SvtXho
         9pp0ls9Q0cHXt6PQgh18QyV9HahooWhnUMRw9CBTdQKKrnnBFnkrZgi4D9zeHIPiIqGs
         jumA==
X-Gm-Message-State: ACrzQf3zoWTNbqZd1gzV94rzf0uB4dHRUpO9dQ1vlfMigHnBCfhHDfie
        SSAL6+7QMGRG4waT7/nvlzA=
X-Google-Smtp-Source: AMsMyM48BA7z/m402G3MA+kDVF1iO8QFE3FITWl4CvXSr+DdU5yTNVGDoRMn0mnH+XqrnL9DniQesQ==
X-Received: by 2002:adf:ba01:0:b0:22e:7318:4e94 with SMTP id o1-20020adfba01000000b0022e73184e94mr12094202wrg.330.1665410757707;
        Mon, 10 Oct 2022 07:05:57 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b003c4ecff4e25sm7004470wmq.9.2022.10.10.07.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 07:05:56 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 10 Oct 2022 16:05:54 +0200
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf parse: Allow names to start with digits
Message-ID: <Y0QmwjY0lJ+CNxvH@krava>
References: <CAP-5=fXgNTW1eXRZhz-s_AfP+v1Oyx1zdksm-Q0B4YVPAgjKxw@mail.gmail.com>
 <YsLOKEqzp0Syz/Rt@krava>
 <Y0Ov7hSuWQJlYAdW@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0Ov7hSuWQJlYAdW@codewreck.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 02:38:54PM +0900, Dominique Martinet wrote:
> Hi Jiri, Ian,
> 
> Jiri Olsa wrote on Mon, Jul 04, 2022 at 01:25:28PM +0200:
> > > If you're ok with that I can resend this as three patches: my original
> > > patch, a patch with your diff and test_event() keeping current
> > > behaviour, and a last patch adding that last flag and testing 9p without
> > > format check.
> > > 
> > > (and if you don't think it's worth checking probe existence same thing
> > > but even simpler)
> > 
> > I have that patch split into 2 separated changes,
> > I'll try to send it later today
> 
> It's been a while (I had totally forgotten), but I don't think I saw
> this patch.
> 
> For reminder you've requested that I add some test for a tracepoint
> starting with digits e.g. 9p:9p_client_res but there's nothing commonly
> available to use there, so you added a way to only check without
> checking if a backing tracepoint exist, but I see no trace of the update
> you sent here:
> https://lore.kernel.org/all/YsGduWiTvkM2/tHv@krava/
> 
> Should I take it, do the split you suggested and send it together with a
> resend of my original patch and new test?

ah, it fell through the cracks, sry.. if you could resend it,
that'd be great

thanks,
jirka

> 
> 
> Ian Rogers wrote on Mon, Jul 04, 2022 at 02:39:05PM -0700:
> > > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> > > index 5b6e4b5249cf..4133d6950d29 100644
> > > --- a/tools/perf/util/parse-events.l
> > > +++ b/tools/perf/util/parse-events.l
> > > @@ -211,7 +211,7 @@ bpf_source  [^,{}]+\.c[a-zA-Z0-9._]*
> > >  num_dec                [0-9]+
> > >  num_hex                0x[a-fA-F0-9]+
> > >  num_raw_hex    [a-fA-F0-9]+
> > > -name           [a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
> > > +name           [a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
> > 
> > Perhaps this would be cleaner as:
> > name           [a-zA-Z0-9_*?\[\]!]+
> > except that would allow a name to start with an exclamation. Would
> > that be an issue?
> 
> Sorry for the lack of reply -- I have no opinion on this as long as we
> can use digits.
> I can't imagine any probe starting with . or !, but that does not seem
> to create any ambiguity with the rest of the grammar that I can see
> either so I think it'd be fine, but I'm not comfortable deciding.
> 
> 
> Thanks,
> --
> Dominique
