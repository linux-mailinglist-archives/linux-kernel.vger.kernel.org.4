Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A77725B01
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbjFGJqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239540AbjFGJqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:46:35 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735C31BC3;
        Wed,  7 Jun 2023 02:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1686131189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+JVWsvrdVX8wdErkW3HdLVdcuF44A70+ru4mrWO8kU=;
        b=heHvTkQ2KhJyt4+ejweblXOzLZXnk+mexY7Dfs84uv562HefMMHKPG6IOtRHBw5gbhRLvv
        kb6WNNnm+1RerASbK0OV+AHVOW6j+mQQKxKUP8iDYiwwckKZvnQAP7OKhJFKAM6W1/waxk
        vgLBm5v8I/lPsoUsg+kiNlgYsK3JFXM=
Message-ID: <845a483ed09728c712ad57b1fe9bc5c930a72d98.camel@crapouillou.net>
Subject: Re: [PATCH] drm/ingenic: Kconfig: select REGMAP and REGMAP_MMIO
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 07 Jun 2023 11:46:27 +0200
In-Reply-To: <20230607072253.440613-1-suijingfeng@loongson.cn>
References: <20230607072253.440613-1-suijingfeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sui,

Le mercredi 07 juin 2023 =C3=A0 15:22 +0800, Sui Jingfeng a =C3=A9crit=C2=
=A0:
> Otherwise its failed to pass basic compile test on platform without
> REGMAP_MMIO selected by defconfig
>=20
> make -j$(nproc) ARCH=3Dmips CROSS_COMPILE=3Dmips64el-linux-gnuabi64-
>=20
> =C2=A0 SYNC=C2=A0=C2=A0=C2=A0 include/config/auto.conf.cmd
> =C2=A0 Checking missing-syscalls for N32
> =C2=A0 CALL=C2=A0=C2=A0=C2=A0 scripts/checksyscalls.sh
> =C2=A0 Checking missing-syscalls for O32
> =C2=A0 CALL=C2=A0=C2=A0=C2=A0 scripts/checksyscalls.sh
> =C2=A0 CALL=C2=A0=C2=A0=C2=A0 scripts/checksyscalls.sh
> =C2=A0 MODPOST Module.symvers
> ERROR: modpost: "__devm_regmap_init_mmio_clk"
> [drivers/gpu/drm/ingenic/ingenic-drm.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
> make: *** [Makefile:1978: modpost] Error 2
>=20
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
> =C2=A0drivers/gpu/drm/ingenic/Kconfig | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/ingenic/Kconfig
> b/drivers/gpu/drm/ingenic/Kconfig
> index a53f475d33df..7457c0b65034 100644
> --- a/drivers/gpu/drm/ingenic/Kconfig
> +++ b/drivers/gpu/drm/ingenic/Kconfig
> @@ -5,6 +5,8 @@ config DRM_INGENIC
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on CMA
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on OF
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on COMMON_CLK
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select REGMAP
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select REGMAP_MMIO

nit: order alphabetically (move them after the DRM_* ones).

Cheers,
-Paul

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select DRM_BRIDGE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select DRM_PANEL_BRIDGE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select DRM_KMS_HELPER

