Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788216715BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjARH7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjARHxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:33 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36C559B56
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:29:21 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bk16so32941471wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rNY6RUE7FrzMgk+W6uGQYyeAqKjNTh5GfoEKMQE7LIA=;
        b=BqwsXWjmor6T0iJs9NLN0UA/EU66Fs3EoT1AELZcOObjlaU9QcePahWtF2yg9U2q7Q
         55TeYlBUHbSZNzM7Ztrc4GRf0b1W6c/1PH6Ob1FPhlSkTcJo4CBvHkKe3g3LGJEyYw+q
         RxCvLq6fF6mF3qOichTFdKVg0LW3Ibx0cCL0aTqEi4ZxXrQIfy0xPhSEPqGECBzOR8rD
         XLr82gDHO/VQc/cxcqYg0jlZOB8L7XOsM3IurMzVYLFrenDlIj9eW7KBL4bZ/qujNgWZ
         zCKA9c+WTfOqVX7O5LeXMt9pFJi7MniR7lDpo5kGR7nDfcjGVuS68+7ZMBWoSRI//yY5
         qwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNY6RUE7FrzMgk+W6uGQYyeAqKjNTh5GfoEKMQE7LIA=;
        b=pGwxIkwPM2CBVV+R0F0LIMF0Xk9ARiA+v901T8Z9iTPxmkqvcTeh2xwtXbA+JbsGmj
         FFVLUJxSUqSKYHqC4Pm5/8lYCgox/sFAGLD3XJyifs1Lhvt2bmOFipoyrIoCuD3pKW+a
         hvwgoPE/UMQogvNwsUAQo8mu5DlhFLpzGrPb2k4d0scldadX9eCAQZRc5pUyjes0rMvX
         ARct+ZkK7v84cTcr73r5YKJzQKLjPu5hlnJOMOf+mu2q7Ttv0tpzisxyPjDJHx9PzQAz
         kIhNUW/BacAvIUDbmv/553Gl5OUudnx0lV6v9RofLTyxMfGuuYAImaaasP6E6B2FbIrs
         Li6w==
X-Gm-Message-State: AFqh2ko7nC9qANGayDC0Q8mb8dM9WHE9OlmjGwFMO80e0GJnOyR6sVA7
        c/i+X5jeXJjE1BOA7OW+apqXzQ1SsZLBVWTKR7vDrANaU+VIeg==
X-Google-Smtp-Source: AMrXdXuw8yKdqSiq4l4w+/L3BrlumqSU8yZ9jgdGz1PAZxgQczucKPlDmrt6DLm+obCadLEht1/9+f7rGxZzRS22VR0=
X-Received: by 2002:a05:6000:5c6:b0:242:5caa:5fbf with SMTP id
 bh6-20020a05600005c600b002425caa5fbfmr143326wrb.300.1674026959721; Tue, 17
 Jan 2023 23:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20230112220024.32709-1-irogers@google.com> <2568dad8-88b4-ebf9-3013-73cc6becdc1c@redhat.com>
In-Reply-To: <2568dad8-88b4-ebf9-3013-73cc6becdc1c@redhat.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 17 Jan 2023 23:29:07 -0800
Message-ID: <CAP-5=fW+jpi_iLCrpA2GeEQBzNYASF52qrX7ExrSNL82uaDREQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf script flamegraph: Avoid d3-flame-graph package dependency
To:     Andreas Gerstmayr <agerstmayr@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        996839@bugs.debian.org, Martin Spier <spiermar@gmail.com>,
        Brendan Gregg <brendan@intel.com>
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

