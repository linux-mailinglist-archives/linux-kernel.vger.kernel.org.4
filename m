Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290475E7D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiIWOap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIWOad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:30:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEEFFA0EF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:30:32 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1objh1-0002rt-OC; Fri, 23 Sep 2022 16:30:15 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1objgz-00016D-Gx; Fri, 23 Sep 2022 16:30:13 +0200
Date:   Fri, 23 Sep 2022 16:30:13 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        sakari.ailus@linux.intel.com, jacopo@jmondi.org,
        hverkuil@xs4all.nl, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 4/4] media: tc358746: add Toshiba TC358746 Parallel to
 CSI-2 bridge driver
Message-ID: <20220923143013.vymstztawb3wb2nf@pengutronix.de>
References: <20220922134843.3108267-1-m.felsch@pengutronix.de>
 <20220922134843.3108267-5-m.felsch@pengutronix.de>
 <Yyyq7CRB3Tg8508B@pendragon.ideasonboard.com>
 <20220923092726.mrurgoylqdlw3ena@pengutronix.de>
 <Yy24k5OQGcuZvcSo@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy24k5OQGcuZvcSo@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-23, Laurent Pinchart wrote:
> Hi Marco,
> 
> On Fri, Sep 23, 2022 at 11:27:26AM +0200, Marco Felsch wrote:

...

> > > > +static int tc358746_write(struct tc358746 *tc358746, u32 reg, u32 val)
> > > > +{
> > > > +	size_t count;
> > > > +	int err;
> > > > +
> > > > +	/* 32-bit registers starting from CLW_DPHYCONTTX */
> > > > +	count = reg < CLW_DPHYCONTTX_REG ? 1 : 2;
> > > > +
> > > > +	err = regmap_bulk_write(tc358746->regmap, reg, &val, count);
> > > > +	if (err)
> > > > +		dev_dbg(tc358746->sd.dev,
> > > > +			"Failed to write reg:0x%04x val:0x%04x\n", reg, val);
> > > 
> > > I'm not sure if the value is relevant here, but I'd add the error, it's
> > > useful to know what kind of I2C issue occurred. Same for read().
> > 
> > Yeah.. I'm not sure, since you told me to not flood the kernel log. If
> > someone recognised error while probing or streaming the debug will be
> > turned on anyways. However, I will make it a dev_err() since this
> > shouldnt appear normally, you're right.
> 
> Sorry, I meant printing the value of the error code in the message, the
> err variable. dev_err() is probably good too actually, as this isn't
> meant to happen.

Sorry that was my fault, I misread your comment.. Anyway since we agree
with dev_err() and I added the err value into the message, everything is
fine :)

Regards,
  Marco
