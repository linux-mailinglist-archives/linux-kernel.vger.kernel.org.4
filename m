Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3692D605166
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiJSUik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJSUii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:38:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461F819C060
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:38:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C41C16193C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472F0C433C1;
        Wed, 19 Oct 2022 20:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666211916;
        bh=A/VeIiymKAD/CA/qi6EVdDQ9Ix/I6WbTZMy4WD/Zvdc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=SOl4GvBO0+9bc1cDDPss8etiIjqoxxxV2PTlQa/GUdtICkfpc+g/dKGA+WxssDsnj
         pEDjm3FNW15KrBof4o7ltUgybSljk3q/+uvEVXvOJRHCaYTCdvkLelMsT+ongQZwN4
         prwvyANRKaMawTPsqvNgeGQTm1+F+s/vAAPoHbN7CJLGU5woD/XqJmPJnLkK3OBIAl
         sfwV9eqHlzMQErykxsA5q1J8SJEftKymEYBPxdFA+xNpxqZNp09t2d7pQ4LQZGxOT3
         HTK7qdpwCMIdjrZdewcG3fxJgBWylcw4Z6ZJMstA0fq5kr100v/MoSrq+FSHUjERg3
         q5zqCOQrWMlOg==
Date:   Wed, 19 Oct 2022 13:38:33 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>, vikram.garhwal@amd.com
Subject: Re: [PATCH] xen/virtio: Handle PCI devices which Host controller is
 described in DT
In-Reply-To: <af073c71-df43-4a5c-c67a-a9858678f588@epam.com>
Message-ID: <alpine.DEB.2.22.394.2210191314410.3873@ubuntu-linux-20-04-desktop>
References: <20221006174804.2003029-1-olekstysh@gmail.com> <alpine.DEB.2.22.394.2210061747590.3690179@ubuntu-linux-20-04-desktop> <f98f9f44-20e9-af8d-8970-9f6241c8dc44@epam.com> <alpine.DEB.2.22.394.2210121733240.3690179@ubuntu-linux-20-04-desktop>
 <16485bc9-0e2a-788a-93b8-453cc9ef0d3c@epam.com> <alpine.DEB.2.22.394.2210171323450.2351079@ubuntu-linux-20-04-desktop> <af073c71-df43-4a5c-c67a-a9858678f588@epam.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-682290085-1666210582=:3873"
Content-ID: <alpine.DEB.2.22.394.2210191316280.3873@ubuntu-linux-20-04-desktop>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-682290085-1666210582=:3873
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2210191316281.3873@ubuntu-linux-20-04-desktop>

+ Vikram

