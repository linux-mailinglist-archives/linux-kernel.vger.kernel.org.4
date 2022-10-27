Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C0960FA71
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbiJ0Ocz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiJ0Ocw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:32:52 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0418179988;
        Thu, 27 Oct 2022 07:32:51 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 29REWQkr000621;
        Thu, 27 Oct 2022 23:32:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 29REWQkr000621
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1666881147;
        bh=4HDEXnWr6VYARBxhtIHHxyW+0nXTxgQlhNlzoM6U/Ls=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cEMOUuGRx0CiM5dMBySppPWAb4vz2zKfDBSxF4AaxelQ/VZgyeTz6mR356DZvwGBa
         L3NaQm+ysBspNbVVKOWPlMn6/0PplDiKBUg3GhXYU9BkTbi9sxuUvk+WElbubd1YOi
         6028JqJm4ULcqhRMu4AUwjYsrRn6JIMdWzOkXjn8DxDUQKF7HG3/ATh3bomtk47REf
         m7hLWNKkhA6XpXQlCfgMQ7jK9Llyk/WehKgjD9RTCQR05P/9gNZ5CLsh/Zru2hgSKa
         IQY1BoGcyNjwcLK1yJ8gNdAWs8XQaojSQ/fGnWHkP/z2b6KgRHhBQguArRzJlutDt9
         KRp0rWdr3qVDg==
X-Nifty-SrcIP: [209.85.167.169]
Received: by mail-oi1-f169.google.com with SMTP id s125so1777921oib.6;
        Thu, 27 Oct 2022 07:32:26 -0700 (PDT)
X-Gm-Message-State: ACrzQf3RFApk6ytHKf8GM4ti80xAt1WjrVgWChO2/16kJOSKQ07DGf1X
        yDZHGVj8Luy9fxOZCaqAR5JW3/dTgw0AK7YNZAE=
X-Google-Smtp-Source: AMsMyM4tqsHTbHWe+6yz0cnG9uKVuvy2JEqtwziNTOAmy0shG5LX1mgNgc+M3G+YmcTGs8ePnEbYIasezCTtPb52hqI=
X-Received: by 2002:aca:bbd4:0:b0:353:f167:6fd3 with SMTP id
 l203-20020acabbd4000000b00353f1676fd3mr5067095oif.287.1666881145769; Thu, 27
 Oct 2022 07:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221024212144.2852069-1-glider@google.com> <20221024212144.2852069-3-glider@google.com>
In-Reply-To: <20221024212144.2852069-3-glider@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 27 Oct 2022 23:31:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfKkiNSUfZAqDQd15O8NAhpX13dHDuGn3OPL_b_F_92g@mail.gmail.com>
Message-ID: <CAK7LNARfKkiNSUfZAqDQd15O8NAhpX13dHDuGn3OPL_b_F_92g@mail.gmail.com>
Subject: Re: [PATCH 3/5] Kconfig.debug: disable CONFIG_FRAME_WARN for KMSAN by default
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 6:22 AM Alexander Potapenko <glider@google.com> wrote:
>
> KMSAN adds a lot of instrumentation to the code, which results in
> increased stack usage (up to 2048 bytes and more in some cases).
> It's hard to predict how big the stack frames can be, so we disable
> the warnings for KMSAN instead.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-kbuild@vger.kernel.org
> Link: https://github.com/google/kmsan/issues/89
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  lib/Kconfig.debug | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 3fc7abffc7aa2..29280072dc0e4 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -400,8 +400,9 @@ config FRAME_WARN
>         default 1536 if (!64BIT && XTENSA)
>         default 1024 if !64BIT
>         default 2048 if 64BIT
> +       default 0 if KMSAN



This is wrong.

Kconfig picks up the first default entry which has
true 'if' condition.


Since (!64BIT || 64BIT) covers all the possible cases,
this patch is just adding dead code.







>         help
> -         Tell gcc to warn at build time for stack frames larger than this.
> +         Tell the compiler to warn at build time for stack frames larger than this.
>           Setting this too low will cause a lot of warnings.
>           Setting it to 0 disables the warning.
>
> --
> 2.38.0.135.g90850a2211-goog
>


-- 
Best Regards
Masahiro Yamada
