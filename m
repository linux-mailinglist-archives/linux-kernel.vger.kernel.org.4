Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5221635C60
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbiKWMEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKWMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:04:37 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506E062F6;
        Wed, 23 Nov 2022 04:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-ID:Content-Description;
        bh=5JMIrXWfVVUBawjQhTsB12rkc3V2fqv2OGN2cVRUBRs=; b=TN91uAo4CNv5C7fEtaNVdRScjZ
        r8YBSVaWiMa+2ppar+coZcihrgglWDIJfTsLSaQwpUhf1rVEmcd9kLzW+lXPH6AYxvX3dyTwXxv1x
        RbvYqzICSadoDgk2up5jwHMyZl4vSrPKOgTmiSFPFOkXKFD/VNmT3ZkuxETK/dTX6VQu+2OBedXun
        QfvLoZZ9UCnkzlfqSe9uGPcdnsDWWR2c0vhOxejyjs2JoSjgn1QZ1qHA91tVW3WTM0hplyFJRx2WI
        MKkNKP5+0FMvgjSWMD7G4Y7GKMU8RBa/Buf+T5sUGCT0+61+MnakBdfUCQRcyNmQ3VKs/gwLHOril
        B1CvOObg==;
Received: from dougal.metanate.com ([192.168.88.1] helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1oxoUU-0007F2-2m;
        Wed, 23 Nov 2022 12:04:34 +0000
Date:   Wed, 23 Nov 2022 12:04:33 +0000
From:   John Keeping <john@metanate.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-usb@vger.kernel.org,
        Fabien Chouteau <fabien.chouteau@barco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Felipe Balbi <balbi@ti.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/3] usb: gadget: f_hid: fix refcount leak on error path
Message-ID: <Y34MUUyOSgwLWQA+@donbot>
References: <20221122123523.3068034-1-john@metanate.com>
 <20221122123523.3068034-3-john@metanate.com>
 <dcd180f6-7769-3bc5-403f-8960e922bb50@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcd180f6-7769-3bc5-403f-8960e922bb50@collabora.com>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 12:55:14PM +0100, Andrzej Pietrasiewicz wrote:
> W dniu 22.11.2022 o 13:35, John Keeping pisze:
> > When failing to allocate report_desc, opts->refcnt has already been
> > incremented so it needs to be decremented to avoid leaving the options
> > structure permanently locked.
> > 
> > Fixes: 21a9476a7ba8 ("usb: gadget: hid: add configfs support")
> > Signed-off-by: John Keeping <john@metanate.com>
> 
> I'd personally place the bugfix before patches 1 and 3, but anyway

Patch 1 is also a bugfix, I ordered 1 & 2 based on the order of the
commits in the Fixes: tags.

> Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> 
> > ---
> >   drivers/usb/gadget/function/f_hid.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> > index 8b8bbeaa27cb..6be6009f911e 100644
> > --- a/drivers/usb/gadget/function/f_hid.c
> > +++ b/drivers/usb/gadget/function/f_hid.c
> > @@ -1292,6 +1292,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
> >   						 GFP_KERNEL);
> >   		if (!hidg->report_desc) {
> >   			put_device(&hidg->dev);
> > +			--opts->refcnt;
> >   			mutex_unlock(&opts->lock);
> >   			return ERR_PTR(-ENOMEM);
> >   		}
> 
