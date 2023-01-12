Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE206686F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbjALWa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjALWab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:30:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC16C1C42A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:29:12 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id co23so19497340wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pIUGJQJXT7uAJK9rL+OANuyRzWTafDsxtBY6dlBM28U=;
        b=S2KM+t+Xqf3mM+UmiM+V4O8BlVfihVrwNQ8zJ+drt2PvqCBU5xpwViDSPNy+UHeyin
         RSj5HeXrxuyxf0625qaggePeIf269hiX4UtEGMQIa+QcHwXV2nbO9F25JMSCC0QzMqEu
         ilcLMK/sFuqYfVI5lI31Ad+PuAE0JZsd1U1VxlA4dIVRN6ykl24RXeqMZTFJSptZj/M5
         JPLCczWp/iKAH56CikF5+UCvZn9kdmktGJbLARpCkd14kypainxt+9av1v7U7Hs0mCpx
         b/jcjAHxp+t2OPjz5KV48sgcbJMJD5DFXqE91GkLuw34DHzYE46UMHoa3Daha1PoToIz
         BM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIUGJQJXT7uAJK9rL+OANuyRzWTafDsxtBY6dlBM28U=;
        b=gHUA25vkN82z7OwzwhDXepzl8Vj6Cy2mQhEEp14xRf69WSJFT0Tlj9JzvaFcd0NSCq
         045d7V1jXawhXzUxLIFEnDExNJYj1EmdHO+PBW3GT0pINnUIfnIyKy47d4/aB3zo9VQn
         gscnlfZqnYnsl1WfubLR40x8y0gHLuGLX3LBln1tTwDtpvle0FuYu8BRxM0C5s0Ep5Kq
         5ignH+sXqzGshaWts5bvAZD8CgAWSuAYbgaZqpAY8hFcb/pPob14X6BlgRKR8r9TZktD
         AQIxmWChrVwhikLMU6TC5e1+xAgdLsLTQVt+gcfB7R23Z80n1p3FvjfwF0seTK6FiglQ
         yoog==
X-Gm-Message-State: AFqh2kpEjm2oslck2GLY63a8Lbs82uyED+U0zQTyobABVj9uqCqEB8kl
        oEPImdycsn6g9SeucsJDOwaAw3HkDqKRfQbuoUYTKg==
X-Google-Smtp-Source: AMrXdXuk59tkjaxsrZqTV/bEecTF/E7i2WkpaBWHxTEHp9axL1d+/O/cV84Qn0onWPN1+EnWmo61W05NU/w+FvxF4tg=
X-Received: by 2002:adf:ec48:0:b0:2bd:df97:13f4 with SMTP id
 w8-20020adfec48000000b002bddf9713f4mr4740wrn.654.1673562551178; Thu, 12 Jan
 2023 14:29:11 -0800 (PST)
MIME-Version: 1.0
References: <20230105030434.255603-1-irogers@google.com> <CAP-5=fXi_9zdhTAoYApiFQoLURAvpEatFzU3uL23o3zs=z25ZQ@mail.gmail.com>
 <bd4a55a4-8e9c-82bf-92c8-1fa354289dce@redhat.com> <CAP-5=fX3LaJgft8T+nYV8SHpmoAOYZ9S5-pztKF9j--Um4HKDQ@mail.gmail.com>
 <928c76bf-39bc-cbc0-373e-70c5561cd5b0@redhat.com> <CAP-5=fWyE_cqumLFxrj_tncnhVSDpiN0cMij3iB_FMY9qmjNWw@mail.gmail.com>
 <68e8840e-d894-c211-184d-91a06c87579c@redhat.com>
