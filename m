Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E71A666284
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjAKSJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbjAKSJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:09:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED68A1C922
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 10:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673460496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JCdCN94VibC7mCVPpS1nQM9hKB5bbCrR2z4LlfOvV1w=;
        b=La1xBzj7HDc58kho1pG6MAvuYWshoojjtvWVOrQdZcFJWtUwCus17W/tLpjwur62wCnslg
        JGnb7MYe0zk73etRmG5cK1bOUU57S/23actUrDoOmiVwmS+OVK06WsGIlhvRCjXQyLioOW
        D8W/9GPZuLMTEafipdpZrbcinnNWlis=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-306-q70TUqsJPe6N5jlhvytX_w-1; Wed, 11 Jan 2023 13:08:15 -0500
X-MC-Unique: q70TUqsJPe6N5jlhvytX_w-1
Received: by mail-wm1-f70.google.com with SMTP id r15-20020a05600c35cf00b003d9a14517b2so11090833wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 10:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCdCN94VibC7mCVPpS1nQM9hKB5bbCrR2z4LlfOvV1w=;
        b=1PAtOnx5NvlW/hAhNae4rFPI6mz+eYWrhra1QBxoOyozLOs5z9VfwoHtNGzvJaEyJs
         vGZuQqO7+4A1zElxS/zYXuMiX1JbTw0zrJbt9Z4Nv9/ji8hSVqpdS4Ylo3ivPc8e3XXR
         v987vbtxFOS59BcNvRf8haJMbbbLf9tEnvMjKImDVqbVcs4DMmcW4PpzYSy9O9gKvFFm
         RF5RUHWjJRORiIQM1V5QuMzILx8rxw6iFcRw4EEai+DWCoegV4pmlHepX/TZY4hlCQ7I
         VyEEw6ZrTkSqZjU6WJo182gbXvWl+hfvUutqjHi+lmIuLLtYs2aZsEK9zWX9TNbgTMP7
         3H7A==
X-Gm-Message-State: AFqh2kr4nK7iClVkzfHqRMInBJRkQkc7DCJtoiQbh7CLaRRNyW4Gz0UR
        usQxDMkrCDkI6Oa6navFEraaV2lWF5a7S8RGWSUkA4kRVjnYQSLLneauk3BDEXaAxVDcWhvLQLa
        +ViFJelamKCdOO2hxDHeeOIGq
X-Received: by 2002:a05:6000:5c9:b0:2b0:bc05:b463 with SMTP id bh9-20020a05600005c900b002b0bc05b463mr18905039wrb.7.1673460493791;
        Wed, 11 Jan 2023 10:08:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvPaRGsQh35oSxkAjdzvfPPmvaO6BBMYMF2khLu8MOUKwipB5V938U4Q1sMvaCw/HaEvgpyXw==
X-Received: by 2002:a05:6000:5c9:b0:2b0:bc05:b463 with SMTP id bh9-20020a05600005c900b002b0bc05b463mr18905023wrb.7.1673460493456;
        Wed, 11 Jan 2023 10:08:13 -0800 (PST)
Received: from [192.168.31.129] (84-115-237-15.cable.dynamic.surfer.at. [84.115.237.15])
        by smtp.gmail.com with ESMTPSA id e1-20020adfdbc1000000b002b8fe58d6desm14503733wrj.62.2023.01.11.10.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 10:08:13 -0800 (PST)
Message-ID: <68e8840e-d894-c211-184d-91a06c87579c@redhat.com>
Date:   Wed, 11 Jan 2023 19:08:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1] perf script flamegraph: Avoid d3-flame-graph package
 dependency
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Brendan Gregg <brendan@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        996839@bugs.debian.org, spiermar@gmail.com
References: <20230105030434.255603-1-irogers@google.com>
 <CAP-5=fXi_9zdhTAoYApiFQoLURAvpEatFzU3uL23o3zs=z25ZQ@mail.gmail.com>
 <bd4a55a4-8e9c-82bf-92c8-1fa354289dce@redhat.com>
 <CAP-5=fX3LaJgft8T+nYV8SHpmoAOYZ9S5-pztKF9j--Um4HKDQ@mail.gmail.com>
 <928c76bf-39bc-cbc0-373e-70c5561cd5b0@redhat.com>
 <CAP-5=fWyE_cqumLFxrj_tncnhVSDpiN0cMij3iB_FMY9qmjNWw@mail.gmail.com>
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
In-Reply-To: <CAP-5=fWyE_cqumLFxrj_tncnhVSDpiN0cMij3iB_FMY9qmjNWw@mail.gmail.com>
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

