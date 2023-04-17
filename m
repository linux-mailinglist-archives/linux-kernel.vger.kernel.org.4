Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3816E4E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjDQQiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDQQh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:37:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F726E8E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:37:54 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f04275b2bdso229355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681749472; x=1684341472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y12t8FRkoyEyk0bMe914lw6E/czb3SRxw59S8iZC1Uc=;
        b=rxk+Nn8PufS+81nHUs0I+UFtsIkcSBXz1RKFi5fJB965/TPvLrweGYeLPOTXZ02XKT
         OEOmwfqB0XI8VvZPHCRurH11Z/mogCp1qS/TxBmUVHdxwJx8lnmcYpE25TGkn4uBWHxK
         LwOm7NzW9Hplzq2bTSzt4d52ivZct0TKdb07VqrDcOVL05YyfplHoFaYZHH7ospcATEK
         QE3IJnFkRqyHWboxfG0bY8tDwTE7nHpqldYkzNBDIf9os4FouvX0EPbEjqz3TNnLczBu
         wlDUSbje1v/HBKqyMdFFas+Y2QX06wSEqfXx9Jy1tV6nVXfV++JEt41h14hnITy3XKuB
         qpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681749472; x=1684341472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y12t8FRkoyEyk0bMe914lw6E/czb3SRxw59S8iZC1Uc=;
        b=M5Is25YFsRoxBY1s0v51bRP/6QG0quZGQy4oXr1pMgvXZv7G6p/eDBD4tU0C77lMuT
         sQpyZE38CZrMQDfKvzrlpjjKVLNhMPIskHFlbkUPTOR0AsqEPOOl4H6YjAoLJspkwgRH
         QXXxc+xNDKYJYkx8RpBru0vPntElsejtkxKlrNmml7r7Y8MEmr18nOwD3dvo3V8VwKvi
         NZ90XTmkqB/ecdcBuQVNMJZ5v0b4SwWbE+xsKSv8fVOVRiSYaCkwXo4fMymEvJY1DxoA
         fPBEjb4MVCFTGSmtICUAeSbBj3XzcFQUYFp2Ih3ovB+p2YlBmzodirvuq+Buvrr2Eyzt
         KqSg==
X-Gm-Message-State: AAQBX9cl9U1h+ACSdXSaCe3+ecmN2n8NHPLu8QWEQdudKRzipNhXcwUn
        O8A7ybFqx0L+pNdfVMdOyabgNGzU2atYaOPlpzTQcQ==
X-Google-Smtp-Source: AKy350b/PcbvwgUXhKj6FKeyq2/NAraVnaIx3D3A7ebH0CLGWn7aqmil2UrIQTjqxwwrE6wNX+7RY2IZF63wyGwJEjs=
X-Received: by 2002:a05:600c:c13:b0:3f1:6fe9:4a98 with SMTP id
 fm19-20020a05600c0c1300b003f16fe94a98mr412681wmb.5.1681749472307; Mon, 17 Apr
 2023 09:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230414082300.34798-1-adrian.hunter@intel.com> <20230417110221.GH83892@hirez.programming.kicks-ass.net>
In-Reply-To: <20230417110221.GH83892@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 17 Apr 2023 09:37:37 -0700
Message-ID: <CAP-5=fUD=RNqD-7229J5fgaUCMtNiu-urp-9B3LDq8JnP2sGBg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] perf: Add ioctl to emit sideband events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 4:02=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Apr 14, 2023 at 11:22:55AM +0300, Adrian Hunter wrote:
> > Hi
> >
> > Here is a stab at adding an ioctl for sideband events.
> >
> > This is to overcome races when reading the same information
> > from /proc.
>
> What races? Are you talking about reading old state in /proc the kernel
> delivering a sideband event for the new state, and then you writing the
> old state out?
>
> Surely that's something perf tool can fix without kernel changes?

So my reading is that during event synthesis there are races between
reading the different /proc files. There is still, I believe, a race
in with perf record/top with uid filtering which reminds me of this.
The uid filtering race is that we scan /proc to find processes (pids)
for a uid, we then synthesize the maps for each of these pids but if a
pid starts or exits we either error out or don't sample that pid. I
believe the error out behavior is easy to hit 100% of the time making
uid mode of limited use.

This may be for something other than synthesis, but for synthesis a
few points are:
 - as servers get bigger and consequently more jobs get consolidated
on them, synthesis is slow (hence --num-thread-synthesize) and also
the events dominate the perf.data file - perhaps >90% of the file
size, and a lot of that will be for processes with no samples in them.
Another issue here is that all those file descriptors don't come for
free in the kernel.
 - BPF has buildid+offset stack traces that remove the need for
synthesis by having more expensive stack generation. I believe this is
unpopular as adding this as a variant for every kind of event would be
hard, but perhaps we can do some low-hanging fruit like instructions
and cycles.
 - I believe Jiri looked at doing synthesis with BPF. Perhaps we could
do something similar to the off-cpu and tail-synthesize, where more
things happen at the tail end of perf. Off-cpu records data in maps
that it then synthesizes into samples.

There is also a long standing issue around not sampling munmap (or
mremap) that causes plenty of issues. Perhaps if we had less mmap in
the perf.data file we could add these.

Thanks,
Ian
