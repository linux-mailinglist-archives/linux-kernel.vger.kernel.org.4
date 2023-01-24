Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E444678F82
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 05:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjAXEtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 23:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjAXEti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 23:49:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F52366A0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 20:49:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y1so8206687wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 20:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DK6xaXE5oASyoDQtrld9FdvxBPYhIcRWULm9bEl36oc=;
        b=TwUkV4fDTn80NzdblDeqyIin7jJkGsyJZv9xSAjsM0BiUikLoxf1xGH8bY9R2rjHPk
         a4+Z3X4imr2ZpgYOMcxQWc0tsIhOYrT/y9aPK2Kzln2qjuB7zdGgCJMZQVTAbp00F+5V
         cAUDa1iXdcq13wWfbGtPGluLFs0fxCsTkvDpqJsYQAOD+zLvQZifMxj9JAKYIDbYetGC
         v4mKhvfMnTL3WsdDqv0tvPZyF9ePAUTW567psXo1g2Sk/ZyGTbaxsNA+GQoTzB+fmZgj
         vZPjxPitfgtSYrthW9g4vF67tPEG+JQdG6XsutwsBFSgKY9U+L5ACvzJLIZ9GYkh4Rss
         LU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DK6xaXE5oASyoDQtrld9FdvxBPYhIcRWULm9bEl36oc=;
        b=AYbGkSpWP3lx/zNchMxN8PK6nkLa54OpUxL2oayrPuDNBlppqYCRqgfH499Q9o4Q4j
         cTkLN91j2WSluhcX59YtldL2//xtN4jAnc3Mnf09FJDZ8Izbtt4d67N+jpPnaYPx/EdR
         841ITx90/yHA8fPM1AXc3nl7UrGMNvIcWdZgi62yH9ovtZB+9mDlM0p3jtJeJgjzvhWG
         /iT1fSCD7vOf7b4h1G04YELtk8c0+5qVDLJQv9ScXtMrzxO5x5GBBAe58k2TJF2PhXTX
         S0JdSsz6pTaBYpK5GSY3k1ENaLLm1Dh04S/PaDWc83TBhZGFLjw6oW31X940adoG82PX
         C7nQ==
X-Gm-Message-State: AFqh2kpniZSjkrLJnbthswaLgfYsRx05Shl5PqpYBzUXAnxGcrHMZfJN
        bf+W5vEgKKoURKfZ8SgcVPGf9LdtyxC9Bxo9VAlkeg==
X-Google-Smtp-Source: AMrXdXunWqevhFj8/tiwX31/k0NTL79Bsn3aXdolVljl3gNlXwKl2/xgYzhiUMRWVNro/K9uQqDGitK/0NB1Ie/+DpM=
X-Received: by 2002:a05:6000:1d9b:b0:2bc:aa47:bf7a with SMTP id
 bk27-20020a0560001d9b00b002bcaa47bf7amr674533wrb.343.1674535775796; Mon, 23
 Jan 2023 20:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20221221223420.2157113-1-irogers@google.com> <20221221223420.2157113-9-irogers@google.com>
 <f5d0e9f0-7076-07f5-483b-57eaee26ff3f@oracle.com>
In-Reply-To: <f5d0e9f0-7076-07f5-483b-57eaee26ff3f@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 23 Jan 2023 20:49:23 -0800
Message-ID: <CAP-5=fUmvgL77itaxQo15ptUo78s8yW39=rwq80ESsqVm5bG1A@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] perf jevents: Generate metrics and events as
 separate tables
To:     John Garry <john.g.garry@oracle.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
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

On Mon, Jan 23, 2023 at 7:18 AM John Garry <john.g.garry@oracle.com> wrote:
>
> On 21/12/2022 22:34, Ian Rogers wrote:
> > Turn a perf json event into an event, metric or both. This reduces the
> > number of events needed to scan to find an event or metric. As events
> > no longer need the relatively seldom used metric fields, 4 bytes is
> > saved per event. This reduces the big C string's size by 335kb (14.8%)
> > on x86.
> >
> > Signed-off-by: Ian Rogers<irogers@google.com>
>
> It would have been good to show an example of how the output changes. I
> could not apply the series (see cover), and knowing what to expect makes
> reviewing the code easier...
>
> Thanks,
> John

Thanks, will add in v3.

Ian
