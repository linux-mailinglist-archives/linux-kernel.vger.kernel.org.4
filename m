Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2189F728D6F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbjFICFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjFICFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:05:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E58430D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C43786521E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EF9C433EF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686276312;
        bh=KXYZnd2Dp+oBXwR3J88fqvQLX/aS78bYiYQ7cL2D2cg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ocWlxdA22HW5Y8nH8e5dpZ5DdeWgU7owemTJsWKdqs5G4xLVQjFrIn+u043uSTGuG
         rJDAbiNcOb7SI3vZS/CewQ2Qv4dU32P9qMd2LUBvUapaVl5Px+DrX+UVncg5aEiXmU
         SgIz/vRtWWy/kFdqyfSLq589GPYWQHOA+wuf2rcKw3DBYHYoRxoKSObMom4R37QdtV
         IGaoyt+REzz3Q+rjg8punU00RDoBuc91eniDEzJ5va2/Y7m2VV+ZJvcZdmmoMPXHkF
         xtda0mUHwvbdD26Tw8hX87KNImsg1sAybasEpl8K0uabvJEZRF5ZX8QaBdZJ+N5kRd
         cYIbuBK+CrPVw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-977ed383b8aso224605666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 19:05:12 -0700 (PDT)
X-Gm-Message-State: AC+VfDx16vwAN4EpzU97m8+7HJfuhQWVOBuNb+OD8OQrmxFIIas+1lEz
        vmRhrcTneD1lD6WJqYAymloij9ATS+60WfvqDkc=
X-Google-Smtp-Source: ACHHUZ4zyM/rSM2b/SUwpwD733zbZ7T8VbxYv4UjXz0Yb8MS1FH4LzMcs4rZzh6/q+xpwBJh1+8Oqa504tsvbHAUGSc=
X-Received: by 2002:a17:907:2d11:b0:96f:905e:6117 with SMTP id
 gs17-20020a1709072d1100b0096f905e6117mr347987ejc.56.1686276310499; Thu, 08
 Jun 2023 19:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230608022738.1861729-1-huqi@loongson.cn>
In-Reply-To: <20230608022738.1861729-1-huqi@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 9 Jun 2023 10:04:58 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4ve4injzQJNp5=y0qkE7szy6EwxNOnPzzFn0+aAGZgdg@mail.gmail.com>
Message-ID: <CAAhV-H4ve4injzQJNp5=y0qkE7szy6EwxNOnPzzFn0+aAGZgdg@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Fix function write_fcsr
To:     Qi Hu <huqi@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Qing Zhang <zhangqing@loongson.cn>,
        Enze Li <lienze@kylinos.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Miao HAO <haomiao19@mails.ucas.ac.cn>
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

Queued, thanks.

Huacai

On Thu, Jun 8, 2023 at 10:27=E2=80=AFAM Qi Hu <huqi@loongson.cn> wrote:
>
> Function "write_fcsr" uses wrong asm dest. Fix it!
>
> Reported-by: Miao HAO <haomiao19@mails.ucas.ac.cn>
> Signed-off-by: Qi Hu <huqi@loongson.cn>
> ---
>  arch/loongarch/include/asm/loongarch.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/incl=
ude/asm/loongarch.h
> index b3323ab5b78d..35e8a52fea11 100644
> --- a/arch/loongarch/include/asm/loongarch.h
> +++ b/arch/loongarch/include/asm/loongarch.h
> @@ -1496,7 +1496,7 @@ __BUILD_CSR_OP(tlbidx)
>  #define write_fcsr(dest, val) \
>  do {   \
>         __asm__ __volatile__(   \
> -       "       movgr2fcsr      %0, "__stringify(dest)" \n"     \
> +       "       movgr2fcsr      "__stringify(dest)", %0 \n"     \
>         : : "r" (val)); \
>  } while (0)
>
> --
> 2.40.1
>
