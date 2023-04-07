Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CF36DAF93
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjDGPSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjDGPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:18:04 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C8F5253
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 08:18:02 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 04192E0007;
        Fri,  7 Apr 2023 15:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680880681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=su/J+YHOkVstEerJgZqlQlSEAis538QbzL9GrGRB2XE=;
        b=Fu506EZLqIBXb5kPblIFRQHeArdM0a4pX/EIqXteyGe51tix/tqx+Yr4RYtSGc9MJ9uC9f
        QO2Xjcg1K5eN50gInIe3lu0Y29uF2UcYfTKZ+GizsY0wlARETALqdV3OOkSYKcMxCNccuX
        nQAruSpGg5+shruQYxaCgUeRrAR5yt5Eyk3Hx2nOKmhIkhA+EaAX6+aNmNBlwdllJpmUww
        IRRJvS6EZDf+i6arQ8eRA4MHhlDTJQ14FCpykuMvlK1AJrcTCp8RD+Q4hYvev4ubtszKev
        IZhp+wDv3wsmfTnon4kL40/FSMGo7DRCAT3TdUYauCgo+eYo/UQ1AkYwmDizvg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH RESEND] firmware: turris-mox-rwtm: make kobj_type
 structure constant
In-Reply-To: <20230227-kobj_type-firmware-turris-v1-1-e48f65155ec5@weissschuh.net>
References: <20230227-kobj_type-firmware-turris-v1-1-e48f65155ec5@weissschuh.net>
Date:   Fri, 07 Apr 2023 17:18:00 +0200
Message-ID: <87sfdb3emv.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Wei=C3=9Fschuh <linux@weissschuh.net> writes:

> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
>
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
>

Applied on mvebu/arm64

Thanks,

Gregory
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  drivers/firmware/turris-mox-rwtm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris=
-mox-rwtm.c
> index 6ea5789a89e2..2de0fb139ce1 100644
> --- a/drivers/firmware/turris-mox-rwtm.c
> +++ b/drivers/firmware/turris-mox-rwtm.c
> @@ -104,7 +104,7 @@ static void mox_kobj_release(struct kobject *kobj)
>  	kfree(to_rwtm(kobj)->kobj);
>  }
>=20=20
> -static struct kobj_type mox_kobj_ktype =3D {
> +static const struct kobj_type mox_kobj_ktype =3D {
>  	.release	=3D mox_kobj_release,
>  	.sysfs_ops	=3D &kobj_sysfs_ops,
>  };
>
> ---
> base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
> change-id: 20230227-kobj_type-firmware-turris-6cd4a66bac19
>
> Best regards,
> --=20
> Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
