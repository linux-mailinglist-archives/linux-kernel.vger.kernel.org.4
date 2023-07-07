Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D353174B39E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjGGPGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjGGPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:06:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA3A1FE1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:06:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AF57619F1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF02C433C8;
        Fri,  7 Jul 2023 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688742389;
        bh=jYK2XSaPacxc90UzntYFLS4o3hAYHTTOBwjoUw67gLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLiNirxRPGt4FJN/EmPkQBS31EKNSC6ucw1VG9g8eNXGm03GQALTl590WVSJqccGE
         brHu0jZLSnV9msktPZC5L9jDtfe0hcVPEMzrFf1cSw/kZ69CVITgK03A4KPKTBlpZS
         0dUXWdoEvYIMrLgFPiPyjLlwSyMqYV2Mdf5N7zMmYz0i7x7bvJWc68eMVNI8tV5rVN
         O8+XlyKy1dqVkJx1Wj8yJYHDsJPB4Fr/Ir92Y0TkrLURTsvcIuC0gNtrcsc0NPWMSD
         48sMklM2Scgkvdykxj+1SZFsUBV+NKnpJ6u81Hx4jJnSSmr/Zpf8NkpHlqnevugnO9
         Z86E3TDdAKsJg==
Date:   Fri, 7 Jul 2023 16:06:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan@kernel.org>, perex@perex.cz,
        tiwai@suse.com, lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR
Message-ID: <56aecc8d-2f6c-42c0-a13a-89c84cf53773@sirena.org.uk>
References: <20230705125723.40464-1-srinivas.kandagatla@linaro.org>
 <ZKfAUOOcGoBanHHu@hovoldconsulting.com>
 <efaf5960-bcc5-6d52-5552-e1505a13b635@linaro.org>
 <87y1jrkgdx.wl-tiwai@suse.de>
 <3450ef1e-cb20-4242-b482-41d3d34c4564@sirena.org.uk>
 <87wmzbkfw7.wl-tiwai@suse.de>
 <f1041542-bd97-41d9-96b9-c6e5fef6b096@sirena.org.uk>
 <87v8evkf3w.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tlUa9QKqH2IYfFLy"
Content-Disposition: inline
In-Reply-To: <87v8evkf3w.wl-tiwai@suse.de>
X-Cookie: Victory or defeat!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tlUa9QKqH2IYfFLy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 07, 2023 at 03:47:47PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > The ASoC generic control stuff supports inverting the value prior to
> > presentation to userspace so it's masked there (instead of writing the
> > number userspace sees to the register we subtract the number from the
> > maximum value and write that to the register), pulling that up further
> > to the ALSA core might be nice I guess?

> I believe yes.  Though, I'm still not sure how we can improve the
> mismatch of dB min/max.  The dB values of those inverted controls
> reflect the result of subtraction, no?

Yes, the dB scale presented to userspace is reversed relative to the
ordering in the registers.

--tlUa9QKqH2IYfFLy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSoKe8ACgkQJNaLcl1U
h9Ctegf/U3PWgeDMZsd7FXUxx85bNLwdSWlDpYEqHFFJypwv/2YdY32iDhvNH6OR
9DmBkJN5P2e/DDad4QDRL7/Gwwhn4p6xl++jxf7oVpGoQDf1uh/ehNIitkwgOn6Y
fHT5J83riAClR+lA2ZwPbe96qGARhRnO4kTCoKywefe6iQozLG/8vdEqnHx9J1rz
1Kf1CNXM01rVA900X8vU+iKWTwnWBQszjDJH/GVlm6ymQ+TJT9i4z2e4beGJJNGR
bR7iMU002qW3Q2z1ZPEtESHw/6bGqna8UdRx71Nmrl7KB9nHuMGqOYYYSjwoPGld
ZgsBB4NGUfGWHbiJVbBwYwWZ42HuWw==
=cnPV
-----END PGP SIGNATURE-----

--tlUa9QKqH2IYfFLy--