On 11.01.23 18:13, Ian Rogers wrote:
> On Wed, Jan 11, 2023 at 5:18 AM Andreas Gerstmayr <agerstmayr@redhat.com> wrote:
>>
>> On 10.01.23 20:51, Ian Rogers wrote:
>>> On Tue, Jan 10, 2023 at 10:02 AM Andreas Gerstmayr
>>> <agerstmayr@redhat.com> wrote:
>>>>
>>>> On 05.01.23 10:24, Ian Rogers wrote:
>>>>> On Wed, Jan 4, 2023 at 7:04 PM Ian Rogers <irogers@google.com> wrote:
>>>>>>
>>>>>> Currently flame graph generation requires a d3-flame-graph template to
>>>>>> be installed. Unfortunately this is hard to come by for things like
>>>>>> Debian [1]. If the template isn't installed warn and download it from
>>>>>> jsdelivr CDN. If downloading fails generate a minimal flame graph
>>>>>> again with the javascript coming from jsdelivr CDN.
>>>>>>
>>>>>> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839
>>>>>>
>>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>
>>>> I'm not entirely convinced that this perf script should make a network
>>>> request. In my opinion
>>>>
>>>> * best would be if this template gets packaged in Debian
>>>> * alternatively print instructions how to install the template:
>>>>
>>>>        sudo mkdir /usr/share/d3-flame-graph
>>>>        sudo wget -O /usr/share/d3-flame-graph/d3-flamegraph-base.html
>>>> https://cdn.jsdelivr.net/npm/d3-flame-graph@4/dist/templates/d3-flamegraph-base.html
>>>>
>>>> * or eventually just embed the entire template (66 KB) in the Python
>>>> file (not sure if this is permissible though, it's basically a minified
>>>> HTML/JS blob)?
>>>> * if the above options don't work, I'd recommend asking the user before
>>>> making the network request, and eventually persist the template
>>>> somewhere so it doesn't need to be downloaded every time
>>>>
>>>> What do you think?
>>>
>>> So the script following this patch is going to try 3 things:
>>> 1) look for a local template HTML,
>>> 2) if a local template isn't found warn and switch to downloading the
>>> CDN version,
>>> 3) if the CDN version fails to download then use a minimal (embedded
>>> in the script) HTML file with JS dependencies coming from the CDN.
>>>
>>> For (1) there are references in the generated HTML to www.w3.org,
>>> meaning the HTML isn't fully hermetic - although these references may
>>> not matter.
>>
>> The references to w3.org are XML namespace names. As far as I'm aware
>> they do not matter, as they are merely identifiers and are never
>> accessed [1,2]. Therefore the generated HTML file in its current form is
>> hermetic.
>>
>> This was a design decision from the start - the flame graph generation
>> and the resulting HTML file should not use any external resources loaded
>> over the network (the external host could be inaccessible or compromised
>> at any time). I understand that this requirement may not apply to every
>> user or company.
>>
>>> For (2) there will be a download from the CDN of the template during
>>> the execution of flamegraph. The template is better than (3) as it
>>> features additional buttons letting you zoom out, etc. The HTML will
>>> contain CDN references.
>>> For (3) the generated HTML isn't hermetic and will use the CDN.
>>>
>>> For (2) we could give a prompt before trying to download the template,
>>> or we could change it so that we give the wget command. I wouldn't
>>> have the wget command require root privileges, I'd say that the
>>> template could be downloaded and then the path of the download given
>>> as an option to the flamegraph program. Downloading the file and then
>>> adding an option to flamegraph seems inconvenient to the user,
>>> something that the use of urllib in the patch avoids - it is
>>> essentially just doing this for the user without storing the file on
>>> disk. I think I prefer to be less inconvenient, and so the state of
>>> the code at the moment looks best to me. Given that no choice results
>>> in a fully hermetic HTML file, they seem similar in this regard. Is it
>>> okay to try a download with urllib? Should there be a prompt? I think
>>> the warning is enough and allows scripts, etc. using flamegraph to
>>> more easily function across differing distributions.
>>
>> I fully agree, your changes make the flame graph generation more
>> convenient in case the template is not installed. Also, downloading the
>> template to a local directory and having to specify the path to the
>> template every time is an inconvenience.
>>
>> I think it is a tradeoff between convenience and security/privacy.
>> jsdelivr can get compromised, serving malicious JS (well, in that case,
>> printing instructions to jsdelivr is also flawed :|).
>> In the end it's up to the maintainers to decide.
> 
> Agreed. It is something of an issue with the perf tool, I think noted
> by Arnaldo and Linus, that it has too many dependencies. We also have
> a problem that a number of dependencies aren't license compatible for
> distribution with perf's GPLv2. flamegraph.py is always installed but
> it carries a dependency that can't be satisfied on Debian and
> everything deriving from it. The prompting to install a package
> solution, as is generally used in the build, is one approach. Using
> http rather than files is the approach this change introduces, and is
> an approach advocated by the d3 flamegraph README.md. Perhaps package
> maintainers like Michael and Ben have opinions here.
> 
>>> An aside, Namhyung pointed out to me that there is a "perf report -g
>>> folded" option, that was added in part to simplify creating
>>> flamegraphs:
>>> http://lkml.kernel.org/r/1447047946-1691-2-git-send-email-namhyung@kernel.org
>>> Building off of perf report may improve/simplify the flamegraph code,
>>> or avoid the requirement that libpython be linked against perf.
>>
>> Yep, in this case another tool is required to generate the flame graph
>> visualization, for example [3].
> 
> Thanks, perhaps [3] needs updating to use it as current processing
> appears to be done using perf script:
> https://github.com/brendangregg/FlameGraph/blob/master/stackcollapse-perf.pl
> 
> I think users end up trying out flamegraph as they want something
> easier to read than perf report and the command ships with the tool.
> flamegraph is unique in being like this and it is a pity that the
> Debian half of the world has difficulty making it work.

