Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E67F5C0453
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiIUQhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiIUQgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:36:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BAE8169B;
        Wed, 21 Sep 2022 09:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7DBCB8312B;
        Wed, 21 Sep 2022 16:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B7CC433D6;
        Wed, 21 Sep 2022 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663777207;
        bh=Duj4kklWK0YcmYF/HuojDKc2O7J0ExDwCk56eToKF2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHE9SwBBT9b+t2i4TxSGAYeOR4V6dLQsGhCI0BGD9omLr9/7/9NjsQo1QwiF459l9
         kF1s/nMqT/Ej8wGb6rGiLr5ArcwuQePBlyD7kgkctYVTJ/RXUCtwZlrAutAnWp+YV+
         uonvd5o6r5v5ihCuPnYGMCBmELmbLqPyKiTDROnw=
Date:   Wed, 21 Sep 2022 18:20:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rondreis <linhaoguo86@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        johan@kernel.org
Subject: Re: KASAN: use-after-free Write in keyspan_close
Message-ID: <Yys5tGHLo4AFcA3E@kroah.com>
References: <CAB7eexKhQeqgpMaZoT=JD2EMwn=qTw4sWzF7hdU9XDFVsz3ooA@mail.gmail.com>
 <YynnT7/mnzJVn7iz@kroah.com>
 <CAB7eexKKeOxgZ6uh7WXJcui71_uOMeYr8+=Hfb0-Gi4h8JMmEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB7eexKKeOxgZ6uh7WXJcui71_uOMeYr8+=Hfb0-Gi4h8JMmEw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 11:45:17PM +0800, Rondreis wrote:
> Thank you for your reply!
> 
> This is a “fake” device. We emulated some functions with the built-in
> gadget module as a virtual device side for fuzzing. It can pass through
> the matching phase and, to some extent the probing phase.
> As you said, the configuration options are correct.

But this fake device does not follow the protocol of the real device,
right?  So how is any fake data sent/received by it to fuzz?

> After a successful attachment, we extracted the file_operations
> of the device files on both sides to find the corresponding system calls.

open/read/write/close?  :)

> Later, by fuzzing the dual-sided device with system calls, it is
> equivalent to considering data threats from both peripheral and user space.

So you are now treating this device as malicious.

If so, wonderful, that means you now need to audit the driver and fix
all of the assumptions that we made when it was written as it was a
trusted device at that point in time.

Not to say that this is a bad thing, just that you are testing something
that the original code was never designed to even consider, so you will
find problems.

Any help you can in fixing them would be appreciated, and then we can
move on to all of the others that we have as all of them were also
written to assume that we trust the hardware, as that was the Linux
security model at the time (also all other operating system's model, we
are not unique here.)

My point being, this is going to be a long slog if you wish to change
the model that Linux was originally designed for.  Perhaps you should
look into some way to "trace" the data paths to find where USB data is
received and acted on before it can be "trusted".  Much like we
currently do today for userspace memory pointers.

That will be a much better solution overall, so that we can then use
that model to fix all drivers, and prevent any future changes from also
causing problems.

Then you can turn that model to other busses, which for now we also
consider trusted, but some people wish to change that.

So don't focus on this one tiny driver, try working on the root issue
here please.

good luck!

greg k-h
