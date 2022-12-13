Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9B864B457
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLMLk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiLMLkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:40:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8461D0C3;
        Tue, 13 Dec 2022 03:40:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AABFB810CB;
        Tue, 13 Dec 2022 11:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A85C433EF;
        Tue, 13 Dec 2022 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670931649;
        bh=a3uM+NwgrxE9/Equ3z8yfvDSF/B2Uo8jYAQaJ9WnQ08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A7m1Z4D65qZhLo5f8G0vWRaDpwNZJtpEHki102/SIci7Y5R7ZWe5DbKzcPFhEQaTY
         hs0EmmP2oqjyGvUFcIieGvmCyVFzjML5CiL04/it3TAQEkTkW/w9C7HNaUE0+NkDEW
         UfSvvQNo+DZtaI7IH9V+K7IpjKbsblA+lDxNZEDr1AcWIQ0rettf67zKzhaM7BqHOb
         sEzxH+QhU1KqKCfp55FbfDVO+1lKVxonzgH4EtEc7puqjcR9QUTpoXCIBVg8DTVZnT
         iKPBtxAHqElSDPeIIT2LJ/tdi2GHiMHK//lqDUwPU5MyjtSFiB60cnTBKe+7A+Saj1
         E4RuRPf41qomg==
Date:   Tue, 13 Dec 2022 11:40:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v1] spi: xtensa-xtfpga: Fix a double put() in
 xtfpga_spi_remove()
Message-ID: <Y5hku6VFhguH2osM@sirena.org.uk>
References: <7946a26c6e53a4158f0f5bad5276d8654fd59415.1670673147.git.christophe.jaillet@wanadoo.fr>
 <CAMo8BfKCv9j-ftKWU+B27g1oHBB_=EZhGBH7qymyVAeF10JcnQ@mail.gmail.com>
 <Y5dKk+uw3UcW2Pu1@sirena.org.uk>
 <bdb26ba3-7276-359a-7784-6ec3e35c64de@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mqecs6IEkkZ9zLfG"
Content-Disposition: inline
In-Reply-To: <bdb26ba3-7276-359a-7784-6ec3e35c64de@huawei.com>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mqecs6IEkkZ9zLfG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 13, 2022 at 09:30:32AM +0800, Yang Yingliang wrote:
> On 2022/12/12 23:36, Mark Brown wrote:
> > On Sat, Dec 10, 2022 at 06:48:02AM -0800, Max Filippov wrote:

> > Probably worth a comment though since it is a bit of a gotcha.  Ideally
> > we'd improve this in the bitbang code but that's harder.

> Ideally, spi_bitbang_stop() should undo spi_bitbang_start(). shall we move
> spi_master_put() in spi_bitbang_stop() instead of
> calling it separately in drivers?

Ideally like I say, there's issues with devm IIRC which make it more
complicated than just adding a put() there.

--mqecs6IEkkZ9zLfG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOYZLsACgkQJNaLcl1U
h9BZPwf+Ny42WwHXUMIzf46c6f9EyBH0/UqF7yyuUcaJ9EVVi1mYMaY1p1CbG45Z
80H+ZkfcWDDlrgSAsukJCzVJ3U3foAI3MtarQJFJ+6h6zcw/SqEExQ1hADg5tH3C
svM/zcT7k9yoPVcYXLaLJ7QnB+TUAdUXdYAxpHeAXokDK7IsYpynr4IMwjuOEajH
U3UJ9dbRHpACDz4a8+ZGzcsdTpJfzEYe5X80GmJerkix/O8uGFq1cK/mLvgwscFr
BS/LJbABnUQVJBHkRpzdG8V6CwouG0W+hwWNy9EXi2rvnQhpVWtnLQq97ngY+DaO
HwVRroIuno1HawxhJm6flTpK/SEzAQ==
=/C27
-----END PGP SIGNATURE-----

--mqecs6IEkkZ9zLfG--
