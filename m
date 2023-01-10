Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACE6664CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjAJTvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjAJTvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:51:40 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A051C50E46
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:51:39 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id 186so8156496vsz.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1w2OJoXjBR0B8nOuaK35hGnXkeRm8nK9BoNjuo7/qeg=;
        b=oFVceod6LlE9oneZeW3yiuCd8rcfhBFXbzQwjOGtCTUcRNytHWcJqRXdmsdOlLRvZJ
         b0jnBx+bc6+TQbQewhT9blS1jV4nFXnN7KmdwwxPL4z/dHRiGi2wBVmTQjsy5bvdV5Sl
         /3BXZxFK43N5oJy3nv+kseBAhPkyL31stuqoXI4eXo8em1uQruyyja8N4M1tAeNDQk4K
         8jJEtXxRpr9ezudb8AlKy9WjXbgJaLSPTirEDIZiSgxg9q2lTeByweUfkKpw7B2qEf3m
         N9iBlQTgmbkYdaQh/zftGzU/93un9E0YTHcAqIpd9fibTWgp+AxJPWNsB2sc2+NT9Q2P
         NpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1w2OJoXjBR0B8nOuaK35hGnXkeRm8nK9BoNjuo7/qeg=;
        b=60yAajU7BfjtAXGlZX82MobIq8F1XfPwpxNL6fjZ7WNgDkABFGN582yPvNfdkvZcTr
         ZJqPhyX7ixC3cD4hK2FExUdgW2BKAdgaI6QDuyviKdleiwOr2Z2Li7FFzaFtn2RQWO1a
         P+/j9oc06GNMhCdpcdT45xAfPrvatKXuYSzkDD5rhX66WUcnWvkMymoBZrtb6MwI5MA1
         uvqUWYVEPkgxwBYX7x4jCwh8oZjBw/V8RUigCsP2Et21Pyztn+QFjy0qxU+WbXuANTP+
         W+ifLvA3QZC4XYtAKEO2NPntEk82y7toSnyOf7w+6rn6+qlvSK5U4WnbJK5DONUwcnPY
         ivvw==
X-Gm-Message-State: AFqh2krcc/cm/wvH1CENOj3a48SJLlfN6gVFuPbULXL2w02d2eKILQOR
        cBf239ROT+72sXYmlujyvOANdTpruGhlOLitXtOH8w==
X-Google-Smtp-Source: AMrXdXvkkTNbfCzuFJkaX44WWcXa9IfzlAb81ReeBK1G9plH5bFXNcyGY3Z09StM8T8s3K1ugNHVH8gWwzECYkzOa3M=
X-Received: by 2002:a67:b90e:0:b0:3cb:1128:2b18 with SMTP id
 q14-20020a67b90e000000b003cb11282b18mr6521371vsn.47.1673380298490; Tue, 10
 Jan 2023 11:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20230105030434.255603-1-irogers@google.com> <CAP-5=fXi_9zdhTAoYApiFQoLURAvpEatFzU3uL23o3zs=z25ZQ@mail.gmail.com>
 <bd4a55a4-8e9c-82bf-92c8-1fa354289dce@redhat.com>
In-Reply-To: <bd4a55a4-8e9c-82bf-92c8-1fa354289dce@redhat.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 10 Jan 2023 11:51:26 -0800
Message-ID: <CAP-5=fX3LaJgft8T+nYV8SHpmoAOYZ9S5-pztKF9j--Um4HKDQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf script flamegraph: Avoid d3-flame-graph package dependency
To:     Andreas Gerstmayr <agerstmayr@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        996839@bugs.debian.org, Brendan Gregg <brendan@intel.com>,
        spiermar@gmail.com
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

On Tue, Jan 10, 2023 at 10:02 AM Andreas Gerstmayr
<agerstmayr@redhat.com> wrote:
>
> On 05.01.23 10:24, Ian Rogers wrote:
> > On Wed, Jan 4, 2023 at 7:04 PM Ian Rogers <irogers@google.com> wrote:
> >>
> >> Currently flame graph generation requires a d3-flame-graph template to
> >> be installed. Unfortunately this is hard to come by for things like
> >> Debian [1]. If the template isn't installed warn and download it from
> >> jsdelivr CDN. If downloading fails generate a minimal flame graph
> >> again with the javascript coming from jsdelivr CDN.
> >>
> >> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839
> >>
> >> Signed-off-by: Ian Rogers <irogers@google.com>
>
> I'm not entirely convinced that this perf script should make a network
> request. In my opinion
>
> * best would be if this template gets packaged in Debian
> * alternatively print instructions how to install the template:
>
>      sudo mkdir /usr/share/d3-flame-graph
>      sudo wget -O /usr/share/d3-flame-graph/d3-flamegraph-base.html
> https://cdn.jsdelivr.net/npm/d3-flame-graph@4/dist/templates/d3-flamegraph-base.html
>
> * or eventually just embed the entire template (66 KB) in the Python
> file (not sure if this is permissible though, it's basically a minified
> HTML/JS blob)?
> * if the above options don't work, I'd recommend asking the user before
> making the network request, and eventually persist the template
> somewhere so it doesn't need to be downloaded every time
>
> What do you think?

So the script following this patch is going to try 3 things:
1) look for a local template HTML,
2) if a local template isn't found warn and switch to downloading the
CDN version,
3) if the CDN version fails to download then use a minimal (embedded
in the script) HTML file with JS dependencies coming from the CDN.

For (1) there are references in the generated HTML to www.w3.org,
meaning the HTML isn't fully hermetic - although these references may
not matter.
For (2) there will be a download from the CDN of the template during
the execution of flamegraph. The template is better than (3) as it
features additional buttons letting you zoom out, etc. The HTML will
contain CDN references.
For (3) the generated HTML isn't hermetic and will use the CDN.

