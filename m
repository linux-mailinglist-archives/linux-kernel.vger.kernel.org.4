Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349A863603A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbiKWNnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbiKWNnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:43:08 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00290CB970
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:31:51 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p12so16643631plq.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmX+sNd2+WsKp5/zxxkZF8cIapARqYlBxdtagaO9M7c=;
        b=fmDgQqEy1dNPukYcsU3C4C7OlFijxRXFWdfb+rzHedDdJQsV2lrxIMXztbl7ofUNBL
         Xm8WtVZcEiIsMQAGNgoU+HMxqxUPmIAmSUN5v93UbMWrvEz7+DSQo+GEILnoz7C4v9T5
         2Q6tvp+83Hb84PBi5pphvCzt98Qr3SkbwbEE74qJefHgk4+p45P+UGQkBXtMpCUhlXqe
         SPUna6I11uMRFeaFJfzPU+NUAKNnz5GLYo6Snzd2XSqeCZ1PT0n6WP0h4SwwaxanvQC7
         UPjN0DhOI6877EajrrgVzcSe9B1ASfTdRw0UeCvVfwtIpX3yH/ZyR1iI9su/uRxNF0Os
         PhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmX+sNd2+WsKp5/zxxkZF8cIapARqYlBxdtagaO9M7c=;
        b=PGZmaQPQdarmJPZS+KUQoDD4kIpnd/i2PXHpWbqKP3gF5gYGukqOFk71mZlXco3SCx
         m3tiGpZjRxHavUBOgIRskkwfxi3CnFDNsszpebH1lfPkUiw+0k6AnNvc0i+2t8eMZDg8
         XcjhZ1oSUFmzli0esc3LJjjFrxfk7ZDRBqschtD9JLNz0cE5ak+RhTvMjNVFCjmJpus0
         5p8KCrEoImhM/Se2xtP5zqRrsiZG4Z9iKRMwA4DAtUTzXqVNkGHPhBRDL1qGBw3Z0NMX
         ghhlHWabs9tjatYBjhHl0NNO87u9xeIVJ+74QCkzhEMRU3MHOgXPkQq6MgIU56HvkxD5
         aR1Q==
X-Gm-Message-State: ANoB5pk1/BXovD8tMhGE/FuRT8gAFXdsOYxf9y8k0xlX5LTWXezuzCNl
        C3A9vSkOz9kl++a6x/WuoQk=
X-Google-Smtp-Source: AA0mqf5uWvDCFfb45VrpQKAdJfSBtAN4gDdIECt/EUvSkn50dObyV5LyATmv1eJzrez2i3KFPfiQOg==
X-Received: by 2002:a17:90a:3f89:b0:217:90e0:3f8c with SMTP id m9-20020a17090a3f8900b0021790e03f8cmr36491582pjc.192.1669210311443;
        Wed, 23 Nov 2022 05:31:51 -0800 (PST)
Received: from debian.me (subs02-180-214-232-75.three.co.id. [180.214.232.75])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090a410d00b00218f15f4b39sm692198pjf.56.2022.11.23.05.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:31:50 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 9CA84101C57; Wed, 23 Nov 2022 20:31:47 +0700 (WIB)
Date:   Wed, 23 Nov 2022 20:31:47 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, nicolas@fjasle.eu, masahiroy@kernel.org,
        kirill.shutemov@linux.intel.com, tony.luck@intel.com,
        michael.roth@amd.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Avoid relocation information in final vmlinux
Message-ID: <Y34gw8tCCZgjBwUM@debian.me>
References: <20220927084632.14531-1-petr.pavlu@suse.com>
 <Y34SXeU6JEk+UGfV@zn.tnic>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DXuslu4VTRt+P95M"
Content-Disposition: inline
In-Reply-To: <Y34SXeU6JEk+UGfV@zn.tnic>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DXuslu4VTRt+P95M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2022 at 01:30:21PM +0100, Borislav Petkov wrote:
> > The patch optimizes a resulting vmlinux by adding a postlink step that
>=20
> Avoid having "This/The patch" or "This commit" in the commit message. It =
is
> tautologically useless.
>=20
> Also, do
>=20
> $ git grep 'This patch' Documentation/process
>=20
> for more details.

Why do you say "tautologically useless"? I think even
Documentation/process/submitting-patches.rst doesn't describe why.
Regardless, I'm almost always sticking to the rule.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--DXuslu4VTRt+P95M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY34gvwAKCRD2uYlJVVFO
o8giAQChNmQO6FbdDJHIwlh6S7CuMXxrIVbWnKtifobyfKeorQD8CvVGS037Q7Gs
fTnXgH8sUisZKeRi/1ShSiWhjZlRKgM=
=SMI/
-----END PGP SIGNATURE-----

--DXuslu4VTRt+P95M--
