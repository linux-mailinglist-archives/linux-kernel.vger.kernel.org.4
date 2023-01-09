Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA86D6630C6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbjAITvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjAITu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:50:56 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43839297
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:50:53 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y1so10721761plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdz957aQvPO0Tg60H2Q1aFW7vcHjqi61ssnYgWz6Z0Q=;
        b=pl1bRfRy3/KHxBZuPRThzBuGBciXtQSrozcMl4yti3ZmO2WPQgVJ1C9HK6CcKKNKUU
         TFn59uhmHyM9xlrCOsmi23v7ixpRT3t6Ve0BR+kvWYsX1e5BjxHMY5iiNd8M4wkWP4r3
         oLto6sZJUYo/iOdw3UNDa8PNmG5lmcWO8RgYqZAhyPM7GTNWwIIVPjfn08ETJEUQVDhQ
         ldgoeU+ZRpGOZJDKr7r3J3iLDpjM+1fDsJaCw1QUfZmSv3FDjJpKbuGKcDilCD647lrW
         aP7LvTqIuy9UQPdiEzN9TZjQvYLczxO8+EndsCbIR8tbhUwlIoNzS2Cc4aOp9iJSCIqw
         wiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdz957aQvPO0Tg60H2Q1aFW7vcHjqi61ssnYgWz6Z0Q=;
        b=J5UiPZEKRdOHO3imz8KzqJjY8r7BGgUTv7PXHqSwsHYFthHPpXZ8FXgLY8w0wsqyWs
         8wTyIzxSkzezV/1GUTKBzIA2M7cdXocObkbvm0A9necXRUmZWErJZdRMpJpzAn7QlqD3
         nQPjv1DFcQD2IOi2RGcAfGQzowAoiYEu5j9tNTL9OgIrcfbUpeh7eRSROM43XqM1JCUk
         YKp63+lciEy4h+0n9RNNemNz5/TARbN8MP0k2BLpum6Go4UIsLozmCamFWSHgBNb9bxN
         ZCA+z3tTD1bjJRKZmmr5o+7D8zKh1nDoB71OxwLtsFOh5n6N07UCBMy5ByKmD9Iq2E8F
         Zr3Q==
X-Gm-Message-State: AFqh2kpqmReB6FHiQNNo3gH7ilFGUCxJ3+/adLIyEXbLtj/YaXPTSsCk
        85lbkFNslcIjAU1rAF6srpZJEQ==
X-Google-Smtp-Source: AMrXdXvvy1XbitwaOE4mJ7lyHskyDtAsvqFBABVpjz65DqG41oyZ4uu27CTMByrLE6A3k65emhOebw==
X-Received: by 2002:a05:6a20:9f03:b0:a4:efde:2ed8 with SMTP id mk3-20020a056a209f0300b000a4efde2ed8mr767013pzb.0.1673293852356;
        Mon, 09 Jan 2023 11:50:52 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:3529:30e5:d581:6e80])
        by smtp.gmail.com with ESMTPSA id z7-20020a63e547000000b00476d1385265sm5461868pgj.25.2023.01.09.11.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:50:51 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:50:44 -0800
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
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH 09/10] platform/chrome: cros_typec_vdm: Add VDM reply
 support
Message-ID: <Y7xwFHn9EpzdZiPh@google.com>
References: <20221228004648.793339-1-pmalani@chromium.org>
 <20221228004648.793339-10-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yOgnd2EkjUG+qCkf"
Content-Disposition: inline
In-Reply-To: <20221228004648.793339-10-pmalani@chromium.org>
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


