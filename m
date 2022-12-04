Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA53641DAD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 16:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiLDPki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 10:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLDPkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 10:40:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F77911175;
        Sun,  4 Dec 2022 07:40:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDB2EB80813;
        Sun,  4 Dec 2022 15:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5423BC433C1;
        Sun,  4 Dec 2022 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670168432;
        bh=XivmGAMo4bgBcXNnSUPwpz9h0TTHV89rfEJTsZENORA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NQ7bmo4QMWxLIgcWGnjZBay9XfrlWS8fqH+oMgWkxSCzi89OBg/+Ufuslov8baNbI
         W1e2XRndmQgMjPshFlO/4JxaC29AFvFQk1ABZva5OgRPOtQwYEKnNps7mEBtsSrVlp
         98fZ6QWPBmn7KwjwLBMkNrcuqIpnYfBJkKelTS8JLBjgqvQ+LaQZm9H7B0LF4kcXa5
         E/s2GYjdatMw565/p/3nGeN2Twoy9mSKS53L9HsVcVsQ3wDpOlpBhMWi73S1i63CnP
         xLJ7gYzyKz8tNCo0butOgN705X8H2o69YkAqdc2pBDZ26sPFj2VgZv/SVlMVIBLV5u
         t99ACQigBwh1Q==
Date:   Sun, 4 Dec 2022 15:53:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Bough Chen <haibo.chen@nxp.com>, Frank Li <frank.li@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH v2 1/1] iio: imx8qxp-adc: fix irq flood when call
 imx8qxp_adc_read_raw()
Message-ID: <20221204155317.5b568fd6@jic23-huawei>
In-Reply-To: <20221202090554.GA10754@chq-T47>
References: <20221201140110.2653501-1-Frank.Li@nxp.com>
        <DB7PR04MB401084C620570D234A535EE990179@DB7PR04MB4010.eurprd04.prod.outlook.com>
        <20221202090554.GA10754@chq-T47>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 2 Dec 2022 17:05:54 +0800
Cai Huoqing <cai.huoqing@linux.dev> wrote:

> On 02 12=E6=9C=88 22 03:23:55, Bough Chen wrote:
> > > -----Original Message-----
> > > From: Frank Li <frank.li@nxp.com>
> > > Sent: 2022=E5=B9=B412=E6=9C=881=E6=97=A5 22:01
> > > To: Bough Chen <haibo.chen@nxp.com>
> > > Cc: cai.huoqing@linux.dev; festevam@gmail.com; Frank Li <frank.li@nxp=
.com>;
> > > imx@lists.linux.dev; jic23@kernel.org; kernel@pengutronix.de;
> > > lars@metafoo.de; linux-arm-kernel@lists.infradead.org;
> > > linux-iio@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> > > linux-kernel@vger.kernel.org; s.hauer@pengutronix.de; shawnguo@kernel=
.org
> > > Subject: [PATCH v2 1/1] iio: imx8qxp-adc: fix irq flood when call
> > > imx8qxp_adc_read_raw()
> > >=20
> > > irq flood happen when run
> > >     cat /sys/bus/iio/devices/iio:device0/in_voltage1_raw
> > >=20
> > > imx8qxp_adc_read_raw()
> > > {
> > > 	...
> > > 	enable irq
> > > 	/* adc start */
> > > 	writel(1, adc->regs + IMX8QXP_ADR_ADC_SWTRIG);
> > > 	^^^^ trigger irq flood.
> > > 	wait_for_completion_interruptible_timeout();
> > > 	readl(adc->regs + IMX8QXP_ADR_ADC_RESFIFO);
> > > 	^^^^ clear irq here.
> > > 	...
> > > }
> > >=20
> > > There is only FIFO watermark interrupt at this ADC controller.
> > > IRQ line will be assert until software read data from FIFO.
> > > So IRQ flood happen during wait_for_completion_interruptible_timeout(=
).
> > >=20
> > > Move FIFO read into irq handle to avoid irq flood.
> > >=20
> > > Fixes: 1e23dcaa1a9f ("iio: imx8qxp-adc: Add driver support for NXP IM=
X8QXP
> > > ADC")
> > > Cc: stable@vger.kernel.org
> > >=20
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com> =20
> >=20
> > Thanks for the quick fix. The total read count in irq handler is fifo_c=
ount which is read from register, this is reasonable.
> >=20
> > Reviewed-by: Haibo Chen <haibo.chen@nxp.com> =20
> The same, thanks.
> Reviewed-by: Cai Huoqing <cai.huoqing@linux.dev>

I briefly wondered if it would be better to return the newest value,
but given it's not obvious and they will be close together in this case,
I'm fine with this.

Applied to the fixes-togreg branch of iio.git and marked for
stable inclusion.  Note I'm unlikely to send a pull request until after rc1=
 now
so this will take a few weeks to land upstream.

Thanks,

Jonathan

> >=20
> > Best Regards
> > Haibo Chen =20
> > > ---
> > > Change from v1 to v2
> > >  - move complete() after read fifo
> > >=20
> > >=20
> > >  drivers/iio/adc/imx8qxp-adc.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-=
adc.c index
> > > 36777b827165..f5a0fc9e64c5 100644
> > > --- a/drivers/iio/adc/imx8qxp-adc.c
> > > +++ b/drivers/iio/adc/imx8qxp-adc.c
> > > @@ -86,6 +86,8 @@
> > >=20
> > >  #define IMX8QXP_ADC_TIMEOUT		msecs_to_jiffies(100)
> > >=20
> > > +#define IMX8QXP_ADC_MAX_FIFO_SIZE		16
> > > +
> > >  struct imx8qxp_adc {
> > >  	struct device *dev;
> > >  	void __iomem *regs;
> > > @@ -95,6 +97,7 @@ struct imx8qxp_adc {
> > >  	/* Serialise ADC channel reads */
> > >  	struct mutex lock;
> > >  	struct completion completion;
> > > +	u32 fifo[IMX8QXP_ADC_MAX_FIFO_SIZE];
> > >  };
> > >=20
> > >  #define IMX8QXP_ADC_CHAN(_idx) {				\
> > > @@ -238,8 +241,7 @@ static int imx8qxp_adc_read_raw(struct iio_dev
> > > *indio_dev,
> > >  			return ret;
> > >  		}
> > >=20
> > > -		*val =3D FIELD_GET(IMX8QXP_ADC_RESFIFO_VAL_MASK,
> > > -				 readl(adc->regs + IMX8QXP_ADR_ADC_RESFIFO));
> > > +		*val =3D adc->fifo[0];
> > >=20
> > >  		mutex_unlock(&adc->lock);
> > >  		return IIO_VAL_INT;
> > > @@ -265,10 +267,15 @@ static irqreturn_t imx8qxp_adc_isr(int irq, void
> > > *dev_id)  {
> > >  	struct imx8qxp_adc *adc =3D dev_id;
> > >  	u32 fifo_count;
> > > +	int i;
> > >=20
> > >  	fifo_count =3D FIELD_GET(IMX8QXP_ADC_FCTRL_FCOUNT_MASK,
> > >  			       readl(adc->regs + IMX8QXP_ADR_ADC_FCTRL));
> > >=20
> > > +	for (i =3D 0; i < fifo_count; i++)
> > > +		adc->fifo[i] =3D FIELD_GET(IMX8QXP_ADC_RESFIFO_VAL_MASK,
> > > +				readl_relaxed(adc->regs + IMX8QXP_ADR_ADC_RESFIFO));
> > > +
> > >  	if (fifo_count)
> > >  		complete(&adc->completion);
> > >=20
> > > --
> > > 2.34.1 =20
> >  =20

