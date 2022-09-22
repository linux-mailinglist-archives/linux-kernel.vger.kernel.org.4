Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3538A5E6798
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiIVPwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiIVPwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:52:11 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0A9CF82772
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:52:06 -0700 (PDT)
Received: (qmail 263288 invoked by uid 1000); 22 Sep 2022 11:52:06 -0400
Date:   Thu, 22 Sep 2022 11:52:06 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Rondreis <linhaoguo86@gmail.com>, Felipe Balbi <balbi@kernel.org>,
        Michal Nazarewicz <mina86@mina86.com>
Cc:     andriy.shevchenko@linux.intel.com, jakobkoschel@gmail.com,
        quic_wcheng@quicinc.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: kernel v5.19 warn in usb_ep_queue
Message-ID: <YyyEpo5E+Tu10RKt@rowland.harvard.edu>
References: <CAB7eexKe2YtpYHy0Ohyr-SXLAWUjErJGLSspSUCeEL=CWyZSKw@mail.gmail.com>
 <YyoDZNZX2ggSuaFE@rowland.harvard.edu>
 <CAB7eexKT341KugNjfEKKVzFNoDJcECh5Ni2mpKSTyp7MqYjAsA@mail.gmail.com>
 <Yys1UHJ/+XoKyR6Y@rowland.harvard.edu>
 <CAB7eexKF5tiUHtesX218XoWSHV0aCiYaW97fgEY91x8Q9JF23g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB7eexKF5tiUHtesX218XoWSHV0aCiYaW97fgEY91x8Q9JF23g@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe and Michal, see below.

