Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CE674EAF1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGKJmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGKJmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:42:00 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3E691;
        Tue, 11 Jul 2023 02:41:59 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C38D20008;
        Tue, 11 Jul 2023 09:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689068517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mQpjvbXTqSZMh2oqXJLwIPvBh65UpQSNz+TWmuX7pg=;
        b=J0IPQRNMF4rW2vhHO+MYH6DbHjXzguu5d4CblnTphTAbz9ZHmZ8RKYVpLXShsypPVO7j6N
        LYIc1MsuzN/0rKV95AwKrjMPziCl43osWurZYVBCqlwo2TdBB8aEX5PQTCS5AGn50ZwmVL
        NTk/4ViLGUGU5qLaKuzX8Ib9PeofopHsvXevdHx5GDuHYF0bvSswTu9giUyFQtqS/YpbaK
        FvIou48O/Tbv0p4Kuv01/RRyikSfEnqANaZHaheeak+lCFg1RslpA9s4A6rqxdFdALqKXN
        FgIQbgkJJ+fVrlUVqyoL8iUiKDvvHr+9Xgt6QwIxvaipNaeSZgstvccv138LAg==
Date:   Tue, 11 Jul 2023 11:41:55 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     "Chunfeng Yun (=?UTF-8?B?5LqR5pil5bOw?=)" <Chunfeng.Yun@mediatek.com>
Cc:     "yhao016@ucr.edu" <yhao016@ucr.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: mtu3: Fix possible use-before-initialization bug
Message-ID: <20230711114155.4a000704@bootlin.com>
In-Reply-To: <29a71cbb61148d2085cc08da681526c4e20d31b9.camel@mediatek.com>
References: <CA+UBctDxfb6+70+hzuXJ-gwb65E0uoNzXYEhpJT92sXr2CE7OA@mail.gmail.com>
        <20230705080625.02b2bac5@bootlin.com>
        <CA+UBctBqtSvyBWf9ZwKbecTrh9_6sCDm_TyU-ncb+6h5y19K5g@mail.gmail.com>
        <20230710082558.2f82d607@bootlin.com>
        <29a71cbb61148d2085cc08da681526c4e20d31b9.camel@mediatek.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunfeng,

On Tue, 11 Jul 2023 08:48:35 +0000
Chunfeng Yun (云春峰) <Chunfeng.Yun@mediatek.com> wrote:

> On Mon, 2023-07-10 at 08:25 +0200, Herve Codina wrote:
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  Hi Yu,
> > 
> > On Sun, 9 Jul 2023 17:48:15 -0700
> > Yu Hao <yhao016@ucr.edu> wrote:
> >   
> > > Hi Hervé,
> > > 
> > > Thanks for the comments. How about this patch?
> > > ---
> > >  drivers/usb/mtu3/mtu3_gadget_ep0.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c
> > > b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> > > index e4fd1bb14a55..af2884943c2a 100644
> > > --- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
> > > +++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> > > @@ -600,7 +600,7 @@ static void ep0_tx_state(struct mtu3 *mtu)
> > >         mtu3_readl(mtu->mac_base, U3D_EP0CSR));
> > >  }
> > > 
> > > -static void ep0_read_setup(struct mtu3 *mtu, struct  
> > usb_ctrlrequest *setup)  
> > > +static int ep0_read_setup(struct mtu3 *mtu, struct usb_ctrlrequest  
> > *setup)  
> > >  {
> > >     struct mtu3_request *mreq;
> > >     u32 count;
> > > @@ -608,6 +608,8 @@ static void ep0_read_setup(struct mtu3 *mtu,
> > > struct usb_ctrlrequest *setup)
> > > 
> > >     csr = mtu3_readl(mtu->mac_base, U3D_EP0CSR) & EP0_W1C_BITS;
> > >     count = mtu3_readl(mtu->mac_base, U3D_RXCOUNT0);
> > > +   if (count == 0)
> > > +       return -EINVAL;  
> > 
> > 'count' should be tested against sizeof(*setup). Indeed, we need to
> > have a
> > setup data packet in the fifo.
> > 
> > What do you think about:
> > if (count < sizef(*setup))
> > return -EINVAL;  
> before call this function, already check the data length in fifo, it
> should be 8 bytes.
> see mtu3_ep0_isr(), about line 761.

Indeed, I missed that point.
Thanks for pointing it.

Regards,
Hervé

> 
> I think no need this patch
> 
> Thanks a lot
> 
> >   
> > > 
> > >     ep0_read_fifo(mtu->ep0, (u8 *)setup, count);
> > > 
> > > @@ -642,7 +644,8 @@ __acquires(mtu->lock)
> > >     struct mtu3_request *mreq;
> > >     int handled = 0;
> > > 
> > > -   ep0_read_setup(mtu, &setup);
> > > +   if (ep0_read_setup(mtu, &setup))
> > > +       return -EINVAL;  
> > 
> > Forward the error code to the caller ?
> > 
> > ret = ep0_read_setup(mtu, &setup)
> > if (ret < 0)
> > return ret;
> > 
> >   
> > >     trace_mtu3_handle_setup(&setup);
> > > 
> > >     if ((setup.bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD)
> > > @@ -764,7 +767,9 @@ irqreturn_t mtu3_ep0_isr(struct mtu3 *mtu)
> > >             break;
> > >         }
> > > 
> > > -       ep0_handle_setup(mtu);
> > > +       if (ep0_handle_setup(mtu))
> > > +           break;
> > > +  
> > 
> > Ok
> >   
> > >         ret = IRQ_HANDLED;
> > >         break;
> > >     default:  
> > 
> > Be careful, your patch is wrongly indented.
> > tabs replaced by 4 spaces. You need to keep tabs.
> > 
> > Regards,
> > Hervé Codina
> >   

