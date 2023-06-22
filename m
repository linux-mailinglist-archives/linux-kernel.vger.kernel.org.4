Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B81473AC92
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjFVWeP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jun 2023 18:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFVWeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:34:11 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761DB26AB;
        Thu, 22 Jun 2023 15:34:00 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-bc9782291f5so1638276.1;
        Thu, 22 Jun 2023 15:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687473239; x=1690065239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1l4aMFEdO0xpytk7dXv95q+X9YwG7wxeJ0FzYDYOHe0=;
        b=ZWh4bOTzTIFFa7Jb8X484hkOzvOkRt9zQYifnrVd91nxilGaeD+DTZm2BTURugz45N
         1R/+5RItYwd8dbv54xZIkGp2nydzcDNlQuxICsVrosr9JNBO1RDPaE+Qy9LsEyXJuKyc
         TovEVtVIVYegIV0jIHKQX7rOLz242FngWL1okKHd+fSlnZBOELu0MJOkw4AJ4IGkGzUI
         WeObyTvsSo8sozKeUXUPHikNo4TLIhfHWjLVNFvcxVoA9mVkyW1UFl35t0lizm+MyGIF
         p9RsUZc/nlksCGiBBVxOoFvZXZy8eU680Tgs13cIbecm5Dm6b9XOiscN8jSAFfXvxlds
         lYVg==
X-Gm-Message-State: AC+VfDxjmt6rai8zag2ooeXG5pBcCqETzUJHGEj9Eb4hgoM3SEXG72Zi
        14F21T8VOZzcWNlDa03B6KKB7uGXcZm19RVL2bM=
X-Google-Smtp-Source: ACHHUZ7wmp5ZlK/YD8jhbJ0ww5BHVrS9AY0ql6wbq5yfg0IOLxbxiiLJkiV8HYnKE2uNGnX7pDx8tJxhcKTRsSI7eS4=
X-Received: by 2002:a25:abcb:0:b0:bc1:dfa5:83a4 with SMTP id
 v69-20020a25abcb000000b00bc1dfa583a4mr17891317ybi.13.1687473239508; Thu, 22
 Jun 2023 15:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <1684835873-15956-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4Es7qs54zr_hNPwn5MfgeLiKr3sgoTUP5iNj3JrH-1Uw@mail.gmail.com>
 <7a085947-9011-ebc9-a97d-7a62c755a978@loongson.cn> <1c3c95c7-54e9-a65a-2f63-3a16af0fc2bf@loongson.cn>
In-Reply-To: <1c3c95c7-54e9-a65a-2f63-3a16af0fc2bf@loongson.cn>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Jun 2023 15:33:48 -0700
Message-ID: <CAM9d7cj8mk_jAmK5KYrAJW248Nc1UY=_yD5BRBM+8aC+BaRBTw@mail.gmail.com>
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

Hello,

On Tue, Jun 20, 2023 at 9:36 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>
>
> On 06/08/2023 03:01 PM, Tiezhu Yang wrote:
> > Hi Arnaldo,
> >
> > On 05/23/2023 06:26 PM, Huacai Chen wrote:
> >> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> >>
> >> On Tue, May 23, 2023 at 5:57 PM Tiezhu Yang <yangtiezhu@loongson.cn>
> >> wrote:
> >>>
> >>> We can see the following definitions in bfd/elfnn-loongarch.c:
>
> ...
>
> >
> > Are you OK with this change?
> > Could you please pick it up in your tree?
>
> Ping. What is the status of this patch? Any more comments?
> Is there a chance to merge it for this coming merge window?

Sorry for the late reply,  I'll apply it to the perf-tools-next tree.

Thanks,
Namhyung
