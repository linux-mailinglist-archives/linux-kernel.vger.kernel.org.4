Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F3A61FCDE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiKGSJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiKGSJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:09:03 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F2DBE1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:05:36 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x2so18891686edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCTpqEx+nj1n6HjmRbfujsCzReaOepaCfo3WlWBlSOs=;
        b=kkw8H1QERm0GF5D+iS4KT6fZ4SYYp6uvTjhGEoGPgwq4dVWvWQjaCel2y3WVJlaOaE
         e5RStAF8t1Pu63/2phYMxZ3eMnlV8avzvgW8eaZg0kjlNhuonZsrQ+N3F29oFWWrbQJa
         0XVweEG5LvZrQIkVPfXx6PQxtjzmogkRZ8eqbG/jSCdy2MHJMkMLcPkpBEt1otOhJYmn
         /5Sc1TtwiGnxrxCE2p+iu+jd3zCXnPCD0XO8jVbQI6zSVlLPWgVWZ53XA5kXJlQFadqg
         et0hOf+R8C8fwCn5J8LpjKtYNuZiFG6vjBLWY1Oo5dx42Q4PDYm3/bFeE+WuqhN6s16z
         avfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCTpqEx+nj1n6HjmRbfujsCzReaOepaCfo3WlWBlSOs=;
        b=t0DhpKys9h+VGkEFVZFE8rdl2jO65MAi0RIFs927vsAN2KWKxIaH1359+cknyOgKqK
         ymOF2TF9f7T3A1rZXKi/rwtjzAdMdVIVnEJ8rN5JhucJ7mbixP3FtVaRd1aNOzmZRGwW
         4E/tCViJf+sHh6GczNnY1xJ5NqnveGOl7leOQVvdKWlBUDzoMi5ZupCKMdZkvqWVxcri
         4EzW7gnvblDse5nqDVXC0aX5822YXpiEZ9C0rnjwIduopJWPvj6x850l+Vrc73aTBhbL
         XbMjehjIhwHKDCIypf1rjKY39XXyY82zb6hm5aPgm0qWlptV8NcI5SkTC+SxY08bOPoA
         HOOg==
X-Gm-Message-State: ACrzQf3ee83MuxlY+9nHU9hhgOp/5zeXwd344I+udQ2aNG00D2vaTGp+
        yNPbuQ4OmqvP4fBGS71ZaEw=
X-Google-Smtp-Source: AMsMyM6Goj84logVrQ5XP20UoYPJnj8X72vsGoAAviPjLBcIzvX+wqD4eLNfV4AQDTIEyo+FSyuFaQ==
X-Received: by 2002:a05:6402:1d4f:b0:461:d2ed:788c with SMTP id dz15-20020a0564021d4f00b00461d2ed788cmr51595245edb.418.1667844335245;
        Mon, 07 Nov 2022 10:05:35 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id p20-20020a17090653d400b007adf2e4c6f7sm3694732ejo.195.2022.11.07.10.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:05:34 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: Re: [PATCH v2 2/2] bus: sunxi-rsb: Support atomic transfers
