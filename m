Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC8E6318DF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 04:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiKUDX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 22:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiKUDX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 22:23:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A7618B10;
        Sun, 20 Nov 2022 19:23:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5157A60E9F;
        Mon, 21 Nov 2022 03:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7D0C433C1;
        Mon, 21 Nov 2022 03:23:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FGcmyMnA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669001003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iHEmdgq+IRGtyRkvMHcpeJyVrJYV+YY+BtviBpbtKkE=;
        b=FGcmyMnAD11Sh+J4t9G3VpYMKj7qX+ijuot6gl1P6jUUjOl0wT6U3g43oAe6fszlrs6kBx
        CtJekQ6F9NjrzynOGtu7yfJ7JIVyT2tu+QbpXIMaZ/rrVuuMkaq1nlhrRFTgAHJp55Srgv
        RPRdrjHlUn754oDRoamnEDWZ5Wp6WSI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 73f9b883 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 21 Nov 2022 03:23:22 +0000 (UTC)
Date:   Mon, 21 Nov 2022 04:23:20 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH v5 2/3] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <Y3rvKEeSAq6548Sz@zx2c4.com>
References: <20221119120929.2963813-1-Jason@zx2c4.com>
 <20221119120929.2963813-3-Jason@zx2c4.com>
 <Y3liVEdYByF2gZZU@sol.localdomain>
 <Y3l6ocn1dTN0+1GK@zx2c4.com>
 <Y3l9MXCO02/rOpFx@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3l9MXCO02/rOpFx@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 02:04:49AM +0100, Jason A. Donenfeld wrote:
> On Sun, Nov 20, 2022 at 01:53:53AM +0100, Jason A. Donenfeld wrote:
> > I'm not quite sure what the best approach here is. One idea would be to
> > just note that libcs should wait until vgetrandom() has returned
> > everywhere before forking, using its atfork functionality. 
> 
> To elaborate on this idea a bit, the way this looks is:
> 
>   rwlock_t l;
>   pid_t fork(void)
>   {
>     pid_t pid;
>     write_lock(&l);
>     pid = syscall_fork();
>     write_unlock(&l);
>     return pid;
>   }
>   ssize_t getrandom(...)
>   {
>     ssize_t ret;
>     ...
>     if (!read_try_lock(&l))
>     	return syscall_getrandom(...);
>     ret = vdso_getrandom(...);
>     read_unlock(&l);
>     return ret;
>   }
> 
> So maybe that doesn't seem that bad, especially considering libc already
> has the kind of infrastructure in place to do that somewhat easily.
> Maybe there's a priority locking thing to get right here -- the writer
> should immediately starve out all future readers, so it's not unbound --
> but that seems par for the course.

Fortunately none of this was necessary, and I've got things implemented
without needing to resort to that, for v+1.

Jason
