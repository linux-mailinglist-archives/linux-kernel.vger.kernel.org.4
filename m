Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376F4690DCE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjBIQDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjBIQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:03:16 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E0AE765640
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:03:14 -0800 (PST)
Received: (qmail 778313 invoked by uid 1000); 9 Feb 2023 11:03:14 -0500
Date:   Thu, 9 Feb 2023 11:03:14 -0500
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
Message-ID: <Y+UZQvuh8KR4gE4P@rowland.harvard.edu>
References: <1675864487-18620-1-git-send-email-quic_prashk@quicinc.com>
 <Y+O3vBbBh4ZwSBWT@kroah.com>
 <482f2c32-41d1-f07e-ee3f-3eb9aee76ac7@quicinc.com>
 <Y+QEQBxlr6FZ58DK@rowland.harvard.edu>
 <542ee8a6-598c-ca17-6d75-5eca2b34133a@quicinc.com>
 <Y+SaZrDmaqB0U2QA@kroah.com>
 <f32398bb-62f3-12fd-4b81-7ce7bdf4706a@quicinc.com>
 <e7dde0aa-c1e2-dd6c-94a1-1e9049f0a5fb@quicinc.com>
 <Y+UMkA9iaJTWVQ5u@rowland.harvard.edu>
 <5ad875be-079c-7f91-ede9-68f954cc7f34@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ad875be-079c-7f91-ede9-68f954cc7f34@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 09:13:37PM +0530, Prashanth K wrote:
> 
> 
> On 09-02-23 08:39 pm, Alan Stern wrote:
> > You should consider having _two_ spinlocks: One in the gs_port structure
> > (the way it is now) and a separate global lock.  The first would be used
> > in situations where you know you have a valid pointer.  The second would
> > be used in situations where you don't know if the pointer is non-NULL
> > or where you are changing the pointer's value.
> Lets say we replaced the existing spinlock in gserial_resume and
> gserial_disconnect with a new static spinlock, and kept the spinlocks in
> other functions unchanged. In that case, wouldn't it cause additional race
> conditions as we are using 2 different locks.

Not race conditions, but possibilities for deadlock.

Indeed, you would have to be very careful about avoiding deadlock 
scenarios.  In particular, you would have to ensure that the code never 
tries to acquire the global spinlock while already holding one of the 
per-port spinlocks.

Alan Stern
