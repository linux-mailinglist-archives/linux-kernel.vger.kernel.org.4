Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832196F0D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344204AbjD0U1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344199AbjD0U1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:27:11 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4AE420C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:27:07 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f0a2f8216fso824701cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682627227; x=1685219227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cx4w/2InDUGZSGXbCAtICIAEMjmXFNs7RTXhfnzotg8=;
        b=xVjQzGIM8s3Rff/povgay08rIJzVcOrP926yLE+hzsBlXr/7d0NnXEgYJ0ffK8Zgt9
         AlDBJ8LfmS4f4YH1PPVaXRYD6GhWdfIiBFAnBLR4ZWPW3ul6DUtR///A6gsHkAyF5jdX
         bzWpvr7LGCVKpHFetBUnh56CIexTMeUU/yULUnzr7lo6BHIVmKVMBmNECdxw9CnpLFmc
         y3T+Qt4zPisE3xR/44rhgYbgecprD8WQzM7+8Gi+4dTkV0isj3/5XKHyygytinxkP+rY
         Ess4IV9waTVa1rNqpGtM8K/5pSXaOmjFS0fbWYGIubZBauEDFXYcHL12UKXf8kUS0mZU
         qiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682627227; x=1685219227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cx4w/2InDUGZSGXbCAtICIAEMjmXFNs7RTXhfnzotg8=;
        b=LIa8D3VKBbpREaJK852brg4xaGJx+ca8NBrhGmvpax8R+0YE4/Z5/MbIJgY9Melk93
         jL7acSt6076XjqNPSq8IUujvFaMWlWfP38wtTUK6MvuqqT5+yxj8rk0WLeIlDW5B85Jv
         C2xlc8vN8Vfhyjf0t+ZFniGQ3QqaQz4IL8Qz9qEYALGtjlAVXBJftD/fGLgTGgT751X5
         mBxc61pAJkHpdyuW0bsWO7M8aEocePLU1YHs1ad3f0KOvTxgv92YHm3CBzpo2ozXmh6J
         XAWfeJ2hd9h8HNRml37Go2tMUH5yviftkDSMDAJEUaADb29zlS/EMHKPAcvCDyGx0zer
         nvDw==
X-Gm-Message-State: AC+VfDzpchfjpvlSVScd0E70sqkxgZt1AJjf71KGAsCpDrr8Xqzp3epA
        l2B7FwmPIO0HhNvJN9xE2HUCCQCytHtpdS+/VtOa+Q==
X-Google-Smtp-Source: ACHHUZ4Njvuv7eViIuHeNciK/fYo0i6wcg+XNlBFmxl89PwP4bkRg0uNaAT122dKxb3yOSXSCFJYBYhaBGncSmiE9C8=
X-Received: by 2002:a05:622a:c4:b0:3ed:9b0a:49b4 with SMTP id
 p4-20020a05622a00c400b003ed9b0a49b4mr83788qtw.12.1682627226581; Thu, 27 Apr
 2023 13:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230427122656.42473-1-adrian.hunter@intel.com>
 <20230427122656.42473-2-adrian.hunter@intel.com> <CAP-5=fU0Sicx0AUWh8nc4g6_eDpr+0w6PmVJ191o6405POhcCg@mail.gmail.com>
 <f743969e-7dda-5686-59f8-844016ebe31e@intel.com>
In-Reply-To: <f743969e-7dda-5686-59f8-844016ebe31e@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 Apr 2023 13:26:55 -0700
Message-ID: <CAP-5=fXOH5V5f4VPaMKNWUpUZkSWMkWbZD9Gp-rSsuxgk7gHfw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tools: Allow config terms with breakpoints
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 9:13=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 27/04/23 18:26, Ian Rogers wrote:
> > On Thu, Apr 27, 2023 at 5:27=E2=80=AFAM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> >>
> >> Add config terms to the parsing of breakpoint events. Extend "Test eve=
nt
> >> parsing" to also cover using a confg term.
> >>
> >> This makes breakpoint events consistent with other events which alread=
y
> >> support config terms.
> >>
> >> Example:
> >>
> >>   $ cat dr_test.c
> >>   #include <unistd.h>
> >>   #include <stdio.h>
> >>
> >>   void func0(void)
> >>   {
> >>   }
> >>
> >>   int main()
> >>   {
> >>           printf("func0 %p\n", &func0);
> >>           while (1) {
> >>                   func0();
> >>                   usleep(100000);
> >>           }
> >>           return 0;
> >>   }
> >>   $ gcc -g -O0 -o dr_test dr_test.c
> >>   $ ./dr_test &
> >>   [2] 19646
> >>   func0 0x55feb98dd169
> >>   $ perf record -e mem:0x55feb98dd169:x/name=3Dbreakpoint/ -p 19646 --=
 sleep 0.5
