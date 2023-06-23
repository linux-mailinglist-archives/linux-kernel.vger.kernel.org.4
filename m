Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9758D73AFAD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjFWFA4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 01:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjFWFAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:00:45 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4311212C;
        Thu, 22 Jun 2023 22:00:35 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-bd6d9d7da35so225831276.0;
        Thu, 22 Jun 2023 22:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687496434; x=1690088434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cElT94Q2SNxLa5ji9VEO/IsbAAy21XvRJdRCIh4+/Co=;
        b=NW6L+ZZ7rz1KxgFgR0TeV1GMp51U+ZeK8oyaGiDNes0HU0HGtq94sOCHEQ/a4HJ8UA
         CqsSFeW5VTFFqFCjWRrgNx7fXMbKv+YinEv80Qv5VR51LQ5ZhkAFchpZUtxIWlQ23vaJ
         ZFy2DK0u4r94EAJ1sMxB3F7LraIpQBCRCZPKCu3jScMIXN9H2aDND8KYPnBpl2eG+HG7
         dGp3+aFCkhNTK2p0MHP6SBgy02WS0a1Q3sT/TuRoOsO/zpsqWKfmfsPHTEKK2hWGOSWx
         8KwrZvgPkPpNBPkHuYh5TbCDnX7PfsgRWKXoF2jhU7UVX1dP2KzSffcT9tiTLy3YwjFX
         lojg==
X-Gm-Message-State: AC+VfDyg71uhG84PGOllL2VfwbwNKRjqUpi1QPjk6cnmiWZ09vBN5/No
        dpTJEJYqVuF6ye3zNwDQcxbI8bJbO//IiXaE0A8=
X-Google-Smtp-Source: ACHHUZ6JXvy5pAXl+X9Gb8SahQwh36YPfLmnMR7ki5baEew8KJcLPgl6zvzQv1YH9WHaoMe+l0e8VlK0VCvBKvUmHZg=
X-Received: by 2002:a25:cf14:0:b0:c08:62b:60e9 with SMTP id
 f20-20020a25cf14000000b00c08062b60e9mr770674ybg.31.1687496433933; Thu, 22 Jun
 2023 22:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230622101809.2431897-1-james.clark@arm.com>
In-Reply-To: <20230622101809.2431897-1-james.clark@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Jun 2023 22:00:21 -0700
Message-ID: <CAM9d7ch3sN3gubQjdqUj=SQ7MQ4aCGs7YqpKyeyE3j=G0jzVJg@mail.gmail.com>
Subject: Re: [PATCH] perf tests: Fix test_arm_callgraph_fp variable expansion
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, spoorts2@in.ibm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, linux-kernel@vger.kernel.org
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

Hi James,

On Thu, Jun 22, 2023 at 3:18 AM James Clark <james.clark@arm.com> wrote:
>
> $TEST_PROGRAM is a command with spaces so it's supposed to be word
> split. The referenced fix to fix the shellcheck warnings incorrectly
> quoted this string so unquote it to fix the test.
>
> At the same time silence the shellcheck warning for that line and fix
> two more shellcheck errors at the end of the script.
>
> Fixes: 1bb17b4c6c91 ("perf tests arm_callgraph_fp: Address shellcheck warnings about signal names and adding double quotes for expression")
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/tests/shell/test_arm_callgraph_fp.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> index 1380e0d12dce..66dfdfdad553 100755
> --- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> +++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> @@ -15,7 +15,8 @@ cleanup_files()
>  trap cleanup_files EXIT TERM INT
>
>  # Add a 1 second delay to skip samples that are not in the leaf() function
> -perf record -o "$PERF_DATA" --call-graph fp -e cycles//u -D 1000 --user-callchains -- "$TEST_PROGRAM" 2> /dev/null &
> +# shellcheck disable=SC2086
> +perf record -o "$PERF_DATA" --call-graph fp -e cycles//u -D 1000 --user-callchains -- $TEST_PROGRAM 2> /dev/null &
>  PID=$!
>
>  echo " + Recording (PID=$PID)..."
> @@ -33,8 +34,8 @@ wait $PID
>  #      76c leafloop
>  # ...
>
> -perf script -i $PERF_DATA -F comm,ip,sym | head -n4
> -perf script -i $PERF_DATA -F comm,ip,sym | head -n4 | \
> +perf script -i "$PERF_DATA" -F comm,ip,sym | head -n4
> +perf script -i "$PERF_DATA" -F comm,ip,sym | head -n4 | \
>         awk '{ if ($2 != "") sym[i++] = $2 } END { if (sym[0] != "leaf" ||
>                                                        sym[1] != "parent" ||
>                                                        sym[2] != "leafloop") exit 1 }'
> --
> 2.34.1
>
