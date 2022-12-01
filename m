Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DD563E6F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 02:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiLABMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 20:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiLABL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 20:11:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E7C9491B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 17:11:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02B9EB81DA2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5679AC433B5;
        Thu,  1 Dec 2022 01:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669857113;
        bh=Cn7d5c1HM/HfMC8q2kd3oQKNeEpuHBhp1yz/hZ7/kV8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dIH078pHAHy01H3xD9BwApkD8WjAL3r9/Y7Na8gLSRGigs9r832+Tzl+ywiilKHqn
         /JGanG+BIAtQlheHMT3XiMYJ4rN8DIwtKS1ftndKOEiHw78xrrEup/dNaALuBmRTko
         yIFSqj6JbC4oM/OqckU7bqWcj0P7cVB/CkkIwe+M70Bx6C5eddoWETcFEOFN5K3m9j
         WvXl9BTgmuCxRc5cL1YtQKsNc9rlX8BYtOks8ppJqPjvgWhoYxMKo9/vyDv8rtkYYh
         a2dlKWoFm2fWusmbjnYo8do1Bm2VDjEt5L1eT6t/a+RvkyEjpYNy52hVkE/NBkpNU3
         9Bt9PPCk35Vgg==
Date:   Wed, 30 Nov 2022 17:11:50 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Roger Pau Monne <roger.pau@citrix.com>
cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Beulich <jbeulich@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] hvc/xen: lock console list traversal
In-Reply-To: <20221130163611.14686-1-roger.pau@citrix.com>
Message-ID: <alpine.DEB.2.22.394.2211301710270.4039@ubuntu-linux-20-04-desktop>
References: <20221130163611.14686-1-roger.pau@citrix.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1211100887-1669857113=:4039"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1211100887-1669857113=:4039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 30 Nov 2022, Roger Pau Monne wrote:
> The currently lockless access to the xen console list in
> vtermno_to_xencons() is incorrect, as additions and removals from the
> list can happen anytime, and as such the traversal of the list to get
> the private console data for a given termno needs to happen with the
> lock held.  Note users that modify the list already do so with the
> lock taken.
> 
> Adjust current lock takers to use the _irq{save,restore} helpers,
> since the context in which vtermno_to_xencons() is called can have
> interrupts disabled.  Use the _irq{save,restore} set of helpers to
> switch the current callers to disable interrupts in the locked region.
> I haven't checked if existing users could instead use the _irq
> variant, as I think it's safer to use _irq{save,restore} upfront.
> 
> While there switch from using list_for_each_entry_safe to
> list_for_each_entry: the current entry cursor won't be removed as
> part of the code in the loop body, so using the _safe variant is
> pointless.
> 
> Fixes: 02e19f9c7cac ('hvc_xen: implement multiconsole support')
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> Changes since v1:
>  - Switch current lock users to disable interrupts in the locked
>    region.
> ---
>  drivers/tty/hvc/hvc_xen.c | 46 ++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
> index e63c1761a361..d9d023275328 100644
> --- a/drivers/tty/hvc/hvc_xen.c
> +++ b/drivers/tty/hvc/hvc_xen.c
> @@ -53,17 +53,22 @@ static DEFINE_SPINLOCK(xencons_lock);
>  
>  static struct xencons_info *vtermno_to_xencons(int vtermno)
>  {
> -	struct xencons_info *entry, *n, *ret = NULL;
> +	struct xencons_info *entry, *ret = NULL;
> +	unsigned long flags;
>  
> -	if (list_empty(&xenconsoles))
> -			return NULL;
> +	spin_lock_irqsave(&xencons_lock, flags);
> +	if (list_empty(&xenconsoles)) {
> +		spin_unlock_irqrestore(&xencons_lock, flags);
> +		return NULL;
> +	}
>  
> -	list_for_each_entry_safe(entry, n, &xenconsoles, list) {
> +	list_for_each_entry(entry, &xenconsoles, list) {
>  		if (entry->vtermno == vtermno) {
>  			ret  = entry;
>  			break;
>  		}
>  	}
> +	spin_unlock_irqrestore(&xencons_lock, flags);
>  
>  	return ret;
>  }
> @@ -234,7 +239,7 @@ static int xen_hvm_console_init(void)
>  {
>  	int r;
>  	uint64_t v = 0;
> -	unsigned long gfn;
> +	unsigned long gfn, flags;
>  	struct xencons_info *info;
>  
>  	if (!xen_hvm_domain())
> @@ -270,9 +275,9 @@ static int xen_hvm_console_init(void)
>  		goto err;
>  	info->vtermno = HVC_COOKIE;
>  
> -	spin_lock(&xencons_lock);
> +	spin_lock_irqsave(&xencons_lock, flags);
>  	list_add_tail(&info->list, &xenconsoles);
> -	spin_unlock(&xencons_lock);
> +	spin_unlock_irqrestore(&xencons_lock, flags);
>  
>  	return 0;
>  err:
> @@ -296,6 +301,7 @@ static int xencons_info_pv_init(struct xencons_info *info, int vtermno)
>  static int xen_pv_console_init(void)
>  {
>  	struct xencons_info *info;
> +	unsigned long flags;
>  
>  	if (!xen_pv_domain())
>  		return -ENODEV;
> @@ -312,9 +318,9 @@ static int xen_pv_console_init(void)
>  		/* already configured */
>  		return 0;
>  	}
> -	spin_lock(&xencons_lock);
> +	spin_lock_irqsave(&xencons_lock, flags);
>  	xencons_info_pv_init(info, HVC_COOKIE);
> -	spin_unlock(&xencons_lock);
> +	spin_unlock_irqrestore(&xencons_lock, flags);
>  
>  	return 0;
>  }
> @@ -322,6 +328,7 @@ static int xen_pv_console_init(void)
>  static int xen_initial_domain_console_init(void)
>  {
>  	struct xencons_info *info;
> +	unsigned long flags;
>  
>  	if (!xen_initial_domain())
>  		return -ENODEV;
> @@ -337,9 +344,9 @@ static int xen_initial_domain_console_init(void)
>  	info->irq = bind_virq_to_irq(VIRQ_CONSOLE, 0, false);
>  	info->vtermno = HVC_COOKIE;
>  
> -	spin_lock(&xencons_lock);
> +	spin_lock_irqsave(&xencons_lock, flags);
>  	list_add_tail(&info->list, &xenconsoles);
> -	spin_unlock(&xencons_lock);
> +	spin_unlock_irqrestore(&xencons_lock, flags);
>  
>  	return 0;
>  }
> @@ -394,10 +401,12 @@ static void xencons_free(struct xencons_info *info)
>  
>  static int xen_console_remove(struct xencons_info *info)
>  {
> +	unsigned long flags;
> +
>  	xencons_disconnect_backend(info);
> -	spin_lock(&xencons_lock);
> +	spin_lock_irqsave(&xencons_lock, flags);
>  	list_del(&info->list);
> -	spin_unlock(&xencons_lock);
> +	spin_unlock_irqrestore(&xencons_lock, flags);
>  	if (info->xbdev != NULL)
>  		xencons_free(info);
>  	else {
> @@ -478,6 +487,7 @@ static int xencons_probe(struct xenbus_device *dev,
>  {
>  	int ret, devid;
>  	struct xencons_info *info;
> +	unsigned long flags;
>  
>  	devid = dev->nodename[strlen(dev->nodename) - 1] - '0';
>  	if (devid == 0)
> @@ -497,9 +507,9 @@ static int xencons_probe(struct xenbus_device *dev,
>  	ret = xencons_connect_backend(dev, info);
>  	if (ret < 0)
>  		goto error;
> -	spin_lock(&xencons_lock);
> +	spin_lock_irqsave(&xencons_lock, flags);
>  	list_add_tail(&info->list, &xenconsoles);
> -	spin_unlock(&xencons_lock);
> +	spin_unlock_irqrestore(&xencons_lock, flags);
>  
>  	return 0;
>  
> @@ -599,10 +609,12 @@ static int __init xen_hvc_init(void)
>  
>  	info->hvc = hvc_alloc(HVC_COOKIE, info->irq, ops, 256);
>  	if (IS_ERR(info->hvc)) {
> +		unsigned long flags;
> +
>  		r = PTR_ERR(info->hvc);
> -		spin_lock(&xencons_lock);
> +		spin_lock_irqsave(&xencons_lock, flags);
>  		list_del(&info->list);
> -		spin_unlock(&xencons_lock);
> +		spin_unlock_irqrestore(&xencons_lock, flags);
>  		if (info->irq)
>  			unbind_from_irqhandler(info->irq, NULL);
>  		kfree(info);
> -- 
> 2.37.3
> 
--8323329-1211100887-1669857113=:4039--
