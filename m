Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707A173211C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjFOUzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFOUzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:55:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F37826AA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34B736144A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 20:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77ABC433C8;
        Thu, 15 Jun 2023 20:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686862509;
        bh=EnxEUlqn+J/nPD5pYPbVvgaiUr+J0w36obkpgcW6z3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrEYaJ4ZGXTIAz5yOg05F+KhyePCb+8dETrP39NHQGBefpSm863+WF7RZoiwlWigm
         psQD6OTPUiNT0PaxsumnUI+v5s7+Rk9cL0b3knlHo2YButXsSoLaqNU/FyQbFFbZxk
         oo6ftaWEhaz2cXOEYGirW2WRaJjkBuB5Hy4wnu1x4QqwCWc5TXZo28hNbqo2vP9MKG
         VTKHkRTaytagsy2snj7tQuLxmNvACCd/GtYXLc4sux+yE27ZOD9LUL/kpE3B1ADIS/
         X0Pi/su/uuhE5DiMXt7X+kDi6lzxqUhFgmCVFZ8wu5/jkNitl2X0EK2TrEg0j7sunj
         VJw6yfxTsQHDA==
Date:   Thu, 15 Jun 2023 21:55:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Konrad Dybcio <konradybcio@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] regmap: Check for register readability before checking
 cache during read
Message-ID: <274a7a7c-ca6c-44fe-8f7a-e19aaf86a86a@sirena.org.uk>
References: <20230613-b4-regmap-check-readability-before-cache-v1-1-b144c0b01ed9@kernel.org>
 <ea63420a-a08d-3610-b01f-61dabe56d2df@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pWr7QM6a1Q/bnGPH"
Content-Disposition: inline
In-Reply-To: <ea63420a-a08d-3610-b01f-61dabe56d2df@kernel.org>
X-Cookie: You are false data.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWr7QM6a1Q/bnGPH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 15, 2023 at 10:45:53PM +0200, Konrad Dybcio wrote:
> On 13.06.2023 22:07, Mark Brown wrote:
> > Ensure that we don't return a spurious cache hit for unreadable registers
> > (eg, with the flat cache which doesn't understand sparseness) by checking
> > for readability before we do a cache lookup.

> this patch breaks using regmap_field_force_write() on fields that are
> parts of registers marked as write-only (e.g. by regmap_access_table.no_ranges)

> Is that intended?

> What's the recommended fix?

Ugh, let's just drop it - it's just an optimisation.

--pWr7QM6a1Q/bnGPH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSLeqgACgkQJNaLcl1U
h9APfgf+NgEsBtwozjnOrmA9FCn/MC2Rx1p/fIKyit0rpv0+2i25lZqwWHoRZ3uu
nErEQ2Fif8fWFNpSVSzyBuBrI2Q4se+C+Huoi/G51jEo1jlgNB1WyA68aewFWguD
QHXRi1Vt5COUYZMDhAZC4/4V9Lxx3FVe8317YIOwGDiDSacuyh+1+9SpBvimX5rj
apGeYx5rTM74nKIZQMNncpu2oIVZ86HpjDdWpUJy9tDu4oiHPqdRGfv0/FBwm3gV
5Vui/RlF0HApanO13Fe34jqIlgByb2S8J+ZRyKDufmM8BN1JGPjJwmPVr1wjyjzI
hJ1u/bPENJQsOi7vlpOwIvHIE3vqoQ==
=dxCs
-----END PGP SIGNATURE-----

--pWr7QM6a1Q/bnGPH--
