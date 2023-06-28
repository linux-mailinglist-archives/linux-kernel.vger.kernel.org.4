Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC928741958
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjF1UMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjF1ULm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:11:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E811BEA;
        Wed, 28 Jun 2023 13:11:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b7f9d66812so2999515ad.0;
        Wed, 28 Jun 2023 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687983099; x=1690575099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vb1LGnw2bBNhKTCsZj3x5fzv8TTJsf7RbOddcOMpsVU=;
        b=JeKrCAAU/abVTYwGeRPT/dmBcPIwlYkdWxakodYALNpZndCeFM+/y5gC5aRcpyGGxG
         x+zh+bIO9rLN7F+LI4pQ4NEMtmgljcCS8E51CNoBp4E2fYom/lNgQxoCiBCw4fVQ5vPF
         s45swkO73/aalrRZmXYeHMBydZ2Hqg9w/pjwFO2hbiEazRtG0gR7uvBhhKXodMlQhH5q
         5TwpRLl7t0qrzN2cSnVrKx4e4hPBCuZE//Uwdky4WrJRSBEVdyOVw66fgVUVtySz6NfH
         G4Z6KC2yyGYnLgmxacfc7aZsj6YNv+tB1kcLTr7BVKzg/P9Wv1N1YEk5ZS9YZEH7yZjK
         LwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983099; x=1690575099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb1LGnw2bBNhKTCsZj3x5fzv8TTJsf7RbOddcOMpsVU=;
        b=H+7EpHnyoI6ao7j82f1IAfs35CoWC2zqq1AZ3TUw36e+wkerLVn6pHDHhF0tT1Y+K3
         mAvq0UOXJr1QHSoEAMgXOI6d5WNsUiEcP9A+5ChV0oIgEGgwB5hU3fbgSmhUdxstpLIg
         DBSRyalvw68eH4YY+ui9L23yoLTtoblIlFwM6vq0SpEob8sxqF/XhHZSCR7GINQ/e4Ph
         NkAjA4Qidyqi7V6bucA8UJijrPKANoUsL6K4ZvG32FWq12XFVSbk0KOP3Ufr37qTsFnp
         vToP1qqvDc9MdYmkQt+hy+iowmMszoxDoQ6qEiesD9w7tcDfBMqlVhfJ/yi9J61D8E+w
         o6PQ==
X-Gm-Message-State: ABy/qLa/9tlFA22qnEx/pG79vTUEIqztD/AmEjgfDyDa7M0/iKT3busB
        QoChTY6AjyR83J/bl6gKPxE=
X-Google-Smtp-Source: APBJJlH/Wpezox1Ka74lcDPdwH1Ez7L3OZ1edh73Ptntv/93LmxZrYyszZ1PWnurhizWa2qCrMpP7A==
X-Received: by 2002:a17:902:8348:b0:1b8:4607:c3d7 with SMTP id z8-20020a170902834800b001b84607c3d7mr1714695pln.41.1687983099018;
        Wed, 28 Jun 2023 13:11:39 -0700 (PDT)
Received: from yoga ([2400:1f00:13:b2f4:d192:6c2b:8deb:5f71])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090301c500b001a04d27ee92sm8045424plh.241.2023.06.28.13.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:11:37 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Thu, 29 Jun 2023 01:41:29 +0530
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
Message-ID: <ZJyT8bt0LFLw6hKV@yoga>
References: <ZG5kjDN63HqqMuJJ@yoga>
 <CAM9d7ciUsJM1kZhGbhQUfdxq1rsvLig2C-mAki13a92EjW37kw@mail.gmail.com>
 <CAP-5=fVekEnC1s=xUG-jFeL20qM=EPNkPO8aw8bcg4cVM=m5wg@mail.gmail.com>
 <ZHENW4HOIo0F6FnN@yoga>
 <ZHkEWse0NVZhwKR7@yoga>
 <ZH5YBBWW5ANckoMp@yoga>
 <CAP-5=fU7ukrQSh_8OwH9C+a-EwCamCrMaZxjqDhE9f+bFJwQBQ@mail.gmail.com>
 <ZIHPXV5/ZopqcSSc@yoga>
 <ZIofrGKElc3nkNk0@yoga>
 <CAP-5=fV9tXNpYHH9DW0cVbRoFLGvG9SNn-MUhuyKuVBRuDqjoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV9tXNpYHH9DW0cVbRoFLGvG9SNn-MUhuyKuVBRuDqjoA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 01:17:52PM -0700, Ian Rogers wrote:
