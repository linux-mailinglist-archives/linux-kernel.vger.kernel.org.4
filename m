Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56E9693BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBMBYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjBMBYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:24:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814BEEB4E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:23:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B66E60DFD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71086C433A8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676251435;
        bh=aiIT7U/MKZcAF6L/AJ9KYL+F8aqoN0dEGv5IBpK+ADA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EPBdAoYWjHUIiVEZk5OxLOz8f/J1vrW5QFVmyAWZOirF2ORDUlJiGb+/+L2gfSfET
         Or8Dk+QJGWiGPbU2/quk05cF27Ir9SvzjvzziOklr6tFhLXkTPD523jN5u6KFExV6G
         fed1EHXxRYICEq+d78Glqcj9eXZxTrE/gj2t9ZmlFOml2pixpxPqwiAjGH0bZMEshL
         9dkA38gKSFv6WEe0QZyVrVywS+5fsKcdboFX5d2o0dodpAC8Yf5sbWZiONtmiT5MUN
         G353XlnyzD1+3iTqIAIpR1XYjnwLF4N8DJdJXMjTuwmZYEkErhaRWoGqZ3qZksVUbR
         Tc+61TPQB48Bg==
Received: by mail-ed1-f49.google.com with SMTP id eq11so10924880edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:23:55 -0800 (PST)
X-Gm-Message-State: AO0yUKXOclXID+T63AjfFGn501PyoJ89YeB64WsfjoNcHafObNwBsroj
        hce8TqfXaGjztSIEdLAFVg0TbKvzdDo3YNuwYDY=
X-Google-Smtp-Source: AK7set8nxOhviNNQgEy7OIE+k9XOzNRgZaPGXNLi3iT4pMmOctJehGJkwVup1YR6i3+rpE+FrOgOTfarXYrMXfDDlYE=
X-Received: by 2002:a50:99c3:0:b0:49d:ec5d:28b1 with SMTP id
 n3-20020a5099c3000000b0049dec5d28b1mr6150941edb.7.1676251432248; Sun, 12 Feb
 2023 17:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20230212021534.59121-1-samuel@sholland.org>
In-Reply-To: <20230212021534.59121-1-samuel@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 13 Feb 2023 09:23:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS1RHyy09ZMP4zX3bKmt9e=WLTiKy+cMyw60RPaZMpdXQ@mail.gmail.com>
Message-ID: <CAJF2gTS1RHyy09ZMP4zX3bKmt9e=WLTiKy+cMyw60RPaZMpdXQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] riscv: Fix alternatives issues on for-next
To:     Samuel Holland <samuel@sholland.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Christoph Muellner <christoph.muellner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 10:15 AM Samuel Holland <samuel@sholland.org> wrote:
>
> Several people have reported that D1 fails to boot on linux-next.
> Patch 1 fixes a bug where early alternative patching used the wrong
> address. Patch 2 fixes a separate issue where the Zbb alternatives
> are incorrectly applied based on the 'C' extension instead of Zbb.
Great Job! Thx for fixup.

>
>
> Samuel Holland (2):
>   riscv: Fix early alternative patching
>   riscv: Fix Zbb alternative IDs
>
>  arch/riscv/errata/thead/errata.c     | 4 +---
>  arch/riscv/include/asm/errata_list.h | 5 -----
>  arch/riscv/lib/strcmp.S              | 2 +-
>  arch/riscv/lib/strlen.S              | 2 +-
>  arch/riscv/lib/strncmp.S             | 2 +-
>  5 files changed, 4 insertions(+), 11 deletions(-)
>
> --
> 2.37.4
>


-- 
Best Regards
 Guo Ren
