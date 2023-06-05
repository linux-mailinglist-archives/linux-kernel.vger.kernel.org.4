Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EEE72203D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjFEHza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjFEHzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:55:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AB3A1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:54:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2565a896d07so1682982a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 00:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685951691; x=1688543691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gctR4B/F366o79rRjaTlEjaSOwGINvdlm29r1EhTx8k=;
        b=IBl45+cFS9ZeEMlBdhrNyq0cLCZXUp9G+sX0aPY3DcZ/BVtbtXzhhMln/ahhy2ii4+
         +Im4NZNpTU4BVjeivBQmdyXeXmz1oSb2FbC01KI2VLeBwFTb6Cn6Ku3A2DRgYes0YMxe
         XlY9f6rsnvGeXdL/iTrTdrppudHw/QuzNE+v6n+xFkpNrBSKx6MMHOfudcjIDGYYm9U3
         UDwZo7f6TA6oNou5jTh0/aX9sVDy0cLfOVDLRlcPv0VegzWVUtgBmxz7db2FghSscCGH
         pY6uK8NqPINsManZWHcnUr0MuS9yIisigu8WLNE0Z9Ujr1/gjlfSKSgJqqq1BgLbidAy
         qeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685951691; x=1688543691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gctR4B/F366o79rRjaTlEjaSOwGINvdlm29r1EhTx8k=;
        b=MLVsGNbZDJlcQP00vII5sRnCecDy1cU+Z9UNB8xxFKdfAUf7CgT+s5GUExwqPO7YjX
         rxAZYi3VDFOEDeewwBWJjezWMxyRGprucr8d+mQSH2NvxWZhJU230hKxK/JY3GlCzx8k
         SHxWJAON6d3hWk25DqBUe2b2ButVIb9qiqWM2sz5yyhM3pYuFBE6WTaVlkUQBZGQRZSf
         PHiGRob8uA65zkW3BnDsP6fGjGXfsfNVxa5sxQdLVn6QLEC9pDX1liH7ZB3LoV8LM4PW
         zpUi0VwHErlu1nYm0VP1WXqQoHKk42tz2LmOT8vIJ0A7J7FUs0+uUdiSe7oxNvxcEZUP
         9RPQ==
X-Gm-Message-State: AC+VfDy2Op0IPfE++pLpaXgblymzL/Lgz+Q46esuCj5r8vMce4bRf9o5
        zkZVm36yt0oYKAoApmHxlMh5hjkHDfou7WLtKWY=
X-Google-Smtp-Source: ACHHUZ6eLBQnJQNw4F4yFQ8bwU7RsMY7hwIYuTv3LodX5gKrukGZKtV/mxNbtDuqrTDK18FqOuTB5jmqu8kShl7aS/U=
X-Received: by 2002:a17:90b:309:b0:253:3f25:3d99 with SMTP id
 ay9-20020a17090b030900b002533f253d99mr2570319pjb.45.1685951691671; Mon, 05
 Jun 2023 00:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230604075713.1027261-1-masahiroy@kernel.org> <20230604075713.1027261-2-masahiroy@kernel.org>
In-Reply-To: <20230604075713.1027261-2-masahiroy@kernel.org>
From:   Ying Liu <gnuiyl@gmail.com>
Date:   Mon, 5 Jun 2023 15:54:40 +0800
Message-ID: <CAOcKUNU_7eCdMvAvx8YyGUHVcz4vjvCHPQ6oo5K4cWQEL4+oig@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: imx: turn imx8{qm, qxp}-ldb into
 single-object modules
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Liu Ying <victor.liu@nxp.com>, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 4, 2023 at 3:57=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
> With the previous fix, these modules are built from a single C file.
>
> Rename the source files so they match the module names.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> (no changes since v1)
>
>  drivers/gpu/drm/bridge/imx/Makefile                           | 4 ----
>  drivers/gpu/drm/bridge/imx/{imx8qm-ldb-drv.c =3D> imx8qm-ldb.c} | 0
>  .../gpu/drm/bridge/imx/{imx8qxp-ldb-drv.c =3D> imx8qxp-ldb.c}   | 0
>  3 files changed, 4 deletions(-)
>  rename drivers/gpu/drm/bridge/imx/{imx8qm-ldb-drv.c =3D> imx8qm-ldb.c} (=
100%)
>  rename drivers/gpu/drm/bridge/imx/{imx8qxp-ldb-drv.c =3D> imx8qxp-ldb.c}=
 (100%)

[...]

Reviewed-by: Liu Ying <victor.liu@nxp.com>
