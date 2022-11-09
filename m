Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FBB6222BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKIDpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiKIDpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:45:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515A35FD8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667965457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1SzpVeGFSvJuoKb2g3I84q9t3Q2PU0091JEzT9e1Qh0=;
        b=O/cJ9AJ8YRmr61PfwAIUGfqM8Jq2jek/yQ9L6jtceCFPeF+mVU0wLQHwN90N3Z2gZoybsw
        wCELnpJVgJZaLk84uwFuV1UqTJbIqrzuI/Jvt4Y3cPxCNi+0hkFghboU0Pgz6YbpxWmTOf
        d4kBk74KDvXzyqSlKLGGopjUQglRrWQ=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-2IcuGbmSPFakY3919nGpgg-1; Tue, 08 Nov 2022 22:44:16 -0500
X-MC-Unique: 2IcuGbmSPFakY3919nGpgg-1
Received: by mail-oo1-f72.google.com with SMTP id b25-20020a4a9bd9000000b0047679132f18so4534265ook.21
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 19:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SzpVeGFSvJuoKb2g3I84q9t3Q2PU0091JEzT9e1Qh0=;
        b=absk0NG38zPNCt4Bona10H7eV4aAuvA7g33YdyJH0gLM1dd8EHJpj9Ct/hQYDyGPNr
         N2fQZM4Dgcdwwieg0vxkeAjYGNnvnc5+3p8Sz7wdW73BG2Q8Y/Y9ohIkpETKtcaTkmBt
         wOnLDFVXuBiUTWl3+GuiZMJ15PgU3/D+rozFJggL2e+cLAh/XW/m5Sl+MQadj4VV59JN
         EtereM1WaFNizTnjxfQvgx07buj53eGs/YKtpmebi0JRBdeewwdhnPrjQRLeu39N3y84
         HIg7Tk1/hSCc9fP6owgm8mh5O6BMPsV9m1mL9W8tBFLqwCKLv6e3KfhvPU9QnLEw33v2
         9yWQ==
X-Gm-Message-State: ACrzQf1e14yl+GmkyJd17ulUCBMO2FCRO5asUWdUa0LrKKMXwWin2pYx
        Z1ap072ni2sKz93Cw4mXRD4bgvBNpFYFbyiKzpSOPGdmym2p2N73GZ/FqPyfvYDJSjsrLUgHTmF
        tdsBZ6UDXm/9vRATUzzJI+iODhTNfqkhC6VkFDlGE
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id bh30-20020a056808181e00b0035a59595909mr14803967oib.35.1667965455533;
        Tue, 08 Nov 2022 19:44:15 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6706UrLNwyKe2vttKVh1ZtOJWzRUIuzEBoQnK1DCHM6gi/phgLdZny/rAkO0ET6NpmVgPN9DannOh8BBXGems=
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id
 bh30-20020a056808181e00b0035a59595909mr14803953oib.35.1667965455277; Tue, 08
 Nov 2022 19:44:15 -0800 (PST)
MIME-Version: 1.0
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org> <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
 <20221107180022-mutt-send-email-mst@kernel.org> <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
 <20221108035142-mutt-send-email-mst@kernel.org> <CACGkMEtFhmgKrKwTT8MdQG26wbi20Z5cTn69ycBtE17V+Kupuw@mail.gmail.com>
 <20221108041820-mutt-send-email-mst@kernel.org> <7105abc8-85d1-63a4-7f77-a2b3e0177b6f@redhat.com>
