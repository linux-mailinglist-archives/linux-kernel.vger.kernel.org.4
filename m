Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF60730911
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbjFNUSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbjFNUSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:18:08 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0062101
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:18:05 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f9d619103dso7091cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686773884; x=1689365884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqcLn1sc/X5tTK2sIkuLC3mzEYr1DrFTM0cheJvahSc=;
        b=w7TIvkcb4AvKEEmA46Bo6G7NyL9AowEczbGDSy8AFpfMZVToMzQ/h8eyf9xodXvofw
         SlEw7L1/F6XHbV5Ck4ZsMsNq1MkdJukulcqsOThvMRURdBUGv8aH1Fit+b0aOwqPcguC
         o9u+y/tz8ZSxjPWEyuFNuoYOCBjJWHbbV9PlED06sMAUsIBldmO2rphcY9hG4D3xhgxu
         YkKNF9HBkinSgfsI3Bki1lxXuCq9K1NehFz9jNQmDRyTEewPihPQdnTDSg975O8lo+JV
         CbRkuSF6dqtjC8iyA2Xt3Cek81EAUMKn3yeTQOjtbY6pHDwM9LgvkyEy/NjjYk3C7gZF
         LWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686773884; x=1689365884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqcLn1sc/X5tTK2sIkuLC3mzEYr1DrFTM0cheJvahSc=;
        b=Kn5rbmP5oYicA9dNcC8GEM8lE/3wQpLv8LpCWS+JGakh/zmWxMGFmdxp6xuEkBDPtP
         F+Tzjm99dnNBHxFdq4egmb7he0qkZ1BhFwwLsU4IwgEINnBQJ+UnpRFaYamabFIAFUlp
         jeS1IMAa0wjVRUcgSExbqHAho/BPAiYtT8wYh4kXIj4RBnPvEqA03teVeyiRXJzRPuj+
         Pp5kbhiwLZ3rlscknny0/5EqtGVPwZgdc7fPPRPTkfRcy9GTc7+Bu+x30DYxZAv/BJV0
         s4i8ta1gOI/sg6ZsLw0NBLzugWZJKk4h7oluMWECV3IxH+C6+qCzKA89rfjUBGeHne3v
         hpUA==
X-Gm-Message-State: AC+VfDzAo6Deh2aRqOmw2ASyCuz2bSGGY/LkIlHn1BkEhQ6VmJCxMT9e
        +F6noAD58IqQ6o93Jwm8OK2kTkLLfWOaF7xnnDrTrA==
X-Google-Smtp-Source: ACHHUZ7X5864chyHknpM2t89dFqVaT5HQ4KYBTYV+EWSiI3SPbnWm/MBQmNbY0XgQwaUF+Y02zJ/I+sxcMZt5ZKIVo4=
X-Received: by 2002:ac8:5a95:0:b0:3f9:a78f:c527 with SMTP id
 c21-20020ac85a95000000b003f9a78fc527mr43765qtc.21.1686773884374; Wed, 14 Jun
 2023 13:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <ZG5kjDN63HqqMuJJ@yoga> <CAM9d7ciUsJM1kZhGbhQUfdxq1rsvLig2C-mAki13a92EjW37kw@mail.gmail.com>
 <CAP-5=fVekEnC1s=xUG-jFeL20qM=EPNkPO8aw8bcg4cVM=m5wg@mail.gmail.com>
 <ZHENW4HOIo0F6FnN@yoga> <ZHkEWse0NVZhwKR7@yoga> <ZH5YBBWW5ANckoMp@yoga>
 <CAP-5=fU7ukrQSh_8OwH9C+a-EwCamCrMaZxjqDhE9f+bFJwQBQ@mail.gmail.com>
 <ZIHPXV5/ZopqcSSc@yoga> <ZIofrGKElc3nkNk0@yoga>
