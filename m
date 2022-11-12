Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28D062683D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 09:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiKLI7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 03:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKLI7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 03:59:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A5F205F9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 00:59:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25774B80025
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 08:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C0AC433C1;
        Sat, 12 Nov 2022 08:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668243551;
        bh=Ypk2MWBUPXJv/NWxF6HqJaH7mpCsB7DE1ZHqHg7Zn2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZZxpJfIVz3AC8YJOWuefWNyai5N24xOfjam+lheVm+peFLghpgxzlOwLk7rwsxh+
         RJg4BMjBdZjI/jyA+xJXwrBBwXck4pA+vi48vzFhY9QDHaJmUfobGM4nmMmz2B2S3N
         iYY9I9NCAapjyE4vMUm1OIz700GpVKCh/xRKnlEU=
Date:   Sat, 12 Nov 2022 09:59:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/irqdesc: hide illegible sysfs warning of
 kobject_del()
Message-ID: <Y29gXLqK2wiu7/WK@kroah.com>
References: <20221112093939.616270-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112093939.616270-1-liushixin2@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 05:39:39PM +0800, Liu Shixin wrote:
> If irq_sysfs_add() failed, system will report a warning but don't call
> kobject_put() to release the descriptor.

I can not parse this sentance :(

> Then in irq_sysfs_del(), we continue to call kobject_del(). In such
> situation, kobject_del() will complains about a object with no parent
> like this:

Then we should not be calling irq_sysfs_del() if the call failed.  That
is the real fix here.

> 
>  kernfs: can not remove 'actions', no directory
>  WARNING: CPU: 0 PID: 277 at fs/kernfs/dir.c:1615 kernfs_remove_by_name_ns+0xd5/0xe0
> [...]
>  Call Trace:
>   <TASK>
>   remove_files.isra.0+0x3f/0xb0
>   sysfs_remove_group+0x68/0xe0
>   sysfs_remove_groups+0x41/0x70
>   __kobject_del+0x45/0xc0
>   kobject_del+0x2a/0x40
>   free_desc+0x44/0x70
>   irq_free_descs+0x5d/0x90
> [...]
> 
> Use kobj->state_in_sysfs to check whether kobject is added succeed. And
> if not, we should not call kobject_del().

That does not describe what you are doing here at all.

> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  kernel/irq/irqdesc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index a91f9001103c..a820d96210d4 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -300,10 +300,11 @@ static void irq_sysfs_del(struct irq_desc *desc)
>  	/*
>  	 * If irq_sysfs_init() has not yet been invoked (early boot), then
>  	 * irq_kobj_base is NULL and the descriptor was never added.
> +	 * And the descriptor may be added failed.
>  	 * kobject_del() complains about a object with no parent, so make
>  	 * it conditional.
>  	 */
> -	if (irq_kobj_base)
> +	if (irq_kobj_base && desc->kobj.parent)

How would the parent be NULL?  Parent devices always stick around until
the child is removed, otherwise something is really wrong here.  You
should never have to look at the parent.

thanks,

greg k-h
