Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B567EAAF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjA0QUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjA0QUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:20:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4E2D518;
        Fri, 27 Jan 2023 08:20:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E702461CC3;
        Fri, 27 Jan 2023 16:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AF5C433AA;
        Fri, 27 Jan 2023 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674836406;
        bh=k+Kx2IUAiNH7/Hsbw5F29FTcB6qAdgkT8x4Ay/ZC6Bo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B/JoMB6X6ExwHvn1xDZdZD0iDncmkGAKhhBOtR+1TP0e2KqcEL+dN3Us9JpXJbldZ
         LTb/AIspmIDl7y8a3ayYLKPiz1ZICUQ3xg9Uoo6R2KirJHsA7gDgfRT+OkD3+rgDqL
         BFTvfnMsGNrv++01Jh9yxLZHZ5K7y4LDSJT+E5mMwadopGBgdJYBpwAzZaPLhJYPvI
         so6KjLxUWklaTcF2YSK07c5RUKXTEAEy1nDEoC5Pyh9J868aTt5+m0qxAnLpP1DJ/w
         m7XypxXYmMxf6YpLKZNxy/bclBgOcQkSh4+W38n2tAuDjUIXNv2OzHNvwUupGnVcaP
         vsbrA4SPVn9UA==
Received: by mail-oi1-f174.google.com with SMTP id dt8so1506456oib.0;
        Fri, 27 Jan 2023 08:20:06 -0800 (PST)
X-Gm-Message-State: AO0yUKVHwkLYYSagA8T4TMBi316Bo3y8zSasqyuWrwgu9ta3NGlTUOsq
        +8J/HUK6LnOAkPYwD7AvV06nbfOTJyPt7UmzXa4=
X-Google-Smtp-Source: AK7set9L06VKE57jTG5zdf7tikUW6gUddtKyVwOD+T3J9DJxHCKIv7zrIgih2qk5LMAZLbw7cIc687JziDfZtt+uQ1g=
X-Received: by 2002:aca:b604:0:b0:377:f944:a8b7 with SMTP id
 g4-20020acab604000000b00377f944a8b7mr55050oif.194.1674836405370; Fri, 27 Jan
 2023 08:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20230122141428.115372-1-masahiroy@kernel.org> <20230122141428.115372-6-masahiroy@kernel.org>
In-Reply-To: <20230122141428.115372-6-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 28 Jan 2023 01:19:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR=Dh0A1ApVBrD5uXdgj+wN2kA3DZ_xs6jnJNocnmXCKg@mail.gmail.com>
Message-ID: <CAK7LNAR=Dh0A1ApVBrD5uXdgj+wN2kA3DZ_xs6jnJNocnmXCKg@mail.gmail.com>
Subject: Re: [PATCH 6/7] setlocalversion: print ${KERNELRELEASE} if set
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 11:14 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> When KERNELRELEASE is overridden, include/config/kernel.release still
> stores the string would be returned by the script if KERNELRELEASE had
> not been overridden. This is not strange.
>
> include/config/kernel.release should store KERNELRELEASE that was used
> for building the kernel.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>




I will drop this patch because a regression was reported.


https://lore.kernel.org/linux-kbuild/CAK7LNATc_aPxiYXabzYbGXOMUW0Rcf0KQi6GBPvoy71uPuqKPg@mail.gmail.com/T/#m514a0303841590f48f0446b70f56986b9f1402cc









> ---
>
>  scripts/setlocalversion | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index 7c7cbefa5aa4..eff8cc831571 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -103,6 +103,11 @@ collect_files()
>         echo "$res"
>  }
>
> +if [ -n "${KERNELRELEASE}" ]; then
> +       echo "${KERNELRELEASE}"
> +       exit 0
> +fi
> +
>  if ! test -e include/config/auto.conf; then
>         echo "Error: kernelrelease not valid - run 'make prepare' to update it" >&2
>         exit 1
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
