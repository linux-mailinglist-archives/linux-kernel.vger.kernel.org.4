Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73276AD456
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 02:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCGB6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 20:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCGB6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:58:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A41332511;
        Mon,  6 Mar 2023 17:58:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA496B81289;
        Tue,  7 Mar 2023 01:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B80C433A4;
        Tue,  7 Mar 2023 01:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678154304;
        bh=N3kCIZXvpJcz2QZXiYH4iMRNR11TLpTrveVjRHahOdA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pZh9nkChLMk7fCj090g6RML1nINIOyeCeFVbFRi39ZyOJyurOHNr+nMoA6NPkQ+u9
         xcViPquuQsAwIgwhgqicEO+ZFUP7SADrSuPyov19IWIelVhhHpLIfsq/f31VQIuIsc
         IUuv7myeh8S3b7eJuO1q7AIsEuiPl3B+iyMOXSPW2BSRDYH4x7e4SNtoZHdKKGrkrm
         EO74Q3nE8GO17amHrvev6xML5AsCpjlUDPY51cTR29CloAwAMgV2oSKy9vcrpJiiC2
         9VLyxRPlX5mD4GmolAeSqSLDHht+3zb0QOtNB03L5vQJnyBBeV19JzkgFJSg2ZhvNQ
         liTB2vHwvpTyQ==
Received: by mail-oi1-f175.google.com with SMTP id e21so8614378oie.1;
        Mon, 06 Mar 2023 17:58:24 -0800 (PST)
X-Gm-Message-State: AO0yUKUKg/tCpqdJc0WEsDN5WThtOAi9bYdLerXq4hVvBUObBdXYCyoy
        dBsqS8Lc417V4m+MMEIY2B9ZnK9NdbNpoY1Uwo0=
X-Google-Smtp-Source: AK7set9AqGnHWX4MzrCtiCcINd/s2K9vqNNfSac4GgnBF80ofq1oVksKZExfx2gs0oZ9WLEauJoLa0icmOJyST5i84U=
X-Received: by 2002:aca:f17:0:b0:37f:83ba:ee74 with SMTP id
 23-20020aca0f17000000b0037f83baee74mr7637997oip.1.1678154303623; Mon, 06 Mar
 2023 17:58:23 -0800 (PST)
MIME-Version: 1.0
References: <20230306101451.375844-1-arnd@kernel.org> <20230306101451.375844-2-arnd@kernel.org>
In-Reply-To: <20230306101451.375844-2-arnd@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 7 Mar 2023 10:57:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT=_wXhrbnW38bHZKpOqLwO-7hhrCWtTxQSi0WJL=CSBA@mail.gmail.com>
Message-ID: <CAK7LNAT=_wXhrbnW38bHZKpOqLwO-7hhrCWtTxQSi0WJL=CSBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kallsyms: expand symbol name into comment for debugging
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 7:15=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The assembler output of kallsyms.c is not meant for people to understand,
> and is generally not helpful when debugging "Inconsistent kallsyms data"
> warnings. I have previously struggled with these, but found it helpful
> to list which symbols changed between the first and second pass in the
> .tmp_vmlinux.kallsyms*.S files.
>
> As this file is preprocessed, it's possible to add a C-style multiline
> comment with the full type/name tuple.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> No idea if there is already a better way to debug this kind of problem,
> or if this causes a notable slowdown.
> ---
>  scripts/kallsyms.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index a239a87e7bec..ea1e3d3aaa6b 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -525,7 +525,8 @@ static void write_src(void)
>                                         table[i]->addr);
>                                 exit(EXIT_FAILURE);
>                         }
> -                       printf("\t.long\t%#x\n", (int)offset);
> +                       expand_symbol(table[i]->sym, table[i]->len, buf);
> +                       printf("\t.long\t%#x    /* %s */\n", (int)offset,=
 buf);




This is printed only for base_relative,
but ia64 will go away sooner or later,
so this seems good to me.

Applied to linux-kbuild. Thanks.











>                 } else if (!symbol_absolute(table[i])) {
>                         output_address(table[i]->addr);
>                 } else {
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
