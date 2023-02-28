Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7F56A63B6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjB1XOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB1XOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:14:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D1610A94;
        Tue, 28 Feb 2023 15:14:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B0B56120A;
        Tue, 28 Feb 2023 23:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99528C4339B;
        Tue, 28 Feb 2023 23:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677626070;
        bh=EuDSLbyL847f/HVjpthXm2AGN7Q4ao68qqAhCFR1Zvg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fmwy5Jknu1D4F5joKoY0XSkhcJbyUjDInDKN/L6l7EtTsCa25+9HME3ES9qP+G4u7
         S5CmnyKFtCWp5kUKAKDCMCZh1K339+TE8BETghbKtX7gFBbQPAZeoZZZ2xXXZmE94R
         sZAYGrWJOrGdHgB8YIcST4keQ6QfPBPChU/Upo/cnZAq6vmbZdIYiSI2+aCwVXaAI0
         EpUVQBVX2aL4TvVaPc5H1Dp27F65kxkSyE6zpWtFwhpdpBHSjPwFlS9kwnfJVcOsG6
         cj8Y2Yyp7b59jcqu40sYD/n2j0vFR3nMZe88zunhPwZyo1o8ZC4BTM6mZXX16Vi9Y/
         KydOWm7PzZgvg==
Received: by mail-vs1-f49.google.com with SMTP id d7so17510714vsj.2;
        Tue, 28 Feb 2023 15:14:30 -0800 (PST)
X-Gm-Message-State: AO0yUKVRKjdqDlni9AoxDyNj5bJL7+m4JqDo9JCTnuKQR2a0dynHyn4c
        bULdzawMD7BifhjevK4agnCuCPPPsyRZHcp0rw==
X-Google-Smtp-Source: AK7set+aK7CTAl6t9dIuKtCbHvHO4bGajf2TPIoBmIXWZ6fe75ws4IO7Z84BmFpK2dG/8GBouSZKyo0t83gA3OM1jiM=
X-Received: by 2002:a67:f859:0:b0:411:bf89:685c with SMTP id
 b25-20020a67f859000000b00411bf89685cmr3147525vsp.6.1677626069544; Tue, 28 Feb
 2023 15:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20230117144929.423089-1-clement.leger@bootlin.com>
In-Reply-To: <20230117144929.423089-1-clement.leger@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 28 Feb 2023 17:14:18 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+eTmbjkOxutCLjgSSQ34yOVEQQQBtSH3v93heM_BYHRQ@mail.gmail.com>
Message-ID: <CAL_Jsq+eTmbjkOxutCLjgSSQ34yOVEQQQBtSH3v93heM_BYHRQ@mail.gmail.com>
Subject: Re: [PATCH] of/irq: add missing of_node_put() for interrupt parent node
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Saravana Kannan <saravanak@google.com>,
        Jean Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

+Saravana, Jean

On Tue, Jan 17, 2023 at 8:47=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <clement.le=
ger@bootlin.com> wrote:
>
> After calling of_irq_parse_one(), the node provided in the of_phandle_arg=
s
> has a refcount increment by one. Add missing of_node_put in of_irq_get()
> to decrement the refcount once used.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> ---
>
> While debugging a refcount problem with OF_DYNAMIC enabled (which is
> actually the only case were node refcount are really used), I noticed tha=
t
> platform_get_irq() was actually incrementing the refcount of an interrupt
> controller node. Digging into that function shows that it calls
> of_irq_get() which calls of_irq_parse_one() and finally of_irq_parse_raw(=
).
> Since it seems sane that the node returned in the of_phandle_args has a
> refcount incremented, I thought it is better to put the of_node_put() in
> the user even though it was hard to find any user doing so.

While investigating [1], I stumbled back on this. Was the failing case
you had using interrupts-extended? It looks to me like that path has a
get, but the 'interrupts' path does not. If so, this change is wrong.

Rob

[1] https://lore.kernel.org/all/20230228174019.4004581-1-jjhiblot@traphandl=
er.com/


>
>  drivers/of/irq.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index e9bf5236ed89..174900072c18 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -438,10 +438,16 @@ int of_irq_get(struct device_node *dev, int index)
>                 return rc;
>
>         domain =3D irq_find_host(oirq.np);
> -       if (!domain)
> -               return -EPROBE_DEFER;
> +       if (!domain) {
> +               rc =3D -EPROBE_DEFER;
> +               goto out;
> +       }
>
> -       return irq_create_of_mapping(&oirq);
> +       rc =3D irq_create_of_mapping(&oirq);
> +out:
> +       of_node_put(oirq.np);
> +
> +       return rc;
>  }
>  EXPORT_SYMBOL_GPL(of_irq_get);
>
> --
> 2.39.0
>
