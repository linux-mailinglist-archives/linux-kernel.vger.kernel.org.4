Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788F76222B2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiKIDk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKIDk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:40:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C59920F75
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667965175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OcRfMGDR57T6McLNYaj9+wh/c5mo5rhH0w8+9LE63fE=;
        b=NJvGfj/68T8fEpKO1sOhRs8POzvoklK+x6xtE50tvV0x75U79wZDXQMBh/SNC1jK1gjeRI
        kJw90jwNuPLAuWPTdaISaZcaSZtrbVdev82fa0iXXtfCmw1Fjm1aMT4fw64dWNVVhldw/v
        ZifW9anWx14/AzFHlBe2C1q2ndDEC58=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-190-bERhcE3cP2-H6mQwBYh_CA-1; Tue, 08 Nov 2022 22:39:34 -0500
X-MC-Unique: bERhcE3cP2-H6mQwBYh_CA-1
Received: by mail-oo1-f70.google.com with SMTP id e10-20020a4a91ca000000b0047f7bf95662so4438884ooh.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 19:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcRfMGDR57T6McLNYaj9+wh/c5mo5rhH0w8+9LE63fE=;
        b=yjc/7mziTR1qpZ6XYwTzcCI3Uyqjfqa2R/wzq4QpTHlz8UO0zdf3aRs3titHPW0YhN
         Qdsele/2AXrjezaBR26PxTj5MgKgE/QbE2Q+FwJU4eargkf7TRQ1tST9l9dCTxgToh2j
         BoE3LQwIldwCG6LeAguPMfbkhrH7+7u6gJBExJdkN6Zpqvj2I9u3paAr5aYR89e8GFzG
         YAnnGIgh6bGlxE9oY9w7brM+uycpm1ZHd1Nr+PtRNl1NKXW3DDhLBIbBzFB+JUt7inHq
         rkdnELoD6E+okeQY2UKVDdVt7JTGo66yBfhBwk/d4Ccmyt4C3oY0PZmiIM/sqxOMNK/Y
         icAQ==
X-Gm-Message-State: ACrzQf2WWNYK8/5R0JcvVIIw/gWvL8W1OL57BUbH/BQtU0xIyFejTuLv
        ebUrqDiieG3i07bbh8E61+0FTHnB8EAYsuPiNiDxBwHiG2PADQsyv1VVHaga+HckXhHiOqNet7P
        hB1x4YfHobca9avPm3ClLhq0yQ+bUZbAxtLgC8mOk
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id t14-20020a056871054e00b0013b29b7e2e8mr43418507oal.35.1667965172168;
        Tue, 08 Nov 2022 19:39:32 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6IbP7wCQjQ/73WjHzwN93Q6Kmxzrb0cn8zveXWG8zANJYKg6GpnJHmpdmPfff7Nlsh5HW8PAE7iWVD1TlJexY=
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr43418498oal.35.1667965171959; Tue, 08
 Nov 2022 19:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org> <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
 <20221107180022-mutt-send-email-mst@kernel.org> <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
 <20221108035142-mutt-send-email-mst@kernel.org> <CACGkMEtFhmgKrKwTT8MdQG26wbi20Z5cTn69ycBtE17V+Kupuw@mail.gmail.com>
 <20221108041820-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221108041820-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 9 Nov 2022 11:39:20 +0800
Message-ID: <CACGkMEvO-Kz_m25J58KNbC7Gqa16wn7xPdh1Ts0TJLa2RbbNVA@mail.gmail.com>
Subject: Re: [RFC] vhost: Clear the pending messages on vhost_init_device_iotlb()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
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

