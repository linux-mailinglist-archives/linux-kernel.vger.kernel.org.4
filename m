Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1903667E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbjALSlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240515AbjALSk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:40:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB92A6D501
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:14:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49607B81F02
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 18:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC84C433D2;
        Thu, 12 Jan 2023 18:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673547281;
        bh=ZHwPqXda3cP76H31k4wg9TUOciDZ22NXwzl5Pg5ZuB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dFyPKjEz89mpn4VEFMpjTmcGuC+vaR+1/9lE+zKt1sMbyxd7AOse6b4bnReyndf5e
         6rnJ48MFe6rkSNujHiheEAdb2FsAzTap2RhF35SZWCJXbHqfxaEII0vMGa/sSYg6qz
         6ouzDwScgmft68J7qFbiw8DDvN3aTQ9d8POT8J5WmM4lrWwJF4SkMmet2DrMTUhEyF
         pJd2vDcck0/GvOhagmAmVrfLWEAxbY3+LkV4V3IsKzDYfeybOUQabGlGgW6ASgwnBB
         Ruh0kvUXw3DqEPPhlykQMshiZDOEvD3/8dvCjNrmp8Wey+tf8x/IHG9w2kb4D/J05o
         4naUKHC7jmJuw==
Date:   Thu, 12 Jan 2023 18:14:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] regmap: sdw: Remove 8-bit value size restriction
Message-ID: <Y8BOCpXyOyF3igfG@sirena.org.uk>
References: <20230112171840.2098463-1-ckeepax@opensource.cirrus.com>
 <20230112171840.2098463-3-ckeepax@opensource.cirrus.com>
 <756fcb2d-d571-18cb-985e-d907ab682275@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NyngNFsuXRwJtzSl"
Content-Disposition: inline
In-Reply-To: <756fcb2d-d571-18cb-985e-d907ab682275@linux.intel.com>
X-Cookie: A watched clock never boils.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NyngNFsuXRwJtzSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 12, 2023 at 11:38:38AM -0600, Pierre-Louis Bossart wrote:

> > +static int regmap_sdw_gather_write(void *context,
> > +				   const void *reg_buf, size_t reg_size,
> > +				   const void *val_buf, size_t val_size)
> >  {
> >  	struct device *dev = context;
> >  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> > -	int read;
> > +	u32 addr = le32_to_cpu(*(const __le32 *)reg_buf);

> what's the difference between regmap_sdw_write() and
> regmap_sdw_gather_write()? Seems to me that it's the same functionality
> of writing at consecutive addresses. It's not a true 'gather' in the
> sense that only the first address is used?

The regmap gather_write() operation allows the bus to take two buffers,
one for the register and one for the value, rather than requiring the
core combine everything into a single buffer (mainly useful for large
transfers like firmware downloads).

--NyngNFsuXRwJtzSl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPATgkACgkQJNaLcl1U
h9DY9gf/TllVCVxT32j19TNlvR5swp3GekXYm0Qe0BdlkBVEWl0Q/HpKixSkgeGR
hn7T5+BdVcpK+FezM681wvCPe5G10YGFW2xoYyL0AJtiVTUo7BOPyP5X6qsxvpiN
vCUyCS58J+sb5eUiDm6Ogvf3b+Gxqx3eZWy+CfGmMkkZuTPj/HUYkWcXYlRDLFoq
G2H7hPHaiuJZRgrhB5N/KPe1aS0tv0vLSIv9c9ggjsIt7syhVlG3LRyqH5+X5FsE
J2kcO5wBMNG0FnoO2+pSe10QZ2/0+P+Cew05yjE5Am/Zvk7stFrkZ/hIKLpj/aBQ
J97DRNhK8Ar45nHSbdcLSZSHfyKdZQ==
=Pt+0
-----END PGP SIGNATURE-----

--NyngNFsuXRwJtzSl--
