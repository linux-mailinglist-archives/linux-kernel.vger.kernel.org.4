Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F269C703C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbjEOSUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245165AbjEOSUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:20:12 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261161CA40;
        Mon, 15 May 2023 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BdCOx9nUh1D3nhNeWTomyk4eDTqnAOeJE1CLlllOBsQ=; b=tPrSjiIrLN8lW0xM6F40tafBx0
        m/W04G9Mb9w0aH8cMsnChu37KzLUOG2v2iqL2nrIBI/RWOU/q2tRcdiHaK03v9ke97f9cbJpe7Wje
        7vW6Ti2FNRK7//8dPFPzF3JN+RaNayDB6Q1PHrC7tMH+gYYrmRUSFNzDCYXE/aNzwQ6c=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:36038 helo=debian-acer)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pycmM-0004Ta-Ko; Mon, 15 May 2023 14:18:40 -0400
Date:   Mon, 15 May 2023 14:18:38 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        hugo@hugovil.com
Message-Id: <20230515141838.c18b0b9375606642ef979403@hugovil.com>
In-Reply-To: <Ygwo4iXtE/hCA5IZ@piout.net>
References: <20220117225625.1252233-1-hugo@hugovil.com>
        <Ygwo4iXtE/hCA5IZ@piout.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH] rtc: pcf2127: add error checking and message when
 disabling POR0
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022 23:27:46 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Hello,
> 
> On 17/01/2022 17:56:24-0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > If PCF2127 device is absent from the I2C bus, or if there is a
> > communication problem, disabling POR0 may fail silently and we
> > still continue with probing the device. In that case, abort probe
> > operation and display an error message.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/rtc/rtc-pcf2127.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > index 81a5b1f2e68c..e6d0838ccfe3 100644
> > --- a/drivers/rtc/rtc-pcf2127.c
> > +++ b/drivers/rtc/rtc-pcf2127.c
> > @@ -690,8 +690,12 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> >  	 * The "Power-On Reset Override" facility prevents the RTC to do a reset
> >  	 * after power on. For normal operation the PORO must be disabled.
> >  	 */
> > -	regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
> > +	ret = regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
> >  				PCF2127_BIT_CTRL1_POR_OVRD);
> > +	if (ret < 0) {
> > +		dev_err(dev, "PORO disabling failed\n");
> 
> As discussed on the other patches, please do not add a message here.

I forgot to resend that patch without the message. I will do it soon.

Hugo.


> > +		return ret;
> > +	}
> >  
> >  	ret = regmap_read(pcf2127->regmap, PCF2127_REG_CLKOUT, &val);
> >  	if (ret < 0)
> > -- 
> > 2.30.2
> > 
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


-- 
Hugo Villeneuve <hugo@hugovil.com>