On Thu, Sep 22, 2022 at 04:34:44PM +0800, Rondreis wrote:
> I patched it again, and the output is:
> 
> 
> [   54.721631][   T24] usb 2-1: new high-speed USB device number 2 using
> dummy_hcd
> [   55.131602][   T24] usb 2-1: Dual-Role OTG device on HNP port
> [   55.151589][   T24] usb 2-1: New USB device found, idVendor=03f0,
> idProduct=0107, bcdDevice= 2.00
> [   55.151919][   T24] usb 2-1: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [   55.152199][   T24] usb 2-1: Product: Gadget
> [   55.152374][   T24] usb 2-1: Manufacturer: Foo Inc.
> [   55.152557][   T24] usb 2-1: SerialNumber: 12345678
> [   55.171998][    C1] configfs-gadget gadget.1: Raise exception 3
> ffff88811b9ba000
> [   55.172604][ T6539] configfs-gadget gadget.1: Enable bulk in
> [   55.172884][ T6539] configfs-gadget gadget.1: Enable bulk out
> [   55.173179][ T6539] configfs-gadget gadget.1: Bulk out start
> ffff888115fd7c80
> [   55.173506][ T6539] CPU: 0 PID: 6539 Comm: file-storage Not tainted
> 5.19.0+ #16
> [   55.173834][ T6539] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS Arch Linux 1.16.0-3-3 04/01/2014
> [   55.174193][ T6539] Call Trace:
> [   55.174316][ T6539]  <TASK>
> [   55.174425][ T6539]  dump_stack_lvl+0xfc/0x174
> [   55.174602][ T6539]  start_out_transfer.part.0+0x7c/0x142
> [   55.174813][ T6539]  fsg_main_thread+0x375/0x1450
> [   55.175004][ T6539]  ? __kthread_parkme+0xc4/0x210
> [   55.175191][ T6539]  ? reacquire_held_locks+0x4b0/0x4b0
> [   55.175392][ T6539]  ? do_set_interface.isra.0+0x530/0x530
> [   55.175606][ T6539]  ? __kthread_parkme+0x14e/0x210
> [   55.175797][ T6539]  ? do_set_interface.isra.0+0x530/0x530
> [   55.176005][ T6539]  kthread+0x2e0/0x390
> [   55.176156][ T6539]  ? kthread_complete_and_exit+0x40/0x40
> [   55.176363][ T6539]  ret_from_fork+0x1f/0x30
> [   55.176537][ T6539]  </TASK>
> [   55.253779][   T24] cdc_eem 2-1:1.0 usb1: register 'cdc_eem' at
> usb-dummy_hcd.1-1, CDC EEM Device, c2:07:46:1b:bf:4a
> [   55.271856][   T24] usb-storage 2-1:1.1: USB Mass Storage device detected
> [   55.278904][   T24] scsi host2: usb-storage 2-1:1.1
> [   56.352122][ T6584] cdc_eem 2-1:1.0 usb1: unregister 'cdc_eem'
> usb-dummy_hcd.1-1, CDC EEM Device
> [   56.412714][ T6584] configfs-gadget gadget.1: Bulk out complete
> ffff888115fd7c80
> [   56.413545][ T6539] configfs-gadget gadget.1: Bulk out start
> ffff888115fd7c80
> [   56.413787][ T6584] configfs-gadget gadget.1: Disable bulk in B
> [   56.413988][ T6539] CPU: 1 PID: 6539 Comm: file-storage Not tainted
> 5.19.0+ #16
> [   56.414336][ T6584] configfs-gadget gadget.1: Disable bulk out B
> [   56.414647][ T6539] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS Arch Linux 1.16.0-3-3 04/01/2014
> [   56.414908][ T6584] configfs-gadget gadget.1: Disable bulk out B finished
> [   56.415348][ T6539] Call Trace:
> [   56.415352][ T6539]  <TASK>
> [   56.415827][ T6584] configfs-gadget gadget.1: Raise exception 3
> 0000000000000000
> [   56.415969][ T6539]  dump_stack_lvl+0xfc/0x174
> [   56.416735][ T6539]  start_out_transfer.part.0+0x7c/0x142
> [   56.416989][ T6539]  fsg_main_thread+0x375/0x1450
> [   56.417256][ T6539]  ? __kthread_parkme+0xc4/0x210
> [   56.417560][ T6539]  ? reacquire_held_locks+0x4b0/0x4b0
> [   56.417885][ T6539]  ? do_set_interface.isra.0+0x530/0x530
> [   56.418231][ T6539]  ? __kthread_parkme+0x14e/0x210
> [   56.418576][ T6539]  ? do_set_interface.isra.0+0x530/0x530
> [   56.418919][ T6539]  kthread+0x2e0/0x390
> [   56.419172][ T6539]  ? kthread_complete_and_exit+0x40/0x40
> [   56.419515][ T6539]  ret_from_fork+0x1f/0x30
> [   56.419804][ T6539]  </TASK>
> [   56.420255][ T6539] ------------[ cut here ]------------
> [   56.420496][ T6539] WARNING: CPU: 1 PID: 6539 at
> drivers/usb/gadget/udc/core.c:283 usb_ep_queue+0x9b/0x3b0
> [   56.420923][ T6539] Modules linked in:
> [   56.421102][ T6539] CPU: 1 PID: 6539 Comm: file-storage Not tainted
> 5.19.0+ #16
> [   56.421429][ T6539] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS Arch Linux 1.16.0-3-3 04/01/2014
> [   56.431805][ T6539] RIP: 0010:usb_ep_queue+0x9b/0x3b0

Okay, thanks.  It's pretty clear what's going wrong.

f_mass_storage uses a kernel thread to do almost all of its work.  But
the fsg_disable() callback routine runs in an atomic context, so it
can't sleep.  And there is no find-grained synchronization between
that routine and the kernel thread.

As a result, when fsg_disable() disables an endpoint, the kernel
thread may still try to use it for a little while.  That's what happened
here.

I can think of three ways to resolve this.  The first is to add
fine-grained synchronization, in the form of a spinlock that has to be
held whenever f_mass_storage uses an endpoint.  Kind of awkward.

The second is to allow drivers to try to access endpoints even after
the endpoints have been disabled.  This means removing the
WARN_ON_ONCE() in usb_ep_queue().  I believe allowing this won't lead
to any trouble, because we will still require drivers not to access
the gadget at all after their ->unbind callback has returned -- but
maybe I'm wrong.  In any case, it seems bad to use an atomic callback
to tell drivers they have to give up a resource; resource removal
should be allowed to sleep.

The third way is to allow a function driver's ->disable callback not
to disable its endpoints.  However, I don't know if this is compatible
with the intended operation of the composite framework.  The
documentation does not explain very clearly what .disable() in struct
usb_function is supposed to do.

I'm not sure which approach would be better.  Felipe and Michal, any
suggestions?

Alan Stern