For (2) we could give a prompt before trying to download the template,
or we could change it so that we give the wget command. I wouldn't
have the wget command require root privileges, I'd say that the
template could be downloaded and then the path of the download given
as an option to the flamegraph program. Downloading the file and then
adding an option to flamegraph seems inconvenient to the user,
something that the use of urllib in the patch avoids - it is
essentially just doing this for the user without storing the file on
disk. I think I prefer to be less inconvenient, and so the state of
the code at the moment looks best to me. Given that no choice results
in a fully hermetic HTML file, they seem similar in this regard. Is it
okay to try a download with urllib? Should there be a prompt? I think
the warning is enough and allows scripts, etc. using flamegraph to
more easily function across differing distributions.

An aside, Namhyung pointed out to me that there is a "perf report -g
folded" option, that was added in part to simplify creating
flamegraphs:
http://lkml.kernel.org/r/1447047946-1691-2-git-send-email-namhyung@kernel.org
Building off of perf report may improve/simplify the flamegraph code,
or avoid the requirement that libpython be linked against perf.

Thanks,
Ian




>
> Cheers,
> Andreas
>
> >> ---
> >>   tools/perf/scripts/python/flamegraph.py | 63 ++++++++++++++++++-------
> >>   1 file changed, 45 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> >> index b6af1dd5f816..808b0e1c9be5 100755
> >> --- a/tools/perf/scripts/python/flamegraph.py
> >> +++ b/tools/perf/scripts/python/flamegraph.py
> >> @@ -25,6 +25,27 @@ import io
> >>   import argparse
> >>   import json
> >>   import subprocess
> >> +import urllib.request
> >> +
> >> +minimal_html = """<head>
> >> +  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
> >
> > (hopefully fixed Martin Spier's e-mail address)
> >
> > The @4.1.3 comes from the README.md:
> > https://github.com/spiermar/d3-flame-graph/blob/master/README.md
> > Does it make sense just to drop it or use @latest ? It'd be nice not
> > to patch this file for every d3-flame-graph update.
> >
> > Thanks,
> > Ian
> >
> >> +</head>
> >> +<body>
> >> +  <div id="chart"></div>
> >> +  <script type="text/javascript" src="https://d3js.org/d3.v7.js"></script>
> >> +  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
> >> +  <script type="text/javascript">
> >> +  const stacks = [/** @flamegraph_json **/];
> >> +  // Note, options is unused.
> >> +  const options = [/** @options_json **/];
> >> +
> >> +  var chart = flamegraph();
> >> +  d3.select("#chart")
> >> +        .datum(stacks[0])
> >> +        .call(chart);
> >> +  </script>
> >> +</body>
> >> +"""
> >>
> >>   # pylint: disable=too-few-public-methods
> >>   class Node:
> >> @@ -50,15 +71,18 @@ class FlameGraphCLI:
> >>           self.args = args
> >>           self.stack = Node("all", "root")
> >>
> >> -        if self.args.format == "html" and \
> >> -                not os.path.isfile(self.args.template):
> >> -            print("Flame Graph template {} does not exist. Please install "
> >> -                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
> >> -                  "package, specify an existing flame graph template "
> >> -                  "(--template PATH) or another output format "
> >> -                  "(--format FORMAT).".format(self.args.template),
> >> -                  file=sys.stderr)
> >> -            sys.exit(1)
> >> +        if self.args.format == "html":
> >> +            if os.path.isfile(self.args.template):
> >> +                self.template = f"file://{self.args.template}"
> >> +            else:
> >> +                print(f"""
> >> +Warning: Flame Graph template '{self.args.template}'
> >> +does not exist, a template will be downloaded via http. To avoid this
> >> +please install a package such as the js-d3-flame-graph or
> >> +libjs-d3-flame-graph, specify an existing flame graph template
> >> +(--template PATH) or another output format (--format FORMAT).
> >> +""", file=sys.stderr)
> >> +            self.template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
> >>
> >>       @staticmethod
> >>       def get_libtype_from_dso(dso):
> >> @@ -129,15 +153,18 @@ class FlameGraphCLI:
> >>               options_json = json.dumps(options)
> >>
> >>               try:
> >> -                with io.open(self.args.template, encoding="utf-8") as template:
> >> -                    output_str = (
> >> -                        template.read()
> >> -                        .replace("/** @options_json **/", options_json)
> >> -                        .replace("/** @flamegraph_json **/", stacks_json)
> >> -                    )
> >> -            except IOError as err:
> >> -                print("Error reading template file: {}".format(err), file=sys.stderr)
> >> -                sys.exit(1)
> >> +                with urllib.request.urlopen(self.template) as template:
> >> +                    output_str = '\n'.join([
> >> +                        l.decode('utf-8') for l in template.readlines()
> >> +                    ])
> >> +            except Exception as err:
> >> +                print(f"Error reading template {self.template}: {err}\n"
> >> +                      "a minimal flame graph will be generated", file=sys.stderr)
> >> +                output_str = minimal_html
> >> +
> >> +            output_str = output_str.replace("/** @options_json **/", options_json)
> >> +            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
> >> +
> >>               output_fn = self.args.output or "flamegraph.html"
> >>           else:
> >>               output_str = stacks_json
> >> --
> >> 2.39.0.314.g84b9a713c41-goog
> >>
> >
>
> --
> Red Hat Austria GmbH, Registered seat: A-1200 Vienna, Millennium Tower,
> 26.floor, Handelskai 94-96, Austria
> Commercial register: Commercial Court Vienna, FN 479668w
>
