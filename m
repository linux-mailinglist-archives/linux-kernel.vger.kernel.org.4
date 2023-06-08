Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614357280A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjFHMye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbjFHMyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:54:22 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D7430E5;
        Thu,  8 Jun 2023 05:54:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-655d1fc8ad8so325552b3a.1;
        Thu, 08 Jun 2023 05:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686228839; x=1688820839;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j8UhG+qvAj194kl8IInt/AKhDQlK5jONroHH725iWxI=;
        b=ela0zpz2yGpujgwMtjD7eFeSiUgq+13PeDj366P+Lol0HdL5cKcKJ3frWiWN56qn4m
         JmJPUuOyfq6Ntu134M9lVeX6Z3xOgnM45UZYpav5ReWMNkMnmeHJad/ALnhH7JUxCD4C
         YX7qwvfgw3TqyWgMWS2E2+YpRwfl0/m0wLkmhkZtgD5VOGVZvJo4w2kOdq5JnwdhklG8
         6KUC/VzhVfYOwC4oTGbm7wXVgdrNldXXSl+dAqj1kKgAMmKWXvixQELkUkz1rNhuBk88
         z5cGIf0srvnjJZEfc015umX3c1AXtCBW2DOugflYxPRDwK/+92Vk9IKZEVTBgqK7M7IQ
         tQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686228839; x=1688820839;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j8UhG+qvAj194kl8IInt/AKhDQlK5jONroHH725iWxI=;
        b=SPoAPIQieodWeaNGA8ZkmfS3x6LEQHVLwaQve6yCYkay+c7YgaLwFz/I2oh/Yr8zoi
         2D/qtcbPTGU2y8P/YtjFfqXEpZgz7fK0RxAKd+TAK1wwFzAsEmFs85LUqA0PyuTerse4
         jXRE2G0Qwdn58TIH2SB+p02rO9denCn2tKDLXYEXK/KtKJpy63xmHxqNP5t+aE1QOlgY
         U8jw5Na7FLD7W8hfV5pO3vClNk7TPxDBuOWb/K6niL4CyliVygfxtRr8YP2s3iHl4K6I
         MBAFr3wXpRC2IvEKBaRRUrTepJkP2gJWU+Byhjjz5bqxgBfTPNQRgm2yiX2SYvaGMsZL
         5GNw==
X-Gm-Message-State: AC+VfDw9FQ1MR5vMsAW9Dh1ppc6aaN0GWp7WOEWm3EqFoiayYzWj37U9
        zt+5XAzt3JhoiFYk7zQwnmg=
X-Google-Smtp-Source: ACHHUZ5qjaUmyv7cI/3oOnnwSzfvkQykcz8emxEeehLW5M+A9pm0rV/YS1OQqB821Dcmtj6EwuedUg==
X-Received: by 2002:a05:6a00:ad0:b0:638:edbc:74ca with SMTP id c16-20020a056a000ad000b00638edbc74camr5312557pfl.0.1686228838588;
        Thu, 08 Jun 2023 05:53:58 -0700 (PDT)
Received: from yoga ([202.131.132.46])
        by smtp.gmail.com with ESMTPSA id c16-20020aa781d0000000b0063f0068cf6csm1048047pfn.198.2023.06.08.05.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 05:53:57 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Thu, 8 Jun 2023 18:23:49 +0530
To:     Ian Rogers <irogers@google.com>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        linux-perf-users@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Adding Support for Firefox's Gecko Profile Format
Message-ID: <ZIHPXV5/ZopqcSSc@yoga>
References: <ZG5kjDN63HqqMuJJ@yoga>
 <CAM9d7ciUsJM1kZhGbhQUfdxq1rsvLig2C-mAki13a92EjW37kw@mail.gmail.com>
 <CAP-5=fVekEnC1s=xUG-jFeL20qM=EPNkPO8aw8bcg4cVM=m5wg@mail.gmail.com>
 <ZHENW4HOIo0F6FnN@yoga>
 <ZHkEWse0NVZhwKR7@yoga>
 <ZH5YBBWW5ANckoMp@yoga>
 <CAP-5=fU7ukrQSh_8OwH9C+a-EwCamCrMaZxjqDhE9f+bFJwQBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU7ukrQSh_8OwH9C+a-EwCamCrMaZxjqDhE9f+bFJwQBQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 11:58:57PM -0700, Ian Rogers wrote:
> On Mon, Jun 5, 2023 at 2:47 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > On Fri, Jun 02, 2023 at 02:19:30AM +0530, Anup Sharma wrote:
> > > On Sat, May 27, 2023 at 01:19:47AM +0530, Anup Sharma wrote:
> > > > On Fri, May 26, 2023 at 08:17:44AM -0700, Ian Rogers wrote:
> > > > > On Thu, May 25, 2023 at 1:53 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > Hi Anup,
> > > > > >
> > > > > > On Wed, May 24, 2023 at 12:25 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> > > > > > >
> > > > > > > Hello everyone,
> > > > > > >
> > > > > > > I'm happy to share that I'll be working on adding support for Firefox's Gecko profile format.
> > > > > > > This format is utilized by the Firefox profiler, which is a powerful tool for performance analysis
> > > > > > > and debugging. By enhancing the perf data command to generate perf.data files in the Gecko
> > > > > > > profile format, it will allow us to leverage the capabilities of the Firefox profiler for visualizing
> > > > > > > and analyzing the performance data.
> > > > > > >
> > > > > > > As a starter task, I have created a test for testing the perf data JSON converter command.
> > > > > > > I'm also looking for a few more starter tasks related to this project. I would greatly appreciate
> > > > > > > your advice and guidance.
> > > > > > >
> > > > > > > In my effort to identify any existing bugs, I have enabled flags like 'fsanitize=address' to detect
> > > > > > > potential issues but have not found any :). Additionally, I am running perf data commands to ensure
> > > > > > > that all use cases are handled properly.
> > > > > >
> > > > > > Great, good to know it works well with asan for the basic use cases at least.
> > > > > >
> > > > > > >
> > > > > > > I have one question regarding the installation process. Typically, I navigate to the perf directory,
> > > > > > > run 'make', and then cp 'perf' to '/usr/bin'. However, I noticed that by default, perf is installed in
> > > > > > > the '~/bin/perf' directory. Could someone please clarify why this is the case? Furthermore, I would
> > > > > > > like to know how all of you compile the perf tree.
> > > > > >
> > > > > > I guess $HOME is the default prefix unless you set it to other, then
> > > > > > make install will put
> > > > > > the binary there.  You can make sure if your PATH contains the ~/bin and use it.
> > > > > >
> > > > > > But it's also possible you can run the perf without installing.  I
> > > > > > have a symlink in
> > > > > > my tmp directory to point to the recent build of the binary and use it
> > > > > > always. :)
> > > > > > To build, you can either 'cd tools/perf; make' or 'make -C tools/perf'
> > > > > > in the top
> > > > > > level linux source tree.  I also pass "BUILD_BPF_SKEL=1" to enable BPF.
> > > > > >
> > > > > > Thanks,
> > > > > > Namhyung
> > > > >
> > > > > I quite often test with address sanitizer, I do this by passing to make:
> > > > > DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame- pointer
> > > > > -fsanitize=address" NO_LIBTRACEEVENT=1
> > > > >
> > > > > The libtraceevent exclusion is to avoid false address sanitizer
> > > > > warnings in libtraceevent (it wasn't compiled with address sanitizer).
> > > > > The other flags are to make the code easier to debug. A good place to
> > > > > start for a description of the build flags is Makefile.perf:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Makefile.perf?h=perf-tools-next
> > > > >
> > > > > There's also some description here:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Documentation/Build.txt?h=perf-tools-next
> > > > >
> > > > > Perhaps you can suggest improvements :-)
> > > > >
> > > >
> > > > Thanks Namhyung and Ian for your suggestions. I'll try them out and let you know if I have any questions.
> > > >
> > >
> > > Hello all,
> > >
> > > Thank you for participating in today's office hours and helping me clarify my doubts.
> > > One topic that emerged from our discussion is the choice of programming language
> > > for writing the converter. I am considering using Python as it offers convenient
> > > libraries for JSON manipulation. However, I need to investigate whether Python is
> > > enabled by default in most of the Linux distributions that ship with perf, as its
> > > absence could pose a potential obstacle.
> > >
> > > Additionally, two profile formats are available: Gecko profile format and Processed profile format[1].
> > > Upon discussing on Firefox Profiler matrix channel, they recommended opting for the Processed format,
> > > as it will be supported in future releases as well. Therefore, I intend to begin by working with the
> > > Processed format and evaluate the results. If any of you have suggestions regarding the choice of
> > > format, I would greatly appreciate your input.
> > >
> > > Later on, I will address concerns I have regarding the file-loading process.
> > > Once again, thank you all for your time.
> >
> > I wanted to provide an update on my exploration of various tools
> > and methods to generate a profiler format. In my experimentation, I
> > considered following command as a reference.
> >
> > perf record -F 99 -g -- perf test -w noploop
> >
> > The command generated perf.data file has been used with three
> > different tools to generate the required format and uploaded them to
> > profiler.firefox.com. Interestingly, I noticed distinct call trees in
> > each of the three cases. I find myself in a state of confusion regarding
> > which result to consider as a reference. Here are the outcomes:
> >
> >     1. Result obtained using perf script: https://share.firefox.dev/3qxEt7F
> >     2. Result obtained using samply:https://share.firefox.dev/3OZsha2
> >     3. Result obtained using simpleperf gecko_profile_generator: https://share.firefox.dev/45Q2BTe
> >
> > I would greatly appreciate any guidance or suggestions in this matter.
> 
> Hi Anup,
> 
> of the 3 outcomes the perf script output looks best. Is the reason
> using the processed profile format? For the other two the major issue
> appears to be symbolization. Presumably with the first perf script is
> helping out. I'm not sure why the simpleperf stacks are truncated.
> Sorry to not be of more use, presumably you've looked into this more
> and we can discuss this in the office hours tomorrow.

The issue does not appear to be related to the processed or gecko profile format.
Despite specifying the path to the debug symbols using the -symfs option, the 
simpleperf gecko_profile_generator script is unable to detect the debug symbols 
in my system. I have confirmed that the permissions are correct.

Here is the basic output: 

root@yoga:/home/anup/perf/simpleperf/scripts# ./gecko_profile_generator.py -i 
perf.data | gzip > profiler.gz
python3 W 06-08 18:13:27 160392 160392 dso.cpp:446] /usr/lib/x86_64-linux-gnu/
ld-linux-x86-64.so.2 doesn't contain symbol table
python3 W 06-08 18:13:27 160392 160392 dso.cpp:446] /usr/lib/x86_64-linux-gnu/
libc.so.6 doesn't contain symbol table

> 
> Thanks,
> Ian
> 
> > > Thanks,
> > > Anup
> > >
> > > [1] https://github.com/firefox-devtools/profiler/blob/main/docs-developer/custom-importer.md
> > >
> > > > > Thanks,
> > > > > Ian
> > > > >
> > > > > > >
> > > > > > > Thank you for your support and I'm looking forward to collaborating with you on this project!