In-Reply-To: <ZIofrGKElc3nkNk0@yoga>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 13:17:52 -0700
Message-ID: <CAP-5=fV9tXNpYHH9DW0cVbRoFLGvG9SNn-MUhuyKuVBRuDqjoA@mail.gmail.com>
Subject: Re: [RFC] Adding Support for Firefox's Gecko Profile Format
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     linux-perf-users@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 1:14=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com=
> wrote:
>
> On Thu, Jun 08, 2023 at 06:23:49PM +0530, Anup Sharma wrote:
> > On Wed, Jun 07, 2023 at 11:58:57PM -0700, Ian Rogers wrote:
> > > On Mon, Jun 5, 2023 at 2:47=E2=80=AFPM Anup Sharma <anupnewsmail@gmai=
l.com> wrote:
> > > >
> > > > On Fri, Jun 02, 2023 at 02:19:30AM +0530, Anup Sharma wrote:
> > > > > On Sat, May 27, 2023 at 01:19:47AM +0530, Anup Sharma wrote:
> > > > > > On Fri, May 26, 2023 at 08:17:44AM -0700, Ian Rogers wrote:
> > > > > > > On Thu, May 25, 2023 at 1:53=E2=80=AFPM Namhyung Kim <namhyun=
g@kernel.org> wrote:
> > > > > > > >
> > > > > > > > Hi Anup,
> > > > > > > >
> > > > > > > > On Wed, May 24, 2023 at 12:25=E2=80=AFPM Anup Sharma <anupn=
ewsmail@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hello everyone,
> > > > > > > > >
> > > > > > > > > I'm happy to share that I'll be working on adding support=
 for Firefox's Gecko profile format.
> > > > > > > > > This format is utilized by the Firefox profiler, which is=
 a powerful tool for performance analysis
> > > > > > > > > and debugging. By enhancing the perf data command to gene=
rate perf.data files in the Gecko
> > > > > > > > > profile format, it will allow us to leverage the capabili=
ties of the Firefox profiler for visualizing
> > > > > > > > > and analyzing the performance data.
> > > > > > > > >
> > > > > > > > > As a starter task, I have created a test for testing the =
perf data JSON converter command.
> > > > > > > > > I'm also looking for a few more starter tasks related to =
this project. I would greatly appreciate
> > > > > > > > > your advice and guidance.
> > > > > > > > >
> > > > > > > > > In my effort to identify any existing bugs, I have enable=
d flags like 'fsanitize=3Daddress' to detect
> > > > > > > > > potential issues but have not found any :). Additionally,=
 I am running perf data commands to ensure
> > > > > > > > > that all use cases are handled properly.
> > > > > > > >
> > > > > > > > Great, good to know it works well with asan for the basic u=
se cases at least.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > I have one question regarding the installation process. T=
ypically, I navigate to the perf directory,
> > > > > > > > > run 'make', and then cp 'perf' to '/usr/bin'. However, I =
noticed that by default, perf is installed in
> > > > > > > > > the '~/bin/perf' directory. Could someone please clarify =
why this is the case? Furthermore, I would
> > > > > > > > > like to know how all of you compile the perf tree.
> > > > > > > >
> > > > > > > > I guess $HOME is the default prefix unless you set it to ot=
her, then
> > > > > > > > make install will put
> > > > > > > > the binary there.  You can make sure if your PATH contains =
the ~/bin and use it.
> > > > > > > >
> > > > > > > > But it's also possible you can run the perf without install=
ing.  I
> > > > > > > > have a symlink in
> > > > > > > > my tmp directory to point to the recent build of the binary=
 and use it
> > > > > > > > always. :)
> > > > > > > > To build, you can either 'cd tools/perf; make' or 'make -C =
tools/perf'
> > > > > > > > in the top
> > > > > > > > level linux source tree.  I also pass "BUILD_BPF_SKEL=3D1" =
to enable BPF.
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Namhyung
> > > > > > >
> > > > > > > I quite often test with address sanitizer, I do this by passi=
ng to make:
> > > > > > > DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g -fno-omit-frame- pointer
> > > > > > > -fsanitize=3Daddress" NO_LIBTRACEEVENT=3D1
> > > > > > >
> > > > > > > The libtraceevent exclusion is to avoid false address sanitiz=
er
> > > > > > > warnings in libtraceevent (it wasn't compiled with address sa=
nitizer).
> > > > > > > The other flags are to make the code easier to debug. A good =
place to
> > > > > > > start for a description of the build flags is Makefile.perf:
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.gi=
t/tree/tools/perf/Makefile.perf?h=3Dperf-tools-next
> > > > > > >
> > > > > > > There's also some description here:
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.gi=
t/tree/tools/perf/Documentation/Build.txt?h=3Dperf-tools-next
> > > > > > >
> > > > > > > Perhaps you can suggest improvements :-)
> > > > > > >
> > > > > >
> > > > > > Thanks Namhyung and Ian for your suggestions. I'll try them out=
 and let you know if I have any questions.