In-Reply-To: <7105abc8-85d1-63a4-7f77-a2b3e0177b6f@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 9 Nov 2022 11:44:03 +0800
Message-ID: <CACGkMEuX-_+fce_rmc-DsBEfa84d1Kxxe2tE_REae2_JrqBWjw@mail.gmail.com>
Subject: Re: [RFC] vhost: Clear the pending messages on vhost_init_device_iotlb()
To:     eric.auger@redhat.com
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, eric.auger.pro@gmail.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 6:17 PM Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Michael, Jason,
>
> On 11/8/22 10:31, Michael S. Tsirkin wrote:
> > On Tue, Nov 08, 2022 at 05:13:50PM +0800, Jason Wang wrote:
> >> On Tue, Nov 8, 2022 at 4:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>> On Tue, Nov 08, 2022 at 11:09:36AM +0800, Jason Wang wrote:
> >>>> On Tue, Nov 8, 2022 at 7:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>>>> On Mon, Nov 07, 2022 at 10:10:06PM +0100, Eric Auger wrote:
> >>>>>> Hi Michael,
> >>>>>> On 11/7/22 21:42, Michael S. Tsirkin wrote:
> >>>>>>> On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
> >>>>>>>> When the vhost iotlb is used along with a guest virtual iommu
> >>>>>>>> and the guest gets rebooted, some MISS messages may have been
> >>>>>>>> recorded just before the reboot and spuriously executed by
> >>>>>>>> the virtual iommu after the reboot. Despite the device iotlb gets
> >>>>>>>> re-initialized, the messages are not cleared. Fix that by calling
> >>>>>>>> vhost_clear_msg() at the end of vhost_init_device_iotlb().
> >>>>>>>>
> >>>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>>>>>> ---
> >>>>>>>>  drivers/vhost/vhost.c | 1 +
> >>>>>>>>  1 file changed, 1 insertion(+)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >>>>>>>> index 40097826cff0..422a1fdee0ca 100644
> >>>>>>>> --- a/drivers/vhost/vhost.c
> >>>>>>>> +++ b/drivers/vhost/vhost.c
> >>>>>>>> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
> >>>>>>>>    }
> >>>>>>>>
> >>>>>>>>    vhost_iotlb_free(oiotlb);
> >>>>>>>> +  vhost_clear_msg(d);
> >>>>>>>>
> >>>>>>>>    return 0;
> >>>>>>>>  }
> >>>>>>> Hmm.  Can't messages meanwhile get processes and affect the
> >>>>>>> new iotlb?
> >>>>>> Isn't the msg processing stopped at the moment this function is called
> >>>>>> (VHOST_SET_FEATURES)?
> >>>>>>
> >>>>>> Thanks
> >>>>>>
> >>>>>> Eric
> >>>>> It's pretty late here I'm not sure.  You tell me what prevents it.
> >>>> So the proposed code assumes that Qemu doesn't process device IOTLB
> >>>> before VHOST_SET_FEAETURES. Consider there's no reset in the general
> >>>> vhost uAPI,  I wonder if it's better to move the clear to device code
> >>>> like VHOST_NET_SET_BACKEND. So we can clear it per vq?
> >>> Hmm this makes no sense to me. iommu sits between backend
> >>> and frontend. Tying one to another is going to backfire.
> >> I think we need to emulate what real devices are doing. Device should
> >> clear the page fault message during reset, so the driver won't read
> >> anything after reset. But we don't have a per device stop or reset
> >> message for vhost-net. That's why the VHOST_NET_SET_BACKEND came into
> >> my mind.
> > That's not a reset message. Userspace can switch backends at will.
> > I guess we could check when backend is set to -1.
> > It's a hack but might work.
> >
> >>> I'm thinking more along the lines of doing everything
> >>> under iotlb_lock.
> >> I think the problem is we need to find a proper place to clear the
> >> message. So I don't get how iotlb_lock can help: the message could be
> >> still read from user space after the backend is set to NULL.
> >>
> >> Thanks
> > Well I think the real problem is this.
> >
> > vhost_net_set_features does:
> >
> >         if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> >                 if (vhost_init_device_iotlb(&n->dev, true))
> >                         goto out_unlock;
> >         }
> >
> >
> > so we get a new iotlb each time features are set.
> >
> > But features can be changes while device is running.
> > E.g.
> >       VHOST_F_LOG_ALL
> >
> >
> > Let's just say this hack of reusing feature bits for backend
> > was not my brightest idea :(
> >
>
> Isn't vhost_init_device_iotlb() racy then, as d->iotlb is first updated with niotlb and later d->vqs[i]->iotlb is updated with niotlb. What does garantee this is done atomically?
>
> Shouldn't we hold the dev->mutex to make all the sequence atomic and
> include vhost_clear_msg()?  Can't the vhost_clear_msg() take the dev lock?

It depends on where we want to place the vhost_clear_msg(), e.g in
most of the device ioctl, the dev->mutex has been held.

Thanks

>
> Thanks
>
> Eric
>
> >
> >
> >
> >>>
> >>>
> >>>>> BTW vhost_init_device_iotlb gets enabled parameter but ignores
> >>>>> it, we really should drop that.
> >>>> Yes.
> >>>>
> >>>>> Also, it looks like if features are set with VIRTIO_F_ACCESS_PLATFORM
> >>>>> and then cleared, iotlb is not properly cleared - bug?
> >>>> Not sure, old IOTLB may still work. But for safety, we need to disable
> >>>> device IOTLB in this case.
> >>>>
> >>>> Thanks
> >>>>
> >>>>>
> >>>>>>>
> >>>>>>>> --
> >>>>>>>> 2.37.3
>

