Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B60682B73
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjAaLa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjAaLaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:30:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681EE4B8B6;
        Tue, 31 Jan 2023 03:30:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18171B81B07;
        Tue, 31 Jan 2023 11:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A558AC433D2;
        Tue, 31 Jan 2023 11:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675164614;
        bh=kEv6gsLwYz/eyxWV8VzxJrnkYjV85inauxe/wslN3KQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YXyHDqCtJP2FkR5RLxpFqtxrM8IFTL+6ysyZhoByJ+rL/sTz41swia38BtJUbfYu0
         fv6dtiEOwJUNQL9SUyY02wN5RKRlFlKCUIUeRe4Jr4LeMhACHP+TcaN4iqI2kY0om+
         9RVZC3uZ5jGr34tEunQZdgW1HsKRB5D3lHlDSdAjlDP4c6aTc05u/hVOkNdceEV/96
         Id8ELZMnvPMpZRzZd2rHBKu7yQGGR0cSAmHWUiol9bN1L5lkFRNauA9+lX9VYZcLPI
         b9SNSd2BhlLXjaTDQefUb1YMCLl/bwbuiAC2WR3HKOKcVmuyMtcmufmfdgTIjVwZFx
         ED9miloB4mfSA==
Received: by mail-oi1-f171.google.com with SMTP id s66so12523426oib.7;
        Tue, 31 Jan 2023 03:30:14 -0800 (PST)
X-Gm-Message-State: AFqh2kriUowkOkNnGJU4grueUa4VLaytmdIQ1LX5sFw96wXIDi18MM4l
        kqOM/RNY8F5fflZQLw/CUD7KIsHoWnMwwPYX5UM=
X-Google-Smtp-Source: AMrXdXuqX/e4EgC3kySmwIIOtFSvYpZYMp/vZO1Ulg2vFuyzr99ScpxtKjrtOKxf+Ws6r371jqmPqxnylcV+YHGads4=
X-Received: by 2002:a05:6808:1786:b0:35e:7c55:b015 with SMTP id
 bg6-20020a056808178600b0035e7c55b015mr3269459oib.287.1675164613832; Tue, 31
 Jan 2023 03:30:13 -0800 (PST)
MIME-Version: 1.0
References: <35c0fc4ba93b11c4b8a55c2907f736a840cd12a3.1675161286.git.geert+renesas@glider.be>
 <9d2450ce-6ba2-49eb-9f00-bcb1b8590eeb@app.fastmail.com> <fd1ca57c-1ab7-fa4f-12ba-4e8fd5fef6f9@prevas.dk>
In-Reply-To: <fd1ca57c-1ab7-fa4f-12ba-4e8fd5fef6f9@prevas.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 31 Jan 2023 20:29:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARa8bxTv9i=yokAEFByPKZgho-k9MZVu9JLRBAftUM9NA@mail.gmail.com>
Message-ID: <CAK7LNARa8bxTv9i=yokAEFByPKZgho-k9MZVu9JLRBAftUM9NA@mail.gmail.com>
Subject: Re: [PATCH resend] compiler-intel: Remove duplicate RELOC_HIDE()
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 7:59 PM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> On 31/01/2023 11.41, Arnd Bergmann wrote:
> > On Tue, Jan 31, 2023, at 11:37, Geert Uytterhoeven wrote:
> >> The RELOC_HIDE() implementation for the Intel compiler is identical to
> >> the generic version in <linux/compiler.h>, so the former can just be
> >> removed.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >> Not even compile-tested.
> >> ---
> >>  include/linux/compiler-intel.h | 5 -----
> >>  1 file changed, 5 deletions(-)
> >
> > I thought the entire file was gone already. I don't see anyone
> > objecting to the earlier patch
> >
> > https://lore.kernel.org/all/20221016182349.49308-1-masahiroy@kernel.org/
> >
> > but it never made it in. Maybe we can revive that instead?
>
> Yes, please!
>


I hoped it would be picked up by Linus directly,
or by an x86 maintainer.


We can re-push it in the next merge window.


-- 
Best Regards
Masahiro Yamada
