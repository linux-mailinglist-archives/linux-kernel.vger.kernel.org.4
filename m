Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B546DD310
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjDKGmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDKGme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:42:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42919100
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681195307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cir0Gnf4lO73dXx+ll4SEClofyoM/9KDMaw0DZ/d7mE=;
        b=QofxRbIKtfkK0IvPhnN8SbaabNav8SvxLeJPyKtvwN+ZIKHbPQDdDsN1BJ44d4GcsA61lV
        bQIKET7pvCJjUAxcl5Ma4ISuQ93rjN0PR/svvFi5gbkF9yUnNJKiRymG63MfNLUucCS38N
        Aql/UGYHCAwI/JZS9gheQD1DBDQs68w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-dpZ8XSXjO7OC5ATSzkD0ow-1; Tue, 11 Apr 2023 02:41:46 -0400
X-MC-Unique: dpZ8XSXjO7OC5ATSzkD0ow-1
Received: by mail-wm1-f69.google.com with SMTP id t8-20020a05600c450800b003ee6dbceb81so1336114wmo.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681195305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cir0Gnf4lO73dXx+ll4SEClofyoM/9KDMaw0DZ/d7mE=;
        b=yliPnemgQUO5T/xEk91uj9CSqz7X+hZZUoKV8JisTVMCN7by0nfHqe5XqTb8xYWt7f
         f3cpphN87oV+UUDQlf3FPc+HH8ee2ZHbegUhbIOicxTILQN+wQh5eGRmvWwxRAKV8Kde
         PqglO6i42+wadltCFcxRTr0Q6dsvci0dDKtO2roOG5d6nQCTuVij/d+s9AWjLAM4dDb/
         vbU6LtEiQuDTdqqqb1vQRsbd2rAuxx8jCoSnBrgvVRtyNeYYOulo5aWJggYsJU3LqMxo
         H9jtKy4LU8FTIMnDoujMTD9ZE4Ix9ObYNWxaAD8lMPzVmc01KGVK1L2khfnXqTjntLtP
         SpaA==
X-Gm-Message-State: AAQBX9fLwe99ou1iDZGk5IZt9fNP6xLqcZXV9OrIQJZXHTYUXCuDgOap
        Is5xnUR2FaoqgPKojlj0vbD6BJWVJB8OC1CCam/imweDZAojkG/PT5+fcxThizTyenSrpLt2ydS
        HZ1PBrm3A+7oshiEPUZi1eT+p
X-Received: by 2002:a5d:4b43:0:b0:2ef:b051:95c5 with SMTP id w3-20020a5d4b43000000b002efb05195c5mr6596130wrs.60.1681195305250;
        Mon, 10 Apr 2023 23:41:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350aDk+askyEP9RLvZG0DjWMCmGyHnqPWpVQgma3u2M6tHEB57yytv6JeU13SIHx3VDd2TjQTtg==
X-Received: by 2002:a5d:4b43:0:b0:2ef:b051:95c5 with SMTP id w3-20020a5d4b43000000b002efb05195c5mr6596114wrs.60.1681195304960;
        Mon, 10 Apr 2023 23:41:44 -0700 (PDT)
Received: from redhat.com ([2.52.10.80])
        by smtp.gmail.com with ESMTPSA id w9-20020adfec49000000b002cde25fba30sm13785542wrn.1.2023.04.10.23.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 23:41:44 -0700 (PDT)
Date:   Tue, 11 Apr 2023 02:41:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
Message-ID: <20230411024109-mutt-send-email-mst@kernel.org>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <20230411022329-mutt-send-email-mst@kernel.org>
 <TY2PR06MB34242144FB4F944DD866567B859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR06MB34242144FB4F944DD866567B859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 06:39:16AM +0000, Angus Chen wrote:
> Hi mst.
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, April 11, 2023 2:30 PM
> > To: Angus Chen <angus.chen@jaguarmicro.com>
> > Cc: jasowang@redhat.com; virtualization@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
> > 
> > On Tue, Apr 11, 2023 at 09:38:32AM +0800, Angus Chen wrote:
> > > We read the status of device after reset,
> > > It is not guaranteed that the device be reseted successfully.
> > 
> > Sorry not guaranteed by what? I am guessing you have a legacy device
> > that does not reset fully on write, and you need to wait?
>  When the card not finished reset, the read only return the middle state of card.
> > 
> > > We can use a while loop to make sure that,like the modern device did.
> > > The spec is not request it ,but it work.
> > >
> > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > 
> > Generally I don't much like touching legacy, no telling what
> > that will do. Case in point, is your device a pure
> > legacy device or a transitional device?
>  Yes.,we have a real card which is use vitio spec.

So is it a transitional device?


>  Thank you.
> > 
> > > ---
> > >  drivers/virtio/virtio_pci_legacy.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> > > index 2257f1b3d8ae..f2d241563e4f 100644
> > > --- a/drivers/virtio/virtio_pci_legacy.c
> > > +++ b/drivers/virtio/virtio_pci_legacy.c
> > > @@ -14,6 +14,7 @@
> > >   *  Michael S. Tsirkin <mst@redhat.com>
> > >   */
> > >
> > > +#include <linux/delay.h>
> > >  #include "linux/virtio_pci_legacy.h"
> > >  #include "virtio_pci_common.h"
> > >
> > > @@ -97,7 +98,8 @@ static void vp_reset(struct virtio_device *vdev)
> > >  	vp_legacy_set_status(&vp_dev->ldev, 0);
> > >  	/* Flush out the status write, and flush in device writes,
> > >  	 * including MSi-X interrupts, if any. */
> > > -	vp_legacy_get_status(&vp_dev->ldev);
> > > +	while (vp_legacy_get_status(&vp_dev->ldev))
> > > +		msleep(1);
> > 
> > The problem with this is that it will break surprise
> > removal even worse than it's already broken.
> > 
> > 
> > >  	/* Flush pending VQ/configuration callbacks. */
> > >  	vp_synchronize_vectors(vdev);
> > >  }
> > > --
> > > 2.25.1
> 

