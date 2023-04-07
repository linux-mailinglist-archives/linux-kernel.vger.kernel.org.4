Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E446DAC85
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 14:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbjDGMFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 08:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbjDGMFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:05:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B0286B8;
        Fri,  7 Apr 2023 05:04:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25FF9611DA;
        Fri,  7 Apr 2023 12:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1C0C433A0;
        Fri,  7 Apr 2023 12:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680869098;
        bh=+h9X2/Li7Dbrxpm+yggIqvqVGjoKmnnUOnHGdxgHm3g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QcUj9ECOxQaA/Yky8OHxIau2ytTKawki9J64VvWZv5N3IeQllGtsa6SnYA3oAwqzI
         KxuccBXTfmGckh/1s/EsyhfmJRu65GFAkiuRbmP04MAEUgC3di++Jr1m5qXKsW62XM
         RnnH6y31dMhRd5pjbt4VWGz5HWOoJM9satW5YVrjQRp/MtULHH4dvQ0efKgwTaPp3a
         aO1fNdrcpRybC+4EUbTPzTBZxuZ1ysUYB/FSD7UmGdlX73kFNwlIr1Bli5b2IDDFwr
         2K0B3Bnf2VYMkhXTll70m0nIwTBEgeJIyzl67c/EsEMOuUsutOgFYS6pcbOxAC84bq
         gcOQFl6YmSXPA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-177b78067ffso45445105fac.7;
        Fri, 07 Apr 2023 05:04:58 -0700 (PDT)
X-Gm-Message-State: AAQBX9dabqJdv2hQ6nQazYwEVRc6xfgKZ4mbyQcQ2TFxVIO1s2XOhpxu
        rHsQT7HEdqqXzLuWg1YtbIaBDef86/VZpZdyMAE=
X-Google-Smtp-Source: AKy350ath5srGcoz4KQWDNBXPgTTg5z+9Gim6RIvepzuuS4FKcJqVnm2ViUyiSoHACPMrrppl/CsgS8vfTV2N0lsW5s=
X-Received: by 2002:a05:6870:3105:b0:183:ebfc:c791 with SMTP id
 v5-20020a056870310500b00183ebfcc791mr849486oaa.11.1680869097793; Fri, 07 Apr
 2023 05:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230312200731.599706-7-masahiroy@kernel.org> <20230406152540.8207-1-youling257@gmail.com>
In-Reply-To: <20230406152540.8207-1-youling257@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 7 Apr 2023 21:04:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNASWhW-dvxcexmkYwA_j-iPr6CbWP3emqEJkKT2qbCFtgg@mail.gmail.com>
Message-ID: <CAK7LNASWhW-dvxcexmkYwA_j-iPr6CbWP3emqEJkKT2qbCFtgg@mail.gmail.com>
Subject: Re: [PATCH 6/6] kbuild: use git-archive for source package creation
To:     youling257 <youling257@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        terrelln@fb.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 12:25=E2=80=AFAM youling257 <youling257@gmail.com> w=
rote:
>
> This patch cause build time a bit longer.
> I use "time make targz-pkg -i -j8" build kernel, this patch will first cr=
eate *.tar file, then create *.tar.gz file, build time a bit longer.
> './System.map' -> 'tar-install/boot/System.map-6.3.0-rc5-android-x86_64+'
> '.config' -> 'tar-install/boot/config-6.3.0-rc5-android-x86_64+'
> './vmlinux' -> 'tar-install/boot/vmlinux-6.3.0-rc5-android-x86_64+'
> './arch/x86/boot/bzImage' -> 'tar-install/boot/vmlinuz-6.3.0-rc5-android-=
x86_64+'
>   TAR     linux-6.3.0-rc5-android-x86_64+-x86.tar
>   GZIP    linux-6.3.0-rc5-android-x86_64+-x86.tar.gz
>
> real    0m37.991s
> user    0m47.529s
> sys     0m8.235s
>
> Revert "kbuild: use git-archive for source package creation"
> './System.map' -> 'tar-install/boot/System.map-6.3.0-rc5-android-x86_64+'
> '.config' -> 'tar-install/boot/config-6.3.0-rc5-android-x86_64+'
> './vmlinux' -> 'tar-install/boot/vmlinux-6.3.0-rc5-android-x86_64+'
> './arch/x86/boot/bzImage' -> 'tar-install/boot/vmlinuz-6.3.0-rc5-android-=
x86_64+'
>   TAR     linux-6.3.0-rc5-android-x86_64+-x86.tar.gz
>
> real    0m11.006s
> user    0m21.079s
> sys     0m7.830s
>
> I don't like *.tar file, i will delete *.tar file when every time build k=
ernel, i need *.tar.gz file, if one file is i needn't, i will delete it.
> linux-6.3.0-rc5-android-x86_64+-x86.tar.gz file is i need, linux-6.3.0-rc=
5-android-x86_64+-x86.tar is i needn't.


OK.

On second thought, splitting tar and compression was unneeded.

I submitted a patch set to avoid unneeded *.tar creation.


https://lore.kernel.org/lkml/20230407101629.1298051-1-masahiroy@kernel.org/=
T/#t





--=20
Best Regards
Masahiro Yamada
