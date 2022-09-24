Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7505E5E8E99
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiIXQuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIXQuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:50:18 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DB82CE0F;
        Sat, 24 Sep 2022 09:50:16 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-11eab59db71so4125530fac.11;
        Sat, 24 Sep 2022 09:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cx1vUNHT+5IRDwqfYkN5MeQ6W29Z+utD9fw1z+nI1u8=;
        b=ulFR17KqcNE/Y7NP5BQSM8WQn4zcNTEY+EagT3x47jsJGUCw6MuCmzD7jdKa32rSBD
         QbQt+jkPGw5yVXXhIJSODAaAKy+GramPCRufzLNUAdA/IGoY4vffchKAh1/9/+ceSA0i
         uETWR1AwzY8NF9rJW3LcZ+AzZvAMotT1+25jGXXMbeT7XTyu+kXEu+b8bksM/xZJb4wk
         vdC7J0BWM6OI0WufnzbagFxIbTA+p2oCGgomnB1uLEMR3X7I0f8hNPSdNm/kyQLtBop+
         Y0O/UEhS2BdfiqULvVUwTh6WgKPidAPUvfuUCA/9zDXOdIAtwriiOmc6F+grx8r7fKc9
         x+dQ==
X-Gm-Message-State: ACrzQf2ZGbbQ4K2TL0Eb/Z+IH5mCyDwEe14/DMFj5F7rYm64XbKLGHga
        tCKk54Yu80k3pxfFnDsGFknhmMvdxw+4tKBYz+I=
X-Google-Smtp-Source: AMsMyM7PvkY8CBrRg2ZS9etiXqDnby3hPjzd/kDK15h9/F6YAaBLZ7oFmIfc6TxF21rFbKZr3Rs6akiJZnuCl/zF2Ag=
X-Received: by 2002:a05:6870:524b:b0:12c:cfd2:81c0 with SMTP id
 o11-20020a056870524b00b0012ccfd281c0mr8003537oai.209.1664038215521; Sat, 24
 Sep 2022 09:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220924004221.841024-1-namhyung@kernel.org> <20220924004221.841024-3-namhyung@kernel.org>
 <7c89e623-c90f-181b-d22a-e1349ddb3340@intel.com>
In-Reply-To: <7c89e623-c90f-181b-d22a-e1349ddb3340@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 24 Sep 2022 09:50:04 -0700
Message-ID: <CAM9d7ciURCEeJGPDRtSN9U1JD7dtYWB_Mthf4m=Svw314ZtSvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf test: Add kernel lock contention test
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
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 1:10 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 24/09/22 03:42, Namhyung Kim wrote:
> > Add a new shell test to check if both normal perf lock record +
> > contention and BPF (with -b) option are working.  Use perf bench
> > sched messaging as a workload since it'd create some contention for
> > sending and receiving messages.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> There are a few things below that don't need to be fixed but
> are perhaps things to be aware of.
>
> Nevertheless:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks Adrian, I'll install and run shellcheck next time.

Arnaldo, please let me know if you want me to resend it
with the suggested changes.

Thanks,
Namhyung
