Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75475B7945
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiIMSTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiIMSSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:18:44 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A323A67CBC;
        Tue, 13 Sep 2022 10:29:05 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so3203761otu.7;
        Tue, 13 Sep 2022 10:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fmdMytbW7qsWbZoZ6AaYxNZfbU1oq/hxMCvqPD9NxQY=;
        b=evvxnxl7i51wnvNLJnCg8wHybLttsfthQBffgT3t8HfMoUSbeSv1pSfO5dWHLl2T+u
         85qLJZLKxvsuNdxsoTlHQtWexBNyqeCRrM2431HZp9pgKeerG0fqDk4pKTBfvw/xSdXn
         G20f6Hd0FcOheHv6rTY7N9hMp2aCUHqK53tqswmXAzmNsnKQlS9foFShs7YHgLuGu7Xw
         9L4d72Q2g7E+AB4CA95MJgBtuwwitpkJKmSRtsSq9P44hBSnQ22NBGR0BNWGq3Olsyr1
         qoFe5RxgBvvYhCRZNPpd27LI2s5Sg1Nm2T9RhxZDa6+JJDGFjz+fIQwIuD6zg4vIopaT
         NSZQ==
X-Gm-Message-State: ACgBeo3KghRZq1oLeoGMXRagkkrd56YRSLGzPHuuTidrUM07Ytlm+4Kw
        Vh0/Cybz9mjpvVZaNrx7vYvyTlP7Mhr24V2AqrE=
X-Google-Smtp-Source: AA6agR5M7O62vb84c+K+p2La5GX5nrKthW0djIO6S3P3j+Re/Xgz9xXuDFCWX67HO7l1lv4EoBJxVD2T3wSbwpOUYlA=
X-Received: by 2002:a9d:7442:0:b0:655:df84:5bd3 with SMTP id
 p2-20020a9d7442000000b00655df845bd3mr4725571otk.155.1663090144800; Tue, 13
 Sep 2022 10:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220907064645.1197894-1-namhyung@kernel.org> <20220907064645.1197894-6-namhyung@kernel.org>
 <f69ccb77-b60a-c901-3bec-5b8d1a518043@intel.com>
In-Reply-To: <f69ccb77-b60a-c901-3bec-5b8d1a518043@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 13 Sep 2022 10:28:53 -0700
Message-ID: <CAM9d7chGXx8_py96rvt1dKP31u+D7LjzD81_K4foojb5=6Uk-w@mail.gmail.com>
Subject: Re: [PATCH 5/6] perf test: Add target workload test in perf record tests
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, Sep 13, 2022 at 4:03 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 7/09/22 09:46, Namhyung Kim wrote:
> > Add a subtest which profiles the given workload on the command line.
> > As it's a minimal requirement, test should run ok so it doesn't skip
> > the test even if it failed to run the perf record.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/shell/record.sh | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> > index bd4ef60948bd..ff66e58f3a26 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -167,11 +167,42 @@ test_system_wide() {
> >    echo "Basic --system-wide mode test [Success]"
> >  }
> >
> > +test_workload() {
> > +  echo "Basic target workload test"
> > +  if ! perf record ${testopt} -o ${perfdata} ${testprog} 2> /dev/null
> > +  then
> > +    echo "Workload record [Failed record]"
> > +    err=1
> > +    return
> > +  fi
> > +  if ! perf report -i ${perfdata} -q | egrep -q ${testsym}
> > +  then
> > +    echo "Workload record [Failed missing output]"
> > +    err=1
> > +    return
> > +  fi
> > +  if ! perf record -e cpu-clock,cs --threads=package ${testopt} \
> > +    -o ${perfdata} ${testprog} 2> /dev/null
> > +  then
> > +    echo "Workload record [Failed recording with threads]"
> > +    err=1
> > +    return
> > +  fi
> > +  if ! perf report -i ${perfdata} -q | egrep -q ${testsym}
> > +  then
> > +    echo "Workload record [Failed missing output]"
>
> When testing, this was happening always until changing the delay
> from 3 to 1 ms.  It might be a bit racy to work consistently on
> different machines.
>
> Another approach is to wait for threads to appear in /proc/N/task
> like wait_for_threads() here:
>
>         https://lore.kernel.org/linux-perf-users/20220912083412.7058-12-adrian.hunter@intel.com/T/#u

Looks good.  Maybe we can move it to tests/shell/lib ?

Thanks,
Namhyung
