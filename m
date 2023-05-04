Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78056F6DAE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjEDO1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjEDO1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:27:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A465BBD
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:27:41 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1puZvK-0002Nr-OF; Thu, 04 May 2023 16:27:10 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1puZvI-0003dF-IR; Thu, 04 May 2023 16:27:08 +0200
Date:   Thu, 4 May 2023 16:27:08 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     andreas@fatal.se, jun.li@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] usb: typec: tcpci: clear the fault status bit
Message-ID: <20230504142708.l4xo4sbl7wzsrbql@pengutronix.de>
References: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
 <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-3-3889b1b2050c@pengutronix.de>
 <6a894ff0-3232-4ef0-5e26-95471cc33ed9@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a894ff0-3232-4ef0-5e26-95471cc33ed9@roeck-us.net>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-04, Guenter Roeck wrote:
> On 5/4/23 06:46, Marco Felsch wrote:
> > According the "USB Type-C Port Controller Interface Specification v2.0"
> > the TCPC sets the fault status register bit-7
> > (AllRegistersResetToDefault) once the registers have been reseted to
> 
> cleared ? set ?

Sry. I don't get this.

> > their default values.
> > 
> > This triggers an alert(-irq) on PTN5110 devices albeit we do mask the
> > fault-irq. Fix this gernally by writing a one to the correspondig
> 
> generically ?

Sure, thanks.

> corresponding

Of course!

> > bit-7.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >   drivers/usb/typec/tcpm/tcpci.c | 5 +++++
> >   include/linux/usb/tcpci.h      | 1 +
> >   2 files changed, 6 insertions(+)
> > 
> > diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> > index 8da23240afbe..15632d023e4c 100644
> > --- a/drivers/usb/typec/tcpm/tcpci.c
> > +++ b/drivers/usb/typec/tcpm/tcpci.c
> > @@ -602,6 +602,11 @@ static int tcpci_init(struct tcpc_dev *tcpc)
> >   	if (time_after(jiffies, timeout))
> >   		return -ETIMEDOUT;
> > +	regmap_read(tcpci->regmap, TCPC_FAULT_STATUS, &reg);
> 
> Needs error check.

I will add this.

> Also, I am not sure if this is the correct place for this code. The alert
> status is cleared after vendor initialization. Should the same be done
> here ?

According the spec the bit must be cleared before the TCPC_ALERT is
cleared. Of course the vendor-init can (re-)trigger the bit, therefore
we should move behind the vendor init and right before the TCPC_ALERT
clear.

> Also, why not just write the bit unconditionally, similar
> to TCPC_ALERT ?

Thought about this too.. I will change it in the v3.

Thanks for the feedback,
  Marco

> 
> Thanks,
> Guenter
> 
> > +	if (reg & TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT)
> > +		tcpci_write16(tcpci, TCPC_FAULT_STATUS,
> > +			      TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT);
> > +
> >   	/* Handle vendor init */
> >   	if (tcpci->data->init) {
> >   		ret = tcpci->data->init(tcpci, tcpci->data);
> > diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> > index 85e95a3251d3..83376473ac76 100644
> > --- a/include/linux/usb/tcpci.h
> > +++ b/include/linux/usb/tcpci.h
> > @@ -103,6 +103,7 @@
> >   #define TCPC_POWER_STATUS_SINKING_VBUS	BIT(0)
> >   #define TCPC_FAULT_STATUS		0x1f
> > +#define TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT BIT(7)
> >   #define TCPC_ALERT_EXTENDED		0x21
> > 
> 
> 
