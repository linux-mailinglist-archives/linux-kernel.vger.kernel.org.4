Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B4C63AEC0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiK1RUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiK1RUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:20:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8F119B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:20:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1BE1ACE0F98
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0911BC433C1;
        Mon, 28 Nov 2022 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669656027;
        bh=tf0WiEJqp3Uz7c/yGfr226KPsBoOUo/W6nhjIe3hjic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=au8F2IYRHB7WH8RgMo0xnUrTHRgaTH8dcj09VU0k2OvzAYh4CRiIYfJDTC0KKW5tm
         Ek/WggmTBpBPeEEtCm6eavBeK1+VpHDNZpc413sNPkEgZA46Hn8Zt1r91LUO1LzdU5
         dKmA7x2W26l+Y1Ws5wDDZ6e+H4kia+1sBDo1okfQ=
Date:   Mon, 28 Nov 2022 18:20:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     tglx@linutronix.de, kraig@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] genirq/irqdesc: fix WARNING in irq_sysfs_del()
Message-ID: <Y4Tt2NIcPFeoss4s@kroah.com>
References: <20221128151612.1786122-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128151612.1786122-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:16:12PM +0800, Yang Yingliang wrote:
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
> the information files. Add 'sysfs_added' field in struct irq_desc to
> indicate if it is added, and check it before calling kobject_del() to
> avoid these WARNINGs.
> 
> Fixes: ecb3f394c5db ("genirq: Expose interrupt information through sysfs")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v1 -> v2:
>   Don't use state_in_sysfs, introduce 'sysfs_added' to indicate if it is added.
> ---
>  include/linux/irqdesc.h | 1 +
>  kernel/irq/irqdesc.c    | 7 +++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
> index 844a8e30e6de..fec0f3946a34 100644
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -97,6 +97,7 @@ struct irq_desc {
>  #ifdef CONFIG_SPARSE_IRQ
>  	struct rcu_head		rcu;
>  	struct kobject		kobj;
> +	bool			sysfs_added;
>  #endif
>  	struct mutex		request_mutex;
>  	int			parent_irq;
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index a91f9001103c..9bf74d11bad5 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -292,6 +292,8 @@ static void irq_sysfs_add(int irq, struct irq_desc *desc)
>  		 */
>  		if (kobject_add(&desc->kobj, irq_kobj_base, "%d", irq))
>  			pr_warn("Failed to add kobject for irq %d\n", irq);
> +		else
> +			desc->sysfs_added = true;

Wait, no.  Why are you just not properly failing and unwinding here?
Why do you need a special flag just to say "sysfs worked" or not unlike
all other users of kobjects.

Fix this up properly please.

thanks,

greg k-h
