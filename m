Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6D262F908
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbiKRPNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242247AbiKRPNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:13:09 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207803C6E4;
        Fri, 18 Nov 2022 07:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668784388; x=1700320388;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5o88/se2tIugNJ6foutVgd4SrFrr/hRNWGIbanNCAN8=;
  b=NywkP9YFt+y0u0IuMl21URk02e2bSUkRpGV9sf7Wx2iZE2v8m+7oT1+k
   paiARjXT9ZtyFnCmKai/hGTLwtjvXVyalY46/hjcdMFm7BCYl2K6C67GL
   k0+Ed8tks+Ixd46fceKcrB7iRzXesTjH5x8c4GjhfgzEviUSxDdl5afZ1
   yIo3c5Z9eoi2PowHwmKXYYISuLBuG0gTbPjjsk0u8QRK/PoqMV+guKPty
   7ZlqDded25htCQAZ5YmNkdlyPiSNxLgM3ufyon3hAs3C75PSIYIsUU1rv
   JAwniCuTMxWFmBxErTd8W6e3e8fq21FJcvLqOplHp0ki1fUnLw4z6M7cE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="314972625"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="314972625"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 07:12:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="729256172"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="729256172"
Received: from amulyuko-mobl1.ccr.corp.intel.com ([10.252.35.83])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 07:12:53 -0800
Date:   Fri, 18 Nov 2022 17:12:53 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 06/15] tty: serial: qcom-geni-serial: refactor
 qcom_geni_serial_isr()
In-Reply-To: <20221118122539.384993-7-brgl@bgdev.pl>
Message-ID: <c08d484-f4b7-e8c1-5d66-827b4a6fb71c@linux.intel.com>
References: <20221118122539.384993-1-brgl@bgdev.pl> <20221118122539.384993-7-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1438676183-1668784378=:3952"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1438676183-1668784378=:3952
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 18 Nov 2022, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Simplify the conditions in qcom_geni_serial_isr() and fix indentation.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index dd1491a72deb..22c1869c60f4 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -824,20 +824,18 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>  
>  	if (m_irq_status & m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
>  		qcom_geni_serial_handle_tx(uport, m_irq_status & M_CMD_DONE_EN,
> -					geni_status & M_GENI_CMD_ACTIVE);
> +					   geni_status & M_GENI_CMD_ACTIVE);
>  
> -	if (s_irq_status & S_GP_IRQ_0_EN || s_irq_status & S_GP_IRQ_1_EN) {
> +	if (s_irq_status & (S_GP_IRQ_0_EN | S_GP_IRQ_1_EN)) {
>  		if (s_irq_status & S_GP_IRQ_0_EN)
>  			uport->icount.parity++;
>  		drop_rx = true;
> -	} else if (s_irq_status & S_GP_IRQ_2_EN ||
> -					s_irq_status & S_GP_IRQ_3_EN) {
> +	} else if (s_irq_status & (S_GP_IRQ_2_EN | S_GP_IRQ_3_EN)) {
>  		uport->icount.brk++;
>  		port->brk = true;
>  	}
>  
> -	if (s_irq_status & S_RX_FIFO_WATERMARK_EN ||
> -					s_irq_status & S_RX_FIFO_LAST_EN)
> +	if (s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN))
>  		qcom_geni_serial_handle_rx(uport, drop_rx);
>  
>  out_unlock:
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1438676183-1668784378=:3952--
