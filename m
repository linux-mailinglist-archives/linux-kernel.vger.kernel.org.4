Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4610163A465
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiK1JMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiK1JMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:12:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B661515A19;
        Mon, 28 Nov 2022 01:12:21 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669626740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=egAkd5jcnw3WXfXnsitc16aTXvDigRVo0FyASpJ7HzA=;
        b=fEZ52b6P2xXsYJ3imbGOViX9gJKxW0ix7VlMSP7XF0qWegibSTlzUTiEb3cwq6AHrI7n2Y
        dWhWkhoO/kX0wruHyNMkW5PizFHxUgZd0VGBK1aK153YV7BmYjo/knRn+uO3NAeDDPMyf6
        nRLuzBaIXF14pk/m3Ra8rHUzlvPGdjekw7v3QSyafHQ1cTMBKVoRRBcHWLSU+K3IZwMxJk
        csJi0uUpd4LNq7J5XgqQ8oA+DXSZT7M93Spgwyw5cF1QCY/rxNB+ZCWWSD7qD2Rn8ip/Kn
        u4u2JvCHS5LXVvuelc9Prh8WOA2HF0R+0RycSSUYtKrQC85xBaqVA2W8ErxSMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669626740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=egAkd5jcnw3WXfXnsitc16aTXvDigRVo0FyASpJ7HzA=;
        b=lGr49rOP7i+ovveWAhw2+02bhSFEHYgBkYWFAbYnd4I7CciOjIVzRxpzbj44G5+pUVzxnr
        V5MNZXtUnRXPsWDg==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v7 1/3] random: add vgetrandom_alloc() syscall
In-Reply-To: <Y4PF+pBlNZGfZ0sr@zx2c4.com>
References: <20221124165536.1631325-1-Jason@zx2c4.com>
 <20221124165536.1631325-2-Jason@zx2c4.com> <87bkouyd90.ffs@tglx>
 <Y4PF+pBlNZGfZ0sr@zx2c4.com>
Date:   Mon, 28 Nov 2022 10:12:19 +0100
Message-ID: <87pmd7wih8.ffs@tglx>
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

On Sun, Nov 27 2022 at 21:18, Jason A. Donenfeld wrote:
> On Fri, Nov 25, 2022 at 09:45:31PM +0100, Thomas Gleixner wrote:
>> > --- a/arch/x86/include/asm/unistd.h
>> > +++ b/arch/x86/include/asm/unistd.h
>> > @@ -27,6 +27,7 @@
>> >  #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
>> >  #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
>> >  #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
>> > +#  define __ARCH_WANT_VGETRANDOM_ALLOC
>> 
>> So instead of this define, why can't you do:
>> 
>> config VGETRADOM_ALLOC
>>        bool
>>        select ADVISE_SYSCALLS
>> 
>> and then have
>> 
>> config GENERIC_VDSO_RANDOM_WHATEVER
>>        bool
>>        select VGETRANDOM_ALLOC
>> 
>> This gives a clear Kconfig dependency instead of the random
>> ADVISE_SYSCALLS select.
>
> That's much better indeed. I was trying to straddle the two conventions
> of `#define __ARCH_...` for syscalls and a Kconfig for vDSO functions,
> but doing it all together as you've suggested is nicer.
>
> I'll try to figure this out, though so far futzing around suggests there
> might have to be both, because of unistd.h being a userspace header.
> That is, include/uapi/asm-generic/unistd.h typically needs a `#if
> __ARCH_WANT..., #define ...` in it. I'll give it a spin and you'll see

Bah. Did not think about that user space part...

Thanks,

        tglx
