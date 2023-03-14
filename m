Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB1C6B89ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 05:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCNEzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 00:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjCNEzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 00:55:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA0F26CEA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 21:55:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so4815399pjv.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 21:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678769706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V+GGb3ptBh1e6f7SZa3WUdgPGSOkMzefKbLzCNkJM7A=;
        b=C9DBDX+gVzOuJcvEcgQmkLsriX59c0qHolTRZQgVElo7mJO9XP0XrE3e3AJLwNzWPP
         dQmSVHpMPhhrtC2An2IfLVyxVengslpinKhVFActY2ig2nDcpJx1lgJZrIAjT0NQqVa7
         gaKyosDjZE0GN6IikF1Hixykv/CEy5dwbraEuhpAFEw0MPVvKsUnjhROkIft3z8+NtMt
         +2zB7bS/cZJlKg6XWXFPvqN9oTGAYhAiaV04jNVP6STCsKrLm8TcphhcPgn48B3nqGtc
         +Uh2a0+rY0ro/KJsQXKYOS8TF+oP9GmnoeJKS2uO6/OUHP6s9vj5FGbO+uQhBNhYyv52
         EhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678769706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+GGb3ptBh1e6f7SZa3WUdgPGSOkMzefKbLzCNkJM7A=;
        b=SKZItjiLn5KpQLn8JEiyngDxF3uhC1nmyKW5jgUteEoWarW3TlE/0AP35xP3FqYlSt
         oxHkv5F1vbx/Louu5AGpOBNcnPUffNiSKePTLzQ0SLQtfbmPAXF0690B06mWDzoW5Nte
         lGeOpQXv8aYSldJ/RrpNKJz8pUR9Ct7aaq2qwezjnnBFQ9j6Qg6OSVSxwOF04g1+amyQ
         vsZu3qbDVMZ3CKgp0cnO/l+xij8VGLqtg7E/c67CKKw/5iN5KJGfYDiu2aKe4GELag8E
         UBFUbIONG8erR1MJc3CqmPW8fojbfmX1y53JEcsSjhK4XDagi1qDfgmvSPkq8N7WGTpQ
         Jo4Q==
X-Gm-Message-State: AO0yUKV3urzOrchu/o2EshL9DjYNLxCacBsI9n56lLiMAwmReDJEiQr6
        UmkzPRmzOI9r97H+9kXO42izO2FtIXQ=
X-Google-Smtp-Source: AK7set9M5yiG8FIOgaweAra6Tzonl3vZeHRpbzxyVm6TtU3dc099vSZEQbAG4owpeEK9wEVGsTx2CA==
X-Received: by 2002:a05:6a20:144d:b0:cd:c79:50e8 with SMTP id a13-20020a056a20144d00b000cd0c7950e8mr44791277pzi.62.1678769706058;
        Mon, 13 Mar 2023 21:55:06 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-88.three.co.id. [180.214.232.88])
        by smtp.gmail.com with ESMTPSA id j11-20020a65428b000000b004d4547cc0f7sm580920pgp.18.2023.03.13.21.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 21:55:05 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 17B811066DA; Tue, 14 Mar 2023 11:55:02 +0700 (WIB)
Date:   Tue, 14 Mar 2023 11:55:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Kloudifold <cloudifold.3125@gmail.com>,
        teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750: Rename function to avoid CamelCase
Message-ID: <ZA/+JlgWfdg2wH8B@debian.me>
References: <ZA+K6OdPe21k8F2k@CloudiRingWorld>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q9+2y9es+8db1Tkx"
Content-Disposition: inline
In-Reply-To: <ZA+K6OdPe21k8F2k@CloudiRingWorld>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q9+2y9es+8db1Tkx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2023 at 04:43:20AM +0800, Kloudifold wrote:
> The sm750 driver had some functions named in CamelCase,
> which violates the kernel's naming convention.
> In this patch, I rename these functions to snake case,
> which is the expected style.
>=20
> This v2 patch was prompted by an error reported by the
> Linux test robot, which detected the compile error.
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@i=
ntel.com/

Hi,

I'd like to write the patch description as (ignore markdown):

```
sm750 driver has sm750_hw_cursor_* functions, which are named in
camelcase. Rename them to snake case to follow the function naming
convention.

Fixes: <commit that introduces these camelcase function>
```

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Q9+2y9es+8db1Tkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZA/+JgAKCRD2uYlJVVFO
o7VIAPsG0Of1YSDHa+Ug6knGMBl+AC/WH6UA5gFPaUapKrIcOwD/UyxwKtQxte62
rsEOKS1MlZupf1k40EL7qlGMJGwuvgM=
=k0dL
-----END PGP SIGNATURE-----

--Q9+2y9es+8db1Tkx--
