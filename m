Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3293C68AA57
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 14:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbjBDNrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 08:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjBDNra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 08:47:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17DA2385A;
        Sat,  4 Feb 2023 05:47:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E3CC60C52;
        Sat,  4 Feb 2023 13:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3B8C433D2;
        Sat,  4 Feb 2023 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675518448;
        bh=Y6XRGBnDwv3SnYF+rVbMbNaRJLOSMSi4NThGLC2Ldzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rcg0WfeyZFCbBmKU1RzDmQeO1blbobPUoHEfgpDqQncqhtOvxn49fT9Os3TyQG/hd
         3Nu8JqjzLrPaGS3xwlOgWe1RN0Zin3/EpHWSLzwf1aO+szJZTsIplHZ0f1ekgY5Wri
         6/YqJVClTitxt8E5bJ/1Vl+f2e8HjRFz562ee48M=
Date:   Sat, 4 Feb 2023 14:47:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: Converting dev->mutex into dev->spinlock ?
Message-ID: <Y95h7Vop9t5Li0HD@kroah.com>
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 10:32:11PM +0900, Tetsuo Handa wrote:
> Hello.
> 
> There is a long-standing deadlock problem in driver core code caused by
> "struct device"->mutex being marked as "do not apply lockdep checks".

The marking of a lock does not cause a deadlock problem, so what do you
mean exactly by this?  Where is the actual deadlock?

> We can make this deadlock visible by applying [1], and we can confirm that
> there is a deadlock problem that I think needs to be addressed in core code [2].

Any reason why you didn't cc: us on these patches?

> Also, since driver developers are taking it for granted that driver callback
> functions can behave as if dev->mutex is not held (because possibility of deadlock
> was never reported), it would solve many deadlocks in driver code if you can update
> driver core code to avoid calling driver callback functions with dev->mutex held
> (by e.g. replacing dev->mutex with dev->spinlock and dev->atomic_flags).
> But I'm not familiar enough to propose such change...

A driver developer should never be messing with the mutex of a device,
that's not for them to touch, that's the driver core's lock to touch,
right?

So I don't understand the real problem here.  What subsystem is having
issues and what issues are they exactly?

And using a spinlock shouldn't change any locking deadlocks that I can
tell, so I don't understand the proposal, sorry.

thanks,

greg k-h
