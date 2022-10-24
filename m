Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4640609977
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 06:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJXEx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 00:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJXExw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:53:52 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0DF79A5D;
        Sun, 23 Oct 2022 21:53:51 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 29O4rcSG025743;
        Mon, 24 Oct 2022 13:53:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 29O4rcSG025743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1666587218;
        bh=4NFHC4g9rnUxSNT4tQeW/Eo1yoJTtStaw/TgZqPti70=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=El85+Av3fnJHrfx+6KzDM3DWH/IhgWOFBba02gyEqjAnihk2561KpYPATK9zOdGwP
         mbeNMtsLa/vA4sLhbiQTaDzSqzQqH52j/RfcDGSayTDjRQOU67snLVwA6IyNU9RNnH
         xB6nWP3xX0W9Eu3T7t5SWii7lh+YlvNQIlgsse/5ZN2VzpWdjVhaj5O9/pbRgr27ws
         RuHOHf+7xMuEvLqUjUP7jshIn1gilqi5DY7W2bGHy8/qyrACDIOyTx1tEhMX/r4g7E
         VP1Stf5r8vNaVK21H/DRJwkZdvM3PxWmwT4QK9ya6Ufv2gIdssz4X9Aoi3WTvP71kP
         4pXRPu8+dTqlQ==
X-Nifty-SrcIP: [209.85.167.169]
Received: by mail-oi1-f169.google.com with SMTP id y72so9780336oia.3;
        Sun, 23 Oct 2022 21:53:38 -0700 (PDT)
X-Gm-Message-State: ACrzQf3BdkzMlKHOLsAMjRemVJ7k6juQtCcvobdQGDUpXLUYZlFhUu98
        iUYJ0xf/uxKVYkoME3s9SRUZCH4edKKJWhXJ5rs=
X-Google-Smtp-Source: AMsMyM4W46Xo2mvj3Q/CNtOuDxr+TYGCgSSa7E4BW9w4X5LhZcIASk5PSqG6gJQtqiZX1NjiY340gfgQDD1amawBoMg=
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id
 cj5-20020a0568081b8500b0034d8ce1d5b0mr29062478oib.194.1666587217292; Sun, 23
 Oct 2022 21:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221023191055.85098-1-masahiroy@kernel.org> <Y1YAyQ4s+wxfAPAU@debian.me>
In-Reply-To: <Y1YAyQ4s+wxfAPAU@debian.me>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 24 Oct 2022 13:53:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNARxGhRHRAQuw7bkY79Z8tAuRdZ=Ayr1_JyS5Cwo=2ERmQ@mail.gmail.com>
Message-ID: <CAK7LNARxGhRHRAQuw7bkY79Z8tAuRdZ=Ayr1_JyS5Cwo=2ERmQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: fix segmentation fault in menuconfig search
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-kbuild@vger.kernel.org,
        Johannes Zink <j.zink@pengutronix.de>,
        Ariel Marcovitch <arielmarcovitch@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 12:04 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Mon, Oct 24, 2022 at 04:10:55AM +0900, Masahiro Yamada wrote:
> > Since commit d05377e184fc ("kconfig: Create links to main menu items
> > in search"), menuconfig shows a jump key next to "Main menu" if the
> > nearest visible parent is the rootmenu. If you press that jump key,
> > menuconfig crashes with a segmentation fault.
> >
> > For example, do this:
> >
> >   $ make ARCH=arm64 allnoconfig menuconfig
> >
> > Press '/' to search for the string "ACPI". Press '1' to choose
> > "(1) Main menu". Then, menuconfig crashed with a segmentation fault.
>
> You missed the prerequisites: search EFI and press 1 to jump to
> CONFIG_EFI.


Try the command in my commit description.

"allnoconfig" disables EFI.





> >
> > The following code in search_conf()
> >
> >     conf(targets[i]->parent, targets[i]);
> >
> > results in NULL pointer dereference because targets[i] is the rootmenu,
> > which does not have a parent.
> >
> > Commit d05377e184fc tried to fix the issue of top-level items not having
> > a jump key, but adding the "Main menu" was not the right fix.
> >
> > The correct fix is to show the searched item itself. This fixes another
> > weird behavior described in the comment block.
> >
> > Fixes: d05377e184fc ("kconfig: Create links to main menu items in search")
> > Reported-by: Johannes Zink <j.zink@pengutronix.de>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > Link: https://lore.kernel.org/r/20221023191055.85098-1-masahiroy@kernel.org
>
> Missing Cc: stable? The segfault (IMO) appears after v5.15, so all
> supported stable branches are affected.



In my understanding, Fixes: is enough to automatically find which stable kernels
to which the patch should be back-ported.



>
> Anyway, the segfault gone away with this patch applied. Thanks.
>
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
>
> --
> An old man doll... just what I always wanted! - Clara



-- 
Best Regards
Masahiro Yamada
