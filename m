Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5023E699954
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjBPP4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjBPP4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:56:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789494DE29
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676562912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aQJispMxLWggFGsX88pXtjW67uc7Az4OgGG+e9elAfY=;
        b=J2yL0rU1IaSxutE1pfHplwMh9NOMlygq7CwSfp/y8EPnuQ8Jjhv5fX51VUrh20RFV7SfM2
        omnUCooof537IB3ffcnh6S8cHZCwcm0QFn6BSJVCqGh5iNJMsdGoLq+fs/frNk1VvRBkAo
        wBDr5/iMi/t78RIiOI4ApswVZQEWjLw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-578-z89Nh-pIPgW7Wx4_hzyZ_Q-1; Thu, 16 Feb 2023 10:55:11 -0500
X-MC-Unique: z89Nh-pIPgW7Wx4_hzyZ_Q-1
Received: by mail-wm1-f72.google.com with SMTP id n7-20020a05600c500700b003e2165f33cbso491351wmr.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:55:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQJispMxLWggFGsX88pXtjW67uc7Az4OgGG+e9elAfY=;
        b=T/zTcZ+bXSZdJQqLoNjVfvfO6JXonM8Qfk1HxPh6zv9ZThgmWAedueQjKxxi+X20Sy
         OoLY2Xj9GBF1akjkGHyTZmOwaHSt92SKmq6XmtqXLs+lxoUz+kbrcSI0YoQD0gjRY+M+
         7YsJHi7859mpOOHGcJJHXVT0ehoOh98BViK9iTJ5zNOkVYrJ3hKj5aYvZjomIpJhbu4g
         kmkF6p6EzkrV+DbNQWaK23EKEYp/5UWGd6t0Nq5Mw6YA3yaIVYGmZvz9yMRtWMVghzxG
         HXNF7CZ66yhIxTDk0DoH685wQZn4x9UesqWJjIo3GaySvEAzN3Cxx8yY54YQcON06cdB
         7tlg==
X-Gm-Message-State: AO0yUKXGC/zczC5OCPkPUaFy8ByYSqoXXVNxw3G9UtQamstNOzesEDnp
        nFL1WOZ8cKdIdOgfwJq6I3v2HAH9Mtd2KwStPTybyjpzRL0I2sVwcEeige4e7nMszCYI+hg/YQF
        zFwBiWZI5rqC+dKr40NJ3bEH+uCkX3Q==
X-Received: by 2002:a05:600c:4fc5:b0:3d3:513c:240b with SMTP id o5-20020a05600c4fc500b003d3513c240bmr4951803wmq.7.1676562909367;
        Thu, 16 Feb 2023 07:55:09 -0800 (PST)
X-Google-Smtp-Source: AK7set8Q/HnGPzL27od+yaYtYBlLFUzyikFRTEMFw3FVUCYO/8oLv2mKITWNdcak4uzBRY+s9VIZKw==
X-Received: by 2002:a05:600c:4fc5:b0:3d3:513c:240b with SMTP id o5-20020a05600c4fc500b003d3513c240bmr4951790wmq.7.1676562909071;
        Thu, 16 Feb 2023 07:55:09 -0800 (PST)
Received: from redhat.com ([2.52.5.34])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003e20970175dsm3143978wmc.32.2023.02.16.07.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 07:55:08 -0800 (PST)
Date:   Thu, 16 Feb 2023 10:55:05 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Suweifeng (Weifeng, EulerOS)" <suweifeng1@huawei.com>,
        linux-kernel@vger.kernel.org, shikemeng@huawei.com,
        liuzhiqiang26@huawei.com, linfeilong@huawei.com,
        zhanghongtao22@huawei.com
Subject: Re: [PATCH] uio:uio_pci_generic:Don't clear master bit when the
 process does not exit
Message-ID: <20230216105435-mutt-send-email-mst@kernel.org>
References: <20230214132157.472753-1-suweifeng1@huawei.com>
 <Y+uJ6ejVNl6RoQPk@kroah.com>
 <1601ce95-5ec7-3656-cdcd-bf052cf6d222@huawei.com>
 <Y+5GrE6F++Lv4BO+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+5GrE6F++Lv4BO+@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 04:07:24PM +0100, Greg KH wrote:
> On Thu, Feb 16, 2023 at 10:45:02PM +0800, Suweifeng (Weifeng, EulerOS) wrote:
> > On 2023/2/14 21:17, Greg KH wrote:
> > > On Tue, Feb 14, 2023 at 09:21:57PM +0800, Su Weifeng wrote:
> > > > From: Weifeng Su <suweifeng1@huawei.com>
> > > > 
> > > > The /dev/uioX device is used by multiple processes. The current behavior
> > > > is to clear the master bit when a process exits. This affects other
> > > > processes that use the device, resulting in command suspension and
> > > > timeout. This behavior cannot be sensed by the process itself.
> > > > The solution is to add the reference counting. The reference count is
> > > > self-incremented and self-decremented each time when the device open and
> > > > close. The master bit is cleared only when the last process exited.
> > > > 
> > > > Signed-off-by: Weifeng Su <suweifeng1@huawei.com>
> > > > ---
> > > >   drivers/uio/uio_pci_generic.c | 18 +++++++++++++++++-
> > > >   1 file changed, 17 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
> > > > index e03f9b532..d36d3e08e 100644
> > > > --- a/drivers/uio/uio_pci_generic.c
> > > > +++ b/drivers/uio/uio_pci_generic.c
> > > > @@ -31,6 +31,7 @@
> > > >   struct uio_pci_generic_dev {
> > > >   	struct uio_info info;
> > > >   	struct pci_dev *pdev;
> > > > +	refcount_t  dev_refc;
> > > >   };
> > > >   static inline struct uio_pci_generic_dev *
> > > > @@ -39,10 +40,22 @@ to_uio_pci_generic_dev(struct uio_info *info)
> > > >   	return container_of(info, struct uio_pci_generic_dev, info);
> > > >   }
> > > > +static int open(struct uio_info *info, struct inode *inode)
> > > > +{
> > > > +	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
> > > > +
> > > > +	if (gdev)
> > > > +		refcount_inc(&gdev->dev_refc);
> > > 
> > > This flat out does not work, sorry.
> > > 
> > > You should never rely on trying to count open/release calls, just let
> > > the vfs layer handle that for us as it currently does so.
> > > 
> > > Think about what happens if you call dup() in userspace on a
> > > filehandle...
> > > 
> > > > +	return 0;
> > > > +}
> > > > +
> > > >   static int release(struct uio_info *info, struct inode *inode)
> > > >   {
> > > >   	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
> > > > +	if (gdev && refcount_dec_not_one(&gdev->dev_refc))
> > > 
> > > I don't think you actually tested this as it is impossible for gdev to
> > > ever be NULL.
> > > 
> > > sorry, but this patch is not correct.
> > > 
> > > greg k-h
> > 
> > First of all, thank you for taking the time to read this patch, your
> > comments are very enlightening, but I do have a strange problem here, I test
> > such programs on kernels 5.10 and 6.2.
> > fd = open("/dev/uio0". O_RDWR);
> > while (true)
> > 	sleep(1);
> > This program only opens the uio device. After starting multiple such
> > processes, I close one of them. From the added print, it can be seen that
> > the "uio_pci_generic.c:release" function is called and the master bit is
> > cleared, instead of being called when the last process exits as expected. I
> > think the vfs is not protected as it should be.
> 
> Did your patch change this functionality?
> 
> > Such a problem cannot be
> > handled in the user-mode program. We have to clear the master bit when the
> > last process exits. Otherwise, user-mode programs (for example, the DPDK
> > process that uses uio_pci_generic) cannot work properly.
> 
> Look at the big comment in the release() function in this file.  Does
> that explain the issues here?
> 
> Just do not open the device multiple times, you have full control over
> this, right?
> 
> If not, then perhaps your hardware should not be using the
> uio_pci_generic() driver but rather have a real kernel driver for it
> instead if it needs to handle this type of functionality?
> 
> thanks,
> 
> greg k-h


Hmm. this code did however work correctly before
865a11f987ab5f03089 ("uio/uio_pci_generic: Disable bus-mastering on release")

