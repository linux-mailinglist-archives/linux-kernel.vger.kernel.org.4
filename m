Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0065770C3C0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjEVQwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjEVQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:52:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0239F1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:52:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D04C6252A
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 16:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B6CC433D2;
        Mon, 22 May 2023 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684774370;
        bh=vOQbWWEEqd8EQVksWSFEy4waMaZII1vIhTX3SzTbbko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3MLFpG2OoR6zPuYXlOFRm68JelSBH0QDndXPwKeHRgL9+reSIMdQe6CNgI/cfc9f
         miDxNritVnfcvqwuHDuMk5Rn/GbaQD+om4+8MowbFMZnHWSN9ZE0shhe5sjt+9/A0J
         BNSZ2iolJWZw8v1cc/eom6LTzfCJ1k1NevOLgfiI=
Date:   Mon, 22 May 2023 17:52:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ricardo =?iso-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        regressions@lists.linux.dev,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        denys.f@collabora.com, kernelci@lists.linux.dev
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
Message-ID: <2023052247-bobtail-factsheet-d104@gregkh>
References: <CAKwvOd=4hBcU4fAkddU0b-GOZc9FzTZoj3PFW6ZZrX0jS8x+bg@mail.gmail.com>
 <17c91d37-7d9c-0df4-2438-2b30ca0b5777@collabora.com>
 <CAKwvOdk4QO8x_bs64fFRCsMu__AjhXd4Ew2KfgzQOb9Q3FMqSA@mail.gmail.com>
 <b5d0cf82-0e42-f6a1-c9f5-c145fdc4c622@collabora.com>
 <CAKwvOdkFxu9hYSL_RCXadpR0dQd1+dZmAUVXdfFiLUfxg4D_Xw@mail.gmail.com>
 <878rdlk9bi.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOd=8LVU+iANkFx18Wm1jg7gYiAXovAmo9t5ZZaVdMULn-Q@mail.gmail.com>
 <875y8ok9b5.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOdmJJibt6sHSp91v2s7BxUWBC6xG7F7+3C6gUxNMzZ2xRA@mail.gmail.com>
 <87353ok78h.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87353ok78h.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 12:09:34PM +0200, Ricardo Cañuelo wrote:
> On vie, may 19 2023 at 08:57:24, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > It could be; if the link order was changed, it's possible that this
> > target may be hitting something along the lines of:
> > https://isocpp.org/wiki/faq/ctors#static-init-order i.e. the "static
> > initialization order fiasco"
> >
> > I'm struggling to think of how this appears in C codebases, but I
> > swear years ago I had a discussion with GKH (maybe?) about this. I
> > think I was playing with converting Kbuild to use Ninja rather than
> > Make; the resulting kernel image wouldn't boot because I had modified
> > the order the object files were linked in.  If you were to randomly
> > shuffle the object files in the kernel, I recall some hazard that may
> > prevent boot.
> 
> I thought that was specifically a C++ problem? But then again, the
> kernel docs explicitly say that the ordering of obj-y goals in kbuild is
> significant in some instances [1]:

Yes, it matters, you can not change it.  If you do, systems will break.
It is the only way we have of properly ordering our init calls within
the same "level".

thanks,

greg k-h
