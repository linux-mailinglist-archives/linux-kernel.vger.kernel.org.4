Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF215F1165
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiI3SNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiI3SM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:12:29 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CFC1E92ED
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:10:56 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 78so4784178pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FdAwaR2ThOuiEkbcZBSK+LnUmsamyS86q3QP/tm0gAk=;
        b=l7a1aZIzcaqxlxcKCOg2rfD97WjT6mvyxS81K+jeiPEurzrvoMXhrmG7+DY3ACQRKp
         eqh+1SeGRM4Gvzfo0L77PITM901lagPAy9lB2dzRjNnftL6Aqx0g8i51uYGXx4E4tqce
         BdSW4Ryr9LwIHzyHWZE97S+54YNi5ptJlU8bLbpORMt10xlSekDHWmoaSEaVC+6dX6N9
         ab5ezxQpsnvMSUY4/6SMgATV+4pVdmux8qv4W3ByYsp2NFQy263vTkvV9362enHEROkh
         OtQB7iq2d6GzbAOn0E/oP3/jlXZAIiAFJw1MQBWyw4lgPNrbndVa/j/XjURbLkpkK6nO
         OTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FdAwaR2ThOuiEkbcZBSK+LnUmsamyS86q3QP/tm0gAk=;
        b=PBFJORlTQSzT/woFaGd6PBWpz1e2Ld29PH07EhHlxDjAOS0rim9HVPbcXK/duM/VeJ
         /jxTDHeaJIkgKyIHszTEc3bFKcolfRvw/P3iWYDoW+vZ5tZ/jb7NTy3AqQuCQoRchWYI
         6ng3GDNOrxDWwb9MkS19XAyaMMx/j1rbEZl/HKRwlBMedXEnEWNl6RnMmJ9GbYioNmA3
         TECO/JFLBtbuyBPwzCdIZ7tVWQZD6XjrFPmpXvsTYCiWwHOjfi10y5IzYkhFsXN+cdkU
         gxT4GVRiNS3/ELFHdGkT5zirfqTh40FHT+llEYyHfa6EsssGZa5BrEw+ZGfL87MYOLml
         Fqnw==
X-Gm-Message-State: ACrzQf1Lv3j6nbBvvsLa/IrdXdPwXqeIiXMvTafwNDQHr3mWqJr3eOtx
        aJzIvTm07zgEXO1Qw3CLdfluUqaKTnjX7qH9DMwFWg==
X-Google-Smtp-Source: AMsMyM6b6d5PRzEl8t8Xryx+i34BOBUdxOQjKRDtvOB1nuKhNXfvBQg1ErJjFskWinXmgjPpV9+i5H9hBPxol7sIhOo=
X-Received: by 2002:a05:6a00:4c11:b0:53e:4f07:fce9 with SMTP id
 ea17-20020a056a004c1100b0053e4f07fce9mr10553729pfb.66.1664561455909; Fri, 30
 Sep 2022 11:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220817185410.1174782-1-nathan@kernel.org> <CAKwvOd=0R76r6YqNiOhGNt_XrA_t_ZbuBbNNdNXV4CWpDy0+Bg@mail.gmail.com>
 <Yv3uI/MoJVctmBCh@worktop.programming.kicks-ass.net>
In-Reply-To: <Yv3uI/MoJVctmBCh@worktop.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Sep 2022 11:10:44 -0700
Message-ID: <CAKwvOdk_XAXNJ5n_WdymSqZq=No2pbHpSJiJkH6K4gPFEEVNNg@mail.gmail.com>
Subject: Re: [PATCH] x86/build: Move '-mindirect-branch-cs-prefix' out of
 GCC-only block
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "Moreira, Joao" <joao.moreira@intel.com>
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

On Thu, Aug 18, 2022 at 12:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> This being clang, you'll ofcourse still have a few weird:
>
>         "Jcc.d32 __x86_indirect_thunk_r11"
>
> sites that will not be able to be replaced, but there's nothing I can do
> about that other than to continue to encourage y'all to stop emitting
> them ;-)

Joao has a patch up for this:
https://reviews.llvm.org/D134915
-- 
Thanks,
~Nick Desaulniers
