Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D339664823
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjAJSF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbjAJSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:05:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E1E61304
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673373751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nVC5afln46faM4kHdFQbld23Olkqu6ilJutGGzB4fnU=;
        b=DESyaWf1XLKy0/PwS4s0iT7uh9lthMDR/6uQIhpKNJRep2UDQLYBC2wSGk5L5Hx9QzPhr5
        S4X1mxGvp94hCiAxvh+5p2XxsT1v6ONb7uS9HIJ+F9W5DrXc3GEft35+g0dyavU+1Ltfca
        FaKTDVUznfGqeu7XSfsBqnBCO43ir0g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-122-3RWHrf1ONFi-be7mzwQ07g-1; Tue, 10 Jan 2023 13:02:29 -0500
X-MC-Unique: 3RWHrf1ONFi-be7mzwQ07g-1
Received: by mail-wr1-f69.google.com with SMTP id l18-20020adfa392000000b002bbd5c680a3so1774107wrb.14
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:02:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVC5afln46faM4kHdFQbld23Olkqu6ilJutGGzB4fnU=;
        b=24xjq+DUTUeZcSn+M111uTP9vWRvi9YQqtqgZQSRB7riRJseDdMIWSYJ2G+nV0esBP
         8mJAiYKjwdV3EIv49a6IiiBtFOicOBTCx+CuDP6KwvmUvA7kA1o1/2HxX119SXJglUqw
         0z4viREHc/VuXp7gyEDnisbf0KGvr8DSCOlImfnSb0syWilsNfQ4SqOYLiI4aqSK8SZ2
         yA5hJpJ5QoKTPVHACOrmq3FoJQsse3IdtZgYkoOqb3DfRYcxiQ6VqWTCsBLBYLGojAwv
         TLAwA/14jyrweEyearpGzYhfPXcbm5YZLtKY1jZn9RuvTyWdP9y7hlbjmovP48HhC5Pw
         o9RA==
X-Gm-Message-State: AFqh2krR/yKu1G8tbb7Ltw0imDwQgFyBPQWhaXNHAHgXlfMkJ3fdGFAc
        52BxeTYetQvlt8r2RElBlfQxA0CSLWfQIiLjvWFtx0YvGlK64e4cSiCyGPQsLluOTRGT9nwM68C
        xvPizmzEj0xFBNZp/0mScEKoC
X-Received: by 2002:a05:600c:1f0e:b0:3cf:497c:c59e with SMTP id bd14-20020a05600c1f0e00b003cf497cc59emr51042305wmb.6.1673373748521;
        Tue, 10 Jan 2023 10:02:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuoimejpOhIg4YK96wkX5m3HozxICPfW+pC6ZhtT/dAGhgJLRHQyug3apvBlMqwTbdajkpKLQ==
X-Received: by 2002:a05:600c:1f0e:b0:3cf:497c:c59e with SMTP id bd14-20020a05600c1f0e00b003cf497cc59emr51042277wmb.6.1673373748276;
        Tue, 10 Jan 2023 10:02:28 -0800 (PST)
Received: from [192.168.31.129] (84-115-237-15.cable.dynamic.surfer.at. [84.115.237.15])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600011cf00b00294176c2c01sm11838518wrx.86.2023.01.10.10.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 10:02:27 -0800 (PST)
Message-ID: <bd4a55a4-8e9c-82bf-92c8-1fa354289dce@redhat.com>
Date:   Tue, 10 Jan 2023 19:02:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1] perf script flamegraph: Avoid d3-flame-graph package
 dependency
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Content-Language: en-US
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
In-Reply-To: <CAP-5=fXi_9zdhTAoYApiFQoLURAvpEatFzU3uL23o3zs=z25ZQ@mail.gmail.com>
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

On 05.01.23 10:24, Ian Rogers wrote:
> On Wed, Jan 4, 2023 at 7:04 PM Ian Rogers <irogers@google.com> wrote:
>>
>> Currently flame graph generation requires a d3-flame-graph template to
>> be installed. Unfortunately this is hard to come by for things like
>> Debian [1]. If the template isn't installed warn and download it from
>> jsdelivr CDN. If downloading fails generate a minimal flame graph
>> again with the javascript coming from jsdelivr CDN.
>>
>> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>

I'm not entirely convinced that this perf script should make a network 
request. In my opinion

* best would be if this template gets packaged in Debian
* alternatively print instructions how to install the template:

     sudo mkdir /usr/share/d3-flame-graph
     sudo wget -O /usr/share/d3-flame-graph/d3-flamegraph-base.html 
https://cdn.jsdelivr.net/npm/d3-flame-graph@4/dist/templates/d3-flamegraph-base.html