> > > > > >
> > > > >
> > > > > Hello all,
> > > > >
> > > > > Thank you for participating in today's office hours and helping m=
e clarify my doubts.
> > > > > One topic that emerged from our discussion is the choice of progr=
amming language
> > > > > for writing the converter. I am considering using Python as it of=
fers convenient
> > > > > libraries for JSON manipulation. However, I need to investigate w=
hether Python is
> > > > > enabled by default in most of the Linux distributions that ship w=
ith perf, as its
> > > > > absence could pose a potential obstacle.
> > > > >
> > > > > Additionally, two profile formats are available: Gecko profile fo=
rmat and Processed profile format[1].
> > > > > Upon discussing on Firefox Profiler matrix channel, they recommen=
ded opting for the Processed format,
> > > > > as it will be supported in future releases as well. Therefore, I =
intend to begin by working with the
> > > > > Processed format and evaluate the results. If any of you have sug=
gestions regarding the choice of
> > > > > format, I would greatly appreciate your input.
> > > > >
> > > > > Later on, I will address concerns I have regarding the file-loadi=
ng process.
> > > > > Once again, thank you all for your time.
> > > >
> > > > I wanted to provide an update on my exploration of various tools
> > > > and methods to generate a profiler format. In my experimentation, I
> > > > considered following command as a reference.
> > > >
> > > > perf record -F 99 -g -- perf test -w noploop
> > > >
> > > > The command generated perf.data file has been used with three
> > > > different tools to generate the required format and uploaded them t=
o
> > > > profiler.firefox.com. Interestingly, I noticed distinct call trees =
in
> > > > each of the three cases. I find myself in a state of confusion rega=
rding
> > > > which result to consider as a reference. Here are the outcomes:
> > > >
> > > >     1. Result obtained using perf script: https://share.firefox.dev=
/3qxEt7F
> > > >     2. Result obtained using samply:https://share.firefox.dev/3OZsh=
a2
> > > >     3. Result obtained using simpleperf gecko_profile_generator: ht=
tps://share.firefox.dev/45Q2BTe
> > > >
> > > > I would greatly appreciate any guidance or suggestions in this matt=
er.
> > >
> > > Hi Anup,
> > >
> > > of the 3 outcomes the perf script output looks best. Is the reason
> > > using the processed profile format? For the other two the major issue
> > > appears to be symbolization. Presumably with the first perf script is
> > > helping out. I'm not sure why the simpleperf stacks are truncated.
> > > Sorry to not be of more use, presumably you've looked into this more
> > > and we can discuss this in the office hours tomorrow.
> >
> > The issue does not appear to be related to the processed or gecko profi=
le format.
> > Despite specifying the path to the debug symbols using the -symfs optio=
n, the
> > simpleperf gecko_profile_generator script is unable to detect the debug=
 symbols
> > in my system. I have confirmed that the permissions are correct.
> >
> > Here is the basic output:
> >
> > root@yoga:/home/anup/perf/simpleperf/scripts# ./gecko_profile_generator=
.py -i
> > perf.data | gzip > profiler.gz
> > python3 W 06-08 18:13:27 160392 160392 dso.cpp:446] /usr/lib/x86_64-lin=
ux-gnu/
> > ld-linux-x86-64.so.2 doesn't contain symbol table
> > python3 W 06-08 18:13:27 160392 160392 dso.cpp:446] /usr/lib/x86_64-lin=
ux-gnu/
> > libc.so.6 doesn't contain symbol table
> >
>
> Hi All,
>
> I wanted to take a moment to provide you with an update on the progress
> of our Firefox Gecko converter work. While I must emphasize that the code
> I'm sharing is not the final version, I wanted to share the advancements
> I have made thus far.
>
> This script can generate a JSON format from the output of the "perf scrip=
t" command.
> I attempted to load this JSON file into profile.firefox.com, and although=
 it
> successfully loaded, the call tree are not visible. I'm certain this issu=
e
> is related to the format of the JSON file or if there is another underlyi=
ng
> cause. I will continue investigating to determine the cause of this probl=
em.

Great Anup, progress can be frustrating slow at first but it is a good
milestone to be generating output and having firefox profiler consume
it. You can open up the JavaScript console for the firefox profiler
and it will give some debug output. This should hopefully help you
make progress.

Thanks,
Ian

