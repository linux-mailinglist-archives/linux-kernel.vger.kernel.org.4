Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AF163CCFD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 02:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiK3Bm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 20:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiK3Bmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 20:42:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0182BF2;
        Tue, 29 Nov 2022 17:42:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32EF9B819AC;
        Wed, 30 Nov 2022 01:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C08BC433C1;
        Wed, 30 Nov 2022 01:42:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="K7IubIt0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669772565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WuN+KhpT8YNfloW483gLZz6haZ2usQ2Rlgmnbqxalyo=;
        b=K7IubIt0hZQBV+CqO3q1bKqvECB/bTg6+RQGig2PLj/QQ/JydF5843lv9HvmzfhhTV9Sny
        kYo9if1fJI5iU+/y4e0j0v/nMoCgzMGZhpkrUbGjxaJCxDDEvYn+EZ4K/9TG+aAtaAdfzJ
        dzWJtoFpb5n9DR1edRYismBfSvCJvKo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e3f8f065 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 30 Nov 2022 01:42:45 +0000 (UTC)
Date:   Wed, 30 Nov 2022 02:42:40 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v10 1/4] random: add vgetrandom_alloc() syscall
Message-ID: <Y4a1ELq0rM3/gGv3@zx2c4.com>
References: <20221129210639.42233-1-Jason@zx2c4.com>
 <20221129210639.42233-2-Jason@zx2c4.com>
 <87cz95v2q2.ffs@tglx>
 <Y4arB7/zB8mRoapK@zx2c4.com>
 <87mt89te77.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mt89te77.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 02:37:32AM +0100, Thomas Gleixner wrote:
> On Wed, Nov 30 2022 at 01:59, Jason A. Donenfeld wrote:
> > On Tue, Nov 29, 2022 at 11:02:29PM +0100, Thomas Gleixner wrote:
> >> > + * Returns a pointer to the first state in the allocation.
> >> 
> >> I have serious doubts that this statement is correct.
> >
> > "Returns the address of the first state in the allocation" is better I
> > guess.
> 
> Does not even come close to correct.
> 
> As my previous hint of 'using this as template for the (hint:missing)
> man page' did not work well, may I suggest that you look at the various
> return statements in that function and validate whether your proposed
> return value documentation is valid for all of them?

Ahh, the error values and such. Righto. Will do. I'll match the style of
similar functions.

Jason
