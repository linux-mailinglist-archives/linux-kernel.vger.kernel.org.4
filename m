Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F701672231
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjARPzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjARPyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:54:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12FD4DE32
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674057033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kgYqGftpEGZz+nVlMbD31Pa4IzVL9LK66lldVqRNb7c=;
        b=Eym/6x5bSo9F+RkmhFm/7G6kwy5asrk1+104O5Pt84IUgXRH6Rq7EuzO9bnwAhX7GKR4cV
        aAXFJMEwUXCb8F87WNLkDxkCpU19krqoaXYa9euOXvyR4N49QgmLY5y50TmOuCyIz5IFvi
        /pe8InnO/LQiKpGZYXyWoVLSdMwyFQI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-eBqDeZwKMB-FRUqcg9Kijw-1; Wed, 18 Jan 2023 10:50:31 -0500
X-MC-Unique: eBqDeZwKMB-FRUqcg9Kijw-1
Received: by mail-ed1-f71.google.com with SMTP id m7-20020a056402510700b00488d1fcdaebso23668624edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:50:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgYqGftpEGZz+nVlMbD31Pa4IzVL9LK66lldVqRNb7c=;
        b=8P1GJ7dYtUI2wIz8siOSnWX7GdBZXRbWrbK8022biZP5D1oK0RobOWaZ3L37lH3XBP
         uydabeqj/n/1Huw+mb/gKmoLK4ihS2alNEzUocmQVo3uD1Q4LwMdBItEFEYIKab6HnGO
         jRKZHVMbKJRF486OkzNRgkzPrhYUCBpbFWKNYVgXuijKdjJ+pNfCMvqTzsT1H6i2n5kC
         SoOXPeFCDi3FHS0D0PqKyZ7mAeQtd6ENXhfb3iPyAtBglRh4Y5IPKkkcSe6P8S5IPwM2
         fOdRWwAASiQWS/Jq8meY7tiCtO/I/TXIohgvw7E6Io155BtLrAuMRbswPXBHGXs3lPBU
         8sIw==
X-Gm-Message-State: AFqh2kqCsKsf8m2T0wDRtiuRY/tNSM/zFPAYjVJqp2hC3jTax05kiBVZ
        16eYoymYMr4c+p7BlLbCLjDgU+QSRCC6v8Fuv1q6xsS2w9r4lQgX0dF8pkWH5ziGoFYjDXuN8mr
        y3FxkfjKfrZKVdcAJKlodFDx7
X-Received: by 2002:a05:6402:e81:b0:498:9793:785b with SMTP id h1-20020a0564020e8100b004989793785bmr8448155eda.3.1674057030753;
        Wed, 18 Jan 2023 07:50:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuw982CP6OF7sXpPXF66Ak+EVGD7JgT//Xh3g/Uj3KPeS7JtOd63aiKaOMC+0k0mDSUC0/D7Q==
X-Received: by 2002:a05:6402:e81:b0:498:9793:785b with SMTP id h1-20020a0564020e8100b004989793785bmr8448134eda.3.1674057030499;
        Wed, 18 Jan 2023 07:50:30 -0800 (PST)
Received: from [192.168.31.129] (84-115-237-15.cable.dynamic.surfer.at. [84.115.237.15])
        by smtp.gmail.com with ESMTPSA id k24-20020a1709065fd800b0087329ff5922sm2195887ejv.139.2023.01.18.07.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 07:50:30 -0800 (PST)
Message-ID: <9dff0701-06f8-e759-7485-1f2b8a77631b@redhat.com>
Date:   Wed, 18 Jan 2023 16:50:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] perf script flamegraph: Avoid d3-flame-graph package
 dependency
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        996839@bugs.debian.org, Martin Spier <spiermar@gmail.com>,
        Brendan Gregg <brendan@intel.com>
References: <20230118072409.147786-1-irogers@google.com>
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
In-Reply-To: <20230118072409.147786-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.01.23 08:24, Ian Rogers wrote:
> Currently flame graph generation requires a d3-flame-graph template to
> be installed. Unfortunately this is hard to come by for things like
> Debian [1]. If the template isn't installed then ask if it should be
> downloaded from jsdelivr CDN. The downloaded HTML file is validated
> against an md5sum. If the download fails, generate a minimal flame
> graph with the javascript coming from links to jsdelivr CDN.
> 
> v3. Adds a warning message and quits before download in live mode.
> v2. Change the warning to a prompt about downloading and add the
>      --allow-download command line flag. Add an md5sum check for the
>      downloaded HTML.
> 
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---

I've tested the new functionality on Fedora 37 and everything works.

On second thought, now the flame graph script will not only also work on 
Debian (and derivatives), but on all distributions without needing a new 
package for each distribution. That's a great improvement - thank you 
for the changes!

