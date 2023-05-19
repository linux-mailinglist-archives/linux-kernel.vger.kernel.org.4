Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A9A709ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjESPH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjESPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:07:27 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5987A109
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:07:26 -0700 (PDT)
Received: (qmail 40772 invoked by uid 1000); 19 May 2023 11:07:25 -0400
Date:   Fri, 19 May 2023 11:07:25 -0400
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
Subject: Re: [PATCH v2] usb: gadget: udc: core: Offload usb_udc_vbus_handler
 processing
Message-ID: <a1d064e7-9847-4e2e-b74a-4ae4f39d3f04@rowland.harvard.edu>
References: <20230519043041.1593578-1-badhri@google.com>
 <c181c8ef-f342-4a31-9b8c-e1fa14ad214e@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c181c8ef-f342-4a31-9b8c-e1fa14ad214e@rowland.harvard.edu>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 10:49:49AM -0400, Alan Stern wrote:
> On Fri, May 19, 2023 at 04:30:41AM +0000, Badhri Jagan Sridharan wrote:
> > chipidea udc calls usb_udc_vbus_handler from udc_start gadget
> > ops causing a deadlock. Avoid this by offloading usb_udc_vbus_handler
> > processing.
> 
> Look, this is way overkill.
> 
> usb_udc_vbus_handler() has only two jobs to do: set udc->vbus and call 
> usb_udc_connect_control().  Furthermore, it gets called from only two 
> drivers: chipidea and max3420.
> 
> Why not have the callers set udc->vbus themselves and then call 
> usb_gadget_{dis}connect() directly?  Then we could eliminate 
> usb_udc_vbus_handler() entirely.  And the unnecessary calls -- the ones 
> causing deadlocks -- from within udc_start() and udc_stop() handlers can 
> be removed with no further consequence.
> 
> This approach simplifies and removes code.  Whereas your approach 
> complicates and adds code for no good reason.

I changed my mind.

After looking more closely, I found the comment in gadget.h about 
->disconnect() callbacks happening in interrupt context.  This means we 
cannot use a mutex to protect the associated state, and therefore the 
connect_lock _must_ be a spinlock, not a mutex.

This also probably means that udc_start and udc_stop callbacks should 
not be invoked with the lock held.  In fact, you might want to avoid 
using the lock at all with gadget_bind_driver() and 
gadget_unbind_driver() -- use it only in the functions that these 
routines call.

So it appears the whole connect_lock thing needs to be redesigned with 
these ideas in mind.  However, it's still true that the UDC drivers 
shouldn't try to set the connection state from within their udc_start 
and udc_stop callbacks, because the core takes care of this 
automatically.

Alan Stern
