Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA85269F532
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjBVNWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjBVNWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:22:33 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F943A0AE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:22:31 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l1so7430810wry.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmed1jeBZ5AybmMhwZvMFWvP/a/HwCGONjFVZMu41zE=;
        b=i5RWhuySJGsDW5u4u/jrDVUZbkEsJFfC/M/mC//9GjfsjkJazoQiySRTK8sLCGlnmQ
         GYS0VFwgu/bPirBC2MZO3iOheg8F7v8SxcGRb/Azwe/UoGJTFJgWWCJOUwcabhVzkeMp
         FkCTCDJa8OM6OytqCZ9ErNJBvy9+xUehTvDutBxTxyitHO27FNViVgPGWXdL9HbjRc+9
         fn8vPWtxMqwG6Ekkg2Z1ht1QOWmlnsBkKixH3jfwXjD/Xe0mqaiaIcx2rdEC9AUi2YmF
         qcRbgwy/eWtrV60KsN6aOW21Lmk1kCp6MJBmpzsZuXwAKpXJ1CKc7IMUP9iPrjIf8jcW
         9P6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tmed1jeBZ5AybmMhwZvMFWvP/a/HwCGONjFVZMu41zE=;
        b=dFzaWVKUo9hWBuxiMPF8JKIP6HhUCnfc8vaiAUmlYU1UCYJFaBiu5qZewwQkosFBiH
         NrsODq9uaQ5d4AaSIBm5TeQi0/daC2V0BlpyHBPCyUz1QgCBb6T3gKqUCiyVd2QkBNgJ
         DUpg0HHIVRHfvXSow6wiX+67gIh/0ODGx/oJRGX+ygKS6/sMg/6zclTh+HlN3rOzPxD+
         RAlTbDj71E9itQ+B/nBW5mIEEdf5n8LSmRCwbE7CII3fRX4BMntfE+Hg7x+zbmRcj48q
         pXlAaT9CbitsvI72I93kq4pjVyz7jcB6Oj+rp89xvnMkL5+V+Sx7o634rss7Wk3HgdgH
         g+Ag==
X-Gm-Message-State: AO0yUKWlfO3W7HnD4p+mXsHtKVUId/K8JsYunp9zMRYt0m6vXxdTL/bh
        jTEz+s+SDdT2st+0zPk5gaP9Rg==
X-Google-Smtp-Source: AK7set83YHXEvsgL8aoSr/C3Ep9V9AvsQelC+QFyKa2M2Ln+SyAy7ut2BmyU7lCTP81l1gJfdgTM/g==
X-Received: by 2002:a5d:6b81:0:b0:2c5:4ea7:a8e2 with SMTP id n1-20020a5d6b81000000b002c54ea7a8e2mr6563930wrx.33.1677072150228;
        Wed, 22 Feb 2023 05:22:30 -0800 (PST)
Received: from localhost ([2a01:cb19:85e6:1900:2bf7:7388:731d:c4e1])
        by smtp.gmail.com with ESMTPSA id u3-20020adff883000000b002c703d59fa7sm5031553wrp.12.2023.02.22.05.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 05:22:29 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Werner Sembach <wse@tuxedocomputers.com>,
        dmitry.torokhov@gmail.com, hdegoede@redhat.com,
        wse@tuxedocomputers.com, chenhuacai@kernel.org, tiwai@suse.de,
        wsa+renesas@sang-engineering.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix strange behavior of touchpad on Clevo NS70PU
In-Reply-To: <20230220183014.238432-1-wse@tuxedocomputers.com>
References: <20230220183014.238432-1-wse@tuxedocomputers.com>
Date:   Wed, 22 Feb 2023 14:22:29 +0100
Message-ID: <878rgp4yy2.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On lun., f=C3=A9vr. 20, 2023 at 19:30, Werner Sembach <wse@tuxedocomputers.=
com> wrote:

> When closing the laptop lid with an external screen connected, the mouse
> pointer has a constant movement to the lower right corner. Opening the
> lid again stops this movement, but after that the touchpad does no longer
> register clicks.
>
> The touchpad is connected both via i2c-hid and PS/2, the predecessor of
> this device (NS70MU) has the same layout in this regard and also strange
> behaviour caused by the psmouse and the i2c-hid driver fighting over
> touchpad control. This fix is reusing the same workaround by just
> disabling the PS/2 aux port, that is only used by the touchpad, to give t=
he
> i2c-hid driver the lone control over the touchpad.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/serio/i8042-acpipnpio.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/=
i8042-acpipnpio.h
> index efc61736099b9..3a6640a11dd99 100644
> --- a/drivers/input/serio/i8042-acpipnpio.h
> +++ b/drivers/input/serio/i8042-acpipnpio.h
> @@ -1156,6 +1156,12 @@ static const struct dmi_system_id i8042_dmi_quirk_=
table[] __initconst =3D {
>  					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
>  					SERIO_QUIRK_NOPNP)
>  	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_NAME, "NS5x_7xPU"),
> +		},
> +		.driver_data =3D (void *)(SERIO_QUIRK_NOAUX)
> +	},
>  	{
>  		.matches =3D {
>  			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> --=20
> 2.34.1
