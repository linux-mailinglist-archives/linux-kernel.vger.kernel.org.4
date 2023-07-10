Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7AA74E074
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 23:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGJVva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 17:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGJVv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 17:51:28 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDBF11B;
        Mon, 10 Jul 2023 14:51:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso2492565ad.2;
        Mon, 10 Jul 2023 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689025887; x=1691617887;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9S6N5y4xR1Mwz7JsLB8Y+2L4nPmqA79cUA7WUOzNa4A=;
        b=PR9IUNeCLww0G3YNvD38T3sg67j0v9zzxifS9kVOFgcChWBplUH/jI/nxFV3v2fU42
         JQhdL4Vmm/VmjLGsBmkBo5Zu1IIbanZwPmjy3kr4UuuHN2umgVp7q3zBxI3NOlvBEUm+
         PB2YVIrj9NuWsWjN2uCD1eVuC6X9lVvKdQOKJaQSw30iA31YUxsQ1cp1hFSa5QFiht0N
         RZ3sLRVfezdor+8WuJrKkPdV7taSJi5nmHE3u/IOW7BqCmgQGeKWjiG3nlt/8kd95UQn
         KWMuqD39xrSx4kPrHzHpBkbKVUNp4aAOStVXGudEq2aD7W56+T8GAjR+XUF5ZkE1YlZz
         KAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689025887; x=1691617887;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9S6N5y4xR1Mwz7JsLB8Y+2L4nPmqA79cUA7WUOzNa4A=;
        b=llWnb3HHPQAQLaFkcOKdjQiOs6UAQAAhQS5YvFKyjbOrZc1yWNsYliuK6foy9T193V
         xuj6K007gTuXWllmrtpe4jO093GGtYMTfZvIvIYzPxM4pkBfR1ulZBNDcaVrosQvHgZ9
         aSK+w27ES3kM3y83+7/EI8Oj3904sO4+aYV0nrLVWDQAKKr72MsOunpZ7jAv+gW5Jvfj
         990mtXfLlBZvrAjIQDaH+YkNkSv/QqIubBLpZZlzkzn5UgQw5LSk2UidB9sIM0L9skaD
         mt6F1ubJTsXyFxwbGmtIy8SOt0gwO3fwif18rAWF6fZ0hH3rFfoYR7DDVJSTZEX6KVQJ
         adJw==
X-Gm-Message-State: ABy/qLaq54bnnJMo1x35drdDbY4JntNWtl5gHVI7KQnDI4167UKIQ7Xj
        4VDbWQ0popzn1SAor2mDWW8=
X-Google-Smtp-Source: APBJJlGmbWSXN1azF3qSDawF9LKNrJlAj+HBGMvkfnU1MVvdsvPADMeDsDvhiZUO4HEsez0iqnDd8g==
X-Received: by 2002:a17:903:2305:b0:1b8:9b17:f63d with SMTP id d5-20020a170903230500b001b89b17f63dmr13872377plh.23.1689025887292;
        Mon, 10 Jul 2023 14:51:27 -0700 (PDT)
Received: from yoga ([2400:1f00:13:76f2:d743:45e6:d02:e038])
        by smtp.gmail.com with ESMTPSA id c23-20020a170902cb1700b001b9bebbc621sm358380ply.136.2023.07.10.14.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:51:26 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Tue, 11 Jul 2023 03:21:19 +0530
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] scripts: python: Introduce thread sample
 processing to create thread
Message-ID: <ZKx9V3o3VZAfBz4e@yoga>
References: <cover.1688585597.git.anupnewsmail@gmail.com>
 <df4773a4ebb43a6c855bad5a2bbc338bc2669ca7.1688585597.git.anupnewsmail@gmail.com>
 <CAM9d7chNwcCD6J-twSTTxm6uLoNbMT8ZYKHcDiZxXjcfEVfDfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chNwcCD6J-twSTTxm6uLoNbMT8ZYKHcDiZxXjcfEVfDfw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:42:47PM -0700, Namhyung Kim wrote:
> On Wed, Jul 5, 2023 at 12:44 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > The _addThreadSample function is responsible for adding a sample to a specific
> > thread. It first checks if the thread exists in the thread_map dictionary.
> > If not, it creates a new thread using the _createtread function and assigns
> > it to the thread_map. Finally, it calls the 'addSample' method of the thread,
> > passing the thread name, stack, and timestamp.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> > ---
> >  .../perf/scripts/python/firefox-gecko-converter.py  | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> > index ce663840d212..95b061a97cbc 100644
> > --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > @@ -18,7 +18,20 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> >  from perf_trace_context import *
> >  from Core import *
> >
> > +thread_map = {}
> > +start_time = None
> > +
> >  def process_event(param_dict):
> > +       global start_time
> > +       global thread_map
> > +
> > +       def _addThreadSample(pid, tid, threadName, time_stamp, stack):
> > +               thread = thread_map.get(tid)
> > +               if not thread:
> > +                       thread = _createtread(threadName, pid, tid)
> 
> Shouldn't it be '_createThread'?

Yes, it should be '_createThread'. I will fix it in the next version.

> > +                       thread_map[tid] = thread
> > +               thread['addSample'](threadName, stack, time_stamp)
> 
> Why is it like this?  What do you intend with the thread['addSample']
> method?  Can it be simpler like a direct function call?

The purpose of the addSample function is to append stack frames to the
samples['data'] collection. While it could be implemented as a standalone
function, doing so would increase complexity due to shared properties
among threads such as pid, tid, and threadName. Although a decorator
could potentially address this, it would likely result in code that
is functionally and structurally similar. Alternatively, if addSample
were implemented as a separate function, the shared elements would need
to be repeatedly passed to the function.

> And more importantly, you'd better make each patch work properly.
> AFAICS it won't do the job because both _createtread() and
> thread['addSample'] are not implemented yet.
>
> You can either move those definitions to this commit or have the
> commit implementing them before this one.

Thanks, Preparing commit in series is new to me. I will try to fix
it in the next version.

> Thanks,
> Namhyung
> 
> 
> > +
> >         time_stamp = (param_dict['sample']['time'] // 1000) / 1000
> >         pid = param_dict['sample']['pid']
> >         tid = param_dict['sample']['tid']
> > --
> > 2.34.1
> >
