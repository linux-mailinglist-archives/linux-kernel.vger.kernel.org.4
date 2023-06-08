Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6A77283B7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbjFHP1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjFHP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:27:11 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9314B2D46
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:27:09 -0700 (PDT)
Received: (qmail 265539 invoked by uid 1000); 8 Jun 2023 11:27:08 -0400
Date:   Thu, 8 Jun 2023 11:27:08 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, francesco@dolcini.it,
        alistair@alistair23.me, stephan@gerhold.net, bagasdotme@gmail.com,
        luca@z3ntu.xyz, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 2/2] usb: gadget: udc: core: Prevent
 soft_connect_store() race
Message-ID: <66a886aa-4b3d-421d-a229-8bb400c6fc8b@rowland.harvard.edu>
References: <20230601031028.544244-1-badhri@google.com>
 <20230601031028.544244-2-badhri@google.com>
 <0bea99f1-cf66-4e80-b89b-41007c2ccfee@rowland.harvard.edu>
 <CAPTae5+EG+neDj=z4vC-r88Ai9Ha9n6FGU3dJi34NY+bka0zvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTae5+EG+neDj=z4vC-r88Ai9Ha9n6FGU3dJi34NY+bka0zvQ@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:17:04PM -0700, Badhri Jagan Sridharan wrote:
> On Wed, Jun 7, 2023 at 11:26 AM Alan Stern <stern@rowland.harvard.edu>
> wrote:
> > > @@ -756,10 +772,12 @@ int usb_gadget_disconnect(struct usb_gadget
> > *gadget)
> > >       if (!gadget->connected)
> > >               goto out;
> > >
> > > -     if (gadget->deactivated) {
> > > +     if (gadget->deactivated || !gadget->udc->started) {
> >
> > Do you really need to add this extra test?  After all, if the gadget
> > isn't started then how could the previous test of gadget->connected
> > possibly succeed?
> >
> > In fact, I suspect this entire section of code was always useless, since
> > the gadget couldn't be connected now if it was already deactivated.
> >
> 
> Thanks Alan ! Will fix all other comments in v7 but not sure about this one.
> Although the ->pullup() function will not be called,
> -> connected flag could actually be set when the gadget is not started.
> 
> - if (gadget->deactivated || !gadget->udc->allow_connect) {
> + if (gadget->deactivated || !gadget->udc->allow_connect ||
> !gadget->udc->started) {
>   /*
>   * If gadget is deactivated we only save new state.
>   * Gadget will be connected automatically after activation.
> + *
> + * udc first needs to be started before gadget can be pulled up.
>   */
>   gadget->connected = true;
> 
> This could happen, for instance, when  usb_udc_vbus_handler()  is invoked
> after soft_connect_store() disconnects the gadget.
> Same applies to when usb_gadget_connect() is called after the gadget has
> been deactivated through usb_gadget_deactivate().
> 
> This implies that the checks should be there, right ?

Yes, you're right; the checks do need to be there.  I had forgotten
about these possible cases.  Ignore that comment.

Alan Stern
