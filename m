Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CFD70E2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbjEWQ6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjEWQ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:58:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A5FC2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:58:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C96E634B0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0C8C433EF;
        Tue, 23 May 2023 16:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684861087;
        bh=ZOgRWSUZeAQRQ5r1OvrZ23h8E9WcL1BECJs8FsCwu4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OkVDIoD4tEZoLdZ/xUfE9c+NUefU1OXooZ6auYkikWy6kMyqxJ0YfM/3oeOMdICLB
         N71Z05lVrelwQcnV0tTYQNrwylc8R3oER3PixagiICfpxB8wRdfD2ZHT05b+DjqGTg
         WRq1Ldi65dSA5GhYYuXKGrUavb62X9tFFTy6tjgo0H4RoLGCKTnNpP1+DKw0UbiPbp
         l9FrvjrSCFXD+xAi/+SerSyMRUiL6yhHtzsopL4zFam/qUaoeYVLbqgwq1bM+Z/4/S
         zckmWsg0rZxyhB16hRhBE6U3QlOhxEyw3lVQ0KNJu5TjEmAaUTkDfKyccFwvMAfuyp
         15JnQwxRWAYgw==
Date:   Tue, 23 May 2023 17:58:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        ckeepax@opensource.cirrus.com, tanureal@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] regmap: sdw: check for invalid multi-register writes
 config
Message-ID: <dd2d2484-13f9-4fa6-85d2-5a540f137b3a@sirena.org.uk>
References: <20230523154747.5429-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KttESI1M0xs/s7UC"
Content-Disposition: inline
In-Reply-To: <20230523154747.5429-1-srinivas.kandagatla@linaro.org>
X-Cookie: Beware of low-flying butterflies.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KttESI1M0xs/s7UC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 23, 2023 at 04:47:47PM +0100, Srinivas Kandagatla wrote:

> +	/* Only bulk writes are supported not multi-register writes */
> +	if (config->can_multi_write)
> +		return -ENOTSUPP;
> +

This doesn't seem like the right fix - I'd expect us to simply choose
not to use multiple writes, with an additional flag/check for bus
support.

--KttESI1M0xs/s7UC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRs8JkACgkQJNaLcl1U
h9BO1Qf/SF8Vg2vHrhREne+0bKejDxWWk5D1YXA1nuKMm6xnfjwxmxE0E4nsuZmC
2H94Qqjuyv2OFRrF8zvY5zczDzfbSiVbmCA3D8udwnFSz+QjbnPluIMPQOOa3pPi
44OIgVJWruEu1ofWtlv0YzCmWaEkkd0EMcQQo0A2i2MFDSeqYKhsnskOPKyDQR7g
I2JszY5qdCiH1FMyHEbJKHutlAm14xf5NfWClIxxkp7n85mmsbu7AtXskC8MdCQw
xN6FaRL6JCEO60zdl/ahFHEYyPdTcdtMHEogKFdI9uM9GOwB3qyf3lDnd97dBXR+
ychovc+cRMUbDRKjYTeNDasKMVOgeg==
=daRG
-----END PGP SIGNATURE-----

--KttESI1M0xs/s7UC--
