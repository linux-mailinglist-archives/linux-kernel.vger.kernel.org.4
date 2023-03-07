Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F73F6AD416
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 02:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCGBfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 20:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCGBfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:35:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E17227AD;
        Mon,  6 Mar 2023 17:35:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB8DA611B0;
        Tue,  7 Mar 2023 01:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36402C433A4;
        Tue,  7 Mar 2023 01:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678152949;
        bh=96GxmiQ5du45sMf6FYtMZt0H5BR5G3/xraIYvMTYkG4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jHzidSvgmH7a+nM3iFkHHaUFAHqiYYqc0gDHNHVVQu71UVjJqDz/5r6ak4rUK+5nc
         BHzabmhamO3QQLs+Sah4HUDTeun4M31QcMya5SaCaHS5beX0EnhCESwI+qfcECo5CA
         0lfKz6qbeOH76XfRuu9HpkML6FCWPlmGYJ0qR3oMu9VOLpuqVNz7m5LyBWv4rwzkSh
         Yz0Q1D2NN5uUiizgfnqzDEK3KhheJNAy/8/p0BwBXIChUbGNY/1Nn/Arvsqn04v6gn
         moeAoR0VIoax4PHwARDbaerubW+z2LED9+Zk1+Iwe87jZXT1328Loypy2o1K20C05X
         9ekaNy06JphbA==
Received: by mail-oi1-f172.google.com with SMTP id e21so8586584oie.1;
        Mon, 06 Mar 2023 17:35:49 -0800 (PST)
X-Gm-Message-State: AO0yUKUUZzGC4u0wqQ7umLjI4Khjl9bmmg4ln7VM/ksggaRJA+NkT2Zp
        AL6uBvxi4jH/dKUwNa9Rg8/QCaHAqJqiSwjmyxs=
X-Google-Smtp-Source: AK7set8lVj4D13JZcH4i0yjo+2bsVAwD1icJ02iTozW0rRyWQO3rx1bHYKQ6qlK0oQnze4/jSag2RELyvpxUUd0Jst0=
X-Received: by 2002:aca:1c09:0:b0:384:2019:c201 with SMTP id
 c9-20020aca1c09000000b003842019c201mr4089334oic.8.1678152948346; Mon, 06 Mar
 2023 17:35:48 -0800 (PST)
MIME-Version: 1.0
References: <20230306101451.375844-1-arnd@kernel.org>
In-Reply-To: <20230306101451.375844-1-arnd@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 7 Mar 2023 10:35:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNASEmWTz_kPr5X9y9=cC+05NycoxDd241k06+ziL_zPGgg@mail.gmail.com>
Message-ID: <CAK7LNASEmWTz_kPr5X9y9=cC+05NycoxDd241k06+ziL_zPGgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kallsyms: add kallsyms_seqs_of_names to list of
 special symbols
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
> My randconfig build setup ran into another kallsyms warning:
>
> Inconsistent kallsyms data
> Try make KALLSYMS_EXTRA_PASS=3D1 as a workaround
>
> After adding some debugging code to kallsyms.c, I saw that the recently
> added kallsyms_seqs_of_names symbol can sometimes cause the second stage
> table to be slightly longer than the first stage, which makes the
> build inconsistent.
>
> Add it to the exception table that contains all other kallsyms-generated
> symbols.
>
> Fixes: 60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_looku=
p_name()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  scripts/kallsyms.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 8a68179a98a3..a239a87e7bec 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -119,6 +119,7 @@ static bool is_ignored_symbol(const char *name, char =
type)
>                 "kallsyms_markers",
>                 "kallsyms_token_table",
>                 "kallsyms_token_index",
> +               "kallsyms_seqs_of_names",
>                 /* Exclude linker generated symbols which vary between pa=
sses */
>                 "_SDA_BASE_",           /* ppc */
>                 "_SDA2_BASE_",          /* ppc */
> --
> 2.39.2
>


Applied to linux-kbuild/fixes.
Thanks.


--=20
Best Regards
Masahiro Yamada
