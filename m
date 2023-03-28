Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA526CBDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjC1L3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1L3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:29:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4CE19A3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D396C616DD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3497C433D2;
        Tue, 28 Mar 2023 11:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680002924;
        bh=wWw+zrxr5xYqlfoALQXULcVguICJViOH6RqTbK2v2L8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=naRa3SCh+7/k3aysx7iuHiCMKhvYJOWiRUi0dz5k993t3st06vbniogrJSWZyjO8H
         e5GDYq/cgXKEHS+42qIX07OZLd3XUS6nPPuZrtmMETEQ9FOcciH1Mx1YfzCnUeECWe
         8b5l+SCEaEnnQ6VZh0pvbm03Onh36GsiGuO1bHOs=
Date:   Tue, 28 Mar 2023 13:28:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] systemd-devd triggers kernel memleak apparently in
 drivers/core/dd.c: driver_register()
Message-ID: <ZCLPaYGKHlFQGKYQ@kroah.com>
References: <5059b11b-8b6e-394b-338f-49e1339067fa@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5059b11b-8b6e-394b-338f-49e1339067fa@alu.unizg.hr>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 01:13:33PM +0200, Mirsad Todorovac wrote:
> Hi all,
> 
> Here is another kernel memory leak report, just as I thought we have done with
> them by the xhci patch by Mathias.
> 
> The memory leaks were caught on an AlmaLinux 8.7 (CentOS) fork system, running
> on a Lenovo desktop box (see lshw.txt) and the newest Linux kernel 6.3-rc4 commit
> g3a93e40326c8 with Mathias' patch for a xhci systemd-devd triggered leak.
> 
>         See: <20230327095019.1017159-1-mathias.nyman@linux.intel.com> on LKML.
> 
> This leak is also systemd-devd triggered, except for the memstick_check() leaks
> which I was unable to bisect due to the box not booting older kernels (work in
> progress).
> 
> unreferenced object 0xffff88ad12392710 (size 96):
>   comm "systemd-udevd", pid 735, jiffies 4294896759 (age 2257.568s)
>   hex dump (first 32 bytes):
>     53 65 72 69 61 6c 50 6f 72 74 31 41 64 64 72 65  SerialPort1Addre
>     73 73 2c 33 46 38 2f 49 52 51 34 3b 5b 4f 70 74  ss,3F8/IRQ4;[Opt
>   backtrace:
>     [<ffffffffae8fb26c>] slab_post_alloc_hook+0x8c/0x3e0
>     [<ffffffffae902b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
>     [<ffffffffae8773c9>] __kmalloc_node_track_caller+0x59/0x180
>     [<ffffffffae866a1a>] kstrdup+0x3a/0x70
>     [<ffffffffc0d839aa>] tlmi_extract_output_string.isra.0+0x2a/0x60 [think_lmi]
>     [<ffffffffc0d83b64>] tlmi_setting.constprop.4+0x54/0x90 [think_lmi]
>     [<ffffffffc0d842b1>] tlmi_probe+0x591/0xba0 [think_lmi]
>     [<ffffffffc051dc53>] wmi_dev_probe+0x163/0x230 [wmi]

Why aren't you looking at the wmi.c driver?  That should be where the
issue is, not the driver core, right?

thanks,

greg k-h
