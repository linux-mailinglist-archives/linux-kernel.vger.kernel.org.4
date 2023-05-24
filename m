Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5109270FFB9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjEXVM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjEXVMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:12:54 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95077F5
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:12:51 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-33164ec77ccso47135ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684962771; x=1687554771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zT/HDg/gBVolXCcggpB7iSC/DWvpNoZ2VGMNWSuR74=;
        b=RkcFmnM0HLWQuKc8UgAw0e9xvrWfxkZ18UU71V/+md6GlosqEs5GzDY/a4UJxCkNm2
         yFek/5dSOlr36tQAQYPyVVOkLm7ZbOBjzFKZuVQbE7WLKT82ane7Hpz3IMu0xgVecZwN
         SmofscwdIr2/0IZ+GlSvXW+QSbErcSYt2ufNNnYqWJ78AnD/90rAY35gMrSkatVwJz1R
         Lr4hfQl+f+9jQ/xnercKbKQ0tlv8BIuAId9wXR5DsBdh6R2bYqLw8izC58h2uNHZrE5W
         JGUKVXqmKPeS2SQ7bBgM95TiTju8NigM2h5+wC00qaOy/ICoPS+GZGVW6wAPMuevuqmY
         jgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684962771; x=1687554771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zT/HDg/gBVolXCcggpB7iSC/DWvpNoZ2VGMNWSuR74=;
        b=TYOpOh6FzZctLeve/BYpQIa1kMyMuNDsXO42ATH0kqDoPtC9hysdxg0OB13sXU7GdB
         ZQxf/V1/40w6TiD7CTLK17iaF+V2KqLmUEGIRttpnLsDuJ4wyKIDthKsucuWyq8LpL2W
         EnJfjKQ1+3MYPwYMGd2QToglM/hetobQ+o9s1mazoApQuEvuYu2UbeohcuEZLFiFIdot
         DWRBOfZ20TCwE+rUHA+sMO9R26wetDx3fq1oxhN5V58PPIZtBXGbv2psrojsyrh5bz/Q
         Kfo4u+GDeSM18xm4CQ3xqpu7s0KWlTpnTTchf99mJrm0c3IJ1+A6hEL7/BrzNVBMfMr5
         2A8w==
X-Gm-Message-State: AC+VfDxCFMudQEQKo1PcisxDafz11cXMfsVlLiJ/yO0OqqgqlOPBk/st
        8R3CnmlAbgkqRe66JAem3puArewbkit+JOWxMAI/lQ==
X-Google-Smtp-Source: ACHHUZ5PVlgmDkUaggheQ9kq1zpCNNG/WvpI/zFjM6+9rZiEuRcJv3dN4QRqcRItX2BQQ3VJJ7rOlQJYb3u3SyZXEqE=
X-Received: by 2002:a05:6e02:2196:b0:337:8a1b:b9ee with SMTP id
 j22-20020a056e02219600b003378a1bb9eemr66790ila.14.1684962770819; Wed, 24 May
 2023 14:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=FV=WRecTWsFM96k81YAx1=jJT0vpS4EPP0ZfWFUGHNFx9Tw@mail.gmail.com>
 <20230524072816.1131039-1-yangcong5@huaqin.corp-partner.google.com> <20230524072816.1131039-2-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20230524072816.1131039-2-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Wed, 24 May 2023 14:12:36 -0700
Message-ID: <CAD=FV=UXD7EKkfghpGWp9ziB8DX-RbUzs+zOex9trRT4J-f+Yg@mail.gmail.com>
Subject: Re: [v2 1/4] drm/panel: Support for Starry-himax83102-j02 TDDI
 MIPI-DSI panel
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     daniel@ffwll.ch, neil.armstrong@linaro.org, sam@ravnborg.org,
        airlied@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, hsinyi@google.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 24, 2023 at 12:28=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The Starry-himax83102-j02 is a 10.51" WUXGA TFT panel. which fits in nice=
ly
> with the existing panel-boe-tv101wum-nl6 driver. From the datasheet[1], M=
IPI
> needs to keep the LP11 state before the lcm_reset pin is pulled high, so
> increase lp11_before_reset flag.
>
> [1]: https://github.com/HimaxSoftware/Doc/tree/main/Himax_Chipset_Power_S=
equence
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu=
/drm/panel/panel-boe-tv101wum-nl6.c
> index f5a6046f1d19..5c8ec263e11f 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -76,6 +76,75 @@ struct panel_init_cmd {
>         .len =3D sizeof((char[]){__VA_ARGS__}), \
>         .data =3D (char[]){__VA_ARGS__} }
>
> +static const struct panel_init_cmd starry_himax83102_j02_init_cmd[] =3D =
{

nit: Please have the order of the tables match the order they're
referenced. That means this should come _after_
"starry_qfh032011_53g_init_cmd", not at the start of the tables.


-Doug
