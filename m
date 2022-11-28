Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F31B63AEA2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiK1RPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiK1RO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:14:59 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422931F60D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:14:58 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id h131-20020a1c2189000000b003d02dd48c45so6353466wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yuTB0LuVTvAuueCSXqErL8XhQHEeQdK/qmHJKdgaoM=;
        b=MioE/8if35q06jJbNXzrxjxJbAUCDJ4IPzSR3FuF4oogTs2mMb/0SYaNGRKRGLp/Px
         ehQ/HA2JB61b5hTujyPoYhA5fg6wPwTcUPWxPWHqTOpC3t2UuFPembWEbM7yFRWmqDZi
         7v3ILMSh3eX90XgIImg2tg9uKyYzBYHrqt/SFjrrEbA4RWd+SjRMuaofck4AepO4jbAL
         0USg2DkvxxYPnIx7gLhoW8DrwWbD1bE3m9HpKM8AVkW0ytLm2oJMsRGMN9tvSiR7YiIX
         8AMfc9/SzA+Sl9pwof1b+2wNNdTsGIGB0bwF22nSSyL4LzGJjIo/mMWbfQxFgUpnHDOK
         YKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yuTB0LuVTvAuueCSXqErL8XhQHEeQdK/qmHJKdgaoM=;
        b=wAptd7KHff4j+k+ByuIeN7MFTv2tk8vh0858dkqR8krgNs5NAMyPQZA+FGvTUP9hb4
         CThJKsDdPoEYrX9teV27IC8vWUCPu8hqp8+wSFI1T8A6VHTERDDGf1Drv690JFz6l3d/
         zG7i+VL2/ldSeB5rXfvlkJNx2eFWZON/AFfsZ2frGCmVg3NmA5rReSyXMEFg47nou7j6
         y9LZJOpWj+g6ShStnLGsKY+xu0wD8bI8/2DLcLeDFWKPpd/lirg3sRNFplkye3t+MJmw
         kOb5ermAZgOIiUoeHXMEoHtiUhYkNJdgJMO4vYuXyZ9IpGdynZPJ+n4f3PRjmVgyrXaJ
         RnrQ==
X-Gm-Message-State: ANoB5pliX/81ng8VHufRPOO1lYmW2W/OwBuiLQ8v2lKNp92sHjmUmq1n
        R6G9Xa0NP7ICecWCYVDGEtjT+NObLYevsmuljmfpWw==
X-Google-Smtp-Source: AA0mqf7epnQVWOqbkHx8YWf9JOxQr4sQF58dFGKhnNvZWFDTLsAdLFXKntQ7VhGYubEldWmwxw0dxY7KAlq25a3HyrM=
X-Received: by 2002:a05:600c:4920:b0:3cf:8b23:549c with SMTP id
 f32-20020a05600c492000b003cf8b23549cmr30520502wmp.174.1669655696520; Mon, 28
 Nov 2022 09:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20221125032018.962-1-ravi.bangoria@amd.com> <CAP-5=fVtFLuFzYY8x72ib1=G8n-aFYjqRmttxsu7t-oFGnCWEw@mail.gmail.com>
 <dda39c0a-0857-e650-b5ba-5fcff2414179@amd.com>
In-Reply-To: <dda39c0a-0857-e650-b5ba-5fcff2414179@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 28 Nov 2022 09:14:44 -0800
Message-ID: <CAP-5=fU_gzuUnSqGKOrjg1ns5rFuuWu06bp8z9aSUXDGiveMPg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Add event group test
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, jolsa@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, mark.rutland@arm.com,
        kan.liang@linux.intel.com, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, carsten.haitzler@arm.com,
        leo.yan@linaro.org, maddy@linux.ibm.com, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, tmricht@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 11:02 PM Ravi Bangoria <ravi.bangoria@amd.com> wrot=
