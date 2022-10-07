Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4465F7694
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJGKAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJGJ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:59:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83A21BEB3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 02:59:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MkP1F4Prqz4x1V;
        Fri,  7 Oct 2022 20:59:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1665136785;
        bh=r5pOhr5aXcgfuxajTgRTIpgB/fG0Hr0VJvR4lNkxQuk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JrsEniCa8qmRDqtWz6i7lz8Evqm4LMSG/owqkEoToYVYDx/4RYzKgRr8s4lW6F9x4
         btk+FMh1Fy/mR7jqcXnE7Nwzn1qM4rOO2fidSQolZbs9Jt5qIZ3a6YoDkbD0AIPMJA
         1mTassUolopT46KlIKk1/GKiz0pS/hxDIcdpSmT7vCC5WHrLB1MztvHgW0/fhy3ffc
         Uc2Fo1N/y+azSYQi5VwynlKDz/t3VIzymq+IqIsr88AT/WSaNPzsHDYIUECKqrjNf9
         xh4BgcSD6H+Ij5ZJ4TiJSHGVsFmzsSg4Z3Nf/kVhExpMT2X718HNa0kFFxNArEDWin
         HucxopABOhxMA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 06/19] powerpc/cputable: Split cpu_specs[] out of
 cputable.h
In-Reply-To: <f75c2d9d-423f-f8c4-5bcd-cdea6c33e206@csgroup.eu>
References: <828f6a64eeb51ce9abfa1d4e84c521a02fecebb8.1663606875.git.christophe.leroy@csgroup.eu>
 <a44b865e0318286155273b10cdf524ab697928c1.1663606875.git.christophe.leroy@csgroup.eu>
 <CN13QQX0NEA2.M6SABG46NYYN@bobo>
 <f75c2d9d-423f-f8c4-5bcd-cdea6c33e206@csgroup.eu>
Date:   Fri, 07 Oct 2022 20:59:40 +1100
Message-ID: <87k05cnecz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 20/09/2022 =C3=A0 10:56, Nicholas Piggin a =C3=A9crit=C2=A0:
>> On Tue Sep 20, 2022 at 3:01 AM AEST, Christophe Leroy wrote:
>>=20
>> This series is a nice cleanup. No comments yet but kernel/ is getting
>> pretty crowded. Should we make some subdirectories for subarch things
>> like mm has?
>>=20
>> Can do that after your series. Probably requires another merge window
>> to do it.
>>=20
>
> By the way, I'm wondering how we decide whether some code goes in=20
> arch/powerpc/kernel/ or in arch/powerpc/lib/

On a case-by-case basis? :)

I think our lib is *mostly* routines that are library like, eg. string
copy, memcpy, memcmp etc. Though there's also single step code, code
patching etc.

I guess one thing they have in common is that they're (somewhat) self
contained routines that do a specific thing, and that they are called
from various other parts of the kernel.

On the other hand code in kernel *tends* to be more larger things, like
early boot sequence, interrupt/syscall entry, module loading etc.

But really kernel is where everything lives that doesn't have anywhere
else to go, so it's a bit of a dumping ground.


Talking specifically about all these CPU files, I think we could create
an arch/powerpc/cpu for them. On x86 they have arch/x86/kernel/cpu, but
the kernel seems redundant.

With all the CPU specs, CPU setups, and dt_cpu_ftrs.c we'd have ~4500
lines that could go in arch/powerpc/cpu. Which seems like enough to
justify a directory.

cheers