> On Wed, Jun 14, 2023 at 1:14 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > On Thu, Jun 08, 2023 at 06:23:49PM +0530, Anup Sharma wrote:
> > > On Wed, Jun 07, 2023 at 11:58:57PM -0700, Ian Rogers wrote:
> > > > On Mon, Jun 5, 2023 at 2:47 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jun 02, 2023 at 02:19:30AM +0530, Anup Sharma wrote:
> > > > > > On Sat, May 27, 2023 at 01:19:47AM +0530, Anup Sharma wrote:
> > > > > > > On Fri, May 26, 2023 at 08:17:44AM -0700, Ian Rogers wrote:
> > > > > > > > On Thu, May 25, 2023 at 1:53 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Anup,
> > > > > > > > >
> > > > > > > > > On Wed, May 24, 2023 at 12:25 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hello everyone,
> > > > > > > > > >
> > > > > > > > > > I'm happy to share that I'll be working on adding support for Firefox's Gecko profile format.
> > > > > > > > > > This format is utilized by the Firefox profiler, which is a powerful tool for performance analysis
> > > > > > > > > > and debugging. By enhancing the perf data command to generate perf.data files in the Gecko
> > > > > > > > > > profile format, it will allow us to leverage the capabilities of the Firefox profiler for visualizing
> > > > > > > > > > and analyzing the performance data.
> > > > > > > > > >
> > > > > > > > > > As a starter task, I have created a test for testing the perf data JSON converter command.
> > > > > > > > > > I'm also looking for a few more starter tasks related to this project. I would greatly appreciate
> > > > > > > > > > your advice and guidance.
> > > > > > > > > >
> > > > > > > > > > In my effort to identify any existing bugs, I have enabled flags like 'fsanitize=address' to detect
> > > > > > > > > > potential issues but have not found any :). Additionally, I am running perf data commands to ensure
> > > > > > > > > > that all use cases are handled properly.
> > > > > > > > >
> > > > > > > > > Great, good to know it works well with asan for the basic use cases at least.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I have one question regarding the installation process. Typically, I navigate to the perf directory,
> > > > > > > > > > run 'make', and then cp 'perf' to '/usr/bin'. However, I noticed that by default, perf is installed in
> > > > > > > > > > the '~/bin/perf' directory. Could someone please clarify why this is the case? Furthermore, I would
> > > > > > > > > > like to know how all of you compile the perf tree.
> > > > > > > > >
> > > > > > > > > I guess $HOME is the default prefix unless you set it to other, then
> > > > > > > > > make install will put
> > > > > > > > > the binary there.  You can make sure if your PATH contains the ~/bin and use it.
> > > > > > > > >
> > > > > > > > > But it's also possible you can run the perf without installing.  I
> > > > > > > > > have a symlink in
> > > > > > > > > my tmp directory to point to the recent build of the binary and use it
> > > > > > > > > always. :)
> > > > > > > > > To build, you can either 'cd tools/perf; make' or 'make -C tools/perf'
> > > > > > > > > in the top
> > > > > > > > > level linux source tree.  I also pass "BUILD_BPF_SKEL=1" to enable BPF.
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Namhyung
> > > > > > > >
> > > > > > > > I quite often test with address sanitizer, I do this by passing to make:
> > > > > > > > DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame- pointer
> > > > > > > > -fsanitize=address" NO_LIBTRACEEVENT=1
> > > > > > > >
> > > > > > > > The libtraceevent exclusion is to avoid false address sanitizer
> > > > > > > > warnings in libtraceevent (it wasn't compiled with address sanitizer).
> > > > > > > > The other flags are to make the code easier to debug. A good place to
> > > > > > > > start for a description of the build flags is Makefile.perf:
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Makefile.perf?h=perf-tools-next
> > > > > > > >
> > > > > > > > There's also some description here:
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Documentation/Build.txt?h=perf-tools-next
> > > > > > > >
> > > > > > > > Perhaps you can suggest improvements :-)
> > > > > > > >
> > > > > > >
> > > > > > > Thanks Namhyung and Ian for your suggestions. I'll try them out and let you know if I have any questions.
> > > > > > >
> > > > > >
> > > > > > Hello all,
> > > > > >
> > > > > > Thank you for participating in today's office hours and helping me clarify my doubts.
> > > > > > One topic that emerged from our discussion is the choice of programming language
> > > > > > for writing the converter. I am considering using Python as it offers convenient
> > > > > > libraries for JSON manipulation. However, I need to investigate whether Python is
> > > > > > enabled by default in most of the Linux distributions that ship with perf, as its
> > > > > > absence could pose a potential obstacle.
> > > > > >
> > > > > > Additionally, two profile formats are available: Gecko profile format and Processed profile format[1].
> > > > > > Upon discussing on Firefox Profiler matrix channel, they recommended opting for the Processed format,
> > > > > > as it will be supported in future releases as well. Therefore, I intend to begin by working with the
> > > > > > Processed format and evaluate the results. If any of you have suggestions regarding the choice of
> > > > > > format, I would greatly appreciate your input.
> > > > > >
> > > > > > Later on, I will address concerns I have regarding the file-loading process.
> > > > > > Once again, thank you all for your time.
> > > > >
> > > > > I wanted to provide an update on my exploration of various tools
> > > > > and methods to generate a profiler format. In my experimentation, I
> > > > > considered following command as a reference.
> > > > >
> > > > > perf record -F 99 -g -- perf test -w noploop
> > > > >
> > > > > The command generated perf.data file has been used with three
> > > > > different tools to generate the required format and uploaded them to
> > > > > profiler.firefox.com. Interestingly, I noticed distinct call trees in
> > > > > each of the three cases. I find myself in a state of confusion regarding
> > > > > which result to consider as a reference. Here are the outcomes:
> > > > >
> > > > >     1. Result obtained using perf script: https://share.firefox.dev/3qxEt7F
> > > > >     2. Result obtained using samply:https://share.firefox.dev/3OZsha2
> > > > >     3. Result obtained using simpleperf gecko_profile_generator: https://share.firefox.dev/45Q2BTe
> > > > >
> > > > > I would greatly appreciate any guidance or suggestions in this matter.
> > > >
> > > > Hi Anup,
> > > >
> > > > of the 3 outcomes the perf script output looks best. Is the reason
> > > > using the processed profile format? For the other two the major issue
> > > > appears to be symbolization. Presumably with the first perf script is
> > > > helping out. I'm not sure why the simpleperf stacks are truncated.
> > > > Sorry to not be of more use, presumably you've looked into this more
> > > > and we can discuss this in the office hours tomorrow.
> > >
> > > The issue does not appear to be related to the processed or gecko profile format.
> > > Despite specifying the path to the debug symbols using the -symfs option, the
> > > simpleperf gecko_profile_generator script is unable to detect the debug symbols
> > > in my system. I have confirmed that the permissions are correct.
> > >
> > > Here is the basic output:
> > >
> > > root@yoga:/home/anup/perf/simpleperf/scripts# ./gecko_profile_generator.py -i
> > > perf.data | gzip > profiler.gz
> > > python3 W 06-08 18:13:27 160392 160392 dso.cpp:446] /usr/lib/x86_64-linux-gnu/
> > > ld-linux-x86-64.so.2 doesn't contain symbol table
> > > python3 W 06-08 18:13:27 160392 160392 dso.cpp:446] /usr/lib/x86_64-linux-gnu/
> > > libc.so.6 doesn't contain symbol table
> > >
> >
> > Hi All,
> >
> > I wanted to take a moment to provide you with an update on the progress
> > of our Firefox Gecko converter work. While I must emphasize that the code
> > I'm sharing is not the final version, I wanted to share the advancements
> > I have made thus far.
> >
> > This script can generate a JSON format from the output of the "perf script" command.
> > I attempted to load this JSON file into profile.firefox.com, and although it
> > successfully loaded, the call tree are not visible. I'm certain this issue
> > is related to the format of the JSON file or if there is another underlying
> > cause. I will continue investigating to determine the cause of this problem.
> 
> Great Anup, progress can be frustrating slow at first but it is a good
> milestone to be generating output and having firefox profiler consume
> it. You can open up the JavaScript console for the firefox profiler
> and it will give some debug output. This should hopefully help you
> make progress.