> >>   [ perf record: Woken up 1 times to write data ]
> >>   [ perf record: Captured and wrote 0.017 MB perf.data (5 samples) ]
> >>   $ perf script
> >>       dr_test 19646  5632.956628:          1 breakpoint:      55feb98d=
d169 func0+0x0 (/home/ahunter/git/work/dr_test)
> >>       dr_test 19646  5633.056866:          1 breakpoint:      55feb98d=
d169 func0+0x0 (/home/ahunter/git/work/dr_test)
> >>       dr_test 19646  5633.157084:          1 breakpoint:      55feb98d=
d169 func0+0x0 (/home/ahunter/git/work/dr_test)
> >>       dr_test 19646  5633.257309:          1 breakpoint:      55feb98d=
d169 func0+0x0 (/home/ahunter/git/work/dr_test)
> >>       dr_test 19646  5633.357532:          1 breakpoint:      55feb98d=
d169 func0+0x0 (/home/ahunter/git/work/dr_test)
> >>   $ sudo perf test "Test event parsing"
> >>     6: Parse event definition strings                                 =
 :
> >>     6.1: Test event parsing                                           =
 : Ok
> >>   $ sudo perf test -v "Test event parsing" |& grep mem
> >>   running test 8 'mem:0'
> >>   running test 9 'mem:0:x'
> >>   running test 10 'mem:0:r'
> >>   running test 11 'mem:0:w'
> >>   running test 19 'mem:0:u'
> >>   running test 20 'mem:0:x:k'
> >>   running test 21 'mem:0:r:hp'
> >>   running test 22 'mem:0:w:up'
> >>   running test 26 'mem:0:rw'
> >>   running test 27 'mem:0:rw:kp'
> >>   running test 42 'mem:0/1'
> >>   running test 43 'mem:0/2:w'
> >>   running test 44 'mem:0/4:rw:u'
> >>   running test 58 'mem:0/name=3Dbreakpoint/'
> >>   running test 59 'mem:0:x/name=3Dbreakpoint/'
> >>   running test 60 'mem:0:r/name=3Dbreakpoint/'
> >>   running test 61 'mem:0:w/name=3Dbreakpoint/'
> >>   running test 62 'mem:0/name=3Dbreakpoint/u'
> >>   running test 63 'mem:0:x/name=3Dbreakpoint/k'
> >>   running test 64 'mem:0:r/name=3Dbreakpoint/hp'
> >>   running test 65 'mem:0:w/name=3Dbreakpoint/up'
> >>   running test 66 'mem:0:rw/name=3Dbreakpoint/'
> >>   running test 67 'mem:0:rw/name=3Dbreakpoint/kp'
> >>   running test 68 'mem:0/1/name=3Dbreakpoint/'
> >>   running test 69 'mem:0/2:w/name=3Dbreakpoint/'
> >>   running test 70 'mem:0/4:rw/name=3Dbreakpoint/u'
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  tools/perf/tests/parse-events.c | 135 +++++++++++++++++++++++++++++++=
+
> >>  tools/perf/util/parse-events.c  |  23 +++++-
> >>  tools/perf/util/parse-events.h  |   6 +-
> >>  tools/perf/util/parse-events.l  |   7 +-
> >>  tools/perf/util/parse-events.y  |  42 +++++-----
> >>  5 files changed, 187 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-=
events.c
> >> index 8068cfd89b84..f424ad77da60 100644
> >> --- a/tools/perf/tests/parse-events.c
> >> +++ b/tools/perf/tests/parse-events.c
> >> @@ -439,6 +439,76 @@ static int test__checkevent_breakpoint_rw_modifie=
r(struct evlist *evlist)
> >>         return test__checkevent_breakpoint_rw(evlist);
> >>  }
> >>
> >> +static int test__checkevent_breakpoint_modifier_name(struct evlist *e=
vlist)
> >> +{
> >> +       struct evsel *evsel =3D evlist__first(evlist);
> >> +
> >> +       TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclud=
e_user);
> >> +       TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclu=
de_kernel);
> >> +       TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_h=
v);
> >> +       TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_=
ip);
> >> +       TEST_ASSERT_VAL("wrong name",
> >> +                       !strcmp(evsel__name(evsel), "breakpoint"));
> >> +
> >> +       return test__checkevent_breakpoint(evlist);
> >> +}
> >> +
> >> +static int test__checkevent_breakpoint_x_modifier_name(struct evlist =
*evlist)
> >> +{
> >> +       struct evsel *evsel =3D evlist__first(evlist);
> >> +
> >> +       TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude=
_user);
> >> +       TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.excl=
ude_kernel);
> >> +       TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_h=
v);
> >> +       TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_=
ip);
> >> +       TEST_ASSERT_VAL("wrong name",
> >> +                       !strcmp(evsel__name(evsel), "breakpoint"));
> >> +
> >> +       return test__checkevent_breakpoint_x(evlist);
> >> +}
> >> +
> >> +static int test__checkevent_breakpoint_r_modifier_name(struct evlist =
*evlist)
> >> +{
> >> +       struct evsel *evsel =3D evlist__first(evlist);
> >> +
> >> +       TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude=
_user);
> >> +       TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclu=
de_kernel);
> >> +       TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_=
hv);
> >> +       TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_i=
p);
> >> +       TEST_ASSERT_VAL("wrong name",
> >> +                       !strcmp(evsel__name(evsel), "breakpoint"));
> >> +
> >> +       return test__checkevent_breakpoint_r(evlist);
> >> +}
> >> +
> >> +static int test__checkevent_breakpoint_w_modifier_name(struct evlist =
*evlist)
> >> +{
> >> +       struct evsel *evsel =3D evlist__first(evlist);
> >> +
> >> +       TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclud=
e_user);
> >> +       TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclu=
de_kernel);
> >> +       TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_h=
v);
> >> +       TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_i=
p);
> >> +       TEST_ASSERT_VAL("wrong name",
> >> +                       !strcmp(evsel__name(evsel), "breakpoint"));
> >> +
> >> +       return test__checkevent_breakpoint_w(evlist);
> >> +}
> >> +
> >> +static int test__checkevent_breakpoint_rw_modifier_name(struct evlist=
 *evlist)
