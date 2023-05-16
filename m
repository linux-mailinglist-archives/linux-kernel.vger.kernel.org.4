Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D346D70512E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjEPOqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjEPOqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:46:15 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF2A3AB3;
        Tue, 16 May 2023 07:46:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f41d087b3bso111431855e9.0;
        Tue, 16 May 2023 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684248365; x=1686840365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mxec1tP1LgcbhvQ2IbjcTPo5YvuUG6DlMwZkkhZztmI=;
        b=MYd32HYvYPtK/Z69UQhYDSwbJLECfWDMwNYQiXSDOXY9Igumbca2qgcveMtE37+Mjw
         dlR3+dgkbheO4/j2unRJnIixuB2WiKEU/rY464q78DcS0+M7e0lo5NXEEjvXTTU06Il+
         F3eRXnW83ka4IHslCSUIKNUBzRhIrXcFS4YO1sDJpQqyaZ1Zj86VMqaIXEZoJYAJeMo2
         WFTDo9OBpLnLs3MDudK002rS2I0eCOdY/vKms7dGO4+vK72iRji6LN1FGE9G4H8BU0Uw
         5LRaEzGXLtpixb6s1PPb4qzttgeuiYYfEGKmb4wM+Im0jhkMa79WCmU7TodmxeckW7Wv
         v7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684248365; x=1686840365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mxec1tP1LgcbhvQ2IbjcTPo5YvuUG6DlMwZkkhZztmI=;
        b=OiFEsgpskjr5LsbVafq1gc1ZnNGdggMpeSPg1+Uw28vxN2hQoBqbI0HtnXSDCltv7x
         6I7VE/j0v4Y1DFcq6VrAhvA/dyD2dMs27EDjFuE0iGDien0d+X+QwfqFxiyWMnw3mKp4
         FqI/tpBGGbgUfmG63iD1IvBVM5HzHbr1mkN6Pzi3y23/bvoTHQtJV3dJuAcDhVsxVceS
         RqX8iB7bHRR49ZWhkFs0ieTzMSQQfCagLriiEZHpxNavdnj0oh8ayhO/XA189HxwSbAv
         pUFqplFu+U0zbOg+sVED/sZgDx48O49ibXZqEIBSxydNj3RmnPoQBx/rXf5pIT+TqVtP
         ZKLg==
X-Gm-Message-State: AC+VfDyTsk3YNqqnRInJGC5M45E1UyMBXS2Aa+FRQRbtvIbnlKurYDhh
        +YsO37DeNoDqi60l36cspdYV36tm3V7SaKvDYxk=
X-Google-Smtp-Source: ACHHUZ6xl8e/6S2Q49cV40BDZecVjlgfqJCACkPyBvcslCqdcZr8bECiSlaQgONvA8ntAgoK94S8Fg3/UCY3y+wtGaA=
X-Received: by 2002:a7b:cc05:0:b0:3f1:7581:eaaf with SMTP id
 f5-20020a7bcc05000000b003f17581eaafmr26455677wmh.4.1684248364746; Tue, 16 May
 2023 07:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230516043943.5234-1-azeemshaikh38@gmail.com> <20230516101727.7f19aae9@gandalf.local.home>
In-Reply-To: <20230516101727.7f19aae9@gandalf.local.home>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Tue, 16 May 2023 10:45:53 -0400
Message-ID: <CADmuW3V6pPDTZPKQ8PiUZKi+ttem05SpL3wk=+gmXnXyPsN69A@mail.gmail.com>
Subject: Re: [PATCH] tracing: Replace all non-returning strlcpy with strscpy
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        David Ahern <dsahern@kernel.org>,
        Mark Bloch <mbloch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.

