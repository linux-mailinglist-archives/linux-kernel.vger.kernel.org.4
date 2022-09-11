Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FD25B4D5A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiIKK0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiIKK00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:26:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5733AE60;
        Sun, 11 Sep 2022 03:26:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0AEC4CE0B69;
        Sun, 11 Sep 2022 10:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F77C433C1;
        Sun, 11 Sep 2022 10:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662891981;
        bh=CX0IateX3sJ2WEFjcCnlZ/1dbHOryL+D+S1Du/XSe+Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J2ZGYSj70hjY6RGmsJlpMEpjgHhvlx6MVM1y8tn9GkJFzsuEfjkSmHVGYVwqTRe7C
         NDzEjHpekCG2hi9BfuN1vhpXn8KLvC502VmJPgDYK66rN4mAzCVe9LW/el0awP48kb
         8VZWkGVd2raOEWb3P8iYA/0sWBpQqwDV9ifuilTy3Fv2t7ca2URMRuFK9woMAQFa+3
         nDIDTugFlhwnfyi9JbB503upsla2P9vGWxzHilcEIx4jiJoH1YN40fGQ+llSOXp04Z
         e7EOAxbow9hmmGuubvL5aKa6Eo/P3rg3JGdyVaJII7+rrpxtkDDoARz4gSRnuzAYif
         LxDiWtxfvcMyg==
Date:   Sun, 11 Sep 2022 10:52:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v1 1/1] iio: adc: mxs-lradc-adc: Get rid of OF specifics
Message-ID: <20220911105215.72bd79f3@jic23-huawei>
In-Reply-To: <YxdM1KUFcdVlnKuO@smile.fi.intel.com>
References: <20220530173324.921-1-andriy.shevchenko@linux.intel.com>
        <20220603181006.2c5cc6c4@jic23-huawei>
        <20220620204225.34d40a3f@jic23-huawei>
        <YxdM1KUFcdVlnKuO@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 16:36:20 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Jun 20, 2022 at 08:42:25PM +0100, Jonathan Cameron wrote:
> > On Fri, 3 Jun 2022 18:10:06 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote: =20
> > > On Mon, 30 May 2022 20:33:24 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >  =20
> > > > First of all, the additional conversion from vIRQ, and this is exac=
tly
> > > > what is returned by platform_get_irq_byname(), to vIRQ is not neede=
d.   =20
> > > Confusing sentence form.  Perhaps:
> > >=20
> > > First, the additional conversion from vIRQ (returned by platform_get_=
irq_byname())
> > > to vIRQ is not needed.
> > >  =20
> > > > Hence, drop no-op call to irq_of_parse_and_map().
> > > >=20
> > > > Second, assign the firmware node instead of of_node. =20
>=20
> ...
>=20
> > > Seems sensible to me, but I'd like a sanity check from someone more
> > > familiar with this driver. =20
> >=20
> > This one has been outstanding for a few weeks. I'd still like
> > an Ack or similar form someone who knows this device well.
> >=20
> > If no one has looked at it in a week or so I'll just go with
> > my judgement and pick it up. =20
>=20
> Any news on this one? Maybe I need to resend with the better commit messa=
ge?
>=20

=46rom glancing back at the thread, looks like you said you were going to send
a v2 with property.h include.  I think the rest of the thread is concerned
with a different issue entirely.

Jonathan


