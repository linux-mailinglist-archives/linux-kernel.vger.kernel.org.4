Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBC673C500
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 02:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjFXAFL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 20:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFXAFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 20:05:10 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7AE1715;
        Fri, 23 Jun 2023 17:05:09 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-62ffb5f6aafso10539956d6.1;
        Fri, 23 Jun 2023 17:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687565108; x=1690157108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aL5w2m8V/KDDXwMddYTWzt+5srKNCPxK8P/RiM5TeBE=;
        b=AjiUGplicGIsRNBjRHHIlNquYfZBsdnC/fkE4F6rur5zkb+w0pqqLyicoxmOqQwpK/
         pHlOBZn0i22bEEiAZN5ZPXlWsbgvcvYR4FxQSeByjVRhWz9HA93X6KPzdLkI1NoPrK5m
         iZuqn5hUl7a+CoAtDk1z7A+zFzMHi6l2vC6lSkAdTj+zaDmd+9bWh6KXx1qkXR2Si6Jt
         BhpsvRG45Lq5IsoH25HJg/u2KNcQk7xqYRDO4whHDBHvnB6qo0dM/F+oRaSBRiWI+HZj
         q8/r9BUYUWkeA34JyhKyOvO5UdmColWfrK6yrV0d3Whbv9KASSNpWFMV2eqEo1CfqvcU
         XMIA==
X-Gm-Message-State: AC+VfDyz0uZZ0wH4R6uUaJU4SiVmGFmmrgBgbXoklhwjY40QMnqK1NWr
        Z2OciBhxA1Uyf/1HtrzrAtAPrAVIFb/cEf9h5r8=
X-Google-Smtp-Source: ACHHUZ6NE6ujRGM98HY3j9uxeIkYXkzK9S/TYzrlW9uwGmhfNN/kn1bdgiyUxQC8DXwTmVtPO6yX1tzNZfWXAYUE4oY=
X-Received: by 2002:a05:6214:5193:b0:630:1bc8:9c7 with SMTP id
 kl19-20020a056214519300b006301bc809c7mr17681678qvb.2.1687565108078; Fri, 23
 Jun 2023 17:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687375189.git.anupnewsmail@gmail.com> <4d0ac80521ebd44322a360ac331ce2443a1f0f26.1687375189.git.anupnewsmail@gmail.com>
In-Reply-To: <4d0ac80521ebd44322a360ac331ce2443a1f0f26.1687375189.git.anupnewsmail@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 23 Jun 2023 17:04:56 -0700
Message-ID: <CAM9d7cgAfvzrGiU0QiEigTAYKMe+OEP0b3o3Xd-0VhXX5Wkx1g@mail.gmail.com>
Subject: Re: [PATCH 7/9] scripts: python: implement get or create frame function
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

On Wed, Jun 21, 2023 at 12:45 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
>
> The CATEGORIES list and the USER_CATEGORY_INDEX and
> KERNEL_CATEGORY_INDEX constants has been introduced.
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
>  .../scripts/python/firefox-gecko-converter.py | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> index 30fc542cfdeb..866751e5d1ce 100644
> --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -15,6 +15,13 @@ def isPerfScriptFormat(profile):
>      firstLine = profile[:profile.index('\n')]
>      return bool(re.match(r'^\S.*?\s+(?:\d+/)?\d+\s+(?:\d+\d+\s+)?[\d.]+:', firstLine))
>
> +CATEGORIES = [
> +{'name': 'User', 'color': 'yellow', 'subcategories': ['Other']},
> +{'name': 'Kernel', 'color': 'orange', 'subcategories': ['Other']}
> +]
> +USER_CATEGORY_INDEX = 0
> +KERNEL_CATEGORY_INDEX = 1
> +
>  def convertPerfScriptProfile(profile):
>      def _createtread(name, pid, tid):
>          markers = {
> @@ -70,6 +77,37 @@ def convertPerfScriptProfile(profile):
>                  stackMap[key] = stack
>              return stack
>
> +        frameMap = dict()
> +        def get_or_create_frame(frameString):
> +            frame = frameMap.get(frameString)
> +            if frame is None:
> +                frame = len(frameTable['data'])
> +                location = len(stringTable)
> +                stringTable.append(frameString)
> +
> +                category = KERNEL_CATEGORY_INDEX if frameString.find('kallsyms') != -1 or frameString.find('/vmlinux') != -1 or frameString.endswith('.ko)') else USER_CATEGORY_INDEX

This line is too long, we usually don't allow long lines
over 100 characters.

Thanks,
Namhyung


> +                implementation = None
> +                optimizations = None
> +                line = None
> +                relevantForJS = False
> +                subcategory = None
> +                innerWindowID = 0
> +                column = None
> +
> +                frameTable['data'].append([
> +                    location,
> +                    relevantForJS,
> +                    innerWindowID,
> +                    implementation,
> +                    optimizations,
> +                    line,
> +                    column,
> +                    category,
> +                    subcategory,
> +                ])
> +                frameMap[frameString] = frame
> +            return frame
> +
>          def addSample(threadName, stackArray, time):
>              nonlocal name
>              if name != threadName:
> --
> 2.34.1
>
