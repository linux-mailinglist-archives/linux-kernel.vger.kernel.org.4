Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD2D749557
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjGFGJB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 02:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjGFGIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:08:48 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896FA1FD4;
        Wed,  5 Jul 2023 23:07:12 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fb9fd28025so293965e87.2;
        Wed, 05 Jul 2023 23:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688623631; x=1691215631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stDwC3ubWk7UbpFGcin9q0Sf3tcXcBNG3Nx064U9y4M=;
        b=Vw3a1VWpJV59uqZCBdlQFMYQgbLG2dGlyvzWXfvONYpOHQuLZt1X3jkLpyUq0H7LUN
         dxE5E1PfgFxsMT98DMk2I9ik46aJ5Ol5Y+W5JvnMXLBlao3KNTMWBVlR3XEIcokcgR4l
         gtbuUbp1zyjLMsz4kVUVVyRXIQKdgEQ+F+XptXowoDw9XnYQv8+1sjdIPbIFXY7fdliJ
         mqY4s3ojc2w6PEGWUaAn4fXs732DjGqAAgVSm+LnbCZgqhHZCIMnzODAf/akEr20fF2l
         c0CqPey8//z5tTMY4a1VgIi7g2FhxUr3L6n0qo+Ey9/vLwgnbTGe+kYqQp+zPR1pqyKh
         n0cg==
X-Gm-Message-State: ABy/qLZ40xSBDRApmgk5a6Vc/27YQueENcbReqh2rZEnsmWmRELV4CPd
        97PLhHVoG0Shgt337q43GxZgEGdGMogOiA6dTck=
X-Google-Smtp-Source: APBJJlHXjO7GNcxa6ABgkuVpPfWJFiI8v4svLbYVLj2+noQZu6WN4oUZHk2Ssx8lpRGp5SUIZ56TkybmX12RHpaGE0Y=
X-Received: by 2002:a05:6512:1584:b0:4fb:8359:e8c with SMTP id
 bp4-20020a056512158400b004fb83590e8cmr866572lfb.34.1688623630488; Wed, 05 Jul
 2023 23:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688585597.git.anupnewsmail@gmail.com> <a5749b6a98928b2a8fa6c1dd1c54201334edb04b.1688585597.git.anupnewsmail@gmail.com>
In-Reply-To: <a5749b6a98928b2a8fa6c1dd1c54201334edb04b.1688585597.git.anupnewsmail@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 5 Jul 2023 23:06:58 -0700
Message-ID: <CAM9d7ciZcO_kVwRhOoz0xt-hdguoTHUd8RPSpSOwiCFOTbYNKw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] scripts: python: implement get or create frame function
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
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 12:48 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
>
> The get_or_create_frame function is responsible for retrieving or
> creating a frame based on the provided frameString. If the frame
> corresponding to the frameString is found in the frameMap, it is
> returned. Otherwise, a new frame is created by appending relevant
> information to the frameTable's 'data' array and adding the
> frameString to the stringTable.
>
> The index of the newly created frame is added to the frameMap.
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  .../scripts/python/firefox-gecko-converter.py | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> index 6f69c083d3ff..d5b9fb16e520 100644
> --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -77,6 +77,39 @@ def process_event(param_dict):
>                                 stackMap[key] = stack
>                         return stack
>
> +               frameMap = dict()
> +               def get_or_create_frame(frameString):
> +                       frame = frameMap.get(frameString)
> +                       if frame is None:
> +                               frame = len(frameTable['data'])
> +                               location = len(stringTable)
> +                               stringTable.append(frameString)

Looks like it just always appending a new string.
Any deduplication work later?

> +                               category = KERNEL_CATEGORY_INDEX if frameString.find('kallsyms') != -1 \
> +                                               or frameString.find('/vmlinux') != -1 \
> +                                               or frameString.endswith('.ko)') \
> +                                               else USER_CATEGORY_INDEX

I think you can use param_dict['sample']['cpumode'].
Please see include/uapi/linux/perf_event.h for cpumode
values.

> +                               implementation = None
> +                               optimizations = None
> +                               line = None
> +                               relevantForJS = False
> +                               subcategory = None
> +                               innerWindowID = 0
> +                               column = None
> +
> +                               frameTable['data'].append([
> +                                       location,
> +                                       relevantForJS,
> +                                       innerWindowID,
> +                                       implementation,
> +                                       optimizations,
> +                                       line,
> +                                       column,
> +                                       category,
> +                                       subcategory,
> +                               ])
> +                               frameMap[frameString] = frame

I think it'd be better if you define the frameTable in this
commit.

Thanks,
Namhyung


> +                       return frame
> +
>         def _addThreadSample(pid, tid, threadName, time_stamp, stack):
>                 thread = thread_map.get(tid)
>                 if not thread:
> --
> 2.34.1
>
