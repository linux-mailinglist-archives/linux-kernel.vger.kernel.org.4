Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E060BF38
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiJYAHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiJYAGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:06:45 -0400
X-Greylist: delayed 4144 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 15:23:54 PDT
Received: from elaine.keithp.com (home.keithp.com [63.227.221.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E665FAB;
        Mon, 24 Oct 2022 15:23:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 7417D3F337D5;
        Mon, 24 Oct 2022 11:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1666636504; bh=fE4YzItjZnxgJ2So2TV1go9hLn+lPre32wOumOrKUws=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=J7N7Q1zvtKPbtjJxuO8SPhuU6eB/sSiuxi7eHHlYqfr5p54G6TTYPR5/fdDy2oO/u
         bDKxsE1xSaHWZTPR7GpzUAVoPRNs0q1GjObMcP6ooAgW7AhveBujGvz0zzxm7P5MRC
         iS8+qTZ4YFUZjR/yDcUcSmXbXfEWvQDQi0lYlN9cFeeWmnpB2VT/ig79qMLZaVHm+a
         sIFxcKS0V1qMOtWTuWRhmflduMPf3IKdAy3peoMNNG66ckZqXOB22eB98S064573zY
         N6YzZAd4DSRKCt46xCvJ9dxTgPq4MN7AGqw/XPf6EjqJvksgNjydgKPzvm3sBWR0//
         L5QIp3LgqMSdw==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id EXR7_NEv1jGg; Mon, 24 Oct 2022 11:35:04 -0700 (PDT)
Received: from keithp.com (koto.keithp.com [192.168.11.2])
        by elaine.keithp.com (Postfix) with ESMTPSA id 0D46C3F337D4;
        Mon, 24 Oct 2022 11:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1666636504; bh=fE4YzItjZnxgJ2So2TV1go9hLn+lPre32wOumOrKUws=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=J7N7Q1zvtKPbtjJxuO8SPhuU6eB/sSiuxi7eHHlYqfr5p54G6TTYPR5/fdDy2oO/u
         bDKxsE1xSaHWZTPR7GpzUAVoPRNs0q1GjObMcP6ooAgW7AhveBujGvz0zzxm7P5MRC
         iS8+qTZ4YFUZjR/yDcUcSmXbXfEWvQDQi0lYlN9cFeeWmnpB2VT/ig79qMLZaVHm+a
         sIFxcKS0V1qMOtWTuWRhmflduMPf3IKdAy3peoMNNG66ckZqXOB22eB98S064573zY
         N6YzZAd4DSRKCt46xCvJ9dxTgPq4MN7AGqw/XPf6EjqJvksgNjydgKPzvm3sBWR0//
         L5QIp3LgqMSdw==
Received: by keithp.com (Postfix, from userid 1000)
        id 95E081E601CE; Mon, 24 Oct 2022 11:35:03 -0700 (PDT)
From:   Keith Packard <keithp@keithp.com>
To:     Kees Cook <keescook@chromium.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Daniel Axtens <dja@axtens.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        Zorro Lang <zlang@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Introduce flexible array struct helpers
In-Reply-To: <20221024172058.534477-1-keescook@chromium.org>
References: <20221024171848.never.522-kees@kernel.org>
 <20221024172058.534477-1-keescook@chromium.org>
Date:   Mon, 24 Oct 2022 11:35:03 -0700
Message-ID: <87k04pf4tk.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Kees Cook <keescook@chromium.org> writes:

> + * struct flex_array_struct_example {
> + *	...			 // arbitrary members
> + *	bounded_flex_array(
> + *		u16, part_count, // count of elements stored in "parts" below.
> + *		u32, parts	 // flexible array with elements of type u32.
> + *	);
> + * );

> + * struct flex_array_struct_example {
> + *	...		// position-sensitive members
> + *	// count of elements stored in "parts" below.
> + *	DECLARE_FAS_COUNT(u16, part_count);
> + *	..		// position-sensitive members
> + *	// flexible array with elements of type u32.
> + *	DECLARE_FAS_ARRAY(u32, parts);
> + * };

I'm sure there's a good reason, but these two macros appear to be doing
similar things and yet have very different naming conventions. Maybe:

        FAS_DECLARE_COUNT(type, name)
        FAS_DECLARE_ARRAY(type, name)
        FAS_DECLARE(size_type, size_name, array_type, array_name)

> +/* For use with flexible array structure helpers, in <linux/flex_array.h=
> */
> +#define __DECLARE_FAS_COUNT(TYPE, NAME)					\
> +	union {								\
> +		TYPE __flex_array_elements_count;			\
> +		TYPE NAME;						\
> +	}

How often could that second "public" member be 'const'? That would catch
places which accidentally assign to this field.

For code which does want to write to this field, is it mostly trimming
data from the end, or does it actually smash in arbitrary values? For
the former case, would it be helpful to have a test to make sure the
assigned size isn't larger than the real size (yeah, that would probably
take an extra field holding the real size), or larger than the current size?

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmNW2tcACgkQ2yIaaQAA
ABGa6A//WlcPIt1OZ72U5DGohaUla3vfRSTFFWeGl9RRAdiWSeidLKpuq8iGBpWU
+/2UygeNpW3KV9kJe4WCX/+PLAd2aGmRD1Me7OP+FdHj3FTa5iBEClfjg782geI1
5yQoGtsM3rujUSRAdlFTBF0S/n7YLE4JqtR51nCSu/jSsJ1GLbi9Yk5Wice/PsKL
0B7UU1Jl1QPQI6+q/LkCarAizF3/yKnAqVHgKCWAz2neKmd/8JgXdsaX9Kj5GVjV
q6CoXbrblbybvqaoV6LOARGs92rS55nFAIELZ6nmBdq3jfdpMlaSjGDh1NeIOM+o
f4Ls+kewrBIKYQljausRJ3YAcWXZNcprnmPr4dQx2iygqcIpe2B5nH/wGwqbiKCK
dXx8k33WjYJt0AbI9KZmJod52r1qsXk9sSiM/fOeIJ25J2GzCC4i/QjHEuopWdkp
qMLDnSKQQrPyCTR52csOgHqSvL1cbmkBWyIrzZcMdMGvbTBPNiKBIhOQU/ijSh7g
vM1sGPaRosgsgHgVMaLXDnUrrS6Lo0TwEM/43tt1KBSADkRx7K9pvhhh+yae3cK3
KGqj7Rk+acwhC8LMU82VTC557ZNSfnzeQaT0AFZ3wQBVJXt61y2eAqkIRIS4PIKM
iXFH76M95WGwitiO4kvqsEgcJkypic0/pYpAWAlMljyT6BJ2c9M=
=g28z
-----END PGP SIGNATURE-----
--=-=-=--
