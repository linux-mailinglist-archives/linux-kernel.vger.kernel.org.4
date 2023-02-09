Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3DE69113D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBITXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBITXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:23:08 -0500
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11CF69513;
        Thu,  9 Feb 2023 11:23:07 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id gr7so9549428ejb.5;
        Thu, 09 Feb 2023 11:23:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7o5yTbpWRbzj9iV3iQMg/9LappBGRsRzPY57bghk5oU=;
        b=jddJbjN+X+BmmGtoMWg/cNrH8cW8/o/7ydDYZS2ShCk8aSwZwi+JHA7CjH3AZIBsZr
         jAS4JodTA60F0+uISan/rXTNC5uT8/2oVEWlbMEXlJhlaDDntU/NT5I/jGj8ft7t0KUG
         f4gM/4gL5nv1dFDR9i4kutCI0MDIAz5J3JPl/UQHLxGmxl4G7jHV2XE4B32mKIh5RHuy
         U9lGsQK4XUd4SIipI/4MaVDaOubrIle8CJMo7rsgxl951b2xfcMN7rudL+Yc4s83TWhv
         3cTxHGH41Stct3aJUbgcqvNnFTeonEI9163RbQBsmc4DGNyH1rStwvQakGjWc7L+aE0r
         9p6g==
X-Gm-Message-State: AO0yUKVu04En1hlWmZNd+0eDrMYC/iDBcmZJh10IJju2tjt0CJAyNExP
        0aj3AfMnNJe159gjHiJF+FJvpufMcNsKXX28ork=
X-Google-Smtp-Source: AK7set86SSL9/+hxZ5DwxUScmEiB63Hmf+cjyivUHUwm9nb8TvZguV1Yj3Zsf8KCYhILkpaEAi5LmZu9uTRd2EUB5Qw=
X-Received: by 2002:a17:906:ce2e:b0:87f:575a:9b67 with SMTP id
 sd14-20020a170906ce2e00b0087f575a9b67mr2937313ejb.274.1675970586239; Thu, 09
 Feb 2023 11:23:06 -0800 (PST)
MIME-Version: 1.0
References: <20230207161256.271613-1-arnd@kernel.org> <Y+R+uNXkS/BPpdZc@amd.com>
In-Reply-To: <Y+R+uNXkS/BPpdZc@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Feb 2023 20:22:55 +0100
Message-ID: <CAJZ5v0h44yCRdQhYvuB3dMVyjm0S+yNBRFsmzE4KA2PCfViWng@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: avoid uninitialized variable use
To:     Huang Rui <ray.huang@amd.com>, Arnd Bergmann <arnd@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Jinzhou Su <Jinzhou.Su@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Feb 9, 2023 at 6:04 AM Huang Rui <ray.huang@amd.com> wrote:
>
> On Wed, Feb 08, 2023 at 12:12:51AM +0800, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The new epp support causes warnings about three separate
> > but related bugs:
> >
> > 1) failing before allocation should just return an error:
> >
> > drivers/cpufreq/amd-pstate.c:951:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
> >         if (!dev)
> >             ^~~~
> > drivers/cpufreq/amd-pstate.c:1018:9: note: uninitialized use occurs here
> >         return ret;
> >                ^~~
> >
> > 2) wrong variable to store return code:
> >
> > drivers/cpufreq/amd-pstate.c:963:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
> >         if (rc)
> >             ^~
> > drivers/cpufreq/amd-pstate.c:1019:9: note: uninitialized use occurs here
> >         return ret;
> >                ^~~
> > drivers/cpufreq/amd-pstate.c:963:2: note: remove the 'if' if its condition is always false
> >         if (rc)
> >         ^~~~~~~
> >
> > 3) calling amd_pstate_set_epp() in cleanup path after determining
> > that it should not be called:
> >
> > drivers/cpufreq/amd-pstate.c:1055:6: error: variable 'epp' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
> >         if (cpudata->epp_policy == cpudata->policy)
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/cpufreq/amd-pstate.c:1080:30: note: uninitialized use occurs here
> >         amd_pstate_set_epp(cpudata, epp);
> >                                     ^~~
> >
> > All three are trivial to fix, but most likely there are additional bugs
> > in this function when the error handling was not really tested.
> >
> > Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks!
>
> Acked-by: Huang Rui <ray.huang@amd.com>
>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 168a28bed6ee..847f5f31396d 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -940,7 +940,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
> >       int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> >       struct amd_cpudata *cpudata;
> >       struct device *dev;
> > -     int rc;
> >       u64 value;
> >
> >       /*
> > @@ -950,7 +949,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
> >       amd_perf_ctl_reset(policy->cpu);
> >       dev = get_cpu_device(policy->cpu);
> >       if (!dev)
> > -             goto free_cpudata1;
> > +             return -ENODEV;
> >
> >       cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
> >       if (!cpudata)
> > @@ -959,8 +958,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
> >       cpudata->cpu = policy->cpu;
> >       cpudata->epp_policy = 0;
> >
> > -     rc = amd_pstate_init_perf(cpudata);
> > -     if (rc)
> > +     ret = amd_pstate_init_perf(cpudata);
> > +     if (ret)
> >               goto free_cpudata1;
> >
> >       min_freq = amd_get_min_freq(cpudata);
> > @@ -1076,9 +1075,9 @@ static void amd_pstate_epp_init(unsigned int cpu)
> >               value |= (u64)epp << 24;
> >       }
> >
> > +     amd_pstate_set_epp(cpudata, epp);
> >  skip_epp:
> >       WRITE_ONCE(cpudata->cppc_req_cached, value);
> > -     amd_pstate_set_epp(cpudata, epp);
> >       cpufreq_cpu_put(policy);
> >  }
> >
> > --

Applied, thanks!
