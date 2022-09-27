Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728E65ECAD6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiI0R2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiI0R2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:28:33 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D59E1D2615;
        Tue, 27 Sep 2022 10:28:29 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-12803ac8113so14176345fac.8;
        Tue, 27 Sep 2022 10:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=A4Hgdsgb0R0NQiBo/wcOatV1qpXWwyQV6akvHd7chNk=;
        b=5dIk6SNv6sD3xw4uoILP2VCnIFZNWCbTy2/xDaRv6cLBkn7xpID7+g9lpj+hYzGtod
         b87PtZlUQrrUZh6tMCNwMt2FVPcZ6tO10WmlXUxIiFY9qFWYsfB0yeayr7thq3ebreLW
         eHD0K+X+VXLfjFiyxcdK2ZuW+JWYLfKFNjn2sYLWdy5sgibDNPA15Xj/zKEonTgTmzJL
         9rHk3YmJxwuqRStSQgRIdvfFHHtPEw+I1X6Xtg9f/ssSUrc2URTcbsPtp+KUxZsj4Wvn
         sjBFHmWtpLwsmiVSrQ+G0FB35dd1yzGalonJndiKGBQLrSm2r33cXfC/W4vRXe7f+xGY
         tWPw==
X-Gm-Message-State: ACrzQf2pD1yVj8aLDOT/oTslsEVUZzxf+mK4jPMEPBNJ6rx8usQT4nFC
        2oPLgYzNe0ZxpJd+IYBoBUA6ACDuZmIV8K1wYIU=
X-Google-Smtp-Source: AMsMyM6r/HSLwYcRSAmNP2HJo8uW4AMK/Jo6YTb/Lt64GJJW24vG65SQbRiIVsgzICBGsNyVzuCXUBH7GJCmSSltvkY=
X-Received: by 2002:a05:6870:a70f:b0:127:666a:658 with SMTP id
 g15-20020a056870a70f00b00127666a0658mr2897216oam.218.1664299708381; Tue, 27
 Sep 2022 10:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220924165737.956428-1-namhyung@kernel.org> <20220924165737.956428-3-namhyung@kernel.org>
 <d901f8c8-0dda-8f34-f963-09cf56d4924e@intel.com>
In-Reply-To: <d901f8c8-0dda-8f34-f963-09cf56d4924e@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 27 Sep 2022 10:28:17 -0700
Message-ID: <CAM9d7ciGFqSRO=J6FZmz=enML7eCyvRMQB+bm=nZ07GmozJwbw@mail.gmail.com>
Subject: Re: [PATCH 2/5] libperf: Propagate maps only if necessary
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, Sep 27, 2022 at 12:06 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 24/09/22 19:57, Namhyung Kim wrote:
> > The current code propagate evsel's cpu map settings to evlist when it's
> > added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
> > be updated in perf_evlist__set_maps() later.  No need to do it before
> > evlist's cpus are set actually.
> >
> > Actually we discarded this intermediate all_cpus maps at the beginning
> > of perf_evlist__set_maps().  Let's not do this.  It's only needed when
> > an evsel is added after the evlist cpu maps are set.
>
> That might not be true.  Consider evlist__fix_hybrid_cpus() which fiddles
> with evsel->core.cpus and evsel->core.own_cpus after the evsel has been
> added to the evlist.  It can also remove an evsel from the evlist.

Thanks for your review.  I think it's fine to change evsel cpus or to remove
an evsel from evlist before calling evlist__create_maps().  The function
will take care of setting evlist's all_cpus from the evsels in the evlist.
So previous changes in evsel/cpus wouldn't be any special.

After this point, adding a new evsel needs to update evlist all cpus by
propagating cpu maps.  So I think hybrid cpus should be fine.
Did I miss something?

>
> There might be other cases like that, but that was just one that stuck
> out.

Thanks for sharing your concern.  Please let me know if you could
come up with another.

Namhyung
