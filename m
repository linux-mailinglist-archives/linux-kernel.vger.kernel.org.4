Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E44613AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiJaPvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:50:59 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26B811C16;
        Mon, 31 Oct 2022 08:50:58 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id l5so13184300oif.7;
        Mon, 31 Oct 2022 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lIDgC5wvEGZA+roGZtnsfrM13aoGf3nJzAXiQwNmGc=;
        b=qWS6FuJvLWqQHjY/GmHSJtdOLjV9rK64odJ8YbpmF51DXHPGHBLU6eAPEL9T64JzHh
         EdL0D7t0I2rwaU7W3q49qp6KiabyUjJx5e7IjpRk3eTTfwUW5f6sLnRAa8Q8JF8o592d
         xomC74nWbezZwd/T1xCN/yemjUg4Ro013h43QEfhIWgrnOLh1MsikfbVMiiLQAMnaf53
         1IZyyd8xnX3LBOqt29xhq1QAWvVSeJOrsqvsw5H/0q52ZrUsz5G7uWwHF4CF/yqnPyMF
         Z5TeN1R01W8yUEP3za1kOOZk7iYrhfO4wTjXff8WUW4+W3nSjcdQgYQM31+nWGuzZTLx
         eJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lIDgC5wvEGZA+roGZtnsfrM13aoGf3nJzAXiQwNmGc=;
        b=MT20AniAmm8HBzqW6w0wcHLaGSR/PGTjh5sjLjWLNc7n251zPuP0/k0SKDnPyopN56
         AU8nF3rHOtgfvBP3g8osMNgo4NTJkLRLJ9Rt6UKYLJBaGWDuPUlAl474iQNx48Pby8TX
         TsySJ9ACKEWoW0YIV3VIsJ5dYBJ1ei+Cbe10BB29p+i1ONXdhuuMIxmWJIdtCcm4OwzV
         YK++LPC1kCE7TSgpxrrh7gFNs5/T/4kdIs1130n4HON8S6vkPIxXkO+NCX4ajI1euTJC
         galdGwXL6i5KGs9fS5K6OhTB66iRZeLmjzNSUX2UJDIDMCZbpAOktuMqKLsl0pj5f+6W
         TLcg==
X-Gm-Message-State: ACrzQf3UG52LY3l4qlQoDmkmvI9Za4eHMlp8xlNF3I65XMGJEsUYB8Op
        9yeZRjFbsVrBSD9swJphJZ8=
X-Google-Smtp-Source: AMsMyM6w6hdy7w8UNtM4CZrPnsDEWsTvC/yUjGJ3lI77D1NDCC96hC7nZHnMgowE4l8LTLeoefEipA==
X-Received: by 2002:a05:6808:1411:b0:354:f508:dca4 with SMTP id w17-20020a056808141100b00354f508dca4mr15697300oiv.291.1667231458244;
        Mon, 31 Oct 2022 08:50:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cy11-20020a056870b68b00b0011f22e74d5fsm3170490oab.20.2022.10.31.08.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 08:50:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 31 Oct 2022 08:50:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-usb@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [RFC][PATCH v2 20/31] timers: usb: Use del_timer_shutdown()
 before freeing timer
Message-ID: <20221031155056.GB2462187@roeck-us.net>
References: <20221027150525.753064657@goodmis.org>
 <20221027150928.983388020@goodmis.org>
 <4e61935b-b06b-1f2d-6c2b-79bdfd569cd6@roeck-us.net>
 <20221028140129.040d9acc@gandalf.local.home>
 <20221028141007.05f5c490@gandalf.local.home>
 <20221028195959.GA1073367@roeck-us.net>
 <20221029145241.GA3296895@roeck-us.net>
 <20221029151952.076821f2@gandalf.local.home>
 <5ee0b72c-3942-8981-573f-73d97ea7ef08@roeck-us.net>
 <20221030114828.58fdd5d0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030114828.58fdd5d0@gandalf.local.home>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 11:48:28AM -0400, Steven Rostedt wrote:
> On Sat, 29 Oct 2022 15:56:25 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > >> WARNING: CPU: 0 PID: 9 at lib/debugobjects.c:502 debug_print_object+0xd0/0x100
> > >> ODEBUG: free active (active state 0) object type: timer_list hint: neigh_timer_handler+0x0/0x480
> > >>
> > >> That happens with almost every test, so I may have missed some others
> > >> in the noise.  
> > > 
> > > Can you add this?
> > >   
> > 
> > It doesn't make a difference.
> 
> Ah, it also requires this (I have other debugging in that file, so it may
> only apply with some fuzzing):
> 

Almost good, except for the attached backtrace. That seems to happen
on shutdown after bootting from a usb drive, but not on all platforms.

The warning is in __mod_timer():

        if (WARN_ON_ONCE(!timer->function))
                return -EINVAL;

This may be due to the change in blk_sync_queue() which I suspect may
be called prior to the last mod_timer() call. I'll add some debug code
to verify.