This week I tried playing with perf-script-python, the first challenge was 
figuring out how to parse the data coming from the process_events. 
Understanding the structure and extracting the necessary information
proved to be more complex than anticipated. This required me to spend 
a significant amount of time researching and experimenting with different
parsing techniques.

The second challenge revolved around the usage of event hooks provided with the perf script
python event handlers. I found myself deliberating between two approaches. The first
approach involved creating custom functions that would be called using the event
handlers. These functions would then save the data in an organized format within
globally created data structures. The alternative approach was to write the entire
logic inside the event handlers themselves. 

Additionally, I contemplated whether it would be more suitable to handle the creation of 
a Gecko format for JSON and the profile format within the same script or to separate 
them into different scripts. 

I will discuss this points during tomorrow's office hour.   

However, I have gained a deeper understanding of the problem at hand and will use this 
knowledge to make more informed decisions and progress more effectively in the coming weeks.

> Thanks,
> Ian
> 
> > ----------------------->cut<---------------------------
> > diff --git a/tools/perf/scripts/python/gecko_converter.py b/tools/perf/scripts/python/gecko_converter.py
> > new file mode 100644
> > index 000000000000..7340ea4bd84e
> > --- /dev/null
> > +++ b/tools/perf/scripts/python/gecko_converter.py
> > @@ -0,0 +1,236 @@
> > +#!/usr/env/bin python3
> > +import re
> > +import sys
> > +import json
> > +from functools import reduce
> > +
> > +def isPerfScriptFormat(profile):
> > +    if profile.startswith('{'):
> > +        return False
> > +
> > +    firstLine = profile[:profile.index('\n')]
> > +    return bool(re.match(r'^\S.*?\s+(?:\d+/)?\d+\s+(?:\d+\d+\s+)?[\d.]+:', firstLine))
> > +
> > +CATEGORIES = [
> > +{'name': 'User', 'color': 'yellow', 'subcategories': ['Other']},
> > +{'name': 'Kernel', 'color': 'orange', 'subcategories': ['Other']}
> > +]
> > +USER_CATEGORY_INDEX = 0
> > +KERNEL_CATEGORY_INDEX = 1
> > +
> > +def convertPerfScriptProfile(profile):
> > +    def _createtread(name, pid, tid):
> > +        markers = {
> > +            'schema': {
> > +                'name': 0,
> > +                'startTime': 1,
> > +                'endTime': 2,
> > +                'phase': 3,
> > +                'category': 4,
> > +                'data': 5,
> > +            },
> > +            'data': [],
> > +        }
> > +        samples = {
> > +            'schema': {
> > +                'stack': 0,
> > +                'time': 1,
> > +                'responsiveness': 2,
> > +                },
> > +            'data': [],
> > +        }
> > +        frameTable = {
> > +            'schema': {
> > +                'location': 0,
> > +                'relevantForJS': 1,
> > +                'innerWindowID': 2,
> > +                'implementation': 3,
> > +                'optimizations': 4,
> > +                'line': 5,
> > +                'column': 6,
> > +                'category': 7,
> > +                'subcategory': 8,
> > +            },
> > +            'data': [],
> > +        }
> > +        stackTable = {
> > +            'schema': {
> > +                'prefix': 0,
> > +                'frame': 1,
> > +            },
> > +            'data': [],
> > +        }
> > +        stringTable = []
> > +
> > +        stackMap = dict()
> > +        def get_or_create_stack(frame, prefix):
> > +            key = f"{frame}" if prefix is None else f"{frame},{prefix}"
> > +            stack = stackMap.get(key)
> > +            if stack is None:
> > +                stack = len(stackTable['data'])
> > +                stackTable['data'].append([prefix, frame])
> > +                stackMap[key] = stack
> > +            return stack
> > +
> > +        frameMap = dict()
> > +        def get_or_create_frame(frameString):
> > +            frame = frameMap.get(frameString)
> > +            if frame is None:
> > +                frame = len(frameTable['data'])
> > +                location = len(stringTable)
> > +                stringTable.append(frameString)
> > +                # print('batman', frame, frameString)
> > +
> > +                category = KERNEL_CATEGORY_INDEX if frameString.find('kallsyms') != -1 or frameString.find('/vmlinux') != 1 or frameString.endswith('.ko)') else USER_CATEGORY_INDEX
> > +                implementation = None
> > +                optimizations = None
> > +                line = None
> > +                relevantForJS = False
> > +                subcategory = None
> > +                innerWindowID = 0
> > +                column = None
> > +
> > +                frameTable['data'].append([
> > +                    location,
> > +                    relevantForJS,
> > +                    innerWindowID,
> > +                    implementation,
> > +                    optimizations,
> > +                    line,
> > +                    column,
> > +                    category,
> > +                    subcategory,
> > +                ])
> > +                frameMap[frameString] = frame
> > +            return frame
> > +
> > +        def addSample(threadName, stackArray, time):
> > +            nonlocal name
> > +            if name != threadName:
> > +                name = threadName
> > +            stack = reduce(lambda prefix, stackFrame: get_or_create_stack(get_or_create_frame(stackFrame), prefix), stackArray)
> > +            responsiveness = 0
> > +            samples['data'].append([stack, time, responsiveness])
> > +
> > +        def finish():
> > +            return {
> > +                "tid": tid,
> > +                "pid": pid,
> > +                "name": name,
> > +                "markers": markers,
> > +                "samples": samples,
> > +                "frameTable": frameTable,
> > +                "stackTable": stackTable,
> > +                "stringTable": stringTable,
> > +                "registerTime": 0,
> > +                "unregisterTime": None,
> > +                "processType": 'default'
> > +            }
> > +
> > +        return {
> > +            "addSample": addSample,
> > +            "finish": finish
> > +        }
> > +
> > +    threadMap = dict()
> > +    def _addThreadSample(pid, tid, threadName, time_stamp, stack):
> > +        thread = threadMap.get(tid)
> > +        if not thread:
> > +            thread = _createtread(pid, tid, threadName)
> > +            threadMap[tid] = thread
> > +        thread['addSample'](threadName, stack, time_stamp)
> > +
> > +    lines = profile.split('\n')
> > +
> > +    line_index = 0
> > +    start_time = 0
> > +    while line_index < len(lines):
> > +        line = lines[line_index]
> > +        line_index += 1
> > +        if line == '' or line.startswith('#'):
> > +            continue
> > +
> > +        sample_start_line = line
> > +
> > +        sample_start_match = re.match(r'^(.*)\s+([\d.]+):', sample_start_line)
> > +        if not sample_start_match:
> > +            print(f'Could not parse line as the start of a sample in the "perf script" profile format: "{sample_start_line}"')
> > +            continue
> > +
> > +        before_time_stamp = sample_start_match[1]
> > +        time_stamp = float(sample_start_match[2]) * 1000
> > +
> > +        threadNamePidAndTidMatch = re.match(r'^(.*)\s+(?:(\d+)\/)?(\d+)\b', before_time_stamp)
> > +
> > +        if not threadNamePidAndTidMatch:
> > +            print('Could not parse line as the start of a sample in the "perf script" profile format: "%s"' % sampleStartLine)
> > +            continue
> > +
> > +        threadName = threadNamePidAndTidMatch[1].strip()
> > +        pid = int(threadNamePidAndTidMatch[2] or 0)
> > +        tid = int(threadNamePidAndTidMatch[3] or 0)
> > +        startTime = 0 #workarround
> > +        if startTime == 0:
> > +            startTime = time_stamp
> > +        stack = []
> > +        while line_index < len(lines):
> > +            stackFrameLine = lines[line_index]
> > +            line_index += 1
> > +            if stackFrameLine.strip() == '':
> > +                break
> > +            stackFrameMatch = re.match(r'^\s*(\w+)\s*(.+) \(([^)]*)\)', stackFrameLine)
> > +            if stackFrameMatch:
> > +                rawFunc = stackFrameMatch[2]
> > +                mod = stackFrameMatch[3]
> > +                rawFunc = re.sub(r'\+0x[\da-f]+$', '', rawFunc)
> > +
> > +            if rawFunc.startswith('('):
> > +                continue # skip process names
> > +
> > +            if mod:
> > +               rawFunc += f' (in {mod})'
> > +
> > +            stack.append(rawFunc)
> > +        if len(stack) != 0:
> > +            stack.reverse()
> > +            _addThreadSample(pid, tid, threadName, time_stamp, stack)
> > +
> > +    thread_array = list(map(lambda thread: thread['finish'](), threadMap.values()))
> > +
> > +    for thread in thread_array:
> > +        key = thread['samples']['schema']['time']
> > +        thread['samples']['data'].sort(key=lambda data : float(data[key]))
> > +
> > +    return {
> > +    'meta': {
> > +        'interval': 1,
> > +        'processType': 0,
> > +        'product': 'Firefox',
> > +        'stackwalk': 1,
> > +        'debug': 0,
> > +        'gcpoison': 0,
> > +        'asyncstack': 1,
> > +        'startTime': startTime,
> > +        'shutdownTime': None,
> > +        'version': 24,
> > +        'presymbolicated': True,
> > +        'categories': CATEGORIES,
> > +        'markerSchema': []
> > +    },
> > +    'libs': [],
> > +    'threads': thread_array,
> > +    'processes': [],
> > +    'pausedRanges': []
> > +}
> > +
> > +def main():
> > +#    inputFile = input('Enter input file name: ')
> > +    with open('test.txt') as f:
> > +        profile = f.read()
> > +    isPerfScript = isPerfScriptFormat(profile)
> > +    output = convertPerfScriptProfile(profile)
> > +    json.dump(output, sys.stdout, indent=2)
> > +   #     print('isPerfScript: {}'.format(isPerfScript))
> > +
> > +if __name__ == '__main__':
> > +    main()
> > ------------------------>cut<---------------------------
> >
> > Thanks,
> > Anup
> >
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > > Thanks,
> > > > > > Anup
> > > > > >
> > > > > > [1] https://github.com/firefox-devtools/profiler/blob/main/docs-developer/custom-importer.md
> > > > > >
> > > > > > > > Thanks,
> > > > > > > > Ian
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Thank you for your support and I'm looking forward to collaborating with you on this project!
