Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FED5B56BE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiILIwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiILIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:52:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AE012621;
        Mon, 12 Sep 2022 01:52:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EA2831FD05;
        Mon, 12 Sep 2022 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662972756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrEPOpC6RMrJZKG5SGOheqONS2NkCVotDwBL3ONmMr8=;
        b=Kq1bmzcUiqmQHNsF/jhZcPASkI+Kb8xbW2GB+iyhsCXnZmDZ7W7e11v/lKUH7iF2xRXUxK
        3d3zQoXf9NKRcQizJ8EZsJnt0h6WzJUUlBrF+p3BLCgFa3ivMDjDECHhLz0LYVE3mIUJIL
        1kYBJ/EjIe9rnXgTH1T1SdF5wAgyd+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662972756;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrEPOpC6RMrJZKG5SGOheqONS2NkCVotDwBL3ONmMr8=;
        b=EXfxBZOLY/woL4HAc486PqQ++Nq+33rlt+AGjbEXZGn1ZIf2nR75TqaEDc/LS1FVAya99r
        iMsK9xaLPXGbqSAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9CE5139E0;
        Mon, 12 Sep 2022 08:52:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X3EENVTzHmOhNQAAMHmgww
        (envelope-from <iivanov@suse.de>); Mon, 12 Sep 2022 08:52:36 +0000
MIME-Version: 1.0
Date:   Mon, 12 Sep 2022 11:52:36 +0300
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Phil Elwell <phil@raspberrypi.com>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] clk: bcm2835: Round UART input clock up
In-Reply-To: <20220912081306.24662-1-iivanov@suse.de>
References: <20220912081306.24662-1-iivanov@suse.de>
User-Agent: Roundcube Webmail
Message-ID: <1f41b47acc9abd5ddf728c87fbab46a5@suse.de>
X-Sender: iivanov@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I am sorry, forgot to add change log.

Change since v4:
* Rename rounding function and it parameter from clock to rate.
* Fix double ;; typo.

Regards,
Ivan

On 2022-09-12 11:13, Ivan T. Ivanov wrote:
> It was reported that RPi3[1] and RPi Zero 2W boards have issues with
> the Bluetooth. It turns out that when switching from initial to
> operation speed host and device no longer can talk each other because
> host uses incorrect UART baud rate.
> 
> The UART driver used in this case is amba-pl011. Original fix, see
> below Github link[2], was inside pl011 module, but somehow it didn't
> look as the right place to fix. Beside that this original rounding
> function is not exactly perfect for all possible clock values. So I
> deiced to move the hack to the platform which actually need it.
> 
> The UART clock is initialised to be as close to the requested
> frequency as possible without exceeding it. Now that there is a
> clock manager that returns the actual frequencies, an expected
> 48MHz clock is reported as 47999625. If the requested baud rate
> == requested clock/16, there is no headroom and the slight
> reduction in actual clock rate results in failure.
> 
> If increasing a clock by less than 0.1% changes it from ..999..
> to ..000.., round it up.
> 
> [1] https://bugzilla.suse.com/show_bug.cgi?id=1188238
> [2] 
> https://github.com/raspberrypi/linux/commit/ab3f1b39537f6d3825b8873006fbe2fc5ff057b7
> 
> Cc: Phil Elwell <phil@raspberrypi.com>
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/clk/bcm/clk-bcm2835.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/bcm/clk-bcm2835.c 
> b/drivers/clk/bcm/clk-bcm2835.c
> index 48a1eb9f2d55..4361ec4c659a 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -30,6 +30,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/math.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -502,6 +503,8 @@ struct bcm2835_clock_data {
>  	bool low_jitter;
> 
>  	u32 tcnt_mux;
> +
> +	bool round_up;
>  };
> 
>  struct bcm2835_gate_data {
> @@ -993,12 +996,34 @@ static long
> bcm2835_clock_rate_from_divisor(struct bcm2835_clock *clock,
>  	return temp;
>  }
> 
> +static unsigned long bcm2835_round_rate(unsigned long rate)
> +{
> +	unsigned long scaler;
> +	unsigned long limit;
> +
> +	limit = rate / 100000;
> +
> +	scaler = 1;
> +	while (scaler < limit)
> +		scaler *= 10;
> +
> +	/*
> +	 * If increasing a clock by less than 0.1% changes it
> +	 * from ..999.. to ..000.., round up.
> +	 */
> +	if ((rate + scaler - 1) / scaler % 1000 == 0)
> +		rate = roundup(rate, scaler);
> +
> +	return rate;
> +}
> +
>  static unsigned long bcm2835_clock_get_rate(struct clk_hw *hw,
>  					    unsigned long parent_rate)
>  {
>  	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
>  	struct bcm2835_cprman *cprman = clock->cprman;
>  	const struct bcm2835_clock_data *data = clock->data;
> +	unsigned long rate;
>  	u32 div;
> 
>  	if (data->int_bits == 0 && data->frac_bits == 0)
> @@ -1006,7 +1031,12 @@ static unsigned long
> bcm2835_clock_get_rate(struct clk_hw *hw,
> 
>  	div = cprman_read(cprman, data->div_reg);
> 
> -	return bcm2835_clock_rate_from_divisor(clock, parent_rate, div);
> +	rate = bcm2835_clock_rate_from_divisor(clock, parent_rate, div);
> +
> +	if (data->round_up)
> +		rate = bcm2835_round_rate(rate);
> +
> +	return rate;
>  }
> 
>  static void bcm2835_clock_wait_busy(struct bcm2835_clock *clock)
> @@ -2143,7 +2173,8 @@ static const struct bcm2835_clk_desc 
> clk_desc_array[] = {
>  		.div_reg = CM_UARTDIV,
>  		.int_bits = 10,
>  		.frac_bits = 12,
> -		.tcnt_mux = 28),
> +		.tcnt_mux = 28,
> +		.round_up = true),
> 
>  	/* TV encoder clock.  Only operating frequency is 108Mhz.  */
>  	[BCM2835_CLOCK_VEC]	= REGISTER_PER_CLK(
