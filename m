Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C47D62CE7E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiKPXHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiKPXHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:07:02 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92A352882;
        Wed, 16 Nov 2022 15:07:01 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id v81so58391oie.5;
        Wed, 16 Nov 2022 15:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exwunUZ/kcqkAH6HVxuBc9I6bVs9+z6PsdO9s6kIF5o=;
        b=QHVRNnJluOIk5mwqA/oPdyz5t8RgnM+Y5gWIUPvPINw3WhpH3TDrLq9nQiobVEbZ8Q
         sheojxhE/Ui3wqsbrkoXb+GQCEwd9hRBePYa698FzXDr0ApU2nIc9taJMexXXgi7uPfx
         Ep84OrW/9ciGa1uCJhQILNJUnx7Uw6YtLjiWMjkCA8SjYflr4GVTT+JPXCxMMbGDiCTw
         ++P0oHNwgISSUZ3BGAXVnH9CyNE2bCfFf7oTo6WB5bu/B5Pl/11CDZszFoR2XJyjwWKt
         1YJzGzVc/yi7BrphN9SCl4xT5/1HoC8289+q9KANOgVbyJgdg1Un7xjDMPX8B7Ih+8YI
         w1IA==
X-Gm-Message-State: ANoB5plihTjmzolTDq2PUKoV2DzipqyenqzR3k3b6Y1/Qeb+juQJ+fFc
        z4ViMVgjBzL8mR2rLYiTsUgKNudgdGAArowzTUE=
X-Google-Smtp-Source: AA0mqf7X5fTQrBEK3PHi9gyxnFVRnOqSYNQoHd6MBnp8JMgtGMPwPhfUB9Uyt096rPWornfdybIqy8VZHMsGx4Za9y8=
X-Received: by 2002:aca:654d:0:b0:35a:812c:3eae with SMTP id
 j13-20020aca654d000000b0035a812c3eaemr2752516oiw.218.1668640020942; Wed, 16
 Nov 2022 15:07:00 -0800 (PST)
MIME-Version: 1.0
References: <20221110181920.84900-1-namhyung@kernel.org> <20221110181920.84900-10-namhyung@kernel.org>
 <86c42368-cbbb-2e13-ce7d-31865a12bb81@arm.com>
In-Reply-To: <86c42368-cbbb-2e13-ce7d-31865a12bb81@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 16 Nov 2022 15:06:49 -0800
Message-ID: <CAM9d7ch3x4f3vNFhixjpHrcco=ifgCaYD6XYwRS_vMX_CjB43g@mail.gmail.com>
Subject: Re: [PATCH 09/12] perf test: Add 'brstack' test workload
To:     James Clark <james.clark@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Wed, Nov 16, 2022 at 3:39 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 10/11/2022 18:19, Namhyung Kim wrote:
> [...]
> > +
> > +#define BENCH_RUNS 999999
> > +
> > +static volatile int cnt;
> > +
> > +static void brstack_bar(void) {
> > +}                            /* return */
> > +
> > +static void brstack_foo(void) {
> > +     brstack_bar();          /* call */
> > +}                            /* return */
> > +
> > +static void brstack_bench(void) {
> > +     void (*brstack_foo_ind)(void) = brstack_foo;
> > +
> > +     if ((cnt++) % 3)        /* branch (cond) */
> > +             brstack_foo();  /* call */
> > +     brstack_bar();          /* call */
> > +     brstack_foo_ind();      /* call (ind) */
> > +}
> > +
> > +static int brstack(int argc, const char **argv)
> > +{
> > +     if (argc > 0)
> > +             cnt = atoi(argv[0]);
> > +
> > +     while (1) {
> > +             if ((cnt++) > BENCH_RUNS)
> > +                     break;
>
> Hi Namhyung,
>
> I'm reading this as you can specify the number of loops as an argument.
>
> In that case should it be more like this?
>
>         int num_loops = argc>0 ? atoi(argv[0]) : BENCH_RUNS;
>
>         if ((cnt++) > num_loops)
>                 break;

Yep, that's more intuitive.  Will change!

Thanks,
Namhyung
