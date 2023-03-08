Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A376AFB58
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCHAhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjCHAhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:37:25 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F91B0B9E;
        Tue,  7 Mar 2023 16:36:56 -0800 (PST)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3321A27C;
        Wed,  8 Mar 2023 01:36:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678235796;
        bh=/SiZ/SnUZaXl45SfRpnKybJKwHQE7m3GNk+YSHsQfvQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kS7QgudtNnSLQ7b9uMa5oT2EwmGy5QQPQtuM2EnJCXKvap5+e1BOSRzac8jGf0bD0
         +iXtbZRr9GOO70xDv34jwhfSyVCrhLb+dZo8gK7RIrV26Xuv/SHkahGpGyv928wB9Y
         MtVYgAlfjKwAMyUQXC7LTQxVidX+Gd7H3t0fM9yo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230307163041.3815-6-wsa+renesas@sang-engineering.com>
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com> <20230307163041.3815-6-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 05/11] media: renesas: fdp1: remove R-Car H3 ES1.* handling
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Date:   Wed, 08 Mar 2023 00:36:32 +0000
Message-ID: <167823579297.93391.2081091035435718250@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wolfram Sang (2023-03-07 16:30:33)
> R-Car H3 ES1.* was only available to an internal development group and
> needed a lot of quirks and workarounds. These become a maintenance
> burden now, so our development group decided to remove upstream support
> and disable booting for this SoC. Public users only have ES2 onwards.
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> ---
> Please apply individually per subsystem. There are no dependencies and th=
e SoC
> doesn't boot anymore since v6.3-rc1.
>=20
>  drivers/media/platform/renesas/rcar_fdp1.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/media/platform/renesas/rcar_fdp1.c b/drivers/media/p=
latform/renesas/rcar_fdp1.c
> index 37ecf489d112..f4a1fc8ce595 100644
> --- a/drivers/media/platform/renesas/rcar_fdp1.c
> +++ b/drivers/media/platform/renesas/rcar_fdp1.c
> @@ -254,7 +254,6 @@ MODULE_PARM_DESC(debug, "activate debug info");
> =20
>  /* Internal Data (HW Version) */
>  #define FD1_IP_INTDATA                 0x0800
> -#define FD1_IP_H3_ES1                  0x02010101
>  #define FD1_IP_M3W                     0x02010202
>  #define FD1_IP_H3                      0x02010203
>  #define FD1_IP_M3N                     0x02010204
> @@ -2359,9 +2358,6 @@ static int fdp1_probe(struct platform_device *pdev)
> =20
>         hw_version =3D fdp1_read(fdp1, FD1_IP_INTDATA);
>         switch (hw_version) {
> -       case FD1_IP_H3_ES1:
> -               dprintk(fdp1, "FDP1 Version R-Car H3 ES1\n");
> -               break;
>         case FD1_IP_M3W:
>                 dprintk(fdp1, "FDP1 Version R-Car M3-W\n");
>                 break;
> --=20
> 2.35.1
>
