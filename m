Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF2867DCF7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 05:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjA0EuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 23:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjA0EuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 23:50:11 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B5D410BA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 20:50:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P34rJ02zQz4xGM;
        Fri, 27 Jan 2023 15:50:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1674795008;
        bh=xrXkmoW88qRFi3cS/J8wdbXij99nXqiP/sRzTWWDpHM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=oSu9/IaiVeQxufg2Zflj72HUZdDIFHIsgWMA2FUIVh88i23rPhEHjDjfq98IAp7A/
         DnaKtn7E3QgQ0B0UxRtn6kolE/ndlORgylafo/dQcvtVXTXShSTFyjJ1ND2w6HGNPM
         b1iAy2ZSuYL34vDYm48gROwv1hVnwkk97nvOrxUQ5uDbwQReN4xGwBeAS7aEyAgt3s
         UFdwxPE0NE5UHENu/vMgurJVfUw4qp3p0ZxFH7YXx8xTNdlegohom8AwoYkjIwqPcY
         YxSMnYzTyOm2lp0RWeKVwlVVI6JCWrbtfSDAjXZKfRWDMHqnFWy5xvGFsYx+l20yVi
         +2YtUaeafdUog==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Nathan Lynch <nathanl@linux.ibm.com>
Subject: Re: [PATCH] kasan: Fix Oops due to missing calls to
 kasan_arch_is_ready()
In-Reply-To: <20230126152024.bfdd25de2ff5107fa7c02986@linux-foundation.org>
References: <150768c55722311699fdcf8f5379e8256749f47d.1674716617.git.christophe.leroy@csgroup.eu>
 <20230126152024.bfdd25de2ff5107fa7c02986@linux-foundation.org>
Date:   Fri, 27 Jan 2023 15:50:01 +1100
Message-ID: <874jsctwcm.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:
> On Thu, 26 Jan 2023 08:04:47 +0100 Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
>
>> On powerpc64, you can build a kernel with KASAN as soon as you build it
>> with RADIX MMU support. However if the CPU doesn't have RADIX MMU,
>> KASAN isn't enabled at init and the following Oops is encountered.
>
> Should we backport to -stable?  If so, can we identify a suitable Fixes: target?

It would be nice if it went to stable, but I'd defer to the Kasan maintainers.

The kasan_arch_is_ready() checks went in a while back, but there wasn't
a meaningful user until the powerpc support went in, so I'd target that:

Fixes: 41b7a347bf14 ("powerpc: Book3S 64-bit outline-only KASAN support")
Cc: stable@vger.kernel.org # v5.19+

cheers
