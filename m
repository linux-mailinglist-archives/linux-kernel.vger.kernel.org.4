Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC60E695044
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBMTE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBMTE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:04:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9701CF4B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:04:01 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676315014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s/5hBu3lJn/nxDd45X/AZd9ZUTe4oaN87JfD4iadRpA=;
        b=Zo4GlIDsgegigrgFMYCL+i/4cAE6UGTPwynRmjh3xboLJm4gcmMxjwgpgOWxEYPlD2WJBY
        QouZ0DJLwO1f2LTPkJYgUW1vZzFRy8Q/D5F5ozZIoZtuQ8kxs0AnviSlrSwQhvf+NDBfj4
        F9+WxYduSMyPG7TZWxzl6Blsq2w2mzKb0I7sps03eikJ54SXeC0EgVAu3bJVruct3OEQjR
        UUIgg2UTDSfoIVJdnulb8CJiCjFagvpSHWgHfB41VcESdat+eUlYUoHBmLggMLoaQ94Put
        o0u13yw3sG/Fd/emSfGVaj4e/c1Mrko0fsSGoasKFT5Kf/3s2tjWsa4UaRuvHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676315014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s/5hBu3lJn/nxDd45X/AZd9ZUTe4oaN87JfD4iadRpA=;
        b=olibHbAFeBCq5oQJ5pdXixnpt+iaVdMRyPo1DdyRmeTH3tz1x7uDJtPDx7UTZVf5cuQmEm
        Dgthve/+8gYIGMCA==
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86: Use `get_random_u8' for kernel stack offset
 randomization
In-Reply-To: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301302011150.55843@angie.orcam.me.uk>
Date:   Mon, 13 Feb 2023 20:03:34 +0100
Message-ID: <874jrptmk9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30 2023 at 21:30, Maciej W. Rozycki wrote:
>
> Therefore switch to our generic entropy source and use `get_random_u8' 
> instead, which according to Jason A. Donenfeld is supposed to be fast 
> enough:
>
> "Generally it's very very fast, as most cases wind up being only a
> memcpy -- in this case, a single byte copy. So by and large it should
> be suitable. It's fast enough now that most networking things are able
> to use it. And lots of other places where you'd want really high
> performance. So I'd expect it's okay to use here too. And if it is too
> slow, we should figure out how to make it faster. But I don't suspect
> it'll be too slow."

Please provide numbers on contemporary hardware.

Up to that point, it's easy enough to just disable that randomization on
32bit.

Thanks,

        tglx
