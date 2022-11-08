Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00182620BDF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiKHJPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbiKHJPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:15:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C428327DD1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667898844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V76xZRdJF90cto+eNTfmdr62lIvdE2c1NcFAYSKdle4=;
        b=M+Wrl7VnA3XfGnJi9Ob7CZxtP1KHuJHGsNEFTiKi6GM4mYOCPhWdLcTcKHJ75aF+oVhGBh
        AcQ60aDcYJW+V1mM5EkrIOaEyBf+rwNVrV8PtYX8bSzrO8EEjarkwayo5aWkBoNaSpmu4P
        HmaypbOycwqohhFx1wcfjyrvl3xoPiQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-26-LDM0JV4TN9eB0s2ry5ptjA-1; Tue, 08 Nov 2022 04:14:02 -0500
X-MC-Unique: LDM0JV4TN9eB0s2ry5ptjA-1
Received: by mail-oo1-f71.google.com with SMTP id x6-20020a4a2a46000000b0049ca27b1507so3487530oox.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 01:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V76xZRdJF90cto+eNTfmdr62lIvdE2c1NcFAYSKdle4=;
        b=yw3zJYLMnkyFx47bjL3586pJI6YSMyiZmltVJ5um/TPxCXo3KoDfryQUvYI25APex1
         T8T2Ns3W/inNpILrnVc7tksYn6VcgiYWx85NOgSVWLxRTDt3KwwFNc2qkg/i+qCHaERo
         2T7du1HSffclX6pOZfC2iajqGzwlXLS4zzymDAn2vZ/rF3+Vz3TyXtw6oEQbENQ3lfHg
         zapFp9k+QQ18AYiNQA6L1A4ayu+li3WjgRr+VKDeNeVvG3v5CItAqGjgU46z5RWfGQWo
         A0fohWyOjaKSMd09zjylnBEvVopOjUNdjvgeFmDUGEZFBcHLXGbXDRxulS+lsZ+mVxQt
         IQEQ==
X-Gm-Message-State: ACrzQf2kLCO/mSHlJr+RpT/VAGW9sWqgbVSEu8HW5HSmx/ria7Yc9xQL
        sD5rQX7h6MdC+kqmD8bW28O3bny45t4xNbagkTiR3qFDD7S6i72Bz4K7m8P+9YRe7huJmMP0kyc
        4+mcVQfqdwa4bNW54ms6uY2MwYA+eks6ZK91HbfOz
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id bh30-20020a056808181e00b0035a59595909mr12605627oib.35.1667898842133;
        Tue, 08 Nov 2022 01:14:02 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4BhHQXBK0rCa4T6dbx0EVI/Ylq8zyZOMDMURFlkMUxZJxMkfdr0MI6/RWsCNdB4MxuJjGKjU+X+8yWsgsh5K0=
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id
 bh30-20020a056808181e00b0035a59595909mr12605616oib.35.1667898841877; Tue, 08
 Nov 2022 01:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org> <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
 <20221107180022-mutt-send-email-mst@kernel.org> <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
 <20221108035142-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221108035142-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 8 Nov 2022 17:13:50 +0800
Message-ID: <CACGkMEtFhmgKrKwTT8MdQG26wbi20Z5cTn69ycBtE17V+Kupuw@mail.gmail.com>
Subject: Re: [RFC] vhost: Clear the pending messages on vhost_init_device_iotlb()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com
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

On Tue, Nov 8, 2022 at 4:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Nov 08, 2022 at 11:09:36AM +0800, Jason Wang wrote:
> > On Tue, Nov 8, 2022 at 7:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Nov 07, 2022 at 10:10:06PM +0100, Eric Auger wrote:
> > > > Hi Michael,
> > > > On 11/7/22 21:42, Michael S. Tsirkin wrote:
> > > > > On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
> > > > >> When the vhost iotlb is used along with a guest virtual iommu
> > > > >> and the guest gets rebooted, some MISS messages may have been
> > > > >> recorded just before the reboot and spuriously executed by
> > > > >> the virtual iommu after the reboot. Despite the device iotlb gets
> > > > >> re-initialized, the messages are not cleared. Fix that by calling
> > > > >> vhost_clear_msg() at the end of vhost_init_device_iotlb().
> > > > >>
> > > > >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > > >> ---
> > > > >>  drivers/vhost/vhost.c | 1 +
> > > > >>  1 file changed, 1 insertion(+)
> > > > >>
> > > > >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > >> index 40097826cff0..422a1fdee0ca 100644
> > > > >> --- a/drivers/vhost/vhost.c
> > > > >> +++ b/drivers/vhost/vhost.c
> > > > >> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
> > > > >>    }
> > > > >>
> > > > >>    vhost_iotlb_free(oiotlb);
> > > > >> +  vhost_clear_msg(d);
> > > > >>
> > > > >>    return 0;
> > > > >>  }
> > > > > Hmm.  Can't messages meanwhile get processes and affect the
> > > > > new iotlb?
> > > > Isn't the msg processing stopped at the moment this function is called
> > > > (VHOST_SET_FEATURES)?
> > > >
> > > > Thanks
> > > >
> > > > Eric
> > >
> > > It's pretty late here I'm not sure.  You tell me what prevents it.
> >
> > So the proposed code assumes that Qemu doesn't process device IOTLB
> > before VHOST_SET_FEAETURES. Consider there's no reset in the general
> > vhost uAPI,  I wonder if it's better to move the clear to device code
> > like VHOST_NET_SET_BACKEND. So we can clear it per vq?
>
> Hmm this makes no sense to me. iommu sits between backend
> and frontend. Tying one to another is going to backfire.

I think we need to emulate what real devices are doing. Device should
clear the page fault message during reset, so the driver won't read
anything after reset. But we don't have a per device stop or reset
message for vhost-net. That's why the VHOST_NET_SET_BACKEND came into
my mind.

>
> I'm thinking more along the lines of doing everything
> under iotlb_lock.

I think the problem is we need to find a proper place to clear the
message. So I don't get how iotlb_lock can help: the message could be
still read from user space after the backend is set to NULL.

Thanks

>
>
>
> > >
> > > BTW vhost_init_device_iotlb gets enabled parameter but ignores
> > > it, we really should drop that.
> >
> > Yes.
> >
> > >
> > > Also, it looks like if features are set with VIRTIO_F_ACCESS_PLATFORM
> > > and then cleared, iotlb is not properly cleared - bug?
> >
> > Not sure, old IOTLB may still work. But for safety, we need to disable
> > device IOTLB in this case.
> >
> > Thanks
> >
> > >
> > >
> > > > >
> > > > >
> > > > >> --
> > > > >> 2.37.3
> > >
>

