Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923BF728727
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjFHS05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjFHS0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:26:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF47C3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 11:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86EEF63D63
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DAAC433D2;
        Thu,  8 Jun 2023 18:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686248809;
        bh=gmE8jvKLyhmikJ5KyPqv8k92Y0DC+gclA/sxByU2jBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dk4yxsEzOooNSGrsZc4mQQbvEXgGxljeELTCqr3qm0RrTpHEyBFeH32B6T3EqpESg
         MZt9C1nn3mG7RgPqiM5aMuhbcbCRTbY0Rf8X0OkOWBEHRnJXmpe1sXZCHvjtVixveD
         1sEHWxsLtKN1A2OBiKySniQl2hTampCoI4l0e/P9we9jHyG6Bl7oYQVQZd9q6dTRI0
         daJmOyCi1t92ttWHUDQUynibz2bPWIekich+EMzBCb57EoX6h2uu04ucXyQfNu3bmB
         4IWaz5762+I+s0DtTXkJ7tT9sGncQX/0vVdtrvRKFrs48SZW1hMmExeCH37WQdkze4
         LEJmEnaa/SoZw==
Date:   Thu, 8 Jun 2023 19:26:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] block: fix rootwait=
Message-ID: <aab7ae20-d36a-47cf-bc1a-9590c3d8b3b7@sirena.org.uk>
References: <20230607135746.92995-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aQ9yJ0P2gFtj9aEc"
Content-Disposition: inline
In-Reply-To: <20230607135746.92995-1-hch@lst.de>
X-Cookie: You have a truly strong individuality.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aQ9yJ0P2gFtj9aEc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 07, 2023 at 03:57:46PM +0200, Christoph Hellwig wrote:

> Failures to look up the gendisk must return -ENODEV so that rootwait
> retries the lookup instead of -EINVAL which exits early.

This appears to be causing failures to find a root filesystem located on
a partition on a virtio device virtio-blk when booting on Arm FVP
virtual platforms on today's -next.  With root=/dev/vda1 we find the
device:

[    0.593310] virtio_blk virtio0: 1/0/0 default/read/poll queues
[    0.594413] virtio_blk virtio0: [vda] 2929688 512-byte logical blocks (1.50 GB/1.40 GiB)
[    0.598898]  vda: vda1

but then when it comes time to mount the rootfs we get:

[    1.035643] Waiting for root device /dev/vda1...

instead of mounting the device we already knew about.  A bisect (log
below) lands on this commit and reverting the first hunk:

> @@ -181,7 +181,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
>         *p = '\0';
>         *devt = blk_lookup_devt(s, part);
>         if (*devt)
> -               return 0;
> +               return -ENODEV;

avoids the issue and allows us to boot as normal.  I need to stare at
the code a bit more to fully follow the intent of that bit of the change
but I'm about done for today, the commit log just mentions replacing
-EINVAL rather than 0.

Bisect log:

git bisect start
# bad: [db10f126048021b86e43a5d6a335ec49dec10155] Add linux-next specific files for 20230608
git bisect bad db10f126048021b86e43a5d6a335ec49dec10155
# good: [5f63595ebd82f56a2dd36ca013dd7f5ff2e2416a] Merge tag 'input-for-v6.4-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
git bisect good 5f63595ebd82f56a2dd36ca013dd7f5ff2e2416a
# good: [dc3648f0663a83e9399f44faa473ce8891f8a469] Merge branch 'drm-next' of git://git.freedesktop.org/git/drm/drm.git
git bisect good dc3648f0663a83e9399f44faa473ce8891f8a469
# bad: [80f5925ba46062fd05697d83717d67162ae18812] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
git bisect bad 80f5925ba46062fd05697d83717d67162ae18812
# good: [2c5161ad2db3e89b608b89e4994e23ab58db7162] Merge branch 'for-linux-next' of git://anongit.freedesktop.org/drm-intel
git bisect good 2c5161ad2db3e89b608b89e4994e23ab58db7162
# good: [0e425a6896902e0112a4da8cbf71c067ec6d6d8f] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git bisect good 0e425a6896902e0112a4da8cbf71c067ec6d6d8f
# good: [2dc4eeb36feb4b5baae9ec9ef145c974007d94b8] Merge branch 'for-6.5/block' into for-next
git bisect good 2dc4eeb36feb4b5baae9ec9ef145c974007d94b8
# bad: [e0e9727312109e289bcce88bbd2bbe86b9a209ca] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
git bisect bad e0e9727312109e289bcce88bbd2bbe86b9a209ca
# good: [182faecd1a321d626190cb7e87d814da04c2a083] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
git bisect good 182faecd1a321d626190cb7e87d814da04c2a083
# bad: [f3e6f4e23cc82971bda01ef5cacb716fb564c7aa] Merge branch 'for-6.5/io_uring' into for-next
git bisect bad f3e6f4e23cc82971bda01ef5cacb716fb564c7aa
# bad: [80d994d2a71f88e0809dcaccef2259c791d2e3ef] pktcdvd: Use DEFINE_SHOW_ATTRIBUTE() to simplify code
git bisect bad 80d994d2a71f88e0809dcaccef2259c791d2e3ef
# bad: [3a41db531e5124adaa3a9ab9ca0c724aee85b10c] pktcdvd: Get rid of custom printing macros
git bisect bad 3a41db531e5124adaa3a9ab9ca0c724aee85b10c
# good: [a7cfa0af0c88353b4eb59db5a2a0fbe35329b3f9] blk-ioc: fix recursive spin_lock/unlock_irq() in ioc_clear_queue()
git bisect good a7cfa0af0c88353b4eb59db5a2a0fbe35329b3f9
# bad: [1341c7d2ccf42ed91aea80b8579d35bc1ea381e2] block: fix rootwait=
git bisect bad 1341c7d2ccf42ed91aea80b8579d35bc1ea381e2
# good: [3d2af77e31ade05ff7ccc3658c3635ec1bea0979] blk-cgroup: Reinit blkg_iostat_set after clearing in blkcg_reset_stats()
git bisect good 3d2af77e31ade05ff7ccc3658c3635ec1bea0979
# first bad commit: [1341c7d2ccf42ed91aea80b8579d35bc1ea381e2] block: fix rootwait=

--aQ9yJ0P2gFtj9aEc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSCHWQACgkQJNaLcl1U
h9CB3wf+NZ8PaewE5bRCQKXskuC1z9hCpcqK8ghMUvIOntzyRoDQ44TC87K3OTeR
Eq9Y78/tj95FHTb3xJfZsX73RGcmySkrqptK7/Yox9c0XimUBsx1k7tzpmwyIwVA
RW/+ouPnlaBw7Gr8tbVThup982naCDIpUGJnJeahx2v5qJlmoUrQNVbULez69T07
/4rE2oEBpNXAqCCmraPrZZKkH2YTWSGRdX958GFdNLn+kgPowOxARaIzumG31jOT
qU7RXut9sTyXhw+N+L5aCbhUCgKdOEg9RPtTOrGmwIEc9B0mRC+OrrR2+Nr0pz5b
89uKJOw+WdGfbL3Nlu10Y5FGEhrcbA==
=InQC
-----END PGP SIGNATURE-----

--aQ9yJ0P2gFtj9aEc--
