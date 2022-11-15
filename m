Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27E4628DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbiKOAKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiKOAKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:10:01 -0500
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2606FFCD;
        Mon, 14 Nov 2022 16:09:59 -0800 (PST)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2AF09jor016476;
        Tue, 15 Nov 2022 09:09:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2AF09jor016476
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668470986;
        bh=kaA/W3OJWm84xj9yEegRlT2FAT0iIsZ8VWe5fgSo9GU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QTSW/6MALar81EQSANVauPIeMoO7hFmk+lKd4MXEYq4YsW8dPi3Ckb5KysNSy/GhV
         xTKDuws0mSS7fFT77SPv3gLqMB1oFA28rt8Huc9E4WqHf3zqgVFAPqEx99k9zuQuNe
         vO/gwagUFfLWYfymOEa9tdPo2Q3PYe1h4ATjK+TMHyF8AHjiK8XvM0sFZBHVvtcrRS
         KYZonXB1obBHTemrCHU8cWiLUDwjVKJF5AdJPoFMTeXxXGA9/ZcInpBOqra9+MVCl7
         6Jns9edanLzMlqVYjnJY2DEuNIuREGXAF/lkvowbg6Eb1eYhdHNetC3rgCnlOp2WJC
         Nkt2Xf/a11AqQ==
X-Nifty-SrcIP: [209.85.160.41]
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so14441531fac.1;
        Mon, 14 Nov 2022 16:09:46 -0800 (PST)
X-Gm-Message-State: ANoB5pkjk4pH3hLoSAzDeJZp35e1SY6GSWYPNYKjlzFqkgYD9kzIXJpK
        BbyjH31S8DuaGgn3iOgkon1JOo5ajt7wsO/qfW0=
X-Google-Smtp-Source: AA0mqf6eE8HDLCKvTlnxgDoYaH5GNpequC3qeHCSogElmgHpUN769SFeVKvjngqvP3+7CVcdknEjtjnNcyioMGjnIXI=
X-Received: by 2002:a05:6870:4b4a:b0:13b:5d72:d2c6 with SMTP id
 ls10-20020a0568704b4a00b0013b5d72d2c6mr7940778oab.287.1668470985073; Mon, 14
 Nov 2022 16:09:45 -0800 (PST)
MIME-Version: 1.0
References: <20221113160237.3152770-1-maz@kernel.org>
In-Reply-To: <20221113160237.3152770-1-maz@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 15 Nov 2022 09:09:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNASoWbJ458zLTP6NuC+5Q+YHOdzVOeCKQ3MeyXQYrkjneg@mail.gmail.com>
Message-ID: <CAK7LNASoWbJ458zLTP6NuC+5Q+YHOdzVOeCKQ3MeyXQYrkjneg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Restore .version auto-increment behaviour for
 Debian/RPM packages
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 1:02 AM Marc Zyngier <maz@kernel.org> wrote:
>
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index 60a2a63a5e90..e5c983afddab 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -90,7 +90,7 @@ if [ -n "$KDEB_PKGVERSION" ]; then
>         packageversion=$KDEB_PKGVERSION
>         revision=${packageversion##*-}
>  else
> -       revision=$(cat .version 2>/dev/null||echo 1)
> +       revision=$(init/build-version)


This does not work for out-of-tree builds
because init/build-version is a check-in source file.



For example, "make O=/tmp/foo bindeb-pkg" fails with:
.../linux/scripts/package/mkdebian: 93: init/build-version: not found


The correct code is:


          revision=$($srctree/init/build-version)




>         packageversion=$version-$revision
>  fi
>  sourcename=$KDEB_SOURCENAME
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index 70392fd2fd29..9cbd45f497ba 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -42,7 +42,7 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
>         Name: kernel
>         Summary: The Linux Kernel
>         Version: $__KERNELRELEASE
> -       Release: $(cat .version 2>/dev/null || echo 1)
> +       Release: $(init/build-version)


Ditto.

          Release: $($srctree/init/build-version)




>         License: GPL
>         Group: System Environment/Kernel
>         Vendor: The Linux Community
> --
> 2.34.1
>


--
Best Regards
Masahiro Yamada