On Tue, Nov 8, 2022 at 5:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Nov 08, 2022 at 05:13:50PM +0800, Jason Wang wrote:
> > On Tue, Nov 8, 2022 at 4:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Nov 08, 2022 at 11:09:36AM +0800, Jason Wang wrote:
> > > > On Tue, Nov 8, 2022 at 7:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Mon, Nov 07, 2022 at 10:10:06PM +0100, Eric Auger wrote:
> > > > > > Hi Michael,
> > > > > > On 11/7/22 21:42, Michael S. Tsirkin wrote:
> > > > > > > On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
> > > > > > >> When the vhost iotlb is used along with a guest virtual iommu
> > > > > > >> and the guest gets rebooted, some MISS messages may have been
> > > > > > >> recorded just before the reboot and spuriously executed by
> > > > > > >> the virtual iommu after the reboot. Despite the device iotlb gets
> > > > > > >> re-initialized, the messages are not cleared. Fix that by calling
> > > > > > >> vhost_clear_msg() at the end of vhost_init_device_iotlb().
> > > > > > >>
> > > > > > >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > > > > >> ---
> > > > > > >>  drivers/vhost/vhost.c | 1 +
> > > > > > >>  1 file changed, 1 insertion(+)
> > > > > > >>
> > > > > > >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > > >> index 40097826cff0..422a1fdee0ca 100644
> > > > > > >> --- a/drivers/vhost/vhost.c
> > > > > > >> +++ b/drivers/vhost/vhost.c
> > > > > > >> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
> > > > > > >>    }
> > > > > > >>
> > > > > > >>    vhost_iotlb_free(oiotlb);
> > > > > > >> +  vhost_clear_msg(d);
> > > > > > >>
> > > > > > >>    return 0;
> > > > > > >>  }
> > > > > > > Hmm.  Can't messages meanwhile get processes and affect the
> > > > > > > new iotlb?
> > > > > > Isn't the msg processing stopped at the moment this function is called
> > > > > > (VHOST_SET_FEATURES)?
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > Eric
> > > > >
> > > > > It's pretty late here I'm not sure.  You tell me what prevents it.
> > > >
> > > > So the proposed code assumes that Qemu doesn't process device IOTLB
> > > > before VHOST_SET_FEAETURES. Consider there's no reset in the general
> > > > vhost uAPI,  I wonder if it's better to move the clear to device code
> > > > like VHOST_NET_SET_BACKEND. So we can clear it per vq?
> > >
> > > Hmm this makes no sense to me. iommu sits between backend
> > > and frontend. Tying one to another is going to backfire.
> >
> > I think we need to emulate what real devices are doing. Device should
> > clear the page fault message during reset, so the driver won't read
> > anything after reset. But we don't have a per device stop or reset
> > message for vhost-net. That's why the VHOST_NET_SET_BACKEND came into
> > my mind.
>
> That's not a reset message. Userspace can switch backends at will.
> I guess we could check when backend is set to -1.
> It's a hack but might work.

Yes, that's what I meant actually.

>
> > >
> > > I'm thinking more along the lines of doing everything
> > > under iotlb_lock.
> >
> > I think the problem is we need to find a proper place to clear the
> > message. So I don't get how iotlb_lock can help: the message could be
> > still read from user space after the backend is set to NULL.
> >
> > Thanks
>
> Well I think the real problem is this.
>
> vhost_net_set_features does:
>
>         if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
>                 if (vhost_init_device_iotlb(&n->dev, true))
>                         goto out_unlock;
>         }
>
>
> so we get a new iotlb each time features are set.

Right, but this looks like another independent issue that needs to be fixed.

>
> But features can be changes while device is running.
> E.g.
>         VHOST_F_LOG_ALL
>
>
> Let's just say this hack of reusing feature bits for backend
> was not my brightest idea :(
>

Probably :)

Thanks

>
>
>
>
> > >
> > >
> > >
> > > > >
> > > > > BTW vhost_init_device_iotlb gets enabled parameter but ignores
> > > > > it, we really should drop that.
> > > >
> > > > Yes.
> > > >
> > > > >
> > > > > Also, it looks like if features are set with VIRTIO_F_ACCESS_PLATFORM
> > > > > and then cleared, iotlb is not properly cleared - bug?
> > > >
> > > > Not sure, old IOTLB may still work. But for safety, we need to disable
> > > > device IOTLB in this case.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > >> --
> > > > > > >> 2.37.3
> > > > >
> > >
>

