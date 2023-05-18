Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483FE70849C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjERPGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjERPEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:04:20 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 89783E43
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:04:01 -0700 (PDT)
Received: (qmail 916250 invoked by uid 1000); 18 May 2023 10:56:17 -0400
Date:   Thu, 18 May 2023 10:56:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Helge Deller <deller@gmx.de>
Cc:     syzbot <syzbot+0e22d63dcebb802b9bc8@syzkaller.appspotmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, bernie@plugable.com,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fbdev?] [usb?] WARNING in
 dlfb_submit_urb/usb_submit_urb (2)
Message-ID: <2905a85f-4a3b-4a4f-b8fb-a4d037d6c591@rowland.harvard.edu>
References: <0000000000004a222005fbf00461@google.com>
 <ZGXVANMhn5j/jObU@ls3530>
 <4cd17511-2b60-4c37-baf3-c477cf6d1761@rowland.harvard.edu>
 <be824fbc-cde4-9a2a-8fb4-1ca23f498dca@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be824fbc-cde4-9a2a-8fb4-1ca23f498dca@gmx.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 04:16:33PM +0200, Helge Deller wrote:
> On 5/18/23 15:54, Alan Stern wrote:
> > On Thu, May 18, 2023 at 09:34:24AM +0200, Helge Deller wrote:
> > > I think this is an informational warning from the USB stack,
> > 
> > It is not informational.  It is a warning that the caller has a bug.
> 
> I'm not a USB expert, so I searched for such bug reports, and it seems
> people sometimes faced this warning with different USB devices.

Yes.

> > You can't fix a bug by changing the line that reports it from dev_WARN
> > to printk!
> 
> Of course this patch wasn't intended as "fix".
> It was intended to see how the udlfb driver behaves in this situation, e.g.
> if the driver then crashes afterwards.
> 
> Furthermore, why does usb_submit_urb() prints this WARNING and then continues?
> If it's a real bug, why doesn't it returns an error instead?
> So, in principle I still think this warning is kind of informational,
> which of course points to some kind of problem which should be fixed.

Depending on the situation, the bug may or may not lead to an error.  At 
the time the dev_WARN was added, we were less careful about these sorts 
of checks; I did not want to cause previously working devices to stop 
working by failing the URB submission.

> > In this case it looks like dlfb_usb_probe() or one of the routines it
> > calls is wrong; it assumes that an endpoint has the expected type
> > without checking.  More precisely, it thinks an endpoint is BULK when
> > actually it is INTERRUPT.  That's what needs to be fixed.
> 
> Maybe usb_submit_urb() should return an error so that drivers can
> react on it, instead of adding the same kind of checks to all drivers?

Feel free to submit a patch doing this.  But the checks should be added 
in any case; without them the drivers are simply wrong.

Alan Stern
