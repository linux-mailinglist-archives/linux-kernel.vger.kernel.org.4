Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD2974743E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjGDOia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjGDOiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:38:25 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B31E10C3;
        Tue,  4 Jul 2023 07:38:20 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b5ef64bca6so4984505a34.3;
        Tue, 04 Jul 2023 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688481499; x=1691073499;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AF17IbQd8ZxHv7cFvNY+odT1eF0QJFR1h0MLd8BIYjc=;
        b=G2VE6fm00EqQKlsyVd2xRtU0thb2VUFW9Cp7ckYKcedpsaiaO/kJGhu2TcW9BR0gg0
         hbug9YpxF3kmBEV4rbKlgS5a3AyEwBKV66bdb4tDBEHtEax7w2jCbEyVrmVnGduAS/qd
         11GwlsZjBmlMvFH9pf7snQyNdhJH/kE+qzTe/mzoo98HVFPyY4ZHcTViX/4bIlhDfxlU
         H2lrm6mEmG+WuW9EEBHOgQZiP6F0uXoK9nBu91alCyGWmQwz52RPle/pFb7EW9qM2o5I
         mDCPh2SYU9yjQrW6RndJm/7ncbV0GWPy+fOpshMH8IXfR4VJWQptEu0v39z7E3bsdfbF
         rFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688481499; x=1691073499;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AF17IbQd8ZxHv7cFvNY+odT1eF0QJFR1h0MLd8BIYjc=;
        b=iEd2rPWUwlJI/We8TSRbcItZ1/DivtcQLopxPgAGHIiUY3x3MSqgPc0JCskdP1fffB
         lGlcnALiF2ni+xaumoLyHsl1urHfHgBRJRdUDenZISBlsIXI07KW9yG051TNleZdR2de
         mymcswP5580ghq9QAFZuQmGu/wtyZBS9BdbilQjvRS1WM3meSNxfRf6vvQr0v8sxJRoO
         nFEn7SgYoJIyOV8NIIJ5fKqVKXks79hrmw2U+f3wqSHU20Rx8Vy5hl87JWuzR+o6hST/
         /E9gpP7NXu+8gE8gff7oO7OhumCBCL6c7iktb986BVJoA/RgHTc3jcKxzhmpvZZRwDpM
         SNbA==
X-Gm-Message-State: AC+VfDyDY5pi/i1zHT43Xuhr9joytZpJurVFxLg7ZHYkCXliEDnjIa3d
        1C3RPjN2Qeioc9OHS56LN58=
X-Google-Smtp-Source: ACHHUZ7DjkC8tG2WJV9SVeV9pXtt3YOIHU0Xt7K81GGg7u+bu1MSmZrzgrf/bZvjNdCLxLL2O73t+g==
X-Received: by 2002:aca:d19:0:b0:396:4977:e148 with SMTP id 25-20020aca0d19000000b003964977e148mr12199716oin.9.1688481499354;
        Tue, 04 Jul 2023 07:38:19 -0700 (PDT)
Received: from yoga ([2400:1f00:13:4ede:ce27:3b63:fdb3:caf6])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7870d000000b0067a1f4f4f7dsm12978864pfo.169.2023.07.04.07.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:38:18 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Tue, 4 Jul 2023 20:08:11 +0530
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Adding Support for Firefox's Gecko Profile Format
Message-ID: <ZKQu00bJZwO+Fc6m@yoga>
References: <ZHENW4HOIo0F6FnN@yoga>
 <ZHkEWse0NVZhwKR7@yoga>
 <ZH5YBBWW5ANckoMp@yoga>
 <CAP-5=fU7ukrQSh_8OwH9C+a-EwCamCrMaZxjqDhE9f+bFJwQBQ@mail.gmail.com>
 <ZIHPXV5/ZopqcSSc@yoga>
 <ZIofrGKElc3nkNk0@yoga>
 <CAP-5=fV9tXNpYHH9DW0cVbRoFLGvG9SNn-MUhuyKuVBRuDqjoA@mail.gmail.com>
 <ZJyT8bt0LFLw6hKV@yoga>
 <CAM9d7ch7TdagV+dzj6MCp4fY15Vc4oGJjKAoQDyc=BXqy7qi+A@mail.gmail.com>
 <287bf3c8-fa0e-8c36-df14-7d728c63c265@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <287bf3c8-fa0e-8c36-df14-7d728c63c265@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 09:35:22AM +0300, Adrian Hunter wrote:
