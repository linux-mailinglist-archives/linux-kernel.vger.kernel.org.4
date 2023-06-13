Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3540B72E8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjFMQlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjFMQlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:41:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983F710F7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:41:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 896916386D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6ABFC433D9;
        Tue, 13 Jun 2023 16:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686674480;
        bh=v8zZHGVC82PBfUYoSB6keV2P14ZvTtaoalbMHZyNcMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hjoex1jAVU2+UpyM65EDyOPodF8LaEw21LLINKzgj70i7ayz4V7rcce0M1XfzV8/K
         XRefFqnlb0LA4dswZyXhS/agMa+9sbnev5BD4untQ3k4+BxubCniGGSmf6HUfN1Nvr
         rAvDUAm5O3rnNNe+41OC7gzrvQtCLUcG6XZ/vNG9XVxXoGyKndTAgmGnSQFcaOKXtV
         /UX1eMSNL2GHIZEq2TfnhH6mhxmoQjmr/NddWNu8jNXj5Dtvu3veGgYthhW3NzWe9i
         +Skvwbk9SLqJuQiAmPSOSoGG5HiqQDDPDSBIM/Ldpgzlva5ECZ3uHfc82UuDCUb70n
         okTZHPasd2RgQ==
Date:   Tue, 13 Jun 2023 17:41:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Use maple tree register cache
Message-ID: <18bcfcba-a6ce-4595-bd2b-4d4ba761fd58@sirena.org.uk>
References: <20230609-alsa-hda-maple-v1-1-a2b725c8b8f5@kernel.org>
 <87v8fua1qm.wl-tiwai@suse.de>
 <877cs7g6f1.wl-tiwai@suse.de>
 <e48bbd3b-544d-43d5-82a1-8fbbcb8cd1a4@sirena.org.uk>
 <87v8frcueb.wl-tiwai@suse.de>
 <60f70667-16b0-4071-aa0f-a83e43bbf2a0@sirena.org.uk>
 <87a5x3cp9r.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DL3D8ElAXVMbfhcB"
Content-Disposition: inline
In-Reply-To: <87a5x3cp9r.wl-tiwai@suse.de>
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


--DL3D8ElAXVMbfhcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2023 at 06:15:12PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Tue, Jun 13, 2023 at 04:24:28PM +0200, Takashi Iwai wrote:

> > > Since HD-audio codec has no known default values unlike normal codecs,
> > > it needs to initialize itself only at the first access, and this
> > > helper does it.

> > Ah, if it's just suppressing the write the code should just be removed.
> > regmap_update_bits() already suppresses noop writes so unless we might
> > write a different value to the register later the effect will be the
> > same.  I can send a patch.

> Oh, I'm afraid that we're seeing different things.  The code there is
> rather to *set* some initial value for each amp register (but only
> once), and it's not about optimization for writing a same value
> again.

> That is, the function helps to set an initial (mute) value on each amp
> when the driver parses the topology and finds an amp.  But if the
> driver already has parsed this amp beforehand by other paths, it skips
> the initialization, as the other path may have already unmuted the
> amp.

> Or I might have misunderstood what you mean about _update_bits()...

So it is possible that we might set two distinct values during setup
then and we're doing this intentionally?  It's not obvious that this
might happen.  A comment wouldn't hurt, and a big part of this is
confusing is that in the non-regmap case all we're doing is suppressing
duplicate writes, in that path it's just checking for changes in the
register value.

None of this is what the non-regmap path does, it just suppresses noop
writes to the hardware.

--DL3D8ElAXVMbfhcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSInCoACgkQJNaLcl1U
h9Cupgf/fCfGNrjBuCwi0HFbU+sF01lqVpZ/K8KgOXR1+Vm4SY74+qskM1B8pGMt
vjQIXMHy0tJaNBTGguZKFwXyk437A8lyZz0PncVJ77AX979DzQedxVowx+42NWBc
iJ5/qEEaWkwPloOow10gbRYN0GQqTvEEnf3Sr3JCqOmpMX/wIT8WVgkHMF7QZyNT
T7rl9SQATqxTiHvbRdZnLsP5q+XokcC58usEhgWy51KIzJbcbfWXdLWKB76L8/vw
GxAg+TKnyYO3/DWY6bBtxw7jLLGmJsdnNM8osURlW9SbEwVp4nKsz9f1iOyiNVmX
2H8vNN4PpZaoz4DjBpPjzuc2YG3Z2w==
=8X4L
-----END PGP SIGNATURE-----

--DL3D8ElAXVMbfhcB--
