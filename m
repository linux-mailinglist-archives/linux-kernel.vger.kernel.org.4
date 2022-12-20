Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D707652119
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiLTNAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiLTNAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:00:20 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7D2BE36;
        Tue, 20 Dec 2022 05:00:19 -0800 (PST)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2BKCxvxw007257;
        Tue, 20 Dec 2022 21:59:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2BKCxvxw007257
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1671541197;
        bh=as1wqnJSUPY4IGZCP7Jr1uSZ8lvavefiRWrJjkOPjbk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vntPLzuj71ZKh61z01mTLpE2zVyv3Fej/dWQX2xm4FTJUb1AWRmE0l6fFoHrgsn78
         7b9wwKl6etKT0pmM19YqTZnWd1KsDfPpUrDZwNhvwVxJxtjYALFnCPU1qA52iv9KpQ
         /PdU4fKClowaaNgEW5pDdjETmcaKXhmxpqrobxTGcL6RsuLqn7gWD1kU4I1aZxqU9s
         Vyi5SwRSZ1UtgYevZYholnz4LbNmEHCqVLu4XPJLgoxBAVFZLLi/QJbNnmUHEIX7Ie
         OxXzAYR6OHP+PNZtuak+D8zx6AeH/uxzhTPTyorccJyqTYxrR5DAcAGSS32FMLRFd6
         +j/UhZYTO6+Bw==
X-Nifty-SrcIP: [209.85.160.46]
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1322d768ba7so15277193fac.5;
        Tue, 20 Dec 2022 04:59:57 -0800 (PST)
X-Gm-Message-State: AFqh2krKvoB738gwUXvLvmndIJu7bjlRWN8S8XEaOhFjE6+GGib8U2TV
        7+/hhSLpCUOPoy7vH6wwpRkIs5qe+zMAJKGpND0=
X-Google-Smtp-Source: AMrXdXvIZRCGb5rv78/PDTcz2Y7Kc/eQC18CumXPRSz4fKFJxbpS8kSZyozTqQpqkMPK5inAG+wcMvDKMRcRUXJ1EXw=
X-Received: by 2002:a05:6870:a11e:b0:144:d060:72e with SMTP id
 m30-20020a056870a11e00b00144d060072emr2088002oae.287.1671541196422; Tue, 20
 Dec 2022 04:59:56 -0800 (PST)
MIME-Version: 1.0
References: <20221220013233.2890335-1-robh@kernel.org>
In-Reply-To: <20221220013233.2890335-1-robh@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 20 Dec 2022 21:59:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNARMg-Opnnkc5Y6pv64S6+qqUALhze4Ag9ZrH=MyVEAA8Q@mail.gmail.com>
Message-ID: <CAK7LNARMg-Opnnkc5Y6pv64S6+qqUALhze4Ag9ZrH=MyVEAA8Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Optionally enable schema checks for %.dtb targets
To:     Rob Herring <robh@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Marek Vasut <marex@denx.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 10:32 AM Rob Herring <robh@kernel.org> wrote:
>
> While not documented, schema checks for single dtb targets mostly work
> already by setting 'CHECK_DTBS=1'. However, the dependencies are not
> handled and it only works if 'make dt_bindings_check' was run first and
> generated processed-schema.json. In addition, changing a binding file
> doesn't cause the schema to be rebuilt and dtb to be revalidated.
>
> Making this work turns out to be simple. Whenever CHECK_DTBS is set,
> make 'dt_binding_check' a 'dtbs_prepare' dependency.
>
> I reimplemented here what Masahiro had originally come up with a while
> back.


Oh, I just recalled this patch.

https://lore.kernel.org/all/CAA8EJprdCftvie3UF9QpCWr9oQ5SQbqW8OPOHg0qigf9=RXU-w@mail.gmail.com/T/#m2ce6b1de3c74333645831399c0d1775129d7661a

Dritry tested it.

Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>




>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 6aa709df6bde..a99d5c4de0fc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1467,7 +1467,10 @@ dtbs_prepare: include/config/kernel.release scripts_dtc
>
>  ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
>  export CHECK_DTBS=y
> -dtbs: dt_binding_check
> +endif
> +
> +ifneq ($(CHECK_DTBS),)
> +dtbs_prepare: dt_binding_check
>  endif
>
>  dtbs_check: dtbs
> --
> 2.35.1
>


--
Best Regards
Masahiro Yamada
