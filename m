Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974DF64595F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLGLyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiLGLyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:54:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F2453EC6;
        Wed,  7 Dec 2022 03:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670414003; x=1701950003;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yi1CvoW2ZnYsJeWqpB1M54BgrX9F2wgmCB/vqXuVrZQ=;
  b=lkU7GPc/fqdJNcBL7nvCYyXOKx7PVW4jLKucUTauKGLstdaAx0W8b7aV
   GvQmksnbe3xuUlVTOBYvI6rSUUyHOGKmFMyqk+dg7ltKrc2KFVgkVe8YF
   +IYHM424iHPwrlRIGundevhgyzmN61jOkp6qk82Kw5ypktsa1/vWSUHiv
   gCj/GkCZJoSagPlORNS8AlBM1mv7e9uuChkpcsjYNxQLzzcPORNdLJpn9
   54m8SxlE+QdubZE3y3mlirSrtxo1J3oCl/uxbag9baOgwP+1j4lmd62Hq
   Ni+3cym7WWmX9aGLF++ahhH05jHCioGaNiDjkcLK4Cvcz88NX2KiWekwr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="343902402"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="343902402"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 03:53:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="753067135"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="753067135"
Received: from mindrei-mobl2.ger.corp.intel.com ([10.249.37.139])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 03:53:18 -0800
Date:   Wed, 7 Dec 2022 13:53:17 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, macro@orcam.me.uk,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        cang1@live.co.uk, colin.i.king@gmail.com,
        phil.edworthy@renesas.com, biju.das.jz@bp.renesas.com,
        geert+renesas@glider.be, Lukas Wunner <lukas@wunner.de>,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v7 tty-next 3/4] serial: 8250_pci1xxxx: Add RS485 support
 to quad-uart driver
In-Reply-To: <20221207235305.695541-4-kumaravel.thiagarajan@microchip.com>
Message-ID: <784d1b68-98b8-324-ad34-7ef13352855@linux.intel.com>
References: <20221207235305.695541-1-kumaravel.thiagarajan@microchip.com> <20221207235305.695541-4-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2022, Kumaravel Thiagarajan wrote:

> pci1xxxx uart supports RS485 mode of operation in the hardware with
> auto-direction control with configurable delay for releasing RTS after
> the transmission. This patch adds support for the RS485 mode.
> 
> Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
> Changes in v7:
> - No Change
> 
> Changes in v6:
> - Modified datatype of delay_in_baud_periods to u64 to avoid overflows
> 
> Changes in v5:
> - Removed unnecessary assignments
> - Corrected styling issues in comments
> 
> Changes in v4:
> - No Change
> 
> Changes in v3:
> - Remove flags sanitization in driver which is taken care in core
> 
> Changes in v2:
> - move pci1xxxx_rs485_config to a separate patch with
>   pci1xxxx_rs485_supported.
> ---
>  drivers/tty/serial/8250/8250_pci1xxxx.c | 49 +++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
> index be554e2d884b..9f0da264314a 100644
> --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> @@ -145,6 +145,53 @@ static void pci1xxxx_set_divisor(struct uart_port *port, unsigned int baud,
>  	       port->membase + UART_BAUD_CLK_DIVISOR_REG);
>  }
>  
> +static int pci1xxxx_rs485_config(struct uart_port *port,
> +				 struct ktermios *termios,
> +				 struct serial_rs485 *rs485)
> +{
> +	u32 clock_div = readl(port->membase + UART_BAUD_CLK_DIVISOR_REG);
> +	u64 delay_in_baud_periods;
> +	u32 baud_period_in_ns;
> +	u32 data = 0;
> +
> +	/*
> +	 * pci1xxxx's uart hardware supports only RTS delay after
> +	 * Tx and in units of bit times to a maximum of 15
> +	 */
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
> +				rs485->delay_rts_after_send * NSEC_PER_MSEC /
> +				baud_period_in_ns;
> +			delay_in_baud_periods =
> +				min_t(u64, delay_in_baud_periods,
> +				      FIELD_MAX(ADCL_CFG_RTS_DELAY_MASK));
> +			data |= FIELD_PREP(ADCL_CFG_RTS_DELAY_MASK,
> +					   delay_in_baud_periods);
> +			rs485->delay_rts_after_send =
> +				baud_period_in_ns * delay_in_baud_periods /
> +				NSEC_PER_MSEC;

div_u64() or cast+comment if you can prove you never need the high-word at 
this point.

But why you even need u64 because delay_rts_after_send is limited to 
RS485_MAX_RTS_DELAY (=100) by serial core? 100 * NSEC_PER_MSEC doesn't 
overflow u32.


-- 
 i.