Date:   Mon, 07 Nov 2022 19:05:33 +0100
Message-ID: <1929426.usQuhbGJ8B@kista>
In-Reply-To: <20221107112949.21f52e50@donnerap.cambridge.arm.com>
References: <20221107052201.65477-1-samuel@sholland.org> <20221107052201.65477-3-samuel@sholland.org> <20221107112949.21f52e50@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 07. november 2022 ob 12:30:29 CET je Andre Przywara 
napisal(a):
> On Sun,  6 Nov 2022 23:22:00 -0600
> Samuel Holland <samuel@sholland.org> wrote:
> 
> Hi,
> 
> > When communicating with a PMIC during system poweroff (pm_power_off()),
> > IRQs are disabled and we are in a RCU read-side critical section, so we
> > cannot use wait_for_completion_io_timeout(). Instead, poll the status
> > register for transfer completion.
> > 
> > Fixes: d787dcdb9c8f ("bus: sunxi-rsb: Add driver for Allwinner Reduced
> > Serial Bus") Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> > 
> > Changes in v2:
> >  - Add Fixes tag to patch 2
> >  - Only check for specific status bits when polling
> >  
> >  drivers/bus/sunxi-rsb.c | 27 ++++++++++++++++++++-------
> >  1 file changed, 20 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> > index 17343cd75338..012e82f9b7b0 100644
> > --- a/drivers/bus/sunxi-rsb.c
> > +++ b/drivers/bus/sunxi-rsb.c
> > @@ -267,6 +267,9 @@ EXPORT_SYMBOL_GPL(sunxi_rsb_driver_register);
> > 
> >  /* common code that starts a transfer */
> >  static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
> >  {
> > 
> > +	u32 int_mask, status;
> > +	bool timeout;
> > +
> > 
> >  	if (readl(rsb->regs + RSB_CTRL) & RSB_CTRL_START_TRANS) {
> >  	
> >  		dev_dbg(rsb->dev, "RSB transfer still in progress\n");
> >  		return -EBUSY;
> > 
> > @@ -274,13 +277,23 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb
> > *rsb)
> > 
> >  	reinit_completion(&rsb->complete);
> > 
> > -	writel(RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | 
RSB_INTS_TRANS_OVER,
> > +	int_mask = RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | 
RSB_INTS_TRANS_OVER;
> > +	writel(int_mask,
> > 
> >  	       rsb->regs + RSB_INTE);
> >  	
> >  	writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
> >  	
> >  	       rsb->regs + RSB_CTRL);
> > 
> > -	if (!wait_for_completion_io_timeout(&rsb->complete,
> > -					    
msecs_to_jiffies(100))) {
> > +	if (irqs_disabled()) {
> > +		timeout = readl_poll_timeout_atomic(rsb->regs + 
RSB_INTS,
> > +						    status, 
(status & int_mask),
> > +						    10, 
100000);
> 
> So if I understand correctly, this mimics the operation of
> sunxi_rsb_irq(), just replacing rsb->status with status.
> But wouldn't that also mean that we need to clear the interrupt bits in
> INTS, since we are about to handle them below?

Yes, I pointed out that in review of v1.

Best regards,
Jernej

> 
> It probably doesn't matter in practise, since we call this during power
> down only, but looks like more robust to do, from a driver's perspective.
> 
> Cheers,
> Andre
> 
> > +	} else {
> > +		timeout = !wait_for_completion_io_timeout(&rsb-
>complete,
> > +							  
msecs_to_jiffies(100));
> > +		status = rsb->status;
> > +	}
> > +
> > +	if (timeout) {
> > 
> >  		dev_dbg(rsb->dev, "RSB timeout\n");
> >  		
> >  		/* abort the transfer */
> > 
> > @@ -292,18 +305,18 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb
> > *rsb)
> > 
> >  		return -ETIMEDOUT;
> >  	
> >  	}
> > 
> > -	if (rsb->status & RSB_INTS_LOAD_BSY) {
> > +	if (status & RSB_INTS_LOAD_BSY) {
> > 
> >  		dev_dbg(rsb->dev, "RSB busy\n");
> >  		return -EBUSY;
> >  	
> >  	}
> > 
> > -	if (rsb->status & RSB_INTS_TRANS_ERR) {
> > -		if (rsb->status & RSB_INTS_TRANS_ERR_ACK) {
> > +	if (status & RSB_INTS_TRANS_ERR) {
> > +		if (status & RSB_INTS_TRANS_ERR_ACK) {
> > 
> >  			dev_dbg(rsb->dev, "RSB slave nack\n");
> >  			return -EINVAL;
> >  		
> >  		}
> > 
> > -		if (rsb->status & RSB_INTS_TRANS_ERR_DATA) {
> > +		if (status & RSB_INTS_TRANS_ERR_DATA) {
> > 
> >  			dev_dbg(rsb->dev, "RSB transfer data 
error\n");
> >  			return -EIO;
> >  		
> >  		}