* or eventually just embed the entire template (66 KB) in the Python 
file (not sure if this is permissible though, it's basically a minified 
HTML/JS blob)?
* if the above options don't work, I'd recommend asking the user before 
making the network request, and eventually persist the template 
somewhere so it doesn't need to be downloaded every time

What do you think?


Cheers,
Andreas

>> ---
>>   tools/perf/scripts/python/flamegraph.py | 63 ++++++++++++++++++-------
>>   1 file changed, 45 insertions(+), 18 deletions(-)
>>
>> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
>> index b6af1dd5f816..808b0e1c9be5 100755
>> --- a/tools/perf/scripts/python/flamegraph.py
>> +++ b/tools/perf/scripts/python/flamegraph.py
>> @@ -25,6 +25,27 @@ import io
>>   import argparse
>>   import json
>>   import subprocess
>> +import urllib.request
>> +
>> +minimal_html = """<head>
>> +  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
> 
> (hopefully fixed Martin Spier's e-mail address)
> 
> The @4.1.3 comes from the README.md:
> https://github.com/spiermar/d3-flame-graph/blob/master/README.md
> Does it make sense just to drop it or use @latest ? It'd be nice not
> to patch this file for every d3-flame-graph update.
> 
> Thanks,
> Ian
> 
>> +</head>
>> +<body>
>> +  <div id="chart"></div>
>> +  <script type="text/javascript" src="https://d3js.org/d3.v7.js"></script>
>> +  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
>> +  <script type="text/javascript">
>> +  const stacks = [/** @flamegraph_json **/];
>> +  // Note, options is unused.
>> +  const options = [/** @options_json **/];
>> +
>> +  var chart = flamegraph();
>> +  d3.select("#chart")
>> +        .datum(stacks[0])
>> +        .call(chart);
>> +  </script>
>> +</body>
>> +"""
>>
>>   # pylint: disable=too-few-public-methods
>>   class Node:
>> @@ -50,15 +71,18 @@ class FlameGraphCLI:
>>           self.args = args
>>           self.stack = Node("all", "root")
>>
>> -        if self.args.format == "html" and \
>> -                not os.path.isfile(self.args.template):
>> -            print("Flame Graph template {} does not exist. Please install "
>> -                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
>> -                  "package, specify an existing flame graph template "
>> -                  "(--template PATH) or another output format "
>> -                  "(--format FORMAT).".format(self.args.template),
>> -                  file=sys.stderr)
>> -            sys.exit(1)
>> +        if self.args.format == "html":
>> +            if os.path.isfile(self.args.template):
>> +                self.template = f"file://{self.args.template}"
>> +            else:
>> +                print(f"""
>> +Warning: Flame Graph template '{self.args.template}'
>> +does not exist, a template will be downloaded via http. To avoid this
>> +please install a package such as the js-d3-flame-graph or
>> +libjs-d3-flame-graph, specify an existing flame graph template
>> +(--template PATH) or another output format (--format FORMAT).
>> +""", file=sys.stderr)
>> +            self.template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
>>
>>       @staticmethod
>>       def get_libtype_from_dso(dso):
>> @@ -129,15 +153,18 @@ class FlameGraphCLI:
>>               options_json = json.dumps(options)
>>
>>               try:
>> -                with io.open(self.args.template, encoding="utf-8") as template:
>> -                    output_str = (
>> -                        template.read()
>> -                        .replace("/** @options_json **/", options_json)
>> -                        .replace("/** @flamegraph_json **/", stacks_json)
>> -                    )
>> -            except IOError as err:
>> -                print("Error reading template file: {}".format(err), file=sys.stderr)
>> -                sys.exit(1)
>> +                with urllib.request.urlopen(self.template) as template:
>> +                    output_str = '\n'.join([
>> +                        l.decode('utf-8') for l in template.readlines()
>> +                    ])
>> +            except Exception as err:
>> +                print(f"Error reading template {self.template}: {err}\n"
>> +                      "a minimal flame graph will be generated", file=sys.stderr)
>> +                output_str = minimal_html
>> +
>> +            output_str = output_str.replace("/** @options_json **/", options_json)
>> +            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
>> +
>>               output_fn = self.args.output or "flamegraph.html"
>>           else:
>>               output_str = stacks_json
>> --
>> 2.39.0.314.g84b9a713c41-goog
>>
> 

-- 
Red Hat Austria GmbH, Registered seat: A-1200 Vienna, Millennium Tower, 
26.floor, Handelskai 94-96, Austria
Commercial register: Commercial Court Vienna, FN 479668w

