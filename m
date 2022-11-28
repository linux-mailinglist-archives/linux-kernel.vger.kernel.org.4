Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9210563B0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiK1SBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiK1SAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:00:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589B8E0EA;
        Mon, 28 Nov 2022 09:47:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2503612F3;
        Mon, 28 Nov 2022 17:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA333C433D6;
        Mon, 28 Nov 2022 17:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669657639;
        bh=1hkTev7NIENSu1g5GObZnRI6QKX9coXsgHP50hCr9cA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnJjcW7cY1CYaWkk1lz8Z4Y2RREZBjwBremYGYBLCtbaj1en7CtPhYqJSd35I7djj
         Py0yDG4AV6uoBsYD4MVTAZcsPf7scv/XJrW4/GuVZmbvh2La5vP/60LH3K2e/gAFAw
         qB0vVpwzzuiS301QMo46lIr+RpzhkTxJHKxR8moY=
Date:   Mon, 28 Nov 2022 18:47:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     John Keeping <john@metanate.com>, linux-usb@vger.kernel.org,
        Fabien Chouteau <fabien.chouteau@barco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Felipe Balbi <balbi@ti.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/3] usb: gadget: f_hid: fix f_hidg lifetime vs cdev
Message-ID: <Y4T0JMU93gr+MklZ@kroah.com>
References: <20221122123523.3068034-1-john@metanate.com>
 <Y30SWm+bhv8srJC2@google.com>
 <Y4S/3T7jzXzTHNSc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4S/3T7jzXzTHNSc@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:04:13PM +0000, Lee Jones wrote:
> On Tue, 22 Nov 2022, Lee Jones wrote:
> 
> > On Tue, 22 Nov 2022, John Keeping wrote:
> > 
> > > This series arises from the recent thread [1] on lifetime issues.
> > > 
> > > The main point is the first patch, with the second being an unrelated
> > > fix for an issue spotted while working on this.  Both of these have
> > > Fixes: tags for backporting to stable.
> > > 
> > > The final patch tidies up some error handling to hopefully avoid patch 2
> > > issues in the future.
> > > 
> > > [1] https://lore.kernel.org/r/20221117120813.1257583-1-lee@kernel.org
> > > 
> > > John Keeping (3):
> > >   usb: gadget: f_hid: fix f_hidg lifetime vs cdev
> > >   usb: gadget: f_hid: fix refcount leak on error path
> > >   usb: gadget: f_hid: tidy error handling in hidg_alloc
> > > 
> > >  drivers/usb/gadget/function/f_hid.c | 60 ++++++++++++++++-------------
> > >  1 file changed, 33 insertions(+), 27 deletions(-)
> > 
> > For the set:
> > 
> > Reviewed-by: Lee Jones <lee@kernel.org>
> > Tested-by: Lee Jones <lee@kernel.org>
> 
> Greg, is this still on your radar?

Yes, let me catch up on pending patches...
