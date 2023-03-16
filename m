Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63446BD819
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCPSWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCPSWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:22:39 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id F3BF37A917
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:22:36 -0700 (PDT)
Received: (qmail 892389 invoked by uid 1000); 16 Mar 2023 14:22:35 -0400
Date:   Thu, 16 Mar 2023 14:22:35 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valery Zabrovsky <valthebrewer@yandex.ru>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
        Felipe Balbi <balbi@ti.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] usb: gadget: net2280: fix NULL pointer dereference
Message-ID: <2be27aee-1a2d-4c5c-bb62-018e1340d2ad@rowland.harvard.edu>
References: <20230316155356.13391-1-valthebrewer@yandex.ru>
 <ZBNBlwc9lt+pLFkd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBNBlwc9lt+pLFkd@kroah.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 05:19:35PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 16, 2023 at 06:53:55PM +0300, Valery Zabrovsky wrote:
> > In net2280_free_request():
> > If _ep is NULL, then ep is NULL and is dereferenced
> > while trying to produce an error message.
> 
> How can that ever happen?  How did you test and hit this?
> 
> > The patch replaces dev_err() with pr_err() which works fine.
> 
> That's not a good idea for driver code to use, sorry.
> 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> As I have said before, your testing framework needs a lot more work.
> 
> good luck!

In situations like this, it might be better to remove the check 
entirely.  If a driver does pass a NULL pointer, it will lead to an 
invalid pointer dereference which will certainly cause an oops and might 
very well crash the system.  That would be a lot more noticeable than an 
error message hidden in a kernel log!

Greg, is there any general policy about the need for sanity checks such 
as this one?  Like, don't put them in whenever a failure would lead 
to an immediate fault which would be easy to track down?

Alan Stern
