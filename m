Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A15743CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjF3NfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjF3Ne7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:34:59 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9173C34
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=PcXx
        NOWHcmxCDQGZ2++gyrvWOg/Jh/8imTf8rTAbNTE=; b=DsIVyAe8mFx28qd+QeJD
        uVFoOFwyRgGUdSRK3s95176ucP4mtVNJvkbpuSQHjtil/AcjknGDu2M2tLlkdnni
        IvqHZtwebQA6xCFLPBEzHVT88UADuJB7QBap9y0cgKtXPdRBJyQf+61y623k8k+K
        kXtCG7axscYjCCGscPZ8Ki1Umy7ohF7AviVcmoBOp/TleNIoqy36//zS3x6oAiWD
        E4SRXiVKMseKF3mC3OOCMU01hzc+3kVL00Ez9PWKjjegElWxVbWQWsXo6+HvAFes
        /sr4cmkS8DRC9sLbT8MERJkUjETrTCZa9M9jb0NwKJVa6ZpvQGhKh9wHnto7DsJR
        LA==
Received: (qmail 4184676 invoked from network); 30 Jun 2023 15:34:39 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Jun 2023 15:34:39 +0200
X-UD-Smtp-Session: l3s3148p1@/4TB4Fj/db7BVfKA
Date:   Fri, 30 Jun 2023 15:34:36 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
Message-ID: <ZJ7Z7HL684hrSkdx@sai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20230329202148.71107-1-dennis@kernel.org>
 <ZCTOMVjW+pnZVGsQ@snowbird>
 <CAMuHMdVK2zPnyB9s0uYwoKj0xspa0CRzqPjhrj-YFqVNdXxEkg@mail.gmail.com>
 <CAPDyKFqtgCK5Wb_fZ9+VVK1F-LWYL+htMvQ9JPpp0zPjzBZ9gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ardNddU0yOlyz+Nq"
Content-Disposition: inline
In-Reply-To: <CAPDyKFqtgCK5Wb_fZ9+VVK1F-LWYL+htMvQ9JPpp0zPjzBZ9gw@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ardNddU0yOlyz+Nq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Note that, even if the offending commit below triggers this problem
> 100% of the cases (as the probe path has now becomes synchronous),
> there was a potential risk even before. Previously, mmc_add_host()
> ended up punting a work - and if that work ended up sending a request
> to the host driver, *before* the irq-handler would be ready, we would
> hit the similar problem. I bet adding an msleep(1000) immediately
> after mmc_add_host() in tmio_mmc_host_probe(), would then trigger this
> problem too. :-)
>=20
> That said, I am going to revert the offending commit to fix these
> problems, for now. Then I will try to help out and fixup the relevant
> host drivers  - and when that is done, we can give this whole thing a
> new try.

I'll work on the TMIO/SDHI driver next week. Thanks for the input!


--ardNddU0yOlyz+Nq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmSe2egACgkQFA3kzBSg
KbYL0w//Uf2zwM8QA+MvS/28kErGL3iHJwmv3aOLVBcTQcZobGoGYTX7ylZridqi
k2bsQszEYrOqQHg5Nrgze3x1CmSW4zbKZhz67yhBWobwTY8wkYg/lVraQuXJPJQG
13J/Cfugtx+QcCfWwvdAyEd/FarBjMMUlBjjft8zz8OT5S4j3MWLKNg+k08Ytkou
C6TX2YYaSuzkUXo/6j8Zak+OUlIWVAthAnmExWwL8a2azufZoFizG+kWZIXyyjB3
MGFkNo39lM72eNCKhV8yScEm+DwRIVwnlMxGpy8bk5/Xh9YwJaYDAJgZHB3ZwcyE
LF/iI8h/EM6GTodNB97UQCFSkrHCyp9En+tqViXKaHrzZvG4Uudju8JZsNl1e/nX
TOmaSS4usgQfYX7nyO9niohJiw40KXC2xM+ZSLIQkxYwfPF0icqcOXm8mBTiJYO0
2W+Gs7iIK1+jroPGZtgu6uFplX8A5RgXSnBGyq0lE00GoEmVuV31kPuZPKGIXpdD
Q3INCdeaFEeR+0l+h9D3T5IkrVRv0VkxIPrgc2wZ13ZdgQx3/UzM57kybPZAz6Zk
x4FTMSxVOAQP57dOykCLOJMN0UhIB5RUJCJgKBPjbGt06fLEiuAzimd8+1O0jotl
BA9qn0A08k17fGaSL7bjmeNZkHQUoNiYiXgqJSMk5RREMDnavD8=
=suR+
-----END PGP SIGNATURE-----

--ardNddU0yOlyz+Nq--
