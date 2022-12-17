Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E3864F6E6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 03:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiLQCCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 21:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiLQCCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 21:02:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C4DD2C7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 18:02:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B4E36230E
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 02:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19A0C433EF;
        Sat, 17 Dec 2022 02:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671242543;
        bh=hWsOsRWCPRQzGgj30nGOWM5Z6p5zGzmmLaNLn5OgsUs=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=ZGv/1x5INDx3SYs62tpgQuKKSqx+ghEqerALquiN6xBfHsVfATsKS+fr5lMSxgB1K
         AEkgEKnnJg2PL28stQpRsWDV+cL9eXigvsOQ+GwcouQvkeJG8QyfnsAPWHfgK9j5Yb
         IHAMgTSwCGGL3Xnhslm89L5Z6M2/Xwqc5AOdftYSL57e+ZghxQfPJ0UKMNIK482Ntb
         4A+Vt9aTYx3O7u1lnLGPSw4NTRpJmkh/DyarK2v6KYnymvn9DmJJ3Exdl5Z8yo8fy8
         cWDvZ3ce3qlW/pIyMiVByLkB6ttuSBAriTt7CJ7Kw1ECZEcWcesqXWYfXVazlldA7J
         3A2nbJyhIATcQ==
Date:   Fri, 16 Dec 2022 18:02:15 -0800
From:   Conor Dooley <conor@kernel.org>
To:     Saleem Abdulrasool <abdulras@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     ben.dooks@codethink.co.uk, ndesaulniers@google.com,
        nathan@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: avoid enabling vectorized code generation
User-Agent: K-9 Mail for Android
In-Reply-To: <CAO8XFHth5tJWi8EYag1FnOgD38i2pDe87G3u2dkkP+-gkYBZkg@mail.gmail.com>
References: <39636675da60fc6c54cc8bbab64ddbac@codethink.co.uk> <mhng-d601613f-1c73-48e0-bb06-7f87acd60cfa@palmer-ri-x1c9a> <CAO8XFHth5tJWi8EYag1FnOgD38i2pDe87G3u2dkkP+-gkYBZkg@mail.gmail.com>
Message-ID: <E9917D44-4C61-4806-8A79-7F24AF504DA3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16 December 2022 12:56:23 GMT-08:00, Saleem Abdulrasool <abdulras@googl=
e=2Ecom> wrote:
>On Fri, Dec 16, 2022 at 11:54 AM Palmer Dabbelt <palmer@dabbelt=2Ecom> wr=
ote:
>>
>> On Fri, 16 Dec 2022 11:45:21 PST (-0800), ben=2Edooks@codethink=2Eco=2E=
uk wrote:
>> >
>> >
>> > On 2022-12-16 18:50, Saleem Abdulrasool wrote:
>> >> The compiler is free to generate vectorized operations for zero'ing
>> >> memory=2E  The kernel does not use the vector unit on RISCV, similar=
 to
>> >> architectures such as x86 where we use `-mno-mmx` et al to prevent t=
he
>> >> implicit vectorization=2E  Perform a similar check for
>> >> `-mno-implicit-float` to avoid this on RISC-V targets=2E
>> >
>> > I'm not sure if we should be emitting either of the vector or floatin=
g
>> > point instrucitons in the kernel without explicitly marking the secti=
on
>> > of code which is using them such as specific accelerator blocks=2E
>>
>> Yep, we can't let the compiler just blindly enable V or F/D=2E  V would
>> very much break things as we have no support, but even when that's in
>> we'll we at roughly the same spot as F/D are now where we need to handl=
e
>> the lazy save/restore bits=2E
>>
>> This looks like an LLVM-only option, I see at least some handling here
>>
>> https://github=2Ecom/llvm/llvm-project/blob/a72883b7612f5c00b592da85ed2=
f1fd81258cc08/clang/lib/Driver/ToolChains/Clang=2Ecpp#L2098
>>
>> but I don't really know LLVM enough to understand if there's some
>> default for `-mimplicit-float` and I can't find anything in the docs=2E
>> If it can be turned on by default and that results in F/D/V instruction=
s
>> then we'll need to explicitly turn it off, and that would need to be
>> backported=2E
>
>Yes, this is an LLVM option, but I think that the `cc-option` wrapping
>should help ensure that we do not break the gcc build=2E  This only
>recently was added to clang, so an older clang would also miss this
>flag=2E  The `-mimplicit-float` is the default AFAIK, which is why we
>needed to add this flag in the first place=2E  Enabling V exposed this,
>which is why the commit message mentions vector=2E

You've said "enabling V" in the comment and here=2E
By that, do you mean when V support is enabled in clang or when it is enab=
led in Linux?
