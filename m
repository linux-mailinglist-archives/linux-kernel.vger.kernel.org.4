Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219015B89D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiINOD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiINOCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:02:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD407A539;
        Wed, 14 Sep 2022 07:02:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86AD261D8F;
        Wed, 14 Sep 2022 14:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F73C4347C;
        Wed, 14 Sep 2022 14:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663164121;
        bh=NCcTwwKCAlQIABfOl9WvMf92ki9ZXJbGa5QXGi7eAl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V0LhkLbO2f6F3xXrHc9/jVO4fcaYmxCR62Ja689Fi3VSJOxzM4Bp+Mcmejl1filee
         XTeFYZrz4E5LbxZGSzxz2S7OIx2ernyNrVc6BNxHlrb7+kSR2vJ40gQ1/Zus8MEwcN
         +L5358vSEtKN5IOQxwcDrUeAL2TgNpzKOEdneQ5k=
Date:   Wed, 14 Sep 2022 16:02:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rondreis <linhaoguo86@gmail.com>
Cc:     balbi@kernel.org, john@metanate.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: possible deadlock in f_midi_transmit
Message-ID: <YyHe8dBI5ERbK+sL@kroah.com>
References: <CAB7eexKfentLRraPRR8kwqY3NRN9WTTijLW8SrKwAPzOzouxDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB7eexKfentLRraPRR8kwqY3NRN9WTTijLW8SrKwAPzOzouxDg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 08:49:49PM +0800, Rondreis wrote:
> Hello,
> 
> When fuzzing the Linux kernel driver v6.0-rc4, the following crash was
> triggered.
> 
> HEAD commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
> git tree: upstream
> 
> kernel config: https://pastebin.com/raw/xtrgsXP3
> C reproducer: https://pastebin.com/raw/C1xYEf7Q
> console output: https://pastebin.com/raw/3RLhvQHE
> 
> Basically, in the c reproducer, we use the gadget module to emulate
> attaching a USB device(vendor id: 0x403, product id: 0xff3d, with the
> midi function) and executing some simple sequence of system calls.
> To reproduce this crash, we utilize a third-party library to emulate
> the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
> Just clone this repository, install it, and compile the c
> reproducer with ``` gcc crash.c -lusbgx -lconfig -o crash ``` will do
> the trick.
> 
> I would appreciate it if you have any idea how to solve this bug.
> 
> The crash report is as follows:
> 
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.0.0-rc4+ #20 Not tainted
> --------------------------------------------
> kworker/0:1H/9 is trying to acquire lock:
> ffff888057ed9228 (&midi->transmit_lock){....}-{2:2}, at:
> f_midi_transmit+0x18c/0x1460 drivers/usb/gadget/function/f_midi.c:683
> 
> but task is already holding lock:
> ffff888057ed9228 (&midi->transmit_lock){....}-{2:2}, at:
> f_midi_transmit+0x18c/0x1460 drivers/usb/gadget/function/f_midi.c:683
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&midi->transmit_lock);
>   lock(&midi->transmit_lock);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation

That's a lockdep warning, is this really deadlocking?

If so, I'd recommend asking the midi developers...

thanks,

greg k-h
