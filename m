Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9AD72E79D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242956AbjFMPt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243004AbjFMPts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:49:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038A5199
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:49:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12E74633E4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352E3C433D9;
        Tue, 13 Jun 2023 15:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686671386;
        bh=6y3uIMQHh3Xh+Bv9AjWdmW0QTyRI/YTcLq3CZoYBOqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q68y5fp56nvCLUE37GtkHpPEZ5BVQG0cIZYIrpnqql2r6klc+YmEyR0o6hF87p65/
         8AuUjx2ZqVe2i5OLjmkKV01YvAPsuCpweiQPxdsM3K/LlucnOt33qpUIYCQT2nOPBM
         FLXQI+jDdnzxo5y/OBc8/hDh7m7g+ufNWk7hHAh6y5qHUnnAbQAsYmg9uZBz9pixcO
         tNxdLRl9YGRBslp1yAhIKHJFpoYstI/wrgT2Hpbbq5yk5tFeSm9bkaB4au25sIfnk9
         K40luedlbhHg+NKp+I1emUfQ9XszuLT9gkc+ythM/UnkXi6eecOD1gnIuTfgkIhBPI
         NzAgORb5gNQzw==
Date:   Tue, 13 Jun 2023 16:49:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Use maple tree register cache
Message-ID: <60f70667-16b0-4071-aa0f-a83e43bbf2a0@sirena.org.uk>
References: <20230609-alsa-hda-maple-v1-1-a2b725c8b8f5@kernel.org>
 <87v8fua1qm.wl-tiwai@suse.de>
 <877cs7g6f1.wl-tiwai@suse.de>
 <e48bbd3b-544d-43d5-82a1-8fbbcb8cd1a4@sirena.org.uk>
 <87v8frcueb.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MFURhVHYtC0zxDNS"
Content-Disposition: inline
In-Reply-To: <87v8frcueb.wl-tiwai@suse.de>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MFURhVHYtC0zxDNS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2023 at 04:24:28PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > BTW I was just looking at reg_raw_update_once() and I can't figure out
> > why it's trying to do what it's doing - it does a read to check if it's
> > seen the register before and then does an _update_bits() if the register
> > hasn't been cached yet, apparently trying suppress duplicate writes but
> > possibly deliberately discarding changes to multiple bitfields in the
> > same register.  That's not what the non-regmap path does, it'll only
> > discard noop changes to the same bitfield.

> Yes, it's a quite hackish way of optimization of the initialization.

> Since HD-audio codec has no known default values unlike normal codecs,
> it needs to initialize itself only at the first access, and this
> helper does it.

Ah, if it's just suppressing the write the code should just be removed.
regmap_update_bits() already suppresses noop writes so unless we might
write a different value to the register later the effect will be the
same.  I can send a patch.

--MFURhVHYtC0zxDNS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSIkBUACgkQJNaLcl1U
h9AT6gf8Dy9pHA3YE2wF963NjaOfpfoWJmQ8BzJnV72kAvR+CEl+SR0lmgOk8wqF
gS/B69Kd+VGjm0yQJF+ewRNM0j30penApfD1viKUEB+uIpcj4eTP8e9WVRNU+t+1
Uh1Nc/1G/szZFAtv4N/I+k3I/MJSLaKPiJuB6yXBtJStmKZjnxCEj8yJSA4Ei+sA
/o2oADTCY2HAggZknctLJt7Jpd6wMUtMYxwd1niKRlJ3gasQ8orSGivZS+919xW7
t3e9u4sX7t1lyKQToY+Eintx2Uo/ZdZpuCxQxkt7fd/Chy4SAoAR6o3zOC3OjD8p
TG/68NjIRFUmTYCNpFlFjblovjUZ7g==
=cAOZ
-----END PGP SIGNATURE-----

--MFURhVHYtC0zxDNS--
