Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC365B41EB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 00:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiIIV7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIIV7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:59:52 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1562B245;
        Fri,  9 Sep 2022 14:59:49 -0700 (PDT)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 289LxaGs001263;
        Sat, 10 Sep 2022 06:59:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 289LxaGs001263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662760777;
        bh=qJ2xNANFGAA/u/uDw9DaUYVB6Q16K2/fBd9dXrsPcNY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r4EwVh2luXtYErjnUICPEoNsg1wkLrw1g7D9ahitEB0HkdC/jYOr3+TjNI/Ck9Zmy
         l4/VTbJ5zagGGkj7Bu9U6HyZsXsPkrPwZSa9rjU6XE6zyuJiMeVebXObkd7eSPqvRE
         LVm1cmZceJu3R9Q3ZVj/8IAJWRqbIjrFxCOT50AsRSQ503g3MWI+OyHHoy5Ht0Dk7E
         iAZISxeMbOq4nQc5H46znlWHTQiL046MscL9UnV9b0XNNuVVcXyd0IdzLz3CS8GDzl
         bHpM3dTQDwSuUbK5e85Hp+xZE8urta3P6XaXYCb9jU1eIToOAuH8kdilegGPFazJNV
         XqAIol6DApwYQ==
X-Nifty-SrcIP: [209.85.161.41]
Received: by mail-oo1-f41.google.com with SMTP id z23-20020a4ad1b7000000b0044931ffdcafso488592oor.4;
        Fri, 09 Sep 2022 14:59:37 -0700 (PDT)
X-Gm-Message-State: ACgBeo1vHXVCm4NiNYkPpcbdtsL8NqJCrtEpUhIonOfhbjb/U3uFQOIs
        /+lwf1D/F+/Yj6eXFxSwhENYMdXxb6178XbQtIw=
X-Google-Smtp-Source: AA6agR72P3R97llgZiBPvMKMBd85181rfh9FbVRqi/ZZxrmTbOjBMXr/bhgI9jBCYkdfKfxC2nnzR7CajL6bHAWUM1A=
X-Received: by 2002:a4a:9789:0:b0:451:437b:cc58 with SMTP id
 w9-20020a4a9789000000b00451437bcc58mr5606771ooi.96.1662760776232; Fri, 09 Sep
 2022 14:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220907045907.484043-1-ndesaulniers@google.com> <20220907045907.484043-4-ndesaulniers@google.com>
In-Reply-To: <20220907045907.484043-4-ndesaulniers@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 10 Sep 2022 06:59:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNARe+iZBB9OkkpOTGxi+GwTnk8pigjd3KYHR-ZGoyiZEAw@mail.gmail.com>
Message-ID: <CAK7LNARe+iZBB9OkkpOTGxi+GwTnk8pigjd3KYHR-ZGoyiZEAw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        X86 ML <x86@kernel.org>,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 1:59 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> cc-ifversion is GCC specific. Replace it with compiler specific
> variants. Update the users of cc-ifversion to use these new macros.



Now, this is independent of the rest of this series.



Can you rebase this on top of Linus' tree
so that you use clean up
b0839b281c427e844143dba3893e25c83cdd6c17

Otherwise, clang-min-version will not get any users.









--
Best Regards
Masahiro Yamada
