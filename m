Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E616BD3E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjCPPfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjCPPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:34:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3FDE4C44
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FE7561F50
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53ADC433EF;
        Thu, 16 Mar 2023 15:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678980610;
        bh=lXcJ+88HJuvziws9vFMM5B5PQZ+eEgSu327yopL8Yrc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gX0jfpi7p5wDjxbRj9kY+zZY465Nxac0KLgQ7a677u8+OSPp5OjvBt2iNYm3Fhr3U
         Ef/wkjqQ/APKxtbmIgFG9f8YG8sNDEVKjdeVKyIco0QjZmRqOi/swREj6lfzX7y0pM
         S0yVifV/4aGzaILUQYrD+nSPNDF3AqpOOKsH8e2OYx5dPUn7TLarfue4SI6dY17jYY
         uR1VRrWteOIFJyHXGGke4w+XaJ2pmD6Aafx+zw7EVQ/zUU1vhDkYJ/e/itV6snPijS
         Gn3/1tRJLnRbsGr6vvDNs93yLT0+WpNgz6LfaUr6ARGo/Pdi06eQS68uhBJSvpejSw
         bL0HmY9+tA0sg==
Date:   Thu, 16 Mar 2023 16:30:06 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: turris-mox-rwtm: make kobj_type structure
 constant
Message-ID: <20230316163006.7f04b400@dellmb>
In-Reply-To: <20230227-kobj_type-firmware-turris-v1-1-e97f79827db1@weissschuh.net>
References: <20230227-kobj_type-firmware-turris-v1-1-e97f79827db1@weissschuh.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 03:18:50 +0000
Thomas Wei=C3=9Fschuh <linux@weissschuh.net> wrote:

> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
>=20
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  drivers/firmware/turris-mox-rwtm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris=
-mox-rwtm.c
> index 6ea5789a89e2..2de0fb139ce1 100644
> --- a/drivers/firmware/turris-mox-rwtm.c
> +++ b/drivers/firmware/turris-mox-rwtm.c
> @@ -104,7 +104,7 @@ static void mox_kobj_release(struct kobject *kobj)
>  	kfree(to_rwtm(kobj)->kobj);
>  }
> =20
> -static struct kobj_type mox_kobj_ktype =3D {
> +static const struct kobj_type mox_kobj_ktype =3D {
>  	.release	=3D mox_kobj_release,
>  	.sysfs_ops	=3D &kobj_sysfs_ops,
>  };
>=20
> ---
> base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
> change-id: 20230227-kobj_type-firmware-turris-6cd4a66bac19
>=20
> Best regards,

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
