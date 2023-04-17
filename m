Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C226E4F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjDQRrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjDQRrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5D86E93
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A859062598
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 17:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AAAC433EF;
        Mon, 17 Apr 2023 17:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681753620;
        bh=UumL3AR5cGnsjet1Ca8z1G6hDhRj1HkmJ8fDNPrLm7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bdx041Ptx6nbYd7T4nrf6mfXp93+2+GgsJOyR1ea9KCQ5pKd6Zl7Zo/84NappJoxt
         X30h+ss1L5OC9naLW0k5Hw0bQO4RF75fnFKFLUfpD6Dj68cgIeh4RGCcniJUJhIGzq
         JnjGhN3t+z3LXlgqk5xQVM7YIGvy71MMu3um6fBkd1hPOA9xP3bS05j09eBQPTB0jJ
         awwuJeVatmHSZ/LfKyh7B8dwPgUxpLARD2WYucgyN1y7dcFm9Mo9eM+6PBpb+5UUlH
         ja5QJrteV7+UkLwuYM0C1FsLA/inajHXY8T1CtaIpay4KXfsxzSOYTdyUanrRBNG3o
         mLJcXS2fy17WQ==
Date:   Mon, 17 Apr 2023 18:46:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: codecs: wcd934x: Simplify with dev_err_probe
Message-ID: <d17093ae-6c3f-4426-974b-c9f9a8c32e10@sirena.org.uk>
References: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
 <20230417141453.919158-2-krzysztof.kozlowski@linaro.org>
 <20aa9662-9cbb-4fbe-b6ed-3a6ba33e820a@sirena.org.uk>
 <c294d672-c2fa-7468-f02d-18d5230a1d95@linaro.org>
 <5d753a8a-b979-43f6-a403-8a51f69bac29@sirena.org.uk>
 <752c2dc1-65a9-a74a-d9ce-7db5ddbea5f8@linaro.org>
 <80be967f-b831-4a73-8474-09bb96bd2c32@sirena.org.uk>
 <1cc83bad-55c2-46b5-ad70-cac160b842c1@linaro.org>
 <7da0f237-b4ba-4c66-8061-a14c09a1e7a5@sirena.org.uk>
 <45907ab4-ad1d-b4ff-a5b5-40e9bfc44e8d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="orgSy6EAXUzq+s5o"
Content-Disposition: inline
In-Reply-To: <45907ab4-ad1d-b4ff-a5b5-40e9bfc44e8d@linaro.org>
X-Cookie: Two heads are more numerous than one.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--orgSy6EAXUzq+s5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 17, 2023 at 07:30:35PM +0200, Krzysztof Kozlowski wrote:
> On 17/04/2023 19:23, Mark Brown wrote:
> > On Mon, Apr 17, 2023 at 06:32:07PM +0200, Krzysztof Kozlowski wrote:

> >> If you prefer, I can mention the message/EPROBE_DEFER difference in
> >> commit msgs.

> > I know you prefer to maintain exacting standards in these areas.

> I don't understand what do you mean here. Do you wish me to re-phrase
> the commit msg or change something in the code?

Your commit message does not accurately describe the change the patch
makes, it should do so.

--orgSy6EAXUzq+s5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ9hg4ACgkQJNaLcl1U
h9C/cwf8C8PChuzz40kFfDSjF/vdejRXHYYpafw0q6gvpyLrp6azZO+DUtN/fCFh
h2pAAmfULIzRbtTZuoyT9xt0ujyvIz9SpbXdrbBVw1ifhXi0fB+a9KiJcyA54j/F
2upz8mCEtdQ1zr/ERpitk0FghkQaxoWlVQ8e5kPVghyx1bFUuHxC24sUIlw2jZP1
8EhUJxLJ04x8Z0b5dHKt7k3P9cypoiprrhV4pJJGMNppdntQYHI+KMiWPp4z+RAB
lg2QKlO1Sk707Kq9tgWzXa2eJZZXReowVotCAB0tU0keJXYJj+cesgpf7FX2iXYa
I1nMewkAoqXrTKP0PAGtKT/4jbpXng==
=z0j8
-----END PGP SIGNATURE-----

--orgSy6EAXUzq+s5o--
