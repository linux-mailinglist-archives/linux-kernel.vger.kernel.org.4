Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9E768E7DE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 06:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBHFso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 00:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjBHFsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 00:48:40 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B251911EAF;
        Tue,  7 Feb 2023 21:48:39 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4PBTZB5KfVz9sNW;
        Wed,  8 Feb 2023 06:48:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1675835314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZylWv+h3Xu218ZbfmC9cFiHzhi6vfLtl/EmguZL1KJs=;
        b=UnzHsKqUwvCYeRVg5A6EmHxZ8pout8XsTe8f/O2sayi18pZVmHHbqGy3IpvxaabJuYFAE2
        Ypflp+2CG9ATBGTRU32rdh9OB6ATHhzFr8+S2e7w7JZtV1GCq0sU5h1THC1VV2ZksOr8r3
        cbk1BcF0C/pnLjEqd52y8EQH0pKsvbCw9D2gWTNL6OVjNcfHY0A/PuJA379BonOWbEuiRC
        qd+6NeKmthFLtkJPt0BECDW+neq+NsEudIjBruTIckjY2q+p2iXg0fyh+Rp0osai5qQDcY
        fVwfDMB/rDDPVg6+zBrZchjGchnF8osOapA7gLRTo6xyX4t8MM0YsWbWZAa1sQ==
Date:   Wed, 8 Feb 2023 16:48:18 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexander Potapenko <glider@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] uaccess: Add minimum bounds check on kernel buffer size
Message-ID: <20230208054818.geaw2toki4mo32uc@senku>
References: <20230203193523.never.667-kees@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vp6wzq7tucbqsbdg"
Content-Disposition: inline
In-Reply-To: <20230203193523.never.667-kees@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vp6wzq7tucbqsbdg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-03, Kees Cook <keescook@chromium.org> wrote:
> While there is logic about the difference between ksize and usize,
> copy_struct_from_user() didn't check the size of the destination buffer
> (when it was known) against ksize. Add this check so there is an upper
> bounds check on the possible memset() call, otherwise lower bounds
> checks made by callers will trigger bounds warnings under -Warray-bounds.
> Seen under GCC 13:
>=20
> In function 'copy_struct_from_user',
>     inlined from 'iommufd_fops_ioctl' at
> ../drivers/iommu/iommufd/main.c:333:8:
> ../include/linux/fortify-string.h:59:33: warning: '__builtin_memset' offs=
et [57, 4294967294] is out of the bounds [0, 56] of object 'buf' with type =
'union ucmd_buffer' [-Warray-bounds=3D]
>    59 | #define __underlying_memset     __builtin_memset
>       |                                 ^
> ../include/linux/fortify-string.h:453:9: note: in expansion of macro '__u=
nderlying_memset'
>   453 |         __underlying_memset(p, c, __fortify_size); \
>       |         ^~~~~~~~~~~~~~~~~~~
> ../include/linux/fortify-string.h:461:25: note: in expansion of macro '__=
fortify_memset_chk'
>   461 | #define memset(p, c, s) __fortify_memset_chk(p, c, s, \
>       |                         ^~~~~~~~~~~~~~~~~~~~
> ../include/linux/uaccess.h:334:17: note: in expansion of macro 'memset'
>   334 |                 memset(dst + size, 0, rest);
>       |                 ^~~~~~
> ../drivers/iommu/iommufd/main.c: In function 'iommufd_fops_ioctl':
> ../drivers/iommu/iommufd/main.c:311:27: note: 'buf' declared here
>   311 |         union ucmd_buffer buf;
>       |                           ^~~

Makes sense.

Acked-by: Aleksa Sarai <cyphar@cyphar.com>

>=20
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Alexander Potapenko <glider@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/uaccess.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index afb18f198843..ab9728138ad6 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -329,6 +329,10 @@ copy_struct_from_user(void *dst, size_t ksize, const=
 void __user *src,
>  	size_t size =3D min(ksize, usize);
>  	size_t rest =3D max(ksize, usize) - size;
> =20
> +	/* Double check if ksize is larger than a known object size. */
> +	if (WARN_ON_ONCE(ksize > __builtin_object_size(dst, 1)))
> +		return -E2BIG;
> +
>  	/* Deal with trailing bytes. */
>  	if (usize < ksize) {
>  		memset(dst + size, 0, rest);
> --=20
> 2.34.1
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--vp6wzq7tucbqsbdg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCY+M3ngAKCRAol/rSt+lE
b0q+AP9OwsMxuge5vMYJo2+9fH5bmYNcLWHfBb+uD+aeLntahgEA4v8J1lQpM7Ki
Qo4oyu4BaUei9uD+gINFKY2t7rX1SgI=
=xVlD
-----END PGP SIGNATURE-----

--vp6wzq7tucbqsbdg--
