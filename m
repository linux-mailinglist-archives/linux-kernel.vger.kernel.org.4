Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127F2673E46
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjASQJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjASQJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:09:40 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30305BBA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:09:34 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso1626107wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRlMrkR813xw68s+TrVy/K2U/XUSkpo54/blrWaVIz8=;
        b=F8Y78D/7lzBjdsiNq9oK2Aftmae0V2KIdzDV5yS2c3II/xVuoPuP9vZUsrzfVxdKRP
         3NO7XK9isDeRq4lGjY59X7D7klL/AWxqhuhSwJst4QRVPPz9wDlcoYKJvD48ghFGdOYE
         Eg8mqKHPfxxA7wSRdz2uEfqK/EgMEkVCCwmuOn4L6oFlFucegxSDQruJ/beTxqg3fGWg
         hB+dTGqwGM79sscfICtcqmWCXbwz767MyRfb03hbpgtPG7WwCrJ3C08rii/vG9ts4jBQ
         evwulTau7Wet3DMhcSPkrLQqUX6PI/0sxOz2RXdZ5bCSIizzTh0ubm2XNzqTxvEJd+Pu
         G85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRlMrkR813xw68s+TrVy/K2U/XUSkpo54/blrWaVIz8=;
        b=mi5PXqGMTq9Diop/ePBEA1SAuPCmf34RzLfNXlxfsJ6HofsAZFK1I3NAY4F+BYZZD/
         /HZupl2lHKeGoBS/VmeE9taUGsvGE8+n937GHdfaov95OP1J68Vukene/PyL3rFAITNP
         hoeHo5fFrLgT94UkJkle6+UDlObxNvxb8PU5bFr6ngFi0U2YFW5Wx28+EnvCxdzOB5H7
         UCZUlWtAn2oc1QtPYmPPJDWyu3WCgoVy+n4u+P1b0Dj3TO/nSUGk5PJGim2DM2jrmVCD
         McVvRaIhYNiZS2sge6CaLVTWCA5qwr2fWOalWGDOIL47hKMkMlFqvBQyBDughMaCQxri
         YsCw==
X-Gm-Message-State: AFqh2kqSosm3kbtBv/dSnqZKxJ9p7y1umjU7kRN1es5MOVvS7U6M6sK1
        GNJdGxb2a583B/Bo5XVRUqQfRpRVt7hMfWuIAYgUtQ==
X-Google-Smtp-Source: AMrXdXs82Lfvn39C8FUbgYvVTafPAnd33NZRzk0q5hkSRux34CNUZPOOgIn6fTLI2LgZiQwTLnCbVssAGAuKg9RyXEU=
X-Received: by 2002:a05:600c:5405:b0:3d0:50c4:432c with SMTP id
 he5-20020a05600c540500b003d050c4432cmr671355wmb.67.1674144572770; Thu, 19 Jan
 2023 08:09:32 -0800 (PST)
MIME-Version: 1.0
References: <20230114215251.271678-1-irogers@google.com>
In-Reply-To: <20230114215251.271678-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 Jan 2023 08:09:21 -0800
Message-ID: <CAP-5=fXJ3oG3GmG7puq+n9W3mQYfmdx37jq548Wf1_6hcpja2g@mail.gmail.com>
Subject: Re: [PATCH v1] perf test workload thloop: Make count increments atomic
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Jan 14, 2023 at 1:53 PM Ian Rogers <irogers@google.com> wrote:
>
> The count variable is incremented by multiple threads, doing so
> without an atomic operation causes thread sanitizer warnings. Switch
> to using relaxed atomics.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/workloads/thloop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
> index 29193b75717e..af05269c2eb8 100644
> --- a/tools/perf/tests/workloads/thloop.c
> +++ b/tools/perf/tests/workloads/thloop.c
> @@ -20,7 +20,7 @@ static void sighandler(int sig __maybe_unused)
>  noinline void test_loop(void)
>  {
>         while (!done)
> -               count++;
> +               __atomic_fetch_add(&count, 1, __ATOMIC_RELAXED);

Ping. No functional change, cleans up a lot of thread sanitizer
issues, the use of __atomic_fetch_add is consistent with other files.

Thanks,
Ian

>  }
>
>  static void *thfunc(void *arg)
> --
> 2.39.0.314.g84b9a713c41-goog
>
