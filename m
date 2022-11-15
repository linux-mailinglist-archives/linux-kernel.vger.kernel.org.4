Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEA062A439
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbiKOVij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiKOVih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:38:37 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7770FDF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:38:32 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x2so23868447edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0qqcluEnKDWuRRDz3pvE3cXQ8iH9uHWt3hqRxoLeo8=;
        b=gJP6ZkyFtTpF18nmTzBe/C15w/ppBZ0izikt5RYF188kCgQHvCZ5gINPbDmtvBJ1k9
         eaDAB3H4huNHELIlrinYLLWWvNTiNJBjjD9ssyMeD0zizbWoprs51Wgw3iGNcjKDvgP7
         AxLGnxMxoSIaNzQc+JELR3+hYcODZQ/eKMpDUZfxLCaaPMy9X363aFAhFTBEGS1v31Ce
         KiLDTWfZTjmlq1hLURSWnykEmfbe374SyJt9XXNI4oXpQQ1H2ZTQMvg4ThYH0i3xQ4km
         bxFSJjPrrm2ps89EKqD6MyIM8ihjXwM0A8//PwC3lOISKjWi6qMiEAN4vYythSaNaeFh
         iiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0qqcluEnKDWuRRDz3pvE3cXQ8iH9uHWt3hqRxoLeo8=;
        b=f1tDkgUx9E2dNXHbPSz+In3xA1/MQaxX5wXzrn/v2wgGVj4qZ04ezpyiY2gSMYkSgD
         komWO/SdAqPYimdODm8i8x+m3JSPvxAZobWt2y1IGwmUBDgTe5kwXZYAnH0YauWw9bTp
         1nXWDhPpAYaQrtLYSjTgzjatJhHN1tx+Xy0P/zNnsKE+CeF0hXT0l4tZ8DeztyT9avp1
         57CupyZ8q7JIZ04BAV0QHdcTTWv3xpqEcMQh+ggWE4HyJG+qKGCamUXdPKPqRQcZXab3
         3LT3op/wgx3oo/FxKHMUhIUCWmvkLDPbF84K+6yEZNPGp8y+yTY3IMTM9DLr6AqCD4bA
         UxjA==
X-Gm-Message-State: ANoB5pnxX+S4PB1TzHIB/ZNcBjlqBYrmg7lAzDDB7wG7MWm3l8UNyfH1
        2jKImPabtdNpC3HUdqZA2Gw=
X-Google-Smtp-Source: AA0mqf7+GgVYuxL5xasn4VNMBRz2Sy90Pg6Fu+lL4brjmrxjY5GbT2MB3TR585xiHGp5XW6K6Q+wWw==
X-Received: by 2002:a05:6402:360d:b0:461:b033:90ac with SMTP id el13-20020a056402360d00b00461b03390acmr16819244edb.257.1668548311172;
        Tue, 15 Nov 2022 13:38:31 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906310700b007389c5a45f0sm6082972ejx.148.2022.11.15.13.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 13:38:30 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v3 3/3] bus: sunxi-rsb: Clear interrupt status before each transfer
Date:   Tue, 15 Nov 2022 22:38:29 +0100
Message-ID: <1910101.PYKUYFuaPT@jernej-laptop>
In-Reply-To: <735349b0-6738-8ace-a7d3-aafae2a62501@sholland.org>
References: <20221114015749.28490-1-samuel@sholland.org> <2170633.72vocr9iq0@jernej-laptop> <735349b0-6738-8ace-a7d3-aafae2a62501@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 15. november 2022 ob 07:08:12 CET je Samuel Holland napisal(a):
> On 11/14/22 15:00, Jernej =C5=A0krabec wrote:
> > Hi Samuel,
> >=20
> > Dne ponedeljek, 14. november 2022 ob 02:57:49 CET je Samuel Holland
> >=20
> > napisal(a):
> >> Currently, the driver clears the interrupt status bits after anything
> >> could have set them. However, this requires duplicating the same logic
> >> in several places.
> >>=20
> >> Instead of clearing the status flags in the interrupt handler, disable
> >> all further interrupts by clearing the RSB_CTRL_GLOBAL_INT_ENB bit.
> >=20
> > where is this bit cleared?
>=20
> It is cleared by any write to RSB_CTRL that does not include it. I noted
> it below with the "disable interrupts" comments.

Right.

