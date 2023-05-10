Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DC46FDDB8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbjEJMYZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 May 2023 08:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbjEJMYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:24:23 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F234F1;
        Wed, 10 May 2023 05:24:22 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9659dee48edso192626666b.0;
        Wed, 10 May 2023 05:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683721461; x=1686313461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSZBHtUByJZi4SW+6KpHR0uifnr9MtUZ5oHTSHICAco=;
        b=SgtmX22FNcWbxWB3247KsPKuFZsottpkUtKL/DRu04yHz9wtwx21gkvDJddRdpeStj
         xkE4HQ7YcJxlmO+LGNvzDwjfLRLa3L9fETIuCVSOuJATQdw245/kGA57SU5fA1ROryyP
         NUYBsj++e4G6lHqtMz7IwQ8IzpsXCL9E8c74qJMm0gpRGu/rlpw34xK5JcsjEJLuWwQ3
         Olsjat4M0Zs8q8TtsoCb5R7CJfVxTR1GWZujU2Ld9f8wVv/RMIJz6AtV6onkW9w2qst1
         jXsw+BQN5TNdR9QFl5LSClRRdy9pt4SQP95zbvHRODd2mcSh2tbuxtfy3HwshWbfhhZX
         2fmQ==
X-Gm-Message-State: AC+VfDxsuhQECtyiOx12t1iqK3uxkiNWa+fqL5RiMjmJ0v7ruOY8rz0R
        UmekxI4F0DY6VgYZ9vgpg8FPGhnwg+RkvxbA/lA=
X-Google-Smtp-Source: ACHHUZ5pdtpmr+d9b8b03Vv3o3gybtteiYL9XLVeB2oUJbfvSpyT1uNMLzASy2jdUHrLCyTWQqTJx79eogt4BMJPkKc=
X-Received: by 2002:a17:906:7794:b0:965:9c7d:df96 with SMTP id
 s20-20020a170906779400b009659c7ddf96mr13374092ejm.1.1683721460542; Wed, 10
 May 2023 05:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230509180503.739208-1-wyes.karny@amd.com> <20230509180503.739208-2-wyes.karny@amd.com>
 <CAJZ5v0hN7AxkSf7=8-xP1Pb_7bA2Ba6nGUiK45q01uo_MFa1qQ@mail.gmail.com>
 <CAJZ5v0gb9TpH1qCqhqAb28c7uRRk8=iufTkzc5aCpC=OJm8QaQ@mail.gmail.com> <ZFsu1te+HoKB3drf@BLR-5CG13462PL.amd.com>
In-Reply-To: <ZFsu1te+HoKB3drf@BLR-5CG13462PL.amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 May 2023 14:24:08 +0200
Message-ID: <CAJZ5v0g+ZYdgCAka7zZKTag3fqti_7zA7ychqTHd0Y=JaBHT=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpufreq/schedutil: Remove fast_switch_possible
 flag if driver doesn't set fast_switch
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, ray.huang@amd.com,
        viresh.kumar@linaro.org, srinivas.pandruvada@linux.intel.com,
        lenb@kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, joel@joelfernandes.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 7:43 AM Wyes Karny <wyes.karny@amd.com> wrote:
>
> Hi Rafael,
>
> Thanks for reviewing the patch.
>
> On 09 May 20:39, Rafael J. Wysocki wrote:
> ------------------------------------------>8--------------------------------------
> > > > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > > > index 2548ec92faa2..007893514c87 100644
> > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > @@ -2698,8 +2698,6 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
> > > >
> > > >         intel_pstate_init_acpi_perf_limits(policy);
> > > >
> > > > -       policy->fast_switch_possible = true;
> > > > -
> > > >         return 0;
> > > >  }
> > > >
> > > > @@ -2955,6 +2953,7 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > > >         if (ret)
> > > >                 return ret;
> > > >
> > > > +       policy->fast_switch_possible = true;
> >
> > I'm not sure what this is about.  Is it a cleanup of intel_pstate?
>
> This patch intends to remove fast_switch_possible flag dependency from
> drivers which only use adjust_perf as frequency/pref update callback. As
> intel_pstate and amd_pstate driver has only adjust_perf and not
> fast_switch, therefore I'm removing that flag from these drivers. But
> intel_cpufreq has fast_switch therefore, only adding that flag for
> intel_cpufreq driver.

But is it really better to change it?  It works correctly as-is AFAICS.

In any case, the intel_pstate change should be a separate patch,
because it is not directly related to the other changes in the
$subject one IMV.