>
> >  kernel/trace/trace.c               |    8 ++++----
> >  kernel/trace/trace_events.c        |    4 ++--
> >  kernel/trace/trace_events_inject.c |    4 ++--
> >  kernel/trace/trace_kprobe.c        |    2 +-
> >  kernel/trace/trace_probe.c         |    2 +-
> >  10 files changed, 39 insertions(+), 43 deletions(-)
> >
> > diff --git a/include/trace/events/fib.h b/include/trace/events/fib.h
> > index 76297ecd4935..20b914250ce9 100644
> > --- a/include/trace/events/fib.h
> > +++ b/include/trace/events/fib.h
> > @@ -65,7 +65,7 @@ TRACE_EVENT(fib_table_lookup,
> >               }
> >
> >               dev = nhc ? nhc->nhc_dev : NULL;
> > -             strlcpy(__entry->name, dev ? dev->name : "-", IFNAMSIZ);
> > +             strscpy(__entry->name, dev ? dev->name : "-", IFNAMSIZ);
> >
> >               if (nhc) {
> >                       if (nhc->nhc_gw_family == AF_INET) {
> > diff --git a/include/trace/events/fib6.h b/include/trace/events/fib6.h
> > index 4d3e607b3cde..5d7ee2610728 100644
> > --- a/include/trace/events/fib6.h
> > +++ b/include/trace/events/fib6.h
> > @@ -63,7 +63,7 @@ TRACE_EVENT(fib6_table_lookup,
> >               }
> >
> >               if (res->nh && res->nh->fib_nh_dev) {
> > -                     strlcpy(__entry->name, res->nh->fib_nh_dev->name, IFNAMSIZ);
> > +                     strscpy(__entry->name, res->nh->fib_nh_dev->name, IFNAMSIZ);
> >               } else {
> >                       strcpy(__entry->name, "-");
> >               }
> > diff --git a/include/trace/events/kyber.h b/include/trace/events/kyber.h
> > index bf7533f171ff..d4db2fa60e7b 100644
> > --- a/include/trace/events/kyber.h
> > +++ b/include/trace/events/kyber.h
> > @@ -21,8 +21,8 @@ TRACE_EVENT(kyber_latency,
> >
> >       TP_STRUCT__entry(
> >               __field(        dev_t,  dev                             )
> > -             __array(        char,   domain, DOMAIN_LEN              )
> > -             __array(        char,   type,   LATENCY_TYPE_LEN        )
> > +             __string(       domain, domain                          )
> > +             __string(       type,   type                            )
>
> Note, __string() adds a little bit more overhead. If the length is small
> enough (like 16 or 8, as the above are) then it is more efficient in both
> speed and size of the ring buffer to use the hard coded array, and not use
> the dynamic string.
>
> NACK on the above change.
>

Yeah I realized a little too late that these changes will have
performance overhead. Will remove.

>
> The below changes can be sent as its own patch, and I can take it.
>
> -- Steve

Thanks. Sent out a v2 for the below.


>
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index ebc59781456a..28ccd0c9bdf0 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -196,7 +196,7 @@ static int boot_snapshot_index;
> >
> >  static int __init set_cmdline_ftrace(char *str)
> >  {
> > -     strlcpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
> > +     strscpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
> >       default_bootup_tracer = bootup_tracer_buf;
> >       /* We are using ftrace early, expand it */
> >       ring_buffer_expanded = true;
> > @@ -281,7 +281,7 @@ static char trace_boot_options_buf[MAX_TRACER_SIZE] __initdata;
> >
> >  static int __init set_trace_boot_options(char *str)
> >  {
> > -     strlcpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
> > +     strscpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
> >       return 1;
> >  }
> >  __setup("trace_options=", set_trace_boot_options);
> > @@ -291,7 +291,7 @@ static char *trace_boot_clock __initdata;
> >
> >  static int __init set_trace_boot_clock(char *str)
> >  {
> > -     strlcpy(trace_boot_clock_buf, str, MAX_TRACER_SIZE);
> > +     strscpy(trace_boot_clock_buf, str, MAX_TRACER_SIZE);
> >       trace_boot_clock = trace_boot_clock_buf;
> >       return 1;
> >  }
> > @@ -2521,7 +2521,7 @@ static void __trace_find_cmdline(int pid, char comm[])
> >       if (map != NO_CMDLINE_MAP) {
> >               tpid = savedcmd->map_cmdline_to_pid[map];
> >               if (tpid == pid) {
> > -                     strlcpy(comm, get_saved_cmdlines(map), TASK_COMM_LEN);
> > +                     strscpy(comm, get_saved_cmdlines(map), TASK_COMM_LEN);
> >                       return;
> >               }
> >       }
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 654ffa40457a..dc83a259915b 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -2831,7 +2831,7 @@ static __init int setup_trace_triggers(char *str)
> >       char *buf;
> >       int i;
> >
> > -     strlcpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
> > +     strscpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
> >       ring_buffer_expanded = true;
> >       disable_tracing_selftest("running event triggers");
> >
> > @@ -3621,7 +3621,7 @@ static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
> >
> >  static __init int setup_trace_event(char *str)
> >  {
> > -     strlcpy(bootup_event_buf, str, COMMAND_LINE_SIZE);
> > +     strscpy(bootup_event_buf, str, COMMAND_LINE_SIZE);
> >       ring_buffer_expanded = true;
> >       disable_tracing_selftest("running event tracing");
> >
> > diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
> > index d6b4935a78c0..abe805d471eb 100644
> > --- a/kernel/trace/trace_events_inject.c
> > +++ b/kernel/trace/trace_events_inject.c
> > @@ -217,7 +217,7 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
> >                       char *addr = (char *)(unsigned long) val;
> >
> >                       if (field->filter_type == FILTER_STATIC_STRING) {
> > -                             strlcpy(entry + field->offset, addr, field->size);
> > +                             strscpy(entry + field->offset, addr, field->size);
> >                       } else if (field->filter_type == FILTER_DYN_STRING ||
> >                                  field->filter_type == FILTER_RDYN_STRING) {
> >                               int str_len = strlen(addr) + 1;
> > @@ -232,7 +232,7 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
> >                               }
> >                               entry = *pentry;
> >
> > -                             strlcpy(entry + (entry_size - str_len), addr, str_len);
> > +                             strscpy(entry + (entry_size - str_len), addr, str_len);
> >                               str_item = (u32 *)(entry + field->offset);
> >                               if (field->filter_type == FILTER_RDYN_STRING)
> >                                       str_loc -= field->offset + field->size;
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 59cda19a9033..1b3fa7b854aa 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -30,7 +30,7 @@ static char kprobe_boot_events_buf[COMMAND_LINE_SIZE] __initdata;
> >
> >  static int __init set_kprobe_boot_events(char *str)
> >  {
> > -     strlcpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
> > +     strscpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
> >       disable_tracing_selftest("running kprobe events");
> >
> >       return 1;
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index 2d2616678295..73055ba8d8ef 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -254,7 +254,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
> >                       trace_probe_log_err(offset, GROUP_TOO_LONG);
> >                       return -EINVAL;
> >               }
> > -             strlcpy(buf, event, slash - event + 1);
> > +             strscpy(buf, event, slash - event + 1);
> >               if (!is_good_system_name(buf)) {
> >                       trace_probe_log_err(offset, BAD_GROUP_NAME);
> >                       return -EINVAL;
>
