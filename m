Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E0A733A13
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjFPTjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjFPTja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:39:30 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6426119;
        Fri, 16 Jun 2023 12:39:29 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AC77B1C0E70; Fri, 16 Jun 2023 21:39:28 +0200 (CEST)
Date:   Fri, 16 Jun 2023 21:39:28 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Steve French <stfrench@microsoft.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>, pc@cjr.nz, pc@manguebit.com,
        ematsumiya@suse.de, lsahlber@redhat.com, sprasad@microsoft.com,
        vl@samba.org, metze@samba.org
Subject: Re: [PATCH AUTOSEL 6.1 07/16] smb3: missing null check in
 SMB2_change_notify
Message-ID: <ZIy6cGtTFLZ5emr3@duo.ucw.cz>
References: <20230615113816.649135-1-sashal@kernel.org>
 <20230615113816.649135-7-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tpD4GdmscRX88zI1"
Content-Disposition: inline
In-Reply-To: <20230615113816.649135-7-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tpD4GdmscRX88zI1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Steve French <stfrench@microsoft.com>
>=20
> [ Upstream commit b535cc796a4b4942cd189652588e8d37c1f5925a ]
>=20
> If plen is null when passed in, we only checked for null
> in one of the two places where it could be used. Although
> plen is always valid (not null) for current callers of the
> SMB2_change_notify function, this change makes it more consistent.

Changelog explains problem can not happen, so... is this important
enough to backport?

Best regards,
								Pavel

> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/all/202305251831.3V1gbbFs-lkp@intel.com/
> Signed-off-by: Steve French <stfrench@microsoft.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/cifs/smb2pdu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 537e8679900b8..3ca593cdda76e 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -3779,7 +3779,7 @@ SMB2_change_notify(const unsigned int xid, struct c=
ifs_tcon *tcon,
>  		if (*out_data =3D=3D NULL) {
>  			rc =3D -ENOMEM;
>  			goto cnotify_exit;
> -		} else
> +		} else if (plen)
>  			*plen =3D le32_to_cpu(smb_rsp->OutputBufferLength);
>  	}
> =20

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tpD4GdmscRX88zI1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIy6cAAKCRAw5/Bqldv6
8vrRAJ0T7SxR70tEUsVGJxDv21jyrUVGiwCgs6BD2Ydi6XHT2gOEOpXYBZBLh/Q=
=n8do
-----END PGP SIGNATURE-----

--tpD4GdmscRX88zI1--
