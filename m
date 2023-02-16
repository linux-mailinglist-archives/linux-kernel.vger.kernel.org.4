Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D9069986A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjBPPIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBPPIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:08:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B5D3251D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:07:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CDE3B82690
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9D2C433D2;
        Thu, 16 Feb 2023 15:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676560046;
        bh=+jQjyTtJNZoLvTJ7dAH55mjUgmu9ISpAsus6Fi/J13I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mb9CLrmShGTyWfqdZAE7XdP8oeL5c0Q/tNDYMMyzjLr8eiEuo2Z47hY5VZjz2ufZv
         6qqSrJiWvDb3VNPmvL90Q7zem1CJOfmNQqXxMz1g/Rqu/wbBd7BqMD3fepeVVi6Jo9
         QzDLZ1/WUj4db8VmI9Bj0PPbuFn04L3oaeRnn9n8=
Date:   Thu, 16 Feb 2023 16:07:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Suweifeng (Weifeng, EulerOS)" <suweifeng1@huawei.com>
Cc:     mst@redhat.com, linux-kernel@vger.kernel.org, shikemeng@huawei.com,
        liuzhiqiang26@huawei.com, linfeilong@huawei.com,
        zhanghongtao22@huawei.com
Subject: Re: [PATCH] uio:uio_pci_generic:Don't clear master bit when the
 process does not exit
Message-ID: <Y+5GrE6F++Lv4BO+@kroah.com>
References: <20230214132157.472753-1-suweifeng1@huawei.com>
 <Y+uJ6ejVNl6RoQPk@kroah.com>
 <1601ce95-5ec7-3656-cdcd-bf052cf6d222@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601ce95-5ec7-3656-cdcd-bf052cf6d222@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 10:45:02PM +0800, Suweifeng (Weifeng, EulerOS) wrote:
> On 2023/2/14 21:17, Greg KH wrote:
> > On Tue, Feb 14, 2023 at 09:21:57PM +0800, Su Weifeng wrote:
> > > From: Weifeng Su <suweifeng1@huawei.com>
> > > 
> > > The /dev/uioX device is used by multiple processes. The current behavior
> > > is to clear the master bit when a process exits. This affects other
> > > processes that use the device, resulting in command suspension and
> > > timeout. This behavior cannot be sensed by the process itself.
> > > The solution is to add the reference counting. The reference count is
> > > self-incremented and self-decremented each time when the device open and
> > > close. The master bit is cleared only when the last process exited.
> > > 
> > > Signed-off-by: Weifeng Su <suweifeng1@huawei.com>
> > > ---
> > >   drivers/uio/uio_pci_generic.c | 18 +++++++++++++++++-
> > >   1 file changed, 17 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
> > > index e03f9b532..d36d3e08e 100644
> > > --- a/drivers/uio/uio_pci_generic.c
> > > +++ b/drivers/uio/uio_pci_generic.c
> > > @@ -31,6 +31,7 @@
> > >   struct uio_pci_generic_dev {
> > >   	struct uio_info info;
> > >   	struct pci_dev *pdev;
> > > +	refcount_t  dev_refc;
> > >   };
> > >   static inline struct uio_pci_generic_dev *
> > > @@ -39,10 +40,22 @@ to_uio_pci_generic_dev(struct uio_info *info)
> > >   	return container_of(info, struct uio_pci_generic_dev, info);
> > >   }
> > > +static int open(struct uio_info *info, struct inode *inode)
> > > +{
> > > +	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
> > > +
> > > +	if (gdev)
> > > +		refcount_inc(&gdev->dev_refc);
> > 
> > This flat out does not work, sorry.
> > 
> > You should never rely on trying to count open/release calls, just let
> > the vfs layer handle that for us as it currently does so.
> > 
> > Think about what happens if you call dup() in userspace on a
> > filehandle...
> > 
> > > +	return 0;
> > > +}
> > > +
> > >   static int release(struct uio_info *info, struct inode *inode)
> > >   {
> > >   	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
> > > +	if (gdev && refcount_dec_not_one(&gdev->dev_refc))
> > 
> > I don't think you actually tested this as it is impossible for gdev to
> > ever be NULL.
> > 
> > sorry, but this patch is not correct.
> > 
> > greg k-h
> 
> First of all, thank you for taking the time to read this patch, your
> comments are very enlightening, but I do have a strange problem here, I test
> such programs on kernels 5.10 and 6.2.
> fd = open("/dev/uio0". O_RDWR);
> while (true)
> 	sleep(1);
> This program only opens the uio device. After starting multiple such
> processes, I close one of them. From the added print, it can be seen that
> the "uio_pci_generic.c:release" function is called and the master bit is
> cleared, instead of being called when the last process exits as expected. I
> think the vfs is not protected as it should be.

Did your patch change this functionality?

> Such a problem cannot be
> handled in the user-mode program. We have to clear the master bit when the
> last process exits. Otherwise, user-mode programs (for example, the DPDK
> process that uses uio_pci_generic) cannot work properly.

Look at the big comment in the release() function in this file.  Does
that explain the issues here?

Just do not open the device multiple times, you have full control over
this, right?

If not, then perhaps your hardware should not be using the
uio_pci_generic() driver but rather have a real kernel driver for it
instead if it needs to handle this type of functionality?

thanks,

greg k-h
