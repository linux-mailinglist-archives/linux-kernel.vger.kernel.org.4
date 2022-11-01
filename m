Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D997A6143F3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 05:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKAEo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 00:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAEo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 00:44:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF1F1740C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 21:44:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15B9C6153D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 04:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF90CC433D6;
        Tue,  1 Nov 2022 04:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667277865;
        bh=Mipyc3CoA+P5cam/PjXghLUUe5i2EnhXZ9VTJlib7/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLvg24yxzoUyRNO4EzNop33larWhcHBUvZ+HQBIipcci+/Dm2yCqgs0VbjclAXzp0
         8gIqT4E6OUCtdPr0QPFfmCG9c/HSR7NJL4jIw2/kOmeY4FTKE6M6weH0i7qM+ByJeU
         vUU6AOx6IKcSIztM91zvlW1ZEk22uuPNgDpS/p8s=
Date:   Tue, 1 Nov 2022 05:45:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        zhangxuezhi1@coolpad.com, fmhess@users.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] comedi: Fix potential memory leak in comedi_init()
Message-ID: <Y2CkW5EVLiLUoNWh@kroah.com>
References: <20221101032125.27337-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101032125.27337-1-shangxiaojing@huawei.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 11:21:25AM +0800, Shang XiaoJing wrote:
> comedi_init() will goto out_unregister_chrdev_region if cdev_add()
> failed, which won't free the resource alloced in kobject_set_name().
> Call kfree_const() to free the leaked name before goto
> out_unregister_chrdev_region.
> 
> unreferenced object 0xffff8881000fa8c0 (size 8):
>   comm "modprobe", pid 239, jiffies 4294905173 (age 51.308s)
>   hex dump (first 8 bytes):
>     63 6f 6d 65 64 69 00 ff                          comedi..
>   backtrace:
>     [<000000005f9878f7>] __kmalloc_node_track_caller+0x4c/0x1c0
>     [<000000000fd70302>] kstrdup+0x3f/0x70
>     [<000000009428bc33>] kstrdup_const+0x46/0x60
>     [<00000000ed50d9de>] kvasprintf_const+0xdb/0xf0
>     [<00000000b2766964>] kobject_set_name_vargs+0x3c/0xe0
>     [<00000000f2424ef7>] kobject_set_name+0x62/0x90
>     [<000000005d5a125b>] 0xffffffffa0013098
>     [<00000000f331e663>] do_one_initcall+0x7a/0x380
>     [<00000000aa7bac96>] do_init_module+0x5c/0x230
>     [<000000005fd72335>] load_module+0x227d/0x2420
>     [<00000000ad550cf1>] __do_sys_finit_module+0xd5/0x140
>     [<00000000069a60c5>] do_syscall_64+0x3f/0x90
>     [<00000000c5e0d521>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Fixes: ed9eccbe8970 ("Staging: add comedi core")
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>  drivers/comedi/comedi_fops.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index e2114bcf815a..2c508c2cf6f6 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -3379,8 +3379,11 @@ static int __init comedi_init(void)
>  
>  	retval = cdev_add(&comedi_cdev, MKDEV(COMEDI_MAJOR, 0),
>  			  COMEDI_NUM_MINORS);
> -	if (retval)
> +	if (retval) {
> +		kfree_const(comedi_cdev.kobj.name);
> +		comedi_cdev.kobj.name = NULL;
>  		goto out_unregister_chrdev_region;
> +	}

A driver should never have to poke around in the internals of a cdev
object like this.  Please fix the cdev core to not need this if
cdev_add() fails.

thanks,

greg k-h
