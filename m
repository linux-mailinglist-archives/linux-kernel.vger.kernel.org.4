Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C0A687647
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjBBHOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBBHOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:14:15 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02C75AB6B;
        Wed,  1 Feb 2023 23:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675322054; x=1706858054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uE2BQGQx6uGEr8YuYrHWqmG3mhW3rD/PWGl31Wb2xCI=;
  b=Pnr4KlSN7BVVRHq4hu/QSmqyouCGD0tiVHZF7oMcikuD73RnLoTV4/5f
   Hdo3IyvZ6QciD32wqJDtkcNeqmwYHpzqmIPdC/Sk0um0Zzo1qyVHpvULm
   og1C2D34hvgIPWHQOn+AHiT+VGRhAhEbcHppROIClWZ3Fi/UIcPeMVqfH
   9k+uL+2hOyGXqhHIburXe44kfbaSd5gO4nA2Caa9ERObFgXrntmb0EEca
   wHNVmmNLlnchwk7K0KloblHV+3SQZdjP1XFr0YfT3icaWr/d9pSIwySP1
   +rXo41nRyGfEAwX93FQ6IP7uxnJgj7+B7ZGH+24bNtS+1HeOSxNpfcvy4
   w==;
X-IronPort-AV: E=Sophos;i="5.97,266,1669071600"; 
   d="scan'208";a="28816808"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 02 Feb 2023 08:14:11 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 02 Feb 2023 08:14:11 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 02 Feb 2023 08:14:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675322051; x=1706858051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uE2BQGQx6uGEr8YuYrHWqmG3mhW3rD/PWGl31Wb2xCI=;
  b=osOsAn0tOwjbQZj8gR1MYNnrkFdY4eyaDq28o5MnR1tDUXRoAwsM/EWl
   wmhvNOuwXc54yh5Nv7ggE7ZhzU5YMl5IzG6OFsmLepF+TnLcfxjCoVS14
   8yeUglyJb8kXBN7hl0lJWlleIyuc786GARAlWR1D+ATvf5roa5IXc/z+N
   HU0FnIgMONIyvMfiE9fIOaLiO64Zt8LPM0yl2a2SXin6LEbkspVLGdG9F
   FUInYn57wB5pqTp752pcQpZocbZ3GrwaJCwHkzmY58QuuC2eow070UDPm
   OyaQbN/Sq2hoQ05L0ve6SlSDGJzNjgNI4Tz4lwkmPQ0gXqrY1zgIgFbDe
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,266,1669071600"; 
   d="scan'208";a="28816807"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 02 Feb 2023 08:14:11 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 91F4E280056;
        Thu,  2 Feb 2023 08:14:11 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH 5/6] tty: serial: fsl_lpuart: set RTS watermark for lpuart
Date:   Thu, 02 Feb 2023 08:14:09 +0100
Message-ID: <5646686.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230130064449.9564-6-sherry.sun@nxp.com>
References: <20230130064449.9564-1-sherry.sun@nxp.com> <20230130064449.9564-6-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 30. Januar 2023, 07:44:48 CET schrieb Sherry Sun:
> Add RTS watermark support for LPUART. The RX RTS_B output negates when
> the number of empty words in the receive FIFO is greater or equal to
> RTSWATER. Here set the RTSWATER to half of the rxfifo_size.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c
> b/drivers/tty/serial/fsl_lpuart.c index 2789749d3d0d..c35e49a09bcc 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -201,6 +201,7 @@
>  #define UARTDATA_MASK		0x3ff
> 
>  #define UARTMODIR_IREN		0x00020000
> +#define UARTMODIR_RTSWATER	GENMASK(10, 8)
>  #define UARTMODIR_TXCTSSRC	0x00000020
>  #define UARTMODIR_TXCTSC	0x00000010
>  #define UARTMODIR_RXRTSE	0x00000008
> @@ -1573,6 +1574,13 @@ static void lpuart32_setup_watermark(struct
> lpuart_port *sport) (0x0 << UARTWATER_TXWATER_OFF);
>  	lpuart32_write(&sport->port, val, UARTWATER);
> 
> +	/* set RTS watermark */
> +	if (!uart_console(&sport->port)) {
> +		val = lpuart32_read(&sport->port, UARTMODIR);
> +		val |= FIELD_PREP(UARTMODIR_RTSWATER, sport->rxfifo_size 
>> 1);
> +		lpuart32_write(&sport->port, val, UARTMODIR);

On LS1021A these bits are reserved (please refer to QorIQ LS1021A Reference 
manual Rev 3.1 02/2020 section 27.3.6). Is it okay to write to them?

Best regards
Alexander

> +	}
> +
>  	/* Restore cr2 */
>  	lpuart32_write(&sport->port, ctrl_saved, UARTCTRL);
>  }




