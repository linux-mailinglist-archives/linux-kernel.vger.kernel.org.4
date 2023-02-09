Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B0E690C71
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjBIPJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjBIPJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:09:05 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C784C46A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:09:04 -0800 (PST)
Received: (qmail 772764 invoked by uid 1000); 9 Feb 2023 10:09:04 -0500
Date:   Thu, 9 Feb 2023 10:09:04 -0500
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
Message-ID: <Y+UMkA9iaJTWVQ5u@rowland.harvard.edu>
References: <1675864487-18620-1-git-send-email-quic_prashk@quicinc.com>
 <Y+O3vBbBh4ZwSBWT@kroah.com>
 <482f2c32-41d1-f07e-ee3f-3eb9aee76ac7@quicinc.com>
 <Y+QEQBxlr6FZ58DK@rowland.harvard.edu>
 <542ee8a6-598c-ca17-6d75-5eca2b34133a@quicinc.com>
 <Y+SaZrDmaqB0U2QA@kroah.com>
 <f32398bb-62f3-12fd-4b81-7ce7bdf4706a@quicinc.com>
 <e7dde0aa-c1e2-dd6c-94a1-1e9049f0a5fb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7dde0aa-c1e2-dd6c-94a1-1e9049f0a5fb@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 07:37:01PM +0530, Prashanth K wrote:
> 
> 
> On 09-02-23 12:33 pm, Prashanth K wrote:
> > 
> > 
> > On 09-02-23 12:31 pm, Greg Kroah-Hartman wrote:
> > > On Thu, Feb 09, 2023 at 10:31:50AM +0530, Prashanth K wrote:
> > > > In that case i guess we have to make port_lock a global variable
> > > > and take it
> > > > out of gs_port structure.
> > > > 
> > > > + static DEFINE_SPINLOCK(port_lock);
> > > > 
> > > > struct gs_port {
> > > >     struct tty_port port;
> > > > -    spinlock_t port_lock;
> > > > 
> > > > This will require us to change all the spinlock(port->port_lock) used in
> > > > u_serial.c, what do you suggest?
> > > 
> > > Yes, that would be the correct thing to do.
> Hi Greg/Alan, One general doubt, if we make the spinlock static/global,
> wouldn't that be a problem when there are multiple instances, and also
> multiple interfaces can use u_serial at same time. Asking this because
> u_serial can be used by f_serial (gser) as well as f_acm (acm).

You should consider having _two_ spinlocks: One in the gs_port structure 
(the way it is now) and a separate global lock.  The first would be used 
in situations where you know you have a valid pointer.  The second would 
be used in situations where you don't know if the pointer is non-NULL 
or where you are changing the pointer's value.

Alan Stern
