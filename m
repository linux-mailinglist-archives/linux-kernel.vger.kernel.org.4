Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A05665C51
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjAKNTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjAKNTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:19:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84BC659A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673443097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zTMWfGAiBPFZXwWQF8kE22q3w7eEUdeC1OsbaC6TZ6E=;
        b=Reae9ZWhaid/jb2NJ5UDF0uzswRRtE1BCn1LiufkZjP2UG5tptqade3JegHtHXVcMiIojS
        lw6wZQG5jKsTxd15Y4OStZNrTFiaM8LaefhkhfsGStz65oiB1B+vDbRm2KfgrNgwZSVkmE
        bGUMzPLUp1kvjylKCt03bJECgN8AeaA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-532-I0i_BI_TOMGEL9M36ABF8A-1; Wed, 11 Jan 2023 08:18:15 -0500
X-MC-Unique: I0i_BI_TOMGEL9M36ABF8A-1
Received: by mail-wr1-f69.google.com with SMTP id o14-20020adfa10e000000b002631c56fe26so2646605wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:18:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTMWfGAiBPFZXwWQF8kE22q3w7eEUdeC1OsbaC6TZ6E=;
        b=3HQyrcN80hJD2OFRmlmfK6EV2Sux+MHD1xhiJq9gT1vrLR1XIuvpLqyGRzCw2803lg
         0G/W1YAA4FZUh+GK39i7q92Qrk5X8osHLupMvjsE+V+J1xorpFbxQY6IbtYaWBWCwHAP
         Geuk7X4ag33oNd5EVFsyfv7kA9llKe1jz874Gx9+801XRDEzPS2x86b6Qd0pZf7UJvFH
         AGubakDFej53zXyH75qal92T2WeEDHgO2o7ekt5KRQhjGSZ0DwfCKnMKI2l7ObBYjIWJ
         wi7ByBEBbfVygKb3LEYmyrOTOe/TBqHwXBtJY90JC+km6ZqdWKaEGscd/txjff5zJ2ju
         NHeA==
X-Gm-Message-State: AFqh2kpqLXw3xCLc3riMGKM/+io+u/bg8Fhj5cgXJDuENSN19akqIkMB
        x3bd7yvpMip4ZwWxaOJBO7MajJGr0Qs35c1bnBdyhKW8dqPSn/tPF2TnO3aQbyGZJU2LvgyZkHS
        AMdnzDWNFVxaVcraP93DZu8mj
X-Received: by 2002:adf:d216:0:b0:2bc:854d:fc50 with SMTP id j22-20020adfd216000000b002bc854dfc50mr4280060wrh.7.1673443094702;
        Wed, 11 Jan 2023 05:18:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuNl2FDi0fKOWNnsiMV/GUZfmzpnJNXZ/u6KsR6fZaN/GQO0TXronHArzG60dycD8iFkLQS8Q==
X-Received: by 2002:adf:d216:0:b0:2bc:854d:fc50 with SMTP id j22-20020adfd216000000b002bc854dfc50mr4280045wrh.7.1673443094360;
        Wed, 11 Jan 2023 05:18:14 -0800 (PST)
Received: from [192.168.31.129] (84-115-237-15.cable.dynamic.surfer.at. [84.115.237.15])
        by smtp.gmail.com with ESMTPSA id q4-20020adff784000000b0026e94493858sm13479690wrp.106.2023.01.11.05.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 05:18:13 -0800 (PST)
