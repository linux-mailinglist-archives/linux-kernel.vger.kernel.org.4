Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A3574C01E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 02:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGIAKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 20:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGIAKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 20:10:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62941BF
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 17:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52EE060B4A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 00:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61703C433C7;
        Sun,  9 Jul 2023 00:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688861446;
        bh=jX6wUeiIgGiJfEHuDBGSpvZCdyiNO4CdZ3loW3fl8m8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=H67A4+Rcrql9SNp94g1HITqejrttPjk5/EZuoIVraA9oi3Ez3YaryntlzQTFpJBcB
         jjBHfzmHNy2CUCl+yrSnWmWToKGiSZqiydwNWY/RSOS4FwOfhK/vIXJrcLrwEELcLH
         kvV7968IO9EIGzjuYvoYcpMyQt1zzHufi2vseHBnxzmjKN31gsblulXnMBZ4P76D93
         OKm6FYj9kXumMJ+TqKekWTPo1x9UVjyrMW2BXZtVXou1fcEA1WTkNkef4tzr8x6QR7
         mZXUC/1frqHjHqQkC4z/c1MBCQ6DiSkBFfCegv+9zskmIuQfkrjbCFVS2o5WkmS4Ye
         /9cUQEwNGeiHA==
Date:   Sat, 8 Jul 2023 17:10:43 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Rahul Singh <Rahul.Singh@arm.com>
cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jane Malalane <jane.malalane@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2] xen/evtchn: Introduce new IOCTL to bind static
 evtchn
In-Reply-To: <156827AA-3DFB-4DA2-BC82-7A27E77C2092@arm.com>
Message-ID: <alpine.DEB.2.22.394.2307081710210.761183@ubuntu-linux-20-04-desktop>
References: <764d561e3aecb7e63e8601dc50aaef9fc40834e4.1688051342.git.rahul.singh@arm.com> <90c961d4-9d10-6fbc-b5f7-84d231264289@epam.com> <156827AA-3DFB-4DA2-BC82-7A27E77C2092@arm.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1772280971-1688861446=:761183"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-1772280971-1688861446=:761183
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 30 Jun 2023, Rahul Singh wrote:
> Hi Oleksandr,
> 
> Thanks for reviewing the code.
> 
> > On 29 Jun 2023, at 7:06 pm, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com> wrote:
> > 
> > 
> > 
> > On 29.06.23 18:46, Rahul Singh wrote:
> > 
> > Hello Rahul
> > 
> > 
> >> Xen 4.17 supports the creation of static evtchns. To allow user space
> >> application to bind static evtchns introduce new ioctl
> >> "IOCTL_EVTCHN_BIND_STATIC". Existing IOCTL doing more than binding
> >> that’s why we need to introduce the new IOCTL to only bind the static
> >> event channels.
> >> 
> >> Also, static evtchns to be available for use during the lifetime of the
> >> guest. When the application exits, __unbind_from_irq() ends up being
> >> called from release() file operations because of that static evtchns
> >> are getting closed. To avoid closing the static event channel, add the
> >> new bool variable "is_static" in "struct irq_info" to mark the event
> >> channel static when creating the event channel to avoid closing the
> >> static evtchn.
> >> 
> >> Signed-off-by: Rahul Singh <rahul.singh@arm.com>
> >> ---
> >> v2:
> >>  * Use bool in place u8 to define is_static variable.
> >>  * Avoid closing the static evtchns in error path.
> > 
> > 
> > Patch looks good to me, just a nit (question) below.
> > 
> > 
> >> ---
> >>  drivers/xen/events/events_base.c |  7 +++++--
> >>  drivers/xen/evtchn.c             | 30 ++++++++++++++++++++++--------
> >>  include/uapi/xen/evtchn.h        |  9 +++++++++
> >>  include/xen/events.h             |  2 +-
> >>  4 files changed, 37 insertions(+), 11 deletions(-)
> >> 
> >> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> >> index c7715f8bd452..5d3b5c7cfe64 100644
> >> --- a/drivers/xen/events/events_base.c
> >> +++ b/drivers/xen/events/events_base.c
> >> @@ -112,6 +112,7 @@ struct irq_info {
> >>   unsigned int irq_epoch; /* If eoi_cpu valid: irq_epoch of event */
> >>   u64 eoi_time;           /* Time in jiffies when to EOI. */
> >>   raw_spinlock_t lock;
> >> + bool is_static;           /* Is event channel static */
> >> 
> >>   union {
> >>   unsigned short virq;
> >> @@ -982,7 +983,8 @@ static void __unbind_from_irq(unsigned int irq)
> >>   unsigned int cpu = cpu_from_irq(irq);
> >>   struct xenbus_device *dev;
> >> 
> >> - xen_evtchn_close(evtchn);
> >> + if (!info->is_static)
> >> + xen_evtchn_close(evtchn);
> >> 
> >>   switch (type_from_irq(irq)) {
> >>   case IRQT_VIRQ:
> >> @@ -1574,7 +1576,7 @@ int xen_set_irq_priority(unsigned irq, unsigned priority)
> >>  }
> >>  EXPORT_SYMBOL_GPL(xen_set_irq_priority);
> >> 
> >> -int evtchn_make_refcounted(evtchn_port_t evtchn)
> >> +int evtchn_make_refcounted(evtchn_port_t evtchn, bool is_static)
> >>  {
> >>   int irq = get_evtchn_to_irq(evtchn);
> >>   struct irq_info *info;
> >> @@ -1590,6 +1592,7 @@ int evtchn_make_refcounted(evtchn_port_t evtchn)
> >>   WARN_ON(info->refcnt != -1);
> >> 
> >>   info->refcnt = 1;
> >> + info->is_static = is_static;
> >> 
> >>   return 0;
> >>  }
> >> diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
> >> index c99415a70051..e6d2303478b2 100644
> >> --- a/drivers/xen/evtchn.c
> >> +++ b/drivers/xen/evtchn.c
> >> @@ -366,7 +366,8 @@ static int evtchn_resize_ring(struct per_user_data *u)
> >>   return 0;
> >>  }
> >> 
> >> -static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port)
> >> +static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port,
> >> + bool is_static)
> >>  {
> >>   struct user_evtchn *evtchn;
> >>   struct evtchn_close close;
> >> @@ -402,14 +403,16 @@ static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port)
> >>   if (rc < 0)
> >>   goto err;
> >> 
> >> - rc = evtchn_make_refcounted(port);
> >> + rc = evtchn_make_refcounted(port, is_static);
> >>   return rc;
> >> 
> >>  err:
> >>   /* bind failed, should close the port now */
> >> - close.port = port;
> >> - if (HYPERVISOR_event_channel_op(EVTCHNOP_close, &close) != 0)
> >> - BUG();
> >> + if (!is_static) {
> > 
> > 
> > I think now "struct evtchn_close close;" can be placed here as it is not 
> > used outside of this block.
> > 
> > Also this block looks like an open-coded version of xen_evtchn_close()
> > defined at events_base.c, so maybe it is worth making xen_evtchn_close() 
> > static inline and placing it into events.h, then calling helper here?
> > Please note, I will be ok either way.
> 
> Make sense. I will modify the patch as per your request in the next version.
> I will wait for other maintainers to review the patch before sending the
> next version.

I don't have any further comments.
--8323329-1772280971-1688861446=:761183--
