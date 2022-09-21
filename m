Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5105BF98C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIUInq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiIUInk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:43:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588177331B;
        Wed, 21 Sep 2022 01:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663749819; x=1695285819;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GFvWUsBI6PkgCRX8mshboJMjgXfbyH3ZuVvnUjHR6mc=;
  b=KokexMs7KShv01IpxK7tXJa4xucMjv3MeNSJtjTiKxesQt38PGneh7r1
   MyhsI+NbDsoJSIR4Qid/pinXcPSlqSOHJ0Flt3ZBUPkwTztrTmKU0Jj1L
   wEtChesiWp8EGAj2XEaHbaEqt15SyH52mDLaow07MTMOB1k/Avq6KIeIW
   I5oVDP53pvYnWcCSTtdVt9r5gAN4XGXPlsGHr6biOtbJymIRamX/87hun
   OWaci1hlfeFJkBcpiqSkrNbBq867eHQLXM66gdrH8DySqVKOn3nWX7MNV
   mEsRkSxgxcaUxrqrPtwxuDqWhovyMM91cu812fc9wpYoTctyEbnvC3XP/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="297540904"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="297540904"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 01:43:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="744872129"
Received: from dgonsal1-mobl1.ger.corp.intel.com ([10.252.58.151])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 01:43:36 -0700
Date:   Wed, 21 Sep 2022 11:43:29 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sherry Sun <sherry.sun@nxp.com>
cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "bhuvanchandra.dv@toradex.com" <bhuvanchandra.dv@toradex.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: disable dma rx/tx use flags in
 lpuart_dma_shutdown
In-Reply-To: <AS8PR04MB84049C72D2B47640CC32BBDB924C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
Message-ID: <f2be5df-cda5-e18-9beb-5ebd75b6e0bc@linux.intel.com>
References: <20220920111703.1532-1-sherry.sun@nxp.com> <ba937cd2-8a79-5352-c6bc-e553ee9baeed@linux.intel.com> <AS8PR04MB84049C72D2B47640CC32BBDB924C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1239297179-1663749818=:1741"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1239297179-1663749818=:1741
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 20 Sep 2022, Sherry Sun wrote:

