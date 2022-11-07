Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D82E62034B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiKGXHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiKGXHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:07:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEB926AED
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667862370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ql3/+AzyhVuxEaK0XBBzJjHyQy15pEZbdDGEtiC6+IA=;
        b=C4ohJ9JWxYbVrYt67x/MInFVnr3eIbjXThHuBMN/62KXenkSM/mi138EPjpNTZDGcA/I2T
        LnuL4CDu2s8H0EGZCoBd9T7WInFdYJOi5SoBkECDw4CIwR4v8x6K5lL4Q1IzLqAi/5YRqZ
        07y56Wp0U0sctVcGibUgQVT2KJFw26w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-113-ImXuPnx0O1GeXPE5p6igBA-1; Mon, 07 Nov 2022 18:06:09 -0500
X-MC-Unique: ImXuPnx0O1GeXPE5p6igBA-1
Received: by mail-qv1-f72.google.com with SMTP id mb6-20020a056214550600b004bc0f14f7b2so8527858qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 15:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ql3/+AzyhVuxEaK0XBBzJjHyQy15pEZbdDGEtiC6+IA=;
        b=XyWAjKqUGgaPpDbG3zE2bvOVeMQoFsezd51dBMfO1o6nH7clv1Hi6BzTFLPBxe10jg
         8jElfgaLuYVApK/9lGXW78M+hC1Rux4Om5lXw2YFfC4lu+rbQ9qtesy4ZRHHC6rpPigt
         OoqyEtGKaQ46tqixWxR57jcwhyup3ZGocSzJiUX3IP05OfIzor6xIH3A8ajURipKfhDh
         LZ8MC4gvFFZ0ol0SLoT76dQjBAe1gpt4GHUDVEs0B+j0Mt6cl/5hd9R0ETnn4Om3fEOy
         7MydmpQpx43uf7xyQhNRJLvD+Hc8oqgyNNNDACTwZYo6IUTzXLjNQ8b7sHoCLiPCGQuG
         nSZw==
X-Gm-Message-State: ACrzQf0N3h2b2KEXXIXC9Oi6+RR0KxTjIcrKOTY6xxnj2VdWPS1TSwtl
        duDuKnbKILNf8d3lMasC+IUnf1dCc3pZP+BAZjGNPHB75tMq4gc8nRiKI2tLdHiE48Itq9FtbZc
        FbZRj6+S/X/5hMs2tgI4vH+Kt
X-Received: by 2002:ae9:e111:0:b0:6fa:1ea0:69e1 with SMTP id g17-20020ae9e111000000b006fa1ea069e1mr34568764qkm.370.1667862368961;
        Mon, 07 Nov 2022 15:06:08 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7mmkvNGzkIVQsl0WH5rThaFl+Pp3Ew/JlRdT6tjQRoUw9VLkIT++tsBdx42M1W6auzIeyiWg==
X-Received: by 2002:ae9:e111:0:b0:6fa:1ea0:69e1 with SMTP id g17-20020ae9e111000000b006fa1ea069e1mr34568749qkm.370.1667862368734;
        Mon, 07 Nov 2022 15:06:08 -0800 (PST)
Received: from redhat.com ([87.249.138.11])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006fab68c7e87sm1387980qkh.70.2022.11.07.15.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:06:08 -0800 (PST)
Date:   Mon, 7 Nov 2022 18:06:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com
Subject: Re: [RFC] vhost: Clear the pending messages on
 vhost_init_device_iotlb()
Message-ID: <20221107180022-mutt-send-email-mst@kernel.org>
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org>
 <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 10:10:06PM +0100, Eric Auger wrote:
> Hi Michael,
> On 11/7/22 21:42, Michael S. Tsirkin wrote:
> > On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
> >> When the vhost iotlb is used along with a guest virtual iommu
> >> and the guest gets rebooted, some MISS messages may have been
> >> recorded just before the reboot and spuriously executed by
> >> the virtual iommu after the reboot. Despite the device iotlb gets
> >> re-initialized, the messages are not cleared. Fix that by calling
> >> vhost_clear_msg() at the end of vhost_init_device_iotlb().
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> ---
> >>  drivers/vhost/vhost.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >> index 40097826cff0..422a1fdee0ca 100644
> >> --- a/drivers/vhost/vhost.c
> >> +++ b/drivers/vhost/vhost.c
> >> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
> >>  	}
> >>  
> >>  	vhost_iotlb_free(oiotlb);
> >> +	vhost_clear_msg(d);
> >>  
> >>  	return 0;
> >>  }
> > Hmm.  Can't messages meanwhile get processes and affect the
> > new iotlb?
> Isn't the msg processing stopped at the moment this function is called
> (VHOST_SET_FEATURES)?
> 
> Thanks
> 
> Eric

It's pretty late here I'm not sure.  You tell me what prevents it.

BTW vhost_init_device_iotlb gets enabled parameter but ignores
it, we really should drop that.

Also, it looks like if features are set with VIRTIO_F_ACCESS_PLATFORM
and then cleared, iotlb is not properly cleared - bug?


> >
> >
> >> -- 
> >> 2.37.3

