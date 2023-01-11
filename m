Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB40166518A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjAKCMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjAKCMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:12:01 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C6C64C7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:11:59 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s67so9561608pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0cwyEc6KQYmQnChy+BikWZp8lFg76+cm/UHIItp73H0=;
        b=Fdbdt5jP7KyPgvW4FZTiLdDjkV4nJa2aeCGEKY/q4hT1iS67KiEisH/90DxltiO5xa
         pu+3Vssbv+0WrkUm3+zirN1u3RkcbNYulzgvsV7pmmE8+YFVfIVQxWcRXGJln/cgHa+M
         UTeWx7l735ZmdRMksrya1PjnX6fa05mtxEow47JN35hBMlnQDV+YWlU2QBkvtugl+Irj
         NXvR8xjzaogFA2iJceuoyOYQL3T6EQBPGhsYlLZMcQVIM+SxOiFKVpqMIhN1iljOpD+V
         kVGrZMEZOERXAxHI+GNpkEe4MQEt7LMTH383fd6hX8yKQ4+Zse6cQG6szVct++bp8rV9
         fAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cwyEc6KQYmQnChy+BikWZp8lFg76+cm/UHIItp73H0=;
        b=BbQyEtN9PMP6drho7yNL3Te/w3FiOnmJrB1BFukYiVPCy6eeQgNZlTs2W5hsDe+mu4
         FftwRXbG+wTlFeRteOhXGXqxOQn4hIigrgGWMVbeJb4/tB3iSffYhBsADaXf1n1PWafK
         +QYF0NluIPZ84h1sCq2EKM1QkCfEXD5KAkTY5To3VOJH5VQt3ESFWswVCA0v03nWst0P
         DXOu78O8mXsxh0yed8SVB5SK0jdQ3FgOrr3YOXEL9O99x79EaWiIpU5fThb4UdqHTd8a
         aILLNpDs9NakWBFU2We6jjwcnJYrU53+b0hHn4Ae8ydsDWfjkITfNPCpI//mbLiGFv3S
         Azdg==
X-Gm-Message-State: AFqh2koaDZtYQag9RauszTwcHpaeRD2qYqaf2g1kWzcnI50mhgdi7wyv
        4oqKP/corUtmHa4R13PRwFeKFstaCRn9M959
X-Google-Smtp-Source: AMrXdXuY4iQkwYRiuSdnjut0GKerpiZ1VUcDECyng7hoJCpwhLI2o5D089+OJU4YAqqI8hhBz9dVCg==
X-Received: by 2002:a05:6a00:368a:b0:581:bfac:7a52 with SMTP id dw10-20020a056a00368a00b00581bfac7a52mr169277pfb.1.1673403118438;
        Tue, 10 Jan 2023 18:11:58 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6a48:569f:20c1:dc8])
        by smtp.gmail.com with ESMTPSA id r5-20020aa79ec5000000b00589605fb0a1sm4145795pfq.96.2023.01.10.18.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 18:11:56 -0800 (PST)
Date:   Tue, 10 Jan 2023 18:11:51 -0800
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, stable@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>
Subject: Re: [PATCH 1/3] usb: typec: altmodes/displayport: Add pin assignment
 helper
Message-ID: <Y74a53YFeYECjvH4@google.com>
References: <20230111020546.3384569-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i4a3Me6WxQZxPfMJ"
Content-Disposition: inline
In-Reply-To: <20230111020546.3384569-1-pmalani@chromium.org>
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


--i4a3Me6WxQZxPfMJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2023 at 02:05:41AM +0000, Prashant Malani wrote:
> The code to extract a peripheral's currently supported Pin Assignments
> is repeated in a couple of locations. Factor it out into a separate
> function.
>=20
> This will also make it easier to add fixes (we only need to update 1
> location instead of 2).
>=20
> Fixes: c1e5c2f0cb8a ("usb: typec: altmodes/displayport: correct pin assig=
nment for UFP receptacles")
> Cc: stable@vger.kernel.org
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>=20
> While this patch doesn't fix anything, it is required by the actual
> fix (which is Patch 2/3 in this series). So, I've add the "Fixes" tag
> and "Cc stable" tag to ensure that both patches are picked.
>=20
> If this is the incorrect approach and there is a better way, my
> apologies, and please let me know the appropriate process.
>=20
>  drivers/usb/typec/altmodes/displayport.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec=
/altmodes/displayport.c
> index 06fb4732f8cd..f9d4a7648bc9 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -420,6 +420,18 @@ static const char * const pin_assignments[] =3D {
>  	[DP_PIN_ASSIGN_F] =3D "F",
>  };
> =20
> +/*
> + * Helper function to extract a peripheral's currently supported
> + * Pin Assignments from its DisplayPort alternate mode state.
> + */
> +static u8 get_current_pin_assignments(struct dp_altmode *dp)
> +{
> +	if (DP_CONF_CURRENTLY(dp->data.conf) =3D=3D DP_CONF_DFP_D)
> +		return DP_CAP_UFP_D_PIN_ASSIGN(dp->alt->vdo);
> +	else
> +		return DP_CAP_DFP_D_PIN_ASSIGN(dp->alt->vdo);
> +}
> +
>  static ssize_t
>  pin_assignment_store(struct device *dev, struct device_attribute *attr,
>  		     const char *buf, size_t size)
> @@ -446,10 +458,7 @@ pin_assignment_store(struct device *dev, struct devi=
ce_attribute *attr,
>  		goto out_unlock;
>  	}
> =20
> -	if (DP_CONF_CURRENTLY(dp->data.conf) =3D=3D DP_CONF_DFP_D)
> -		assignments =3D DP_CAP_UFP_D_PIN_ASSIGN(dp->alt->vdo);
> -	else
> -		assignments =3D DP_CAP_DFP_D_PIN_ASSIGN(dp->alt->vdo);
> +	assignments =3D get_current_pin_assignments(dp);
> =20
>  	if (!(DP_CONF_GET_PIN_ASSIGN(conf) & assignments)) {
>  		ret =3D -EINVAL;
> @@ -486,10 +495,7 @@ static ssize_t pin_assignment_show(struct device *de=
v,
> =20
>  	cur =3D get_count_order(DP_CONF_GET_PIN_ASSIGN(dp->data.conf));
> =20
> -	if (DP_CONF_CURRENTLY(dp->data.conf) =3D=3D DP_CONF_DFP_D)
> -		assignments =3D DP_CAP_UFP_D_PIN_ASSIGN(dp->alt->vdo);
> -	else
> -		assignments =3D DP_CAP_DFP_D_PIN_ASSIGN(dp->alt->vdo);
> +	assignments =3D get_current_pin_assignments(dp);
> =20
>  	for (i =3D 0; assignments; assignments >>=3D 1, i++) {
>  		if (assignments & 1) {
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

--i4a3Me6WxQZxPfMJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCY74a5wAKCRBzbaomhzOw
wq6cAP4jo9IaJb1NAWY9AIAvx8SZWPbNPw0K6Dg+oEggzndGzQD+ODFeM45PMrtK
MQlrDSGenORZzmeqrJzQvANdlDmQNwg=
=r9k1
-----END PGP SIGNATURE-----

--i4a3Me6WxQZxPfMJ--
