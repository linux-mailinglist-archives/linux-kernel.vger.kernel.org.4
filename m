Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E177047A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjEPIWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjEPIV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:21:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14904EC2;
        Tue, 16 May 2023 01:21:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae2c8734fcso8888185ad.0;
        Tue, 16 May 2023 01:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684225317; x=1686817317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i1tMLW6DSWJAntE+I5KuWI3/gKXK9s6L51FeppahMts=;
        b=fXe2aaHfUQG2KOp4zGNCfvmgZMOcSYl/YktISj9YlZz4cdvcya36Mdbk26BupTyeex
         Nb1IdMYvTqX3V6gE0sYW6C6tn3aWXd5WlOZHIoZ9VrSCiA3llbJ41s1n0bSfgIUd72KS
         KIMokZRQfhzRLvHhiWmHgZ0QR8Ked/BGPmTu+8g3kmsSTB0yJLsT0krOEA6cAfzs5OOe
         dP7ufWH70Da1Yfpmaaugb1KDjmUhYGbAzDZM/IG4w6qDwQ7jtdg8AFfiG1saB2CkArVa
         Id7JRSZOH4WWaymFgeeYkwBYsBKlXA7hrHyzXIk9C5Jnx15q+7p8WPmtoTu/4Xdui+IC
         Ql1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684225317; x=1686817317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1tMLW6DSWJAntE+I5KuWI3/gKXK9s6L51FeppahMts=;
        b=GZsAFh5gI0WL1nbaXVLGTvp5UWzqCa+5YFMbIt9PIhvy7Ev8jCU0ExQNlVOPFGOLHa
         us2HmHL+BNBX7fYMrhg0+17d30oSK0qsNtPqOo8RKmq2ra8+QRQcx8vFBnjEww8JwZjQ
         92mwVXwR+PH8sUtk+W9Ol4z7STOHjb4qUIJzLK9GR63xrH1p0ZAvjkPYSDst6yc45CHK
         k9rH0ZByOvgPPEHlL8/5Nac+hrreAGJOUBiwgxYL7qdze77u/MEI43Rc05CgsJh/fBzn
         k8vyQ4IM06MAMPuLulo9aOn7SB2q1tMQYRMi/+NH9Oi9rVCbSKbcUuMNcOOKoDxNhQuP
         LuVg==
X-Gm-Message-State: AC+VfDwj9nMUUVXI0BtJHADktlllcSAUGUx6MckA5LhHAqLnToPC4vf0
        CTaJDyA7fHhalexnShLYwfZdpPD6wuA=
X-Google-Smtp-Source: ACHHUZ6r+lC3evUL4hZ/DojRzT+Z0EuyD4+mKiusnp97fHqX7MLzfh2KfqRInTuiytCLFBBt9rGzlA==
X-Received: by 2002:a17:903:2452:b0:1ad:bc86:851 with SMTP id l18-20020a170903245200b001adbc860851mr26642602pls.45.1684225317073;
        Tue, 16 May 2023 01:21:57 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-73.three.co.id. [180.214.233.73])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001a800e03cf9sm14841603plk.256.2023.05.16.01.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 01:21:56 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id CCC32106212; Tue, 16 May 2023 15:21:51 +0700 (WIB)
Date:   Tue, 16 May 2023 15:21:51 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 000/371] 5.15.111-rc1 review
Message-ID: <ZGM9Hw8eNLr3Ay4/@debian.me>
References: <20230508094811.912279944@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8VmfzJecd+40CVXP"
Content-Disposition: inline
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8VmfzJecd+40CVXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 11:43:21AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.111 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--8VmfzJecd+40CVXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGM9HAAKCRD2uYlJVVFO
o8pxAP9jb21peI8gAYzgNHmohZHbJNs2E1nGig2qbFWQsb8BfwEAzYBNzMugQtH9
ePnO8axssFE7feYe3fEblNxw/mqtpw0=
=RTB5
-----END PGP SIGNATURE-----

--8VmfzJecd+40CVXP--
