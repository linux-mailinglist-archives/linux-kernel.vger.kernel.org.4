Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B598E73BE2C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjFWR6h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 13:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjFWR6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:58:34 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916B4E41;
        Fri, 23 Jun 2023 10:58:33 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso887235276.2;
        Fri, 23 Jun 2023 10:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687543113; x=1690135113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBzWx4UIP8k3qiURWXrDdOAf2Oukk+lJsXvIVWYni3k=;
        b=VSycp+twxyna8h3LWId1hkfZPmCUnB+8IXQKqYKNn1DpgXyeUiBKw10lUKc3usSiNc
         zrSr+U1qoZEAzYXyeuMpWJVGArMhZZkPgAv0YKF9S1CR3tTeEoO5DREpxns21HJ8j5ld
         0CAE6T77OzGLTu1NXOQsDKDeyfE+AyUfg+FFa7p5GsgfdGQd9BBoXYxdn6oE2JJmkgzh
         XycsZlUOf/9s6MYryMBrkv+nGKoRhgKau6Aw8h16+CCrkklQpULjtuk2BsjbANriUKf4
         5i24nQe+G902v7hR45nijft5Xz/lb6Xra1Upy7Og69jN1DNOLOOnapUqkdL5PvuDx2nd
         6eAg==
X-Gm-Message-State: AC+VfDw7aP5C7uLbzfhCgsYgEHz0ER6+DFjicttXPukMkELatvapECz5
        n4XMY3BSC8pyYW4tVDCFkD4o/DSUeqnJjB15i4c=
X-Google-Smtp-Source: ACHHUZ7GVZBmFpy86YmhHMYaDsAsMGzRFcnXpRJNCx9ZOyu2mKEaVaYTFg7tchZISWMggug9v3tLjSG0OMcFuGWPvy4=
X-Received: by 2002:a05:6902:c5:b0:bd7:6810:6646 with SMTP id
 i5-20020a05690200c500b00bd768106646mr19448702ybs.44.1687543112757; Fri, 23
 Jun 2023 10:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230623043107.4077510-1-irogers@google.com> <64741e8e-e81a-afb9-9ce3-9c2d6baab44a@web.de>
 <CAP-5=fVwhiGJEqTST2bfX8cUALpnTxELSHrvKtyJEPjqQjOacQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVwhiGJEqTST2bfX8cUALpnTxELSHrvKtyJEPjqQjOacQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 23 Jun 2023 10:58:21 -0700
Message-ID: <CAM9d7cjVumJRV_hGnh1o-gn_NZGx0mnO7Fj2AyOWpkknBWT9Cg@mail.gmail.com>
Subject: Re: [PATCH v2] perf unwind: Fix map reference counts
To:     Ian Rogers <irogers@google.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
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

Hello,

On Fri, Jun 23, 2023 at 10:49 AM Ian Rogers <irogers@google.com> wrote:
>
> On Fri, Jun 23, 2023 at 9:18 AM Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > > v2. Add missing map__put when dso is missing.
> > > ---
> >
> > Please omit such version information from the change suggestion.
> >
> > See also:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4-rc7#n698
>
> ah, tldr. Will correct in the future.

Thanks for taking a look at this.  I moved it above the tag lines
this time.

>
> >
> > How do you think about to add the tag “Fixes”?
>
> In general we've not been adding Fixes as there is a danger a backport
> will introduce a use-after-free.

Right, this change depends on other changes.  Simply cherry-picking
this will result in unmatched ref count IIUC.

Applied to perf-tools-next, thanks!
