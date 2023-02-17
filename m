Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DE269A879
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjBQJnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBQJny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:43:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302FF4C07
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676626968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VY2XQL+74J0Ra+yUMavRXLtrLR76PhxatHZvzZrd7KI=;
        b=Afc2mKubh5Rg49PVRPtuatt6Qtz3OsylhncDkHaXiODKxNPWZuM+hxmrNa8Zn7lupznhYu
        Uj0u6yP2pTbTKScvQQqii/nr2zE0ICiUJjTUCujquRQjbn4cDT/7hijreljf+uQp+HEiCx
        PeifU82RniyR2rHbgd4tXdWZGuXW0tA=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-412-wOXuL0UKNv6VdgRaQtymCQ-1; Fri, 17 Feb 2023 04:42:47 -0500
X-MC-Unique: wOXuL0UKNv6VdgRaQtymCQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-17068abe37bso401456fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VY2XQL+74J0Ra+yUMavRXLtrLR76PhxatHZvzZrd7KI=;
        b=7cBAdBdZwMijvaWxcji4TuANcjpqfWTGALvZOpVi8gAHlv1EmpSTJXA1KD0g7dja9g
         9kWIrT6b9vpJoR5gH1Ub8MvwqHdfywHE8xA0SwYZRnu2Ig9HaQRXDp5sQoJJZhSRInQq
         4LIU35K9BsafW7PIb+1BkLu4DvX+VvvvHG67REGaf9zjvYRGArsPy9mdkPIqkj/d6vlD
         xlAK/2r/2ExJ374A52PaRTJfGfbItWYOyLhs21+rbyYBRYFK1plMIHVo0BDOx+5GS6xv
         KWmLvI2ardb2r8AQWKMk11Vq+x+KObCkC154eB9vtRZiQ9mieZi9hSIxya4EfemRzjGg
         /xnw==
X-Gm-Message-State: AO0yUKWtjds62AhUmjHJzfeot2BtcLMjKO27YIClezWNmHeuJkk66dT8
        NS6pX0SDWcyTs/sjVAvXkHH0KdYbAj8UNqooqFXy2YRh81HYuwa4yT/4vRCz3k5f0xxJ9802EMn
        YXXKhtX0vvyFbI2J8ioYHW8AvpqXw72gfUzIToZT/
X-Received: by 2002:a05:6870:75ce:b0:16a:1498:b7b5 with SMTP id de14-20020a05687075ce00b0016a1498b7b5mr429646oab.98.1676626966373;
        Fri, 17 Feb 2023 01:42:46 -0800 (PST)
X-Google-Smtp-Source: AK7set+8giDcB+8TnU3A4QbjkvQUCKoiDY3R+UuYZB0A183fUCxr7CIOCFhtspiHjnQ5XmUwycVZN7OsQHMBvoBlpx8=
X-Received: by 2002:a05:6870:75ce:b0:16a:1498:b7b5 with SMTP id
 de14-20020a05687075ce00b0016a1498b7b5mr429642oab.98.1676626966133; Fri, 17
 Feb 2023 01:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20230214112741.133900-1-mgamal@redhat.com> <SA1PR21MB1335435701EBB35A9DD35892BFA19@SA1PR21MB1335.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB1335435701EBB35A9DD35892BFA19@SA1PR21MB1335.namprd21.prod.outlook.com>
From:   Mohammed Gamal <mgamal@redhat.com>
Date:   Fri, 17 Feb 2023 11:42:34 +0200
Message-ID: <CAG-HVq-Knhdgwh4QCJ1U_N+bWYavguQ0axmx-TNgF+aCYoS2AA@mail.gmail.com>
Subject: Re: [PATCH v2] Drivers: vmbus: Check for channel allocation before
 looking up relids
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "xxiong@redhat.com" <xxiong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 8:25 AM Dexuan Cui <decui@microsoft.com> wrote:
>
> > From: Mohammed Gamal <mgamal@redhat.com>
> > Sent: Tuesday, February 14, 2023 3:28 AM
> > ...
> > So Make relid2channel() check if vmbus channels is allocated first, and if not
> > print a warning and return NULL to the caller.
> Can we change the above to:
>
> Print a warning and error out in relid2channel() for a channel id that's invalid
> in the second kernel.
Will do!

>
> > --- a/drivers/hv/connection.c
> > +++ b/drivers/hv/connection.c
> > @@ -409,6 +409,10 @@ void vmbus_disconnect(void)
> >   */
> >  struct vmbus_channel *relid2channel(u32 relid)
> >  {
> > +     if (vmbus_connection.channels == NULL) {
> > +             WARN(1, "Requested relid=%u, but channel mapping not
> > allocated!\n", relid);
>
> WARN() may be too noisy. I suggest we use pr_warn() instead.
>
Makes sense. Will use pr_warn() instead.

> Can we make the line a little shorter:
>         pr_warn("relid2channel: invalid channel id %u\n", relid);
>
I think this message could be a bit misleading. The problem here is
not that the relid
is invalid, but that the relid-to-channel mapping hasn't been
allocated by the second
kernel yet. An invalid relid could simply be the case where relid >=
MAX_CHANNEL_RELIDS.

May be something like:
     pr_warn("relid2channel: No channels mapped for relid %d\n, relid");
would be clearer?

