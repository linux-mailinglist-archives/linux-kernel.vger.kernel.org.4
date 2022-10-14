Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8495FE86A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 07:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJNFcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 01:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJNFcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 01:32:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B671946F9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 22:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665725568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BWNFgRVlGjYNydd5Fi8o/nyAidzrHzoVF78WNHdTm7o=;
        b=hxWgxf3+mZAniUfoNH/fUYRtpT+eYdGbMt2wXESwppKF9H6fXpkONWNacbo8paDwnXqxkT
        rX1PR3TLmBTzUoqoX0GlMt/pFVogBN4IU5/mzXOiiS86C4T2rSnVpJGx+JhEB9g1kr4VM2
        RJ720gVS1uhn+jCMALmVnH7WcISYgQg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-287-4RzmNkz9MC-R6rHs7kVWmw-1; Fri, 14 Oct 2022 01:32:47 -0400
X-MC-Unique: 4RzmNkz9MC-R6rHs7kVWmw-1
Received: by mail-wr1-f71.google.com with SMTP id e14-20020adf9bce000000b0022d18139c79so1468690wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 22:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWNFgRVlGjYNydd5Fi8o/nyAidzrHzoVF78WNHdTm7o=;
        b=dcA9Wm9IWYQJRxXGkWqQGxnrIacmxzBW1jvgcGHwo/8Jq7oMzaUbXXwph+hdiAA5Lu
         uqo+qlVnR2QUcg89dHnekoN/dxHJRJSlPr+0wQYDbbet7IHcfBipJZofFqAI6Gl9iwAI
         TFlbnguhEI4SY5c9GKPQkX/VGaQEvu7/9/j/HG5VGhA9PuCg6O578rIECaF51krTahf0
         mAti25XndPZaN/QPaRiqItAqHdb0cyr92LKz75oX4fONwVkvQsjQw3PDloPOHMux3SLd
         NLW7I8EQtMWQSaOcPqaCmaX3U68yTOBpKhn2P+uRO4DFiH1JxataQSSHr3o9fVz8z/0m
         uXyg==
X-Gm-Message-State: ACrzQf0/3TnxkhQns1cyhg8A96n5Z0feiS8/TkpIdO0zrT4GTOdG0k1o
        vi+4Fx85tWnl6VuH2zHcLoWL6NPpZ9HLcTn6PJ0V7bL+EV135pKPOu7UlNrXLdIktVbn+zW40os
        r1xwrt73golg3pCxV+VjmZBcV
X-Received: by 2002:a05:600c:6885:b0:3c4:de24:638 with SMTP id fn5-20020a05600c688500b003c4de240638mr8799784wmb.183.1665725566138;
        Thu, 13 Oct 2022 22:32:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4R1CQSNUlZz9bqJOSmz/KQyXR4UqWpCPLl4Qqk64SVMiSobCwwLzb2VOcQZa8mbMypnWERfA==
X-Received: by 2002:a05:600c:6885:b0:3c4:de24:638 with SMTP id fn5-20020a05600c688500b003c4de240638mr8799770wmb.183.1665725565818;
        Thu, 13 Oct 2022 22:32:45 -0700 (PDT)
Received: from redhat.com ([2.54.162.123])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b003bf6da9d2cesm6022807wmq.28.2022.10.13.22.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 22:32:45 -0700 (PDT)
Date:   Fri, 14 Oct 2022 01:32:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] virtio_pci: use irq to detect interrupt support
Message-ID: <20221014013156-mutt-send-email-mst@kernel.org>
References: <20221012220312.308522-1-mst@redhat.com>
 <TY2PR06MB3424171328BEE476FCB9942785249@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY2PR06MB3424171328BEE476FCB9942785249@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 12:09:20AM +0000, Angus Chen wrote:
> Hi Mst
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, October 13, 2022 6:04 AM
> > To: linux-kernel@vger.kernel.org
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>; Michael Ellerman
> > <mpe@ellerman.id.au>; Angus Chen <angus.chen@jaguarmicro.com>; Jason
> > Wang <jasowang@redhat.com>; virtualization@lists.linux-foundation.org
> > Subject: [PATCH] virtio_pci: use irq to detect interrupt support
> > 
> > commit 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
> > breaks virtio_pci on powerpc, when running as a qemu guest.
> > 
> > vp_find_vqs() bails out because pci_dev->pin == 0.
> > 
> > But pci_dev->irq is populated correctly, so vp_find_vqs_intx() would
> > succeed if we called it - which is what the code used to do.
> > 
> > This seems to happen because pci_dev->pin is not populated in
> > pci_assign_irq().
> > 
> > Which is absolutely a bug in the relevant PCI code, but it
> > may also affect other platforms that use of_irq_parse_and_map_pci().
> > 
> > However Linus said:
> > 	The correct way to check for "no irq" doesn't use NO_IRQ at all, it just does
> > 		if (dev->irq) ...
> > so let's just check irq and be done with it.
> > 
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> > Fixes: 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
> > Cc: "Angus Chen" <angus.chen@jaguarmicro.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Build tested only - very late here. Angus any chance you could
> > help test this? Thanks!
> I tested the patch ，it work well on x86。Inlcude legacy and modern driver.
> And I tested it on arm server also，and find some problem because of 0.9.5 limitation.
>  "platform bug: legacy virtio-pci must not be used with RAM above 0x%llxGB\n",
>  But the error is not effected by our patch.with or without our patch ,it print the same.

Yes that's a limitation of 0.9.5 - just make a smaller VM to test
legacy.

> And I test modern dirver,it work well also.
> Sorry for the late reply.


Great, thanks a lot!

> > 
> >  drivers/virtio/virtio_pci_common.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_pci_common.c
> > b/drivers/virtio/virtio_pci_common.c
> > index 4df77eeb4d16..a6c86f916dbd 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -409,8 +409,8 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int
> > nvqs,
> >  	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
> >  	if (!err)
> >  		return 0;
> > -	/* Is there an interrupt pin? If not give up. */
> > -	if (!(to_vp_device(vdev)->pci_dev->pin))
> > +	/* Is there an interrupt? If not give up. */
> > +	if (!(to_vp_device(vdev)->pci_dev->irq))
> >  		return err;
> >  	/* Finally fall back to regular interrupts. */
> >  	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
> > --
> > MST
> 

