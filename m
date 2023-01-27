Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B1167EA01
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjA0Pvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjA0PvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:51:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B0B45BD1;
        Fri, 27 Jan 2023 07:51:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54F55B80AF8;
        Fri, 27 Jan 2023 15:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0700CC433D2;
        Fri, 27 Jan 2023 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674834675;
        bh=gX12jOrRkb1rjBILNvcmKkE46vvlFJL/mDyptg9AClM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PzSeETgch6b0w8SXANYRpya00efWx57a5QUTalSSpO6I4mUiT0+4xNrv/NBdy90yf
         tWgxmUeJW4sXea9lGrKZi1vrRHLj6kKoEVKytCunI3swR+hLJY/VYyRrE5M3+7Ho6V
         jFsvqJCDQUvFJ4/rmFIpNXnWNW9XYj4aX0km19jpjv/ukAZvh2P4p5En+XRAy5BhZh
         xCYHPKBeKt1MOWOSBDLd4yLUS6BmeI75prvc1ib3O4HzwnkjDXsTJ2+XpCVxsVGyel
         fz66mNmxbBEeC2C6/w3WfM2E9iChb5EY3wJTe6ddJ/ujwVdyBnsgdU02HDeSvgcEtZ
         cAwirCC1ZuGuA==
Received: by mail-oi1-f173.google.com with SMTP id s66so4525598oib.7;
        Fri, 27 Jan 2023 07:51:14 -0800 (PST)
X-Gm-Message-State: AFqh2kqLO7MpjoeJZrQF7u8RZlQ0RAd7Z92epN/czqODU74MCmUOJRXo
        CbGCQUgRG9csXo3kXXQuftbWCnp5g7oAO84jsu8=
X-Google-Smtp-Source: AMrXdXsEVCDrcCrPO3WwFGoGMw8KY8bSw80OpIW9KEUB9vyFzXUsqCTvX2onikFDjUHFBlDlja8ypDHL8R33CGaBWKY=
X-Received: by 2002:a05:6808:1786:b0:35e:7c55:b015 with SMTP id
 bg6-20020a056808178600b0035e7c55b015mr2475524oib.287.1674834674237; Fri, 27
 Jan 2023 07:51:14 -0800 (PST)
MIME-Version: 1.0
References: <20230122141428.115372-1-masahiroy@kernel.org> <Y9PozQphFcXZmEJz@orome>
In-Reply-To: <Y9PozQphFcXZmEJz@orome>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 28 Jan 2023 00:50:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNATc_aPxiYXabzYbGXOMUW0Rcf0KQi6GBPvoy71uPuqKPg@mail.gmail.com>
Message-ID: <CAK7LNATc_aPxiYXabzYbGXOMUW0Rcf0KQi6GBPvoy71uPuqKPg@mail.gmail.com>
Subject: Re: [PATCH 1/7] kbuild: do not put .scmversion into the source tarball
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 12:08 AM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> On Sun, Jan 22, 2023 at 11:14:21PM +0900, Masahiro Yamada wrote:
> > .scmversion is used by (src)rpm-pkg and deb-pkg to carry KERNELRELEASE.
> >
> > In fact, deb-pkg does not rely on it any more because the generated
> > debian/rules specifies KERNELRELEASE from the command line.
> >
> > Do likwise for (src)rpm-pkg, and remove this feature.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Makefile.package |  6 ++----
> >  scripts/package/mkspec   |  6 +++---
> >  scripts/setlocalversion  | 19 +------------------
> >  3 files changed, 6 insertions(+), 25 deletions(-)
>
> Hi Masahiro,
>
> I've been observing some strange behaviour when doing incremental builds
> on recent linux-next versions. What happens is that the kernel version
> doesn't get updated as I switch branches.
>
> For instance I was rebuilding in a kernel tree which I hadn't touched in
> a very long while and rebased on a recent linux-next. The kernel version
> then stayed at the prior version rather than being updated to reflect
> the actual state of the working tree.
>
> Reverting all of the seven patches in this series fixes the issue, but I
> don't really have a clue where exactly it fails. Do you have any ideas
> how to fix this?


Thanks for the report.

"setlocalversion: print ${KERNELRELEASE} if set" is bad.

I will fix it.



Best Regards
Masahiro Yamada
