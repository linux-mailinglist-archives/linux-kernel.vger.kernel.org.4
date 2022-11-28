Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22D363A04C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 05:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiK1EDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 23:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiK1EDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 23:03:09 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAEC2704;
        Sun, 27 Nov 2022 20:03:07 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 6so8845691pgm.6;
        Sun, 27 Nov 2022 20:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ilpG6GdC789HXmI5aw3aKOys6o4JUHsn6+C+0F+HJGE=;
        b=JgNYRVqOjC3J6zzCHhezSQKcGICWvtRXcZZV/QfD9yLjI8PLTsPAz5j1+BpR1zZ7ud
         C17JKc9CsWIWbLKCa6drSJskkfLcD8xb7K5I2hjcmSztUoI95mUvhTJF8QebbYXJp4Kn
         LOmhgupsSbEXb2EmIDJ+vxVHhh6UjvXRHIsFGMQ5ZHpwDpOoI0duNxAbUZcXClEFZLFg
         vycC1n4eB4jfDuNRSKU18HZBOWEd3mIIR4R/tS8Rd5bay6FuswTeWALmZyr6FvBbhEaz
         kb+F09axlyNMUL609iGg5Tqtyh2K5unr/ZuPYf5AuPKyTC9GPq3UP7khnYpqra91/1oy
         7+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilpG6GdC789HXmI5aw3aKOys6o4JUHsn6+C+0F+HJGE=;
        b=gyljfFmpU2iNZ7fpeUZPDPsXwp/PAyavYzYd9VG56BBve9g9ARQLSwi/GPUD1oLFXC
         56yW6n2dF1Soh03FykjRbqWtTneN8gDElgI6Oi27yBfHXPaVQWD6Nhl4AKs75ZqS+TXf
         ScdXOrXxTICGgCcPdhT15HO8dmSgQH1mwBpg6totGNJA+TRZ1cpkJz+jqsNGcsdnvorI
         xzn0TxTvfpHCE5wqrpJmqfhswe6e1FJzGedHbcTCnbnmUnrx/hpLUzYOKej/JZyOQXKQ
         J8yUl9Bq+0JTT4LBSeij4/ppKiFHkn6VcRM06ri3zFaVLIMd2f1mSWRXp0/g2zqyTOVi
         1iAA==
X-Gm-Message-State: ANoB5pllxi38dNaqpljQNthdEIVVig7oAzXTD7Eu322la9ugm1max+Ab
        cXmRUenQHt4sWggV4EPsRX0=
X-Google-Smtp-Source: AA0mqf6bze+yXYcqx3xk+GoY6mVDVHQSnDl/b6xE9mbGXshZotue5b5tKREVbSYA8QN58Mg5L/GZPQ==
X-Received: by 2002:a63:d556:0:b0:435:7957:559d with SMTP id v22-20020a63d556000000b004357957559dmr32676308pgi.122.1669608187418;
        Sun, 27 Nov 2022 20:03:07 -0800 (PST)
Received: from debian.me (subs03-180-214-233-83.three.co.id. [180.214.233.83])
        by smtp.gmail.com with ESMTPSA id c80-20020a624e53000000b00561dcfa700asm6913307pfb.107.2022.11.27.20.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 20:03:06 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 7B3D51038E9; Mon, 28 Nov 2022 11:03:03 +0700 (WIB)
Date:   Mon, 28 Nov 2022 11:03:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org
Subject: Re: [PATCH v3] doc: Fix htmldocs build warnings of stallwarn.rst
Message-ID: <Y4Qy9hpzyQMCDZwS@debian.me>
References: <20221124062204.1932-1-thunder.leizhen@huawei.com>
 <1c472632-caf6-72d3-5de8-aaa3a1fdfd61@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qZu2EZ2+iL1NvBah"
Content-Disposition: inline
In-Reply-To: <1c472632-caf6-72d3-5de8-aaa3a1fdfd61@huawei.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qZu2EZ2+iL1NvBah
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 26, 2022 at 09:30:32AM +0800, Leizhen (ThunderTown) wrote:
>=20
> Hi, Bagas Sanjaya:
>   Do you have time to review this patch again? Your review comments are i=
mportant
> because you made comments in the previous version.
>=20

OK, will review.

--=20
An old man doll... just what I always wanted! - Clara

--qZu2EZ2+iL1NvBah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY4Qy8QAKCRD2uYlJVVFO
ow5zAP0d2VP67ycj21Srtq8AHtkWRGlstqm4yxtCgcQLigutlAEArz3jeMoqCN8V
W2AkbsS/CvoDZduuNwYPDT/4Cj6cHQs=
=bAyq
-----END PGP SIGNATURE-----

--qZu2EZ2+iL1NvBah--
