Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554396209AD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 07:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiKHGoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 01:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiKHGom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 01:44:42 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FCE26489
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 22:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667889881; x=1699425881;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=AQcWoCcHM2weWRCMEOUkXBLqWa1s2gGh6x77ixq+6UA=;
  b=V/OD5U+9TC1PHJhb2qNo5Am2/fJVqhlEV8GRFzNWY0KJB6M8xhbUTvS3
   QQFju6fTI0sqnbkwYaTKFY8p9zpRWUfPRZQGWmKJK0YfaiY3cun78uDlf
   paPxaovr5/R+xqZZS4h4ntZuiDjgqepttGUJBrXt4v6cKzxN6GpBm6Lwk
   //S81eTau/HRZFxhHP9JWfsIlOlBXK2IdGFufSEXAwM+PKLRarJPMl72Z
   D7+254TxBWWEfRe53DAEWMhcDe0YeeqL6Xkm1sQ4f9oE4cgXy1jYuD5db
   D8C5SBG07Vjr7EEQ5TBIXF8e4mUt4Ii3fbFAVcJj/KToe3cOEnZxGuYnU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="308240824"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="asc'?scan'208";a="308240824"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 22:44:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="667476860"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="asc'?scan'208";a="667476860"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.159.108])
  by orsmga008.jf.intel.com with ESMTP; 07 Nov 2022 22:44:37 -0800
Date:   Tue, 8 Nov 2022 14:44:12 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [next] i915/gvt: remove hardcoded value on crc32_start
 calculation
Message-ID: <20221108064412.GJ30028@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20221030033628.GA279284@mail.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <20221030033628.GA279284@mail.google.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022.10.30 16:36:28 +1300, Paulo Miguel Almeida wrote:
> struct gvt_firmware_header has a crc32 member in which all members that
> come after the that field are used to calculate it. The previous
> implementation added the value '4' (crc32's u32 size) to calculate the
> crc32_start offset which came across as a bit cryptic until you take a
> deeper look at the struct.
>=20
> This patch changes crc32_start offset to the 'version' member which is
> the first member of the struct gvt_firmware_header after crc32.
>=20
> It's worth mentioning that doing a build before/after this patch results
> in no binary output differences.
>=20
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.c=
om>
> ---
>  drivers/gpu/drm/i915/gvt/firmware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/firmware.c b/drivers/gpu/drm/i915/g=
vt/firmware.c
> index 54fe442238c6..a683c22d5b64 100644
> --- a/drivers/gpu/drm/i915/gvt/firmware.c
> +++ b/drivers/gpu/drm/i915/gvt/firmware.c
> @@ -104,7 +104,7 @@ static int expose_firmware_sysfs(struct intel_gvt *gv=
t)
> =20
>  	memcpy(p, gvt->firmware.mmio, info->mmio_size);
> =20
> -	crc32_start =3D offsetof(struct gvt_firmware_header, crc32) + 4;
> +	crc32_start =3D offsetof(struct gvt_firmware_header, version);
>  	h->crc32 =3D crc32_le(0, firmware + crc32_start, size - crc32_start);
> =20
>  	firmware_attr.size =3D size;
> --=20
> 2.25.4
>=20

Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>

thanks!

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCY2n6vAAKCRCxBBozTXgY
J9NOAJ90+/zrOO+G2J0btugVOX3Rka6vUQCgnzp1wLu+ynVS2gklxJ1YxffpPhc=
=je3g
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
