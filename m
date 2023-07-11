Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1038E74F955
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjGKUtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGKUtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:49:47 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE56E9B;
        Tue, 11 Jul 2023 13:49:45 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7FF0F1C0AC1; Tue, 11 Jul 2023 22:49:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1689108583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pjvzqHFp8LIfdFXjHOUI6Im7LV07g2ArgXcDiJugfM8=;
        b=dMl7NkMoZr9kB38vZDHQimokyDUoKjZ6f19n2vmw5fIdTSPZS7qkiu7X0Cx8+9rewDFTwl
        EdBZ4RNT912YKtcrHQ597FWiZD79aiRc0zEE/T6UknW4+GC45QF1vBVzrVP11n4JRBTXyK
        97CD0xQQLUa60aRiwNySkrXg7yQuLz0=
Date:   Tue, 11 Jul 2023 22:49:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Shyam Prasad N <sprasad@microsoft.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Steve French <stfrench@microsoft.com>, pc@cjr.nz,
        lsahlber@redhat.com, pc@manguebit.com, ematsumiya@suse.de,
        zhangxiaoxu5@huawei.com, dhowells@redhat.com, brauner@kernel.org,
        vl@samba.org
Subject: Re: [PATCH AUTOSEL 6.1 06/15] cifs: fix sockaddr comparison in
 iface_cmp
Message-ID: <ZK3AZzm0BCglXXKN@duo.ucw.cz>
References: <20230626215031.179159-1-sashal@kernel.org>
 <20230626215031.179159-6-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PrDF4c4GHgG1I1r/"
Content-Disposition: inline
In-Reply-To: <20230626215031.179159-6-sashal@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PrDF4c4GHgG1I1r/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +++ b/fs/cifs/connect.c
> @@ -1332,6 +1332,56 @@ cifs_demultiplex_thread(void *p)
>  	module_put_and_kthread_exit(0);
>  }
> =20
> +++ b/fs/cifs/smb2ops.c
> @@ -510,6 +510,43 @@ smb3_negotiate_rsize(struct cifs_tcon *tcon, struct =
smb3_fs_context *ctx)
>  	return rsize;
>  }
> =20
> +/*
> + * compare two interfaces a and b
> + * return 0 if everything matches.
> + * return 1 if a is rdma capable, or rss capable, or has higher link spe=
ed
> + * return -1 otherwise.
> + */
> +static int
> +iface_cmp(struct cifs_server_iface *a, struct cifs_server_iface *b)
> +{
> +	int cmp_ret =3D 0;
> +
> +	WARN_ON(!a || !b);
> +	if (a->rdma_capable =3D=3D b->rdma_capable) {
> +		if (a->rss_capable =3D=3D b->rss_capable) {
> +			if (a->speed =3D=3D b->speed) {
> +				cmp_ret =3D cifs_ipaddr_cmp((struct sockaddr *) &a->sockaddr,
> +							  (struct sockaddr *) &b->sockaddr);
> +				if (!cmp_ret)
> +					return 0;
> +				else if (cmp_ret > 0)
> +					return 1;
> +				else
> +					return -1;

cifs_ipaddr_cmp already returns 0/1/-1, so this can really be "return cmp_r=
et".

Best regards,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--PrDF4c4GHgG1I1r/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZK3AZwAKCRAw5/Bqldv6
8uRHAJwP4r0wJjkrQds9FYH8w/a4U5stQACcCF0ivTGiLDSBXupgRSc9djKk3QU=
=c7q1
-----END PGP SIGNATURE-----

--PrDF4c4GHgG1I1r/--
