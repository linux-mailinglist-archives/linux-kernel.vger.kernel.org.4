Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9EA719ABB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjFALL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjFALLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:11:50 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0693107;
        Thu,  1 Jun 2023 04:11:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3E08380F1;
        Thu,  1 Jun 2023 11:11:48 +0000 (UTC)
Date:   Thu, 1 Jun 2023 14:11:47 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230601111147.GA14287@atomide.com>
References: <20230525113034.46880-1-tony@atomide.com>
 <CGME20230601110030eucas1p2eed547c326a51a6110100fb50799d136@eucas1p2.samsung.com>
 <88d9edfe-2f39-b15f-f513-463eac6bf473@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88d9edfe-2f39-b15f-f513-463eac6bf473@samsung.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Marek Szyprowski <m.szyprowski@samsung.com> [230601 11:00]:
> Hi Tony,
> 
> On 25.05.2023 13:30, Tony Lindgren wrote:
> > We want to enable runtime PM for serial port device drivers in a generic
> > way. To do this, we want to have the serial core layer manage the
> > registered physical serial controller devices.
> >
> > To manage serial controllers, let's set up a struct bus and struct device
> > for the serial core controller as suggested by Greg and Jiri. The serial
> > core controller devices are children of the physical serial port device.
> > The serial core controller device is needed to support multiple different
> > kind of ports connected to single physical serial port device.
> >
> > Let's also set up a struct device for the serial core port. The serial
> > core port instances are children of the serial core controller device.
> >
> > With the serial core port device we can now flush pending TX on the
> > runtime PM resume as suggested by Johan.
> >
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> > Suggested-by: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> This patch landed in today's linux next-20230601 as commit 84a9582fd203 
> ("serial: core: Start managing serial controllers to enable runtime 
> PM"). Unfortunately it breaks booting some of my test boards. This can 
> be easily reproduced with QEMU and ARM64 virt machine. The last message 
> I see in the log is:
> 
> [    3.084743] Run /sbin/init as init process

OK thanks for the report. I wonder if this issue is specific to ttyAM
serial port devices somehow?

> I've tried a hack posted here by Steven Price, but unfortunately it 
> doesn't fix my issue. Reverting $subject on top of next-20230601 fixes 
> the boot.

OK

> Here is my qemu test command (nothing really special...):
> 
> qemu-system-aarch64 -kernel Image -append "console=ttyAMA0 
> no_console_suspend root=/dev/vda rootwait ip=::::target::off" -M virt 
> -cpu cortex-a57 -smp 2 -m 1024 -device 
> virtio-blk-device,drive=virtio-blk0 -device 
> virtio-blk-device,drive=virtio-blk1 -drive 
> file=qemu-virt-rootfs.raw,id=virtio-blk1,if=none,format=raw -drive 
> file=initrd,id=virtio-blk0,if=none,format=raw -netdev user,id=user 
> -device virtio-net-device,netdev=user -display none

OK thanks I'll try to reproduce it.

Regards,

Tony
