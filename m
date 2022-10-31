Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BC16139E6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiJaPVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiJaPVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:21:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67441DE80
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:21:07 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7cf329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7cf:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18D761EC0430;
        Mon, 31 Oct 2022 16:21:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667229665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Db7WJVy4OeuTAMBJY1kZVmvASTWQFkOtfVPTdG7CobU=;
        b=CoRTjjQGY6HfFTrvq5RPdbUZXzDnOhcO+WOaLet+LZKZhdYfvh56kDng1p7W8UOsC60OVc
        cozEqZo5UEUTxt4CUApO0lo12I7q5HvU9+ozz0PT2rtU95dXZfxvhCq+Q2vBvaaK2r2eFc
        R+Xg2qq+Fmz2PBcqAo0nPYa2e84T4UM=
Date:   Mon, 31 Oct 2022 16:20:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jiri Slaby <jslaby@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2]  x86/boot: fix relying on link order
Message-ID: <Y1/n27HM/DTmLUiS@zn.tnic>
References: <20221031151047.167288-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221031151047.167288-1-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ jslaby.

On Mon, Oct 31, 2022 at 04:10:45PM +0100, Alexander Lobakin wrote:
> The series contains stuff I caught last week while working on some
> x86 code. It can be considered a material for fixes or for next,
> I'm okay with either, although leaning more towards fixes :P
> 
> Notes on patches:
> * 0001: I didn't put any "Fixes:" tag since it's not linear. The
>         lines changed with this patch came from the initial x86
>         KASLR series, but that unconditional jump to the kernel
>         beginning already was there. It goes at least from the set
>         that brought relocatable kernel support to x86, but this
>         is quite prehistoric already and might not look really
>         relatable. So up to you whether it needs any.
> * 0002: doesn't fix anything, except that having any files listed
>         in that whitelist already is an architecture bug :D And
>         it wouldn't be convenient to decouple it from #0001, but
>         up to you as well.
> 
> Alexander Lobakin (2):
>   x86/boot: robustify calling startup_{32,64}() from the decompressor
>     code
>   scripts/head-object-list: remove x86 from the list
> 
>  arch/x86/boot/compressed/head_32.S |  2 +-
>  arch/x86/boot/compressed/head_64.S |  2 +-
>  arch/x86/boot/compressed/misc.c    | 16 +++++++++++-----
>  scripts/head-object-list.txt       |  6 ------
>  4 files changed, 13 insertions(+), 13 deletions(-)
> 
> -- 
> 2.38.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
