Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72B7739682
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 06:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjFVErl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 00:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFVErj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 00:47:39 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47931992
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 21:47:37 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-33d928a268eso204965ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 21:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687409257; x=1690001257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RswzDNbUeMUjbPFYG+iZxviTZ/WORDfOHoGv7gqMsGc=;
        b=DNCJ+vgCu1f/LA+QlmAzQIbDaMNrX+aHSF7SCwGIQ6Hz6Ed/4Mh7KJj+oHBax1fZrd
         rK8BDTnVh6+IkfvyIiuSYF52FywsD5vTIvvDS0gMfUvGkIPf12JscQufegjK2WTSac8B
         bCQw0bGcqship4RGxusgz/H0tWJO/NhRhKpvSiTiNLPenLguAu3XOjF87v0XDJY9pEMP
         f0A9IFwtDC5M5lnpI+fBQ2uywRIyiScg8bu3qJnr+byx3uT9ULkORAg7El7b+WqqOQx9
         NQxiJXFVvFResRpZmbfTmsP4lWqU3W04tKHe1QhJJ0QXvH94r5zFCwEJa5q5ZYwQ9kuL
         +AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687409257; x=1690001257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RswzDNbUeMUjbPFYG+iZxviTZ/WORDfOHoGv7gqMsGc=;
        b=jdTW8LGbX8hWJhqhRyJq7ESSnB44wWnVL6WfAP2kBrZO5BnK5zJ71YtCHRDX4J0Xx8
         +9nG1rQ9mftWICeeyZ0ycONaWI0afaPJWp1nb2sEYirMHMqwrmW+0oK2dM8EwoMlW6IX
         d30AbQaR+iTRd/xGdNoNZapGjFIUwCdlGT74+8j5TirAXLPTaKs2DXyUWmvSElAOC7Bb
         vn6NZoor77X+W10lVNhBEM6ure2tXXl7MbkviWoGr3rvuFdKZyQkmzWnXeDJcfsfHEHt
         gFD+lDXyBSpIRu+ktyNREQs7hB8WxkICmdhV/6PgKMm18oE+nk8Mb9cHPDeanyBnCcf/
         qL/g==
X-Gm-Message-State: AC+VfDyvtgjTZEgjLezXH9llA31nVBeCMhlCH75uGKFKTumgZD4LOFs/
        cJaeFj806LFP+3NnlA7sBBa5ll2X/DeYN4+Cf8fv
X-Google-Smtp-Source: ACHHUZ60L8DcgJ08cWf/iLhYLzvZ6S+WWw4e8Y5xw/Mo5bi4ww5seBC1RfwSY5aW54qoG3AG2iH4aaWlS3oiGJwEpS0=
X-Received: by 2002:a05:6e02:1e01:b0:33e:549a:78c2 with SMTP id
 g1-20020a056e021e0100b0033e549a78c2mr2072301ila.5.1687409256992; Wed, 21 Jun
 2023 21:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230622005213.458236-1-isaacmanjarres@google.com>
In-Reply-To: <20230622005213.458236-1-isaacmanjarres@google.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 21 Jun 2023 21:47:26 -0700
Message-ID: <CANDhNCrEhx4LUPaz-FHZZJMG2yX670hk-vGTZs=HxiGR18zm5A@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Add support for dynamically allocated ramoops
 memory regions
To:     "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        kernel-team@android.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 5:52=E2=80=AFPM 'Isaac J. Manjarres' via kernel-tea=
m
<kernel-team@android.com> wrote:
>
> From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
>
> The reserved memory region for ramoops is assumed to be at a fixed
> and known location when read from the devicetree. This is not desirable
> in environments where it is preferred for the region to be dynamically
> allocated early during boot (i.e. the memory region is defined with
> the "alloc-ranges" property instead of the "reg" property).
>

Thanks for sending this out, Isaac!

Apologies, I've forgotten much of the details around dt bindings here,
so forgive my questions:
If the memory is dynamically allocated from a specific range, is it
guaranteed to be consistently the same address boot to boot?

> Since ramoops regions are part of the reserved-memory devicetree
> node, they exist in the reserved_mem array. This means that the
> of_reserved_mem_lookup() function can be used to retrieve the
> reserved_mem structure for the ramoops region, and that structure
> contains the base and size of the region, even if it has been
> dynamically allocated.

I think this is answering my question above, but it's a little opaque,
so I'm not sure.

> Thus invoke of_reserved_mem_lookup() in case the call to
> platform_get_resource() fails in order to support dynamically
> allocated ramoops memory regions.
>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
>  fs/pstore/ram.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index ade66dbe5f39..e4bbba187011 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -20,6 +20,7 @@
>  #include <linux/compiler.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_reserved_mem.h>
>
>  #include "internal.h"
>  #include "ram_internal.h"
> @@ -643,6 +644,7 @@ static int ramoops_parse_dt(struct platform_device *p=
dev,
>  {
>         struct device_node *of_node =3D pdev->dev.of_node;
>         struct device_node *parent_node;
> +       struct reserved_mem *rmem;
>         struct resource *res;
>         u32 value;
>         int ret;
> @@ -651,13 +653,20 @@ static int ramoops_parse_dt(struct platform_device =
*pdev,
>
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (!res) {
> -               dev_err(&pdev->dev,
> -                       "failed to locate DT /reserved-memory resource\n"=
);
> -               return -EINVAL;
> +               rmem =3D of_reserved_mem_lookup(of_node);

Nit: you could keep rmem scoped locally here.

Otherwise the code looks sane, I just suspect the commit message could
be more clear in explaining the need/utility of the dts entry using
alloc-ranges.

thanks
-john
