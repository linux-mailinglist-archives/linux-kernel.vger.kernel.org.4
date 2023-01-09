Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA6766309E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbjAITmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237632AbjAITmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:42:19 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A178A3C3BD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:42:16 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jn22so10648006plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ydmzchxyNR+IqB33c0jWFlmVpBQ7+XVQgnYYMSL8I6g=;
        b=jJpQzHlTSQsFi3n9cFfzVW1NWhX8e/c/p0uH6A3AOU7JnJmK3r4pNZZOp5JlymTU+t
         zaANHLXB2rmILVpmAhvASLkFD6lG9tbgZUrj+zWui1JpisYdQPaYdpevHtXqR/QRbaZY
         KroO310n78o9aeKhYcIuJsXPyFlsJN7fevtxrC0XfFKIdaKOlvjj6tqYPRTWxboWlyki
         5X+az/nXmpddA6BbV3sN8sqAPA5oGd3njpycrXCbAcy4l8VDZbhD2NN+SQcMS1nPFmMd
         mYlp/9723BeNtFpHdDo2wKq+djxxfzclG5StDBEfaoBJYkYtgeuHMCRg8wpFYgm1jfAe
         r+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydmzchxyNR+IqB33c0jWFlmVpBQ7+XVQgnYYMSL8I6g=;
        b=bpoUDR3HxP9oFjorCMGU8LVuyjj+8+k00bO8oWHc5qus6yejMtyuysB3qjKSY5y6OR
         UUZuaXIphNm+8hqKdCId+f3TaWA78PhGyktfzpjFg2bRrGaX+J7UL9fxfaYLqKXWrnxG
         5IabuJmN3x4nzmrb8fRLJjLGV7ISWAdu98tNYVwMNumOPr+s8mtOVIqz3nT2DbmF1MD4
         3bqCX/vC8TKjgg9z4t+u4Asf27dsw+9yde6Ny/ltV2q/Y1hQwlNs9JAVFQ8/hbSgqRRz
         xm2IXjYXVPvV//7qf0iMsbm4s3xsC6jUv9zzweubpwaMit/Mwa+UU1b2uqGK1gg9/ixw
         W5FQ==
X-Gm-Message-State: AFqh2ko2LB24RXPk1YZzpHPA1Xd18MrZCRfVKVWbK441ndktnahryNh2
        i5nyYKL7TZXh4pxaT0oMjiXHFA==
X-Google-Smtp-Source: AMrXdXuAYx5/bXE9mxYxFY1+P8b3f3U7d1zPlfl9lusfmfAMG0NCDq+Ap03P0QfGw+CnF3IV3rY+0A==
X-Received: by 2002:a17:902:9346:b0:192:8a1e:9bc7 with SMTP id g6-20020a170902934600b001928a1e9bc7mr678043plp.0.1673293335845;
        Mon, 09 Jan 2023 11:42:15 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:3529:30e5:d581:6e80])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b00189d4c666c8sm6506350plg.153.2023.01.09.11.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:42:14 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:42:08 -0800
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
        Lee Jones <lee.jones@linaro.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH 03/10] platform/chrome: cros_ec_typec: Stash port driver
 info
Message-ID: <Y7xuEDPwbMQ29mDE@google.com>
References: <20221228004648.793339-1-pmalani@chromium.org>
 <20221228004648.793339-4-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NN1+a3FMy7XRMBpl"
Content-Disposition: inline
In-Reply-To: <20221228004648.793339-4-pmalani@chromium.org>
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


--NN1+a3FMy7XRMBpl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2022 at 12:45:06AM +0000, Prashant Malani wrote:
> Stash port number and a pointer to the driver-specific struct in the
> local typec port struct.
>=20
> These can be useful to the port driver to figure out how to communicate
> with the Chrome EC when an altmode-driver related callback is invoked
> from the Type-C class code.
>=20
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> index 001b0de95a46..bc8dc8bd90b3 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -45,6 +45,7 @@ struct cros_typec_altmode_node {
>  /* Per port data. */
>  struct cros_typec_port {
>  	struct typec_port *port;
> +	int port_num;
>  	/* Initial capabilities for the port. */
>  	struct typec_capability caps;
>  	struct typec_partner *partner;
> @@ -78,6 +79,8 @@ struct cros_typec_port {
>  	struct usb_power_delivery *partner_pd;
>  	struct usb_power_delivery_capabilities *partner_src_caps;
>  	struct usb_power_delivery_capabilities *partner_sink_caps;
> +
> +	struct cros_typec_data *typec_data;
>  };
> =20
>  /* Platform-specific data for the Chrome OS EC Type C controller. */
> @@ -408,6 +411,8 @@ static int cros_typec_init_ports(struct cros_typec_da=
ta *typec)
>  			goto unregister_ports;
>  		}
> =20
> +		cros_port->port_num =3D port_num;
> +		cros_port->typec_data =3D typec;
>  		typec->ports[port_num] =3D cros_port;
>  		cap =3D &cros_port->caps;
> =20
> --=20
> 2.39.0.314.g84b9a713c41-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--NN1+a3FMy7XRMBpl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCY7xuEAAKCRBzbaomhzOw
wj+iAQDtMZ3B1KQCAs2iQXnCSW345geepG6lz0sfCgM1KnGP5AEAq6NhnPEoJHYG
duYb+Hur+DFRDISsE4dXY7k4gg0V/wQ=
=OrDg
-----END PGP SIGNATURE-----

--NN1+a3FMy7XRMBpl--
