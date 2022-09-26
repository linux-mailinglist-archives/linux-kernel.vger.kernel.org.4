Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F9D5EB35C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIZVmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIZVmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:42:37 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937B9A50EA;
        Mon, 26 Sep 2022 14:42:33 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-127ba06d03fso11022765fac.3;
        Mon, 26 Sep 2022 14:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+KcZVOe6xtv1ry2Jgrm4LTKRDPbLt0jHuqQFNWmEBt0=;
        b=iPST+DeNKA+biF0faph2OUmSCQhOTkqZrj+J/ezhHPq3T2DvNRncPkNfqsyUYQmVnN
         BAm//KcmS45hTnORdgrji5ww24H3PNXkUziC636Axjy/Txb6igSP2MM58ymculMOgO/D
         J2lhpZtSbIKRvTePdf0HkvA5aUfxLf5+Uju1Bgdr7f0qMCLZuZ2F+v9WdG1LwKJy+1yL
         yrXA0noqUeLVKaaVoisMTdo8AfikPtidwC7idoyCjnraPvhrWrSsI5CwNGmRQJYNv0I1
         UP0Psz/sI1bi9sQtuwQf1u6Y9SqBTSUHMOn6f498T0EAN/xos9vvlx/yHGuRUjHxAHfw
         AeKw==
X-Gm-Message-State: ACrzQf0LiUzRqgiQBb4ppA6V+/eUD4W3/NZpoRRry20e6TAPMPQadCNn
        pHzpO0cxwOcRwFjLmBPBK6nIVxVVp3o4r1Dta6g=
X-Google-Smtp-Source: AMsMyM480rPSaDt+OwSc6bVf0V7feDQiu8lz9RpVlS5umfCI5eq2YY/utCUB9zit7AGzbw0an9bcbF+jRPTqsViz9g0=
X-Received: by 2002:a05:6870:a70f:b0:127:666a:658 with SMTP id
 g15-20020a056870a70f00b00127666a0658mr433946oam.218.1664228552381; Mon, 26
 Sep 2022 14:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220802191004.347740-1-namhyung@kernel.org> <20220802191004.347740-3-namhyung@kernel.org>
 <a87d481e-adb7-b4e3-518b-2c4276d906e7@kernel.org>
In-Reply-To: <a87d481e-adb7-b4e3-518b-2c4276d906e7@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 26 Sep 2022 14:42:21 -0700
Message-ID: <CAM9d7ci27w7bqiZnAQYCZVtaPE8_f0Hbk_McqJB=F-F_4WPmQw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf lock: Print the number of lost entries for BPF
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Song Liu <songliubraving@fb.com>,
        Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Sep 26, 2022 at 1:05 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> Hi,
>
> On 02. 08. 22, 21:10, Namhyung Kim wrote:
> > Like the normal perf lock contention output, it'd print the number of
> > lost entries for BPF if exists or -v option is passed.  Currently it
> > uses BROKEN_CONTENDED stat for the lost count (due to full stack maps).
> ...
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> ...
> > @@ -73,6 +73,9 @@ int enabled;
> >   int has_cpu;
> >   int has_task;
> >
> > +/* error stat */
> > +unsigned long lost;
>
> I don't know how all this is generated into lock_contention.skel.h. But
> I believe this patch breaks perf build on 32bit:
> > [  375s] In file included from util/bpf_lock_contention.c:13:
> > [  375s] util/bpf_skel/lock_contention.skel.h: In function 'lock_contention_bpf__assert':
> > [  375s] util/bpf_skel/lock_contention.skel.h:537:9: error: static assertion failed: "unexpected size of \'lost\'"
> > [  375s]   537 |         _Static_assert(sizeof(s->bss->lost) == 8, "unexpected size of 'lost'");
> > [  375s]       |         ^~~~~~~~~~~~~~
>
> Should the above (and below too) be __u64?

Oops, it seems BPF ABI uses 8-byte long even on 32-bit systems.
Sorry for the inconvenience.  Will change.

Thanks,
Namhyung


>
> > --- a/tools/perf/util/lock-contention.h
> > +++ b/tools/perf/util/lock-contention.h
> > @@ -113,6 +113,7 @@ struct lock_contention {
> >       struct machine *machine;
> >       struct hlist_head *result;
> >       unsigned long map_nr_entries;
> > +     unsigned long lost;
>
> thanks,
> --
> js
> suse labs
>
