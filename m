Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F30663092
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjAITjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjAITjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:39:52 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9E97289B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:39:52 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id w3so10680764ply.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aJ4JfCzqm6YYlndMbkGrmhDzhoFbeiRvc2+0c/UTEBY=;
        b=GfJQo4XYnjXMnJiUJVeuwai4J8n3rE0213VwIKTil6Ce69dza7NyAPfZUHXJiwMEEn
         /HSIb91fOrldGXUWSvMxDpiPvQBhOdfJ5kmoWySVuTybYhs8TS2k+WeV2STRB8Q4nQwM
         xg5X8JuMb1081IfyAtLBUc1/diSSSzrO7EY7Wz/MMhewoNJMMZyvMyClyNZtOkZ1dpwX
         +a5resVJKmPu0/eviBDfkTwxUPrdo2yFlSrUKgxFHevSqw9da9j4ht+waufLDwbKVOZo
         1mJwFtxSphobpBWegKIL2bS+kfUVt7m4uF+/pYkJz8OPzwMamYKsfpcvEFcGi84DTZZ/
         DEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJ4JfCzqm6YYlndMbkGrmhDzhoFbeiRvc2+0c/UTEBY=;
        b=OyIDZkYGTnZe0K/5+RiwY6ZM9StFHgQXEqTsvO8GUpZwEm3c5c6YZm08QUSe58mNIs
         pIB1e2p+n2HHokt4w3z7+BcXEPg3L14uge2gJpWgvIWoSoHQEvyhGcQnSM+Wnx76EkKn
         eQHqNJuZR1aYCCh1szwob+o39qwpZkdESSFjNtZetDbXzyHe27suL7Nv6T2T9C/wQX9d
         IoELz1Tz6s1piTg6rtXW/JmfwitGCN+7dz5wObwAMYJZ6sIGwzqiMPf8d4WzqBXPvmm1
         u2IKltgO7kshFJBx20D80h/jp58Kp+iU+jA8SEpwqn5kCDM6i4LOVjR1lWJVp3Fkh1rD
         Ia7Q==
X-Gm-Message-State: AFqh2krir+yq/77PhHeCuvYXbT0VFza4/iouXYTM2N1RrnUQuDNoA2m9
        JyGGIc9EGLDDoKuxWlEOJEerBA==
X-Google-Smtp-Source: AMrXdXtCP4WxAZ/xFgvRZtu8jNSu0jpRtpggaFyFh53jai1TpVtfkQOcYc8I0ZcjMa/2AxO1fZxAfw==
X-Received: by 2002:a17:902:9346:b0:192:8a1e:9bc7 with SMTP id g6-20020a170902934600b001928a1e9bc7mr677175plp.0.1673293191406;
        Mon, 09 Jan 2023 11:39:51 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:3529:30e5:d581:6e80])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902d50200b00192a96f4916sm6406049plg.259.2023.01.09.11.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:39:50 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:39:43 -0800
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        heikki.krogerus@linux.intel.com,
        Benson Leung <bleung@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Evan Green <evgreen@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, Lee Jones <lee@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH 10/10] platform/chrome: cros_typec_vdm: Add VDM send
 support
Message-ID: <Y7xtf4BEd3On42FJ@google.com>
References: <20221228004648.793339-1-pmalani@chromium.org>
 <20221228004648.793339-11-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ave0XMEPWD+hATqC"
Content-Disposition: inline
In-Reply-To: <20221228004648.793339-11-pmalani@chromium.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ave0XMEPWD+hATqC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2022 at 12:45:13AM +0000, Prashant Malani wrote:
> Add support to send generic VDM messages from the alt mode driver to the
> partner (via the ChromeOS EC). The function introduced here is intended
> to be called by the alt mode driver (via the Type-C bus logic).
>=20
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/platform/chrome/cros_typec_vdm.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/platform/chrome/cros_typec_vdm.c b/drivers/platform/=
chrome/cros_typec_vdm.c
> index fc7b602ceb37..aca9d337118e 100644
> --- a/drivers/platform/chrome/cros_typec_vdm.c
> +++ b/drivers/platform/chrome/cros_typec_vdm.c
> @@ -77,6 +77,30 @@ static int cros_typec_port_amode_enter(struct typec_al=
tmode *amode, u32 *vdo)
>  			   sizeof(req), NULL, 0);
>  }
> =20
> +static int cros_typec_port_amode_vdm(struct typec_altmode *amode, const =
u32 hdr,
> +				     const u32 *vdo, int cnt)
> +{
> +	struct cros_typec_port *port =3D typec_altmode_get_drvdata(amode);
> +	struct ec_params_typec_control req =3D {
> +		.port =3D port->port_num,
> +		.command =3D TYPEC_CONTROL_COMMAND_SEND_VDM_REQ,
> +	};
> +	struct typec_vdm_req vdm_req =3D {};
> +
> +	vdm_req.vdm_data[0] =3D hdr;
> +	vdm_req.vdm_data_objects =3D cnt;
> +	memcpy(&vdm_req.vdm_data[1], vdo, cnt - 1);
> +	vdm_req.partner_type =3D TYPEC_PARTNER_SOP;
> +	req.vdm_req_params =3D vdm_req;
> +
> +	dev_dbg(port->typec_data->dev, "Sending VDM, hdr: %x, num_objects: %d, =
port: %d\n",
> +		hdr, cnt, port->port_num);
> +
> +	return cros_ec_cmd(port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
> +			   sizeof(req), NULL, 0);
> +}
> +
>  struct typec_altmode_ops port_amode_ops =3D {
>  	.enter =3D cros_typec_port_amode_enter,
> +	.vdm =3D cros_typec_port_amode_vdm,
>  };
> --=20
> 2.39.0.314.g84b9a713c41-goog
>=20
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--ave0XMEPWD+hATqC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCY7xtfwAKCRBzbaomhzOw
wgK7AQDJDYDwhW2Nb640pvBtKbu4HD8oBF2zIL+PEs6ybEUBAAD/Ut8HlwZnHQw/
Z3fB9mZO4uji9sD+BUD+TFcZxc477ws=
=TD7C
-----END PGP SIGNATURE-----

--ave0XMEPWD+hATqC--
