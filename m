Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE372848E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjFHQEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjFHQEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:04:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495A335BD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:04:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2C8B64EC7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951DFC433EF;
        Thu,  8 Jun 2023 16:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686240249;
        bh=f9H+3yXxvwSmJGxKQ/DBjTp81E44oQegFdzLk3uPs8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YvxH00djkue9YGQvcVXdHTN7IjeZGU+vJ7p7BpnHdFKDRQ66oGKvdmFDhu11LotFl
         nz0olf0E4qyVQo/9Ro6hHrR3osNuU1meTlOPfNOsmWxDpEUFuozOOcNWWrmYF+8J3y
         4b96H3SVLLEgoNKHdG4F+QyGf3TntC+pWXsuVqE1SsexjwY6/YIWGeRCcBzSAkfl71
         lwIAorkWSHiwAcQlgExoH3nbSUY2afqpEEZ3CDB3RBuIpkUkL9xWUBmQRiISVrKjFr
         nEiIZIY8D1StbmgjTtoKOSSWT+B5lY7Tnl5h9fubzZLO5RMpykn30ivmva1TG9BAVi
         GCgY2G6SLUsdQ==
Date:   Thu, 8 Jun 2023 17:04:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] arm64/fpsimd: Exit streaming mode when flushing tasks
Message-ID: <f207f395-2fce-45da-a2ba-fba322fd226a@sirena.org.uk>
References: <20230607-arm64-flush-svcr-v1-1-7821a6199e0a@kernel.org>
 <ZIH4/kLTkvIN34FL@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+qV82rKrOrzP4fh4"
Content-Disposition: inline
In-Reply-To: <ZIH4/kLTkvIN34FL@FVFF77S0Q05N>
X-Cookie: Disk crisis, please clean up!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+qV82rKrOrzP4fh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 08, 2023 at 04:51:26PM +0100, Mark Rutland wrote:
> On Wed, Jun 07, 2023 at 09:30:51PM +0100, Mark Brown wrote:

> >  		fpsimd_flush_thread_vl(ARM64_VEC_SME);
> >  		current->thread.svcr = 0;
> > +		sme_smstop_sm();

> I don't think we should blindly do this if we never expect to get here in that
> state; this is just going to mask bugs and make them harder to debug going
> forwards.

> If we need this, it'd be better to have something like:

> 	if (WARN_ON_ONCE(sme_is_in_streaming_mode()))
> 		sme_smstop_sm();

> ... so that we can identify this case and fix it.

No, being here in streaming mode is valid so that check would be wrong -
if there is an issue the issue would be that we're expecting that any
further use of the register state would involve reloading from memory
but there would be some path where we end up doing something that uses
the in register state again rather than reloading.  The change ensures
that the saved and register states are in sync so that can't go wrong,
meaning we don't need to go confirm if there's such a path.

Though now I look again we should do a full SMSTOP since a similar
concern applies to ZA.

--+qV82rKrOrzP4fh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSB+/MACgkQJNaLcl1U
h9D30Qf9HNaYiNl8I7Jcf99d1m8KO85jAobhM+72SBTN8edbhJglkTc2mRy9i9gC
e7DwDnjgOvmYLziVhkhuDm+CnAserbwhmvpWWUS42+SKNL3Hl4MRKxvh5T+kYRk2
bblrSpGEA6S763mejnHcG2LkvYZvSuUhh59TdE2aRjqLuxykZhbrphFZK7N8NMYx
2kIf2eZGn1C/y8DqssVBkj9a6rFyTI2oDSqFkLBvcuapRlqUbQLQHpqPPl3FhWu3
kFRd0Xp91uzxc9OosBtRsCM6eqGy/1wF7TiL5UxabwOiEjSL71F6J+LMRtj+77HH
LeiuDhu2wzXKYMeN5mxXwl/K51X15Q==
=2Lv0
-----END PGP SIGNATURE-----

--+qV82rKrOrzP4fh4--
