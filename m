Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ED15FE51D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJMWPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJMWPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:15:17 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1D65A834
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 15:15:14 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id CF2B440D4004;
        Thu, 13 Oct 2022 22:15:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru CF2B440D4004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1665699309;
        bh=zW55gN1/6+8XP4kkPEapEF1AnUx4akoHzKRCGfyaIdo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EqHOFwstTXG4EcnbNLuoFt3KmBo16+7A/QRUptixHCj0clunGQepso1oPZY8FQpic
         v3QCELHjMV9Ny1fy78zPs8gohVBqkDwN6hTpU8gAPd1vDwIoj2Pddwin7Y/W1SA0MT
         H+VMEUchrQ9wglQoR3BN6Yty8EzH5roP3KVJdqcU=
MIME-Version: 1.0
Date:   Fri, 14 Oct 2022 01:15:09 +0300
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     Andrei Vagin <avagin@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 2/2] selftests/timens: add a test for vfork+exit
In-Reply-To: <CAEWA0a6DHqZOduKhJi7o12RprGt2LGqGOC86TKN1bTXn36u7hw@mail.gmail.com>
References: <20220921003120.209637-1-avagin@google.com>
 <20220921003120.209637-2-avagin@google.com>
 <00ffd40b257346d26dfc0f03d144ec71@ispras.ru>
 <CAEWA0a6DHqZOduKhJi7o12RprGt2LGqGOC86TKN1bTXn36u7hw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <724cf9e4b07b7d25135f3f1427f1c9fc@ispras.ru>
X-Sender: izbyshev@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-13 20:46, Andrei Vagin wrote:
> On Sun, Oct 9, 2022 at 9:10 AM Alexey Izbyshev <izbyshev@ispras.ru> 
> wrote:
>> 
>> On 2022-09-21 03:31, Andrei Vagin wrote:
>> > From: Andrei Vagin <avagin@gmail.com>
> 
> <snip>
> 
>> > +     if (pid == 0) {
>> > +             char now_str[64];
>> > +             char *cargv[] = {"exec", now_str, NULL};
>> > +             char *cenv[] = {NULL};
>> > +
>> > +             // Check that we are still in the source timens.
>> > +             if (check("child before exec", &now))
>> > +                     return 1;
>> 
>> I know this is just a test, but...
>> 
>> Creating threads in a vfork()-child is quite dangerous (like most 
>> other
>> things that touch the libc state, which is shared with the parent
>> process). Here it works probably only because pthread_create() 
>> followed
>> by pthread_join() restores everything into more-or-less the original
>> state before returning control to the parent, but this is something 
>> that
>> libcs don't guarantee and that can break at any moment.
>> 
>> Also, returning from a vfork()-child is explicitly forbidden by the
>> vfork() contract because the parent would then return to an invalid
>> stack frame that could be arbitrarily clobbered by code executed in 
>> the
>> child after main() returned. Moreover, if I'm not mistaken, on x86 
>> with
>> Intel CET-enabled glibc (assuming the support for CET is ever merged
>> into the kernel) such return would cause the parent to always trap
>> because the shadow stack will become inconsistent with the normal 
>> stack.
>> Instead, _exit() should be used here...
>> 
> 
> Hi Alexey,
> 
> You are right, it isn't a good idea to create threads from the vfork-ed
> process. Now, vfork isn't a special case in the kernel code, so I think
> we can just remove the check() call from here. I have sent an updated
> version of this patch, pls take a look at it.
> 
Hi, Andrei,

While I think you could just skip check_in_thread() in the vfork()-child 
instead of removing check() completely (the rest of the code in check() 
is unlikely to mess up the libc state), I agree that the test is still 
able to catch problems unconditionally affecting all CLONE_VM tasks 
thanks to check_in_thread() in the parent, so I don't see much point in 
holding it up further. Your v2 patch looks good enough to me, thanks!

Alexey