Maybe someone with Debian packager rights could package the template 
[1]? Then it'd work the same way like with RPM-based distros, and it'll 
also work in environments without network access.

> Fwiw, I'd like
> to start adding documentation to the wiki about how to do easier
> visualizations with other tools, such as the firefox profiler. Perhaps
> some help from the tool also makes sense.

+1
I just tested the steps in the firefox profiler docs [2]. It looks great 
for power users, offering lots of different views, filtering and a 
timeline. There's also speedscope [3], which imho sits between the perf 
flamegraph script and the firefox profiler regarding functionality.


[1] 
https://src.fedoraproject.org/rpms/js-d3-flame-graph/blob/f9efd0ec91e9b88a4f6d47c0e4817c758187b8d2/f/js-d3-flame-graph.spec#_78-85
[2] https://profiler.firefox.com/docs/#/./guide-perf-profiling
[3] https://github.com/jlfwong/speedscope


Cheers,
Andreas

> 
> Thanks,
> Ian
> 
> 
> 
>>
>> [1] https://www.w3.org/TR/xml-names11/
>> [2] https://developer.mozilla.org/en-US/docs/Web/SVG/Namespaces_Crash_Course
>> [3] https://github.com/brendangregg/FlameGraph
>>
>>
>> Cheers,
>> Andreas
>>
>>>
>>> Thanks,
>>> Ian
>>>
>>>
>>>
>>>
>>>>
>>>> Cheers,
>>>> Andreas
>>>>
>>>>>> ---
>>>>>>     tools/perf/scripts/python/flamegraph.py | 63 ++++++++++++++++++-------
>>>>>>     1 file changed, 45 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
>>>>>> index b6af1dd5f816..808b0e1c9be5 100755
>>>>>> --- a/tools/perf/scripts/python/flamegraph.py
>>>>>> +++ b/tools/perf/scripts/python/flamegraph.py
>>>>>> @@ -25,6 +25,27 @@ import io
>>>>>>     import argparse
>>>>>>     import json
>>>>>>     import subprocess
>>>>>> +import urllib.request
>>>>>> +
>>>>>> +minimal_html = """<head>
>>>>>> +  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
>>>>>
>>>>> (hopefully fixed Martin Spier's e-mail address)
>>>>>
>>>>> The @4.1.3 comes from the README.md:
>>>>> https://github.com/spiermar/d3-flame-graph/blob/master/README.md
>>>>> Does it make sense just to drop it or use @latest ? It'd be nice not
>>>>> to patch this file for every d3-flame-graph update.
>>>>>
>>>>> Thanks,
>>>>> Ian
>>>>>
>>>>>> +</head>
>>>>>> +<body>
>>>>>> +  <div id="chart"></div>
>>>>>> +  <script type="text/javascript" src="https://d3js.org/d3.v7.js"></script>
>>>>>> +  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
>>>>>> +  <script type="text/javascript">
>>>>>> +  const stacks = [/** @flamegraph_json **/];
>>>>>> +  // Note, options is unused.
>>>>>> +  const options = [/** @options_json **/];
>>>>>> +
>>>>>> +  var chart = flamegraph();
>>>>>> +  d3.select("#chart")
>>>>>> +        .datum(stacks[0])
>>>>>> +        .call(chart);
>>>>>> +  </script>
>>>>>> +</body>
>>>>>> +"""
>>>>>>
>>>>>>     # pylint: disable=too-few-public-methods
>>>>>>     class Node:
>>>>>> @@ -50,15 +71,18 @@ class FlameGraphCLI:
>>>>>>             self.args = args
>>>>>>             self.stack = Node("all", "root")
>>>>>>
>>>>>> -        if self.args.format == "html" and \
>>>>>> -                not os.path.isfile(self.args.template):
>>>>>> -            print("Flame Graph template {} does not exist. Please install "
>>>>>> -                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
>>>>>> -                  "package, specify an existing flame graph template "
>>>>>> -                  "(--template PATH) or another output format "
>>>>>> -                  "(--format FORMAT).".format(self.args.template),
>>>>>> -                  file=sys.stderr)
>>>>>> -            sys.exit(1)
>>>>>> +        if self.args.format == "html":
>>>>>> +            if os.path.isfile(self.args.template):
>>>>>> +                self.template = f"file://{self.args.template}"
>>>>>> +            else:
>>>>>> +                print(f"""
>>>>>> +Warning: Flame Graph template '{self.args.template}'
>>>>>> +does not exist, a template will be downloaded via http. To avoid this
>>>>>> +please install a package such as the js-d3-flame-graph or
>>>>>> +libjs-d3-flame-graph, specify an existing flame graph template
>>>>>> +(--template PATH) or another output format (--format FORMAT).
>>>>>> +""", file=sys.stderr)
>>>>>> +            self.template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
>>>>>>
>>>>>>         @staticmethod
>>>>>>         def get_libtype_from_dso(dso):
>>>>>> @@ -129,15 +153,18 @@ class FlameGraphCLI:
>>>>>>                 options_json = json.dumps(options)
>>>>>>
>>>>>>                 try:
>>>>>> -                with io.open(self.args.template, encoding="utf-8") as template:
>>>>>> -                    output_str = (
>>>>>> -                        template.read()
>>>>>> -                        .replace("/** @options_json **/", options_json)
>>>>>> -                        .replace("/** @flamegraph_json **/", stacks_json)
>>>>>> -                    )
>>>>>> -            except IOError as err:
>>>>>> -                print("Error reading template file: {}".format(err), file=sys.stderr)
>>>>>> -                sys.exit(1)
>>>>>> +                with urllib.request.urlopen(self.template) as template:
>>>>>> +                    output_str = '\n'.join([
>>>>>> +                        l.decode('utf-8') for l in template.readlines()
>>>>>> +                    ])
>>>>>> +            except Exception as err:
>>>>>> +                print(f"Error reading template {self.template}: {err}\n"
>>>>>> +                      "a minimal flame graph will be generated", file=sys.stderr)
>>>>>> +                output_str = minimal_html
>>>>>> +
>>>>>> +            output_str = output_str.replace("/** @options_json **/", options_json)
>>>>>> +            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
>>>>>> +
>>>>>>                 output_fn = self.args.output or "flamegraph.html"
>>>>>>             else:
>>>>>>                 output_str = stacks_json
>>>>>> --
>>>>>> 2.39.0.314.g84b9a713c41-goog
>>>>>>
>>>>>
>>>>
>>>> --
>>>> Red Hat Austria GmbH, Registered seat: A-1200 Vienna, Millennium Tower,
>>>> 26.floor, Handelskai 94-96, Austria
>>>> Commercial register: Commercial Court Vienna, FN 479668w
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