Guenter

------------[ cut here ]------------
WARNING: CPU: 0 PID: 283 at kernel/time/timer.c:1046 mod_timer+0x294/0x34c
Modules linked in:
CPU: 0 PID: 283 Comm: init Tainted: G                 N 6.1.0-rc2-00397-g18ccc9f8a778 #1
Hardware name: Freescale i.MX25 (Device Tree Support)
 unwind_backtrace from show_stack+0x10/0x18
 show_stack from dump_stack_lvl+0x34/0x54
 dump_stack_lvl from __warn+0xc0/0x1f0
 __warn from warn_slowpath_fmt+0x5c/0xc4
 warn_slowpath_fmt from mod_timer+0x294/0x34c
 mod_timer from blk_add_timer+0xa4/0xb4
 blk_add_timer from blk_mq_start_request+0x84/0x1f4
 blk_mq_start_request from scsi_queue_rq+0x4a8/0xb84
 scsi_queue_rq from blk_mq_dispatch_rq_list+0x320/0x9d0
 blk_mq_dispatch_rq_list from __blk_mq_sched_dispatch_requests+0xb0/0x158
 __blk_mq_sched_dispatch_requests from blk_mq_sched_dispatch_requests+0x34/0x64
 blk_mq_sched_dispatch_requests from __blk_mq_run_hw_queue+0x8c/0x234
 __blk_mq_run_hw_queue from blk_mq_sched_insert_request+0xe8/0x15c
 blk_mq_sched_insert_request from blk_execute_rq+0xa4/0x1d0
 blk_execute_rq from __scsi_execute+0xb4/0x19c
 __scsi_execute from sd_sync_cache+0xac/0x1ec
 sd_sync_cache from sd_shutdown+0x5c/0xc8
 sd_shutdown from sd_remove+0x30/0x44
 sd_remove from device_release_driver_internal+0xd0/0x16c
 device_release_driver_internal from bus_remove_device+0xd0/0x100
 bus_remove_device from device_del+0x190/0x464
 device_del from __scsi_remove_device+0x130/0x184
 __scsi_remove_device from scsi_forget_host+0x60/0x64
 scsi_forget_host from scsi_remove_host+0x6c/0x188
 scsi_remove_host from usb_stor_disconnect+0x40/0xf4
 usb_stor_disconnect from usb_unbind_interface+0x68/0x230
 usb_unbind_interface from device_release_driver_internal+0xd0/0x16c
 device_release_driver_internal from bus_remove_device+0xd0/0x100
 bus_remove_device from device_del+0x190/0x464
 device_del from usb_disable_device+0x88/0x130
 usb_disable_device from usb_disconnect+0xb4/0x234
 usb_disconnect from usb_disconnect+0x9c/0x234
 usb_disconnect from usb_remove_hcd+0xd0/0x16c
 usb_remove_hcd from host_stop+0x38/0xa8
 host_stop from ci_hdrc_remove+0x40/0x11c
 ci_hdrc_remove from platform_remove+0x24/0x54
 platform_remove from device_release_driver_internal+0xd0/0x16c
 device_release_driver_internal from bus_remove_device+0xd0/0x100
 bus_remove_device from device_del+0x190/0x464
 device_del from platform_device_del.part.0+0x10/0x78
 platform_device_del.part.0 from platform_device_unregister+0x18/0x28
 platform_device_unregister from ci_hdrc_remove_device+0xc/0x24
 ci_hdrc_remove_device from ci_hdrc_imx_remove+0x28/0xfc
 ci_hdrc_imx_remove from device_shutdown+0x178/0x230
 device_shutdown from kernel_restart_prepare+0x2c/0x3c
 kernel_restart_prepare from kernel_restart+0xc/0x68
 kernel_restart from __do_sys_reboot+0xc0/0x204
 __do_sys_reboot from ret_fast_syscall+0x0/0x1c
Exception stack(0xc8ca1fa8 to 0xc8ca1ff0)
1fa0:                   01234567 0000000f fee1dead 28121969 01234567 00000000
1fc0: 01234567 0000000f 00000001 00000058 000e05c0 00000000 00000000 00000000
1fe0: 000e0298 bea82de4 000994bc b6f6d2c0
irq event stamp: 3443
hardirqs last  enabled at (3451): [<c0074590>] __up_console_sem+0x64/0x88
hardirqs last disabled at (3458): [<c007457c>] __up_console_sem+0x50/0x88
softirqs last  enabled at (3438): [<c000988c>] __do_softirq+0x2fc/0x5d0
softirqs last disabled at (3433): [<c0022518>] __irq_exit_rcu+0x170/0x1ec
---[ end trace 0000000000000000 ]---
sd 0:0:0:0: [sda] Synchronize Cache(10) failed: Result: hostbyte=0x01 driverbyte=DRIVER_OK
ci_hdrc ci_hdrc.0: USB bus 1 deregistered
reboot: Restarting system
------------
