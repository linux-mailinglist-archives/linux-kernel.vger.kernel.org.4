Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EC772AA6F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 10:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjFJI5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 04:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjFJI5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 04:57:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C2D30E3;
        Sat, 10 Jun 2023 01:57:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E00A361191;
        Sat, 10 Jun 2023 08:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3981BC4339B;
        Sat, 10 Jun 2023 08:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686387419;
        bh=Iee+wypTexQUR8K2T7uMz0+4RhthbX1msBu1bBQDFD4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tmI+uD684n12jhr1gJvdv1lzVx+1kzV9/wjIrBYQYAhNHNhnFSWhuStvVoqawNSE2
         Pu7/jDE/P8YbbaUVHhESPG5uJvfDmAyCh+dmgL5LeuMjjistVEaDbJQWbXeNEafxbl
         d4uDmqf9vM6QQeR1TirlavuXcbpV9fORi4PwFolfm1MWEYp8FR9ii3DP+WIsYeSJX9
         5J7/NvKro6ada38cS3UbKICBkQuUmYWM7EYDOuz7p/Evp5+Abh01aqavNgPpNBze7N
         FLSJk94PV2A4kezMAZwIqweP9+S3bYvue3rboJcMug6p3DkeQkSs/vJkS0d5vL+QDE
         iDMqSDkIDY4Sg==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-39a97058691so1173303b6e.2;
        Sat, 10 Jun 2023 01:56:59 -0700 (PDT)
X-Gm-Message-State: AC+VfDxxTyRvjI2M3BuzvbzuBa22xmPNia+BR77WvOpF45hjbWwPXRhY
        eoL5pxQieBdlWv+jnQMP/yOlLhBn74pQAMOWKbk=
X-Google-Smtp-Source: ACHHUZ45B9+vJu0Lfsj9S9kDUxsN76ThLC0nxg1vRtcpilnc8du/wMOz5B2KLxi2xKZM6nJKmyX/LNJ2HwyK2ORMZ9U=
X-Received: by 2002:a05:6808:1b1f:b0:398:9fa:655e with SMTP id
 bx31-20020a0568081b1f00b0039809fa655emr729889oib.31.1686387418474; Sat, 10
 Jun 2023 01:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230608142428.256985-1-masahiroy@kernel.org> <20230608142428.256985-4-masahiroy@kernel.org>
In-Reply-To: <20230608142428.256985-4-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 10 Jun 2023 17:56:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQfqXU+MFucqsaQmKALgz1f909G0+6ycEUd6+kgeiv2ww@mail.gmail.com>
Message-ID: <CAK7LNAQfqXU+MFucqsaQmKALgz1f909G0+6ycEUd6+kgeiv2ww@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] kbuild: generate KSYMTAB entries by modpost
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 11:24=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Commit 7b4537199a4a ("kbuild: link symbol CRCs at final link, removing
> CONFIG_MODULE_REL_CRCS") made modpost output CRCs in the same way
> whether the EXPORT_SYMBOL() is placed in *.c or *.S.
>
> For further cleanups, this commit applies a similar approach to the
> entire data structure of EXPORT_SYMBOL().
>
> The EXPORT_SYMBOL() compilation is split into two stages.
>
> When a source file is compiled, EXPORT_SYMBOL() is converted into a
> dummy symbol in the .export_symbol section.
>
> For example,
>
>     EXPORT_SYMBOL(foo);
>     EXPORT_SYMBOL_NS_GPL(bar, BAR_NAMESPACE);
>
> will be encoded into the following assembly code:
>
>     .section ".export_symbol","a"
>     __export_symbol__foo:
>             .asciz ""
>             .balign 4
>             .long foo - .


I hope this will work for all arches, but
unfortunately, the 0day bot reported breakages
on xtensa.

I will restore the code in v6.







--=20
Best Regards
Masahiro Yamada
