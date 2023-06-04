Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E2D721AED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 00:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjFDW5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 18:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjFDW5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 18:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226A7CD;
        Sun,  4 Jun 2023 15:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B23B760A4D;
        Sun,  4 Jun 2023 22:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46A0C433D2;
        Sun,  4 Jun 2023 22:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685919425;
        bh=zfrbgwR0tjxIA4v1/JSiC5rjb7ChMD3y2vHZ5GgJAX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jd+z+tVXgZtxg1eJslxOgJNz2ubn1AYCRm7reB7e2pO4EGR6BI7YlabqkMUlc4CF7
         yqsXsMn4FwcGX3Na4J8Vo9VLhTagb7j/NpIqWMSVmOdu+l72+MjmbVROWaSvX8wot4
         mxYlB4G59Tk9coeqvZHMfc9H+9dd0DKbzojTdWkBion6m3HftLTho6YlADGVpT2F6v
         J9fjHPskXyrp9ZQXdH1tQ2rOQPqtt0SQYecK3UYAdNQGGx1MrAYC3kAw8oCqSoBemy
         +uBKIsY/fo+tTItNWl748qu0f5QLrJOfIXdx8BLa+SSQBgZI6cHcrXC4ddjfwzm+5a
         5FShg5Mre9pGA==
Date:   Mon, 5 Jun 2023 06:56:53 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "open list:CADENCE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] usb: cdns3: fix NCM gadget RX speed 20x slow than
 expection at iMX8QM
Message-ID: <20230604225653.GA258497@nchen-desktop>
References: <20230518154946.3666662-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518154946.3666662-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18 11:49:45, Frank Li wrote:
> At iMX8QM platform, enable NCM gadget and run 'iperf3 -s'.
> At host, run 'iperf3 -V -c fe80::6863:98ff:feef:3e0%enxc6e147509498'
> 
> [  5]   0.00-1.00   sec  1.55 MBytes  13.0 Mbits/sec   90   4.18 KBytes
> [  5]   1.00-2.00   sec  1.44 MBytes  12.0 Mbits/sec   75   4.18 KBytes
> [  5]   2.00-3.00   sec  1.48 MBytes  12.4 Mbits/sec   75   4.18 KBytes
> 
> Expected speed should be bigger than 300Mbits/sec.
> 
> The root cause of this performance drop was found to be data corruption
> happening at 4K borders in some Ethernet packets, leading to TCP
> checksum errors. This corruption occurs from the position
> (4K - (address & 0x7F)) to 4K. The u_ether function's allocation of
> skb_buff reserves 64B, meaning all RX addresses resemble 0xXXXX0040.
> 
> Force trb_burst_size to 16 can fix this problem.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index ccfaebca6faa..1dcadef933e3 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -2097,6 +2097,19 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
>  	else
>  		priv_ep->trb_burst_size = 16;
>  
> +	/*
> +	 * In versions preceding DEV_VER_V2, for example, iMX8QM, there exit the bugs
> +	 * in the DMA. These bugs occur when the trb_burst_size exceeds 16 and the
> +	 * address is not aligned to 128 Bytes (which is a product of the 64-bit AXI
> +	 * and AXI maximum burst length of 16 or 0xF+1, dma_axi_ctrl0[3:0]). This
> +	 * results in data corruption when it crosses the 4K border. The corruption
> +	 * specifically occurs from the position (4K - (address & 0x7F)) to 4K.
> +	 *
> +	 * So force trb_burst_size to 16 at such platform.
> +	 */
> +	if (priv_dev->dev_ver < DEV_VER_V2)
> +		priv_ep->trb_burst_size = 16;
> +
>  	mult = min_t(u8, mult, EP_CFG_MULT_MAX);
>  	buffering = min_t(u8, buffering, EP_CFG_BUFFERING_MAX);
>  	maxburst = min_t(u8, maxburst, EP_CFG_MAXBURST_MAX);
> -- 
> 2.34.1
> 

Acked-by: Peter Chen <peter.chen@kernel.org>

-- 

Thanks,
Peter Chen