> On 29/06/23 09:26, Namhyung Kim wrote:
> > Hi Anup,
> > 
> > On Wed, Jun 28, 2023 at 1:11 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >>
> >> On Wed, Jun 14, 2023 at 01:17:52PM -0700, Ian Rogers wrote:
> >>> On Wed, Jun 14, 2023 at 1:14 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >>>>
> >>>> On Thu, Jun 08, 2023 at 06:23:49PM +0530, Anup Sharma wrote:
> >>>> I wanted to take a moment to provide you with an update on the progress
> >>>> of our Firefox Gecko converter work. While I must emphasize that the code
> >>>> I'm sharing is not the final version, I wanted to share the advancements
> >>>> I have made thus far.
> >>>>
> >>>> This script can generate a JSON format from the output of the "perf script" command.
> >>>> I attempted to load this JSON file into profile.firefox.com, and although it
> >>>> successfully loaded, the call tree are not visible. I'm certain this issue
> >>>> is related to the format of the JSON file or if there is another underlying
> >>>> cause. I will continue investigating to determine the cause of this problem.
> >>>
> >>> Great Anup, progress can be frustrating slow at first but it is a good
> >>> milestone to be generating output and having firefox profiler consume
> >>> it. You can open up the JavaScript console for the firefox profiler
> >>> and it will give some debug output. This should hopefully help you
> >>> make progress.
> >>
> >> This week I tried playing with perf-script-python, the first challenge was
> >> figuring out how to parse the data coming from the process_events.
> >> Understanding the structure and extracting the necessary information
> >> proved to be more complex than anticipated. This required me to spend
> >> a significant amount of time researching and experimenting with different
> >> parsing techniques.
> > 
> > I'm not sure what kind of parsing you meant.  IIRC the sample data is
> > in a dict and all the information should be available there.  Maybe we
> > missed some new sample data types though.
> 
> Most data is there.  There are existing scripts in
> tools/perf/scripts/python/ for reference.
> 
> There is also the dlfilter API:
> 
> https://perf.wiki.kernel.org/index.php/Latest_Manual_Page_of_perf-dlfilter.1
>
Hello everyone,

I hope you're all doing well. I have been working on the using process_events function and have made
progress in developing the converter script. Currently, I am in the testing phase. However, I
have encountered a problem after performing some recent compilations. I am no longer receiving
the complete callchains in the output as I used to.
For Example, when I ran the command perf script -F +pid, the output would include detailed
information like the following example:

perf-exec  132554/132554  171854.674582:        356 cycles:P: 
	ffffffff8fab3fc6 arch_static_branch+0x6 (inlined)
	ffffffff8fab3fc6 static_key_false+0x6 (inlined)
	ffffffff8fab3fc6 native_write_msr+0x6 (/lib/modules/6.4.0-rc1/build/vmlinux)
	ffffffff8fa12ca5 intel_pmu_enable_all+0x15 (/lib/modules/6.4.0-rc1/build/vmlinux)

However, in my current situation, the output is limited to the following:

perf  108107/108107  [000] 67650.031827:          1 cycles:P:  
ffffffff83ab3fc4 native_write_msr+0x4 (/lib/modules/6.4.0-rc1/build/vmlinux)
perf  108107/108107  [000] 67650.031832:          1 cycles:P:
ffffffff83ab3fc4 native_write_msr+0x4 (/lib/modules/6.4.0-rc1/build/vmlinux)

It seems to be issue in perf record. I would appreciate any suggestions or assistance
in resolving this issue. Thank you all for your help.

Regards,
Anup
> > 
> >>
> >> The second challenge revolved around the usage of event hooks provided with the perf script
> >> python event handlers. I found myself deliberating between two approaches. The first
> >> approach involved creating custom functions that would be called using the event
> >> handlers. These functions would then save the data in an organized format within
> >> globally created data structures. The alternative approach was to write the entire
> >> logic inside the event handlers themselves.
> >>
> >> Additionally, I contemplated whether it would be more suitable to handle the creation of
> >> a Gecko format for JSON and the profile format within the same script or to separate
> >> them into different scripts.
> >>
> >> I will discuss this points during tomorrow's office hour.
> >>
> >> However, I have gained a deeper understanding of the problem at hand and will use this
> >> knowledge to make more informed decisions and progress more effectively in the coming weeks.
> > 
> > Sounds like you did a good amount of research on how perf script
> > works.  We can talk about the details in the meeting.
> > 
> > Thanks,
> > Namhyung
> 