>=20
> >> Then we can delay the status register write until the start of the next
> >> transfer, so it only has to be done in one place.
> >>=20
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>=20
> >> Changes in v3:
> >>  - Add a patch refactoring how the status bits are cleared
> >> =20
> >>  drivers/bus/sunxi-rsb.c | 20 +++++---------------
> >>  1 file changed, 5 insertions(+), 15 deletions(-)
> >>=20
> >> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> >> index 3aa91aed3bf7..cb622e60897b 100644
> >> --- a/drivers/bus/sunxi-rsb.c
> >> +++ b/drivers/bus/sunxi-rsb.c
> >> @@ -279,6 +279,7 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *r=
sb)
> >>=20
> >>  	int_mask =3D RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR |
> >>  	RSB_INTS_TRANS_OVER;
> >>  	writel(int_mask, rsb->regs + RSB_INTE);
> >>=20
> >> +	writel(int_mask, rsb->regs + RSB_INTS);
> >=20
> > Wouldn't be better to clear status before enabling interrupts? Unless
> > global interrupt flag is cleared beforehand, but I don't see that
> > anywhere.
> Indeed the intention was that the global interrupt flag is cleared
> beforehand, and only enabled on the next line below. However, I realize
> I missed disabling it for the new atomic case.
>=20
> I'm not so sure anymore that this patch is an improvement. What do you
> think? I can send a v4 with a fix, or I am fine with skipping this
> patch. I would at least like the other two to be merged for -fixes.

Sure, first two patches will go in regardless. I'm not convinced of value o=
f=20
this patch either. I guess we can skip it.

Best regards,
Jernej

>=20
> Regards,
> Samuel
>=20
> >>  	writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
> >>  =09
> >>  	       rsb->regs + RSB_CTRL);
> >>=20
> >> @@ -286,7 +287,6 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *r=
sb)
> >>=20
> >>  		timeout =3D readl_poll_timeout_atomic(rsb->regs +=20
RSB_INTS,
> >>  	=09
> >>  						   =20
status, (status & int_mask),
> >>  						    10,=20
100000);
> >>=20
> >> -		writel(status, rsb->regs + RSB_INTS);
> >>=20
> >>  	} else {
> >>  =09
> >>  		timeout =3D !wait_for_completion_io_timeout(&rsb-
> >>=20
> >> complete,
> >>=20
> >>  						=09
  msecs_to_jiffies(100));
> >>=20
> >> @@ -296,12 +296,9 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb
> >> *rsb)
> >>=20
> >>  	if (timeout) {
> >>  =09
> >>  		dev_dbg(rsb->dev, "RSB timeout\n");
> >>=20
> >> -		/* abort the transfer */
> >> +		/* abort the transfer and disable interrupts */
> >>=20
> >>  		writel(RSB_CTRL_ABORT_TRANS, rsb->regs + RSB_CTRL);
> >>=20
> >> -		/* clear any interrupt flags */
> >> -		writel(readl(rsb->regs + RSB_INTS), rsb->regs +=20
RSB_INTS);
> >> -
> >>=20
> >>  		return -ETIMEDOUT;
> >>  =09
> >>  	}
> >>=20
> >> @@ -503,15 +500,11 @@ EXPORT_SYMBOL_GPL(__devm_regmap_init_sunxi_rsb);
> >>=20
> >>  static irqreturn_t sunxi_rsb_irq(int irq, void *dev_id)
> >>  {
> >> =20
> >>  	struct sunxi_rsb *rsb =3D dev_id;
> >>=20
> >> -	u32 status;
> >>=20
> >> -	status =3D readl(rsb->regs + RSB_INTS);
> >> -	rsb->status =3D status;
> >> +	/* disable interrupts */
> >> +	writel(0, rsb->regs + RSB_CTRL);
> >>=20
> >> -	/* Clear interrupts */
> >> -	status &=3D (RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR |
> >> -		   RSB_INTS_TRANS_OVER);
> >> -	writel(status, rsb->regs + RSB_INTS);
> >> +	rsb->status =3D readl(rsb->regs + RSB_INTS);
> >>=20
> >>  	complete(&rsb->complete);
> >>=20
> >> @@ -532,9 +525,6 @@ static int sunxi_rsb_init_device_mode(struct
> >> sunxi_rsb
> >> *rsb) if (reg & RSB_DMCR_DEVICE_START)
> >>=20
> >>  		ret =3D -ETIMEDOUT;
> >>=20
> >> -	/* clear interrupt status bits */
> >> -	writel(readl(rsb->regs + RSB_INTS), rsb->regs + RSB_INTS);
> >> -
> >>=20
> >>  	return ret;
> >> =20
> >>  }




