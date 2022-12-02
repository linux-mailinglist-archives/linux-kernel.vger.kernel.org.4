Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929486402F5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiLBJLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiLBJLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:11:20 -0500
X-Greylist: delayed 317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Dec 2022 01:11:18 PST
Received: from out-124.mta0.migadu.com (out-124.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74F99950E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:11:18 -0800 (PST)
Date:   Fri, 2 Dec 2022 17:05:54 +0800
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Frank Li <frank.li@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jic23@kernel.org" <jic23@kernel.org>,
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
Message-ID: <20221202090554.GA10754@chq-T47>
References: <20221201140110.2653501-1-Frank.Li@nxp.com>
 <DB7PR04MB401084C620570D234A535EE990179@DB7PR04MB4010.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR04MB401084C620570D234A535EE990179@DB7PR04MB4010.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 12月 22 03:23:55, Bough Chen wrote:
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: 2022年12月1日 22:01
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: cai.huoqing@linux.dev; festevam@gmail.com; Frank Li <frank.li@nxp.com>;
> > imx@lists.linux.dev; jic23@kernel.org; kernel@pengutronix.de;
> > lars@metafoo.de; linux-arm-kernel@lists.infradead.org;
> > linux-iio@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> > linux-kernel@vger.kernel.org; s.hauer@pengutronix.de; shawnguo@kernel.org
> > Subject: [PATCH v2 1/1] iio: imx8qxp-adc: fix irq flood when call
> > imx8qxp_adc_read_raw()
> > 
> > irq flood happen when run
> >     cat /sys/bus/iio/devices/iio:device0/in_voltage1_raw
> > 
> > imx8qxp_adc_read_raw()
> > {
> > 	...
> > 	enable irq
> > 	/* adc start */
> > 	writel(1, adc->regs + IMX8QXP_ADR_ADC_SWTRIG);
> > 	^^^^ trigger irq flood.
> > 	wait_for_completion_interruptible_timeout();
> > 	readl(adc->regs + IMX8QXP_ADR_ADC_RESFIFO);
> > 	^^^^ clear irq here.
> > 	...
> > }
> > 
> > There is only FIFO watermark interrupt at this ADC controller.
> > IRQ line will be assert until software read data from FIFO.
> > So IRQ flood happen during wait_for_completion_interruptible_timeout().
> > 
> > Move FIFO read into irq handle to avoid irq flood.
> > 
> > Fixes: 1e23dcaa1a9f ("iio: imx8qxp-adc: Add driver support for NXP IMX8QXP
> > ADC")
> > Cc: stable@vger.kernel.org
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Thanks for the quick fix. The total read count in irq handler is fifo_count which is read from register, this is reasonable.
> 
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
The same, thanks.
Reviewed-by: Cai Huoqing <cai.huoqing@linux.dev>
> 
> Best Regards
> Haibo Chen
> > ---
> > Change from v1 to v2
> >  - move complete() after read fifo
> > 
> > 
> >  drivers/iio/adc/imx8qxp-adc.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c index
> > 36777b827165..f5a0fc9e64c5 100644
> > --- a/drivers/iio/adc/imx8qxp-adc.c
> > +++ b/drivers/iio/adc/imx8qxp-adc.c
> > @@ -86,6 +86,8 @@
> > 
> >  #define IMX8QXP_ADC_TIMEOUT		msecs_to_jiffies(100)
> > 
> > +#define IMX8QXP_ADC_MAX_FIFO_SIZE		16
> > +
> >  struct imx8qxp_adc {
> >  	struct device *dev;
> >  	void __iomem *regs;
> > @@ -95,6 +97,7 @@ struct imx8qxp_adc {
> >  	/* Serialise ADC channel reads */
> >  	struct mutex lock;
> >  	struct completion completion;
> > +	u32 fifo[IMX8QXP_ADC_MAX_FIFO_SIZE];
> >  };
> > 
> >  #define IMX8QXP_ADC_CHAN(_idx) {				\
> > @@ -238,8 +241,7 @@ static int imx8qxp_adc_read_raw(struct iio_dev
> > *indio_dev,
> >  			return ret;
> >  		}
> > 
> > -		*val = FIELD_GET(IMX8QXP_ADC_RESFIFO_VAL_MASK,
> > -				 readl(adc->regs + IMX8QXP_ADR_ADC_RESFIFO));
> > +		*val = adc->fifo[0];
> > 
> >  		mutex_unlock(&adc->lock);
> >  		return IIO_VAL_INT;
> > @@ -265,10 +267,15 @@ static irqreturn_t imx8qxp_adc_isr(int irq, void
> > *dev_id)  {
> >  	struct imx8qxp_adc *adc = dev_id;
> >  	u32 fifo_count;
> > +	int i;
> > 
> >  	fifo_count = FIELD_GET(IMX8QXP_ADC_FCTRL_FCOUNT_MASK,
> >  			       readl(adc->regs + IMX8QXP_ADR_ADC_FCTRL));
> > 
> > +	for (i = 0; i < fifo_count; i++)
> > +		adc->fifo[i] = FIELD_GET(IMX8QXP_ADC_RESFIFO_VAL_MASK,
> > +				readl_relaxed(adc->regs + IMX8QXP_ADR_ADC_RESFIFO));
> > +
> >  	if (fifo_count)
> >  		complete(&adc->completion);
> > 
> > --
> > 2.34.1
> 
