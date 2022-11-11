Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26D5625379
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiKKGTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiKKGTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:19:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEFF532F7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:19:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0566A61E7C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037A0C433D6;
        Fri, 11 Nov 2022 06:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668147541;
        bh=SNfh2FDt7AaTBy1bXtKDfqrTwScuCkTOTXYRDtP+2dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BIqVl7eCCX1sBmSLMNiG4d9UXVBq4wMhS9seBPRbKIZB+Oy7Kwo/rEg2suq4l7rlG
         oZAMoC4O8GYkKbmxbBvZ83bti2jJegCGUA3UOYy4vSQU75d82POi8FRJpghOyj+vDI
         /AVHj6ulM/aRPKtJXjJ4/DFv2aeG7xUOnv4zjmws=
Date:   Fri, 11 Nov 2022 07:18:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linmq006@gmail.com
Subject: Re: [PATCH v2] firmware: dmi-sysfs: Fix null-ptr-deref in
 dmi_sysfs_register_handle
Message-ID: <Y23pUlitIuqdyd0g@kroah.com>
References: <20221111015326.251650-1-chenzhongjin@huawei.com>
 <20221111015326.251650-2-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111015326.251650-2-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 09:53:26AM +0800, Chen Zhongjin wrote:
> KASAN reported a null-ptr-deref error:
> 
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 0 PID: 1373 Comm: modprobe
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> RIP: 0010:dmi_sysfs_entry_release
> ...
> Call Trace:
>  <TASK>
>  kobject_put
>  dmi_sysfs_register_handle (drivers/firmware/dmi-sysfs.c:540) dmi_sysfs
>  dmi_decode_table (drivers/firmware/dmi_scan.c:133)
>  dmi_walk (drivers/firmware/dmi_scan.c:1115)
>  dmi_sysfs_init (drivers/firmware/dmi-sysfs.c:149) dmi_sysfs
>  do_one_initcall (init/main.c:1296)
>  ...
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: 0x4000000 from 0xffffffff81000000
> ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> It is because previous patch added kobject_put() to release the memory
> which will call  dmi_sysfs_entry_release() and list_del().
> 
> However, list_add_tail(entry->list) is called after the error block,
> so the list_head is uninitialized and cannot be deleted.
> 
> Move error handling to after list_add_tail to fix this.
> 
> Fixes: 660ba678f999 ("firmware: dmi-sysfs: Fix memory leak in dmi_sysfs_register_handle")
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
> v1 -> v2:
> Change fix to moving error handling to after list_add_tail.
> So that it is consistent with kobject_put(&entry->kobj) in other
> places.

<snip>

I got 2 copies of this, which one is correct?

thanks,

greg k-h
