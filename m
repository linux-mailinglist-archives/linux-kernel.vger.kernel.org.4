Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7382B665194
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjAKCNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjAKCNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:13:22 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6607F6544
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:13:21 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id jl4so15224431plb.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b3v/mjJghvz+nesPcSFgua0EIfANDlTaoBpVT/LmX68=;
        b=a/bd5+wBaxhAEoy70YSi7YZ7BQBdgPullvyp/DoVmVkCa7uz1Qz0VIqF+kluHX8vBJ
         bu2otuyw+KOAUgIUo9oXDn5GEEbHu65ZVsiyrtBKAZN7SbnD3CI9UDav+5BXlYGOJ7A9
         VOHoBb+B9qak26SYLbUu13RxKrkmSaJgyALnq5RbZ41UW3DjZaFAtKwvm3CHDwIywD+O
         +HaQZUIYo2neOWYbmDvJCsPsoG8SXrmWD1459qupgzBe5+3HXtUsa6Y4wo95rzjlepEP
         U3nQVIBgqvCro+s8I3A+MbRUbuomMN9gw1g28hrLghlJPN8CihWl7b8MBuy+bupbWm2A
         fH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3v/mjJghvz+nesPcSFgua0EIfANDlTaoBpVT/LmX68=;
        b=uzZiOMBNZ6bvVO1UC/tGklvVkCXIuxj9uGM9r32Tr01pSbng8DH2E/vMKp4Bvz+qFt
         /3U9lfn+B/D4Zy0lPf2jxnYf3McAsjlyelP2RvZBNQzmSdz3TdoLQMs9ATxI1eQ+AwSY
         Abrt9WK3fuV98Fjz2kGesfGqpsONynU/oASyBLnHuB7+R6nen7/XWs93T1g8MKVyvv5f
         bxFKZI3SjT/zCmaYXDu8fxftGw/J05oWbPo22v5PvG7ylGeumBTd9Be4QBl/e+5KJc/L
         q87DbK/Pzd9J12n9Fiae5+r3QDHaWJtXC4r4yJlxkdjjVJEXVIWJghM4iFIau0gF/F9g
         OKHw==
X-Gm-Message-State: AFqh2kqykozH+ShDpd9yfnowQ2AwgiPInUeDqjfqAZvQTBhwgb/RwAsY
        GfzkiEtZOSsQ9aU0PIytio5TxQ==
X-Google-Smtp-Source: AMrXdXtbYELwuDFtlM/Ll5KFvcS79aCWDZW84NYVf6rXDf0/DjYIeSXCYyeB9TLRNQSVuAHeKzj+6A==
X-Received: by 2002:a05:6a20:4284:b0:9d:b8e6:d8e5 with SMTP id o4-20020a056a20428400b0009db8e6d8e5mr359588pzj.2.1673403200529;
        Tue, 10 Jan 2023 18:13:20 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6a48:569f:20c1:dc8])
        by smtp.gmail.com with ESMTPSA id u11-20020a6540cb000000b0046ff3634a78sm7387774pgp.71.2023.01.10.18.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 18:13:19 -0800 (PST)
Date:   Tue, 10 Jan 2023 18:13:14 -0800
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>
Subject: Re: [PATCH 3/3] usb: typec: altmodes/displayport: Use proper macro
 for pin assignment check
Message-ID: <Y74bOlZC7VezQPl/@google.com>
References: <20230111020546.3384569-1-pmalani@chromium.org>
 <20230111020546.3384569-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fVYJqbuNhrzGG0D"
Content-Disposition: inline
In-Reply-To: <20230111020546.3384569-3-pmalani@chromium.org>
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


--2fVYJqbuNhrzGG0D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2023 at 02:05:43AM +0000, Prashant Malani wrote:
> While looking at the DP configuration VDO to determine the peripheral
> configuration, the spec (Table 8-5: DisplayPort Configurations, VESA
> DisplayPort Alt Mode Standard v2.0) lists the options as "UFP_U as a DP
> Source/Sink Device".
>=20
> So, use the correct macro while performing this check. Effectively it's
> the same as the existing code, but the proposed macro describes the
> state a little better.
>=20
> No functional changes introduced.
>=20
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/usb/typec/altmodes/displayport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec=
/altmodes/displayport.c
> index c0d65c93cefe..746bfbf3d557 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -426,7 +426,7 @@ static const char * const pin_assignments[] =3D {
>   */
>  static u8 get_current_pin_assignments(struct dp_altmode *dp)
>  {
> -	if (DP_CONF_CURRENTLY(dp->data.conf) =3D=3D DP_CONF_DFP_D)
> +	if (DP_CONF_CURRENTLY(dp->data.conf) =3D=3D DP_CONF_UFP_U_AS_DFP_D)
>  		return DP_CAP_PIN_ASSIGN_DFP_D(dp->alt->vdo);
>  	else
>  		return DP_CAP_PIN_ASSIGN_UFP_D(dp->alt->vdo);
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

--2fVYJqbuNhrzGG0D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCY74bOgAKCRBzbaomhzOw
wowAAQDFTes+DZuv7868tAyRpVpR36P6n2H9MOeH+OqxPzCE5AD+MLsdcrYXjV24
gBXEi0yxLR33Mnnu3CMlN30COjy7IAo=
=0CVW
-----END PGP SIGNATURE-----

--2fVYJqbuNhrzGG0D--
