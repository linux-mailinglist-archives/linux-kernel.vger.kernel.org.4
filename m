Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0640A70B2EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 03:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjEVBsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 21:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjEVBsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 21:48:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88A0DE;
        Sun, 21 May 2023 18:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 392D56115E;
        Mon, 22 May 2023 01:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBA0C4339B;
        Mon, 22 May 2023 01:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684720096;
        bh=LXrAyE8xoklF4IlUUrc+eKNzPWHP+rqO9CrKVwazuIw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pURT/Ja7uOZETyQSFp1XKbEy8ZXM88D4sL79KEJIguZ4JqxxZ8VRC1XIFS2CcKEuZ
         6uQ4ueJ/KPGaq2jN2P5zp/To/Dkf0AsTbf11zCX1THG0sDQttTHMhPOorRMixGi8D/
         V/VEwWAeRkG/DdemFMoc9mqJDoid+8kL+rjQSWCMiOZQ5pR1CxxRrqw9CDeDeNHv12
         XczCwSmvpWwdqxqp60RXmbW6VXf4ajeoO9r0mfHFH4kNs03LCYIq5ZjDkeSWlKZaC3
         e0w8lmbxs0OSKDNuEDmHKtW+wGlEuULq/4OMbeEYc9b8JlTtPiSztBgquoYJSmkOmD
         bzDxUm4nPhR/Q==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-19ad6baf96dso1094401fac.0;
        Sun, 21 May 2023 18:48:16 -0700 (PDT)
X-Gm-Message-State: AC+VfDyWuPbj5JgJw5TsqW/29+W1DJl87kghH8C6iEwM87BK5gXBhPU8
        M32xPkNSgq9DUCSW+3AdQcL6A+1sbWPkHTExfgY=
X-Google-Smtp-Source: ACHHUZ5XTk3iAoquz3ZPOmQoeS4GpU5RJJnAjw6YBirZieBIKNUZKIQAtGsjV/qlW4d6g/Hom7CA7YsRFVImJ4pgYjM=
X-Received: by 2002:a05:6870:c803:b0:196:ca0:c575 with SMTP id
 ee3-20020a056870c80300b001960ca0c575mr4509701oab.3.1684720095855; Sun, 21 May
 2023 18:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org>
In-Reply-To: <20230521160426.1881124-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 22 May 2023 10:47:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNARjzGnj+sYX=_5yQ+8qoOQ2KB5N-_Ye53Ru3=XicezTYw@mail.gmail.com>
Message-ID: <CAK7LNARjzGnj+sYX=_5yQ+8qoOQ2KB5N-_Ye53Ru3=XicezTYw@mail.gmail.com>
Subject: Re: [PATCH v6 00/20] Unify <linux/export.h> and <asm/export.h>,
 remove EXPORT_DATA_SYMBOL(), faster TRIM_UNUSED_KSYMS
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 1:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
>
> This patch set refactors modpost first to make it easier to
> add new code.
>
> My goals:
>
>  - Refactors EXPORT_SYMBOL, <linux/export.h> and <asm/export.h>.
>    You can still put EXPORT_SYMBOL() in *.S file, very close to the defin=
ition,
>    but you do not need to care about whether it is a function or a data.
>    This removes EXPORT_DATA_SYMBOL().
>
>  - Re-implement TRIM_UNUSED_KSYMS in one-pass.
>    This makes the building faster.
>
>  - Move the static EXPORT_SYMBOL check to modpost.
>    This also makes the building faster.
>
> This patch set is applicable to
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git =
kbuild





I pushed this series to
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 modpost-v6-testing




--=20
Best Regards
Masahiro Yamada
