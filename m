Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AE0620C45
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiKHJcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiKHJcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:32:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBF413E13
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667899901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wORuoNKSEGIHseLSvWb8U/wTDNM4BG+j707oJXZ4j9I=;
        b=Ah4ajqaE42Q56y2ekKGk1XqdjRNOyuDIcklz/dS8/K4nS8CVRaOXoASS773yOyUwJjj/N8
        M2W7+aCHd5+FvVjlcIkxsKJLYlT9jIwr/QqFMo6IFMHe48q8QrcsLkndZ0wcX3jfrYPWoj
        ZIBKtzk+FVjl6mYtxU1GITdWkHl5Jk0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-527-ebncSmbrNDOTUTRkmKD1HA-1; Tue, 08 Nov 2022 04:31:39 -0500
X-MC-Unique: ebncSmbrNDOTUTRkmKD1HA-1
Received: by mail-qk1-f198.google.com with SMTP id bl21-20020a05620a1a9500b006fa35db066aso12401579qkb.19
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 01:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wORuoNKSEGIHseLSvWb8U/wTDNM4BG+j707oJXZ4j9I=;
        b=3bysnZnOrJeIFf/i86VApfKl3AmJy9jJDy48A8z52yVmEw4WjPGJRGv8jYZnsztpgt
         Gn1mljjTHzqkJaCIp0JA4/rSXRcxrjLv/ixZzYEx6sx4Phd6s/BQbn4ObUR+V16b0irc
         BVqqmjWdirJP9CpW/3qebZFiTGtS2nEn0P3kAMrJDqna4KhUbPiq8KOQh9WwuinGeLTa
         RaXWj2Ph21SXxRyNRtkzpFS0NQQgEtxjQC/BJNVh/v3tu7nF3N878OKa+J6iLRQBiDF1
         iUc9R8XcalCdE4BlH8fB2xyVy/ay1dOd2okYN96lHgpq84eLhc+K6Dmq/MI8HLfNE9zF
         qVkg==
X-Gm-Message-State: ACrzQf0apJGNVbilM3CGFFb+li3wModJpD97Rq85WGUGKLwZVsh6HoNH
        yZLxfVsXErHwTfjhE8ELWq4jSBGuDtaPd3Z9iZoNnPFVS9t1UBNalFDdWwpLPaB5es9Je2IdMRp
        4kxgsoh89gw/W8XM3sGDOzTo/
X-Received: by 2002:ac8:4788:0:b0:3a5:6a2f:e77d with SMTP id k8-20020ac84788000000b003a56a2fe77dmr15500745qtq.562.1667899899154;
        Tue, 08 Nov 2022 01:31:39 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5r6u9VAFIEkP5ZvGS1wz6LtG1vG3jMrqncPoAa0QeUVMjh8Yu9Jeel/zWCsisC28rCmndQSA==
X-Received: by 2002:ac8:4788:0:b0:3a5:6a2f:e77d with SMTP id k8-20020ac84788000000b003a56a2fe77dmr15500734qtq.562.1667899898878;
        Tue, 08 Nov 2022 01:31:38 -0800 (PST)
Received: from redhat.com ([138.199.52.3])
        by smtp.gmail.com with ESMTPSA id o14-20020a05620a0d4e00b006eef13ef4c8sm8702771qkl.94.2022.11.08.01.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 01:31:38 -0800 (PST)
Date:   Tue, 8 Nov 2022 04:31:33 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com
Subject: Re: [RFC] vhost: Clear the pending messages on
 vhost_init_device_iotlb()
Message-ID: <20221108041820-mutt-send-email-mst@kernel.org>
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org>
 <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
 <20221107180022-mutt-send-email-mst@kernel.org>
 <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
 <20221108035142-mutt-send-email-mst@kernel.org>
 <CACGkMEtFhmgKrKwTT8MdQG26wbi20Z5cTn69ycBtE17V+Kupuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtFhmgKrKwTT8MdQG26wbi20Z5cTn69ycBtE17V+Kupuw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 05:13:50PM +0800, Jason Wang wrote:
