Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2965B85F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiINKKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiINKJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:09:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE27BF75;
        Wed, 14 Sep 2022 03:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663150186; x=1694686186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SIVcQrh1gSIAZ845KvaUeIdpxkVqBq92ZOZjdm9+p6Q=;
  b=XaJSS23ttzPlW+t4u7LEypC26n+q5+i9IUp/rBZi9ie7b2XSjWSeT2dj
   TGZvvs9/e4y3ibJrOHQbF0rP/greTKLruth5CAQQYwNkmi2205bXa5NF5
   nKcqwV/gBTv+uAogYW3PoKcMDHI0SUUcadksD9NUUY+hMfV9iIeaVpK/m
   7WmNZzhjRM1nmMXX2ICpkmNx1m4ey9WBmEXG1y/Xn102LtRfOrFL40Uhq
   K5g9Cqkd+EXz7wDzmJvq4255UgiguRyE9A28jh3stw409fOWhMH0XFFwn
   yTpN1TEelkMhW83ZOyCs+5xPQLTXa/mENIbSdnNC2JthsE5/jbINowpH/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="298390540"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="298390540"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 03:09:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="594324921"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 03:09:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oYPKv-0029B7-0z;
        Wed, 14 Sep 2022 13:09:41 +0300
Date:   Wed, 14 Sep 2022 13:09:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lennert Buytenhek <buytenh@wantstofly.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: I/O page faults from 8250_mid PCIe UART after TIOCVHANGUP
Message-ID: <YyGoZLTFhYQvlf+P@smile.fi.intel.com>
References: <YyF/dogp/0C87zLb@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyF/dogp/0C87zLb@wantstofly.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Ilpo

On Wed, Sep 14, 2022 at 10:15:02AM +0300, Lennert Buytenhek wrote:
> Hi,
> 
> On an Intel SoC with several 8250_mid PCIe UARTs built into the CPU, I
> can reliably trigger I/O page faults if I invoke TIOCVHANGUP on any of
> the UARTs and then re-open that UART.
> 
> Invoking TIOCVHANGUP appears to clear the MSI address/data registers
> in the UART via tty_ioctl() -> tty_vhangup() -> __tty_hangup() ->
> uart_hangup() -> uart_shutdown() -> uart_port_shutdown() ->
> univ8250_release_irq() -> free_irq() -> irq_domain_deactivate_irq() ->
> __irq_domain_deactivate_irq() -> msi_domain_deactivate() ->
> __pci_write_msi_msg():
> 
> [root@icelake ~]# lspci -s 00:1a.0 -vv | grep -A1 MSI:
> 	Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 		Address: fee00278  Data: 0000
> [root@icelake ~]# cat hangup.c
> #include <stdio.h>
> #include <sys/ioctl.h>
> 
> int main(int argc, char *argv[])
> {
> 	ioctl(1, TIOCVHANGUP);
> 
> 	return 0;
> }
> [root@icelake ~]# gcc -Wall -o hangup hangup.c
> [root@icelake ~]# ./hangup > /dev/ttyS4
> [root@icelake ~]# lspci -s 00:1a.0 -vv | grep -A1 MSI:
> 	Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 		Address: 00000000  Data: 0000
> [root@icelake ~]#
> 
> Opening the serial port device again while the UART is in this state
> then appears to cause the UART to generate an interrupt

The interrupt is ORed three: DMA Tx, DMA Rx and UART itself.
Any of them can be possible, but to be sure, can you add:

	dev_info(p->dev, "FISR: %x\n", fisr);

into dnv_handle_irq() before any other code and see which bits we actually got
there before the crash?

(If it floods the logs, dev_info_ratelimited() may help)

> before the
> MSI vector has been set up again, causing a DMA write to I/O virtual
> address zero:
> 
> [root@icelake console]# echo > /dev/ttyS4
> [  979.463307] DMAR: DRHD: handling fault status reg 3
> [  979.469409] DMAR: [DMA Write NO_PASID] Request device [00:1a.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
> 
> I'm guessing there's something under tty_open() -> uart_open() ->
> tty_port_open() -> uart_port_activate() -> uart_port_startup() ->
> serial8250_do_startup() that triggers a UART interrupt before the
> MSI vector has been set up again.
> 
> I did a quick search but it didn't seem like this is a known issue.

Thanks for your report and reproducer! Yes, I also never heard about such an
issue before. Ilpo, who is doing more UART work nowadays, might have an idea,
I hope.

I'm a bit busy with other stuff right now.


-- 
With Best Regards,
Andy Shevchenko


