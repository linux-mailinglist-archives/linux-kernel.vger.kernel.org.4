Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A5F5B86E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiINLBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiINLBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:01:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAAD3868D;
        Wed, 14 Sep 2022 04:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663153311; x=1694689311;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PI6dLaz7Q7YTxqro4grLrUsNnhd5YYxFvz+UTSEb2u4=;
  b=bDHZlxknDvgwCO3eM9YV5ISGrW5hLwBLBOWkj8fH45VJ6YnLJxm8v8oz
   uW5++gO5oALGho2mhJpYPki/zkCNNjHYHcAmL+OUDIIu4JP7cUWmL03tK
   1v6wH2fpwdUrDyaMYUJwDF4lv3mHgWVCTxyhPn17fRsZ55CitoiowWO4g
   XVgesmg+NYSlkPlwjs7CS1RJP3HnJWbfn7CkKxwb4mhEd9UHKa5pTD0+f
   oGbSozCELjWznRk+kmiYL2jMpdBU1a4/ubKVldjMqoTOSB1Mzy98WA+Im
   8Wqvo+A0dn0fUcmPVbcyFORR5yvXTLAYF4lfh3gFLLjuAXlir1nOQLXMx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="297129540"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="297129540"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 04:01:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="647348550"
Received: from kkomeyli-mobl4.amr.corp.intel.com ([10.252.46.196])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 04:01:43 -0700
Date:   Wed, 14 Sep 2022 14:01:38 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sergiu Moga <sergiu.moga@microchip.com>
cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        broonie@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        Jiri Slaby <jirislaby@kernel.org>, admin@hifiphile.com,
        kavyasree.kotagiri@microchip.com, tudor.ambarus@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 12/14] tty: serial: atmel: Only divide Clock Divisor
 if the IP is USART
In-Reply-To: <20220913142205.162399-13-sergiu.moga@microchip.com>
Message-ID: <13397da3-274f-7180-d185-a4377d251978@linux.intel.com>
References: <20220913142205.162399-1-sergiu.moga@microchip.com> <20220913142205.162399-13-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022, Sergiu Moga wrote:

> Make sure that the driver only divides the clock divisor if the
> IP handled at that point is USART, since UART IP's do not support
> implicit peripheral clock division. Instead, in the case of UART,
> go with the highest possible clock divisor.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
> 
> 
> v1 -> v2:
> - Nothing, this patch was not here before and is mainly meant as both cleanup
> and as a way to introduce a new field into struct atmel_uart_port that will be
> used by the last patch to diferentiate between USART and UART regarding the
> location of the Baudrate Clock Source bitmask.
> 
> 
> 
> v2 -> v3:
> - Use ATMEL_US_CD instead of 65535
> - Previously [PATCH 10]


> @@ -2283,10 +2287,21 @@ static void atmel_set_termios(struct uart_port *port,
>  		cd = uart_get_divisor(port, baud);
>  	}
>  
> -	if (cd > 65535) {	/* BRGR is 16-bit, so switch to slower clock */
> +	/*
> +	 * If the current value of the Clock Divisor surpasses the 16 bit
> +	 * ATMEL_US_CD mask and the IP is USART, switch to the Peripheral
> +	 * Clock implicitly divided by 8.
> +	 * If the IP is UART however, keep the highest possible value for
> +	 * the CD and avoid needless division of CD, since UART IP's do not
> +	 * support implicit division of the Peripheral Clock.
> +	 */
> +	if (atmel_port->is_usart && cd > ATMEL_US_CD) {
>  		cd /= 8;
>  		mode |= ATMEL_US_USCLKS_MCK_DIV8;
> +	} else {
> +		cd &= ATMEL_US_CD;

Now that I read the above comment with more thought, would:
		cd = min(cd, ATMEL_US_CD);
be more appropriate here if "the highest possible value" is sought for?


-- 
 i.

