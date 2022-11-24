Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8CC636F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiKXBJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 20:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiKXBIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:08:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24AE106121;
        Wed, 23 Nov 2022 17:08:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61B63B82601;
        Thu, 24 Nov 2022 01:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19061C433D6;
        Thu, 24 Nov 2022 01:08:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ESyQDzKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669252126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jq/kgX6oeVA21zqtsBwkDHPYqUeMNJkafuAfZk9Ja+0=;
        b=ESyQDzKVrdgu1ir4VmP9swMJwjpGnDP1epO+1N1XeGcoWfi5vQOi9OcK8NkHse9NG+bmCq
        R6xSIqa6x0zcmDPZY0LaKjrtMQeJRruINLfghzLwEgR0gUMixuZKFFKcBMqTAezXrm2Gcg
        MyynCkI8vCgepZJdgCs6UI0v8hyAMjs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 83d3477e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 24 Nov 2022 01:08:46 +0000 (UTC)
Date:   Thu, 24 Nov 2022 02:08:44 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH v6 2/3] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <Y37EHHq41KBvgr8z@zx2c4.com>
References: <20221121152909.3414096-1-Jason@zx2c4.com>
 <20221121152909.3414096-3-Jason@zx2c4.com>
 <87r0xulzfd.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r0xulzfd.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Wed, Nov 23, 2022 at 11:48:06AM +0100, Florian Weimer wrote:
> * Jason A. Donenfeld:
> 
> >   static void *vgetrandom_alloc(size_t *num, size_t *size_per_each, unsigned int flags)
> >   {
> >     unsigned long ret = syscall(__NR_vgetrandom_alloc, num, size_per_each, flags);
> >     return ret > -4096UL ? NULL : (void *)ret;
> >   }
> 
> The traditional syscall function returns -1 on error and set errors, so
> using unsing long and the 4096 is quite misleading.

Not sure I have any idea at all whatsoever about what you're talking
about. Firstly, the function you quoted is from the "sample userspace
code" in the commit message, so it might not be code for the context you
have in mind.

Secondly, it's just doing the thing to figure out if the return value is
an error value or a pointer. Were we in glibc, we'd write this as:

    return INTERNAL_SYSCALL_ERROR_P(r) ? NULL : (void *) r;

Right? And if you look at the expansion of that glibc macro, it's just:

  #define INTERNAL_SYSCALL_ERROR_P(val) \
    ((unsigned long int) (val) > -4096UL)

So it looks like the same exact thing?

The only difference I could see is that I assign it to a `unsigned long
ret`, while glibc code tends to assign it to a `long r`? Is that the
difference you're pointing out? Except that clearly doesn't matter
because it just gets casted to unsigned by that macro anyway?

Confused.

Jason
