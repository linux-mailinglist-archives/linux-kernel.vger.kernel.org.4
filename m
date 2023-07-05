Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794AC748E7A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjGET5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjGET5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:57:03 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4584173B;
        Wed,  5 Jul 2023 12:56:58 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6686a05bc66so44417b3a.1;
        Wed, 05 Jul 2023 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688587018; x=1691179018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TlXlQ+VQSstFNgJX2WkC6cI55mZqRHLWVinXakjJg1s=;
        b=UpTCbeiin1FfU7OOgARkTOwjqxlPLBscacN9VOt+W9yiLVV5vhmm1iFDMB1rHtD1kK
         tnCJFXedvuJSJODlK4vMw3++tGED61qYXYKDoKPLUbwPqM4BhF9Ip0teRKucNebRzwQ9
         zxlUSjpb8uEVjKZ56XoVCQH908gang1JdDa0J95QJYOIMk6DQfyr2PtXgAmiHR57lJH2
         hCmo66WwYNNv0YZRumJokqyDSzao9fHyzUrbZSJNEBYEIDt6dIllJOnfgXKaZ/4nhnxK
         yIyX6vLHFQDhsaYs6RZjOo8gTs5J2Iyu952ih0o0i4Ioi2eW5whMa20LIoAvzM4p2ghJ
         0uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688587018; x=1691179018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlXlQ+VQSstFNgJX2WkC6cI55mZqRHLWVinXakjJg1s=;
        b=NgYaZo6LiHscR1W+g6gtIJ6bLex7yF0jdSFEhNFNTPfmlS936qYN7VaI3Gf3amOM2P
         zjNKhktKCkt3WApJlJetGAvei9i0CdGZm550nZ/chui08dF144ReEjdWCz3BIIlm9H+A
         +hsK+x1XqxjVbNKec/Vu1qAujg8fO88vrbJg+Md3FtaY9/nFp21T9RV4BddG57N6/rLn
         FJXzhqchxkEs9TiSMY8IwliVmgclvnwe8YkwrD4D/Pu3ffE4BlTB0dMjjNMLtNWT3BFf
         Dq57Zbr1AEdIfpLjJRXqh1gGOwII9UPaL0zFpqvjdsE/k4K2z5UknGWt7w8SUx2QXyno
         N1Zg==
X-Gm-Message-State: ABy/qLbAYXGQ+XRTh2wGC4onwUCSylEKzQhftMu+pEr7Y1M2qer3HjgI
        mYQSryehljU99vSUYqeP2HA=
X-Google-Smtp-Source: APBJJlF3N73zyO57FioaI2B4aezchVrk01EWrOjfZaHYInWnnMthM22QksStvxiFajwRyuy8NgJwRw==
X-Received: by 2002:a05:6a00:1a8b:b0:66f:7076:a5b8 with SMTP id e11-20020a056a001a8b00b0066f7076a5b8mr16611045pfv.29.1688587018060;
        Wed, 05 Jul 2023 12:56:58 -0700 (PDT)
Received: from yoga ([2400:1f00:13:c628:31be:68ae:86f5:48b9])
        by smtp.gmail.com with ESMTPSA id 18-20020a056a00071200b0063b96574b8bsm4514794pfl.220.2023.07.05.12.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:56:57 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Thu, 6 Jul 2023 01:26:50 +0530
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] scripts: python: Implement parsing of input data in
 convertPerfScriptProfile
Message-ID: <ZKXLAqWF29sxCS1B@yoga>
References: <cover.1687375189.git.anupnewsmail@gmail.com>
 <3772bce9068962f2a4c57672e919ebdf30edbc5c.1687375189.git.anupnewsmail@gmail.com>
 <CAM9d7cj1bWWM7j5LCTpDQqLXmn5UH1mkCvZ-k3VEXJb7S2+wxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cj1bWWM7j5LCTpDQqLXmn5UH1mkCvZ-k3VEXJb7S2+wxg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 05:03:12PM -0700, Namhyung Kim wrote:
> Hi Anup,
> 
> On Wed, Jun 21, 2023 at 12:41 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > The lines variable is created by splitting the profile string into individual
> > lines. It allows for iterating over each line for processing.
> >
> > The line is considered the start of a sample. It is matched against a regular
> > expression pattern to extract relevant information such as before_time_stamp,
> > time_stamp, threadNamePidAndTidMatch, threadName, pid, and tid.
> >
> > The stack frames of the current sample are then parsed in a nested loop.
> > Each stackFrameLine is matched against a regular expression pattern to
> > extract rawFunc and mod information.
> >
> > Also fixed few checkpatch warnings.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> > ---
> >  .../scripts/python/firefox-gecko-converter.py | 62 ++++++++++++++++++-
> >  1 file changed, 60 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> > index 0ff70c0349c8..e5bc7a11c3e6 100644
> > --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > @@ -1,4 +1,5 @@
> >  #!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Please put this line in the first commit.

Sure, followed in latest version.

> >  import re
> >  import sys
> >  import json
> > @@ -14,13 +15,13 @@ def isPerfScriptFormat(profile):
> >      firstLine = profile[:profile.index('\n')]
> >      return bool(re.match(r'^\S.*?\s+(?:\d+/)?\d+\s+(?:\d+\d+\s+)?[\d.]+:', firstLine))
> >
> > -def convertPerfScriptProfile(profile):
> > +def convertPerfScriptProfile(profile):
> 
> You'd better configure your editor to warn or even fix
> the trailing whitespace automatically.

Thanks, I followed your advice and configured my nvim to handle trailing
whitespace automatically. It has significantly improved my workflow.
Here's the updated snippet I added to my vimrc file:

highlight ExtraWhitespace ctermbg=white guibg=white
match ExtraWhitespace /\s\+$/

> Thanks,
> Namhyung
> 
> 
> >
> >          def addSample(threadName, stackArray, time):
> >              nonlocal name
> >              if name != threadName:
> >                  name = threadName
> > -            # TODO:
> > +            # TODO:
> >              # get_or_create_stack will create a new stack if it doesn't exist, or return the existing stack if it does.
> >              # get_or_create_frame will create a new frame if it doesn't exist, or return the existing frame if it does.
> >              stack = reduce(lambda prefix, stackFrame: get_or_create_stack(get_or_create_frame(stackFrame), prefix), stackArray, None)
> > @@ -54,3 +55,60 @@ def convertPerfScriptProfile(profile):
> >              thread = _createtread(threadName, pid, tid)
> >              threadMap[tid] = thread
> >          thread['addSample'](threadName, stack, time_stamp)
> > +
> > +    lines = profile.split('\n')
> > +
> > +    line_index = 0
> > +    startTime = 0
> > +    while line_index < len(lines):
> > +        line = lines[line_index]
> > +        line_index += 1
> > +    # perf script --header outputs header lines beginning with #
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
> > +        threadNamePidAndTidMatch = re.match(r'^(.*)\s+(?:(\d+)\/)?(\d+)\b', before_time_stamp)
> > +
> > +        if not threadNamePidAndTidMatch:
> > +            print('Could not parse line as the start of a sample in the "perf script" profile format: "%s"' % sampleStartLine)
> > +            continue
> > +        threadName = threadNamePidAndTidMatch[1].strip()
> > +        pid = int(threadNamePidAndTidMatch[2] or 0)
> > +        tid = int(threadNamePidAndTidMatch[3] or 0)
> > +        if startTime == 0:
> > +            startTime = time_stamp
> > +        # Parse the stack frames of the current sample in a nested loop.
> > +        stack = []
> > +        while line_index < len(lines):
> > +            stackFrameLine = lines[line_index]
> > +            line_index += 1
> > +            if stackFrameLine.strip() == '':
> > +                # Sample ends.
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
> > +                # If we have a module name, provide it.
> > +                # The code processing the profile will search for
> > +                # "functionName (in libraryName)" using a regexp,
> > +                # and automatically create the library information.
> > +                rawFunc += f' (in {mod})'
> > +
> > +            stack.append(rawFunc)
> > +
> > --
> > 2.34.1
> >
