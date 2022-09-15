Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7DB5BA093
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiIOSEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIOSEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:04:33 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36982AC6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 11:04:32 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id a129so20172299vsc.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=B39yVz8kfoXi9mPWUKj4p1A1YBukzP9yZODn/FRwN34=;
        b=rmF/6rm5AbUxOlAWAjHnEuBBUDdUmzp7069uHNHNDJ0FBMy8pKO08rbZHlr4SLj52i
         DbpHrkgcbXwsLulXw7OjYxioTiKV1ykhTEC2KshVHnWW+eeAVDOKGlcPvFAareKDetrW
         RlEtnrk7nYG+XD4N/yJTYYRBQ/3U2X9ce0ecO3i1/OMFQEEld3aa/Ig4nIQaiplx80Hc
         NdlkOhA8m5ijRYuQjlDVRQPOCMo20eGg7Z0Hj6QJmiH48bZRulFP8Ek1Sx4rPlpzkT3j
         UbuoTEsEOUTXBojEM3fbiW5m3cn11MYMa6AaCbPETdM5IlQ25q5p+hCdqHsdpSzX3LwC
         JHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=B39yVz8kfoXi9mPWUKj4p1A1YBukzP9yZODn/FRwN34=;
        b=HQQeKW5Nt0hbhBAr6e+Fq6ibrneSjbw2W7FLei15V3qTMcKPL+1AaxK8tcugTIvHwr
         caD6/qWH+T+Wy6FUzNmYGoyRoMc0/UfuGKCHz4YJ9xfU2Wyn+RMBbQSq7S85VJsC+XCI
         73DpK5DJyCKFSOSky/r3kWj7XxrClM8pwBD8dEmA7htuDs3W1Lvx3t3emhcecCg6izoZ
         JV2uGWP5aUrsxJA61VwoKLL9oeCLuepgmE6ioQTgnoYTm4ThdAeVfYaRobZGQA4FuVMk
         28N5pChjm5oRITKfOeLiBW/mPGoqs/JVDoPAT7WDaBU7GkjV2OGry2bcVwwpsT5mSOdg
         Bqjw==
X-Gm-Message-State: ACrzQf1lieUpI1ek5nbn8mpGanpd+X0wJoJSBRrvNbXjtlJtaX2NFG0g
        imeOQGmHeDxC/n3YGMbR81L2P8vx0PHpEdRDptBfxA==
X-Google-Smtp-Source: AMsMyM7lFKI0cJm0OC8KuOCtKRDUcA8Q5dyX3p9Rq8BCa0kTSdfY9GGS6MsjZVKNsFr8CV+QvLiqp/p4joRvk1ifLoo=
X-Received: by 2002:a67:b009:0:b0:38a:e0f2:4108 with SMTP id
 z9-20020a67b009000000b0038ae0f24108mr485065vse.9.1663265071592; Thu, 15 Sep
 2022 11:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com> <20220911172051.ff5faed962c365e203790137@linux-foundation.org>
In-Reply-To: <20220911172051.ff5faed962c365e203790137@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 15 Sep 2022 12:03:55 -0600
Message-ID: <CAOUHufbeh=v6gFuxyOA5xOtahL1AGUQYgQZzB7edDaS3hoc-LQ@mail.gmail.com>
Subject: Re: [PATCH v14 00/70] Introducing the Maple Tree
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Sun, Sep 11, 2022 at 6:20 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 6 Sep 2022 19:48:38 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
>
> > Patch series "Introducing the Maple Tree".
>
> I haven't seen any issues attributed to maple tree in 2+ weeks.  Unless
> there be weighty objections, I plan to move this series into mm-stable
> soon after mglru is added.  Perhaps a week from now.

Tested-by: Yu Zhao <yuzhao@google.com>

stress/fuzzing: arm64, mips64, ppc64 and x86_64
performance: arm64 (nodejs), mips64 (memcached), ppc64 (specjbb2015)
and x86_64 (mmtests)
boot: riscv64
not covered: m68knommu and s390 (no hardware available)
