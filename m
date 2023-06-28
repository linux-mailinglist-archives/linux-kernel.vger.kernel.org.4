Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA3B741BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 00:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjF1WvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 18:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjF1Wui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:50:38 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD829358D;
        Wed, 28 Jun 2023 15:46:56 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D175B905;
        Thu, 29 Jun 2023 00:46:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687992374;
        bh=O+6GdTlpoNHtF1G6mT01fUdQslr2Gm+LWPozhSbq2L8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QXxEIatFxiEy/dM2XSsAz44gRa1s92D8MurVhdym0yFSIEvoBvcwmPZWzcBTZqZu6
         r598qR+uDm+7tkrh1XXQGS6YA0mo1XWSlGWVZy6jsdKN/bp59ZrlAdV8Tbx6n1mRyJ
         nlFt8vBtiA4A4SvnvhJXQLSes4dWVjIVIEdvMBQY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230627201628.207483-6-umang.jain@ideasonboard.com>
References: <20230627201628.207483-1-umang.jain@ideasonboard.com> <20230627201628.207483-6-umang.jain@ideasonboard.com>
Subject: Re: [PATCH v8 5/5] staging: vc04_services: vchiq_arm: Remove vchiq_register_child()
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev
Date:   Wed, 28 Jun 2023 23:46:52 +0100
Message-ID: <168799241214.3298351.10936017214708371368@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Umang Jain (2023-06-27 21:16:28)
> vchiq_register_child() is used to registered child devices as platform

s/registered/register/

> devices. Now that the child devices are migrated to use the
> vchiq_bus_type instead, they will be registered to that. Hence, drop
> vchiq_register_child() as it is no more required.
>=20

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  .../interface/vchiq_arm/vchiq_arm.c           | 22 -------------------
>  1 file changed, 22 deletions(-)
>=20
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.=
c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 75da37fa6372..3c52b09c49ea 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -1778,28 +1778,6 @@ static const struct of_device_id vchiq_of_match[] =
=3D {
>  };
>  MODULE_DEVICE_TABLE(of, vchiq_of_match);
> =20
> -static struct platform_device *
> -vchiq_register_child(struct platform_device *pdev, const char *name)
> -{
> -       struct platform_device_info pdevinfo;
> -       struct platform_device *child;
> -
> -       memset(&pdevinfo, 0, sizeof(pdevinfo));
> -
> -       pdevinfo.parent =3D &pdev->dev;
> -       pdevinfo.name =3D name;
> -       pdevinfo.id =3D PLATFORM_DEVID_NONE;
> -       pdevinfo.dma_mask =3D DMA_BIT_MASK(32);
> -
> -       child =3D platform_device_register_full(&pdevinfo);
> -       if (IS_ERR(child)) {
> -               dev_warn(&pdev->dev, "%s not registered\n", name);
> -               child =3D NULL;
> -       }
> -
> -       return child;
> -}
> -
>  static int vchiq_probe(struct platform_device *pdev)
>  {
>         struct device_node *fw_node;
> --=20
> 2.39.1
>
