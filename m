Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723B760DA02
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 05:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiJZDoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 23:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiJZDog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 23:44:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5002668
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 20:44:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MxvnM1dvYz4x1G;
        Wed, 26 Oct 2022 14:44:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1666755863;
        bh=TcGWZ/8i9vDAl2icjyxkCciEesQOkx/pAavjl5eoWBA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AayjD2kRxIUqP3jc+cvkhuLAvDZXJYqohWRcBduVvkSUWKf6aHZS0PGA9Y9XGtWEP
         lyn1bIRrn5vjg7iOMfBZGSzrKOIZCmXvTdgxag0v5r5gihPHJI0LJ6GqSk2WyFqy/C
         e5OAWQwHxkgng8VUtEYA9IOalD+QMFu5En6uQsTskAPfDSHdhTG4uSqVG0Ry55dlW7
         svboBrmcSXxTpGxtRobBdPgA0Ym4PnxBdN9KPS579O+ra4cJs//cypl/461uHGj8i8
         iPiBlaZ4eGaCvbgwomVkfC91hRhhNe31ha72WDXMxadAdtqk2C+968jNXCJNepuVhp
         hqhhMM9gxP0MQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: Linux 6.1-rc2
In-Reply-To: <20221025172239.GC968059@roeck-us.net>
References: <CAHk-=wgLV1tNP0EYz7qWK-xeKzO6bh5Kogbpn2wxKLPPpOit3w@mail.gmail.com>
 <20221025162441.GA1128834@roeck-us.net>
 <CAHk-=wivKoK4VgfKB8ykQUHKhNSUYA2=m4X7k8QKaizSMvzgZg@mail.gmail.com>
 <20221025172239.GC968059@roeck-us.net>
Date:   Wed, 26 Oct 2022 14:44:18 +1100
Message-ID: <878rl3tfjh.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:
> On Tue, Oct 25, 2022 at 09:41:50AM -0700, Linus Torvalds wrote:
>> On Tue, Oct 25, 2022 at 9:24 AM Guenter Roeck <linux@roeck-us.net> wrote:
>> >
>> > Build results:
>> >         total: 152 pass: 152 fail: 0
>> > Qemu test results:
>> >         total: 499 pass: 499 fail: 0
>> 
>> Woo-hoo!
>> 
>> That was quick, for once.
>> 
>
> Yes, it was. I now have an even better one, with a new personal
> milestone reached (500 qemu boot tests):
>
> Build results:
> 	total: 152 pass: 152 fail: 0
> Qemu test results:
> 	total: 500 pass: 500 fail: 0
> 	       ^^^
>
> ... after getting yet another qemu machine to boot.
>
>> > Runtime warnings
>> 
>> Oh.
>> 
>> Well, close enough, and those fixes are presumably pending too.
>> 
>
> Let's hope so. I think I forgot to copy the ppc maintainers last week,
> so we'll see if we get some feedback on the status of those problems.

I have those in my fixes-test branch. While testing one of them I
stumbled on some issues that I've been trying to confirm are existing
and not regressions.

But I plan for those fixes to hit rc3.

cheers
