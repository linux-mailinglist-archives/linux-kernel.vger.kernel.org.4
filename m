Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DCA7072AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjEQUBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjEQUBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:01:31 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3049F5B8E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:01:29 -0700 (PDT)
Received: (qmail 887386 invoked by uid 1000); 17 May 2023 16:01:28 -0400
Date:   Wed, 17 May 2023 16:01:28 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        balbi@ti.com, francesco@dolcini.it, alistair@alistair23.me,
        stephan@gerhold.net, bagasdotme@gmail.com, luca@z3ntu.xyz,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1] usb: gadget: udc: core: Offload usb_udc_vbus_handler
 processing
Message-ID: <c7cb96ea-628d-4591-908c-d6ea572ef5a0@rowland.harvard.edu>
References: <20230517115955.1078339-1-badhri@google.com>
 <c7f19b4e-469c-4e40-bd2e-e864ca5f7872@rowland.harvard.edu>
 <CAPTae5JB2LLEF7ZNaJxMnF==8WCWoEYvmF_FK3F=BDq0Hko0xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTae5JB2LLEF7ZNaJxMnF==8WCWoEYvmF_FK3F=BDq0Hko0xQ@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 10:19:25AM -0700, Badhri Jagan Sridharan wrote:
> On Wed, May 17, 2023 at 7:44 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, May 17, 2023 at 11:59:55AM +0000, Badhri Jagan Sridharan wrote:
> > > chipidea udc calls usb_udc_vbus_handler from udc_start gadget
> > > ops causing a deadlock. Avoid this by offloading usb_udc_vbus_handler
> > > processing.
> >
> > Surely that is the wrong approach.
> >
> > The real problem here is that usb_udc_vbus_handler() gets called from
> > within a udc_start routine.  But this is totally unnecessary, because
> > the UDC core will call usb_udc_connect_control_locked() itself, later on
> > during gadget_bind_driver().
> 
> Hi Alan,
> 
> usb_udc_vbus_handler sets the udc->vbus flag as well apart from
> calling usb_udc_connect_control_locked().  So, removing usb_udc_vbus_handler
> from chip specific start callback might prevent the controller from
> starting.
> 
> void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
> {
> struct usb_udc *udc = gadget->udc;
> 
> mutex_lock(&udc->connect_lock);
> if (udc) {
> udc->vbus = status;
> usb_udc_connect_control_locked(udc);

Then add "udc->vbus = true;" at the appropriate spot in 
gadget_bind_driver().

Alan Stern

PS: I just noticed that in max3420_udc.c, the max_3420_vbus_handler() 
function calls usb_udc_vbus_handler() from within an interrupt handler.  
This won't work, since interrupt handlers aren't allowed to sleep and 
therefore can't lock mutexes.
