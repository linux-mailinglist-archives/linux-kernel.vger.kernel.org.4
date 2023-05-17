Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933E7706D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjEQPjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjEQPjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:39:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB639EC7
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:39:19 -0700 (PDT)
Received: from [IPV6:2a0c:5a83:9203:ad00:6a82:5fb2:6bd2:f97e] (unknown [IPv6:2a0c:5a83:9203:ad00:6a82:5fb2:6bd2:f97e])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2F494660592C;
        Wed, 17 May 2023 16:39:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684337957;
        bh=uKJy4pRowB3D34xI/kCqED8xTiizsjkeJjkVA+sWiDg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J3RJBjgQgnVA+7J1qy5wo1XnaBI4eFQ40N2q3EzZPqWSkG4VeLp/HmJIF9KybDYrD
         p2w+b3Zu/piTF52kCxT5tAT38LiKVEzzDk6dmf6GTAK5aDnanaWtY8rwA7gy4bCd0e
         /CDRSAWiCmBkhOVGD8zd3T0ysX85HEgrD068tSrV9z3YedxGJTxfoliXX/bEJ5YbuU
         vie1nXy2EBglJCCKdTAVBlEIy7kOvrgttcXXcGwhph9evDqm1XGYlRkX5W+QSp7uQp
         /ovShfAMmFjJ3uqoynZvC2GBYeZUR/6U3z7J9+YzBKE6ApI7rSnmAjP7e731LJ3agF
         CL9Sl1agVbzWg==
Message-ID: <b5d0cf82-0e42-f6a1-c9f5-c145fdc4c622@collabora.com>
Date:   Wed, 17 May 2023 17:39:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        regressions@lists.linux.dev,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        denys.f@collabora.com, kernelci@lists.linux.dev
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com>
 <20220919170828.3718437-1-ndesaulniers@google.com>
 <597ef55f-e7c1-ab60-b4aa-0071ff4b5e0e@collabora.com>
 <CAKwvOdmSrAxx-YY1Na3BSdYuxXCPKK+F0K5V6i+adTn_bVJEsw@mail.gmail.com>
 <89961dfc-d40f-78e4-5d34-b86b7d152182@collabora.com>
 <CAKwvOd=4hBcU4fAkddU0b-GOZc9FzTZoj3PFW6ZZrX0jS8x+bg@mail.gmail.com>
 <17c91d37-7d9c-0df4-2438-2b30ca0b5777@collabora.com>
 <CAKwvOdk4QO8x_bs64fFRCsMu__AjhXd4Ew2KfgzQOb9Q3FMqSA@mail.gmail.com>
From:   =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
In-Reply-To: <CAKwvOdk4QO8x_bs64fFRCsMu__AjhXd4Ew2KfgzQOb9Q3FMqSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 16/5/23 1:01, Nick Desaulniers wrote:
> Can you please help verify this failure by hand, and see if applying
> https://github.com/ClangBuiltLinux/linux/commit/45c4fb6095d872785e077942da896d65d87ab56b.patch
> helps?  If you can repro; mind sharing your precise steps to reproduce?

I ran a few tests but the commit that introduced your changes
passes every time. There's a chance that the bisector got misled
due to the test runs failing for whatever reason unrelated to the
patch. There's definitely something introducing a bug somewhere,
as current mainline/master makes this test fail on this target
when kernel/configs/debug.config is applied, but it must be
somewhere else. I'll investigate this some more to see what I can
find.

About the steps to reproduce it, we're using the current KernelCI
tools (kci_build) to generate the kernel. To actually launch the
tests I'm submitting jobs to Collabora's LAVA lab, which is
something that isn't available to external users, so it might be
a bit hard for you to reproduce the exact environment from the
original test. If you need to test something, I can do it for
you.

Thanks,
Ricardo
