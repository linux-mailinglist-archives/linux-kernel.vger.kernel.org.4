Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0127620B9A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiKHI47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiKHI4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:56:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2942E69E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 00:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667897756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4yipTWvAKK59+UDaW0mZvnxyflOnwLDwk1GJZlatPJg=;
        b=CuZR7opWThqtdRZIOQ7ABJ9I837OHqlJUjwEEnGY/U6703VbTypXmJCcVCvkkbNNqA6LQd
        wca/zo0HAtS+BNKMobAdYr6ywp/dT0dpmORPzBskKQ+l9Y7Qjz+iSnFUPEVqjkfEZCw9eX
        wlBTCEEjcI2shXeO0XfTkWAcx9DcXos=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-183-yLcmH3RRNoejJ2uyvWDT-w-1; Tue, 08 Nov 2022 03:55:55 -0500
X-MC-Unique: yLcmH3RRNoejJ2uyvWDT-w-1
Received: by mail-qk1-f199.google.com with SMTP id i17-20020a05620a249100b006fa2e10a2ecso12331585qkn.16
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 00:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yipTWvAKK59+UDaW0mZvnxyflOnwLDwk1GJZlatPJg=;
        b=rINigKR0p/VIcLOX11mzipcMIzOThOo+Zta7KkoBG9bJDWDz9sJe7vPSazlaIDpNn+
         8JA6nV/iLsYP8eSFhyg9Hk2FNksFtHyKD6BrUO/phDTcCNhF4qZ9VnAT1euJni2q1KEV
         WhfZ/n9BoJmfH5lVDzYca8oetG1Ud0IGNkel5ApvlAgk77rezx3hvZJQbIDzC3aTdBYb
         4lp+uZ+MfH9XUGzcUblXfwLf2OxWdanOzIsQMHld3FwN6q0M9aKnfBFoaGV09gbZGf39
         hmRtr6ajiw3oTbGqgCKlKR8Vj16bmJxmzN30grT9nxCzBaqBKFY49BBsyBZox8rusWEl
         TMqQ==
X-Gm-Message-State: ACrzQf3lCkqdj7HKfRsUUFj9YzH5Zxd86R7Vr29cCCXQMl2A/g9fdn2E
        VLTs2jw0Owv1tSjTd2vfNWfT/H5obrteaDP6CJww4sj/KGQic92mI1CQP+2ShPjTInb39AK7IDK
        AO80iY6oWZjLFnoy9T6AAJiVI
X-Received: by 2002:a37:603:0:b0:6fa:6fa6:1019 with SMTP id 3-20020a370603000000b006fa6fa61019mr20362211qkg.27.1667897754408;
        Tue, 08 Nov 2022 00:55:54 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4sAQ/1DJwa8nDgW33KcEepaQdX8eNEfpVaNQCy6RzDEu4X9alIhMotTbpwFmqZnXU/fXpW6A==
X-Received: by 2002:a37:603:0:b0:6fa:6fa6:1019 with SMTP id 3-20020a370603000000b006fa6fa61019mr20362199qkg.27.1667897754116;
        Tue, 08 Nov 2022 00:55:54 -0800 (PST)
Received: from redhat.com ([138.199.52.3])
        by smtp.gmail.com with ESMTPSA id r16-20020ac87ef0000000b003996aa171b9sm7624944qtc.97.2022.11.08.00.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 00:55:53 -0800 (PST)
Date:   Tue, 8 Nov 2022 03:55:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com
Subject: Re: [RFC] vhost: Clear the pending messages on
 vhost_init_device_iotlb()
Message-ID: <20221108035142-mutt-send-email-mst@kernel.org>
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org>
 <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
 <20221107180022-mutt-send-email-mst@kernel.org>
 <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 11:09:36AM +0800, Jason Wang wrote:
> On Tue, Nov 8, 2022 at 7:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Nov 07, 2022 at 10:10:06PM +0100, Eric Auger wrote:
> > > Hi Michael,
> > > On 11/7/22 21:42, Michael S. Tsirkin wrote:
> > > > On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
> > > >> When the vhost iotlb is used along with a guest virtual iommu
> > > >> and the guest gets rebooted, some MISS messages may have been
> > > >> recorded just before the reboot and spuriously executed by
> > > >> the virtual iommu after the reboot. Despite the device iotlb gets
> > > >> re-initialized, the messages are not cleared. Fix that by calling
> > > >> vhost_clear_msg() at the end of vhost_init_device_iotlb().
> > > >>
> > > >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > >> ---
> > > >>  drivers/vhost/vhost.c | 1 +
> > > >>  1 file changed, 1 insertion(+)
> > > >>
> > > >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > >> index 40097826cff0..422a1fdee0ca 100644
> > > >> --- a/drivers/vhost/vhost.c
> > > >> +++ b/drivers/vhost/vhost.c
> > > >> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
> > > >>    }
> > > >>
> > > >>    vhost_iotlb_free(oiotlb);
> > > >> +  vhost_clear_msg(d);
> > > >>
> > > >>    return 0;
> > > >>  }
> > > > Hmm.  Can't messages meanwhile get processes and affect the
> > > > new iotlb?
> > > Isn't the msg processing stopped at the moment this function is called
> > > (VHOST_SET_FEATURES)?
> > >
> > > Thanks
> > >
> > > Eric
> >
> > It's pretty late here I'm not sure.  You tell me what prevents it.
> 
> So the proposed code assumes that Qemu doesn't process device IOTLB
> before VHOST_SET_FEAETURES. Consider there's no reset in the general
> vhost uAPI,  I wonder if it's better to move the clear to device code
> like VHOST_NET_SET_BACKEND. So we can clear it per vq?

Hmm this makes no sense to me. iommu sits between backend
and frontend. Tying one to another is going to backfire.

I'm thinking more along the lines of doing everything
under iotlb_lock.



> >
> > BTW vhost_init_device_iotlb gets enabled parameter but ignores
> > it, we really should drop that.
> 
> Yes.
> 
> >
> > Also, it looks like if features are set with VIRTIO_F_ACCESS_PLATFORM
> > and then cleared, iotlb is not properly cleared - bug?
> 
> Not sure, old IOTLB may still work. But for safety, we need to disable
> device IOTLB in this case.
> 
> Thanks
> 
> >
> >
> > > >
> > > >
> > > >> --
> > > >> 2.37.3
> >

