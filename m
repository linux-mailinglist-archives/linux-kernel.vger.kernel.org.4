Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452F360287A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJRJhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJRJhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:37:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF3A4B9AB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 984ABB81E07
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B0EC433B5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666085820;
        bh=0xSwj7DpRo1DNNUjXNdGquoqk2dkhuGaKfTJl/tLKY0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tngriZcHLqfhFlJP3nAWgOo49jqGCeWF3zzPJXM2b9B/MzwM2rZjdUeoanxSHeS+W
         H1edRO76AD0S2zgxwbeMFQm0JrM4q66FvAjg6m6hsTRe/BW0pwL7wiGvOVQSmzcyWI
         xmnyPqTGeBUgsbFj/YbmZTSMse4fAikPcK91jgaQczHuPQoVkUSVHgVktsLjLLehGi
         Yz2ETZ94xqWHG3WjIrd/8hRx5n8s/YKxSeukqFNUF2T17PwBSp6+aAACSsVCoiee95
         lDn2TstEiiTUuvJMbb0cL49kjTl8WeITwBugAGmwBSQzjKWm0CXd9q5/BSNfrzRqLf
         9Sm6D6LNOH3nw==
Received: by mail-ed1-f47.google.com with SMTP id m16so19629106edc.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:37:00 -0700 (PDT)
X-Gm-Message-State: ACrzQf0ByBcCAKR0FSvTlrx5dGke9liP+AuLGocEmbgOPrFWPBRwYSE1
        TKUvfR8QADMEoTZrUDKxyT+0Vk5RmTjccKKoLl0=
X-Google-Smtp-Source: AMsMyM6HuObCXrNZYkXqjtISIIoI/Uvn3SFQAym7pWH4mufQ4yI/f0iAiWH+gaz4NEPxrbwlVj+LSLMiXIKDLxB76JI=
X-Received: by 2002:a05:6402:550e:b0:456:f79f:2bed with SMTP id
 fi14-20020a056402550e00b00456f79f2bedmr1810384edb.106.1666085818499; Tue, 18
 Oct 2022 02:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221017022330.2383060-1-chenhuacai@loongson.cn>
 <b8792b1a71754d6eb88debe4d6c2c419@AcuMS.aculab.com> <CAAhV-H5WM97+Um9ULjv7gT3i5pJ3GfQ8ex6NRNr6uzmMgdVY_Q@mail.gmail.com>
 <c34a277a-1735-65e6-c97d-fcc2ac3d57e6@xen0n.name> <CAAhV-H5y5wz0VzFEHrkDpap4wczWXBn_ibL3LW_JQyYkMzjDXQ@mail.gmail.com>
 <cbbc32d4bb0f445197eb5d84d796595c@AcuMS.aculab.com>
In-Reply-To: <cbbc32d4bb0f445197eb5d84d796595c@AcuMS.aculab.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 18 Oct 2022 17:36:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H42_dNyfYHDpdmPM=kG=VTF8xtPHMn-ojWHNkLnTNVDiQ@mail.gmail.com>
Message-ID: <CAAhV-H42_dNyfYHDpdmPM=kG=VTF8xtPHMn-ojWHNkLnTNVDiQ@mail.gmail.com>
Subject: Re: [PATCH V2] LoongArch: Add unaligned access support
To:     David Laight <David.Laight@aculab.com>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 3:48 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Huacai Chen
> > Sent: 18 October 2022 08:33
> ...
> > > What about my more structured approach in another reply that avoids the
> > > huge else-if conditions? Both the terrible line wraps and codegen could
> > > be avoided.
> ...
> > OK, let me try.
>
> I suspect you can mask out some 'operand size' bits from the
> instructions - instead of checking each opcode.
>
> I'm also pretty sure you can't assume the FP register are live.
> If a read from userspace faults then there can be a full
> process switch - so by the time you try to write to the
> FP registers they no longer belong to the current process.
>
> It might be safer and simpler to just enforce the FP
> registers be saved and then act on the save area.
> I'd guess they get restored in the 'return to userspace'
> code.
Good catch, will be fixed in V4.

Huacai
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
