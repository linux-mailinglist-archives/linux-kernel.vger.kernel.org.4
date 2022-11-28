Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCBE63A74A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiK1Lm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiK1LmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:42:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90EF15A11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:42:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5671061127
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AA5C433C1;
        Mon, 28 Nov 2022 11:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669635743;
        bh=0jYGKi9Rw7l0Ynb7pJ7Lgdo+KwQcaw53TAev7Zp6YL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQkbP3HNnWvrdNHtJk4a+uXZn0YobL6h1DB7nIe0l+xPdBfHempYlGEfpp6u+ZLtb
         GgNxqL6u86nFzoAJtXjdGrLFrLH+xPvkRlllC56ATbxjyTCAyX+VFvGYKX0jj6z/hY
         4BnbuH3YcINrxqrOUK8zXSDoWPIyvjAWfvnvvc2Q=
Date:   Mon, 28 Nov 2022 12:42:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     tglx@linutronix.de, kraig@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/irqdesc: fix WARNING in irq_sysfs_del()
Message-ID: <Y4Semf3t/hgPsr3v@kroah.com>
References: <20221126082716.438271-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126082716.438271-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 04:27:16PM +0800, Yang Yingliang wrote:
> I got the lots of WARNING report when doing fault injection test:
> 
> kernfs: can not remove 'chip_name', no directory
> WARNING: CPU: 0 PID: 253 at fs/kernfs/dir.c:1616 kernfs_remove_by_name_ns+0xce/0xe0
> RIP: 0010:kernfs_remove_by_name_ns+0xce/0xe0
> Call Trace:
>  <TASK>
>  remove_files.isra.1+0x3f/0xb0
>  sysfs_remove_group+0x68/0xe0
>  sysfs_remove_groups+0x41/0x70
>  __kobject_del+0x45/0xc0
>  kobject_del+0x29/0x40
>  free_desc+0x42/0x70
>  irq_free_descs+0x5e/0x90
> 
> kernfs: can not remove 'hwirq', no directory
> WARNING: CPU: 0 PID: 253 at fs/kernfs/dir.c:1616 kernfs_remove_by_name_ns+0xce/0xe0
> RIP: 0010:kernfs_remove_by_name_ns+0xce/0xe0
> Call Trace:
>  <TASK>
>  remove_files.isra.1+0x3f/0xb0
>  sysfs_remove_group+0x68/0xe0
>  sysfs_remove_groups+0x41/0x70
>  __kobject_del+0x45/0xc0
>  kobject_del+0x29/0x40
>  free_desc+0x42/0x70
>  irq_free_descs+0x5e/0x90
> 
> If irq_sysfs_add() fails in alloc_descs(), the directory of interrupt
> informations is not added to sysfs, it causes the WARNINGs when removing
> the information files. Fix this by adding check kobj.state_in_sysfs in
> irq_sysfs_del().
> 
> Fixes: ecb3f394c5db ("genirq: Expose interrupt information through sysfs")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  kernel/irq/irqdesc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index a91f9001103c..e391f4195b87 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -303,7 +303,7 @@ static void irq_sysfs_del(struct irq_desc *desc)
>  	 * kobject_del() complains about a object with no parent, so make
>  	 * it conditional.
>  	 */
> -	if (irq_kobj_base)
> +	if (irq_kobj_base && desc->kobj.state_in_sysfs)

No, this is not ok, you are poking around in the core of sysfs in a
field that should be private and not be able to be seen by anyone else.
Fix this properly and do not try to remove a kobject that you know was
not registered properly.

thanks,

greg k-h
