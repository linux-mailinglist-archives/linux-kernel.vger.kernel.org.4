Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9EC6C58C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCVV2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjCVV16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:27:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4EF2A16D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:27:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8992EB81D44
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 21:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7943C433D2;
        Wed, 22 Mar 2023 21:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679520472;
        bh=U7ZA4ZzajtB3yTZYIzLq7NVdSezmrWNVSZd/pwipOXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDZg1c8eq+qM8F9GtHtE2Y2kTFca3WB/rFf41Ha7wwWW9LML0iSBduYNCnEJk2vTa
         LYY14IoAvBZbPDCeXFKjIALMDsLAAnl4S8CXw2W5e3q7x+GceFIg6jO85axrHVAoBx
         cyq5iikM13aTNELSCBQg2JvRAokB7MDdFUcIBgbPuMeqdyP/vzlFryjh0CvRaDbpHr
         gqIgNcy6J5dL9Ega9tBSRZbf7uNDvJbDSdMdYZ8l9nb4zYXXQh5W7m1A4Q2Myfi2CN
         KbCby2aHF7/pK6HDzctw1G1VigHL9beGCVSVZH1Hvjhp5iAkGoFqs5wqLcPf57v0Yw
         ESKr4gNeRwzoA==
Date:   Wed, 22 Mar 2023 21:27:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     =?utf-8?B?5rKI5LiA6LaF?= <zhuning0077@gmail.com>,
        yangxiaohua <yangxiaohua@everest-semi.com>,
        Zhu Ning <zhuning@everest-semi.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables
 sound for systems with a ES8336 codec
Message-ID: <ZBty1CdPaWm0IcRi@sirena.org.uk>
References: <20230320203519.20137-1-posteuca@mutex.one>
 <20230320203519.20137-4-posteuca@mutex.one>
 <141a3320-ff65-459f-9d00-c8bed691dcfc@sirena.org.uk>
 <87lejpwxzf.fsf@mutex.one>
 <ZBr9rJn50ovG1w9W@sirena.org.uk>
 <87ttycjyw3.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pZnMYUgZ7ZDcg5Bx"
Content-Disposition: inline
In-Reply-To: <87ttycjyw3.fsf@mutex.one>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pZnMYUgZ7ZDcg5Bx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 22, 2023 at 10:48:28PM +0200, Marian Postevca wrote:

> Regarding playing the speaker and headphone simultaneously, is not
> something I took into account. Is this even a valid usecase? The intel driver
> for es8336 doesn't seem to support it.

Yes, for example consider a critical notification - the system
may wish to ensure it is audible even if the user has taken off
their headphones for some reason.

> >> This is needed because if suspending the laptop with the headphones
> >> inserted, when resuming, the sound is not working anymore. Sound stops
> >> working on speakers and headphones. Reinsertion and removals of the
> >> headphone doesn't solve the problem.

> >> This seems to be caused by the fact
> >> that the GPIO IRQ stops working in es8316_irq() after resume.

> > That's a bug that should be fixed.

> Agreed, but I don't know how easy it is to fix, and I would like to
> first offer users of these laptops a working sound driver.
> Afterwards this issue can be analyzed and properly fixed.

Surely if nothing else a good first step would be to have the
CODEC driver do whatever disabling the jack does on suspend
without needing the machine driver to bodge things?

--pZnMYUgZ7ZDcg5Bx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQbctEACgkQJNaLcl1U
h9CSngf/VGQQgPsTs+Ok0ohatQmEmhxeehBDIScHFJ/0wlEFMpzy6WXr9xcN/C8P
lGJtD2RikJ423HM4rEtzq0DlG2aJXYJ7A52dsrWVT9hVj+5cgnIx7c+h5WoeRwTn
0OCUzvb//tBIDkkqK9mWEMj1Vv0KO8GAFKeLwo6tU8Ag0u9s+RRlQjY4k/k/JGOj
AOG4QVYsxgP3YQC8V7ldUwMLiKfFKPBkXp97/30jMEIlCY5EXkHnWra9JG5WcH9r
mLFKPePvZH2jbnXu2auZj/7ksXx60vQT7fr5e8p08nxk/amtGc8jsb0szpEo7/47
wuaf5Z6OGcxilwC7OHSRd/1etcOl0A==
=WEnp
-----END PGP SIGNATURE-----

--pZnMYUgZ7ZDcg5Bx--
