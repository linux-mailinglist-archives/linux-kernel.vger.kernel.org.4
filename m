Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320316C4AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjCVMo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjCVMo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:44:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F38010F5;
        Wed, 22 Mar 2023 05:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14763B81CB5;
        Wed, 22 Mar 2023 12:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2730AC433D2;
        Wed, 22 Mar 2023 12:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679489093;
        bh=cYht+F6XkhcFtC9v6SKL72id95a8krZJbrH6VmzeT4Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WONpPLt9AmcBhHrRzuN0Qnbyrl+ANDZBJK9VwQ+ZPTMFUOb7DtKCXUj1nGbyIhwl6
         C85TEyMv3uRNjotWlL/CmGroxtM9UAiFltY/EtQ3hKYPEz3SWc0vxnVaKGlgnOvuEu
         dSVK/zjKyMPpx1roUkDIqvSmxuJALfSbW/c0U5B52Aq9fuvqb96lNkjryPXvfQWx3R
         icYhHDJRJQLuyzYk60vhv9U9WYW+wN70A8U2V19lBUxDy5PWEKCVJYB+/a93CTy64B
         33gtmFtpskmrNeO9u/LTa7/LW6PNCrvVqFTID7hNXzIaa7c8g1JsfKapGmmT7TXoVX
         9T4Dm0UcjZXoA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-toolchains@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: Linux 6.3-rc3
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
        <20230320180501.GA598084@dev-arch.thelio-3990X>
        <CAHk-=wgSqpdkeJBb92M37JNTdRQJRnRUApraHKE8uGHTqQuu2Q@mail.gmail.com>
        <20230320185337.GA615556@dev-arch.thelio-3990X>
Date:   Wed, 22 Mar 2023 14:44:47 +0200
In-Reply-To: <20230320185337.GA615556@dev-arch.thelio-3990X> (Nathan
        Chancellor's message of "Mon, 20 Mar 2023 11:53:37 -0700")
Message-ID: <87pm91uf9c.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Chancellor <nathan@kernel.org> writes:

> On Mon, Mar 20, 2023 at 11:26:17AM -0700, Linus Torvalds wrote:
>> On Mon, Mar 20, 2023 at 11:05=E2=80=AFAM Nathan Chancellor <nathan@kerne=
l.org> wrote:
>> >
>> > On the clang front, I am still seeing the following warning turned err=
or
>> > for arm64 allmodconfig at least:
>> >
>> >   drivers/gpu/host1x/dev.c:520:6: error: variable 'syncpt_irq' is unin=
itialized when used here [-Werror,-Wuninitialized]
>> >           if (syncpt_irq < 0)
>> >               ^~~~~~~~~~
>>=20
>> Hmm. I do my arm64 allmodconfig builds with gcc, and I'm surprised
>> that gcc doesn't warn about this.
>
> Perhaps these would make doing allmodconfig builds with clang more
> frequently less painful for you?
>
> https://lore.kernel.org/llvm/20230319235619.GA18547@dev-arch.thelio-3990X/

Thank you, at least for me this is really helpful. I tried now clang for
the first time but seeing a strange problem.

I prefer to define the compiler in GNUmakefile so it's easy to change
compilers and I don't need to remember the exact command line. So I have
this in the top level GNUmakefile (all the rest commented out):

LLVM=3D/opt/clang/llvm-16.0.0/bin/

If I run 'make oldconfig' it seems to use clang but after I run just
'make' it seems to switch back to the host GCC compiler and ask for GCC
specific config questions again. Workaround for this seems to be adding
'export LLVM' to GNUmakefile, after that also 'make' uses clang as
expected.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
