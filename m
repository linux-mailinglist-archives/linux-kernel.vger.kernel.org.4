Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7496C1294
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCTNEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjCTNEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:04:37 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4883811E98
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:04:36 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3d7aef37dccso633471cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679317475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9cgh0VEcg4Ab0IygUpsCRuesVwyee3u24QztcxL14I=;
        b=Nc6G4xqDNWkG2PTFqaKrWGWYrLQP+YH7BuWB5YrvHaLmErRfwT8/S6RSDCYL3FUkv0
         0I/KuV47Urs1vc6w29DMawt2F67/v/mkzpJ+gatCXW7u23lW+qbqIPhmootT++EDYxG/
         AUd+yJZc23Y6Nvwa2UdoN0M/yrXSPRHKoJF+jgGL+3lOhddfN3mXd2lB52kelcaU2UBe
         Qx0Do7z9LJvBJ0YNpMYu86579R+87V+uDeTXWO7dTyQ76Z6svaoKY62KZNcHuyenifm9
         ZU9bnsMtLl3PpnGnBDPqfMWPMa+/sWyXm6KoAUJHyd4fe75VUbwIJXiNBjP0Twg622zR
         xzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679317475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9cgh0VEcg4Ab0IygUpsCRuesVwyee3u24QztcxL14I=;
        b=YEIXcL3t5PcuWkvX4IgsUVx1X+2+JEpgsWxMIWGk20KlitokT8qOdexCvC3s/wOd64
         QfhNXyJouEjy6cOROyO2B07Q09/JTbvJiT1VtP0twcenHn/HgiN13BerpkLB5vo6Powb
         PgMN7Cjr1Ib5tm54+FIrPEenJGpw8Ke3eMLx7XsJ4yhb3sAZ7JzpQNdBRW6/bpNaBvGD
         nOUiHvXuLNW5k3JsSYH1ufaUSbxBp59pgfXxFgJVQmu/yM6n+WMQTVgeIT2215RPi9Pa
         /DdCZniV22jtBJNjKpCwwnAbfu/5GGYc3/tpbF5MnVvFMxXQum0avYXZIkUW84nSioil
         RZgA==
X-Gm-Message-State: AO0yUKU8pqI+FqQPcOn3Y/au4iZeAB0F32XeB/xRrbUTfpzgmQJScHak
        CXMQ6FbM03f6N9SiJTpZ+bfzVHT3PnWJoh6bCmJ4Dg==
X-Google-Smtp-Source: AK7set9v7LwyY8AYAan4qcskKzkdPBDmteOvnD+a63nO0bK5MxgjR6Oe0G96F7Wmx5sP7Hn9IaFWvxtyBviEqZumc68=
X-Received: by 2002:a05:622a:1892:b0:3bd:ad8:e978 with SMTP id
 v18-20020a05622a189200b003bd0ad8e978mr619001qtc.6.1679317475199; Mon, 20 Mar
 2023 06:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com> <20230320033810.980165-5-irogers@google.com>
 <58d0eb4c-5c58-5ff3-ee26-130247244df7@intel.com>
In-Reply-To: <58d0eb4c-5c58-5ff3-ee26-130247244df7@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Mar 2023 06:04:23 -0700
Message-ID: <CAP-5=fWLakCnLsXbRcD9Zw-Afq=C3Dt-60RfvF5TbKkf=oYLBQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/22] perf test: Fix memory leak in symbols
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>,
        Stephane Eranian <eranian@google.com>
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

On Mon, Mar 20, 2023 at 1:06=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 20/03/23 05:37, Ian Rogers wrote:
> > machine__delete doesn't delete threads.
>
> Which begs the question: Shouldn't it?

Agreed. The patch set was already large enough so I think this can be
followed up separately.

Thanks,
Ian

> >                                         Add call to delete threads
> > ahead of deleting the machine.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/symbols.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
> > index 057b16df6416..0793f8f419e2 100644
> > --- a/tools/perf/tests/symbols.c
> > +++ b/tools/perf/tests/symbols.c
> > @@ -38,6 +38,7 @@ static int init_test_info(struct test_info *ti)
> >  static void exit_test_info(struct test_info *ti)
> >  {
> >       thread__put(ti->thread);
> > +     machine__delete_threads(ti->machine);
> >       machine__delete(ti->machine);
> >  }
> >
>
