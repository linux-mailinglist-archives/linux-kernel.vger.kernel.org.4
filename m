Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C5A6C3815
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCURVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCURVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:21:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9712C311D7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:21:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CE78B818FF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 17:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF6AC4339B;
        Tue, 21 Mar 2023 17:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679419288;
        bh=zgTHrxXgfF59J+d9taf5zXXMOLYG3apCi7j7rkTOU70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qs9AvSrCqAMOAWzdXzibR6qQlQlM5EBVg2qvVn719h6FxpNItyMGzoR7jBmZtq1e6
         9JOXtpAbvfQC8HvXx2h+RqzsCwibxACNZgaZZOvSF70X4ZstqD6hYd7BSQA0Jstvwc
         NWFtE3a+dx+Jh59l0Xn3zzTwDtY1C6uknFQJBjVSOMRrfY6sqnW3n0DBYThCFVkfAY
         sstoHuZSF1LVk9ZRr2pzOFW/RDaeqivhPjc6Oqi4GNCoOR1hCjTAIzL8LCV8m0zpfj
         QGESSGOHBuC50iN/Dy/QXo/LQ48EOI7VJMKNubusHnI2bksRI3uMIP/Ob7DuKOFnf7
         vvent8cKPRCLw==
Date:   Tue, 21 Mar 2023 17:21:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     zhuning@everest-semi.com, yangxiaohua@everest-semi.com,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/4] ASoC: es8316: Enable support for S32 LE format and
 MCLK div by 2
Message-ID: <ab2f5d31-2797-427c-9c4c-1d0166018a2d@sirena.org.uk>
References: <20230320203519.20137-1-posteuca@mutex.one>
 <20230320203519.20137-2-posteuca@mutex.one>
 <6825a54e-f2c0-41c4-981c-fafcd10454fd@sirena.org.uk>
 <87o7omvxns.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/N4FohmuSkAWokHz"
Content-Disposition: inline
In-Reply-To: <87o7omvxns.fsf@mutex.one>
X-Cookie: Will it improve my CASH FLOW?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/N4FohmuSkAWokHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 21, 2023 at 07:09:43PM +0200, Marian Postevca wrote:
> Mark Brown <broonie@kernel.org> writes:
> > On Mon, Mar 20, 2023 at 10:35:16PM +0200, Marian Postevca wrote:

> > This introduces a DT property but there's no documentation for it, but I
> > don't see why we'd want this in the bindings - the driver should be able
> > to tell from the input clock rate and required output/internal clocks if
> > it needs to divide MCLK.

> The problem here is that I have no knowledge what is the maximum MCLK
> that the codec accepts. According to the datasheet the maximum supported
> frequency of MCLK is 51.2 Mhz. But this doesn't seem to be the case in
> practice since a MCLK of 48Mhz causes noises in the sound output.
> The idea to divide the MCLK by 2 was proposed by a Everest Semiconductor
> engineer.
> So I don't know how to make this generic enough to be activated from the
> codec driver.

The usual constraint would be that MCLK can be at most some multiple of
LRCLK or something similar (are all the other dividers in the chip set
sensibly for the full scale MCLK?).  In any case you're clearly aware of
a specific case where it needs to be divided down which can be
identified even if you're concerned about dividing down for other cases.

--/N4FohmuSkAWokHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQZ55IACgkQJNaLcl1U
h9BRNwf/enfamwGA+bFuLN4JarnDOoeq63H5NfeuP7o4LBw3WpvjiXhv6WkFNYkT
Xm76+yP16XFfTkW/DADzJMydsnD2QY+S0OlFgoRDrBoa/eVXfJC4K7wT66+LHcSx
afreEzw253YAXMiBB1jNwRxv6Tnu9ug9iLlRzGc9tmvzrPZAnS5BqRcS5LnZaH0W
7qAif6zk0rldbnovVW2dtAIZNOxgJ8jYD44nEfz5zHxiyRtQknAVVdALP/L7blTd
AvKzX1s2/mMufD4z/+wBLpZ/GsRsN3rzYd6/nft/7Kvh1jjHe8HiTuzgNj2LKz45
4pMXK/j3SOtXh9p1F90kn7Lz9JYepA==
=qzEz
-----END PGP SIGNATURE-----

--/N4FohmuSkAWokHz--
