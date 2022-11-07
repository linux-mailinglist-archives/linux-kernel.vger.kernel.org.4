Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0855A61F1DF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiKGLam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiKGLaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:30:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9765F186CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:30:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7858B1FB;
        Mon,  7 Nov 2022 03:30:44 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D99C3F73D;
        Mon,  7 Nov 2022 03:30:37 -0800 (PST)
Date:   Mon, 7 Nov 2022 11:30:29 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 2/2] bus: sunxi-rsb: Support atomic transfers
Message-ID: <20221107112949.21f52e50@donnerap.cambridge.arm.com>
In-Reply-To: <20221107052201.65477-3-samuel@sholland.org>
References: <20221107052201.65477-1-samuel@sholland.org>
        <20221107052201.65477-3-samuel@sholland.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  6 Nov 2022 23:22:00 -0600
Samuel Holland <samuel@sholland.org> wrote:

Hi,

> When communicating with a PMIC during system poweroff (pm_power_off()),
> IRQs are disabled and we are in a RCU read-side critical section, so we
> cannot use wait_for_completion_io_timeout(). Instead, poll the status
> register for transfer completion.
> 
> Fixes: d787dcdb9c8f ("bus: sunxi-rsb: Add driver for Allwinner Reduced Serial Bus")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v2:
>  - Add Fixes tag to patch 2
>  - Only check for specific status bits when polling
> 
>  drivers/bus/sunxi-rsb.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> index 17343cd75338..012e82f9b7b0 100644
> --- a/drivers/bus/sunxi-rsb.c
> +++ b/drivers/bus/sunxi-rsb.c
> @@ -267,6 +267,9 @@ EXPORT_SYMBOL_GPL(sunxi_rsb_driver_register);
>  /* common code that starts a transfer */
>  static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>  {
> +	u32 int_mask, status;
> +	bool timeout;
> +
>  	if (readl(rsb->regs + RSB_CTRL) & RSB_CTRL_START_TRANS) {
>  		dev_dbg(rsb->dev, "RSB transfer still in progress\n");
>  		return -EBUSY;
> @@ -274,13 +277,23 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>  
>  	reinit_completion(&rsb->complete);
>  
> -	writel(RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER,
> +	int_mask = RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER;
> +	writel(int_mask,
>  	       rsb->regs + RSB_INTE);
>  	writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
>  	       rsb->regs + RSB_CTRL);
>  
> -	if (!wait_for_completion_io_timeout(&rsb->complete,
> -					    msecs_to_jiffies(100))) {
> +	if (irqs_disabled()) {
> +		timeout = readl_poll_timeout_atomic(rsb->regs + RSB_INTS,
> +						    status, (status & int_mask),
> +						    10, 100000);

So if I understand correctly, this mimics the operation of
sunxi_rsb_irq(), just replacing rsb->status with status.
But wouldn't that also mean that we need to clear the interrupt bits in
INTS, since we are about to handle them below?

It probably doesn't matter in practise, since we call this during power
down only, but looks like more robust to do, from a driver's perspective.

Cheers,
Andre

> +	} else {
> +		timeout = !wait_for_completion_io_timeout(&rsb->complete,
> +							  msecs_to_jiffies(100));
> +		status = rsb->status;
> +	}
> +
> +	if (timeout) {
>  		dev_dbg(rsb->dev, "RSB timeout\n");
>  
>  		/* abort the transfer */
> @@ -292,18 +305,18 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>  		return -ETIMEDOUT;
>  	}
>  
> -	if (rsb->status & RSB_INTS_LOAD_BSY) {
> +	if (status & RSB_INTS_LOAD_BSY) {
>  		dev_dbg(rsb->dev, "RSB busy\n");
>  		return -EBUSY;
>  	}
>  
> -	if (rsb->status & RSB_INTS_TRANS_ERR) {
> -		if (rsb->status & RSB_INTS_TRANS_ERR_ACK) {
> +	if (status & RSB_INTS_TRANS_ERR) {
> +		if (status & RSB_INTS_TRANS_ERR_ACK) {
>  			dev_dbg(rsb->dev, "RSB slave nack\n");
>  			return -EINVAL;
>  		}
>  
> -		if (rsb->status & RSB_INTS_TRANS_ERR_DATA) {
> +		if (status & RSB_INTS_TRANS_ERR_DATA) {
>  			dev_dbg(rsb->dev, "RSB transfer data error\n");
>  			return -EIO;
>  		}

