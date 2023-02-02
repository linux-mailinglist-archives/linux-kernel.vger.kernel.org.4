Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FB368850B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjBBREm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjBBREj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:04:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075F22B2AA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 09:04:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A016F61C1D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 17:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0604C433EF;
        Thu,  2 Feb 2023 17:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675357478;
        bh=O+n0bScI1b+Csmx6NP1smlNv95Wxbe7eRqMRrzOG2Iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DECHE5pOMZozf21iVk83OAvCNUndcACIyeG6ZlHtEWgMmX0Ue6qfiSNi1WZwKJyEZ
         TB+VfmTuo8qJkPTtMCX44L7nV/DSEBhnJ3gH8JJVfu9vS1c0ISrc7LR3/oB2fEVG/5
         M+rWU6llXCSrL2soZ6lolUdPTZSsjpAYrwUmZY/LwYRwLyGvV7M/Vu1q3E/9p6J3La
         CKnGRor4P5m5rV1RY8VmARVNFvyfZQjxD1JHKwLza20DvWZlxoBC+TmebhipJF/m5c
         cZRWVPxanvYKVK8fisJ8z2U87c21csQlyY1dktgmHhJelQ4xjU4Z6LdO6E88bpLOBS
         HC+/VZY59Ha9g==
Date:   Thu, 2 Feb 2023 17:04:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Rau <david.rau.zg@renesas.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Message-ID: <Y9vtIISfmpICi+9u@sirena.org.uk>
References: <20221121050744.2278-1-david.rau.zg@renesas.com>
 <20230117195645.GA83401@roeck-us.net>
 <OS3PR01MB66416CEF9F6E5AE62D194BACCDC49@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <20230119161221.GA981953@roeck-us.net>
 <OS3PR01MB66416C10BF8E6400C84DAD02CDD09@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <38f09c4d-70d1-f65f-6e9b-4ad84eda4059@roeck-us.net>
 <Y9kE1cSUg2CQM5vq@sirena.org.uk>
 <20230202155101.GB1373010@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SmIgde9nY4pmZ7FZ"
Content-Disposition: inline
In-Reply-To: <20230202155101.GB1373010@roeck-us.net>
X-Cookie: Swim at your own risk.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SmIgde9nY4pmZ7FZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2023 at 07:51:01AM -0800, Guenter Roeck wrote:
> On Tue, Jan 31, 2023 at 12:08:53PM +0000, Mark Brown wrote:
> > On Mon, Jan 30, 2023 at 10:16:06PM -0800, Guenter Roeck wrote:

> > > I'll see if I can implement a downstream fix.

> > If you implement something I don't see a reason not to post it upstream.

> I had a look into the code, and concluded that it is too complex for anyone
> who doesn't know it to find a proper fix. For example, for an outsider it

It's definitely unclear, there's a datasheet at [1] which does appear to
explicitly call for a 512ms delay though (see figure 20 on page 50).  It
does look like it should only be applied in the case where an inserted
jack is detected (ie, when identifying an accessory or button press) and
not when removal is detected though.

> is not conceivable (or explained) why the ground switch is enabled only
> to be disabled immediately afterwards if a jack was removed.

It smells like there's a power benefit to leaving it disabled when
unplugged (which seems plausible), and possibly like the detection is
more stable with the ground switch enabled.  The ground switch is not
documented AFAICT (it's in register 0xfb which isn't named and doesn't
appear to appear in the datsheet from a quick search).  The code is
leaving the switch enabled so long as an accessory is plugged.

> This is now the top crash reason on affected Chromebooks (so far I
> identified Asus C424, HP SeaStar, and HP StingRay) with this patch
> applied. I am inclined to revert it from all ChromeOS kernel branches.
> At least for us the cure for the problem is much worse than the problem
> itself.

Are you saying this is actually crashing, or just that you're getting
warnings about threads being blocked for too long (that was what was
posted earlier in the thread)?  The only things I can see that look like
they have the potential to actually lock up are the cancel_work_sync()
calls but they were unchanged and the backtrace you showed was showing
the thread in the msleep().  My guess would be that you've got systems
where there are very frequent jack detection events (potentiallly with
broken accessories, or possibly due to the ground switch putting things
into the wrong priority) and that the interrupt is firing again as soon
as the thread unmasks the primary interrupt which means it never
actually stops running.

It's possible that reordering things so that the delay is only applied
if DA7219_JACK_INSERTION_STS_MASK is set would help, that'd need some
motion of the interrupt acking as well.  That's probably a good idea in
general, it's what the datasheet seems to call for and would lead to
prompter removal detection.  However if the issue is systems with broken
accessories constantly firing spurious button events they'd still be
seeing the delay.

My other guess would be that moving the delay that's been added to a
delayed work would avoid the warnings, though you might want to manually
keep the physical interrupt disabled while that's running which is fun.
Possibly also tuning down the delay given that as you say 500ms is
rather a long potential delay even in the context of jack debounces,
though if it is bad accessories then there's probably a bit of luck
involved in the original code not triggering issues and any debounce is
likely to cause fun, and like I say the datasheet does seem to say that
this is the appropriate delay.

You'd end up with something along the lines of

	disable_irq();
	schedule_delayed_work(delay, current_irq_code);

in the IRQ handler then call enable_irq() on the way out of the new
delayed_work.  That would keep the same flow but not look like the task
is running which should avoid setting off the hung task alarm.

[1] https://www.renesas.com/us/en/document/dst/da7219-datasheet?r=1563341

--SmIgde9nY4pmZ7FZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPb7R8ACgkQJNaLcl1U
h9Dftwf8CEeKBxOBN+LR391T+vfagYayeUgWpszKvH+RTKbdwHTojhO+dbenXF1c
d+7JKOcfvFhI8TEBhW+PcUri3v/8kBQoYz5drbzLHUt3mryXvn2pfXmvx7Uf0wjj
US/5UO3btNTAuDKWS8x54NPVk63vLib0SBHLAII90pv8xh23sivOD+c3qan9KOTR
5s8qD/BlK/Cd3ePv7/Wlyy/lnHvR6kJYHVR/Ml9XnPvxtdGm9ny3kVBnLCJ+/pNf
9hhvPLVk3tt9d15r8d+w7630c2e7Zjdrp4eYeKZyBqNEDB+ByeDLRHiQlTwIfBIf
NxNU1ulQGiB909PyOt26k3B84A1hkw==
=PcdV
-----END PGP SIGNATURE-----

--SmIgde9nY4pmZ7FZ--
