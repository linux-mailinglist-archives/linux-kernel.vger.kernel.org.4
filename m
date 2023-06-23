Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1C473BE3C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjFWSBl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 14:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjFWSBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:01:31 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9745A2724;
        Fri, 23 Jun 2023 11:01:29 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-bd729434fa0so896507276.1;
        Fri, 23 Jun 2023 11:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687543289; x=1690135289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrJkokJikgOCvzs7OI6rvSjtU00f06IG7Q3tiUY6Zfw=;
        b=Isnl0Y4So3K+0swczEUS30tIlaJqZZdAHOQnMcJd70cjbdDms/qujwMAW7MVE91ter
         q3LrJwHttgIuIjftucOfz3HYuHnEWzaE2aW+f79Wkth+B8wXiX1zKAbgHG9JiyuvVswX
         fH5+Pzhp60AkGuK0oMKHDc9hzJDIOyH/Ws7FdrD92yAEGbaC3liL3rwJeYi33jlI0TCB
         RKpCaIRPsPKAt09vmSd/27voHp/5ABJs3OtyepyvfLMZfW/BcO/To4dcYftTCSR98Z1R
         lbfvv31I6Z90PlCTxOsZqjuIxXu90P5hJ3298ooozl6oZBQw5N+9fsgbyb8HcrsbyIbC
         avkQ==
X-Gm-Message-State: AC+VfDy3NoI6yeOsWqdPslSYWi8e49hVP588JCU7lCjHIKsjBGIC7bVG
        pmKTnseKtVwD73Nd1m4d5Asha1zDoykOjNYUKio=
X-Google-Smtp-Source: ACHHUZ7gcMe3ibKA/hNp9Z4n8zg1/7efJ7VqDxtomIKEicWZSRCUJthxrmNt1VrTXT93ysYlhgzVdaLiU1DTdSiYx08=
X-Received: by 2002:a25:18d7:0:b0:bcd:f5f3:2e11 with SMTP id
 206-20020a2518d7000000b00bcdf5f32e11mr20184302yby.11.1687543288690; Fri, 23
 Jun 2023 11:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <1684835873-15956-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4Es7qs54zr_hNPwn5MfgeLiKr3sgoTUP5iNj3JrH-1Uw@mail.gmail.com>
 <7a085947-9011-ebc9-a97d-7a62c755a978@loongson.cn> <1c3c95c7-54e9-a65a-2f63-3a16af0fc2bf@loongson.cn>
 <CAM9d7cj8mk_jAmK5KYrAJW248Nc1UY=_yD5BRBM+8aC+BaRBTw@mail.gmail.com>
In-Reply-To: <CAM9d7cj8mk_jAmK5KYrAJW248Nc1UY=_yD5BRBM+8aC+BaRBTw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 23 Jun 2023 11:01:17 -0700
Message-ID: <CAM9d7cgZqyv6gPs=6LRNEgT_-PkRPz+TVRSSi-trSD9vb=59-A@mail.gmail.com>
Subject: Re: [PATCH v2] perf symbol: Add LoongArch case in get_plt_sizes()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
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

On Thu, Jun 22, 2023 at 3:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Tue, Jun 20, 2023 at 9:36 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> >
> >
> > On 06/08/2023 03:01 PM, Tiezhu Yang wrote:
> > > Hi Arnaldo,
> > >
> > > On 05/23/2023 06:26 PM, Huacai Chen wrote:
> > >> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> > >>
> > >> On Tue, May 23, 2023 at 5:57 PM Tiezhu Yang <yangtiezhu@loongson.cn>
> > >> wrote:
> > >>>
> > >>> We can see the following definitions in bfd/elfnn-loongarch.c:
> >
> > ...
> >
> > >
> > > Are you OK with this change?
> > > Could you please pick it up in your tree?
> >
> > Ping. What is the status of this patch? Any more comments?
> > Is there a chance to merge it for this coming merge window?
>
> Sorry for the late reply,  I'll apply it to the perf-tools-next tree.

Applied to perf-tools-next, thanks!
