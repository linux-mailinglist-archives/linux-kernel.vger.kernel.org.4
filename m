Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108296369DE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbiKWT0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbiKWTZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:25:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6BB7819C;
        Wed, 23 Nov 2022 11:25:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30EAFB82449;
        Wed, 23 Nov 2022 19:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B189C433D6;
        Wed, 23 Nov 2022 19:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669231556;
        bh=ZeVSW+ifrT0umNWkh6DjnXkC3E2D1rhSRIgT3S+8KK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRlIjb9FmwcHaugpvh9e2plbxSjpYyGA+JfHE55vRI7nLXfkTAVkuvR6sx2+pBuOL
         MFI0dzW5VBTh4Lfi0eq+2QoT+DDtOnXQccP0GkytesG6uiaxZRDtHxZDdLOYaA8w14
         I0tiHeGoU9ZBbbQBOnxviCW/od9/AqAQVehxFu0c=
Date:   Wed, 23 Nov 2022 20:25:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powercap: fix possible name leak while device_register()
 fails
Message-ID: <Y35zwffl7bUdjs93@kroah.com>
References: <20221112094048.3614365-1-yangyingliang@huawei.com>
 <CAJZ5v0g6bct5pTruxHjjJPQpwDNR8WgqhLWaZWo8NKeRH3n6iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g6bct5pTruxHjjJPQpwDNR8WgqhLWaZWo8NKeRH3n6iw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 08:00:14PM +0100, Rafael J. Wysocki wrote:
> On Sat, Nov 12, 2022 at 10:42 AM Yang Yingliang
> <yangyingliang@huawei.com> wrote:
> >
> > If device_register() returns error, the name allocated by
> > dev_set_name() need be freed. In technical, we should call
> > put_device() to give up the reference and free the name in
> > driver core, but in some cases the device is not intizalized,
> > put_device() can not be called, so don't complicate the code,
> > just call kfree_const() to free name in the error path.
> >
> > Fixes: 75d2364ea0ca ("PowerCap: Add class driver")
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> >  drivers/powercap/powercap_sys.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
> > index f0654a932b37..11e742dc83b9 100644
> > --- a/drivers/powercap/powercap_sys.c
> > +++ b/drivers/powercap/powercap_sys.c
> > @@ -572,6 +572,7 @@ struct powercap_zone *powercap_register_zone(
> >  err_name_alloc:
> >         idr_remove(power_zone->parent_idr, power_zone->id);
> >  err_idr_alloc:
> > +       kfree_const(dev_name(&power_zone->dev));
> >         if (power_zone->allocated)
> >                 kfree(power_zone);
> >         mutex_unlock(&control_type->lock);
> > @@ -622,6 +623,7 @@ struct powercap_control_type *powercap_register_control_type(
> >         dev_set_name(&control_type->dev, "%s", name);
> >         result = device_register(&control_type->dev);
> >         if (result) {
> > +               kfree_const(dev_name(&control_type->dev));
> 
> Why is it necessary to free a device name explicitly after a failing
> device_register()?
> 
> If it is really necessary, then there is a problem in
> device_register() itself AFAICS, because it uses dev_set_name() at
> least in the dev->init_name present case.

I think we already fixed this in the driver core, so these types of
patches should not be applied.

Yang, can you make sure you respond to all of them and say "this is not
needed anymore!" and if any got merged, send reverts for them?

thanks,

greg k-h
