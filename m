Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2F469229C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjBJPr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjBJPry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:47:54 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0389F70952
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:47:53 -0800 (PST)
Received: (qmail 816769 invoked by uid 1000); 10 Feb 2023 10:47:53 -0500
Date:   Fri, 10 Feb 2023 10:47:53 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: u_serial: Add null pointer check in
 gserial_resume
Message-ID: <Y+ZnKaeJx41xswpT@rowland.harvard.edu>
References: <Y+SaZrDmaqB0U2QA@kroah.com>
 <f32398bb-62f3-12fd-4b81-7ce7bdf4706a@quicinc.com>
 <e7dde0aa-c1e2-dd6c-94a1-1e9049f0a5fb@quicinc.com>
 <Y+UMkA9iaJTWVQ5u@rowland.harvard.edu>
 <5ad875be-079c-7f91-ede9-68f954cc7f34@quicinc.com>
 <Y+UZQvuh8KR4gE4P@rowland.harvard.edu>
 <71f624df-5302-8276-2a2a-96223d4ba3c7@quicinc.com>
 <Y+VgHdJjrd0ZvY33@rowland.harvard.edu>
 <53d48954-3f7e-fd02-5e8e-2912c16565b3@quicinc.com>
 <bf3296be-10f7-5a43-5ae8-dfc5b6d41240@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf3296be-10f7-5a43-5ae8-dfc5b6d41240@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:26:52PM +0530, Prashanth K wrote:
> 
> 
> > And this seems like a viable option to me, what do you suggest?
> > 
> > gserial_disconnect {
> >      spin_lock(static)
> >      spin_lock(port)
> >      ...
> >      gser->ioport = NULL;
> >      ...
> >      spin_lock(port)
> >      spin_unlock(static)
> > 
> > }
> > 
> > gserial_resume {
> >      struct gs_port *port = gser->ioport;
> > 
> >      spin_lock(static)
> >      if (!port)
> 	   spin_unlock(static)
> >          return
> >      spin_lock(port)

If you want, you could move the spin_unlock(static) up to here.  It 
probably doesn't matter.

> > 
> >      ...
> >      spin_unlock(port)
> >      spin_unlock(static)
> > }

I agree, that should work fine.

Alan Stern
