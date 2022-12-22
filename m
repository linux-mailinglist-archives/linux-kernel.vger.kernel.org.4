Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8C8653BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 06:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiLVF5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 00:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVF5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 00:57:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D612A2;
        Wed, 21 Dec 2022 21:57:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4653CB81C5A;
        Thu, 22 Dec 2022 05:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C1DC433EF;
        Thu, 22 Dec 2022 05:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671688635;
        bh=HDdlBx74ON1dglZtm6y8d5R2ejMcSANYSAesl8siv5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dp9OpDcPPArlL1vTvtvD4Azkh9JBy9+fEmVKn8PYWq1pgX2nZlBITFKEFbVy3RZws
         XN7bZWDrUCNhITEN9PNTKdCciV/2avG4WIW/rmpX+rwv2wY4Yb77j8x5MD/7m9CprR
         9xIf6ZhuuEYptum/4xTLi5wTtl53IFylfNdtlc6E=
Date:   Thu, 22 Dec 2022 06:57:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jimmy Hu <hhhuuu@google.com>
Cc:     mathias.nyman@intel.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: xhci: Check endpoint is valid before
 dereferencing it
Message-ID: <Y6PxuFPfKM0sttAr@kroah.com>
References: <20221222024630.1812735-1-hhhuuu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222024630.1812735-1-hhhuuu@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 02:46:30AM +0000, Jimmy Hu wrote:
> When the host controller is not responding, all URBs queued to all
> endpoints need to be killed. This can cause a kernel panic if we
> dereference an invalid endpoint.
> 
> Fix this by using xhci_get_virt_ep() helper to find the endpoint and
> checking if the endpoint is valid before dereferencing it.
> 
> [233311.853271] xhci-hcd xhci-hcd.1.auto: xHCI host controller not responding, assume dead
> [233311.853393] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000e8
> 
> [233311.853964] pc : xhci_hc_died+0x10c/0x270
> [233311.853971] lr : xhci_hc_died+0x1ac/0x270
> 
> [233311.854077] Call trace:
> [233311.854085]  xhci_hc_died+0x10c/0x270
> [233311.854093]  xhci_stop_endpoint_command_watchdog+0x100/0x1a4
> [233311.854105]  call_timer_fn+0x50/0x2d4
> [233311.854112]  expire_timers+0xac/0x2e4
> [233311.854118]  run_timer_softirq+0x300/0xabc
> [233311.854127]  __do_softirq+0x148/0x528
> [233311.854135]  irq_exit+0x194/0x1a8
> [233311.854143]  __handle_domain_irq+0x164/0x1d0
> [233311.854149]  gic_handle_irq.22273+0x10c/0x188
> [233311.854156]  el1_irq+0xfc/0x1a8
> [233311.854175]  lpm_cpuidle_enter+0x25c/0x418 [msm_pm]
> [233311.854185]  cpuidle_enter_state+0x1f0/0x764
> [233311.854194]  do_idle+0x594/0x6ac
> [233311.854201]  cpu_startup_entry+0x7c/0x80
> [233311.854209]  secondary_start_kernel+0x170/0x198
> 
> Signed-off-by: Jimmy Hu <hhhuuu@google.com>
> ---
>  drivers/usb/host/xhci-ring.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

What commit id does this fix?  Should it also be cc: stable kernels?  If
so, how far back?

thanks,

greg k-h
