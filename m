Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC3C64A9C9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbiLLVwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbiLLVvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:51:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6942C1A07D;
        Mon, 12 Dec 2022 13:51:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F01CBB80D90;
        Mon, 12 Dec 2022 21:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC2EC433EF;
        Mon, 12 Dec 2022 21:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670881901;
        bh=FvG6dZl0qxOwzykqIDDbxpQVq9AhChXkUGGZgcBqCV4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tbTmWUXI77okTiJlZBbt+kKIDjSaKmoA0w/2HDEFrObeQqzdVs7NUHLgLwvX+0qRU
         SJc0ATq5emJ7CiEv3udAi7R7pEBNQZItcGm9YBVeTOsrFp647EofFZQUYNudYC5Xyp
         on6HOSEjDqok9x/IP+YDfmo1PmeohZPeUz1+XyL0zWVs1n0Zc6Kl7VebLKq05BgwLG
         9MUtPfmQcPFQqlqJnRCUGMaB9RVmR5JIdP0t4XJ//H8v8DHXE0J9YG10YoTezAjrsf
         TUrk76ltl+kdssVis6o7dL5HDisnUUeJFmkeKPPoAObXE+THYaPtS6zeMkOPYGAsFd
         1xaQl+SXhv/0w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d92dbf13-5c64-03d0-1aab-6f96d8f45669@gmail.com>
References: <20221110211132.297512-1-ftoth@exalondelft.nl> <20221110211132.297512-2-ftoth@exalondelft.nl> <d92dbf13-5c64-03d0-1aab-6f96d8f45669@gmail.com>
Subject: Re: [PATCH v2 1/2] usb: ulpi: defer ulpi_register on ulpi_read_id timeout
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ferry Toth <fntoth@gmail.com>, Ferry Toth <ftoth@exalondelft.nl>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Mon, 12 Dec 2022 13:51:39 -0800
User-Agent: alot/0.10
Message-Id: <20221212215141.ADC2EC433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ferry Toth (2022-11-11 06:04:16)
> + Stephen Boyd
>=20
> On 10-11-2022 22:11, Ferry Toth wrote:
> > Since commit 0f010171
> > Dual Role support on Intel Merrifield platform broke due to rearranging
> > the call to dwc3_get_extcon().
> >=20
> > It appears to be caused by ulpi_read_id() on the first test write faili=
ng
> > with -ETIMEDOUT. Currently ulpi_read_id() expects to discover the phy v=
ia
> > DT when the test write fails and returns 0 in that case even if DT does=
 not
> > provide the phy. As a result usb probe completes without phy.
> >=20
> > Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
> > ---
> >   drivers/usb/common/ulpi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> > index d7c8461976ce..60e8174686a1 100644
> > --- a/drivers/usb/common/ulpi.c
> > +++ b/drivers/usb/common/ulpi.c
> > @@ -207,7 +207,7 @@ static int ulpi_read_id(struct ulpi *ulpi)
> >       /* Test the interface */
> >       ret =3D ulpi_write(ulpi, ULPI_SCRATCH, 0xaa);
> >       if (ret < 0)
> > -             goto err;
> > +             return ret;
> >  =20
> >       ret =3D ulpi_read(ulpi, ULPI_SCRATCH);
> >       if (ret < 0)
>=20
> Would this affect others phys (like qcom HSIC)? I'm not sure if failing=20
> the test write is a normal behavior.

I don't think failing a test write is normal behavior. I don't have this
hardware on hand anymore though, so I can't help test it. Looks OK to me
though:

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
