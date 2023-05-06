Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405296F8D3B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 02:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjEFAwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 20:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjEFAwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 20:52:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0135FE5
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 17:52:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FF37641B1
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 00:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D14C433D2;
        Sat,  6 May 2023 00:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683334364;
        bh=ALHPOAtna/tjSpwcldHIbCxstSQu3IlIOdXMLK1ymAk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=s0yzFH9qRgGUP+ca4jtTQerypoWoG51VOS6A+g3VEyKBY2xNAE7TKOqWi16rxNGti
         CAgY2oYIOq1jxq0wfZKej6MBEJ8cfsIOJ/BXrRLcKwC5SRzzDzbVJvZZhqftMjE5IE
         +YWk9Sn14B1chGnGsANBCTQFCwxpqrkF7l6oP87N3+8avr1HsnY9i9odXT2lWMQP7n
         0dSvqSi1R8iDGRoY76Ir8wPc1bftYPConBgX+NmkoXDYAVb0YyjApB8MyHWFvlngkh
         R+HySXoRmobwFj6V7unKA1BzJZlYgc2MbEnllsFt7wmQGvpS0ZpiSQF+a6eu43w32G
         S07IPWkMiPmgg==
Date:   Fri, 5 May 2023 17:52:40 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Rahul Singh <rahul.singh@arm.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Samuel Holland <samuel@sholland.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Marc Zyngier <maz@kernel.org>,
        Jane Malalane <jane.malalane@citrix.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH] xen/evtchn: Introduce new IOCTL to bind static evtchn
In-Reply-To: <48d30a439e37f6917b9a667289792c2b3f548d6d.1682685294.git.rahul.singh@arm.com>
Message-ID: <alpine.DEB.2.22.394.2305051750070.974517@ubuntu-linux-20-04-desktop>
References: <48d30a439e37f6917b9a667289792c2b3f548d6d.1682685294.git.rahul.singh@arm.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1916755753-1683334363=:974517"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1916755753-1683334363=:974517
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 28 Apr 2023, Rahul Singh wrote:
> Xen 4.17 supports the creation of static evtchns. To allow user space
> application to bind static evtchns introduce new ioctl
> "IOCTL_EVTCHN_BIND_STATIC". Existing IOCTL doing more than binding
> that’s why we need to introduce the new IOCTL to only bind the static
> event channels.
> 
> Also, static evtchns to be available for use during the lifetime of the
> guest. When the application exits, __unbind_from_irq() end up
> being called from release() fop because of that static evtchns are
> getting closed. To avoid closing the static event channel, add the new
> bool variable "is_static" in "struct irq_info" to mark the event channel
> static when creating the event channel to avoid closing the static
> evtchn.
> 
> Signed-off-by: Rahul Singh <rahul.singh@arm.com>

I think the patch is OK but evtchn_bind_to_user on the error path calls
EVTCHNOP_close. Could that be a problem for static evtchns? I wonder if
we need to skip that EVTCHNOP_close call too.


err:
	/* bind failed, should close the port now */
	close.port = port;
	if (HYPERVISOR_event_channel_op(EVTCHNOP_close, &close) != 0)
		BUG();
	del_evtchn(u, evtchn);


