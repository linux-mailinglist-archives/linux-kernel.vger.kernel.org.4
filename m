Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0DD648CB2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 04:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLJDX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 22:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLJDX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 22:23:27 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D1525C49;
        Fri,  9 Dec 2022 19:23:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id jl24so6812287plb.8;
        Fri, 09 Dec 2022 19:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y74Cn5CiCVsP4DjJ8yZF5+hknYEUL/oM8T1MPatY28=;
        b=ikI8a2YQsDJ9qEuEgGCSg5/PgITzfs0cRaicS+l2YWND8wRBD3DOsWB/ZiKJ24Q2jg
         6Fj2yM8+t/wJVWLkuzfBpQ4oRyyxRWa/jH1MtcR6LofzIGuVkqBUGp6Lj1KHtoXUcPQP
         NjDT/4wuA8DEexN+BcSfvR8sc6ar6XcHdRBR78YeU20PNssFGTN0g97mhOl0fB5ub/Tg
         8+8SBdtv3sd5qPIz+LE99e/k5eyMOzLNwkYSHCEaU618yXIuDaQ9UdXyjPa3ZsJfHGFo
         StfKcEx9o7WGLu60qgxcY7S7BEp9IDdYn6aAysOM8ZtjIpceTCoJ5vCvlwDyGsEwr31t
         M33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Y74Cn5CiCVsP4DjJ8yZF5+hknYEUL/oM8T1MPatY28=;
        b=ovDtqt5NZMQkQ5OLoDsnQtHlWtcAzGaZXLuwpc1MQ5yQhAGSQlgd2rG7NA8LZBtF5T
         yyomnri55z0YcEWSer1JAZ+EoPR3Wzw6Swm2RRL6pKrNcQ2vNVSeKcSxsdvr7/WcAMiP
         XKAP3wmnDTaEOqOWxElmlHjuG4naFIf2fxNes//qSoxbrWC6L0EfyV64d560+v3Kx7T6
         IqTkbCxKQffcUcR5PCJ3hi1ieiAj9wJAK/DEXWQFsJkyImRLWuR9rPSTWaUSu5NKMX5R
         Mb4asuq/6X0jYC5qTY89xO6ubmfC90xX5cdSzJpereuopeKBN4kuCgO3h7G+x5yFhMRj
         nYDw==
X-Gm-Message-State: ANoB5plzm3BD5O2cp1BtsbHcrb4q4w4mf0PIWSlcdFH+KeyBuY/hUp6h
        uoLobGTcm8QGyEMtxYLinAk=
X-Google-Smtp-Source: AA0mqf7yFJ8CLN+3ulanB43+/24cpg/e7nMZKGpEzciyz1QtE/kE33uCcfTn5/y/kd/H9pM8QhETcA==
X-Received: by 2002:a17:902:d18c:b0:189:df3c:1ba1 with SMTP id m12-20020a170902d18c00b00189df3c1ba1mr7681329plb.38.1670642605609;
        Fri, 09 Dec 2022 19:23:25 -0800 (PST)
Received: from debian.me (subs02-180-214-232-76.three.co.id. [180.214.232.76])
        by smtp.gmail.com with ESMTPSA id d13-20020a63d70d000000b0047829d1b8eesm1605511pgg.31.2022.12.09.19.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 19:23:23 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 146CC101D56; Sat, 10 Dec 2022 10:23:20 +0700 (WIB)
Date:   Sat, 10 Dec 2022 10:23:20 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/21] blksnap - block devices snapshots module
Message-ID: <Y5P7qDolYickFyBJ@debian.me>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a3vgSDtb/WZb5Bie"
Content-Disposition: inline
In-Reply-To: <20221209142331.26395-1-sergei.shtepa@veeam.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a3vgSDtb/WZb5Bie
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2022 at 03:23:10PM +0100, Sergei Shtepa wrote:
> Sergei Shtepa (21):
>   documentation, blkfilter: Block Device Filtering Mechanism
>   block, blkfilter: Block Device Filtering Mechanism
>   documentation, capability: fix Generic Block Device Capability
>   documentation, blksnap:  Block Devices Snapshots Module
>   block, blksnap: header file of the module interface
>   block, blksnap: module management interface functions
>   block, blksnap: init() and exit() functions
>   block, blksnap: interaction with sysfs
>   block, blksnap: attaching and detaching the filter and handling I/O
>     units
>   block, blksnap: map of change block tracking
>   block, blksnap: minimum data storage unit of the original block device
>   block, blksnap: buffer in memory for the minimum data storage unit
>   block, blksnap: functions and structures for performing block I/O
>     operations
>   block, blksnap: storage for storing difference blocks
>   block, blksnap: event queue from the difference storage
>   block, blksnap: owner of information about overwritten blocks of the
>     original block device
>   block, blksnap: snapshot image block device
>   block, blksnap: snapshot
>   block, blksnap: Kconfig and Makefile
>   block, blksnap: adds a blksnap to the kernel tree
>   block, blksnap: adds a maintainer for new files
>=20

Per convention in block subsystem (see for example `git log --no-merges
-- drivers/block/`), the patch subject prefix should looks like "block
component: some patch" (e.g. "blksnap: do something").

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--a3vgSDtb/WZb5Bie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5P7qAAKCRD2uYlJVVFO
oxBMAQDiZVI/ZOQMMTngtyrZorqy9ONsxNMJQtfAoqcgAOYyAgD/fJfx7YohYs8z
LsYz1f786k+fCfipOou0ee1xjjRDeQE=
=KJUt
-----END PGP SIGNATURE-----

--a3vgSDtb/WZb5Bie--
