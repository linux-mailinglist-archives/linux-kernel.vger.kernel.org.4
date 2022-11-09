Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D7F623203
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiKISEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiKISE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:04:29 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1A41D0;
        Wed,  9 Nov 2022 10:04:28 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so20515852fac.1;
        Wed, 09 Nov 2022 10:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p46dqoJSw8bP5Xrwkyogv/cFNXRfHSlK4u22fVva9CE=;
        b=cJO4q64CevlsFKKyxFNc4HpeGLx4Ba+ys5qVXeIkG+TblZJmFEuOvYnIQUw/rXL2yu
         1mcjCVtgPx+HJ+4ExkaYxZsiLQK3FMfjzIg/uNmpj8jMSoz4oUpegMbK1GIe/WOO4ki9
         YH53MZjzLaCUyPPprv0ApUAYCLQa5icpMcJ5Hl2kZhHI8GCd666LdE2CrQzo60rMhfsN
         s3eXWZpf4YQ0NjGtnp0x5HKX8NOXdTYWGwZjj0esP6Bc7fXmKQtb9WjZNCiJvkHvkGNe
         aSOeALZbD5Xyez1Ux5v/h2UEbnlUbOMBv+V+WdaHpHmIsFIdiF23/8FhJT+tFLqni308
         8HQw==
X-Gm-Message-State: ACrzQf0tK4JXzMKh7beSTQoUJIlBl+Ksa90AZ19EfSVkPo2w/3Qutxta
        uCmdMUZiBznYTXCajjO/YlHAY4rfunNcP2KrblI=
X-Google-Smtp-Source: AMsMyM4PNbiHpCGT33PlBOe4Cjvqr2v9IFss8aL/nIZa7B6W80YX9Tphnu1annkI0XjuxDwSGg3kcxJ7nmcklnQgoL0=
X-Received: by 2002:a05:6870:9a27:b0:140:6f4c:f532 with SMTP id
 fo39-20020a0568709a2700b001406f4cf532mr16454902oab.209.1668017068196; Wed, 09
 Nov 2022 10:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20221107213314.3239159-1-namhyung@kernel.org> <20221107213314.3239159-5-namhyung@kernel.org>
 <CAP-5=fXOsQFGo90mg8yRvgMF3k4-s51-HC-n0+1hnE=4VR-rew@mail.gmail.com>
In-Reply-To: <CAP-5=fXOsQFGo90mg8yRvgMF3k4-s51-HC-n0+1hnE=4VR-rew@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Nov 2022 10:04:17 -0800
Message-ID: <CAM9d7cjmVsd4FU5a73vCmg9pgosQUAipTABi5Agjj92W8=9YJA@mail.gmail.com>
Subject: Re: [PATCH 4/9] perf stat: Move common code in print_metric_headers()
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
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

On Tue, Nov 8, 2022 at 3:19 PM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Nov 7, 2022 at 1:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The struct perf_stat_output_ctx is set in a loop with the same values.
> > Move the code out of the loop and keep the loop minimal.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Acked-by: Ian Rogers <irogers@google.com>
> Could also potentially make it const, but functions it is passed to
> would also need changing.

I'll consider when I work on it later.

Thanks,
Namhyung
