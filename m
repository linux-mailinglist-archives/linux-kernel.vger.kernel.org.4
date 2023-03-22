Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F006C54EA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjCVTaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCVTaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:30:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C958B6230C;
        Wed, 22 Mar 2023 12:30:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B35FB81DC6;
        Wed, 22 Mar 2023 19:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF247C433EF;
        Wed, 22 Mar 2023 19:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679513398;
        bh=Cfi9VkCmRLXf0kW1TOnxPaYmZ1+x2ZSSmhXkPX6H0x0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZTOEsjNABSre0n+rHAi7Ne4uXOjzPeOiLgH9JgMEIoesTf6OHh1pJnYM4vdJRlpF
         iHaRuHMV5kSUTcCPhQnMgw0NE0URQolyiJr18Dbfcz4xJikyl8IVXpXeHq9k4I9rki
         zYjdzCsVvGHs1Ntr4zYcLOsyk4EOCPukQF3ZJhD0=
Date:   Wed, 22 Mar 2023 20:29:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hongyu Xie <xiehongyu1@kylinos.cn>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, sunke <sunke@kylinos.cn>
Subject: Re: [PATCH -next] usb: xhci: do not free an empty cmd ring
Message-ID: <ZBtXM3oXeOclQNK0@kroah.com>
References: <20230320042223.676505-1-xiehongyu1@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320042223.676505-1-xiehongyu1@kylinos.cn>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 12:22:23PM +0800, Hongyu Xie wrote:
> It was first found on HUAWEI Kirin 9006C platform with a builtin xhci
> controller during stress cycle test(stress-ng, glmark2, x11perf, S4...).
> 
> phase one:
> [26788.706878] PM: dpm_run_callback(): platform_pm_thaw+0x0/0x68 returns -12
> [26788.706878] PM: Device xhci-hcd.1.auto failed to thaw async: error -12
> ...
> phase two:
> [28650.583496] [2023:01:19 04:43:29]Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
> ...
> [28650.583526] user pgtable: 4k pages, 39-bit VAs, pgdp=000000027862a000
> [28650.583557] [0000000000000028] pgd=0000000000000000
> ...
> [28650.583587] pc : xhci_suspend+0x154/0x5b0
> [28650.583618] lr : xhci_suspend+0x148/0x5b0
> [28650.583618] sp : ffffffc01c7ebbd0
> [28650.583618] x29: ffffffc01c7ebbd0 x28: ffffffec834d0000
> [28650.583618] x27: ffffffc0106a3cc8 x26: ffffffb2c540c848
> [28650.583618] x25: 0000000000000000 x24: ffffffec82ee30b0
> [28650.583618] x23: ffffffb43b31c2f8 x22: 0000000000000000
> [28650.583618] x21: 0000000000000000 x20: ffffffb43b31c000
> [28650.583648] x19: ffffffb43b31c2a8 x18: 0000000000000001
> [28650.583648] x17: 0000000000000803 x16: 00000000fffffffe
> [28650.583648] x15: 0000000000001000 x14: ffffffb150b67e00
> [28650.583648] x13: 00000000f0000000 x12: 0000000000000001
> [28650.583648] x11: 0000000000000000 x10: 0000000000000a80
> [28650.583648] x9 : ffffffc01c7eba00 x8 : ffffffb43ad10ae0
> [28650.583648] x7 : ffffffb84cd98dc0 x6 : 0000000cceb6a101
> [28650.583679] x5 : 00ffffffffffffff x4 : 0000000000000001
> [28650.583679] x3 : 0000000000000011 x2 : 0000000000e2cfa8
> [28650.583679] x1 : 00000000823535e1 x0 : 0000000000000000
> 
> gdb:
> (gdb) l *(xhci_suspend+0x154)
> 0xffffffc010b6cd44 is in xhci_suspend (/.../drivers/usb/host/xhci.c:854).
> 849	{
> 850		struct xhci_ring *ring;
> 851		struct xhci_segment *seg;
> 852
> 853		ring = xhci->cmd_ring;
> 854		seg = ring->deq_seg;
> (gdb) disassemble 0xffffffc010b6cd44
> ...
> 0xffffffc010b6cd40 <+336>:	ldr	x22, [x19, #160]
> 0xffffffc010b6cd44 <+340>:	ldr	x20, [x22, #40]
> 0xffffffc010b6cd48 <+344>:	mov	w1, #0x0                   	// #0
> 
> During phase one, platform_pm_thaw called xhci_plat_resume which called
> xhci_resume. The rest possible calling routine might be
> xhci_resume->xhci_init->xhci_mem_init, and xhci->cmd_ring was cleaned in
> xhci_mem_cleanup before xhci_mem_init returned -ENOMEM.
> 
> During phase two, systemd was tring to hibernate again and called
> xhci_suspend, then xhci_clear_command_ring dereferenced xhci->cmd_ring
> which was already NULL.
> 
> So if xhci->cmd_ring is NULL, xhci_clear_command_ring just return.
> 
> Co-developed-by: sunke <sunke@kylinos.cn>
> Signed-off-by: sunke <sunke@kylinos.cn>
> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> ---
>  drivers/usb/host/xhci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 6183ce8574b1..8b79ad2955e5 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -919,6 +919,10 @@ static void xhci_clear_command_ring(struct xhci_hcd *xhci)
>  {
>  	struct xhci_ring *ring;
>  	struct xhci_segment *seg;
> +	if (!xhci->cmd_ring) {
> +		xhci_err(xhci, "Empty cmd ring");

Why is this being told to userspace?  What can it do about it?

> +		return;

Not returning an error?

> +	}
>  

Please always use checkpatch.pl when sending patches out so that
maintainers have to ask you to use checkpatch.pl.

Also, what commit does this fix?  Does this need to go to stable trees?

But wait, this feels wrong, what can keep this variable from being set
to NULL right after you check it?  Where it the lock involved?

thanks,

greg k-h
