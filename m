Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696C46A58B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjB1L6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjB1L6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:58:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445652310C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:58:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PQwqL0WKnz4x1S;
        Tue, 28 Feb 2023 22:58:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1677585487;
        bh=T7m6rAKgrT8sjyDmNLKdZltCp4n7kd0f94FIxHvHRGw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=f5n+G1San0GWm4EURNJwqNBX5uB++CKCNw0d4OVqayAOk9X6wJ0cJNyhLbSmkqsf9
         I8TJPFTiRl0qOqMUYUC55+bFFECxTuNz91Kw9Ou3qAorl5UorGl+3CtE7vE4BzZvZs
         tyLvaxkStt6qhxCRxGt1hY9gvWqAkP3cyx831AnNmAdt00vQDCMDvAxAfVYbJ56mwm
         ScSy6Nwpi94mJ5Iv3P283KF7epzI45yiXTh0JnUJss8Odc3npkdc9osKcGtpxjDwtf
         Im+tkXG3OdgrSEejGFlh2Y16eZ5woef/IqAPThq/XOLbWzaTSMWupbn8Z9zX27C64f
         Nz4srrQ/Q4hvQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Liam Howlett <liam.howlett@oracle.com>,
        kasan-dev@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Daniel Axtens <dja@axtens.net>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH mm] kasan, powerpc: Don't rename memintrinsics if
 compiler adds prefixes
In-Reply-To: <CANpmjNNtxW41H8ju6iog=ynMdEE0awa7GYabsuL6ZRihmVYQHw@mail.gmail.com>
References: <20230227094726.3833247-1-elver@google.com>
 <20230227141646.084c9a49fcae018852ca60f5@linux-foundation.org>
 <CANpmjNNtxW41H8ju6iog=ynMdEE0awa7GYabsuL6ZRihmVYQHw@mail.gmail.com>
Date:   Tue, 28 Feb 2023 22:58:03 +1100
Message-ID: <87o7peuhmc.fsf@mpe.ellerman.id.au>
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

Marco Elver <elver@google.com> writes:
> On Mon, 27 Feb 2023 at 23:16, Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Mon, 27 Feb 2023 10:47:27 +0100 Marco Elver <elver@google.com> wrote:
>>
>> > With appropriate compiler support [1], KASAN builds use __asan prefixed
>> > meminstrinsics, and KASAN no longer overrides memcpy/memset/memmove.
>> >
>> > If compiler support is detected (CC_HAS_KASAN_MEMINTRINSIC_PREFIX),
>> > define memintrinsics normally (do not prefix '__').
>> >
>> > On powerpc, KASAN is the only user of __mem functions, which are used to
>> > define instrumented memintrinsics. Alias the normal versions for KASAN
>> > to use in its implementation.
>> >
>> > Link: https://lore.kernel.org/all/20230224085942.1791837-1-elver@google.com/ [1]
>> > Link: https://lore.kernel.org/oe-kbuild-all/202302271348.U5lvmo0S-lkp@intel.com/
>> > Reported-by: kernel test robot <lkp@intel.com>
>> > Signed-off-by: Marco Elver <elver@google.com>
>>
>> Seems this is a fix against "kasan: treat meminstrinsic as builtins in
>> uninstrumented files", so I'll plan to fold this patch into that patch.
>
> Yes, that looks right.
>
> If a powerpc maintainer could take a quick look as well would be good.

The patch looks OK to me. It builds for various configs and I did a few
test boots with KASAN enabled, everything seems normal.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)


> The maze of memcpy/memmove/memset definitions and redefinitions isn't
> the simplest - I hope in a few years we can delete all the old code
> (before CC_HAS_KASAN_MEMINTRINSIC_PREFIX), and let the compilers just
> "do the right thing".

Yeah that would be nice.

cheers
