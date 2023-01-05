Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C77D65E7B9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjAEJZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjAEJZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:25:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3046551C8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:25:08 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bn26so16027735wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 01:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJxb6YsgY1IN1CKBHgvi2wvMh1i9b0ozsEOL55ctxKY=;
        b=KLHUdbae1C0mOJLmF5TVe4FUxY2qoWxHG8Sccep6Tm9jZx6DMjOx2hYGQGf9LIDXtu
         jGwfrngwYsYzUWnRevcI0HDbXWCvCVWQLRJLEvUVqTi4/7MYnLZqNZUid9DMnQUKzHE/
         Q+/u4ayAe8Jbw1Lnpw2iQ4V3oHouUssuyV8ItGtHrcbYCSTHbfs40TQjlYn8rVha0oYV
         Efn6urBp1R3QgRAsntARKfKCQzW4PC3m43oOeZFf5pAWbWoNod/KX431WDSHLpjx0g/x
         eGRQZrXPFbCdHC4mzQGMAcT8fATNzgP53nZud6CKlU2ennELNZ9qB/ieIqy0obZb13QK
         6kBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJxb6YsgY1IN1CKBHgvi2wvMh1i9b0ozsEOL55ctxKY=;
        b=Myxqb7QTozGcod9wpjAd9Kqcq9WWQl4AgysTNB1dxmas2SgLg4DeIg1A6B+IxXDOxp
         tgDF697FLmXsIGs+6ckhj/ofoVp75H9WuZCJ8MQ7zLqL6Za1DZ+XJM/LgCMJfZP5TLc0
         dwPcFbPUG/WIJvwEYOePxKVXbB8+Zp6FZMmZfBRhG3LswofKG0BF639cpc7pg4ExtQC9
         pnpVIqSorYQH7voQJlZ0dzJLQtuNo8yCl8rUegBICEpu0W7nv8+IsgpFptKMVztc3J/T
         +5KZGpDHlJz434fVRqNGpjcCz7N3GcZV1vX8LICWHslBNIxWHkceekzQthzywHUzJB5R
         G8CQ==
X-Gm-Message-State: AFqh2kqj6H7Gu1h4p05gRyM+9KdKzscZgSR4W0VK/Kv22brYw6IoqAp0
        8jYhUxNZ/SqC9Ps6jHU/00xopuOky+bDkDKEpXwL+w==
X-Google-Smtp-Source: AMrXdXsLp2YpUcmt7erpbNWwK6ldTYDjBl1h/4EzlXdVs8ChUoD9mwCoNqX8Ibl8j+i7rry7XiqUP/TwWQBb6tbicYs=
X-Received: by 2002:a5d:4590:0:b0:27e:cf2e:ca4e with SMTP id
 p16-20020a5d4590000000b0027ecf2eca4emr759089wrq.343.1672910706943; Thu, 05
 Jan 2023 01:25:06 -0800 (PST)
MIME-Version: 1.0
References: <20230105030434.255603-1-irogers@google.com>
In-Reply-To: <20230105030434.255603-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 Jan 2023 01:24:54 -0800
Message-ID: <CAP-5=fXi_9zdhTAoYApiFQoLURAvpEatFzU3uL23o3zs=z25ZQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf script flamegraph: Avoid d3-flame-graph package dependency
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        996839@bugs.debian.org, Andreas Gerstmayr <agerstmayr@redhat.com>,
        Brendan Gregg <brendan@intel.com>, spiermar@gmail.com
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

On Wed, Jan 4, 2023 at 7:04 PM Ian Rogers <irogers@google.com> wrote:
>
> Currently flame graph generation requires a d3-flame-graph template to
> be installed. Unfortunately this is hard to come by for things like
> Debian [1]. If the template isn't installed warn and download it from
> jsdelivr CDN. If downloading fails generate a minimal flame graph
> again with the javascript coming from jsdelivr CDN.
>
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/scripts/python/flamegraph.py | 63 ++++++++++++++++++-------
>  1 file changed, 45 insertions(+), 18 deletions(-)
>
> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> index b6af1dd5f816..808b0e1c9be5 100755
> --- a/tools/perf/scripts/python/flamegraph.py
> +++ b/tools/perf/scripts/python/flamegraph.py
> @@ -25,6 +25,27 @@ import io
>  import argparse
>  import json
>  import subprocess
> +import urllib.request
> +
> +minimal_html = """<head>
> +  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">

(hopefully fixed Martin Spier's e-mail address)

The @4.1.3 comes from the README.md:
https://github.com/spiermar/d3-flame-graph/blob/master/README.md
Does it make sense just to drop it or use @latest ? It'd be nice not
to patch this file for every d3-flame-graph update.

Thanks,
Ian

> +</head>
> +<body>
> +  <div id="chart"></div>
> +  <script type="text/javascript" src="https://d3js.org/d3.v7.js"></script>
> +  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
> +  <script type="text/javascript">
> +  const stacks = [/** @flamegraph_json **/];
> +  // Note, options is unused.
> +  const options = [/** @options_json **/];
> +
> +  var chart = flamegraph();
> +  d3.select("#chart")
> +        .datum(stacks[0])
> +        .call(chart);
> +  </script>
> +</body>
> +"""
>
>  # pylint: disable=too-few-public-methods
>  class Node:
> @@ -50,15 +71,18 @@ class FlameGraphCLI:
>          self.args = args
>          self.stack = Node("all", "root")
>
> -        if self.args.format == "html" and \
> -                not os.path.isfile(self.args.template):
> -            print("Flame Graph template {} does not exist. Please install "
> -                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
> -                  "package, specify an existing flame graph template "
> -                  "(--template PATH) or another output format "
> -                  "(--format FORMAT).".format(self.args.template),
> -                  file=sys.stderr)
> -            sys.exit(1)
> +        if self.args.format == "html":
> +            if os.path.isfile(self.args.template):
> +                self.template = f"file://{self.args.template}"
> +            else:
> +                print(f"""
> +Warning: Flame Graph template '{self.args.template}'
> +does not exist, a template will be downloaded via http. To avoid this
> +please install a package such as the js-d3-flame-graph or
> +libjs-d3-flame-graph, specify an existing flame graph template
> +(--template PATH) or another output format (--format FORMAT).
> +""", file=sys.stderr)
> +            self.template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
>
>      @staticmethod
>      def get_libtype_from_dso(dso):
> @@ -129,15 +153,18 @@ class FlameGraphCLI:
>              options_json = json.dumps(options)
>
>              try:
> -                with io.open(self.args.template, encoding="utf-8") as template:
> -                    output_str = (
> -                        template.read()
> -                        .replace("/** @options_json **/", options_json)
> -                        .replace("/** @flamegraph_json **/", stacks_json)
> -                    )
> -            except IOError as err:
> -                print("Error reading template file: {}".format(err), file=sys.stderr)
> -                sys.exit(1)
> +                with urllib.request.urlopen(self.template) as template:
> +                    output_str = '\n'.join([
> +                        l.decode('utf-8') for l in template.readlines()
> +                    ])
> +            except Exception as err:
> +                print(f"Error reading template {self.template}: {err}\n"
> +                      "a minimal flame graph will be generated", file=sys.stderr)
> +                output_str = minimal_html
> +
> +            output_str = output_str.replace("/** @options_json **/", options_json)
> +            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
> +
>              output_fn = self.args.output or "flamegraph.html"
>          else:
>              output_str = stacks_json
> --
> 2.39.0.314.g84b9a713c41-goog
>