In-Reply-To: <68e8840e-d894-c211-184d-91a06c87579c@redhat.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 12 Jan 2023 14:28:59 -0800
Message-ID: <CAP-5=fXQ01+ZvQDyD2q6wL2P6JfmnwRyEJHin1B4as9Hfq0GFw@mail.gmail.com>
Subject: Re: [PATCH v1] perf script flamegraph: Avoid d3-flame-graph package dependency
To:     Andreas Gerstmayr <agerstmayr@redhat.com>
Cc:     Michael Petlan <mpetlan@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Brendan Gregg <brendan@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        996839@bugs.debian.org, spiermar@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 10:08 AM Andreas Gerstmayr
<agerstmayr@redhat.com> wrote:
>
> On 11.01.23 18:13, Ian Rogers wrote:
> > On Wed, Jan 11, 2023 at 5:18 AM Andreas Gerstmayr <agerstmayr@redhat.com> wrote:
> >>
> >> On 10.01.23 20:51, Ian Rogers wrote:
> >>> On Tue, Jan 10, 2023 at 10:02 AM Andreas Gerstmayr
> >>> <agerstmayr@redhat.com> wrote:
> >>>>
> >>>> On 05.01.23 10:24, Ian Rogers wrote:
> >>>>> On Wed, Jan 4, 2023 at 7:04 PM Ian Rogers <irogers@google.com> wrote:
> >>>>>>
> >>>>>> Currently flame graph generation requires a d3-flame-graph template to
> >>>>>> be installed. Unfortunately this is hard to come by for things like
> >>>>>> Debian [1]. If the template isn't installed warn and download it from
> >>>>>> jsdelivr CDN. If downloading fails generate a minimal flame graph
> >>>>>> again with the javascript coming from jsdelivr CDN.
> >>>>>>
> >>>>>> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839
> >>>>>>
> >>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>>>
> >>>> I'm not entirely convinced that this perf script should make a network
> >>>> request. In my opinion
> >>>>
> >>>> * best would be if this template gets packaged in Debian
> >>>> * alternatively print instructions how to install the template:
> >>>>
> >>>>        sudo mkdir /usr/share/d3-flame-graph
> >>>>        sudo wget -O /usr/share/d3-flame-graph/d3-flamegraph-base.html
> >>>> https://cdn.jsdelivr.net/npm/d3-flame-graph@4/dist/templates/d3-flamegraph-base.html
> >>>>
> >>>> * or eventually just embed the entire template (66 KB) in the Python
> >>>> file (not sure if this is permissible though, it's basically a minified
> >>>> HTML/JS blob)?
> >>>> * if the above options don't work, I'd recommend asking the user before
> >>>> making the network request, and eventually persist the template
> >>>> somewhere so it doesn't need to be downloaded every time
> >>>>
> >>>> What do you think?
> >>>
> >>> So the script following this patch is going to try 3 things:
> >>> 1) look for a local template HTML,
> >>> 2) if a local template isn't found warn and switch to downloading the
> >>> CDN version,
> >>> 3) if the CDN version fails to download then use a minimal (embedded
> >>> in the script) HTML file with JS dependencies coming from the CDN.
> >>>
> >>> For (1) there are references in the generated HTML to www.w3.org,
> >>> meaning the HTML isn't fully hermetic - although these references may
> >>> not matter.
> >>
> >> The references to w3.org are XML namespace names. As far as I'm aware
> >> they do not matter, as they are merely identifiers and are never
> >> accessed [1,2]. Therefore the generated HTML file in its current form is
> >> hermetic.
> >>
> >> This was a design decision from the start - the flame graph generation
> >> and the resulting HTML file should not use any external resources loaded
> >> over the network (the external host could be inaccessible or compromised
> >> at any time). I understand that this requirement may not apply to every
> >> user or company.
> >>
> >>> For (2) there will be a download from the CDN of the template during
> >>> the execution of flamegraph. The template is better than (3) as it
> >>> features additional buttons letting you zoom out, etc. The HTML will
> >>> contain CDN references.
> >>> For (3) the generated HTML isn't hermetic and will use the CDN.
> >>>
> >>> For (2) we could give a prompt before trying to download the template,
> >>> or we could change it so that we give the wget command. I wouldn't
> >>> have the wget command require root privileges, I'd say that the
> >>> template could be downloaded and then the path of the download given
> >>> as an option to the flamegraph program. Downloading the file and then
> >>> adding an option to flamegraph seems inconvenient to the user,
> >>> something that the use of urllib in the patch avoids - it is
> >>> essentially just doing this for the user without storing the file on
> >>> disk. I think I prefer to be less inconvenient, and so the state of
> >>> the code at the moment looks best to me. Given that no choice results
> >>> in a fully hermetic HTML file, they seem similar in this regard. Is it
> >>> okay to try a download with urllib? Should there be a prompt? I think
> >>> the warning is enough and allows scripts, etc. using flamegraph to
> >>> more easily function across differing distributions.
> >>
> >> I fully agree, your changes make the flame graph generation more
> >> convenient in case the template is not installed. Also, downloading the
> >> template to a local directory and having to specify the path to the
> >> template every time is an inconvenience.
> >>
> >> I think it is a tradeoff between convenience and security/privacy.
> >> jsdelivr can get compromised, serving malicious JS (well, in that case,
> >> printing instructions to jsdelivr is also flawed :|).
> >> In the end it's up to the maintainers to decide.
> >
> > Agreed. It is something of an issue with the perf tool, I think noted
> > by Arnaldo and Linus, that it has too many dependencies. We also have
> > a problem that a number of dependencies aren't license compatible for
> > distribution with perf's GPLv2. flamegraph.py is always installed but
> > it carries a dependency that can't be satisfied on Debian and
> > everything deriving from it. The prompting to install a package
> > solution, as is generally used in the build, is one approach. Using
> > http rather than files is the approach this change introduces, and is
> > an approach advocated by the d3 flamegraph README.md. Perhaps package
> > maintainers like Michael and Ben have opinions here.
> >
> >>> An aside, Namhyung pointed out to me that there is a "perf report -g
> >>> folded" option, that was added in part to simplify creating
> >>> flamegraphs:
> >>> http://lkml.kernel.org/r/1447047946-1691-2-git-send-email-namhyung@kernel.org
> >>> Building off of perf report may improve/simplify the flamegraph code,
> >>> or avoid the requirement that libpython be linked against perf.
> >>
> >> Yep, in this case another tool is required to generate the flame graph
> >> visualization, for example [3].
> >
> > Thanks, perhaps [3] needs updating to use it as current processing
> > appears to be done using perf script:
> > https://github.com/brendangregg/FlameGraph/blob/master/stackcollapse-perf.pl
> >
> > I think users end up trying out flamegraph as they want something
> > easier to read than perf report and the command ships with the tool.
> > flamegraph is unique in being like this and it is a pity that the
> > Debian half of the world has difficulty making it work.
>
> Maybe someone with Debian packager rights could package the template
> [1]? Then it'd work the same way like with RPM-based distros, and it'll
> also work in environments without network access.

