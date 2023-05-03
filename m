Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355276F4E22
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 02:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjECA15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 20:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjECA1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 20:27:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BDA1FFB
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 17:27:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77A4661F23
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 00:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E9BC433D2;
        Wed,  3 May 2023 00:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683073673;
        bh=NYrACsssrmfPGmWOcmRZXfT33+ftG3IlffU7YP1nyHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKLGj0WKZZ2Jx2liro9O4TKwiTokjOB7MujVV/4BMu708nhKYKULt7NqfT4I8zJ7u
         haUCLNNiID4OoFA+dgqh0H2o58AmbGH7Bn+pZGlKx3wr338oqwqwUICg2RJ0Digp6d
         /5EWpE8FlXGIjir90U1Pe+gwOgD6oNUymU9C040eNEyWmj86ngkArJemNNVruRXxzw
         ZZrUnNBSiv4HLyzZivkUPBVA4Mu1xwErVMiNWPptQ5k3W7jx2pn06W1w70BDPEGMGv
         K29KmhS20iGrZo6J3R7Tlj+Dp6AQcZf5GFfCAz+aoOsXxp0dA22X3uCTC/pPPQLFjj
         WMQkzH4PR530g==
Date:   Wed, 3 May 2023 09:27:48 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Shenghao Ding <13916275206@139.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
        shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, gentuser@gmail.com
Subject: Re: [PATCH v1 3/5] firmware: tasdevice_fmw: tasdevice firmware
 loading lib
Message-ID: <ZFGqhM0VYFdorkRa@finisterre.sirena.org.uk>
References: <20230502053235.27066-1-13916275206@139.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jHuLl3Qdr+Gp3RDN"
Content-Disposition: inline
In-Reply-To: <20230502053235.27066-1-13916275206@139.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jHuLl3Qdr+Gp3RDN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 02, 2023 at 01:32:35PM +0800, Shenghao Ding wrote:
> Create tasdevice firmware lib.

>  drivers/firmware/Kconfig            |    1 +
>  drivers/firmware/Makefile           |    1 +
>  drivers/firmware/ti/Kconfig         |    5 +
>  drivers/firmware/ti/Makefile        |    3 +
>  drivers/firmware/ti/tasdevice-fmw.c | 2380 +++++++++++++++++++++++++++
>  5 files changed, 2390 insertions(+)

Given how large this part of the code for these devices is it definitely
makes sense to split it into a separate commit like you've done but are
there any non-audio devices in this series which will share the same
firmware style?  If not then it probably makes sense to keep the code in
sound/soc/codecs, though a separate file would still make sense.

There's some devices that do keep firmware interface code in the
firmware directory but in those cases the devices have other, non-audio,
functionality which also uses the firmware (eg, always on monitoring)
but I've not seen any of the tas devices like that.  If there are some
then the split you've made here makes sense.

--jHuLl3Qdr+Gp3RDN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRRqoEACgkQJNaLcl1U
h9DwJQf/c04X1IDM9RQnB9HFoA2w4Yrd+wID6cNDcMHE05So35+rSAErad/PhU1k
1pu6mTeujT/5RanZL3cElVkqNaKgGy3bY0Aewu4BB6Jp0AkkM9+uk02lG6KHsnB3
ZPWke1iHD1uMIyNYAUm9mQM3pTYCmva2EI9/k6vBfAcfuVhBWDgke6GabRPtoaeh
tpND2K9ckr41xRW0s8GW+SJ+dH9E88V66qGoqez28A/iHjYUupdwEpQAzl6d7R5U
ICP0sv/RgamEp6yYLT/dj+muh/+gbyanTYvfKDPLfGKKUB8c84gCn4sKbQpEDaSf
anNb6TU9LQsQRxu8cijdPQ0YwrAvYg==
=KUlJ
-----END PGP SIGNATURE-----

--jHuLl3Qdr+Gp3RDN--
