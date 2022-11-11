Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB1C625920
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiKKLLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiKKLK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:10:57 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFE3657FF;
        Fri, 11 Nov 2022 03:10:56 -0800 (PST)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N7wtX3ws6z688hK;
        Fri, 11 Nov 2022 19:08:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 12:10:53 +0100
Received: from localhost (10.45.151.252) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 11:10:53 +0000
Date:   Fri, 11 Nov 2022 11:10:49 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
CC:     Subhajit Ghosh <subhajit.ghosh@vixtechnology.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: light: apds9960: Fix iio_event_spec structures
Message-ID: <20221111111049.0000467f@Huawei.com>
In-Reply-To: <CAJCx=g=WaGiBFYJTTjNgzrnW3We0qpuMvyy9iFAVDC8Mkbscsg@mail.gmail.com>
References: <20221110101241.10576-1-subhajit.ghosh@vixtechnology.com>
        <CAJCx=g=qRd+WaCLOHwnEjg1Myg4Ng=PK0sxcGgEG9VT+VpondA@mail.gmail.com>
        <b6ac2692-3152-dfc4-5388-7986042970f0@vixtechnology.com>
        <CAJCx=g=WaGiBFYJTTjNgzrnW3We0qpuMvyy9iFAVDC8Mkbscsg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.151.252]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022 10:50:35 +0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Thu, Nov 10, 2022 at 10:45 PM Subhajit Ghosh
> <subhajit.ghosh@vixtechnology.com> wrote:
> >
> >  
> > >>                 .type = IIO_EV_TYPE_THRESH,
> > >>                 .dir = IIO_EV_DIR_RISING,
> > >> -               .mask_separate = BIT(IIO_EV_INFO_VALUE) |
> > >> -                       BIT(IIO_EV_INFO_ENABLE),
> > >> +               .mask_separate = BIT(IIO_EV_INFO_VALUE),  
> > >
> > > Probably more concise to use the following, and you won't need to add
> > > an additional item to the structs.
> > >
> > >    .mask_separate = BIT(IIO_EV_INFO_VALUE),
> > >    .mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
> > >  
> >
> > Above is the first thing I tried.
> >
> > Current implementation:
> >
> > root@stm32mp1:~# ls -1 /sys/bus/iio/devices/iio:device0/events/
> > in_intensity_clear_thresh_falling_en
> > in_intensity_clear_thresh_falling_value
> > in_intensity_clear_thresh_rising_en
> > in_intensity_clear_thresh_rising_value
> >
> > in_proximity_thresh_falling_en
> > in_proximity_thresh_falling_value
> > in_proximity_thresh_rising_en
> > in_proximity_thresh_rising_value
> >
> >
> > First method (Which you are suggesting):
> > .mask_separate = BIT(IIO_EV_INFO_VALUE),
> > .mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
> >
> > root@stm32mp1:~# ls -1 /sys/bus/iio/devices/iio:device0/events/
> > in_intensity_clear_thresh_falling_value
> > in_intensity_clear_thresh_rising_value
> > in_intensity_thresh_falling_en
> > in_intensity_thresh_rising_en
> >
> > The above says all channels with with the type IIO_INTENSITY has
> > the same enable but we require this particular channel (in_intensity_clear)
> > regardless of direction to have the same enable.
> > Using mask_shared_by_dir and mask_shared_by_all does not provide the logical
> > attribute name.
> >
> >
> > This patch provides the below:
> >
> > root@stm32mp1:~# ls -1 /sys/bus/iio/devices/iio:device0/events/
> > in_intensity_clear_thresh_either_en
> > in_intensity_clear_thresh_falling_value
> > in_intensity_clear_thresh_rising_value
> >
> > in_proximity_thresh_either_en
> > in_proximity_thresh_falling_value
> > in_proximity_thresh_rising_value
> >
> > Verified using iio_event_monitor:
> >
> > root@stm32mp1:~# ./iio_event_monitor /dev/iio:device0
> > Event: time: 1647143384807582753, type: proximity, channel: 0, evtype: thresh, direction: either
> >  
> 
> Hmm maybe Jonathan will have some feedback on this (and if it is okay
> to break the ABI interface). Been awhile since I've touched
> this driver and a little rusty on iio events.  But I am guessing your
> method makes sense since the event(s) has direction and a type, and
> can't just have one of the .mask_shared_by_dir and mask_shared_by_type.
> 
> In any case:
> 
> Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

Hmm.  Given that event enables often cover a couple of different things
(as done here) it isn't unknown for those to not be as easily covered
as you have done.  As such, we have drivers were the ABI allows for
enabling one event to end up enabling several others (even though they
have separate enable attributes).  It's always been permitted for one
IIO attribute write to have an effect on other attributes simply because
we can't represent all dependencies.

Now the bigger complexity / surprise here is the return of the either
direction in response to enabling either rising or falling. 
That is going to rather surprise your average writer of userspace code.

So patch covers what we should definitely have had in the first place.
Hence it's a question of risk of someone running code that will be affected
by the ABI change.  One of those fingers crossed moments...

Jonathan

> 
> 
> - Matt
> 
> >
> > Regards
> > Subhajit Ghosh
> >
> > --
> > This email is confidential. If you have received this email in error please
> > notify us immediately by return email and delete this email and any
> > attachments. Vix accepts no liability for any damage caused by this email
> > or any attachments due to viruses, interference, interception, corruption
> > or unauthorised access.  