> On Tue, Nov 8, 2022 at 4:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Nov 08, 2022 at 11:09:36AM +0800, Jason Wang wrote:
> > > On Tue, Nov 8, 2022 at 7:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Nov 07, 2022 at 10:10:06PM +0100, Eric Auger wrote:
> > > > > Hi Michael,
> > > > > On 11/7/22 21:42, Michael S. Tsirkin wrote:
> > > > > > On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
> > > > > >> When the vhost iotlb is used along with a guest virtual iommu
> > > > > >> and the guest gets rebooted, some MISS messages may have been
> > > > > >> recorded just before the reboot and spuriously executed by
> > > > > >> the virtual iommu after the reboot. Despite the device iotlb gets
> > > > > >> re-initialized, the messages are not cleared. Fix that by calling
> > > > > >> vhost_clear_msg() at the end of vhost_init_device_iotlb().
> > > > > >>
> > > > > >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > > > >> ---
> > > > > >>  drivers/vhost/vhost.c | 1 +
> > > > > >>  1 file changed, 1 insertion(+)
> > > > > >>
> > > > > >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > >> index 40097826cff0..422a1fdee0ca 100644
> > > > > >> --- a/drivers/vhost/vhost.c
> > > > > >> +++ b/drivers/vhost/vhost.c
> > > > > >> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
> > > > > >>    }
> > > > > >>
> > > > > >>    vhost_iotlb_free(oiotlb);
> > > > > >> +  vhost_clear_msg(d);
> > > > > >>
> > > > > >>    return 0;
> > > > > >>  }
> > > > > > Hmm.  Can't messages meanwhile get processes and affect the
> > > > > > new iotlb?
> > > > > Isn't the msg processing stopped at the moment this function is called
> > > > > (VHOST_SET_FEATURES)?
> > > > >
> > > > > Thanks
> > > > >
> > > > > Eric
> > > >
> > > > It's pretty late here I'm not sure.  You tell me what prevents it.
> > >
> > > So the proposed code assumes that Qemu doesn't process device IOTLB
> > > before VHOST_SET_FEAETURES. Consider there's no reset in the general
> > > vhost uAPI,  I wonder if it's better to move the clear to device code
> > > like VHOST_NET_SET_BACKEND. So we can clear it per vq?
> >
> > Hmm this makes no sense to me. iommu sits between backend
> > and frontend. Tying one to another is going to backfire.
> 
> I think we need to emulate what real devices are doing. Device should
> clear the page fault message during reset, so the driver won't read
> anything after reset. But we don't have a per device stop or reset
> message for vhost-net. That's why the VHOST_NET_SET_BACKEND came into
> my mind.

That's not a reset message. Userspace can switch backends at will.
I guess we could check when backend is set to -1.
It's a hack but might work.

> >
> > I'm thinking more along the lines of doing everything
> > under iotlb_lock.
> 
> I think the problem is we need to find a proper place to clear the
> message. So I don't get how iotlb_lock can help: the message could be
> still read from user space after the backend is set to NULL.
> 
> Thanks

Well I think the real problem is this.

vhost_net_set_features does:

        if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
                if (vhost_init_device_iotlb(&n->dev, true))
                        goto out_unlock;
        }


so we get a new iotlb each time features are set.

But features can be changes while device is running.
E.g.
	VHOST_F_LOG_ALL


Let's just say this hack of reusing feature bits for backend
was not my brightest idea :(





> >
> >
> >
> > > >
> > > > BTW vhost_init_device_iotlb gets enabled parameter but ignores
> > > > it, we really should drop that.
> > >
> > > Yes.
> > >
> > > >
> > > > Also, it looks like if features are set with VIRTIO_F_ACCESS_PLATFORM
> > > > and then cleared, iotlb is not properly cleared - bug?
> > >
> > > Not sure, old IOTLB may still work. But for safety, we need to disable
> > > device IOTLB in this case.
> > >
> > > Thanks
> > >
> > > >
> > > >
> > > > > >
> > > > > >
> > > > > >> --
> > > > > >> 2.37.3
> > > >
> >

