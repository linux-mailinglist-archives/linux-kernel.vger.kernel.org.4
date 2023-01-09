Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9376630BC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjAITsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbjAITrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:47:21 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B08E1AB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:45:55 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c9so6994548pfj.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=btvsUbB53Fx2/CaDCMvOO7/DXUDwDM/Zif+ZIWmMPhk=;
        b=ZdTUj/qEswZKNnh0B+GEasVjdRySBRZQ6uwTOnKXhdV7wNVgB/Hb532AUTLmg5k/IO
         d9FXX0t1+HjQHPpqqLaVy9g3hLBTnvNssEMxbOQJUBm67NoC8/ZK9R4Uxsjr8bhXW7eA
         PPxyA48AulXMSLwmAAtSABDueHxq0O5R35kd6d3ID649BTBqBhMfXj+679TsdbeKs+FL
         615wnOHyWxpAtA8Qht3zlR1P5UJPPItTNc4V6KBA5VdZWl7E2ppL4xt1ClyZLtW/xxgK
         WoB9LdnEWQG0l1nflfklXz/UQkspd3YMpAJA2sx+S6Y+Mkd2wrea+wJygIsJ0avGfCIK
         Mr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btvsUbB53Fx2/CaDCMvOO7/DXUDwDM/Zif+ZIWmMPhk=;
        b=PnlUaLuXpuc5uj9f7kZKUPEEE3gD1YBvZ3T2E7+N8Y4lBsCxIdkT5xcrfovi9WC3MI
         lZRsy6OPWR2bO0mtyOFRBBuViOeZCQu0w05FUCbonuzSLjQnBX78WiWrGbQp/PMCxO6j
         EmlnfzAsvVMgoeQu6llvmEHsQhesYs+Llq3YfrFFcD6pRPc0i9kb8pFq6wfv2u4ePH7A
         kiRntGJsZY5fRTkXudLq8jZRsLQhtT+CBJsEKk7zs4SoUinHxQJ42dN05UJjTUAIXbHW
         yJ6FbhOBUyWnhhnkZPv3MPvKYO9hNi+CHPBek6K5aYTxnujznfJgMiAhHaWaIWyYK9QS
         7jpw==
X-Gm-Message-State: AFqh2kq54Qf+pIuZeYFXSH4OOhshuVlqJmkJSZk6pI/6ne/mO1+BUWw/
        /Fgb3cRCKf9eweimWb6PMqCiVA==
X-Google-Smtp-Source: AMrXdXuBCw74dvZhfFbNwXx0UuAAwkVu8pA0Fu9D1NHHsnTXwYR5gBfMZbkCJe/u9xVfHI0RaUP8bQ==
X-Received: by 2002:aa7:973c:0:b0:574:8995:c0d0 with SMTP id k28-20020aa7973c000000b005748995c0d0mr747032pfg.1.1673293552015;
        Mon, 09 Jan 2023 11:45:52 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:3529:30e5:d581:6e80])
        by smtp.gmail.com with ESMTPSA id v126-20020a622f84000000b005775c52dbc4sm6357795pfv.167.2023.01.09.11.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:45:50 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:45:44 -0800
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
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH 05/10] platform/chrome: cros_ec_typec: Update port DP VDO
Message-ID: <Y7xu6OlfrurOHDkw@google.com>
References: <20221228004648.793339-1-pmalani@chromium.org>
 <20221228004648.793339-6-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="05WXZqm7LieS+vmi"
Content-Disposition: inline
In-Reply-To: <20221228004648.793339-6-pmalani@chromium.org>
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


--05WXZqm7LieS+vmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2022 at 12:45:08AM +0000, Prashant Malani wrote:
> The port advertising DP support is a Type-C receptacle. Fix the port's
> DisplayPort VDO to reflect this.
>=20
> Fixes: 1903adae0464 ("platform/chrome: cros_ec_typec: Add bit offset for =
DP VDO")
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> index 05dc5a63af53..665fa76e2416 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -27,7 +27,7 @@
>  #define DRV_NAME "cros-ec-typec"
> =20
>  #define DP_PORT_VDO	(DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_C) | BIT(D=
P_PIN_ASSIGN_D)) | \
> -				DP_CAP_DFP_D)
> +				DP_CAP_DFP_D | DP_CAP_RECEPTACLE)
> =20
>  /* Supported alt modes. */
>  enum {
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

--05WXZqm7LieS+vmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCY7xu6AAKCRBzbaomhzOw
whrmAQDM/48X/TaF0wFGfPfGcFm1P1Lcmz0XRaJ22AKTY9cZ8gEAvfdFzUay7awv
nKN6iYyBvlZWE35rg5Bxjk6dQT2diQU=
=7BPi
-----END PGP SIGNATURE-----

--05WXZqm7LieS+vmi--