e:
>
> On 27-Nov-22 8:58 AM, Ian Rogers wrote:
> > On Thu, Nov 24, 2022 at 7:21 PM Ravi Bangoria <ravi.bangoria@amd.com> w=
rote:
> >>
> >> Multiple events in a group can belong to one or more pmus, however
> >> there are some limitations to it. Basically, perf doesn't allow
> >> creating a group of events from different hw pmus. Write a simple
> >> test to create various combinations of hw, sw and uncore pmu events
> >> and verify group creation succeeds or fails as expected.
> >
> > Awesome, thanks! Some comments below.
>
> Thanks Ian!
>
> >> +static int event_open(int type, unsigned long config, int g_fd)
> >> +{
> >> +       struct perf_event_attr attr;
> >> +
> >> +       memset(&attr, 0, sizeof(struct perf_event_attr));
> >> +       attr.type =3D type;
> >> +       attr.size =3D sizeof(struct perf_event_attr);
> >> +       attr.config =3D config;
> >
> > Could you add a comment for the line below?
>
> Although this test exercises perf_event_open() and never enables any even=
t,
> I'm following standard practices. Snippet from man perf_event_open:
>
>    disabled
>        The disabled bit specifies whether the counter starts  out  dis=E2=
=80=90
>        abled  or  enabled.  If disabled, the event can later be enabled
>        by ioctl(2), prctl(2), or enable_on_exec.
>
>        When creating an event group, typically the group leader is ini=E2=
=80=90
>        tialized  with  disabled  set to 1 and any child events are ini=E2=
=80=90
>        tialized with disabled set to 0.  Despite disabled being 0,  the
>        child events will not start until the group leader is enabled.
>
> So it's well documented. I can probably put the same as comment.
>
> >
> >> +       attr.disabled =3D g_fd =3D=3D -1 ? 1 : 0;
> >> +
> >> +       return sys_perf_event_open(&attr, -1, 0, g_fd, 0);
> >> +}
> >> +
> >> +/* hw: cycles, sw: context-switch, uncore: [arch dependent] */
> >
> > static?
>
> +1
>
> >
> >> +int type[] =3D {0, 1, -1};
> >> +unsigned long config[] =3D {0, 3, -1};
> >> +
> >> +static int setup_uncore_event(void)
> >> +{
> >> +       char pmu_name[25] =3D {0};
> >> +       struct perf_pmu *pmu;
> >> +
> >
> > I think the below finding of an uncore PMU is clunky.
>
> Agree.
>
> > On my tigerlake
> > Intel laptop, for example, I don't have an uncore_imc_0 but do have
> > uncore_imc_free_running_0. I think the real fix here is that we should
> > start a new "pmus.h" and "pmus.c", moving the pmus static variable
> > from pmu.c to pmus.c. In pmus.h we should have an every PMU iterator,
> > like we do with perf_pmu__for_each_hybrid_pmu.
>
> I see only one variable that can be moved from pmu.c to pmus.c:
>   LIST_HEAD(pmus)
> So introducing new file pmus.c with just one list variable and a macro to
> iterate over it seems overkill. Or are you suggesting to also migrate all
> pmu.c functions which iterates over pmus list?
>
> > I'd like to go further
> > with a pmus.h, as the computation of the perf_pmu struct should be
> > done a lot more lazily than it is now. But for now you can just
> > iterate the pmus looking for one saying beginning with "uncore_" as a
> > name.
>
> Ok. I can probably introduce perf_pmu__starts_with(const char *name).

uncore_ works for Intel, but... I agree having pmus.c for 1 variable
is overkill. I'd put an iterator in pmus.h like:

#define perf_pmu__for_each_pmu(pmu) list_for_each_entry(pmu, &pmus, list)

and also not have pmus be static in pmu.c. That way in the test you
can iterate the pmus and find the uncore ones.

> >> +static int run_test(int i, int j, int k)
> >> +{
> >> +       int erroneous =3D ((((1 << i) | (1 << j) | (1 << k)) & 5) =3D=
=3D 5);
> >> +       int fd1, fd2, fd3;
> >> +
> >> +       fd1 =3D event_open(type[i], config[i], -1);
> >
> > nit: a name like "event_group_leader_fd" would be more intention
> > revealing than fd1.
>
> hmm, but that's too long :). Are you ok with:
>   s/fd1/group_fd/
>   s/fd2/sibling_fd1/
>   s/fd3/sibling_fd2/
>
> Thanks,
> Ravi

I'm fine with the other changes. I've done too much Java to be
allergic to long variable names ;-)

Thanks,
Ian