> ---
>  drivers/xen/events/events_base.c |  7 +++++--
>  drivers/xen/evtchn.c             | 22 +++++++++++++++++-----
>  include/uapi/xen/evtchn.h        |  9 +++++++++
>  include/xen/events.h             |  2 +-
>  4 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> index c7715f8bd452..31f2d3634ad5 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -112,6 +112,7 @@ struct irq_info {
>  	unsigned int irq_epoch; /* If eoi_cpu valid: irq_epoch of event */
>  	u64 eoi_time;           /* Time in jiffies when to EOI. */
>  	raw_spinlock_t lock;
> +	u8 is_static;           /* Is event channel static */
>  
>  	union {
>  		unsigned short virq;
> @@ -982,7 +983,8 @@ static void __unbind_from_irq(unsigned int irq)
>  		unsigned int cpu = cpu_from_irq(irq);
>  		struct xenbus_device *dev;
>  
> -		xen_evtchn_close(evtchn);
> +		if (!info->is_static)
> +			xen_evtchn_close(evtchn);
>  
>  		switch (type_from_irq(irq)) {
>  		case IRQT_VIRQ:
> @@ -1574,7 +1576,7 @@ int xen_set_irq_priority(unsigned irq, unsigned priority)
>  }
>  EXPORT_SYMBOL_GPL(xen_set_irq_priority);
>  
> -int evtchn_make_refcounted(evtchn_port_t evtchn)
> +int evtchn_make_refcounted(evtchn_port_t evtchn, bool is_static)
>  {
>  	int irq = get_evtchn_to_irq(evtchn);
>  	struct irq_info *info;
> @@ -1590,6 +1592,7 @@ int evtchn_make_refcounted(evtchn_port_t evtchn)
>  	WARN_ON(info->refcnt != -1);
>  
>  	info->refcnt = 1;
> +	info->is_static = is_static;
>  
>  	return 0;
>  }
> diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
> index c99415a70051..47681d4c696b 100644
> --- a/drivers/xen/evtchn.c
> +++ b/drivers/xen/evtchn.c
> @@ -366,7 +366,8 @@ static int evtchn_resize_ring(struct per_user_data *u)
>  	return 0;
>  }
>  
> -static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port)
> +static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port,
> +			bool is_static)
>  {
>  	struct user_evtchn *evtchn;
>  	struct evtchn_close close;
> @@ -402,7 +403,7 @@ static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port)
>  	if (rc < 0)
>  		goto err;
>  
> -	rc = evtchn_make_refcounted(port);
> +	rc = evtchn_make_refcounted(port, is_static);
>  	return rc;
>  
>  err:
> @@ -456,7 +457,7 @@ static long evtchn_ioctl(struct file *file,
>  		if (rc != 0)
>  			break;
>  
> -		rc = evtchn_bind_to_user(u, bind_virq.port);
> +		rc = evtchn_bind_to_user(u, bind_virq.port, false);
>  		if (rc == 0)
>  			rc = bind_virq.port;
>  		break;
> @@ -482,7 +483,7 @@ static long evtchn_ioctl(struct file *file,
>  		if (rc != 0)
>  			break;
>  
> -		rc = evtchn_bind_to_user(u, bind_interdomain.local_port);
> +		rc = evtchn_bind_to_user(u, bind_interdomain.local_port, false);
>  		if (rc == 0)
>  			rc = bind_interdomain.local_port;
>  		break;
> @@ -507,7 +508,7 @@ static long evtchn_ioctl(struct file *file,
>  		if (rc != 0)
>  			break;
>  
> -		rc = evtchn_bind_to_user(u, alloc_unbound.port);
> +		rc = evtchn_bind_to_user(u, alloc_unbound.port, false);
>  		if (rc == 0)
>  			rc = alloc_unbound.port;
>  		break;
> @@ -536,6 +537,17 @@ static long evtchn_ioctl(struct file *file,
>  		break;
>  	}
>  
> +	case IOCTL_EVTCHN_BIND_STATIC: {
> +		struct ioctl_evtchn_bind bind;
> +
> +		rc = -EFAULT;
> +		if (copy_from_user(&bind, uarg, sizeof(bind)))
> +			break;
> +
> +		rc = evtchn_bind_to_user(u, bind.port, true);
> +		break;
> +	}
> +
>  	case IOCTL_EVTCHN_NOTIFY: {
>  		struct ioctl_evtchn_notify notify;
>  		struct user_evtchn *evtchn;
> diff --git a/include/uapi/xen/evtchn.h b/include/uapi/xen/evtchn.h
> index 7fbf732f168f..aef2b75f3413 100644
> --- a/include/uapi/xen/evtchn.h
> +++ b/include/uapi/xen/evtchn.h
> @@ -101,4 +101,13 @@ struct ioctl_evtchn_restrict_domid {
>  	domid_t domid;
>  };
>  
> +/*
> + * Bind statically allocated @port.
> + */
> +#define IOCTL_EVTCHN_BIND_STATIC			\
> +	_IOC(_IOC_NONE, 'E', 7, sizeof(struct ioctl_evtchn_bind))
> +struct ioctl_evtchn_bind {
> +	unsigned int port;
> +};
> +
>  #endif /* __LINUX_PUBLIC_EVTCHN_H__ */
> diff --git a/include/xen/events.h b/include/xen/events.h
> index 44c2855c76d1..962f0bbc7ce1 100644
> --- a/include/xen/events.h
> +++ b/include/xen/events.h
> @@ -69,7 +69,7 @@ int xen_set_irq_priority(unsigned irq, unsigned priority);
>  /*
>   * Allow extra references to event channels exposed to userspace by evtchn
>   */
> -int evtchn_make_refcounted(evtchn_port_t evtchn);
> +int evtchn_make_refcounted(evtchn_port_t evtchn, bool is_static);
>  int evtchn_get(evtchn_port_t evtchn);
>  void evtchn_put(evtchn_port_t evtchn);
>  
> -- 
> 2.25.1
> 
--8323329-1916755753-1683334363=:974517--