Message-ID: <928c76bf-39bc-cbc0-373e-70c5561cd5b0@redhat.com>
Date:   Wed, 11 Jan 2023 14:18:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1] perf script flamegraph: Avoid d3-flame-graph package
 dependency
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
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
References: <20230105030434.255603-1-irogers@google.com>
 <CAP-5=fXi_9zdhTAoYApiFQoLURAvpEatFzU3uL23o3zs=z25ZQ@mail.gmail.com>
 <bd4a55a4-8e9c-82bf-92c8-1fa354289dce@redhat.com>
 <CAP-5=fX3LaJgft8T+nYV8SHpmoAOYZ9S5-pztKF9j--Um4HKDQ@mail.gmail.com>
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
In-Reply-To: <CAP-5=fX3LaJgft8T+nYV8SHpmoAOYZ9S5-pztKF9j--Um4HKDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.01.23 20:51, Ian Rogers wrote:
> On Tue, Jan 10, 2023 at 10:02 AM Andreas Gerstmayr
> <agerstmayr@redhat.com> wrote:
>>
>> On 05.01.23 10:24, Ian Rogers wrote:
>>> On Wed, Jan 4, 2023 at 7:04 PM Ian Rogers <irogers@google.com> wrote:
>>>>
>>>> Currently flame graph generation requires a d3-flame-graph template to
>>>> be installed. Unfortunately this is hard to come by for things like
>>>> Debian [1]. If the template isn't installed warn and download it from
>>>> jsdelivr CDN. If downloading fails generate a minimal flame graph
>>>> again with the javascript coming from jsdelivr CDN.
>>>>
>>>> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839
>>>>
>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>
>> I'm not entirely convinced that this perf script should make a network
>> request. In my opinion
>>
>> * best would be if this template gets packaged in Debian
>> * alternatively print instructions how to install the template:
>>
>>       sudo mkdir /usr/share/d3-flame-graph
>>       sudo wget -O /usr/share/d3-flame-graph/d3-flamegraph-base.html
>> https://cdn.jsdelivr.net/npm/d3-flame-graph@4/dist/templates/d3-flamegraph-base.html
>>
>> * or eventually just embed the entire template (66 KB) in the Python
>> file (not sure if this is permissible though, it's basically a minified
>> HTML/JS blob)?
>> * if the above options don't work, I'd recommend asking the user before
>> making the network request, and eventually persist the template
>> somewhere so it doesn't need to be downloaded every time
>>
>> What do you think?
> 
> So the script following this patch is going to try 3 things:
> 1) look for a local template HTML,
> 2) if a local template isn't found warn and switch to downloading the
> CDN version,
> 3) if the CDN version fails to download then use a minimal (embedded
> in the script) HTML file with JS dependencies coming from the CDN.
> 
> For (1) there are references in the generated HTML to www.w3.org,
> meaning the HTML isn't fully hermetic - although these references may
> not matter.

The references to w3.org are XML namespace names. As far as I'm aware 
they do not matter, as they are merely identifiers and are never 
accessed [1,2]. Therefore the generated HTML file in its current form is 
hermetic.

This was a design decision from the start - the flame graph generation 
and the resulting HTML file should not use any external resources loaded 
over the network (the external host could be inaccessible or compromised 
at any time). I understand that this requirement may not apply to every 
user or company.

> For (2) there will be a download from the CDN of the template during
> the execution of flamegraph. The template is better than (3) as it
> features additional buttons letting you zoom out, etc. The HTML will
> contain CDN references.
> For (3) the generated HTML isn't hermetic and will use the CDN.
> 
> For (2) we could give a prompt before trying to download the template,
> or we could change it so that we give the wget command. I wouldn't
> have the wget command require root privileges, I'd say that the
> template could be downloaded and then the path of the download given
> as an option to the flamegraph program. Downloading the file and then
> adding an option to flamegraph seems inconvenient to the user,
> something that the use of urllib in the patch avoids - it is
> essentially just doing this for the user without storing the file on
> disk. I think I prefer to be less inconvenient, and so the state of
> the code at the moment looks best to me. Given that no choice results
> in a fully hermetic HTML file, they seem similar in this regard. Is it
> okay to try a download with urllib? Should there be a prompt? I think
> the warning is enough and allows scripts, etc. using flamegraph to
> more easily function across differing distributions.

I fully agree, your changes make the flame graph generation more 
convenient in case the template is not installed. Also, downloading the 
template to a local directory and having to specify the path to the 
template every time is an inconvenience.

I think it is a tradeoff between convenience and security/privacy. 
jsdelivr can get compromised, serving malicious JS (well, in that case, 
printing instructions to jsdelivr is also flawed :|).
In the end it's up to the maintainers to decide.

> An aside, Namhyung pointed out to me that there is a "perf report -g
> folded" option, that was added in part to simplify creating
> flamegraphs:
> http://lkml.kernel.org/r/1447047946-1691-2-git-send-email-namhyung@kernel.org
> Building off of perf report may improve/simplify the flamegraph code,
> or avoid the requirement that libpython be linked against perf.

Yep, in this case another tool is required to generate the flame graph 
visualization, for example [3].


[1] https://www.w3.org/TR/xml-names11/
[2] https://developer.mozilla.org/en-US/docs/Web/SVG/Namespaces_Crash_Course
[3] https://github.com/brendangregg/FlameGraph


Cheers,
Andreas

