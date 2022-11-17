Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127A162D8BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239684AbiKQLBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239601AbiKQLA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:00:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76CDB18B1E;
        Thu, 17 Nov 2022 02:59:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A76FD6E;
        Thu, 17 Nov 2022 02:59:18 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFC9C3F73B;
        Thu, 17 Nov 2022 02:59:10 -0800 (PST)
Date:   Thu, 17 Nov 2022 10:58:58 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jiamei Xie <jiamei.xie@arm.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, Rob.Herring@arm.com, wei.chen@arm.com,
        Bertrand.Marquis@arm.com
Subject: Re: [PATCH] serial: amba-pl011: avoid SBSA UART accessing DMACR
 register
Message-ID: <20221117105858.29c6ecd3@donnerap.cambridge.arm.com>
In-Reply-To: <20221117103237.86856-1-jiamei.xie@arm.com>
References: <20221117103237.86856-1-jiamei.xie@arm.com>
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

On Thu, 17 Nov 2022 18:32:37 +0800
Jiamei Xie <jiamei.xie@arm.com> wrote:

> Chapter "B Generic UART" in "ARM Server Base System Architecture" [1]
> documentation describes a generic UART interface. Such generic UART
> does not support DMA. In current code, sbsa_uart_pops and
> amba_pl011_pops share the same stop_rx operation, which will invoke
> pl011_dma_rx_stop, leading to an access of the DMACR register. This
> commit adds a using_rx_dma check in pl011_dma_rx_stop to avoid the
> access to DMACR register for SBSA UARTs which does not support DMA.
> 
> When the kernel enables DMA engine with "CONFIG_DMA_ENGINE=y", Linux
> SBSA PL011 driver will access PL011 DMACR register in some functions.
> For most real SBSA Pl011 hardware implementations, the DMACR write
> behaviour will be ignored. So these DMACR operations will not cause
> obvious problems. But for some virtual SBSA PL011 hardware, like Xen
> virtual SBSA PL011 (vpl011) device, the behaviour might be different.
> Xen vpl011 emulation will inject a data abort to guest, when guest is
> accessing an unimplemented UART register. As Xen VPL011 is SBSA
> compatible, it will not implement DMACR register. So when Linux SBSA
> PL011 driver access DMACR register, it will get an unhandled data abort
> fault and the application will get a segmentation fault:
> Unhandled fault at 0xffffffc00944d048
> Mem abort info:
>   ESR = 0x96000000
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x00: ttbr address size fault
> Data abort info:
>   ISV = 0, ISS = 0x00000000
>   CM = 0, WnR = 0
> swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000020e2e000
> [ffffffc00944d048] pgd=100000003ffff803, p4d=100000003ffff803, pud=100000003ffff803, pmd=100000003fffa803, pte=006800009c090f13
> Internal error: ttbr address size fault: 96000000 [#1] PREEMPT SMP
> ...
> Call trace:
>  pl011_stop_rx+0x70/0x80
>  tty_port_shutdown+0x7c/0xb4
>  tty_port_close+0x60/0xcc
>  uart_close+0x34/0x8c
>  tty_release+0x144/0x4c0
>  __fput+0x78/0x220
>  ____fput+0x1c/0x30
>  task_work_run+0x88/0xc0
>  do_notify_resume+0x8d0/0x123c
>  el0_svc+0xa8/0xc0
>  el0t_64_sync_handler+0xa4/0x130
>  el0t_64_sync+0x1a0/0x1a4
> Code: b9000083 b901f001 794038a0 8b000042 (b9000041)
> ---[ end trace 83dd93df15c3216f ]---
> note: bootlogd[132] exited with preempt_count 1
> /etc/rcS.d/S07bootlogd: line 47: 132 Segmentation fault start-stop-daemon
> 
> This has been discussed in the Xen community, and we think it should fix
> this in Linux. See [2] for more information.

It looks like Xen is looking into avoiding the data abort, but this fix is
correct anyway, and mimics what we already do in other DMA handling
functions.
> 
> [1] https://developer.arm.com/documentation/den0094/c/?lang=en
> [2] https://lists.xenproject.org/archives/html/xen-devel/2022-11/msg00543.html
> 
> Fixes: 0dd1e247fd39 (drivers: PL011: add support for the ARM SBSA generic UART)
> Signed-off-by: Jiamei Xie <jiamei.xie@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/tty/serial/amba-pl011.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 5cdced39eafd..5b97645be667 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1045,6 +1045,9 @@ static void pl011_dma_rx_callback(void *data)
>   */
>  static inline void pl011_dma_rx_stop(struct uart_amba_port *uap)
>  {
> +	if (!uap->using_rx_dma)
> +		return;
> +
>  	/* FIXME.  Just disable the DMA enable */
>  	uap->dmacr &= ~UART011_RXDMAE;
>  	pl011_write(uap->dmacr, uap, REG_DMACR);