> >> +{
> >> +       struct evsel *evsel =3D evlist__first(evlist);
> >> +
> >> +       TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude=
_user);
> >> +       TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.excl=
ude_kernel);
> >> +       TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_h=
v);
> >> +       TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_i=
p);
> >> +       TEST_ASSERT_VAL("wrong name",
> >> +                       !strcmp(evsel__name(evsel), "breakpoint"));
> >> +
> >> +       return test__checkevent_breakpoint_rw(evlist);
> >> +}
> >> +
> >>  static int test__checkevent_pmu(struct evlist *evlist)
> >>  {
> >>
> >> @@ -1973,6 +2043,71 @@ static const struct evlist_test test__events[] =
=3D {
> >>                 .check =3D test__exclusive_group,
> >>                 /* 7 */
> >>         },
> >> +       {
> >> +               .name  =3D "mem:0/name=3Dbreakpoint/",
> >> +               .check =3D test__checkevent_breakpoint,
> >> +               /* 8 */
> >> +       },
> >> +       {
> >> +               .name  =3D "mem:0:x/name=3Dbreakpoint/",
> >> +               .check =3D test__checkevent_breakpoint_x,
> >> +               /* 9 */
> >> +       },
> >> +       {
> >> +               .name  =3D "mem:0:r/name=3Dbreakpoint/",
> >> +               .check =3D test__checkevent_breakpoint_r,
> >> +               /* 0 */
> >> +       },
> >> +       {
> >> +               .name  =3D "mem:0:w/name=3Dbreakpoint/",
> >> +               .check =3D test__checkevent_breakpoint_w,
> >> +               /* 1 */
> >> +       },
> >> +       {
> >> +               .name  =3D "mem:0/name=3Dbreakpoint/u",
> >> +               .check =3D test__checkevent_breakpoint_modifier_name,
> >> +               /* 2 */
> >> +       },
> >> +       {
> >> +               .name  =3D "mem:0:x/name=3Dbreakpoint/k",
> >> +               .check =3D test__checkevent_breakpoint_x_modifier_name=
,
> >> +               /* 3 */
> >> +       },
> >> +       {
> >> +               .name  =3D "mem:0:r/name=3Dbreakpoint/hp",
> >> +               .check =3D test__checkevent_breakpoint_r_modifier_name=
,
> >> +               /* 4 */
> >> +       },
> >> +       {
> >> +               .name  =3D "mem:0:w/name=3Dbreakpoint/up",
> >> +               .check =3D test__checkevent_breakpoint_w_modifier_name=
,
> >> +               /* 5 */
> >> +       },
> >> +       {
> >> +               .name  =3D "mem:0:rw/name=3Dbreakpoint/",
> >> +               .check =3D test__checkevent_breakpoint_rw,
> >> +               /* 6 */
> >> +       },
> >> +       {
> >> +               .name  =3D "mem:0:rw/name=3Dbreakpoint/kp",
> >> +               .check =3D test__checkevent_breakpoint_rw_modifier_nam=
e,
> >> +               /* 7 */
> >> +       },
> >> +       {
> >> +               .name  =3D "mem:0/1/name=3Dbreakpoint/",
> >> +               .check =3D test__checkevent_breakpoint_len,
> >> +               /* 8 */
> >> +       },
> >> +       {
> >> +               .name  =3D "mem:0/2:w/name=3Dbreakpoint/",
> >> +               .check =3D test__checkevent_breakpoint_len_w,
> >> +               /* 9 */
> >> +       },
> >> +       {
> >> +               .name  =3D "mem:0/4:rw/name=3Dbreakpoint/u",
> >> +               .check =3D test__checkevent_breakpoint_len_rw_modifier=
,
> >> +               /* 0 */
> >> +       },
> >>  };
> >>
> >>  static const struct evlist_test test__events_pmu[] =3D {
> >> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-ev=
ents.c
> >> index d71019dcd614..4f4901753f25 100644
> >> --- a/tools/perf/util/parse-events.c
> >> +++ b/tools/perf/util/parse-events.c
> >> @@ -896,10 +896,14 @@ do {                                      \
> >>         return 0;
> >>  }
> >>
> >> -int parse_events_add_breakpoint(struct list_head *list, int *idx,
> >> -                               u64 addr, char *type, u64 len)
> >> +int parse_events_add_breakpoint(struct parse_events_state *parse_stat=
e,
> >> +                               struct list_head *list,
> >> +                               u64 addr, char *type, u64 len,
> >> +                               struct list_head *head_config __maybe_=
unused)
> >>  {
> >>         struct perf_event_attr attr;
> >> +       LIST_HEAD(config_terms);
> >> +       const char *name;
> >>
> >>         memset(&attr, 0, sizeof(attr));
> >>         attr.bp_addr =3D addr;
> >> @@ -920,8 +924,19 @@ int parse_events_add_breakpoint(struct list_head =
*list, int *idx,
> >>         attr.type =3D PERF_TYPE_BREAKPOINT;
> >>         attr.sample_period =3D 1;
> >>
> >> -       return add_event(list, idx, &attr, /*name=3D*/NULL, /*mertic_i=
d=3D*/NULL,
> >> -                        /*config_terms=3D*/NULL);
> >> +       if (head_config) {
> >> +               if (config_attr(&attr, head_config, parse_state->error=
,
> >> +                               config_term_common))
> >> +                       return -EINVAL;
> >> +
> >> +               if (get_config_terms(head_config, &config_terms))
> >> +                       return -ENOMEM;
> >> +       }
> >> +
> >> +       name =3D get_config_name(head_config);
> >> +
> >> +       return add_event(list, &parse_state->idx, &attr, name, /*merti=
c_id=3D*/NULL,
> >> +                        &config_terms);
> >>  }
> >>
> >>  static int check_type_val(struct parse_events_term *term,
> >> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-ev=
ents.h
> >> index 86ad4438a2aa..6cb2076f1577 100644
> >> --- a/tools/perf/util/parse-events.h
> >> +++ b/tools/perf/util/parse-events.h
> >> @@ -179,8 +179,10 @@ int parse_events_add_cache(struct list_head *list=
, int *idx,
> >>                            struct parse_events_error *error,
> >>                            struct list_head *head_config,
> >>                            struct parse_events_state *parse_state);
> >> -int parse_events_add_breakpoint(struct list_head *list, int *idx,
> >> -                               u64 addr, char *type, u64 len);
> >> +int parse_events_add_breakpoint(struct parse_events_state *parse_stat=
e,
> >> +                               struct list_head *list,
> >> +                               u64 addr, char *type, u64 len,
> >> +                               struct list_head *head_config);
> >>  int parse_events_add_pmu(struct parse_events_state *parse_state,
> >>                          struct list_head *list, char *name,
> >>                          struct list_head *head_config,
> >> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-ev=
ents.l
> >> index 51fe0a9fb3de..0d05594e7890 100644
> >> --- a/tools/perf/util/parse-events.l
> >> +++ b/tools/perf/util/parse-events.l
> >> @@ -218,6 +218,8 @@ drv_cfg_term        [a-zA-Z0-9_\.]+(=3D[a-zA-Z0-9_=
*?\.:]+)?
> >>  /* If you add a modifier you need to update check_modifier() */
> >>  modifier_event [ukhpPGHSDIWeb]+
> >>  modifier_bp    [rwx]{1,3}
> >> +digit          [0-9]
> >> +non_digit      [^0-9]
> >>
> >>  %%
> >>
> >> @@ -315,8 +317,9 @@ r0x{num_raw_hex}    { return raw(yyscanner); }
> >>
> >>  <mem>{
> >>  {modifier_bp}          { return str(yyscanner, PE_MODIFIER_BP); }
> >> -:                      { return ':'; }
> >> -"/"                    { return '/'; }
> >> +":"/{modifier_bp}      { return str(yyscanner, PE_BP_COLON); }
> >> +"/"/{digit}            { return str(yyscanner, PE_BP_SLASH); }
> >> +"/"/{non_digit}                { BEGIN(config); return '/'; }
> >
> > Hi Adrian, at this point the lexer is going to match "/" and the
> > non-digits, consuming the non-digits. So if you have input after the /
> > then won't you have a parsing issue?
>
> Thanks for looking at this.  The trailing context should not be
> consumed.  From the flex manual:
>
> =E2=80=98r/s=E2=80=99
>     an =E2=80=98r=E2=80=99 but only if it is followed by an =E2=80=98s=E2=
=80=99. The text matched by =E2=80=98s=E2=80=99 is included when determinin=
g whether this rule is the longest match, but is then returned to the input=
 before the action is executed. So the action only sees the text matched by=
 =E2=80=98r=E2=80=99. This type of pattern is called trailing context. (The=
re are some combinations of =E2=80=98r/s=E2=80=99 that flex cannot match co=
rrectly. See Limitations, regarding dangerous trailing context.)
>
> >                                      Tweaking your example this could
> > be:
> >
> > $ perf record -e
> > mem:0x55feb98dd169:x/name=3Dbreakpoint/,mem:0x55feb98dd169:x/name=3Dbre=
akpoint/
> > -p 19646 -- sleep 0.5
>
> I tried that and it seems to work ok.  Presumably the "/" of "/,"
> gets scanned as part of <config> instead of <mem>

Cool, I wasn't aware of the behavior of / - other things are pretty
obvious in lex because they match regular expressions. A comment and a
test for the event following case would be nice.

Thanks,
Ian

> >
> > This will match "/,mem:" and return the token '/' which will then
> > cause an issue as the second 0x55feb98dd169 will then need to be
> > unput.. actually non_digit doesn't have a plus or star, so you'll
> > match the comma which I think still causes issues.
> >
> > Hope this helps,
> > Ian
> >
> >>  {num_dec}              { return value(yyscanner, 10); }
> >>  {num_hex}              { return value(yyscanner, 16); }
> >>         /*
> >> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-ev=
ents.y
> >> index 4488443e506e..cfdb99537d07 100644
> >> --- a/tools/perf/util/parse-events.y
> >> +++ b/tools/perf/util/parse-events.y
> >> @@ -57,7 +57,7 @@ static void free_list_evsel(struct list_head* list_e=
vsel)
> >>  %token PE_EVENT_NAME
> >>  %token PE_NAME
> >>  %token PE_BPF_OBJECT PE_BPF_SOURCE
> >> -%token PE_MODIFIER_EVENT PE_MODIFIER_BP
> >> +%token PE_MODIFIER_EVENT PE_MODIFIER_BP PE_BP_COLON PE_BP_SLASH
> >>  %token PE_NAME_CACHE_TYPE PE_NAME_CACHE_OP_RESULT
> >>  %token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
> >>  %token PE_ERROR
> >> @@ -78,6 +78,8 @@ static void free_list_evsel(struct list_head* list_e=
vsel)
> >>  %type <str> PE_NAME_CACHE_OP_RESULT
> >>  %type <str> PE_MODIFIER_EVENT
> >>  %type <str> PE_MODIFIER_BP
> >> +%type <str> PE_BP_COLON
> >> +%type <str> PE_BP_SLASH
> >>  %type <str> PE_EVENT_NAME
> >>  %type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_PMU_EVENT_SUF2 PE_KE=
RNEL_PMU_EVENT PE_PMU_EVENT_FAKE
> >>  %type <str> PE_DRV_CFG_TERM
> >> @@ -267,7 +269,7 @@ event_def
> >>  event_def: event_pmu |
> >>            event_legacy_symbol |
> >>            event_legacy_cache sep_dc |
> >> -          event_legacy_mem |
> >> +          event_legacy_mem sep_dc |
> >>            event_legacy_tracepoint sep_dc |
> >>            event_legacy_numeric sep_dc |
> >>            event_legacy_raw sep_dc |
> >> @@ -540,16 +542,16 @@ PE_NAME_CACHE_TYPE opt_event_config
> >>  }
> >>
> >>  event_legacy_mem:
> >> -PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIFIER_BP sep_dc
> >> +PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_B=
P opt_event_config
> >>  {
> >> -       struct parse_events_state *parse_state =3D _parse_state;
> >>         struct list_head *list;
> >>         int err;
> >>
> >>         list =3D alloc_list();
> >>         ABORT_ON(!list);
> >> -       err =3D parse_events_add_breakpoint(list, &parse_state->idx,
> >> -                                         $2, $6, $4);
> >> +       err =3D parse_events_add_breakpoint(_parse_state, list,
> >> +                                         $2, $6, $4, $7);
> >> +       parse_events_terms__delete($7);
> >>         free($6);
> >>         if (err) {
> >>                 free(list);
> >> @@ -558,31 +560,33 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIF=
IER_BP sep_dc
> >>         $$ =3D list;
> >>  }
> >>  |
> >> -PE_PREFIX_MEM PE_VALUE '/' PE_VALUE sep_dc
> >> +PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
> >>  {
> >> -       struct parse_events_state *parse_state =3D _parse_state;
> >>         struct list_head *list;
> >> +       int err;
> >>
> >>         list =3D alloc_list();
> >>         ABORT_ON(!list);
> >> -       if (parse_events_add_breakpoint(list, &parse_state->idx,
> >> -                                       $2, NULL, $4)) {
> >> +       err =3D parse_events_add_breakpoint(_parse_state, list,
> >> +                                         $2, NULL, $4, $5);
> >> +       parse_events_terms__delete($5);
> >> +       if (err) {
> >>                 free(list);
> >>                 YYABORT;
> >>         }
> >>         $$ =3D list;
> >>  }
> >>  |
> >> -PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
> >> +PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
> >>  {
> >> -       struct parse_events_state *parse_state =3D _parse_state;
> >>         struct list_head *list;
> >>         int err;
> >>
> >>         list =3D alloc_list();
> >>         ABORT_ON(!list);
> >> -       err =3D parse_events_add_breakpoint(list, &parse_state->idx,
> >> -                                         $2, $4, 0);
> >> +       err =3D parse_events_add_breakpoint(_parse_state, list,
> >> +                                         $2, $4, 0, $5);
> >> +       parse_events_terms__delete($5);
> >>         free($4);
> >>         if (err) {
> >>                 free(list);
> >> @@ -591,15 +595,17 @@ PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
> >>         $$ =3D list;
> >>  }
> >>  |
> >> -PE_PREFIX_MEM PE_VALUE sep_dc
> >> +PE_PREFIX_MEM PE_VALUE opt_event_config
> >>  {
> >> -       struct parse_events_state *parse_state =3D _parse_state;
> >>         struct list_head *list;
> >> +       int err;
> >>
> >>         list =3D alloc_list();
> >>         ABORT_ON(!list);
> >> -       if (parse_events_add_breakpoint(list, &parse_state->idx,
> >> -                                       $2, NULL, 0)) {
> >> +       err =3D parse_events_add_breakpoint(_parse_state, list,
> >> +                                         $2, NULL, 0, $3);
> >> +       parse_events_terms__delete($3);
> >> +       if (err) {
> >>                 free(list);
> >>                 YYABORT;
> >>         }
> >> --
> >> 2.34.1
> >>
>
