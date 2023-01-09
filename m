Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4036630B8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbjAIToB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbjAITnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:43:45 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806763631F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:43:44 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q9so6627612pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=veGfYnA4hNep9xLtDsZJq60VJSWFSJQTjdAFzULOh0A=;
        b=Hu6TXajbV1nysO6YT0nJGUJITPTEGteUGyF+kqHQ33uo9Inl83eIp1lLHuqQpxw1m7
         /YLSRyk0J/3FAXVmlqu1QWEhMw2acsrss0YQ/wk4Z5Kn0i1L8qEy3QzMmizE4dTTV0rJ
         2UqVggZd2Ez+ZbiuPbAV8UkryLdH6+7EOiVAeNy3dnN0hqWrXHn9hQuFgUGdP39GeSvP
         zlQvtvlXqFOxN/7DYRCH/UxT+FVLk74DQGr4ID7A7Mg7HCCIF67izwZn/6HrFPgx+MoG
         8W4uSdMNZ34ickwCDsPm1otgghgLnjjzXCZDzY2Moy3nKoeggtANwCGKr2vi2Eblzz0f
         Hr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veGfYnA4hNep9xLtDsZJq60VJSWFSJQTjdAFzULOh0A=;
        b=xSAExTCvSNZ+GQTDbD1HJu5SB8wrSCw4fEzXnYSG6JcUvWMWjspxvZb9BaCkK94bzY
         2WMPUMXPfWVJ9nzdT60XBhLWn1Qx+RvDM9DfzMTWyaE3B+2zKpwZtlOUONlqbLxyP+cX
         MqfY7Fq3XVQksXqIuUWf64kXCcuXd8gmsR/Cy52BKiXhmEnwcG6GcjUorCrwgNIGUj5e
         TpyRa3oC3P0VtXth9tJUayEHSYgP0PUBf+bl7Y3k1tnveYBH2hrTjIEymfbCH8iEFmHh
         U1rtp5aRSVAFglxIhj48PpYZ/peu8uJ60aJDvzHPgCmwXSCe9izrZqDTZf+WlGDGdc9r
         zbnw==
X-Gm-Message-State: AFqh2kqdusP/CNfRUlgmu8Fjnqx7tE2siRWIth5seXfTXgzu5Mq8nuVv
        WQcgC6a4cCQbZE3HqIPLxLTlSg==
X-Google-Smtp-Source: AMrXdXso816BpR1KCWzqOEYHfJ2/5KNvt9As0jegoVBLu2b2t6H0lav9N3d0OR41eo4tjS0JoPMDxw==
X-Received: by 2002:aa7:9249:0:b0:576:9252:d06 with SMTP id 9-20020aa79249000000b0057692520d06mr794227pfp.0.1673293423602;
        Mon, 09 Jan 2023 11:43:43 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:3529:30e5:d581:6e80])
        by smtp.gmail.com with ESMTPSA id 4-20020a620404000000b00576ee69c130sm6399350pfe.4.2023.01.09.11.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:43:42 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:43:35 -0800
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
Subject: Re: [PATCH 04/10] platform/chrome: cros_ec_typec: Set port alt mode
 drvdata
Message-ID: <Y7xuZ4jvd0Cl4jKp@google.com>
References: <20221228004648.793339-1-pmalani@chromium.org>
 <20221228004648.793339-5-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mGVjA2t/wX4O1RTo"
Content-Disposition: inline
In-Reply-To: <20221228004648.793339-5-pmalani@chromium.org>
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


--mGVjA2t/wX4O1RTo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2022 at 12:45:07AM +0000, Prashant Malani wrote:
> Save the ChromeOS-specific Type-C port info in the port altmodes' driver
> data. This makes communication with the ChromeOS EC (Embedded
> Controller) easier when alt mode drivers need to send messages to
> peripherals.
>=20
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> index bc8dc8bd90b3..05dc5a63af53 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -345,6 +345,7 @@ static int cros_typec_register_port_altmodes(struct c=
ros_typec_data *typec,
>  	if (IS_ERR(amode))
>  		return PTR_ERR(amode);
>  	port->port_altmode[CROS_EC_ALTMODE_DP] =3D amode;
> +	typec_altmode_set_drvdata(amode, port);
> =20
>  	/*
>  	 * Register TBT compatibility alt mode. The EC will not enter the mode
> @@ -358,6 +359,7 @@ static int cros_typec_register_port_altmodes(struct c=
ros_typec_data *typec,
>  	if (IS_ERR(amode))
>  		return PTR_ERR(amode);
>  	port->port_altmode[CROS_EC_ALTMODE_TBT] =3D amode;
> +	typec_altmode_set_drvdata(amode, port);
> =20
>  	port->state.alt =3D NULL;
>  	port->state.mode =3D TYPEC_STATE_USB;
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

--mGVjA2t/wX4O1RTo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCY7xuZwAKCRBzbaomhzOw
wqnoAQDvv6RZ17rwqoZKO2HlhrcKp+esySgdPBXYMaj4biFnwQD9ERLrj73j0Wft
9yVnrbKWiw6BOhyXJV7Yo6VMuspVSAI=
=/RI6
-----END PGP SIGNATURE-----

--mGVjA2t/wX4O1RTo--
