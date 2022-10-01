Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1976E5F2071
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 00:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJAWuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 18:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJAWun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 18:50:43 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7283FEE1
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 15:50:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fw14so43693pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 15:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=penX+Kg4hrZvT7AzB7uzMcDTS0eBgwhoN2ktq+qEONI=;
        b=CuRp7SGnSS5wwhP3oujeYD5mDXhRcBDMCHnAGPStJEZ4othzW20e3lxVQB00Sg3uPK
         RYrfz1w6AQ0XSYP7cZVdTnWVbi2ynJBzVOQ2dePgTTQlH/6LH4m7mO94dIeTbM55Mr7B
         7DeeGdmXjUb+VIF+zBD8I4v1HXMd9/nz/ZSPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=penX+Kg4hrZvT7AzB7uzMcDTS0eBgwhoN2ktq+qEONI=;
        b=qWrutnrWF4q2i6Qqf69goR5KJl/WFcAKR+X8BtEY2Mdu6qmjQj6rMiSw4M1MXGmEZX
         Yzb6hrLANFlSBuNLH/i3Lfmi9YPwCV0e2zj1UDT9qX21RmIp0/V8+7ItftSidTb2vMZM
         A2J9eU+04bTSUSa9+MoL2KsxZkImCxKvMlM3GCw4B16a6GbPT3xOoyfiBzr/RB0AdmqD
         FlzQpj28X9DqdG9QDMOeB+5kn82cJz9P3kovwYRrDjOCerTCju1afN3FY4rqLLi6lZjQ
         GDgwKt3yKqRpcyJTFgDX+OcHLDxFQdgvnqgGjJViIszt0UkciZ9Xn2TcDb3C6d77hUIF
         q7fA==
X-Gm-Message-State: ACrzQf2u4aO66SZECSr7LLtA1On+jzQZTrqBl00PvqP0VwU56BZYTu+2
        V+NI0qwad+ZJ3FTTwk38m57wXw==
X-Google-Smtp-Source: AMsMyM6PyO4s1FNICpMCUO8/W912S8moTlD9noGsXvAwlRI1a21RiuPyC/OYGsVdNRPnKojPgAolqg==
X-Received: by 2002:a17:90b:4f91:b0:205:edc8:4ae with SMTP id qe17-20020a17090b4f9100b00205edc804aemr5174554pjb.110.1664664641447;
        Sat, 01 Oct 2022 15:50:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y18-20020aa79432000000b0053b208b55d1sm4283815pfo.85.2022.10.01.15.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 15:50:40 -0700 (PDT)
Date:   Sat, 1 Oct 2022 15:50:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Fox Chen <foxhlchen@gmail.com>, Gary Guo <gary@garyguo.net>,
        Geert Stappers <stappers@stappers.nl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joe Perches <joe@perches.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Julian Merkle <me@jvmerkle.de>,
        =?iso-8859-1?B?TOlv?= Lanteri Thauvin 
        <leseulartichaut@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Matthew Bakhtiari <dev@mtbk.me>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Milan Landaverde <milan@mdaverde.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        =?iso-8859-1?Q?N=E1ndor_Istv=E1n_Kr=E1cser?= <bonifaido@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Niklas Mohrin <dev@niklasmohrin.de>,
        Petr Mladek <pmladek@suse.com>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>,
        Viktor Garske <viktor@v-gar.de>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Wei Liu <wei.liu@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        Yuki Okushi <jtitor@2k36.org>
Subject: Re: [GIT PULL] Rust introduction for v6.1-rc1
Message-ID: <202210011547.A456D4679@keescook>
References: <202210010816.1317F2C@keescook>
 <CAK7LNAQ2xBLG_aSDm64SSYRBOBKwhJnZ6UDg8ycAezATVToFLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ2xBLG_aSDm64SSYRBOBKwhJnZ6UDg8ycAezATVToFLg@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 05:21:17AM +0900, Masahiro Yamada wrote:
> On Sun, Oct 2, 2022 at 12:59 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Hi Linus,
> >
> > Please pull the initial Rust support for v6.1-rc1. The tree has a recent
> > base, but has fundamentally been in linux-next for a year and a half[1].
> > It's been updated based on feedback from the Kernel Maintainer's Summit,
> > and to gain recent Reviewed-by: tags. Miguel is the primary maintainer,
> > with me helping where needed/wanted. Our plan is for the tree to switch to
> > the standard non-rebasing practice once this initial infrastructure series
> > lands. The contents are the absolute minimum to get Rust code building
> > in the kernel, with many more interfaces[2] (and drivers[3]) on the way.
> >
> > Expected conflicts are minimal:
> > - docs-next: https://lore.kernel.org/lkml/87czbegets.fsf@meer.lwn.net/
> 
> 
> Also, conflicts against the Kbuild tree.

Ah, yes. Apologies; I missed this while checking the list. The latest
I found are from 9/28:
https://lore.kernel.org/linux-next/20220927181647.487727-1-broonie@kernel.org/
Miguel verified the conflict resolution at the time.

> linux-next 20220930 fails to build with CONFIG_RUST=y because the merge
> conflicts between Kbuild and Rust trees were not correctly resolved.

Ah, did something change between 28 and 30?

> I will try my best to address merge conflicts when I send my pull request.

Thank you!

-- 
Kees Cook
