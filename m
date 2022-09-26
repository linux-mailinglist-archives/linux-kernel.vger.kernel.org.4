Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDAA5EB36D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiIZVpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiIZVpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:45:03 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5170FA6AD3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:44:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y136so8008175pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cUAhqALEYiUXv3Zebu/ZG3Ne7/xgpixkjK+wB3Qg6gw=;
        b=bEmZYNoOPfUOtLUXhjWagv3T/8qLpqKlf904MOD8uU41zx2KRJTvsVU89JlIXk9Zbx
         UodCPBJxCMTHJALH+cvvijMiSyyD7GopoKiG7jGPVlouMCoTKOaHJjSY5fe4ioTHR/2S
         ffG9k+G41w983K6fPLPDHYE3EKUYa4XgxMWAadLd6AyiQJjNcDzlIH1dmHp+iyqC7xvM
         F74FDZN7T7gT0h/7m1hqBcwlXvSAGBNZ/hvMeOdgtmjIIm7d4NCyyE8wGkO5ZjRkrnyT
         LJs5kRm80cYlzRHSdjDmsIyoFkvpQ2zAYZhymxbIZl1BlxPY2hFcPeHwIDMlR2qufm1R
         qq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cUAhqALEYiUXv3Zebu/ZG3Ne7/xgpixkjK+wB3Qg6gw=;
        b=igmRBKUaLYtPtv+2gfIzdZlRSsWvuORZHPcK+EWgQ0McN3vVcoEEgmfpLszeXvkUjk
         2oOIEbl7IGuKslTCJjIZ9cEHSDEUboW56MIjGalX8sjSa+4ynih/NeBtvUkloJX+2/sF
         V8pr7qLGmboONltdxRnWBAr4BItsBCkd753D/5XN/O+YHiOWw+cNG8YvjHLucveeErw4
         B12VsZqsnqeCls+vPGENxlPzJjalKSoM8sijorNkFISvBa4vxZ0tEbyVupqOULo7qKLh
         VFg2QT6yPsg//0Fiy2LMf8s0u7Jddt+c752IPo6HxzGXqQr9//QjJGUJtu8iBKER5Tpi
         /tWw==
X-Gm-Message-State: ACrzQf3g6prFrH7uPqfphThJCV5xwV0o93pj//jxCxgIlz1rp6XnIztB
        QXajHbfEvy4GSdm61hSX37suibhHJkM/harcfLYvkQ==
X-Google-Smtp-Source: AMsMyM6QmcD1KbLT6/X7nBM0XJ7xTiM9QgN0CqNAnhRmDVr7kcrvOyczLw8uPWXrvN/0yWwmiCUEq9/9UEzcvynqr3s=
X-Received: by 2002:a05:6a02:205:b0:420:8b7e:3ff with SMTP id
 bh5-20020a056a02020500b004208b7e03ffmr20895224pgb.427.1664228698203; Mon, 26
 Sep 2022 14:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220924082425.3116757-1-masahiroy@kernel.org>
In-Reply-To: <20220924082425.3116757-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Sep 2022 14:44:46 -0700
Message-ID: <CAKwvOd=RkYuiEJ1Kz+JnLSsLi_X-G22YPeqwLtZrwC+s8awfrA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: hide error checker logs for V=1 builds
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 1:25 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> V=1 (verbose build) shows commands executed by Make, but it may cause
> misunderstanding.
>
> For example, the following command shows the outstanding error message.
>
>   $ make V=1 INSTALL_PATH=/tmp install
>   test -e include/generated/autoconf.h -a -e include/config/auto.conf || (                \
>   echo >&2;                                                       \
>   echo >&2 "  ERROR: Kernel configuration is invalid.";           \
>   echo >&2 "         include/generated/autoconf.h or include/config/auto.conf are missing.";\
>   echo >&2 "         Run 'make oldconfig && make prepare' on kernel src to fix it.";      \
>   echo >&2 ;                                                      \
>   /bin/false)
>     unset sub_make_done; ./scripts/install.sh
>
> It is not an error. Make just showed the recipe lines it has executed,
> but people may think that 'make install' has failed.
>
> Likewise, the combination of V=1 and O= shows confusing
> "*** The source tree is not clean, please run 'make mrproper'".
>
> Suppress such misleading logs.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index a5e9d9388649..833052fcf48a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -583,7 +583,7 @@ quiet_cmd_makefile = GEN     Makefile
>         } > Makefile
>
>  outputmakefile:
> -       $(Q)if [ -f $(srctree)/.config -o \
> +       @if [ -f $(srctree)/.config -o \
>                  -d $(srctree)/include/config -o \
>                  -d $(srctree)/arch/$(SRCARCH)/include/generated ]; then \
>                 echo >&2 "***"; \
> @@ -739,7 +739,7 @@ else # !may-sync-config
>  PHONY += include/config/auto.conf
>
>  include/config/auto.conf:
> -       $(Q)test -e include/generated/autoconf.h -a -e $@ || (          \
> +       @test -e include/generated/autoconf.h -a -e $@ || (             \
>         echo >&2;                                                       \
>         echo >&2 "  ERROR: Kernel configuration is invalid.";           \
>         echo >&2 "         include/generated/autoconf.h or $@ are missing.";\
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
