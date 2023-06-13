Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D3F72E03E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbjFMK7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239776AbjFMK7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:59:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B0B10DE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B5D5634BB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4257C433D2;
        Tue, 13 Jun 2023 10:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686653971;
        bh=/Bfwify/pN+EHLRwOguUkUl5GSv7oUhAl96UexPlNTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sebVX+gknxO4V7hjYXlVEKHloNueXtGxOr8NBU/dQFj6Y8BYrb4sG4LdPf1g7N8WA
         3UuXpO50tdtM5FDJCz0pAZ45/zACbgva6bNZAtJtheCIxqo9tlsPRn3J/U7muageIB
         fiUBnYCQtFdk2NPnT++VU6sP2W540W7Cpg2trpXlOlxxNARy3We8kKesv1zPAG2ZBh
         0xzWrB5zn171WOBzlbzdxc+koXVMpLm8nan1EnBoFnsf4r0hudjaobPl9wO8jsFMvD
         MGrtpA2ijVbyDAN/aKA3T8s84+uIyE8BPbv5JylrK7e2AViS4kyXiSNLuCDbwf6D7c
         Lcak1KWvt0OSg==
Date:   Tue, 13 Jun 2023 11:59:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] regmap: maple: Don't sync read-only registers
Message-ID: <e04053b2-897c-46fa-bd1f-e455e01c6152@sirena.org.uk>
References: <20230613074511.4476-1-tiwai@suse.de>
 <b86f7b95-f116-4d06-9aca-7195b01dffab@sirena.org.uk>
 <87ilbrejlm.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h+jgtpBxK4g6svrk"
Content-Disposition: inline
In-Reply-To: <87ilbrejlm.wl-tiwai@suse.de>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h+jgtpBxK4g6svrk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2023 at 12:34:45PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Tue, Jun 13, 2023 at 09:45:11AM +0200, Takashi Iwai wrote:

> > This should be in _needs_sync().

> I thought it's a different logic?  regacahe_reg_needs_sync() checks
> only whether it's a default value, and other call paths already check
> regmap_writeable().

Yeah, but it feels like that's the reason we ran into this issue given
that you'd expect _needs_sync() to check this too.

> But I can put the check there instead if you still prefer, too.

It should avoid any similar issues in future.

--h+jgtpBxK4g6svrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSITA4ACgkQJNaLcl1U
h9DhLAf/R3bmLGw2qE3Owpg/IK76UR+MoYy36seq2EfEJSTyWeo0N/ZBuKMpLD0J
NVsVkqZ465pPjJrdpSDHh7996Iq5MzJlFlk7uqvs/3tmTOPIp77XoFYHE8i8uiN3
6GpGRY9HhPkwU+YPHKkMMXA58bFdAgfo2fjr9QDDnYu0WvdNkkj8rArosk2pycC3
hZiavqs5jionbZFQc9sdFzDGMQ6GW0UL9cIExPA6GmbURjwBAK+B1TPbZdZ+nB1K
yFN8Bhdc9CE2Ws9iM6CBk9pSSLPmd3W0wtcbtm/bU1ZZZxglIAuL5vGN2P5E5GYG
/7ZwAEimeUz+jTmSCwcsxcnK9uo+wg==
=oLmI
-----END PGP SIGNATURE-----

--h+jgtpBxK4g6svrk--
