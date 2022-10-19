Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496FF6040CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJSKTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiJSKSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:18:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2435510A7C9;
        Wed, 19 Oct 2022 02:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666173521; x=1697709521;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9dSAc1UFg4UrWGr+WusmcEeV8LdPl63/4+kSRPsPwNY=;
  b=JawsDlwJSLRkt2mBl0ShSTAsAu3aJuozJB1k3Ou37BcMjHjRNgs3IySp
   XT1XGQFMDxC+I2a9I5CcxLxoEI+PF1VMShhuEbN925rhRx8Tilne5T1LG
   QBfLEA4JE6YwvOx118tDLFdqI9eUJE2NOjzeGkroweTejTgHJzLHuHDxp
   BDCB59y3rSa1AJuHF/NGhEJ9XTOFCat0R4LoZ1Ncl5yzZPO7gMR1yv21S
   AfAcjlNEQcQVYefLbf960Uwz6uJTGDvKEx+gDhQzkn8yiW2knaB1Jo2Qh
   B+XJZRuoVWGtLLzapxV30zJiZ8U7jACv9vuXd5EC5at/IZPd5rIEQiJsj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="308041281"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="308041281"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="804206433"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="804206433"
Received: from sponnura-mobl1.amr.corp.intel.com ([10.251.214.35])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:12:59 -0700
Date:   Wed, 19 Oct 2022 12:12:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Kartik <kkartik@nvidia.com>
cc:     ldewangan@nvidia.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alan@linux.intel.com, swarren@nvidia.com,
        akhilrajeev@nvidia.com, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: tegra: Read DMA status before terminating
In-Reply-To: <1666105086-17326-1-git-send-email-kkartik@nvidia.com>
Message-ID: <a579bb7-1895-19e4-d189-911c74cce69a@linux.intel.com>
References: <1666105086-17326-1-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-812515331-1666170783=:1619"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-812515331-1666170783=:1619
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 18 Oct 2022, Kartik wrote:

> Read the DMA status before terminating the DMA, as doing so deletes
> the DMA desc.
> 
> Also, to get the correct transfer status information, pause the DMA
> using dmaengine_pause() before reading the DMA status.
> 
> Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
> v1->v2:
>  * Pause the DMA before reading the DMA status.
>  * Updated commit message.
> 
>  drivers/tty/serial/serial-tegra.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
> index b7170cb9a544..cda9cd4fa92c 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -619,8 +619,9 @@ static void tegra_uart_stop_tx(struct uart_port *u)
>  	if (tup->tx_in_progress != TEGRA_UART_TX_DMA)
>  		return;
>  
> -	dmaengine_terminate_all(tup->tx_dma_chan);
> +	dmaengine_pause(tup->tx_dma_chan);
>  	dmaengine_tx_status(tup->tx_dma_chan, tup->tx_cookie, &state);
> +	dmaengine_terminate_all(tup->tx_dma_chan);
>  	count = tup->tx_bytes_requested - state.residue;
>  	async_tx_ack(tup->tx_dma_desc);
>  	uart_xmit_advance(&tup->uport, count);
> @@ -763,8 +764,9 @@ static void tegra_uart_terminate_rx_dma(struct tegra_uart_port *tup)
>  		return;
>  	}
>  
> -	dmaengine_terminate_all(tup->rx_dma_chan);
> +	dmaengine_pause(tup->rx_dma_chan);
>  	dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
> +	dmaengine_terminate_all(tup->rx_dma_chan);
>  
>  	tegra_uart_rx_buffer_push(tup, state.residue);
>  	tup->rx_dma_active = false;

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-812515331-1666170783=:1619--