> 
> Thanks,
> Ian
> 
> 
> 
> 
>>
>> Cheers,
>> Andreas
>>
>>>> ---
>>>>    tools/perf/scripts/python/flamegraph.py | 63 ++++++++++++++++++-------
>>>>    1 file changed, 45 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
>>>> index b6af1dd5f816..808b0e1c9be5 100755
>>>> --- a/tools/perf/scripts/python/flamegraph.py
>>>> +++ b/tools/perf/scripts/python/flamegraph.py
>>>> @@ -25,6 +25,27 @@ import io
>>>>    import argparse
>>>>    import json
>>>>    import subprocess
>>>> +import urllib.request
>>>> +
>>>> +minimal_html = """<head>
>>>> +  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
>>>
>>> (hopefully fixed Martin Spier's e-mail address)
>>>
>>> The @4.1.3 comes from the README.md:
>>> https://github.com/spiermar/d3-flame-graph/blob/master/README.md
>>> Does it make sense just to drop it or use @latest ? It'd be nice not
>>> to patch this file for every d3-flame-graph update.
>>>
>>> Thanks,
>>> Ian
>>>
>>>> +</head>
>>>> +<body>
>>>> +  <div id="chart"></div>
>>>> +  <script type="text/javascript" src="https://d3js.org/d3.v7.js"></script>
>>>> +  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
>>>> +  <script type="text/javascript">
>>>> +  const stacks = [/** @flamegraph_json **/];
>>>> +  // Note, options is unused.
>>>> +  const options = [/** @options_json **/];
>>>> +
>>>> +  var chart = flamegraph();
>>>> +  d3.select("#chart")
>>>> +        .datum(stacks[0])
>>>> +        .call(chart);
>>>> +  </script>
>>>> +</body>
>>>> +"""
>>>>
>>>>    # pylint: disable=too-few-public-methods
>>>>    class Node:
>>>> @@ -50,15 +71,18 @@ class FlameGraphCLI:
>>>>            self.args = args
>>>>            self.stack = Node("all", "root")
>>>>
>>>> -        if self.args.format == "html" and \
>>>> -                not os.path.isfile(self.args.template):
>>>> -            print("Flame Graph template {} does not exist. Please install "
>>>> -                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
>>>> -                  "package, specify an existing flame graph template "
>>>> -                  "(--template PATH) or another output format "
>>>> -                  "(--format FORMAT).".format(self.args.template),
>>>> -                  file=sys.stderr)
>>>> -            sys.exit(1)
>>>> +        if self.args.format == "html":
>>>> +            if os.path.isfile(self.args.template):
>>>> +                self.template = f"file://{self.args.template}"
>>>> +            else:
>>>> +                print(f"""
>>>> +Warning: Flame Graph template '{self.args.template}'
>>>> +does not exist, a template will be downloaded via http. To avoid this
>>>> +please install a package such as the js-d3-flame-graph or
>>>> +libjs-d3-flame-graph, specify an existing flame graph template
>>>> +(--template PATH) or another output format (--format FORMAT).
>>>> +""", file=sys.stderr)
>>>> +            self.template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
>>>>
>>>>        @staticmethod
>>>>        def get_libtype_from_dso(dso):
>>>> @@ -129,15 +153,18 @@ class FlameGraphCLI:
>>>>                options_json = json.dumps(options)
>>>>
>>>>                try:
>>>> -                with io.open(self.args.template, encoding="utf-8") as template:
>>>> -                    output_str = (
>>>> -                        template.read()
>>>> -                        .replace("/** @options_json **/", options_json)
>>>> -                        .replace("/** @flamegraph_json **/", stacks_json)
>>>> -                    )
>>>> -            except IOError as err:
>>>> -                print("Error reading template file: {}".format(err), file=sys.stderr)
>>>> -                sys.exit(1)
>>>> +                with urllib.request.urlopen(self.template) as template:
>>>> +                    output_str = '\n'.join([
>>>> +                        l.decode('utf-8') for l in template.readlines()
>>>> +                    ])
>>>> +            except Exception as err:
>>>> +                print(f"Error reading template {self.template}: {err}\n"
>>>> +                      "a minimal flame graph will be generated", file=sys.stderr)
>>>> +                output_str = minimal_html
>>>> +
>>>> +            output_str = output_str.replace("/** @options_json **/", options_json)
>>>> +            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
>>>> +
>>>>                output_fn = self.args.output or "flamegraph.html"
>>>>            else:
>>>>                output_str = stacks_json
>>>> --
>>>> 2.39.0.314.g84b9a713c41-goog
>>>>
>>>
>>
>> --
>> Red Hat Austria GmbH, Registered seat: A-1200 Vienna, Millennium Tower,
>> 26.floor, Handelskai 94-96, Austria
>> Commercial register: Commercial Court Vienna, FN 479668w
>>
> 

-- 
Red Hat Austria GmbH, Registered seat: A-1200 Vienna, Millennium Tower, 
26.floor, Handelskai 94-96, Austria
Commercial register: Commercial Court Vienna, FN 479668w

