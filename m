Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721BE625FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiKKQmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiKKQm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:42:29 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069878546F;
        Fri, 11 Nov 2022 08:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668184946; x=1699720946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xo9zWJnr1AaY4coMz3PslVlhPxbfw1UObfs/irsmF6o=;
  b=iAFREIaXxZWXZzpvWBWvMcDLEpehNwfPvcWsvBexRxtEsOoIdDw12Qwr
   +67km0Bj8p6BENQhvmqj5xvLCT9dJvsz5mSZ03oYWZkeiaCTSOC3QVd4U
   F6KHj3lfVJj6PoPBiw2QnvnrLTReXiQt+oYk9YA3Za7ocz7Dc7/P8Jj/O
   iss5tF1BllOadt4WNNTvFtiltmuGfVkVH999xOUe8NhrtAIA1zs31Ipiy
   P42tzeND0/4eQiJZyp/ddTOt68qbY1ozqiPqtoETY3+npnYPmAnCFlREH
   phZoqxYJV20ODMMQJh0qndNqJw8sIcXvbX96PdAyI1QixFYY98SuFXLV4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="338400808"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="338400808"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 08:42:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="966871067"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="966871067"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 11 Nov 2022 08:42:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1otX6V-00AngD-18;
        Fri, 11 Nov 2022 18:42:07 +0200
Date:   Fri, 11 Nov 2022 18:42:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk,
        jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, lukas@wunner.de,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v4 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
 support to quad-uart driver
Message-ID: <Y257X+pkCRtzg7I4@smile.fi.intel.com>
References: <20221111161130.2043882-1-kumaravel.thiagarajan@microchip.com>
 <20221111161130.2043882-3-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111161130.2043882-3-kumaravel.thiagarajan@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 09:41:29PM +0530, Kumaravel Thiagarajan wrote:
> pci1xxxx uart supports rs485 mode of operation in the hardware with

UART
RS485 (same in the subject)

> auto-direction control with configurable delay for releasing RTS after
> the transmission. This patch adds support for the rs485 mode.

RS485

...

> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>

No Co-developed-by?

...

> +static int pci1xxxx_rs485_config(struct uart_port *port,
> +				 struct ktermios *termios,
> +				 struct serial_rs485 *rs485)
> +{
> +	u32 clock_div = readl(port->membase + UART_BAUD_CLK_DIVISOR_REG);

> +	u8 delay_in_baud_periods = 0;
> +	u32 baud_period_in_ns = 0;

Why these assignments?

> +	u32 data = 0;
> +
> +	/* pci1xxxx's uart hardware supports only RTS delay after
> +	 * Tx and in units of bit times to a maximum of 15
> +	 */

/*
 * Use proper multi-line
 * comment style.
 */

> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		data = ADCL_CFG_EN | ADCL_CFG_PIN_SEL;
> +
> +		if (!(rs485->flags & SER_RS485_RTS_ON_SEND))
> +			data |= ADCL_CFG_POL_SEL;
> +
> +		if (rs485->delay_rts_after_send) {
> +			baud_period_in_ns =
> +				FIELD_GET(BAUD_CLOCK_DIV_INT_MSK, clock_div) *
> +				UART_BIT_SAMPLE_CNT;
> +			delay_in_baud_periods =
> +				(rs485->delay_rts_after_send * NSEC_PER_MSEC) /
> +				baud_period_in_ns;
> +			delay_in_baud_periods =
> +				min_t(u8, delay_in_baud_periods,
> +				      FIELD_MAX(ADCL_CFG_RTS_DELAY_MASK));
> +			data |= FIELD_PREP(ADCL_CFG_RTS_DELAY_MASK,
> +					   delay_in_baud_periods);
> +			rs485->delay_rts_after_send =
> +				(baud_period_in_ns * delay_in_baud_periods) /
> +				NSEC_PER_MSEC;
> +			rs485->delay_rts_before_send = 0;
> +		}
> +	}
> +	writel(data, port->membase + ADCL_CFG_REG);
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


