Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B377747DB0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjGEG7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjGEG7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:59:30 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F9A199A;
        Tue,  4 Jul 2023 23:58:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8b2cb7384so753835ad.2;
        Tue, 04 Jul 2023 23:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688540328; x=1691132328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOBekDUo3aipR+GfrPkz/lBRM9kv+I/UnJZ1bWtQhbY=;
        b=kne59eDqFdRnpjPhStuLzwuz+YDVUhmmKeqSHqHqLYyM8Mx36L7+BjMRrjKBQsaZFn
         a1k9jKJWO/96LQUltnKeV7RrW/lgYMnxXmSrm9sOrA4YoYct5x2GCtzQ9lpCi1AYpFIb
         tESHMxS5Bvi8+DKLsQihkvH9ZCrrNoGYw+wIZSOfcpI8n1tofTsFjwpIOhmA6fqtwFSl
         IJnRTrybtirGbX06wH7Wgn/3s7nFoqyIb8vxpC9koMIeRXqSgyy9oga/zu5FKAOcn7kD
         ESvt/PKbaXnbfSYQ5pwTUj4W9YUNYA98J/+0nhvc1cZ2cBZqivnPfNtmg/33GJdzJrC8
         BKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688540328; x=1691132328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOBekDUo3aipR+GfrPkz/lBRM9kv+I/UnJZ1bWtQhbY=;
        b=hXH02aIsaSpsL8O36T/HiGYlbN23alW0sk0hnj1mdA0E5USJqweTXnJ0iPAEnQ7wUB
         NvBKOR7PSnhfLiPkQOeQZdPXceeD/6IbOuDq3qSvnQOVc8Dw5KV4s9ky4DEEsgVaNfWN
         4rKaWnDwBqfyok6o+kQHix0T3z8OINWG6Ch/MCtEsKXbRMwxUN4Ikyx+cJDpoDnOWHrO
         cH669D7BHIxZS0GxosMAoekbOffMwqlMcPuIY2GOyVrYhUwFgGKJwF28UuRpuSVS7/8F
         WNUYEmvFnW7lKLcsS22Fuum6jMLFYOZt4pY+RiP5jX8fPnard/5CDtIiH2XfGVHCfPpj
         TDOQ==
X-Gm-Message-State: ABy/qLbmS/nNCliyKakF74UMeTRZGMN1XjmbPVMteX6FmgyMFxIKYOUf
        GfKUOaxXesjAc1fNn6+po3Y=
X-Google-Smtp-Source: APBJJlGJh47YE1+DxQRpHxFoXP7erWWhRznO03XdtQE8sGDLNFyyo1zLqh4sST49Hn/8ANgjgHDFRQ==
X-Received: by 2002:a17:903:246:b0:1b1:99c9:8ce1 with SMTP id j6-20020a170903024600b001b199c98ce1mr13265300plh.51.1688540328442;
        Tue, 04 Jul 2023 23:58:48 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902e9d500b001b8649e52f8sm9490928plk.254.2023.07.04.23.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 23:58:47 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2FAF78061696; Wed,  5 Jul 2023 13:58:43 +0700 (WIB)
Date:   Wed, 5 Jul 2023 13:58:42 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/13] 6.1.38-rc2 review
Message-ID: <ZKUUovHusmwmZR1S@debian.me>
References: <20230704084611.071971014@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/qHfQp2kcWQ1L9Da"
Content-Disposition: inline
In-Reply-To: <20230704084611.071971014@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/qHfQp2kcWQ1L9Da
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 09:48:32AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.38 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--/qHfQp2kcWQ1L9Da
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZKUUngAKCRD2uYlJVVFO
ozhZAP9kql9Y4fampzYuzVfCougXR8SF4O6k5UH3zH47EFr6IAD/TKLMLdQUqa/Z
i6rYxXb1rxe2G8Ak4sv0ANy0mVUpwAw=
=EBqP
-----END PGP SIGNATURE-----

--/qHfQp2kcWQ1L9Da--
