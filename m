Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEEA73C4FF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 02:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjFXADe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 20:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjFXADc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 20:03:32 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896FC2707;
        Fri, 23 Jun 2023 17:03:24 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-bf3934ee767so3628346276.0;
        Fri, 23 Jun 2023 17:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687565004; x=1690157004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGxsOBbKB22bf0B3O3FFaShm0eqOgqt5FgbcjeTORJ4=;
        b=P6ZsZ+A2FGZ3iKm/RpnXpE0aVSgZ8w1jGpZZpPmzUEnUvHj1BZNA5mTL/3GmG1cVYW
         1tqgf/ViH4FKPIoPT3H4nw3z8HO0fykTvXyPeW+NYlvlqfzxbey2QRpbOfJHPsZ7jtho
         XgdmijS6wzf9R20WQcxLYf6HLT6HMcd2gPlx7+g4+FWhSXzVuG3JaRVS6s8xsqRyCrPo
         0sKeUUISDOei/PKW5fqbrBapBmjK9CibIlWGkOky2oOb8wzX+cIfyYdHepHM77rYhto6
         5anm2YFjhfwd/IGXCJw1rtswWAdt+3pAqgHW6agr5mdbxgAXD5xrb2jSrePSY6tbfl3k
         91TQ==
X-Gm-Message-State: AC+VfDxQyjcUYeMLW4Sq6pKdxhknnOIrHJHzQ30p8ZM4nmjwXeLguHRe
        6k9iEMLtqMU6cmlsPtpSHYez/HTORsFzc3QgXOA=
X-Google-Smtp-Source: ACHHUZ74md1d7MCVgnQak7P7DSFy1RGjbsvcL2UzCK/lxvaIV7Dt+oqX0IdVhBd9GO7+OI5JrMPtT6AuBl1cxPlAC4o=
X-Received: by 2002:a25:4007:0:b0:b94:bbf2:19a3 with SMTP id
 n7-20020a254007000000b00b94bbf219a3mr24508831yba.18.1687565003693; Fri, 23
 Jun 2023 17:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687375189.git.anupnewsmail@gmail.com> <3772bce9068962f2a4c57672e919ebdf30edbc5c.1687375189.git.anupnewsmail@gmail.com>
In-Reply-To: <3772bce9068962f2a4c57672e919ebdf30edbc5c.1687375189.git.anupnewsmail@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 23 Jun 2023 17:03:12 -0700
Message-ID: <CAM9d7cj1bWWM7j5LCTpDQqLXmn5UH1mkCvZ-k3VEXJb7S2+wxg@mail.gmail.com>
Subject: Re: [PATCH 4/9] scripts: python: Implement parsing of input data in convertPerfScriptProfile
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On Wed, Jun 21, 2023 at 12:41 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
>
> The lines variable is created by splitting the profile string into individual
> lines. It allows for iterating over each line for processing.
>
> The line is considered the start of a sample. It is matched against a regular
> expression pattern to extract relevant information such as before_time_stamp,
> time_stamp, threadNamePidAndTidMatch, threadName, pid, and tid.
>
> The stack frames of the current sample are then parsed in a nested loop.
> Each stackFrameLine is matched against a regular expression pattern to
> extract rawFunc and mod information.
>
> Also fixed few checkpatch warnings.
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  .../scripts/python/firefox-gecko-converter.py | 62 ++++++++++++++++++-
>  1 file changed, 60 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> index 0ff70c0349c8..e5bc7a11c3e6 100644
> --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -1,4 +1,5 @@
>  #!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0

Please put this line in the first commit.

>  import re
>  import sys
>  import json
> @@ -14,13 +15,13 @@ def isPerfScriptFormat(profile):
>      firstLine = profile[:profile.index('\n')]
>      return bool(re.match(r'^\S.*?\s+(?:\d+/)?\d+\s+(?:\d+\d+\s+)?[\d.]+:', firstLine))
>
> -def convertPerfScriptProfile(profile):
> +def convertPerfScriptProfile(profile):

You'd better configure your editor to warn or even fix
the trailing whitespace automatically.

Thanks,
Namhyung


>
>          def addSample(threadName, stackArray, time):
>              nonlocal name
>              if name != threadName:
>                  name = threadName
> -            # TODO:
> +            # TODO:
>              # get_or_create_stack will create a new stack if it doesn't exist, or return the existing stack if it does.
>              # get_or_create_frame will create a new frame if it doesn't exist, or return the existing frame if it does.
>              stack = reduce(lambda prefix, stackFrame: get_or_create_stack(get_or_create_frame(stackFrame), prefix), stackArray, None)
> @@ -54,3 +55,60 @@ def convertPerfScriptProfile(profile):
>              thread = _createtread(threadName, pid, tid)
>              threadMap[tid] = thread
>          thread['addSample'](threadName, stack, time_stamp)
> +
> +    lines = profile.split('\n')
> +
> +    line_index = 0
> +    startTime = 0
> +    while line_index < len(lines):
> +        line = lines[line_index]
> +        line_index += 1
> +    # perf script --header outputs header lines beginning with #
> +        if line == '' or line.startswith('#'):
> +            continue
> +
> +        sample_start_line = line
> +
> +        sample_start_match = re.match(r'^(.*)\s+([\d.]+):', sample_start_line)
> +        if not sample_start_match:
> +            print(f'Could not parse line as the start of a sample in the "perf script" profile format: "{sample_start_line}"')
> +            continue
> +
> +        before_time_stamp = sample_start_match[1]
> +        time_stamp = float(sample_start_match[2]) * 1000
> +        threadNamePidAndTidMatch = re.match(r'^(.*)\s+(?:(\d+)\/)?(\d+)\b', before_time_stamp)
> +
> +        if not threadNamePidAndTidMatch:
> +            print('Could not parse line as the start of a sample in the "perf script" profile format: "%s"' % sampleStartLine)
> +            continue
> +        threadName = threadNamePidAndTidMatch[1].strip()
> +        pid = int(threadNamePidAndTidMatch[2] or 0)
> +        tid = int(threadNamePidAndTidMatch[3] or 0)
> +        if startTime == 0:
> +            startTime = time_stamp
> +        # Parse the stack frames of the current sample in a nested loop.
> +        stack = []
> +        while line_index < len(lines):
> +            stackFrameLine = lines[line_index]
> +            line_index += 1
> +            if stackFrameLine.strip() == '':
> +                # Sample ends.
> +                break
> +            stackFrameMatch = re.match(r'^\s*(\w+)\s*(.+) \(([^)]*)\)', stackFrameLine)
> +            if stackFrameMatch:
> +                rawFunc = stackFrameMatch[2]
> +                mod = stackFrameMatch[3]
> +                rawFunc = re.sub(r'\+0x[\da-f]+$', '', rawFunc)
> +
> +            if rawFunc.startswith('('):
> +                continue # skip process names
> +
> +            if mod:
> +                # If we have a module name, provide it.
> +                # The code processing the profile will search for
> +                # "functionName (in libraryName)" using a regexp,
> +                # and automatically create the library information.
> +                rawFunc += f' (in {mod})'
> +
> +            stack.append(rawFunc)
> +
> --
> 2.34.1
>
