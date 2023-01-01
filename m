Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACB765A92F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 07:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjAAGjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 01:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAAGjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 01:39:08 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29756633F;
        Sat, 31 Dec 2022 22:39:06 -0800 (PST)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 3016cpCZ003313;
        Sun, 1 Jan 2023 15:38:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 3016cpCZ003313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1672555132;
        bh=7ybTzL94IkNlUhsJSs+/8TOUWgjgmDY30w2NqMVmPAA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f8O5BrAzaYWfxyAFagWX61Q6TFy3MBAHJ63HyAPTeQuQrAr1QSo0t6kQbWfDoqYbY
         hRDHyZ38XT4OY1LebIAgQkrbllU4CSddYK3WghVbezWmnpPblUs2piVXhNd2BVXGXx
         9bkLzcwjpMqlxd3kKWdPsqjWK2DzK2/R69tja/FX3tZ9W2mqXLvFAeDxSXbmsuKloB
         rgCn7GNN8VvvupIT+QnPVSyDso16mtkRjC8tiU/ci9Iu3i6xzaR226nb3BF+Ygf0O8
         KLt5+XGg+V/FwZRIWeJ65inL72gxHt9IrktwQUl6B5OK03HbiAxD/FA4o1k+vyv6ce
         SyVd8mlghYylg==
X-Nifty-SrcIP: [209.85.167.182]
Received: by mail-oi1-f182.google.com with SMTP id s187so22618932oie.10;
        Sat, 31 Dec 2022 22:38:52 -0800 (PST)
X-Gm-Message-State: AFqh2kopXorRZU/SzIUaHk+OJmSV/WCaFgpN/buo6TAVdR3wMwIGoI3i
        k4NbLfxW2yXpGArFmPCKVcJuCS2UY3rneUgpf0Q=
X-Google-Smtp-Source: AMrXdXu+sH/J29tITqYNuK7Zi+ahw7RsTIWntn7Gvl7q2J86sr0xn+7ASIn4Ezb6OaV2c/rMiUYaFNra1Ozx+JwAnnk=
X-Received: by 2002:aca:3755:0:b0:35e:7c55:b015 with SMTP id
 e82-20020aca3755000000b0035e7c55b015mr2032967oia.287.1672555131207; Sat, 31
 Dec 2022 22:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20221211130408.2800314-1-masahiroy@kernel.org> <20221231174745.jc3qlmwydujswrne@pengutronix.de>
In-Reply-To: <20221231174745.jc3qlmwydujswrne@pengutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 1 Jan 2023 15:38:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQrywdeJL8YAp7ZSgehkb6dimGEtOWNFuUfXi=k_234Pg@mail.gmail.com>
Message-ID: <CAK7LNAQrywdeJL8YAp7ZSgehkb6dimGEtOWNFuUfXi=k_234Pg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: change module.order to list *.o instead of *.ko
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 1, 2023 at 2:48 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 11.12.2022 22:04:07, Masahiro Yamada wrote:
> > scripts/Makefile.build replaces the suffix .o with .ko, then
> > scripts/Makefile.modpost calls the sed command to change .ko back
> > to the original .o suffix.
> >
> > Instead of converting the suffixes back-and-forth, store the .o paths
> > in modules.order, and replace it with .ko in 'make modules_install'.
> >
> > This avoids the unneeded sed command.
>
> This breaks direct compilation of kernel modules (on current Linus's
> master):
>
> | $ make drivers/net/can/dev/can-dev.ko
> | [...]
> |   CC [M]  drivers/net/can/dev/skb.o
> |   CC [M]  drivers/net/can/dev/calc_bittiming.o
> |   CC [M]  drivers/net/can/dev/bittiming.o
> |   CC [M]  drivers/net/can/dev/dev.o
> |   CC [M]  drivers/net/can/dev/length.o
> |   CC [M]  drivers/net/can/dev/netlink.o
> |   LD [M]  drivers/net/can/dev/can-dev.o
> | make[5]: 'drivers/net/can/dev/can-dev.mod' is up to date.
> |   LDS     scripts/module.lds
> |   MODPOST Module.symvers
> | drivers/net/can/dev/can-dev.ko: No such file or directory
> | make[1]: *** [.../linux/scripts/Makefile.modpost:129: Module.symvers] Error 1
> | make: *** [.../linux/Makefile:1982: single_modules] Error 2
>
> According to "make help" it should be possible:
>
> |  dir/file.ko     - Build module including final link
>
> I've bisected it to:
>
> | first bad commit: [f65a486821cfd363833079b2a7b0769250ee21c9] kbuild: change module.order to list *.o instead of *.ko
>
> regards,
> Marc



Thanks for the report. I submitted a fix.

https://lore.kernel.org/lkml/20230101060709.208512-1-masahiroy@kernel.org/T/#u




>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |



-- 
Best Regards
Masahiro Yamada
