Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989786F23A2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjD2HoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 03:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjD2Hn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 03:43:59 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124F81FFD;
        Sat, 29 Apr 2023 00:43:59 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64115e652eeso17299896b3a.0;
        Sat, 29 Apr 2023 00:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682754238; x=1685346238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fNsx+EGWInTOeiZ4tD3MVuDHiRQf5TbDrLEYxwSL/bM=;
        b=jY1gx92+1HxYj0Kd65ZE6f/w+Fk5U03K5aPD3TFgwk519gMgzP64KRJxruJHo31BVK
         8eFJug7Hss3BcoVyElaMxbRPyuArBtzdgcMcSNI2hZmWUwscpi3jN3WItnQDi6IvFX1j
         cYSDCi7dhUzfsBKUOwEekwE+W/kiRNgD3+bLBqvtXbSfIbR+14R2P+FHriRnOCan0Nlb
         9xKfNWOGC9edtaP4WWUNkFHT1ELUkBEv9vDOEMKoWLwNawFSSVleYAKZ79sb1lsfKccn
         bm1pxAR8kHursWMhlJGQATaYRih0UzgWXmnTISqfgn/p3pMF6KzsC8QksClKky3ttxhC
         oF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682754238; x=1685346238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNsx+EGWInTOeiZ4tD3MVuDHiRQf5TbDrLEYxwSL/bM=;
        b=fEBiRaNedFxZUvCI62WzvPs38sO6+Nf+EqV4Unh7tZ9I/16Mgtddtw24/PZSmdsfEx
         iHDZ+yewqurs5cQU0HD8Ht1b1CzhVqPNImM2Qo1b6lulDGTZNgqM2ADh8oYzeZl6+9nZ
         KPS7rNF+EoY645XQNtd7vp7tz16jyiWu1vusax+lBgNfyfDs7VjMl+pjWxX4RhNu7+Yn
         ZxfY583hfwEvSfVmsfzO1zbJzhOGxxWUEOwyC2yATlpNrRNZ5956RZV3AuF/aRLIiN5i
         HHGea42wmiv9dMzWHfg04ASWAlvT7BVC0fdzwiX8EHDSXFECL62KDEdC8icLiSLWsx/F
         UydA==
X-Gm-Message-State: AC+VfDzDJxOLT2Y02D71dEZBSl07yahAldEr5zBzvtUk8IZX9pWGglg3
        Ss0dAcv+mt79jXB7dZbZMcmTu1WQ++i0+g==
X-Google-Smtp-Source: ACHHUZ7GSSty4wq83CAvMYKvcnYfsaFPIsonBYyfBD4mAdRbxUHXh9u9Or+yszzrhdhg5ldaFNBtkQ==
X-Received: by 2002:a05:6a00:21d4:b0:635:d9e1:8e1e with SMTP id t20-20020a056a0021d400b00635d9e18e1emr15399410pfj.11.1682754238381;
        Sat, 29 Apr 2023 00:43:58 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-88.three.co.id. [180.214.233.88])
        by smtp.gmail.com with ESMTPSA id fe5-20020a056a002f0500b0062de9ef6915sm16138803pfb.216.2023.04.29.00.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 00:43:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6B81B106978; Sat, 29 Apr 2023 14:43:55 +0700 (WIB)
Date:   Sat, 29 Apr 2023 14:43:55 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 00/16] 6.1.27-rc1 review
Message-ID: <ZEzKu1gpZZD38rqQ@debian.me>
References: <20230428112040.063291126@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RKt0aBtYhjpidQhr"
Content-Disposition: inline
In-Reply-To: <20230428112040.063291126@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RKt0aBtYhjpidQhr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2023 at 01:27:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.27 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully built and installed bindeb-pkgs for my computer (Acer E15,
Intel Core i3 Haswell).

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--RKt0aBtYhjpidQhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZEzKuwAKCRD2uYlJVVFO
o8VFAQDYWVuLFqY9ZedQsA4I1jow6eAFXKNzDkhRWPfRDrSZ+AEAvjRO88mA2cWJ
Cz6HiPN+MzlS/nJDL0x1iF9TORupPw8=
=kTn4
-----END PGP SIGNATURE-----

--RKt0aBtYhjpidQhr--
