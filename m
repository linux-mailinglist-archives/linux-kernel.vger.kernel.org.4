Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0AA620752
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiKHDKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiKHDKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:10:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE39233A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 19:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667876990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YRtjwtaorg58e8Zp57TXoIs8WKp2QJ/obFRTRLN8svw=;
        b=dkBVn2KdndVRk+OwdLlNAgzF5+FCcp178sXnDCGbA58IsAl5QEMEg2Lag98gjd3ojjkwNc
        l6sZ+pK3ubsi2wgbqRAaXMYVI5TkWZh2iifOs3Ou4Sfnyq7OrFsLQHmQ6Suv2EwS82qn9B
        Mg7WHABkcWm1/8r45T+nZ5Iqct0JDV0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-3Pf7KWghOL-c2ET1a4ZVcg-1; Mon, 07 Nov 2022 22:09:49 -0500
X-MC-Unique: 3Pf7KWghOL-c2ET1a4ZVcg-1
Received: by mail-oo1-f72.google.com with SMTP id b25-20020a4a9bd9000000b0047679132f18so3361717ook.21
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 19:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRtjwtaorg58e8Zp57TXoIs8WKp2QJ/obFRTRLN8svw=;
        b=EqqcRUPDf155O92J/r9l+D9TPlBPO77j6V6j5JUfSQloK+SokeQGhzuKUH9ad8DF1P
         xRmAbzL/7lYLas0vM1GU+pUeB3aleb5ckMB8Y4kwUrXzYL95hEIyJqKM0k2zH5Rwynz1
         RXUeZ7no0No988huJSdx3IrzBTvK9cN13SkgEMfVtpnndPsgtQj0VoxOg1wVtU2gZcPl
         2wkd6NzFl4Pi6K4/Igh9C8ViP00dUOAGA35TA5nQd1/m62M6mr60nFIB5b7Q2GTOVRRK
         QVWbHfwyio6dN19zNgTRUf86qeeeZHyc8JSaafILsctho7EpLO9xR9I9zFV0QCUvE6iA
         cX+Q==
X-Gm-Message-State: ACrzQf3j37pCcPEI+zd8aEGiaaDJ4mGw2Mvi9X42Z7JztTFFrFNhyAvU
        wg9CV9e9Y+zc6uWSGJWv4ZV1cbmKUGjwNRMxqOK4x46pyyP5wwGf4vxsAZYoJOzc/ZLfnH4x/7M
        Q0bbnLHf52cVVUxgn0D9I9TJftYJoYF4WntJsQcbS
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id bh30-20020a056808181e00b0035a59595909mr12052283oib.35.1667876988556;
        Mon, 07 Nov 2022 19:09:48 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6BPJN6+RWLjuJmH1wJzS9NwxgnfXhSRGMuXsqjkcXwG8HMP9YZ06ug0yaAFlWBN/rcTRqzjG9mlnOGGsXVDR8=
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id
 bh30-20020a056808181e00b0035a59595909mr12052272oib.35.1667876988328; Mon, 07
 Nov 2022 19:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org> <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
 <20221107180022-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221107180022-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 8 Nov 2022 11:09:36 +0800
Message-ID: <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
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

On Tue, Nov 8, 2022 at 7:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Nov 07, 2022 at 10:10:06PM +0100, Eric Auger wrote:
> > Hi Michael,
> > On 11/7/22 21:42, Michael S. Tsirkin wrote:
> > > On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
> > >> When the vhost iotlb is used along with a guest virtual iommu
> > >> and the guest gets rebooted, some MISS messages may have been
> > >> recorded just before the reboot and spuriously executed by
> > >> the virtual iommu after the reboot. Despite the device iotlb gets
> > >> re-initialized, the messages are not cleared. Fix that by calling
> > >> vhost_clear_msg() at the end of vhost_init_device_iotlb().
> > >>
> > >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > >> ---
> > >>  drivers/vhost/vhost.c | 1 +
> > >>  1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > >> index 40097826cff0..422a1fdee0ca 100644
> > >> --- a/drivers/vhost/vhost.c
> > >> +++ b/drivers/vhost/vhost.c
> > >> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
> > >>    }
> > >>
> > >>    vhost_iotlb_free(oiotlb);
> > >> +  vhost_clear_msg(d);
> > >>
> > >>    return 0;
> > >>  }
> > > Hmm.  Can't messages meanwhile get processes and affect the
> > > new iotlb?
> > Isn't the msg processing stopped at the moment this function is called
> > (VHOST_SET_FEATURES)?
> >
> > Thanks
> >
> > Eric
>
> It's pretty late here I'm not sure.  You tell me what prevents it.

So the proposed code assumes that Qemu doesn't process device IOTLB
before VHOST_SET_FEAETURES. Consider there's no reset in the general
vhost uAPI,  I wonder if it's better to move the clear to device code
like VHOST_NET_SET_BACKEND. So we can clear it per vq?

>
> BTW vhost_init_device_iotlb gets enabled parameter but ignores
> it, we really should drop that.

Yes.

>
> Also, it looks like if features are set with VIRTIO_F_ACCESS_PLATFORM
> and then cleared, iotlb is not properly cleared - bug?

Not sure, old IOTLB may still work. But for safety, we need to disable
device IOTLB in this case.

Thanks

>
>
> > >
> > >
> > >> --
> > >> 2.37.3
>

