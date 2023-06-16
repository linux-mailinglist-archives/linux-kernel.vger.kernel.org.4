Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F874733774
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344681AbjFPRb4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Jun 2023 13:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344043AbjFPRbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:31:52 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A371FDD;
        Fri, 16 Jun 2023 10:31:51 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5164c5bd369so243031a12.1;
        Fri, 16 Jun 2023 10:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686936710; x=1689528710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6foOH820Be2eo+HgY8ANc0xKZkpS4qHIJ6UAnYexJ7E=;
        b=e+9NVm+cis3bpyktz9kUL3Nbi+qxBYTuPhu4FOvYO52kmVSWzXrmSBwJ/Bib9Sqien
         dNY9nxl2kE5QoZODVBudqVtrnKM2/GmbG9094ln8HZr82c5b4LwXe2ppzS38mdLDTMLH
         W17jQLzM4ScryFraQG4e2vtpmph4qVuym67Xnhs5j+awalCl0KiKefS5c3qDXN8wi8J5
         Qht7vmmgm4u6q/c3jDVQOoRYMEsVtQyt92uKiEcoytGf/14WEwmX0pOO+msrjHK9haIJ
         WF0+vaNOFY9S+RrdRGmYlry8NJnx+TgCldW6HQndAt526dd27a2DklANxxVVv35bOg//
         F5ug==
X-Gm-Message-State: AC+VfDwe2RImIrN9rd1/cHpdxitCf0b7SrFb3IgTs+wfl6o6JvwRETAY
        YoFKeeLq8JKoqvJE1V0WngE7GIUpv2ENRFChZds=
X-Google-Smtp-Source: ACHHUZ6NXEkYlVqKpt/p6qZKChllDNPJGZ2TvN6qimzbavltjKOxUJ+LA80hfIPPqKlYeE+NRzBBtmvlV1xvulvfWds=
X-Received: by 2002:a17:906:51cd:b0:977:ead3:c91 with SMTP id
 v13-20020a17090651cd00b00977ead30c91mr2063417ejk.1.1686936709687; Fri, 16 Jun
 2023 10:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230530131348.4135-1-wyes.karny@amd.com> <ZIwJLbNa8qRDlkNn@amd.com>
In-Reply-To: <ZIwJLbNa8qRDlkNn@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Jun 2023 19:31:38 +0200
Message-ID: <CAJZ5v0jYYv_RVy6tjLte2+7pMsigCumkmaGX1VOBzSvsTf41Ag@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Write CPPC enable bit per-socket
To:     Huang Rui <ray.huang@amd.com>, "Karny, Wyes" <wyes.karny@amd.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 9:03 AM Huang Rui <ray.huang@amd.com> wrote:
>
> On Tue, May 30, 2023 at 09:13:48PM +0800, Karny, Wyes wrote:
> > Currently amd_pstate sets CPPC enable bit in MSR_AMD_CPPC_ENABLE only
> > for the CPU where the module_init happened. But MSR_AMD_CPPC_ENABLE is
> > per-socket. This causes CPPC enable bit to set for only one socket for
> > servers with more than one physical packages. To fix this write
> > MSR_AMD_CPPC_ENABLE per-socket.
> >
> > Also, handle duplicate calls for cppc_enable, because it's called from
> > per-policy/per-core callbacks and can result in duplicate MSR writes.
> >
> > Before the fix:
> > amd@amd:~$ sudo rdmsr -a 0xc00102b1 | uniq --count
> >       192 0
> >     192 1
> >
> > After the fix:
> > amd@amd:~$ sudo rdmsr -a 0xc00102b1 | uniq --count
> >     384 1
> >
> > Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > ---
> > v1 -> v2:
> > - Made CPPC enable read/write per-socket
> >
> >  drivers/cpufreq/amd-pstate.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 5a3d4aa0f45a..45b9e359f638 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -63,6 +63,7 @@ static struct cpufreq_driver *current_pstate_driver;
> >  static struct cpufreq_driver amd_pstate_driver;
> >  static struct cpufreq_driver amd_pstate_epp_driver;
> >  static int cppc_state = AMD_PSTATE_DISABLE;
> > +static bool cppc_enabled;
> >
> >  /*
> >   * AMD Energy Preference Performance (EPP)
> > @@ -228,7 +229,28 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
> >
> >  static inline int pstate_enable(bool enable)
> >  {
> > -     return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
> > +     int ret, cpu;
> > +     unsigned long logical_proc_id_mask = 0;
> > +
> > +     if (enable == cppc_enabled)
> > +             return 0;
> > +
> > +     for_each_present_cpu(cpu) {
> > +             unsigned long logical_id = topology_logical_die_id(cpu);
> > +
> > +             if (test_bit(logical_id, &logical_proc_id_mask))
> > +                     continue;
> > +
> > +             set_bit(logical_id, &logical_proc_id_mask);
> > +
> > +             ret = wrmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_ENABLE,
> > +                             enable);
>
> Thanks Wyes, that makes a lot more sense to me. The MSR is per package on
> design. We should only write once per package.
>
> Patch is
>
> Acked-by: Huang Rui <ray.huang@amd.com>

Applied as 6.5 material, thanks!
