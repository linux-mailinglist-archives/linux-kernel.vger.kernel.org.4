Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB7F628AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiKNUv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbiKNUvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:51:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD6C1571A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:51:53 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DF61D6602995;
        Mon, 14 Nov 2022 20:51:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668459112;
        bh=bMpyH+/4FiYoqWgMqdnS697JNiSHBwCg9saHH1+OGgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cZSHR6LlBuC8X76x5C/QlMLMqIQdpbT1ACX18rdzkVctnSnoHCmC7f8l2IiD3TAEh
         FmumjikOpnpbT9U2MAvh/Bo1QMCnIJmjoXRS3p5Yb/poV7yj8ItQMX6J9PCahhq1+i
         ZEIiNJ6nwzCHlUca/6XuUhZimJcXNQBdSVs6UXMjBLb5oeG0EHNvLGAgeBYSoZBKuQ
         ZOYO6YX96tCyulNElBviEBLGfkss0bJqtdoAEXK1p8qXavZO4k3cDq57y4BXIBVkaG
         L/wgcduQc8lY3r7eOHK5QM8fvnHjNzOItKRWVl6R1H+J9p0Rs7KHiX81Io72TQ1JTP
         YfIfw0Nktk5rQ==
Received: by mercury (Postfix, from userid 1000)
        id F1BEE106D188; Mon, 14 Nov 2022 21:51:48 +0100 (CET)
Date:   Mon, 14 Nov 2022 21:51:48 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] HSI: ssi_protocol: Fix return type of ssip_pn_xmit()
Message-ID: <20221114205148.etcmhrzzqymmawfv@mercury.elektranox.org>
References: <20221102160233.4042756-1-nathan@kernel.org>
 <202211021207.8F7604C860@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pj6hpsbh2linlpg5"
Content-Disposition: inline
In-Reply-To: <202211021207.8F7604C860@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pj6hpsbh2linlpg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 02, 2022 at 12:07:02PM -0700, Kees Cook wrote:
> On Wed, Nov 02, 2022 at 09:02:33AM -0700, Nathan Chancellor wrote:
> > With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> > indirect call targets are validated against the expected function
> > pointer prototype to make sure the call target is valid to help mitigate
> > ROP attacks. If they are not identical, there is a failure at run time,
> > which manifests as either a kernel panic or thread getting killed. A
> > proposed warning in clang aims to catch these at compile time, which
> > reveals:
> >=20
> >   drivers/hsi/clients/ssi_protocol.c:1053:20: error: incompatible funct=
ion pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct ne=
t_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *=
)') with an expression of type 'int (struct sk_buff *, struct net_device *)=
' [-Werror,-Wincompatible-function-pointer-types-strict]
> >           .ndo_start_xmit =3D ssip_pn_xmit,
> >                             ^~~~~~~~~~~~
> >   1 error generated.
> >=20
> > ->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
> > 'netdev_tx_t', not 'int'. Adjust the return type of ssip_pn_xmit() to
> > match the prototype's to resolve the warning and CFI failure.
> > Additionally, use the enum 'NETDEV_TX_OK' instead of a raw '0' for the
> > return value of ssip_pn_xmit().
> >=20
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks, queued.

-- Sebastian

--pj6hpsbh2linlpg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNyqmIACgkQ2O7X88g7
+prqchAAnhtz4Nq2PI78VktAGNUPjJE+daFB1pq6E71I0v1cQ0AasXAAxbZ3kxcr
ZQzYpL8bmXudJDFZ+hGPllVvA/7KWCbKGPnpJjhEQea0guQdfiShrlKLUd+dNaGV
kMeUlCtlaxUWSqVlNGn05JHKjM50A9oucVKiVNSc2sEIhq1Tzq2608AqDter0Vag
pB2Fjx5ZcjI5bvNQQCm2Vvz2rCDpoXu1QkmXVgRDDJrE89OLfqXGml1T+i2Zzco2
ph9saPL7XhOlULcT/1mIbdOahhuXxvp2lmpWbWEGpVjZPJduAUmefUp55eFmOhUH
2RRl0M0SBaOP2sCuiHzSHlDabpk+oVrzgXX2fBlB0u8rDFnDki31HDxAKCDzuBCQ
nlF1CGPXUvRpPZe7/9r7/Y/Sy+DLwDgQnIxA9wn3Og/fJ24biuX6SUgzHP+1H1wy
x/1UPrIwbI3tmVS706FaxCRT3votE7rIjFpWXBm+uQIf1F1NqmqbsRgbTprWugZT
JMIEWrJjsvm02FUFedabo3sD7DEn0gKIWT4FYpD16vIDvWA8D07MMKmgKCLP9ybw
rkc3FFR+j47QDyVxCXYJn+b5trhSMAy+nsTzAhl+YDBmMtyElhucK9tBXeFaH+wU
DY9paVnnu0+sqGvdl2Rh8jpqrrmAC7m+cLDq+nvXCMq93yiKDQU=
=qxFt
-----END PGP SIGNATURE-----

--pj6hpsbh2linlpg5--