> 
> 
> > -----Original Message-----
> > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Sent: 2022年9月20日 20:26
> > To: Sherry Sun <sherry.sun@nxp.com>
> > Cc: gregkh@linuxfoundation.org; jirislaby@kernel.org;
> > bhuvanchandra.dv@toradex.com; linux-serial@vger.kernel.org; linux-
> > kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH] tty: serial: fsl_lpuart: disable dma rx/tx use flags in
> > lpuart_dma_shutdown
> > 
> > On Tue, 20 Sep 2022, Sherry Sun wrote:
> > 
> > > lpuart_dma_shutdown tears down lpuart dma, but lpuart_flush_buffer can
> > > still occur which in turn tries to access dma apis if
> > > lpuart_dma_tx_use flag is true. At this point since dma is torn down,
> > > these dma apis can abort. Set lpuart_dma_tx_use and the corresponding
> > > rx flag lpuart_dma_rx_use to false in lpuart_dma_shutdown so that dmas
> > > are not accessed after they are relinquished.
> > >
> > > Otherwise, when try to kill btattach, kernel may panic. This patch may
> > > fix this issue.
> > > root@imx8ulpevk:~# btattach -B /dev/ttyLP2 -S 115200
> > > ^C[   90.182296] Internal error: synchronous external abort: 96000210 [#1]
> > PREEMPT SMP
> > > [   90.189806] Modules linked in: moal(O) mlan(O)
> > > [   90.194258] CPU: 0 PID: 503 Comm: btattach Tainted: G           O
> > 5.15.32-06136-g34eecdf2f9e4 #37
> > > [   90.203554] Hardware name: NXP i.MX8ULP 9X9 EVK (DT)
> > > [   90.208513] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS
> > BTYPE=--)
> > > [   90.215470] pc : fsl_edma3_disable_request+0x8/0x60
> > > [   90.220358] lr : fsl_edma3_terminate_all+0x34/0x20c
> > > [   90.225237] sp : ffff800013f0bac0
> > > [   90.228548] x29: ffff800013f0bac0 x28: 0000000000000001 x27:
> > ffff000008404800
> > > [   90.235681] x26: ffff000008404960 x25: ffff000008404a08 x24:
> > ffff000008404a00
> > > [   90.242813] x23: ffff000008404a60 x22: 0000000000000002 x21:
> > 0000000000000000
> > > [   90.249946] x20: ffff800013f0baf8 x19: ffff00000559c800 x18:
> > 0000000000000000
> > > [   90.257078] x17: 0000000000000000 x16: 0000000000000000 x15:
> > 0000000000000000
> > > [   90.264211] x14: 0000000000000003 x13: 0000000000000000 x12:
> > 0000000000000040
> > > [   90.271344] x11: ffff00000600c248 x10: ffff800013f0bb10 x9 :
> > ffff000057bcb090
> > > [   90.278477] x8 : fffffc0000241a08 x7 : ffff00000534ee00 x6 :
> > ffff000008404804
> > > [   90.285609] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
> > ffff0000055b3480
> > > [   90.292742] x2 : ffff8000135c0000 x1 : ffff00000534ee00 x0 :
> > ffff00000559c800
> > > [   90.299876] Call trace:
> > > [   90.302321]  fsl_edma3_disable_request+0x8/0x60
> > > [   90.306851]  lpuart_flush_buffer+0x40/0x160
> > > [   90.311037]  uart_flush_buffer+0x88/0x120
> > > [   90.315050]  tty_driver_flush_buffer+0x20/0x30
> > > [   90.319496]  hci_uart_flush+0x44/0x90
> > > [   90.323162]  +0x34/0x12c
> > > [   90.327253]  tty_ldisc_close+0x38/0x70
> > > [   90.331005]  tty_ldisc_release+0xa8/0x190
> > > [   90.335018]  tty_release_struct+0x24/0x8c
> > > [   90.339022]  tty_release+0x3ec/0x4c0
> > > [   90.342593]  __fput+0x70/0x234
> > > [   90.345652]  ____fput+0x14/0x20
> > > [   90.348790]  task_work_run+0x84/0x17c
> > > [   90.352455]  do_exit+0x310/0x96c
> > > [   90.355688]  do_group_exit+0x3c/0xa0
> > > [   90.359259]  __arm64_sys_exit_group+0x1c/0x20
> > > [   90.363609]  invoke_syscall+0x48/0x114
> > > [   90.367362]  el0_svc_common.constprop.0+0xd4/0xfc
> > > [   90.372068]  do_el0_svc+0x2c/0x94
> > > [   90.375379]  el0_svc+0x28/0x80
> > > [   90.378438]  el0t_64_sync_handler+0xa8/0x130
> > > [   90.382711]  el0t_64_sync+0x1a0/0x1a4
> > > [   90.386376] Code: 17ffffda d503201f d503233f f9409802 (b9400041)
> > > [   90.392467] ---[ end trace 2f60524b4a43f1f6 ]---
> > > [   90.397073] note: btattach[503] exited with preempt_count 1
> > > [   90.402636] Fixing recursive fault but reboot is needed!
> > >
> > > Fixes: 6250cc30c4c4 ("tty: serial: fsl_lpuart: Use scatter/gather DMA
> > > for Tx")
> > > Signed-off-by: Thara Gopinath <tgopinath@microsoft.com>
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  drivers/tty/serial/fsl_lpuart.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > b/drivers/tty/serial/fsl_lpuart.c index f21915015d67..064bd1f33c21
> > > 100644
> > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > @@ -1771,6 +1771,7 @@ static void lpuart_dma_shutdown(struct
> > lpuart_port *sport)
> > >  	if (sport->lpuart_dma_rx_use) {
> > >  		del_timer_sync(&sport->lpuart_timer);
> > >  		lpuart_dma_rx_free(&sport->port);
> > > +		sport->lpuart_dma_rx_use = false;
> > >  	}
> > >
> > >  	if (sport->lpuart_dma_tx_use) {
> > > @@ -1779,6 +1780,7 @@ static void lpuart_dma_shutdown(struct
> > lpuart_port *sport)
> > >  			sport->dma_tx_in_progress = false;
> > >  			dmaengine_terminate_all(sport->dma_tx_chan);
> > >  		}
> > > +		sport->lpuart_dma_tx_use = false;
> > >  	}
> > >
> > >  	if (sport->dma_tx_chan)
> > 
> > Isn't it still racy because lpuart_dma_shutdown() is called outside of port's
> > lock?
> 
> Hi Ilpo, do you think add the following changes should work for this?
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 064bd1f33c21..b3c53935fbc8 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1768,10 +1768,14 @@ static int lpuart32_startup(struct uart_port *port)
> 
>  static void lpuart_dma_shutdown(struct lpuart_port *sport)
>  {
> +       unsigned long flags;
> +
>         if (sport->lpuart_dma_rx_use) {
>                 del_timer_sync(&sport->lpuart_timer);
>                 lpuart_dma_rx_free(&sport->port);
> +               spin_lock_irqsave(&sport->port.lock, flags);
>                 sport->lpuart_dma_rx_use = false;
> +               spin_unlock_irqrestore(&sport->port.lock, flags);
>         }
> 
>         if (sport->lpuart_dma_tx_use) {
> @@ -1780,7 +1784,9 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
>                         sport->dma_tx_in_progress = false;
>                         dmaengine_terminate_all(sport->dma_tx_chan);
>                 }
> +               spin_lock_irqsave(&sport->port.lock, flags);
>                 sport->lpuart_dma_tx_use = false;
> +               spin_unlock_irqrestore(&sport->port.lock, flags);
>         }

After reading a bit more, I think the original patch is likely fine since 
shutdown doesn't seem to be racing with flush_buffer.

-- 
 i.

--8323329-1239297179-1663749818=:1741--
