Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC4C639937
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 04:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiK0DOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 22:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiK0DOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 22:14:47 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76435F5AB
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 19:14:45 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so9072444wmb.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 19:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B7jJJzGDAdvwTHY0/uqqYf6jkjFWmT8EU2xpYpvXkds=;
        b=cePTeChGShsKFQLKo60/NW160lCTvZ5UIrzkfSGokNE7LKlkvAKqCkVlqiSB10KNPE
         8q1EoBmxueU34vR0QFvwtcqicOHoxW0GRYY69d1JNRddcLHtP9oZuM2MWykXPrj076S9
         pm9oXtrQrft7qGK2r1rnDgk/jb89gR7RHXElUier3GlZ0Ga31EGMJVTpLwEKZr0zYGBe
         wDUazPxKe3j1G+BtMnZgHpxQhSYJd0JklCht9o6K3yi8A2xjl5AVBHpCGQi1EBV6MEb+
         br+SgLKyfvmqRCtYdT/jbChq25oqeXmu8pX3S88Ni+J07UAb9iRnPOHuejNro3S2w5W7
         kOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7jJJzGDAdvwTHY0/uqqYf6jkjFWmT8EU2xpYpvXkds=;
        b=6xQBp2azoQJbsT40k862FkSj1RziW/1QeGj5jSsFDXMk5Nl9wiE4wpBinhY77BTOez
         vWcUeb7931z+p9Q91AczjvrQO2Nho3Ub/P9tchDKUmff+s/fF+8RXOlYc0h1239z0l/e
         U5CWczhGQBtwFmzznaZjbgsMLVgp6mj4LhlTE/vkG9yCKlJ/dDwXR0VZSIPi5YIYww8Z
         g9wfD/g9DQ21sYt3nm96NvtM8w4YJmQgTT5MlwO+T0GijPmW8kDqwu/H18ezUbViqzwk
         T7eM+NN137OBVatp8n64XcD8LuwHfsZiTS5cnOtyfBk6DhXJGfgZrm2LwShRBjtlm+ms
         KQLg==
X-Gm-Message-State: ANoB5pkXbr5aQqppoeL82xZbZE3fvRXZ3nEQqXfHFkjNhps5eVGqKnOX
        6wdu2/glsoUZETUUV94nBqI8yTqtsvDGXVviRYdhww==
X-Google-Smtp-Source: AA0mqf7LMoOeXBa4COl0lx2SMWDgnnyYM5Gy2YzqMQ8ChhQoXhTAJ9MTq7YA84e8LtYvn1kbeaJlNtnNfZtC+SoXNpE=
X-Received: by 2002:a05:600c:540a:b0:3d0:50c4:432c with SMTP id
 he10-20020a05600c540a00b003d050c4432cmr3448681wmb.67.1669518883874; Sat, 26
 Nov 2022 19:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-15-namhyung@kernel.org>
 <CAP-5=fVJjPXk2hmWc6xqDxe06Arq-nOB51CwihAuuVFAoaKJ4g@mail.gmail.com> <CAM9d7ciARxBRKpwf-8eQr-x5kR8n0Wv3RmycVFdO4ikeYhDVwg@mail.gmail.com>
In-Reply-To: <CAM9d7ciARxBRKpwf-8eQr-x5kR8n0Wv3RmycVFdO4ikeYhDVwg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 26 Nov 2022 19:14:31 -0800
Message-ID: <CAP-5=fWF7ScB0kHKQsqePHmg3sJf22TOfvKcNeYQdMoD0p8Tbg@mail.gmail.com>
Subject: Re: [PATCH 14/15] perf stat: Rename "aggregate-number" to "cpu-count"
 in JSON
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
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

On Thu, Nov 24, 2022 at 11:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Wed, Nov 23, 2022 at 3:31 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Nov 23, 2022 at 10:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > As the JSON output has been broken for a little while, I guess there are
> > > not many users.  Let's rename the field to more intuitive one. :)
> >
> > I'm not sure cpu-count is accurate. For example, an uncore counter in
> > a dual socket machine may have a CPU mask of "0, 36", ie one event per
> > socket. The aggregate-number in this case I believe is 2.
>
> You're right.  In case of uncore events, it can be confusing.  But in some
> sense it could be thought as cpu count as well since it aggregates the
> result from two cpus anyway. :)
>
> Note that the aggregate-number (or cpu-count) is only printed if users
> requested one of aggregation options like --per-socket or --per-core.
> In your example, then it could print 1 for each socket.
>
> But I think uncore events are different from core events, and hopefully
> they have separate instances for different sockets or something already.
> That means it doesn't need to use those aggregation options for them.
>
> Also the CSV output uses "cpus" for the same information.  It'd be nice
> we could have consistency.

So in the original patch from Claire she'd passed the name "number"
through to the json from the stat code. Having an integer called
"number" isn't exactly intention revealing - thank you for your clean
up work! :-) I switched "number" to be "aggregate number" as the
number comes from the "data" aggregated and the code refers to it as
aggregate data. I think aggregate-number is more consistent with the
code, and cpu-count would look strange in the uncore case above where
the number of CPUs (really hyperthreads) is 72. Perhaps we should also
be outputting the aggregation mode with the number. Anyway, I think
for the patch series I'd prefer we skipped this one and kept the rest.

Thanks,
Ian
> Namhyung