I chatted a little with Arnaldo and have sent out a v2 that adds the
prompt as well as an md5sum check on the downloaded file. PTAL:
https://lore.kernel.org/lkml/20230112220024.32709-1-irogers@google.com/

Thanks,
Ian

> > Fwiw, I'd like
> > to start adding documentation to the wiki about how to do easier
> > visualizations with other tools, such as the firefox profiler. Perhaps
> > some help from the tool also makes sense.
>
> +1
> I just tested the steps in the firefox profiler docs [2]. It looks great
> for power users, offering lots of different views, filtering and a
> timeline. There's also speedscope [3], which imho sits between the perf
> flamegraph script and the firefox profiler regarding functionality.
>
>
> [1]
> https://src.fedoraproject.org/rpms/js-d3-flame-graph/blob/f9efd0ec91e9b88a4f6d47c0e4817c758187b8d2/f/js-d3-flame-graph.spec#_78-85
> [2] https://profiler.firefox.com/docs/#/./guide-perf-profiling
> [3] https://github.com/jlfwong/speedscope
>
>
> Cheers,
> Andreas
>
> >
> > Thanks,
> > Ian
> >
> >
> >
> >>
> >> [1] https://www.w3.org/TR/xml-names11/
> >> [2] https://developer.mozilla.org/en-US/docs/Web/SVG/Namespaces_Crash_Course
> >> [3] https://github.com/brendangregg/FlameGraph
> >>
> >>
> >> Cheers,
> >> Andreas
> >>
> >>>
> >>> Thanks,
> >>> Ian
> >>>
> >>>
> >>>
> >>>
> >>>>
> >>>> Cheers,
> >>>> Andreas
> >>>>
> >>>>>> ---
> >>>>>>     tools/perf/scripts/python/flamegraph.py | 63 ++++++++++++++++++-------
> >>>>>>     1 file changed, 45 insertions(+), 18 deletions(-)
> >>>>>>
> >>>>>> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> >>>>>> index b6af1dd5f816..808b0e1c9be5 100755
> >>>>>> --- a/tools/perf/scripts/python/flamegraph.py
> >>>>>> +++ b/tools/perf/scripts/python/flamegraph.py
> >>>>>> @@ -25,6 +25,27 @@ import io
> >>>>>>     import argparse
> >>>>>>     import json
> >>>>>>     import subprocess
> >>>>>> +import urllib.request
> >>>>>> +
> >>>>>> +minimal_html = """<head>
> >>>>>> +  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
> >>>>>
> >>>>> (hopefully fixed Martin Spier's e-mail address)
> >>>>>
> >>>>> The @4.1.3 comes from the README.md:
> >>>>> https://github.com/spiermar/d3-flame-graph/blob/master/README.md
> >>>>> Does it make sense just to drop it or use @latest ? It'd be nice not
> >>>>> to patch this file for every d3-flame-graph update.
> >>>>>
> >>>>> Thanks,
> >>>>> Ian
> >>>>>
> >>>>>> +</head>
> >>>>>> +<body>
> >>>>>> +  <div id="chart"></div>
> >>>>>> +  <script type="text/javascript" src="https://d3js.org/d3.v7.js"></script>
> >>>>>> +  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
> >>>>>> +  <script type="text/javascript">
> >>>>>> +  const stacks = [/** @flamegraph_json **/];
> >>>>>> +  // Note, options is unused.
> >>>>>> +  const options = [/** @options_json **/];
> >>>>>> +
> >>>>>> +  var chart = flamegraph();
> >>>>>> +  d3.select("#chart")
> >>>>>> +        .datum(stacks[0])
> >>>>>> +        .call(chart);
> >>>>>> +  </script>
> >>>>>> +</body>
> >>>>>> +"""
> >>>>>>
> >>>>>>     # pylint: disable=too-few-public-methods
> >>>>>>     class Node:
> >>>>>> @@ -50,15 +71,18 @@ class FlameGraphCLI:
> >>>>>>             self.args = args
> >>>>>>             self.stack = Node("all", "root")
> >>>>>>
> >>>>>> -        if self.args.format == "html" and \
> >>>>>> -                not os.path.isfile(self.args.template):
> >>>>>> -            print("Flame Graph template {} does not exist. Please install "
> >>>>>> -                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
> >>>>>> -                  "package, specify an existing flame graph template "
> >>>>>> -                  "(--template PATH) or another output format "
> >>>>>> -                  "(--format FORMAT).".format(self.args.template),
> >>>>>> -                  file=sys.stderr)
> >>>>>> -            sys.exit(1)
> >>>>>> +        if self.args.format == "html":
> >>>>>> +            if os.path.isfile(self.args.template):
> >>>>>> +                self.template = f"file://{self.args.template}"
> >>>>>> +            else:
> >>>>>> +                print(f"""
> >>>>>> +Warning: Flame Graph template '{self.args.template}'
> >>>>>> +does not exist, a template will be downloaded via http. To avoid this
> >>>>>> +please install a package such as the js-d3-flame-graph or
> >>>>>> +libjs-d3-flame-graph, specify an existing flame graph template
> >>>>>> +(--template PATH) or another output format (--format FORMAT).
> >>>>>> +""", file=sys.stderr)
> >>>>>> +            self.template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
> >>>>>>
> >>>>>>         @staticmethod
> >>>>>>         def get_libtype_from_dso(dso):
> >>>>>> @@ -129,15 +153,18 @@ class FlameGraphCLI:
> >>>>>>                 options_json = json.dumps(options)
> >>>>>>
> >>>>>>                 try:
> >>>>>> -                with io.open(self.args.template, encoding="utf-8") as template:
> >>>>>> -                    output_str = (
> >>>>>> -                        template.read()
> >>>>>> -                        .replace("/** @options_json **/", options_json)
> >>>>>> -                        .replace("/** @flamegraph_json **/", stacks_json)
> >>>>>> -                    )
> >>>>>> -            except IOError as err:
> >>>>>> -                print("Error reading template file: {}".format(err), file=sys.stderr)
> >>>>>> -                sys.exit(1)
> >>>>>> +                with urllib.request.urlopen(self.template) as template:
> >>>>>> +                    output_str = '\n'.join([
> >>>>>> +                        l.decode('utf-8') for l in template.readlines()
> >>>>>> +                    ])
> >>>>>> +            except Exception as err:
> >>>>>> +                print(f"Error reading template {self.template}: {err}\n"
> >>>>>> +                      "a minimal flame graph will be generated", file=sys.stderr)
> >>>>>> +                output_str = minimal_html
> >>>>>> +
> >>>>>> +            output_str = output_str.replace("/** @options_json **/", options_json)
> >>>>>> +            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
> >>>>>> +
> >>>>>>                 output_fn = self.args.output or "flamegraph.html"
> >>>>>>             else:
> >>>>>>                 output_str = stacks_json
> >>>>>> --
> >>>>>> 2.39.0.314.g84b9a713c41-goog
> >>>>>>
> >>>>>
> >>>>
> >>>> --
> >>>> Red Hat Austria GmbH, Registered seat: A-1200 Vienna, Millennium Tower,
> >>>> 26.floor, Handelskai 94-96, Austria
> >>>> Commercial register: Commercial Court Vienna, FN 479668w
> >>>>
> >>>
> >>
> >> --
> >> Red Hat Austria GmbH, Registered seat: A-1200 Vienna, Millennium Tower,
> >> 26.floor, Handelskai 94-96, Austria
> >> Commercial register: Commercial Court Vienna, FN 479668w
> >>
> >
>
> --
> Red Hat Austria GmbH, Registered seat: A-1200 Vienna, Millennium Tower,
> 26.floor, Handelskai 94-96, Austria
> Commercial register: Commercial Court Vienna, FN 479668w
>
