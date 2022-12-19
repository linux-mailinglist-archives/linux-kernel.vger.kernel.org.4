Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D724650766
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 06:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiLSF5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 00:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiLSF5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 00:57:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2B160D8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 21:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671429383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1YVIFG5ASLDJsVejZ6lyd9CLA6aU0mKibk4ZoX9A1ok=;
        b=jQG1EnDEYoGU8lWFeSBjatpkNcpff10MQQUCZR6nNU4XZOriGutdK4oXw7/XJt6ZA0+qRq
        cyPzWrQWuTr0yTidFG0mnTi61pHR7eaR+1v/iTzArGoiTbbXmacc+DpkA8o/zt1y4UnxU9
        AyD5+/wm1Qck9p9szeeLtZnSPxpjt+o=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-115-_ZA3kZE5M9OCGcCSx8ugIQ-1; Mon, 19 Dec 2022 00:56:22 -0500
X-MC-Unique: _ZA3kZE5M9OCGcCSx8ugIQ-1
Received: by mail-qt1-f199.google.com with SMTP id h26-20020ac8505a000000b003a7e8e8b03bso3600157qtm.18
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 21:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YVIFG5ASLDJsVejZ6lyd9CLA6aU0mKibk4ZoX9A1ok=;
        b=JT7QuRcnkVwymDOuqK9hO3sXvKuumUe17JWMc/18+7ygSJO9Jro8aNhLgXfvsKopxC
         1b5muz9Rz2B1oe3L8QAUL+/4dm/UhDcxKMjC2njuCTNYZNaxQJxTqeFkpYViNxIxEBfI
         1CM7FS5AMR3Eb9YLQQO7tmfd7EFpFmRqXHiMJY5PSOXp2c6afHeVRftQwKGvEkSHOyqL
         UX7+eYJzJdiN7wBWNSsBB6YxEcgpkARqj/zDtJo82cHVrs5YCB1k9pwgF5bVZP/hsvV2
         3J57nRC3lV+z3mmad0931TjVk6MS5wsfThk/DidX8X/lJCfgJObSJlN51whWzQvw4Kno
         lUaw==
X-Gm-Message-State: AFqh2kqubxWQ/Mj4oQPsj/VrgH56uqPwPmTE5Tlg5JrRn6ElxRtKvN7I
        C+4mvIZut020BGeBVhV7IP2yKO+UAiwbTDdJLjjTC+F2KTF40UwwMiqk9mxs//LAEX7NfXk4GeE
        XsvOAwOiJ1LXPQDdR0x7HGn+F
X-Received: by 2002:a05:6214:3806:b0:4c7:a44:4843 with SMTP id ns6-20020a056214380600b004c70a444843mr11127662qvb.10.1671429381592;
        Sun, 18 Dec 2022 21:56:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsGT+Jx+wLtUrPbCzsIYqfziIyY7UkyBDh/VVwJMzg21tldwd7XzQhDQ3XYPGEo+48DT9kAGg==
X-Received: by 2002:a05:6214:3806:b0:4c7:a44:4843 with SMTP id ns6-20020a056214380600b004c70a444843mr11127651qvb.10.1671429381337;
        Sun, 18 Dec 2022 21:56:21 -0800 (PST)
Received: from redhat.com ([45.144.113.29])
        by smtp.gmail.com with ESMTPSA id c24-20020a05620a11b800b006fc2cee4486sm6351630qkk.62.2022.12.18.21.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 21:56:20 -0800 (PST)
Date:   Mon, 19 Dec 2022 00:56:15 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Parav Pandit <parav@nvidia.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Wei Gong <gongwei833x@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221219005553-mutt-send-email-mst@kernel.org>
References: <20221110144700-mutt-send-email-mst@kernel.org>
 <20221111234219.GA763705@bhelgaas>
 <20221113034519-mutt-send-email-mst@kernel.org>
 <20221116111619.GA5804@wunner.de>
 <PH0PR12MB54811F4658F068C46E071E81DC069@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB54811F4658F068C46E071E81DC069@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 05:36:48AM +0000, Parav Pandit wrote:
