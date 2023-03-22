Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54E96C466A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjCVJ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjCVJ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:29:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6246B5BD94;
        Wed, 22 Mar 2023 02:29:28 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso660102pjc.1;
        Wed, 22 Mar 2023 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679477368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XBoeMowM+IoIMdHjKwOnzSsKPfs93K2XUbD3gSzsmUE=;
        b=AOtl+XeytMqaMs0MwWt00D4XoBAE/6kXB0ge8R0h3zkxP4DT5Rej8bUcjtH44dzKFb
         p8dYUKfg1f6+9Wvdv8Ugje+44FfhgwbNcOR//pWIqYNG6/kqRBhcxoYsXtu79lgIBAOE
         uIWHl6mlWH2VO6Vk3wXo/fvFGrYqlm9fIpHBkGiguEP2+8XZ9tPaMdJ0IjdpOFtzte5k
         EBUesAORZCBhFfeiU9AcdAtAcRvWQdnjPPk54AB0Wy3p2W7N/wHgrc6Nbx3O8R5lUxEc
         Wsrb4qs2r6ENmQjDbh3XaTv341+Y3MEhOWvx9wo3Ze0Qb5hqg+MS2x+l1xGo+ByoD153
         eOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679477368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBoeMowM+IoIMdHjKwOnzSsKPfs93K2XUbD3gSzsmUE=;
        b=dWpW1wnKup68rpxgffwMZc6O7iOcgRisnDkJOaYRZcbCfyjf9lWPkZICxdCzWeuvtE
         YxRxNpF6hpZ10U+F7JDMeCRpYNq7gxEJFT+35ppO/rNzFyrtSdN4okRULISenYExhA8w
         /EmHGgbOlUjFv4Ix875agMgIwIzQiVm866WTTkGt257EEUxa4XyrHXrXSkkVMTRp3D+T
         H7DjwMAf01+lkuAO5ep5nCJoZDi2kVzycEorV7v9ZTpcNVI4FMClRykLs5vnnzrStmkm
         hvBeoQXNmd5JcxVg2xJGJAiHNj8uNcq+lfaNXrRvXibQuzV9mJDhcBiajIQ/j7KH5+ng
         Q6Gg==
X-Gm-Message-State: AO0yUKUVHQ4yhw4ZYLx5OcHBhzQCgjN+Oeg+blxd9r+qd45+gSptCKl3
        0Hj9hmtc16e2hEyzt74xmRse3KJsBPY=
X-Google-Smtp-Source: AK7set8mTJRHvhWbhNQL/BlfDi/3wXyUn5Z0SM24vsHW+cALSNl/T5cHveTWBfpJhhH0qjKM6+gWAA==
X-Received: by 2002:a05:6a20:639f:b0:bf:4563:e647 with SMTP id m31-20020a056a20639f00b000bf4563e647mr4288716pzg.40.1679477367639;
        Wed, 22 Mar 2023 02:29:27 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-25.three.co.id. [180.214.233.25])
        by smtp.gmail.com with ESMTPSA id a3-20020a637f03000000b005034a46fbf7sm9294147pgd.28.2023.03.22.02.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 02:29:27 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B779B1064C9; Wed, 22 Mar 2023 16:29:23 +0700 (WIB)
Date:   Wed, 22 Mar 2023 16:29:23 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net
Cc:     kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: add system-state document to admin-guide
Message-ID: <ZBrKcwoFMAhmIn1f@debian.me>
References: <20230321231816.31131-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0vnTosCR76VYIEXj"
Content-Disposition: inline
In-Reply-To: <20230321231816.31131-1-skhan@linuxfoundation.org>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0vnTosCR76VYIEXj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 05:18:16PM -0600, Shuah Khan wrote:
> +scripts/checksyscalls.sh can be used to check if current architecture is
> +missing any function calls compared to i386.

i386 is the reference architecture for comparing syscalls, right?

> +This scripts parses Documentation/features to find the support status
> +information. It can be used to validate the contents of the files under
> +Documentation/features or simply list.::

"... to validate contents of Documentation/features files or simply list
them::"

> +Let's do one last sanity check on the system to see if the following two
> +command outputs match. If they don't examine your system closely. kernel
> +rootkits install their own ps, find, etc. utilities to mask their activi=
ty.
> +The outputs match on my system. Do they on yours?
> +
> +ps ax | wc -l
> +ls -d /proc/* | grep [0-9]|wc -l

The shell snippet above should be in a code block for consistency
with other snippets.

> +Linux kernel supports several hardening options to make system secure.
> +kconfig-hardened-check tool sanity checks kernel configuration for
> +security. You can checkout the latest::

"... If you don't have the tool handy, you can clone the repository::"

> + * https://docs.kernel.org/trace/index.html

Shouldn't the last ref be internal link (Documentation/trace/index.rst)?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--0vnTosCR76VYIEXj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZBrKbgAKCRD2uYlJVVFO
o3VaAP415FImweEF2ePXNyzWcQP35sUVq4OG8VI0Ht71e73DxwD+OSu5cCXAeH48
YKh9xLW+JHubcBCX8gn0+uJykH5FRQU=
=GHde
-----END PGP SIGNATURE-----

--0vnTosCR76VYIEXj--
