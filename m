Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF95F5BBE5A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 16:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIROWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 10:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIROWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 10:22:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC241EAE3;
        Sun, 18 Sep 2022 07:22:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8977360C55;
        Sun, 18 Sep 2022 14:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BECC433C1;
        Sun, 18 Sep 2022 14:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663510940;
        bh=z4w4Jd6Yw1OP2BhleHWvgUNU4yfAz6x/VUTv668v3Kw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HUs5os1a2lRyrvWD3ybe8gDorfa+QU5tTeXFoRFHXT1MkeZTxKtLHsSYUBT67hipM
         OhaQE6riClZjjG6Ohrtf6POn2RRUJRlu/LW3Vs+VbpqBK271GUhdl9ZV+kMRVUOzxu
         x+2XupNxl1zxh6DKWveI1GRTbF+DuanMaRP1wkxuTQ9/7SGPFeeXv/RoLu9jt8b2b6
         Qzne4wqiXhmY+nOhrskQ+ldWQhJ1YbuoNRgptxHnoPtrLPZm03nB1W2O4LhhqYGGCD
         l/CQ8F5rrslGWdeDvV9rbYx595j7cp4Gch1Kz768l5YGtX9gUpild9AwOGl8tD1Dv7
         dJG1aprR6sbvQ==
Date:   Sun, 18 Sep 2022 15:22:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Denys Zagorui <dzagorui@cisco.com>, Meng.Li@windriver.com,
        lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ltc2497: Fix reading conversion results
Message-ID: <20220918152224.14f874c1@jic23-huawei>
In-Reply-To: <20220912104631.zysrv2qqxvsjfbxc@pengutronix.de>
References: <20220815091647.1523532-1-dzagorui@cisco.com>
        <20220820130648.5b9bc66f@jic23-huawei>
        <20220912104631.zysrv2qqxvsjfbxc@pengutronix.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2022 12:46:31 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> On Sat, Aug 20, 2022 at 01:06:48PM +0100, Jonathan Cameron wrote:
> > On Mon, 15 Aug 2022 09:16:47 +0000
> > Denys Zagorui <dzagorui@cisco.com> wrote:
> >  =20
> > > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > >=20
> > > After the result of the previous conversion is read the chip
> > > automatically starts a new conversion and doesn't accept new i2c
> > > transfers until this conversion is completed which makes the function
> > > return failure. =20
> >=20
> > That's rather nasty.
> >=20
> > Could we add a cheeky sleep in the other path to ensure there is always
> > time for the conversion to be done?  Not ideal, but might ensure
> > there isn't a known problem path without introducing much complexity. =
=20
>=20
> FTR: While the patch was originally authored by me, I don't currently
> have access to a machine with that chip. So currently there will be no
> incentive on my side to address this feedback.

I'm not keen to keep changes to this driver queued up on improving this pat=
ch.
Hence applied to the togreg branch of iio.git and I'll push that out as tes=
ting
shortly for the autobuilders to poke at it.

I have also marked it for stable.

Thanks,

Jonathan

>=20
> Best regards
> Uwe
>=20

