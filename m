Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D9C6C826F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCXQfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXQfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:35:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3B9D52F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:35:16 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679675714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z0I9lsT60WCP6vbQCWj28YST5u9bxKrl5bchzlD9sCE=;
        b=yaZeWUSU815+XJ/jzQpzdqIwgsCsBNHFWGrBYbuy32UqwPOL+Q/9c87OH3NslI0LE7mQA8
        2/zEUxIBbeOWiPzf5OmG8gxf5g8vF6v/uFqhjwa0Y7jNtLhtslqY8qQhdQHRbrvi1XwHOZ
        DVAXgimQ0nMrLcph9zrk08IQdMECf5tcuKcS4K1QTqK7sXXcT9blMMW4M4TaBfRRrMM6nL
        sQO57Pe7HA9GSOy5jxBbUdCJTTymL67Do+5wFjeCn2/DEDsOZ1W/yuYQ+a3hkLEmI3HAIm
        IUrFPnF/Jpp6Wl9E/d2jL+csKrJM6Lmh15xux/yhYO+QNTxalnZWEbVnSLlVYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679675714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z0I9lsT60WCP6vbQCWj28YST5u9bxKrl5bchzlD9sCE=;
        b=xBqsF3Xfl1mz/yPYkhuXGlsIWrS9exh/cdRXclN129z2MMikXTPjq9YOXNtfv9/VrtyErx
        ZonNezu0lAPFwKCg==
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: move @microcode_mutex definition near usage
In-Reply-To: <20230324151933.GCZB2/hUOFuECIF1AG@fat_crate.local>
References: <20230324114720.1756466-1-john.ogness@linutronix.de>
 <20230324120019.GAZB2Q09ODVq0iYz5l@fat_crate.local>
 <87edpenvkh.fsf@jogness.linutronix.de>
 <20230324151933.GCZB2/hUOFuECIF1AG@fat_crate.local>
Date:   Fri, 24 Mar 2023 17:39:35 +0106
Message-ID: <87a602nm74.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-24, Borislav Petkov <bp@alien8.de> wrote:
>> I was doing some tests with CONFIG_PREEMPT_RT. I did not think that
>> mattered, since the mutex is obviously defined but not used for
>> !CONFIG_MICROCODE_LATE_LOADING.
>
> Oh sure, I see that. I'd still like to have in the commit message why
> exactly it happens.

Note that an unused mutex is being defined, even when the compiler is
not warning about it.

>> CONFIG_PREEMPT_RT cannot be enabled yet, so this patch is not urgent for
>> mainline. But at some point it will need fixing.
>
> Sure, send it to me when it can be triggered with a .config with the
> upstream tree, along with exact explanation how it happens and I'll
> queue it.

OK, but the kernel test robots will probably beat me to it. ;-)

John Ogness
