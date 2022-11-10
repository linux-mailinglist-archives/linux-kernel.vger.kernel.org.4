Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8980462489C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiKJRuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiKJRuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:50:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438382F670
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:50:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ADEDCCE2365
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABA4C433D6;
        Thu, 10 Nov 2022 17:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668102597;
        bh=OVjUU7r1CsVN2aMCZg7F/ys5w7Y53PtBg4hEbIP71KI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P84HxD67ZT0G9k/UDyNL2wHXO3penxfkGPED5rdUIUBhckaJOY9oemuKGU1Atxdv0
         PnXEOf6QVJBMlhJ1ncLnWV39gw023fjvCRrUGENcQXLWDbdPwIeiK/FVU6sA+jHxjT
         uw4uBnHfWohUBeJqcdWTD2P2bMx7/nvT1TTS9MMA=
Date:   Thu, 10 Nov 2022 18:49:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linmq006@gmail.com
Subject: Re: [PATCH] firmware: dmi-sysfs: Fix null-ptr-deref in
 dmi_sysfs_register_handle
Message-ID: <Y205w1j7lc1a5EPS@kroah.com>
References: <20221017095342.2567-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017095342.2567-1-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 05:53:42PM +0800, Chen Zhongjin wrote:
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
> Because entry is allocated by kzalloc() so the list.prev is NULL in
> the error path. Check it in dmi_sysfs_entry_release() to avoid
> deleting uninitialized list_head.
> 
> Fixes: 660ba678f999 ("firmware: dmi-sysfs: Fix memory leak in dmi_sysfs_register_handle")
> 
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  drivers/firmware/dmi-sysfs.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
> index 66727ad3361b..f8815eeed00c 100644
> --- a/drivers/firmware/dmi-sysfs.c
> +++ b/drivers/firmware/dmi-sysfs.c
> @@ -557,9 +557,12 @@ static void dmi_sysfs_entry_release(struct kobject *kobj)
>  {
>  	struct dmi_sysfs_entry *entry = to_entry(kobj);
>  
> -	spin_lock(&entry_list_lock);
> -	list_del(&entry->list);
> -	spin_unlock(&entry_list_lock);
> +	if (entry->list.prev != NULL) {

You should not be poking around in a lock structure like this at all.
Also the lock isn't held, so how do you know this is going to work?

I suggest fixing up the original patch, perhaps reverting that instead?

thanks,

greg k-h