Reviewed-by: Andreas Gerstmayr <agerstmayr@redhat.com>


Thanks,
Andreas



>   tools/perf/scripts/python/flamegraph.py | 107 +++++++++++++++++++-----
>   1 file changed, 85 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> index b6af1dd5f816..cf7ce8229a6c 100755
> --- a/tools/perf/scripts/python/flamegraph.py
> +++ b/tools/perf/scripts/python/flamegraph.py
> @@ -19,12 +19,34 @@
>   # pylint: disable=missing-function-docstring
>   
>   from __future__ import print_function
> -import sys
> -import os
> -import io
>   import argparse
> +import hashlib
> +import io
>   import json
> +import os
>   import subprocess
> +import sys
> +import urllib.request
> +
> +minimal_html = """<head>
> +  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
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
>   # pylint: disable=too-few-public-methods
>   class Node:
> @@ -50,16 +72,6 @@ class FlameGraphCLI:
>           self.args = args
>           self.stack = Node("all", "root")
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
> -
>       @staticmethod
>       def get_libtype_from_dso(dso):
>           """
> @@ -128,16 +140,63 @@ class FlameGraphCLI:
>               }
>               options_json = json.dumps(options)
>   
> +            template_md5sum = None
> +            if self.args.format == "html":
> +                if os.path.isfile(self.args.template):
> +                    template = f"file://{self.args.template}"
> +                else:
> +                    if not self.args.allow_download:
> +                        print(f"""Warning: Flame Graph template '{self.args.template}'
> +does not exist. To avoid this please install a package such as the
> +js-d3-flame-graph or libjs-d3-flame-graph, specify an existing flame
> +graph template (--template PATH) or use another output format (--format
> +FORMAT).""",
> +                              file=sys.stderr)
> +                        if self.args.input == "-":
> +                            print("""Not attempting to download Flame Graph template as script command line
> +input is disabled due to using live mode. If you want to download the
> +template retry without live mode. For example, use 'perf record -a -g
> +-F 99 sleep 60' and 'perf script report flamegraph'. Alternatively,
> +download the template from:
> +https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html
> +and place it at:
> +/usr/share/d3-flame-graph/d3-flamegraph-base.html""",
> +                                  file=sys.stderr)
> +                            quit()
> +                        s = None
> +                        while s != "y" and s != "n":
> +                            s = input("Do you wish to download a template from cdn.jsdelivr.net? (this warning can be suppressed with --allow-download) [yn] ").lower()
> +                        if s == "n":
> +                            quit()
> +                    template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
> +                    template_md5sum = "143e0d06ba69b8370b9848dcd6ae3f36"
> +
>               try:
> -                with io.open(self.args.template, encoding="utf-8") as template:
> -                    output_str = (
> -                        template.read()
> -                        .replace("/** @options_json **/", options_json)
> -                        .replace("/** @flamegraph_json **/", stacks_json)
> -                    )
> -            except IOError as err:
> -                print("Error reading template file: {}".format(err), file=sys.stderr)
> -                sys.exit(1)
> +                with urllib.request.urlopen(template) as template:
> +                    output_str = "".join([
> +                        l.decode("utf-8") for l in template.readlines()
> +                    ])
> +            except Exception as err:
> +                print(f"Error reading template {template}: {err}\n"
> +                      "a minimal flame graph will be generated", file=sys.stderr)
> +                output_str = minimal_html
> +                template_md5sum = None
> +
> +            if template_md5sum:
> +                download_md5sum = hashlib.md5(output_str.encode("utf-8")).hexdigest()
> +                if download_md5sum != template_md5sum:
> +                    s = None
> +                    while s != "y" and s != "n":
> +                        s = input(f"""Unexpected template md5sum.
> +{download_md5sum} != {template_md5sum}, for:
> +{output_str}
> +continue?[yn] """).lower()
> +                    if s == "n":
> +                        quit()
> +
> +            output_str = output_str.replace("/** @options_json **/", options_json)
> +            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
> +
>               output_fn = self.args.output or "flamegraph.html"
>           else:
>               output_str = stacks_json
> @@ -172,6 +231,10 @@ if __name__ == "__main__":
>                           choices=["blue-green", "orange"])
>       parser.add_argument("-i", "--input",
>                           help=argparse.SUPPRESS)
> +    parser.add_argument("--allow-download",
> +                        default=False,
> +                        action="store_true",
> +                        help="allow unprompted downloading of HTML template")
>   
>       cli_args = parser.parse_args()
>       cli = FlameGraphCLI(cli_args)

-- 
Red Hat Austria GmbH, Registered seat: A-1200 Vienna, Millennium Tower, 
26.floor, Handelskai 94-96, Austria
Commercial register: Commercial Court Vienna, FN 479668w

