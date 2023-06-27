Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FF873FB86
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjF0L6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjF0L6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:58:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2653010FC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:58:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71D1261191
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8C8C433C8;
        Tue, 27 Jun 2023 11:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687867128;
        bh=W+eyB9v7ItklUr+kuqjiKNtG3VKl8hIObwsAcuDXFAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s6xQ+C6+d/Dw2Yel+nFePKC7s4eZUCztDPhu8oDiTcsxujUT1C8ThUeeGeRC2Ibsc
         ZchMGGf75U1GK2Cj3NcJRtbzzg6QnD/M8KzzwHHlLJN6//Tx1nj7mbT0MN16J49dmD
         N8JHpJa0MkC7Gc9yNsM08/ffD7dNwrE5ySA6vHiHR+GPkZahX0lEqNDIR5qACOEgDv
         lMS2ZIFqRHT7wj6zhsw5ek3kcRbrCtgDO5aKpZP3jXlEFaplK4wIgAJlAwyyYrQMXg
         Irbuven/SpEbwnCSHXFxktn2ZjqBJCU0ryVS5/P7wNKVqiCQU1FmbTH8zu+Xig7g8/
         PjYVl3PRHg38g==
Date:   Tue, 27 Jun 2023 12:58:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Jim Wylder <jwylder@google.com>,
        Russ Weight <russell.h.weight@intel.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, matthew.gerlach@linux.intel.com
Subject: Re: [PATCH 1/1] regmap: spi-avmm: Fix regmap_bus max_raw_write
Message-ID: <4fac60f2-ae53-4735-a847-6ebd3e824c61@sirena.org.uk>
References: <20230620202824.380313-1-russell.h.weight@intel.com>
 <ZJfB9zXhizbqmIrm@yilunxu-OptiPlex-7050>
 <c5c95368-eac3-4250-b50a-50f0a526b753@sirena.org.uk>
 <CAEP57O-EsrW0KgSDDnDDEYrvL-SEtO-Ji6oShNzvP3y0o9AqCw@mail.gmail.com>
 <ZJpZJhostb4G1UMt@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mVOP92SZIrht49D6"
Content-Disposition: inline
In-Reply-To: <ZJpZJhostb4G1UMt@yilunxu-OptiPlex-7050>
X-Cookie: Money is the root of all wealth.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mVOP92SZIrht49D6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 27, 2023 at 11:36:06AM +0800, Xu Yilun wrote:

> I'm a bit prefer to exclude the reg addr, as it is in stable tree now
> and doesn't see strong reason to change it. And suggest regmap-i2c does
> the same as spi do, that is to reserve space for reg addr/padding by
> reducing the max_raw_read/write value, see:

It seems better to keep things like this in the core since every time a
bus has to open code something that's something that the bus can get
wrong, as we've seen here.  This would mean some churn now but going
forwards it'd be less error prone.

--mVOP92SZIrht49D6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSazvMACgkQJNaLcl1U
h9D/Vwf+Jeeen0HBG97mDIfJfSL9gm7Ujsp3364y3g3OplWBpf3Nh2zqeHWO7vFb
2jmohhgNatNtnF3pnaAXJ3eNdsHEKcne86zTSixSUYfoYaJDmS/CLWzI4RfMJ7uS
bSyecAagbkGUGuNQoVf7ATfLLx1m/J1VUu8xwSXr1zU+Gtya7/CAwVMc8Zz/pSF5
zWmj9DX9p0KyHeZ5PSNfWTmYM+k5ETxPgH8konrnRiT3KAhrCG64Zupfwwcx2y4s
RNwuF/KqeuW17jMxu8a2e8WN9vN1OYWUkq7GKYJ1qmjiKVcpDZue4+uP3HE2fyT4
9hgqDFkOMxzXKRl7YajIzZltvmtK7w==
=/rAG
-----END PGP SIGNATURE-----

--mVOP92SZIrht49D6--