On Wed, 19 Oct 2022, Oleksandr Tyshchenko wrote:
> >> Regarding the virtio-mmio (platform) devices, yes, we could expose them
> >> with status "disabled", and they won't get probed by default.
> >> To be honest, I have experimented with that, when I was thinking of
> >> possible hotplug for virtio-mmio devices (I know, this sounds uncommon
> >> and strange).
> >> I used Linux feature (CONFIG_OF_DYNAMIC, overlays) to update the
> >> device-tree on running guest, so the toolstack initially inserts
> >> virtio-mmio device nodes for non-boot devices
> >> with status "disabled", and at the runtime, once we receive an event for
> >> example, we change the status to "ok" and the corresponding virtio-mmio
> >> device gets probed.
> >> But again, it is not a 100% hotplug, as we need to pre-allocate memory
> >> range and interrupt in advance (when generating guest device tree).
> > Actually this is really cool! Does it work? It doesn't matter to me if
> > the virtio devices are pci or mmio as long as we can solve the "wait"
> > problem. So this could be a good solution.
> 
> 
> ... yes, it does. Initially I experimented with virtio-mmio devices, but 
> today I tried with PCI host bridge as well.
> I won't describe the commands which I used to apply/remove device-tree 
> overlays from the userspace as well as the context of
> dtso files I created, I will describe how that could be done from the 
> kernel by using existing functionality (CONFIG_OF_DYNAMIC).
> 
> As I said if we exposed the devices with status "disabled", they 
> wouldn't get probed by default. Once we receive an signal
> that otherend is ready, we change the status to "ok" and the 
> corresponding device gets probed.
> 
> So below the test patch, which just change the status of the required 
> device-tree node (as you can see the code to update the property is 
> simple enough),
> I hacked "xl sysrq" for the convenience of testing.
> 
> 
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index 045c1805b2d5..9683ce075bc9 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -10,6 +10,7 @@
>   #include <linux/module.h>
>   #include <linux/dma-map-ops.h>
>   #include <linux/of.h>
> +#include <linux/of_platform.h>
>   #include <linux/pci.h>
>   #include <linux/pfn.h>
>   #include <linux/xarray.h>
> @@ -379,6 +380,108 @@ bool xen_is_grant_dma_device(struct device *dev)
>          return false;
>   }
> 
> +/* TODO: Consider using statically allocated (struct property status) */
> +static int xen_grant_dma_enable_device(struct device_node *np)
> +{
> +       struct property *status;
> +
> +       status = kzalloc(sizeof(*status), GFP_KERNEL);
> +       if (!status)
> +               return -ENOMEM;
> +
> +       status->name = kstrdup("status", GFP_KERNEL);
> +       if (!status->name)
> +               return -ENOMEM;
> +
> +       status->value = kstrdup("okay", GFP_KERNEL);
> +       if (!status->value)
> +               return -ENOMEM;
> +
> +       status->length = sizeof("okay");
> +
> +       return of_update_property(np, status);
> +}
> +
> +static int xen_grant_dma_disable_device(struct device_node *np)
> +{
> +       struct property *status;
> +
> +       status = kzalloc(sizeof(*status), GFP_KERNEL);
> +       if (!status)
> +               return -ENOMEM;
> +
> +       status->name = kstrdup("status", GFP_KERNEL);
> +       if (!status->name)
> +               return -ENOMEM;
> +
> +       status->value = kstrdup("disabled", GFP_KERNEL);
> +       if (!status->value)
> +               return -ENOMEM;
> +
> +       status->length = sizeof("disabled");
> +
> +       return of_update_property(np, status);
> +}
> +
> +void xen_grant_dma_handle_sysrq(int key)
> +{
> +       struct device_node *np;
> +       const char *path;
> +       bool enable;
> +
> +       printk("%s: got key %d\n", __func__, key);
> +
> +       switch (key) {
> +       case '0':
> +               path = "/virtio@2000000";
> +               enable = true;
> +               break;
> +
> +       case '1':
> +               path = "/virtio@2000200";
> +               enable = true;
> +               break;
> +
> +       case '2':
> +               path = "/virtio@2000000";
> +               enable = false;
> +               break;
> +
> +       case '3':
> +               path = "/virtio@2000200";
> +               enable = false;
> +               break;
> +
> +       case '4':
> +               path = "/pcie@10000000";
> +               enable = true;
> +               break;
> +
> +       case '5':
> +               path = "/pcie@10000000";
> +               enable = false;
> +               break;
> +
> +       default:
> +               printk("%s: wrong key %d\n", __func__, key);
> +               return;
> +       }
> +
> +       np = of_find_node_by_path(path);
> +       if (!np) {
> +               printk("%s: failed to find node by path %s\n", __func__, 
> path);
> +               return;
> +       }
> +
> +       if (enable) {
> +               xen_grant_dma_enable_device(np);
> +               printk("%s: enable %s\n", __func__, path);
> +       } else {
> +               xen_grant_dma_disable_device(np);
> +               printk("%s: disable %s\n", __func__, path);
> +       }
> +}
> +
>   bool xen_virtio_mem_acc(struct virtio_device *dev)
>   {
>          if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) || xen_pv_domain())
> diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
> index c16df629907e..6df96be1ea40 100644
> --- a/drivers/xen/manage.c
> +++ b/drivers/xen/manage.c
> @@ -308,7 +308,8 @@ static void sysrq_handler(struct xenbus_watch 
> *watch, const char *path,
>                  goto again;
> 
>          if (sysrq_key != '\0')
> -               handle_sysrq(sysrq_key);
> +               /*handle_sysrq(sysrq_key);*/
> +               xen_grant_dma_handle_sysrq(sysrq_key);
>   }
> 
>   static struct xenbus_watch sysrq_watch = {
> diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
> index a34f4271a2e9..c2da1bc24091 100644
> --- a/include/xen/xen-ops.h
> +++ b/include/xen/xen-ops.h
> @@ -215,6 +215,8 @@ static inline void xen_preemptible_hcall_end(void) { }
> 
>   #endif /* CONFIG_XEN_PV && !CONFIG_PREEMPTION */
> 
> +void xen_grant_dma_handle_sysrq(int key);
> +
>   #ifdef CONFIG_XEN_GRANT_DMA_OPS
>   void xen_grant_setup_dma_ops(struct device *dev);
>   bool xen_is_grant_dma_device(struct device *dev);
> (END)
> 
> So how it looks like:
> 
> 1. DomU boots without PCI Host bridge probed. So nothing PCI related is 
> observed in DomU.
> 
> cat /proc/device-tree/pcie@10000000/status
> disabled
> 
> 2. I run backends in DomD and after that issue a signal to "enable"
> 
> root@generic-armv8-xt-dom0:~# xl sysrq DomU 4
> 
> 3. The PCI Host bridge is probed, and all required PCI devices are 
> discovered
> 
> root@generic-armv8-xt-dom0:~# xl console DomU
> [  237.407620] xen_grant_dma_handle_sysrq: got key 52
> [  237.408133] pci-host-generic 10000000.pcie: host bridge 
> /pcie@10000000 ranges:
> [  237.408186] pci-host-generic 10000000.pcie:      MEM 
> 0x0023000000..0x0032ffffff -> 0x0023000000
> [  237.408231] pci-host-generic 10000000.pcie:      MEM 
> 0x0100000000..0x01ffffffff -> 0x0100000000
> [  237.408313] pci-host-generic 10000000.pcie: ECAM at [mem 
> 0x10000000-0x1fffffff] for [bus 00-ff]
> [  237.408451] pci-host-generic 10000000.pcie: PCI host bridge to bus 
> 0000:00
> [  237.408490] pci_bus 0000:00: root bus resource [bus 00-ff]
> [  237.408517] pci_bus 0000:00: root bus resource [mem 
> 0x23000000-0x32ffffff]
> [  237.408545] pci_bus 0000:00: root bus resource [mem 
> 0x100000000-0x1ffffffff pref]
> [  237.409043] pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
> [  237.458045] pci 0000:00:01.0: [1af4:1041] type 00 class 0x020000
> [  237.502588] pci 0000:00:01.0: reg 0x20: [mem 0x00000000-0x00003fff 
> 64bit pref]
> [  237.507475] pci 0000:00:02.0: [1af4:1042] type 00 class 0x010000
> [  237.552706] pci 0000:00:02.0: reg 0x20: [mem 0x00000000-0x00003fff 
> 64bit pref]
> [  237.559847] pci 0000:00:01.0: BAR 4: assigned [mem 
> 0x100000000-0x100003fff 64bit pref]
> [  237.560411] pci 0000:00:02.0: BAR 4: assigned [mem 
> 0x100004000-0x100007fff 64bit pref]
> [  237.563324] virtio-pci 0000:00:01.0: Set up Xen grant DMA ops (rid 
> 0x8 sid 0x1)
> [  237.564833] virtio-pci 0000:00:01.0: enabling device (0000 -> 0002)
> [  237.582734] virtio-pci 0000:00:02.0: Set up Xen grant DMA ops (rid 
> 0x10 sid 0x1)
> [  237.583413] virtio-pci 0000:00:02.0: enabling device (0000 -> 0002)
> [  237.595712] virtio_blk virtio1: 4/0/0 default/read/poll queues
> [  237.596227] virtio_net virtio0 enp0s1: renamed from eth1
> [  237.602499] virtio_blk virtio1: [vda] 4096000 512-byte logical blocks 
> (2.10 GB/1.95 GiB)
> [  237.606317] xen_grant_dma_handle_sysrq: enable /pcie@10000000
> 
> 4. The same way the pseudo-hotremove would work (if we change the status 
> to "disabled" the corresponding device gets removed)
> 
> 
> If this pseudo-hotplug sounds appropriate for the dom0less,

This is great! Yes I think it is totally acceptable.


> the one of the next questions would be what mechanism to use for
> signalling (event, xenstore, whatever).

For your information, we had to solve a similar issue a few months ago
to let a domU discover a newly added and directly assigned programmable
logic block. That was also done by applying DT overlays, first to Xen,
then to the domU.

Have a look at Vikram's Xen Summit presentation:
https://static.sched.com/hosted_files/xen2022/e8/Introduce%20Dynamic%20Device%20Node%20Programming%20for%20Xen.pdf

We wrote a small xenstore-based protocol to notify the domU and also to
tranfer the overlay to it:

https://github.com/Xilinx/xen/blob/xlnx_rebase_4.16/docs/misc/arm/overlay.txt
https://github.com/Xilinx/xen/blob/xlnx_rebase_4.16/tools/helpers/get_overlay.c

There is a good description starting at slide 16 in the PDF.


I am only sharing this as FYI. This Virtio problem is simpler because we
already know the devices that are going to become available. We don't
need an actual DT overlay to be passed to the domU. So we could get away
with just a single interrupt or a single xenstore property.


> Note that signal should only be sent if all backends which serve
> virtio-pci devices within that PCI Host bridge are ready.

Yes. That should be fine as long as all the backends are in the same
domain. I can imagine there could be difficulties if the backends are
in different domains: backend-domain-1 would have to tell dom0 that it
is ready, then backend-domain-2 would have to do the same, then dom0
finally notifies the domU, or something like that.

Anyway, I think this is good enough to start as a solution. Excellent!


> >>> Other ideas?
> >> Another (crazy?) idea is to reuse CONFIG_XEN_VIRTIO_FORCE_GRANT for
> >> dom0less system (I mean without "xen,grant-dma" bindings at all).
> >> If virtio backends are always going to run in Dom0 when we have it up
> >> and running, then it should work as domid == 0 is reserved for Dom0.
> >> If there is a need to run virtio backends in other *backend* domain (for
> >> the domain ID to be always known we could reserve an ID for it, so it
> >> would be a const value),
> >> we could probably introduce something configurable like
> >> CONFIG_XEN_VIRTIO_FORCE_GRANT_BE_DOMID with 0 by default (or cmd line
> >> option).
> > The problem in a dom0less system is not much how to tell which is the
> > backend domid, because that is known in advance and could be added to
> > device tree at boot somehow. The issue is how to ask the frontend to
> > "wait" and then how to tell the frontend to "proceed" after the backend
> > comes online.
> 
> please see above.
> 
> 
> To summarize:
> 
> 1. For normal case there is no problem with communicating the backend 
> domid on Arm with device-tree (neither for virtio-mmio nor for virtio-pci),
> for the virtio-pci the V2 (PCI-IOMMU bindings) should be used. For the 
> dom0less there won't be problem also as I understood from the discussion 
> (as the configuration is known in advance).
> So I propose to concentrate on V2.

Yes I agree


> 2. The problem is in supporting virtio for the dom0less in general 
> despite whether it is a foreign or grant mappings.
> Here we would need a (pseudo-)hotplug or some other method to start 
> operating only when backend is available.

Yes I think you are right
--8323329-682290085-1666210582=:3873--
