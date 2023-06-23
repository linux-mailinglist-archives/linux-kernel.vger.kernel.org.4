Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285AB73BDA4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjFWRQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjFWRQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:16:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9640726B9;
        Fri, 23 Jun 2023 10:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E8CD61AC7;
        Fri, 23 Jun 2023 17:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF0DC433C8;
        Fri, 23 Jun 2023 17:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687540593;
        bh=XzF98qjp3cUGS5MdS2OUjPFF18XAGxz1hZNvRMAQmHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eg6HTCAVX1qEpMbVau3oUofy7C3xYSygLN3FOWo1H1d54+tUe0gpxCURhZN9NuULb
         pIXiuaoqwl/QiGwrKQRLOY/eI895G46e9NxP8CcILCHBX7W3EDX2zmqeJd84BgyoUB
         Kru+WxIr698PqZJ1A9OizO3WY2t0LNll+7a7FTypYl3Is8+v0zCf3N3xJYXz4YPrB0
         jfVaO6e1CDtgcRM+ACDgh5eTN4iow+qzTuBT46eXlyg8I2vyv91Vc/tfwKxxz4WKN4
         GDN1Wz5KzKaMQZLWVfCOb2lniu0m7Xif0yOkOtrHAoxWfkmvw4W2PJ4Hrb5Xe6lmw7
         1cYLF9UYSR5ew==
Date:   Fri, 23 Jun 2023 18:16:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        krzysztof.kozlowski@linaro.org, andi@etezian.org, kernel@axis.com,
        alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] spi: Split transfers larger than max size
Message-ID: <ZJXTbb7zb9Q9T3QQ@finisterre.sirena.org.uk>
References: <20220927112117.77599-1-vincent.whitchurch@axis.com>
 <20220927112117.77599-4-vincent.whitchurch@axis.com>
 <6dff003d-c727-e4a3-b5d3-f58beb2b02cb@linux.ibm.com>
 <ZJS6OnzRapPCboC8@finisterre.sirena.org.uk>
 <9cc6addc-cd41-7794-79a0-5c776946f492@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6UKfe05sFDoqKM7Y"
Content-Disposition: inline
In-Reply-To: <9cc6addc-cd41-7794-79a0-5c776946f492@linux.ibm.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6UKfe05sFDoqKM7Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2023 at 11:45:19AM -0500, Eddie James wrote:
> On 6/22/23 16:16, Mark Brown wrote:
> > On Thu, Jun 22, 2023 at 02:48:36PM -0500, Eddie James wrote:
> > > On 9/27/22 06:21, Vincent Whitchurch wrote:

> > > > A couple of drivers call spi_split_transfers_maxsize() from their
> > > > ->prepare_message() callbacks to split transfers which are too big =
for
> > > > them to handle.  Add support in the core to do this based on
> > > > ->max_transfer_size() to avoid code duplication.

> > > I've been testing AT25 functionality in linux 6.1 and I believe this =
patch
> > > is breaking the AT25 protocol. It will split a write command up such =
that
> > > some of the data is in a different transfer than=A0 the write enable =
and

> > Could you be more specific about the manner in which you think this is
> > breaking things?  The size of transfer is immaterial to the client

> Ok, I understand better now. Agreed it shouldn't make a difference, but t=
his
> is actually a limitation of the spi controller I'm using (spi-fsi). The
> controller cannot handle multiple transfers keeping the chip select
> enabled... I guess the driver can batch transfers in the message to get
> around this, unless you want to add a flag for that behavior.

Client drivers should in general just generate messages corresponding to
the desired result visible to the device and let the controller worry
about how to actually accomplish that, splitting transfers needlessly is
just going to create overheads.  If there's scatter/gather going on
that does complicate things a bit though so it's not always going to
happen.  If the controller driver needs to rewrite the message to
combine transfers then it should do that (or tell the core to do so on
it's behalf), just like with splitting transfers due to length limits.

> > In any case this is all based on the maximum transfer size advertised by
> > the conteroller driver, if the device can physically handle larger
> > transfers then there's no reason for it to set a limit.  If the driver
> > can't physically handle larger transfers and it does make a difference
> > then the system simply won't work.

> Yep, this is also an artifact of the spi-fsi driver having different
> transfer size limits for writes and reads. Funnily enough the at25 driver
> doesn't truly respect the max transfer size (it doesn't include the write
> command and address bytes in the calculation against the max transfer siz=
e)
> so that's how this worked previously.

Yes, the logic there looks incorrect.  As well as the issue you've
identified the driver should really be using spi_max_message_size(),
with a controller that can't control chip select effectivley like the
FSI driver that'll be the same a the transfer size but other drivers
will be able to chain multiple transfers together even if there's limits
on the transfer length.

--6UKfe05sFDoqKM7Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSV02wACgkQJNaLcl1U
h9BdnAf+PY0FCLe/tEf10cWA/oH5sgrTc40JOaRJnDP2aw9Aq8zcj4EH+N/SwtGJ
VUSCxXpX7D+HyuiQVugw/zdg0XE9gLx2Na7ER9xZrtjcv3GQMQU1VSHlqslPYUBn
rARQDcMDZdVVY7BEEvzGl4/FVYklns1he4gF/+HSM/gGinW1f8cNpz5t0z0U1j/l
PnOpwHDPP0IhTKiPJoNwpT8bvRg2DGSvhHvZpjFbXdoa09cXJV5tNeZP7FrU/MDZ
qnPyBPAWYxc5I2dRHbf503WZBr5CWNch8Ax6zh4oUQuJSVU5zj4OzuEu1ypL6S9n
y/Myq1Lx5mGdbbx4ZLfWn/I10kri4w==
=M1Yj
-----END PGP SIGNATURE-----

--6UKfe05sFDoqKM7Y--