> ----------------------->cut<---------------------------
> diff --git a/tools/perf/scripts/python/gecko_converter.py b/tools/perf/sc=
ripts/python/gecko_converter.py
> new file mode 100644
> index 000000000000..7340ea4bd84e
> --- /dev/null
> +++ b/tools/perf/scripts/python/gecko_converter.py
> @@ -0,0 +1,236 @@
> +#!/usr/env/bin python3
> +import re
> +import sys
> +import json
> +from functools import reduce
> +
> +def isPerfScriptFormat(profile):
> +    if profile.startswith('{'):
> +        return False
> +
> +    firstLine =3D profile[:profile.index('\n')]
> +    return bool(re.match(r'^\S.*?\s+(?:\d+/)?\d+\s+(?:\d+\d+\s+)?[\d.]+:=
', firstLine))
> +
> +CATEGORIES =3D [
> +{'name': 'User', 'color': 'yellow', 'subcategories': ['Other']},
> +{'name': 'Kernel', 'color': 'orange', 'subcategories': ['Other']}
> +]
> +USER_CATEGORY_INDEX =3D 0
> +KERNEL_CATEGORY_INDEX =3D 1
> +
> +def convertPerfScriptProfile(profile):
> +    def _createtread(name, pid, tid):
> +        markers =3D {
> +            'schema': {
> +                'name': 0,
> +                'startTime': 1,
> +                'endTime': 2,
> +                'phase': 3,
> +                'category': 4,
> +                'data': 5,
> +            },
> +            'data': [],
> +        }
> +        samples =3D {
> +            'schema': {
> +                'stack': 0,
> +                'time': 1,
> +                'responsiveness': 2,
> +                },
> +            'data': [],
> +        }
> +        frameTable =3D {
> +            'schema': {
> +                'location': 0,
> +                'relevantForJS': 1,
> +                'innerWindowID': 2,
> +                'implementation': 3,
> +                'optimizations': 4,
> +                'line': 5,
> +                'column': 6,
> +                'category': 7,
> +                'subcategory': 8,
> +            },
> +            'data': [],
> +        }
> +        stackTable =3D {
> +            'schema': {
> +                'prefix': 0,
> +                'frame': 1,
> +            },
> +            'data': [],
> +        }
> +        stringTable =3D []
> +
> +        stackMap =3D dict()
> +        def get_or_create_stack(frame, prefix):
> +            key =3D f"{frame}" if prefix is None else f"{frame},{prefix}=
"
> +            stack =3D stackMap.get(key)
> +            if stack is None:
> +                stack =3D len(stackTable['data'])
> +                stackTable['data'].append([prefix, frame])
> +                stackMap[key] =3D stack
> +            return stack
> +
> +        frameMap =3D dict()
> +        def get_or_create_frame(frameString):
> +            frame =3D frameMap.get(frameString)
> +            if frame is None:
> +                frame =3D len(frameTable['data'])
> +                location =3D len(stringTable)
> +                stringTable.append(frameString)
> +                # print('batman', frame, frameString)
> +
> +                category =3D KERNEL_CATEGORY_INDEX if frameString.find('=
kallsyms') !=3D -1 or frameString.find('/vmlinux') !=3D 1 or frameString.en=
dswith('.ko)') else USER_CATEGORY_INDEX
> +                implementation =3D None
> +                optimizations =3D None
> +                line =3D None
> +                relevantForJS =3D False
> +                subcategory =3D None
> +                innerWindowID =3D 0
> +                column =3D None
> +
> +                frameTable['data'].append([
> +                    location,
> +                    relevantForJS,
> +                    innerWindowID,
> +                    implementation,
> +                    optimizations,
> +                    line,
> +                    column,
> +                    category,
> +                    subcategory,
> +                ])
> +                frameMap[frameString] =3D frame
> +            return frame
> +
> +        def addSample(threadName, stackArray, time):
> +            nonlocal name
> +            if name !=3D threadName:
> +                name =3D threadName
> +            stack =3D reduce(lambda prefix, stackFrame: get_or_create_st=
ack(get_or_create_frame(stackFrame), prefix), stackArray)
> +            responsiveness =3D 0
> +            samples['data'].append([stack, time, responsiveness])
> +
> +        def finish():
> +            return {
> +                "tid": tid,
> +                "pid": pid,
> +                "name": name,
> +                "markers": markers,
> +                "samples": samples,
> +                "frameTable": frameTable,
> +                "stackTable": stackTable,
> +                "stringTable": stringTable,
> +                "registerTime": 0,
> +                "unregisterTime": None,
> +                "processType": 'default'
> +            }
> +
> +        return {
> +            "addSample": addSample,
> +            "finish": finish
> +        }
> +
> +    threadMap =3D dict()
> +    def _addThreadSample(pid, tid, threadName, time_stamp, stack):
> +        thread =3D threadMap.get(tid)
> +        if not thread:
> +            thread =3D _createtread(pid, tid, threadName)
> +            threadMap[tid] =3D thread
> +        thread['addSample'](threadName, stack, time_stamp)
> +
> +    lines =3D profile.split('\n')
> +
> +    line_index =3D 0
> +    start_time =3D 0
> +    while line_index < len(lines):
> +        line =3D lines[line_index]
> +        line_index +=3D 1
> +        if line =3D=3D '' or line.startswith('#'):
> +            continue
> +
> +        sample_start_line =3D line
> +
> +        sample_start_match =3D re.match(r'^(.*)\s+([\d.]+):', sample_sta=
rt_line)
> +        if not sample_start_match:
> +            print(f'Could not parse line as the start of a sample in the=
 "perf script" profile format: "{sample_start_line}"')
> +            continue
> +
> +        before_time_stamp =3D sample_start_match[1]
> +        time_stamp =3D float(sample_start_match[2]) * 1000
> +
> +        threadNamePidAndTidMatch =3D re.match(r'^(.*)\s+(?:(\d+)\/)?(\d+=
)\b', before_time_stamp)
> +
> +        if not threadNamePidAndTidMatch:
> +            print('Could not parse line as the start of a sample in the =
"perf script" profile format: "%s"' % sampleStartLine)
> +            continue
> +
> +        threadName =3D threadNamePidAndTidMatch[1].strip()
> +        pid =3D int(threadNamePidAndTidMatch[2] or 0)
> +        tid =3D int(threadNamePidAndTidMatch[3] or 0)
> +        startTime =3D 0 #workarround
> +        if startTime =3D=3D 0:
> +            startTime =3D time_stamp
> +        stack =3D []
> +        while line_index < len(lines):
> +            stackFrameLine =3D lines[line_index]
> +            line_index +=3D 1
> +            if stackFrameLine.strip() =3D=3D '':
> +                break
> +            stackFrameMatch =3D re.match(r'^\s*(\w+)\s*(.+) \(([^)]*)\)'=
, stackFrameLine)
> +            if stackFrameMatch:
> +                rawFunc =3D stackFrameMatch[2]
> +                mod =3D stackFrameMatch[3]
> +                rawFunc =3D re.sub(r'\+0x[\da-f]+$', '', rawFunc)
> +
> +            if rawFunc.startswith('('):
> +                continue # skip process names
> +
> +            if mod:
> +               rawFunc +=3D f' (in {mod})'
> +
> +            stack.append(rawFunc)
> +        if len(stack) !=3D 0:
> +            stack.reverse()
> +            _addThreadSample(pid, tid, threadName, time_stamp, stack)
> +
> +    thread_array =3D list(map(lambda thread: thread['finish'](), threadM=
ap.values()))
> +
> +    for thread in thread_array:
> +        key =3D thread['samples']['schema']['time']
> +        thread['samples']['data'].sort(key=3Dlambda data : float(data[ke=
y]))
> +
> +    return {
> +    'meta': {
> +        'interval': 1,
> +        'processType': 0,
> +        'product': 'Firefox',
> +        'stackwalk': 1,
> +        'debug': 0,
> +        'gcpoison': 0,
> +        'asyncstack': 1,
> +        'startTime': startTime,
> +        'shutdownTime': None,
> +        'version': 24,
> +        'presymbolicated': True,
> +        'categories': CATEGORIES,
> +        'markerSchema': []
> +    },
> +    'libs': [],
> +    'threads': thread_array,
> +    'processes': [],
> +    'pausedRanges': []
> +}
> +
> +def main():
> +#    inputFile =3D input('Enter input file name: ')
> +    with open('test.txt') as f:
> +        profile =3D f.read()
> +    isPerfScript =3D isPerfScriptFormat(profile)
> +    output =3D convertPerfScriptProfile(profile)
> +    json.dump(output, sys.stdout, indent=3D2)
> +   #     print('isPerfScript: {}'.format(isPerfScript))
> +
> +if __name__ =3D=3D '__main__':
> +    main()
> ------------------------>cut<---------------------------
>
> Thanks,
> Anup
>
> > >
> > > Thanks,
> > > Ian
> > >
> > > > > Thanks,
> > > > > Anup
> > > > >
> > > > > [1] https://github.com/firefox-devtools/profiler/blob/main/docs-d=
eveloper/custom-importer.md
> > > > >
> > > > > > > Thanks,
> > > > > > > Ian
> > > > > > >
> > > > > > > > >
> > > > > > > > > Thank you for your support and I'm looking forward to col=
laborating with you on this project!