On Tue, Jan 17, 2023 at 7:17 AM Andreas Gerstmayr <agerstmayr@redhat.com> wrote:
>
> On 12.01.23 23:00, Ian Rogers wrote:
> > Currently flame graph generation requires a d3-flame-graph template to
> > be installed. Unfortunately this is hard to come by for things like
> > Debian [1]. If the template isn't installed then ask if it should be
> > downloaded from jsdelivr CDN. The downloaded HTML file is validated
> > against an md5sum. If the download fails, generate a minimal flame
> > graph with the javascript coming from links to jsdelivr CDN.
> >
> > v2. Change the warning to a prompt about downloading and add the
> >      --allow-download command line flag. Add an md5sum check for the
> >      downloaded HTML.
> >
> > [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Thank you for the changes. I've tested v2 with:
>
> * d3-flame-graph package installed
> * template not installed, download template from jsdelivr
> * download from jsdelivr, with --allow-download
> * invalid checksum
> * unreachable jsdelivr, creating a minimal template
>
> Everything works great except when I'm invoking "perf script flamegraph
> -a -F 99 sleep 10" (combining perf report + perf script):
>
> [root@agerstmayr-thinkpad tmp]# perf script flamegraph -a -F 99 sleep 10
> ------------------------------------------------------------
> [...]
> ------------------------------------------------------------
> Warning: Flame Graph template
> '/usr/share/d3-flame-graph/d3-flamegraph-base.html'
> does not exist. To avoid this please install a package such as the
> js-d3-flame-graph or libjs-d3-flame-graph, specify an existing flame
> graph template (--template PATH) or use another output format (--format
> FORMAT).
> Do you wish to download a template from cdn.jsdelivr.net? (this warning
> can be suppressed with --allow-download) [yn] Traceback (most recent
> call last):
>    File "/usr/libexec/perf-core/scripts/python/flamegraph.py", line 157,
> in trace_end
>      s = input("Do you wish to download a template from
> cdn.jsdelivr.net? (this warning can be suppressed with --allow-download)
> [yn] ").lower()
>
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> OSError: [Errno 9] Bad file descriptor
> Fatal Python error: handler_call_die: problem in Python trace event handler
> Python runtime state: initialized
>
> Current thread 0x00007ff4053a3cc0 (most recent call first):
>    <no Python frame>
>
> Extension modules: systemd._journal, systemd._reader, systemd.id128
> (total: 3)
> /usr/libexec/perf-core/scripts/python/bin/flamegraph-report: line 3:
> 2135491 Aborted                 (core dumped) perf script -s
> "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
>
>
> iirc when running "perf script flamegraph" the perf.data gets piped to
> stdin of the flamegraph script, so we can't ask the user in this case.
> You can check this condition with `self.args.input == "-". Not sure
> what's the best action in this case, maybe just exit?

Thanks Andreas,

There's no way to handle command line arguments to the script in
"live" mode and so I sent a v3 where the script warns and then
quit()s. The only other option would have been to assume downloading,
and we'd agreed to avoid that. Hopefully v3 is in the right shape now.

Thanks again,
Ian

>
> Cheers,
> Andreas
>
>
> > ---
> >   tools/perf/scripts/python/flamegraph.py | 96 +++++++++++++++++++------
> >   1 file changed, 74 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> > index b6af1dd5f816..086619053e4e 100755
> > --- a/tools/perf/scripts/python/flamegraph.py
> > +++ b/tools/perf/scripts/python/flamegraph.py
> > @@ -19,12 +19,34 @@
> >   # pylint: disable=missing-function-docstring
> >
> >   from __future__ import print_function
> > -import sys
> > -import os
> > -import io
> >   import argparse
> > +import hashlib
> > +import io
> >   import json
> > +import os
> >   import subprocess
> > +import sys
> > +import urllib.request
> > +
> > +minimal_html = """<head>
> > +  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
> > +</head>
> > +<body>
> > +  <div id="chart"></div>
> > +  <script type="text/javascript" src="https://d3js.org/d3.v7.js"></script>
> > +  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
> > +  <script type="text/javascript">
> > +  const stacks = [/** @flamegraph_json **/];
> > +  // Note, options is unused.
> > +  const options = [/** @options_json **/];
> > +
> > +  var chart = flamegraph();
> > +  d3.select("#chart")
> > +        .datum(stacks[0])
> > +        .call(chart);
> > +  </script>
> > +</body>
> > +"""
> >
> >   # pylint: disable=too-few-public-methods
> >   class Node:
> > @@ -50,16 +72,6 @@ class FlameGraphCLI:
> >           self.args = args
> >           self.stack = Node("all", "root")
> >
> > -        if self.args.format == "html" and \
> > -                not os.path.isfile(self.args.template):
> > -            print("Flame Graph template {} does not exist. Please install "
> > -                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
> > -                  "package, specify an existing flame graph template "
> > -                  "(--template PATH) or another output format "
> > -                  "(--format FORMAT).".format(self.args.template),
> > -                  file=sys.stderr)
> > -            sys.exit(1)
> > -
> >       @staticmethod
> >       def get_libtype_from_dso(dso):
> >           """
> > @@ -128,16 +140,52 @@ class FlameGraphCLI:
> >               }
> >               options_json = json.dumps(options)
> >
> > +            template_md5sum = None
> > +            if self.args.format == "html":
> > +                if os.path.isfile(self.args.template):
> > +                    template = f"file://{self.args.template}"
> > +                else:
> > +                    if not self.args.allow_download:
> > +                        print(f"""Warning: Flame Graph template '{self.args.template}'
> > +does not exist. To avoid this please install a package such as the
> > +js-d3-flame-graph or libjs-d3-flame-graph, specify an existing flame
> > +graph template (--template PATH) or use another output format (--format
> > +FORMAT).""",
> > +                              file=sys.stderr)
> > +                        s = None
> > +                        while s != "y" and s != "n":
> > +                            s = input("Do you wish to download a template from cdn.jsdelivr.net? (this warning can be suppressed with --allow-download) [yn] ").lower()
> > +                        if s == "n":
> > +                            quit()
> > +                    template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
> > +                    template_md5sum = "143e0d06ba69b8370b9848dcd6ae3f36"
> > +
> >               try:
> > -                with io.open(self.args.template, encoding="utf-8") as template:
> > -                    output_str = (
> > -                        template.read()
> > -                        .replace("/** @options_json **/", options_json)
> > -                        .replace("/** @flamegraph_json **/", stacks_json)
> > -                    )
> > -            except IOError as err:
> > -                print("Error reading template file: {}".format(err), file=sys.stderr)
> > -                sys.exit(1)
> > +                with urllib.request.urlopen(template) as template:
> > +                    output_str = "".join([
> > +                        l.decode("utf-8") for l in template.readlines()
> > +                    ])
> > +            except Exception as err:
> > +                print(f"Error reading template {template}: {err}\n"
> > +                      "a minimal flame graph will be generated", file=sys.stderr)
> > +                output_str = minimal_html
> > +                template_md5sum = None
> > +
> > +            if template_md5sum:
> > +                download_md5sum = hashlib.md5(output_str.encode("utf-8")).hexdigest()
> > +                if download_md5sum != template_md5sum:
> > +                    s = None
> > +                    while s != "y" and s != "n":
> > +                        s = input(f"""Unexpected template md5sum.
> > +{download_md5sum} != {template_md5sum}, for:
> > +{output_str}
> > +continue?[yn] """).lower()
> > +                    if s == "n":
> > +                        quit()
> > +
> > +            output_str = output_str.replace("/** @options_json **/", options_json)
> > +            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
> > +
> >               output_fn = self.args.output or "flamegraph.html"
> >           else:
> >               output_str = stacks_json
> > @@ -172,6 +220,10 @@ if __name__ == "__main__":
> >                           choices=["blue-green", "orange"])
> >       parser.add_argument("-i", "--input",
> >                           help=argparse.SUPPRESS)
> > +    parser.add_argument("--allow-download",
> > +                        default=False,
> > +                        action="store_true",
> > +                        help="allow unprompted downloading of HTML template")
> >
> >       cli_args = parser.parse_args()
> >       cli = FlameGraphCLI(cli_args)
>
> --
> Red Hat Austria GmbH, Registered seat: A-1200 Vienna, Millennium Tower,
> 26.floor, Handelskai 94-96, Austria
> Commercial register: Commercial Court Vienna, FN 479668w
>
