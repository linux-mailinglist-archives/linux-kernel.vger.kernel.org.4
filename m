Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323AB749527
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjGFF4M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 01:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGFF4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:56:10 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD391732;
        Wed,  5 Jul 2023 22:56:06 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so3095835e9.3;
        Wed, 05 Jul 2023 22:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688622964; x=1691214964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TqatMR75Z/5NsmIWgZ6TKjuBUALAv5Ok5UmFVZ5PDI=;
        b=gc1yXiK/rVVKRAY1y1Bq/NaIAfP8k2zh4nPpbTZX0hLxithSkZFlmpZ9iXVWkXhfwg
         NfVxJS6Z4rYeXBR6C5+gyv4ToAtXAYkpXFTqUz6q0z+Nhx8Sdm+MhCdEDdqEQQtFGGHn
         zuMC/frJnq6RMligi7Hh711LcBESwVQuf8iL3pRLSpv09yk2n3HcWKQhqZkbes+7baeX
         s514t9hQeMVxhkEn38QaTv95qgRYHAur0pTgNuQxaLiVXreTKyuVArf6Ap0VUazExKyb
         v75/xXfxvaKc0mGtFw6aEZRh5mHIXB3btXp+pyDKVdCFXgP6VTo4h9/8bIQD4jKoGwXe
         nStQ==
X-Gm-Message-State: ABy/qLYLa+Q6+2ZiwiBlq9X1qwdJUenegWqo3VP+L3W9YcIvkWmdmaWh
        1Q2lN/Ebj+d2bkydmbz/gPubvnSUMHI9wFN63wA=
X-Google-Smtp-Source: APBJJlGzOMIzE6PdWI53JFF+hk1odHvngeGn3SwfzEoe4mCpvOrbV3IEani/9sxrdbVrMP+TAuwX0RY8QSGs556Axdo=
X-Received: by 2002:a7b:c3cc:0:b0:3fb:c225:a75e with SMTP id
 t12-20020a7bc3cc000000b003fbc225a75emr479061wmj.24.1688622964426; Wed, 05 Jul
 2023 22:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688585597.git.anupnewsmail@gmail.com> <d432405a93438f1780a767567b69bcdab32e1683.1688585597.git.anupnewsmail@gmail.com>
In-Reply-To: <d432405a93438f1780a767567b69bcdab32e1683.1688585597.git.anupnewsmail@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 5 Jul 2023 22:55:52 -0700
Message-ID: <CAM9d7ciAeGJ=n6DiR9=0K1AmN1mLoYXqYVjFFEPPD8UnRrstoA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] scripts: python: implement get or create stack function
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
> The get_or_create_stack function is responsible for retrieving
> or creating a stack based on the provided frame and prefix.
> It first generates a key using the frame and prefix values.
> If the stack corresponding to the key is found in the stackMap,
> it is returned. Otherwise, a new stack is created by appending
> the prefix and frame to the stackTable's 'data' array. The key
> and the index of the newly created stack are added to the
> stackMap for future reference.
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  tools/perf/scripts/python/firefox-gecko-converter.py | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> index e56864e78dc1..6f69c083d3ff 100644
> --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -65,6 +65,17 @@ def process_event(param_dict):
>                         },
>                         'data': [],
>                 }
> +               stringTable = []
> +
> +               stackMap = dict()
> +               def get_or_create_stack(frame, prefix):
> +                       key = f"{frame}" if prefix is None else f"{frame},{prefix}"
> +                       stack = stackMap.get(key)

I'm confused about what the 'stack' is.

> +                       if stack is None:
> +                               stack = len(stackTable['data'])

It seems like a kind of index for the stackTable's data.

> +                               stackTable['data'].append([prefix, frame])
> +                               stackMap[key] = stack
> +                       return stack

So this function returns an index, right?

Thanks,
Namhyung


>
>         def _addThreadSample(pid, tid, threadName, time_stamp, stack):
>                 thread = thread_map.get(tid)
> --
> 2.34.1
>