> 
> > From: Lukas Wunner <lukas@wunner.de>
> > Sent: Wednesday, November 16, 2022 6:16 AM
> > 
> > [cc += Parav Pandit, author of 43bb40c5b926]
> > 
> > On Sun, Nov 13, 2022 at 03:46:06AM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Nov 11, 2022 at 05:42:19PM -0600, Bjorn Helgaas wrote:
> > > > On Thu, Nov 10, 2022 at 03:15:55PM -0500, Michael S. Tsirkin wrote:
> > > > > On Thu, Nov 10, 2022 at 01:35:47PM -0600, Bjorn Helgaas wrote:
> > > > > > Prior to this change pci_device_is_present(VF) returned "false"
> > > > > > (because the VF Vendor ID is 0xffff); after the change it will
> > > > > > return "true" (because it will look at the PF Vendor ID instead).
> > > > > >
> > > > > > Previously virtio_pci_remove() called virtio_break_device().  I
> > > > > > guess that meant the virtio I/O operation will never be completed?
> > > > > >
> > > > > > But if we don't call virtio_break_device(), the virtio I/O
> > > > > > operation
> > > > > > *will* be completed?
> > >
> > > Just making sure - pci_device_is_present *is* the suggested way to
> > > distinguish between graceful and surprise removal, isn't it?
> > 
> > No, it's not.  Instead of !pci_device_is_present() you really want to call
> > pci_dev_is_disconnected() instead.
> > 
> > While the fix Bjorn applied for v6.2 may solve the issue and may make sense
> > on it's own, it's not the solution you're looking for.  You want to swap the
> > call to !pci_device_is_present() with pci_dev_is_disconnected(), move
> > pci_dev_is_disconnected() from drivers/pci/pci.h to include/linux/pci.h and
> > add a Fixes tag referencing 43bb40c5b926.
> > 
> > If you don't want to move pci_dev_is_disconnected(), you can alternatively
> > check for "pdev->error_state == pci_channel_io_perm_failure" or call
> > pci_channel_offline().  The latter will also return true though on transient
> > inaccessibility of the device (e.g. if it's being reset).
> > 
> pci_device_is_present() is calling pci_dev_is_disconnected().
> pci_dev_is_disconnected() avoids reading the vendor id.
> So pci_dev_is_disconnected() looks less strong check.
> I see that it can return a valid value on recoverable error case.
> 
> In that case, is pci_channel_offline() a more precise way to check that covers transient and permanent error?
> 
> And if that is the right check, we need to fix all the callers, mainly widely used nvme driver [1].
> 
> [1] https://elixir.bootlin.com/linux/v6.1-rc5/source/drivers/nvme/host/pci.c#L3228
> 
> Also, we need to add API documentation on when to use this API in context of hotplug, so that all related drivers can consistently use single API.

Bjorn, Lukas, what's your take on this idea?
Thanks!


> > The theory of operation is as follows:  The PCI layer does indeed know
> > whether the device was surprise removed or gracefully removed and that
> > information is passed in the "presence" flag to pciehp_unconfigure_device()
> > (in drivers/pci/hotplug/pciehp_pci.c).  That function does the following:
> > 
> > 	if (!presence)
> > 		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
> > 
> > In other words, pdev->error_state is set to pci_channel_io_perm_failure on
> > the entire hierarchy below the hotplug port.  And pci_dev_is_disconnected()
> > simply checks whether that's the device's error_state.
> > 
> > pci_dev_is_disconnected() makes sense if you definitely know the device is
> > gone and want to skip certain steps or delays on device teardown.
> > However be aware that the device may be hot-removed after graceful
> > removal was initiated.  In such a situation, pci_dev_is_disconnected() may
> > return false and you'll try to access the device as normal, even though it was
> > yanked from the slot after the pci_dev_is_disconnected() call was
> > performed.  Ideally you should be able to cope with such scenarios as well.
> > 
> > For some more background info, refer to this LWN article (scroll down to the
> > "Surprise removal" section):
> > https://lwn.net/Articles/767885/
> > 
> > Thanks,
> > 
> > Lukas