--yOgnd2EkjUG+qCkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2022 at 12:45:12AM +0000, Prashant Malani wrote:
> Handle response VDMs which are sent by the partner (replying to VDMs
> sent by the host system itself). These get forwarded to the altmode
> driver.
>=20
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_typec.c  |  7 +++++
>  drivers/platform/chrome/cros_typec_vdm.c | 39 ++++++++++++++++++++++++
>  drivers/platform/chrome/cros_typec_vdm.h |  2 ++
>  3 files changed, 48 insertions(+)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> index 1e28d56b094d..e02107a6870a 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -1000,6 +1000,13 @@ static void cros_typec_handle_status(struct cros_t=
ypec_data *typec, int port_num
>  					 "Failed SOP Disc event clear, port: %d\n", port_num);
>  		}
>  	}
> +
> +	if (resp.events & PD_STATUS_EVENT_VDM_REQ_REPLY) {
> +		cros_typec_handle_vdm_response(typec, port_num);
> +		ret =3D cros_typec_send_clear_event(typec, port_num, PD_STATUS_EVENT_V=
DM_REQ_REPLY);
> +		if (ret < 0)
> +			dev_warn(typec->dev, "Failed VDM Reply event clear, port: %d\n", port=
_num);
> +	}
>  }
> =20
>  static int cros_typec_port_update(struct cros_typec_data *typec, int por=
t_num)
> diff --git a/drivers/platform/chrome/cros_typec_vdm.c b/drivers/platform/=
chrome/cros_typec_vdm.c
> index df0102ca3a18..fc7b602ceb37 100644
> --- a/drivers/platform/chrome/cros_typec_vdm.c
> +++ b/drivers/platform/chrome/cros_typec_vdm.c
> @@ -13,6 +13,45 @@
>  #include "cros_ec_typec.h"
>  #include "cros_typec_vdm.h"
> =20
> +/*
> + * Retrieves a VDM response from the EC and forwards it to the altmode d=
river based on SVID.
> + */
> +void cros_typec_handle_vdm_response(struct cros_typec_data *typec, int p=
ort_num)
> +{
> +	struct ec_response_typec_vdm_response resp;
> +	struct ec_params_typec_vdm_response req =3D {
> +		.port =3D port_num,
> +	};
> +	struct typec_altmode *amode;
> +	u16 svid;
> +	u32 hdr;
> +	int ret;
> +
> +	ret =3D cros_ec_cmd(typec->ec, 0, EC_CMD_TYPEC_VDM_RESPONSE, &req,
> +			  sizeof(req), &resp, sizeof(resp));
> +	if (ret < 0) {
> +		dev_warn(typec->dev, "Failed VDM response fetch, port: %d\n", port_num=
);
> +		return;
> +	}
> +
> +	hdr =3D resp.vdm_response[0];
> +	svid =3D PD_VDO_VID(hdr);
> +	dev_dbg(typec->dev, "Received VDM header: %x, port: %d\n", hdr, port_nu=
m);
> +
> +	amode =3D typec_match_altmode(typec->ports[port_num]->port_altmode, CRO=
S_EC_ALTMODE_MAX,
> +				    svid, PD_VDO_OPOS(hdr));
> +	if (!amode) {
> +		dev_err(typec->dev, "Received VDM for unregistered altmode (SVID:%x), =
port: %d\n",
> +			svid, port_num);
> +		return;
> +	}
> +
> +	ret =3D typec_altmode_vdm(amode, hdr, &resp.vdm_response[1], resp.vdm_d=
ata_objects);
> +	if (ret)
> +		dev_err(typec->dev, "Failed to forward VDM to altmode (SVID:%x), port:=
 %d\n",
> +			svid, port_num);
> +}
> +
>  static int cros_typec_port_amode_enter(struct typec_altmode *amode, u32 =
*vdo)
>  {
>  	struct cros_typec_port *port =3D typec_altmode_get_drvdata(amode);
> diff --git a/drivers/platform/chrome/cros_typec_vdm.h b/drivers/platform/=
chrome/cros_typec_vdm.h
> index 7e282d168a98..003587525554 100644
> --- a/drivers/platform/chrome/cros_typec_vdm.h
> +++ b/drivers/platform/chrome/cros_typec_vdm.h
> @@ -7,4 +7,6 @@
> =20
>  extern struct typec_altmode_ops port_amode_ops;
> =20
> +void cros_typec_handle_vdm_response(struct cros_typec_data *typec, int p=
ort_num);
> +
>  #endif /*  __CROS_TYPEC_VDM__ */
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

--yOgnd2EkjUG+qCkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCY7xwFAAKCRBzbaomhzOw
wtRXAP0R7YQrQIMgbkFps9UuEx8LPSxIJiwT0XnhvsfJ8zSGrwEA14Du/Bvx/WGl
bu6M/XkFRU4Iu7vP5j1xqgWFoerJPAI=
=Cikg
-----END PGP SIGNATURE-----

--yOgnd2EkjUG+qCkf--
