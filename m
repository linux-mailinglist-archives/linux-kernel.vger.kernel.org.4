Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFD16A4F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 00:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjB0XKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 18:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0XKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 18:10:01 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FB215CA7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 15:10:00 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536b7ffdd34so221496317b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 15:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QFjaeE4eSo23upfyzVu9yFw6RjIFdreut8TNcWwSiF4=;
        b=dE9jVGLG/4tiI3x6Dm2ln1b5O0ij+v6xIJv9LjSu2Sq8avzQ5a10IA9zBy09wz78lm
         fh1mu648v/L5g/J0LjSzxqiWhzxAlc6SyMsYfjUvDPvy15L0IQYO9zspThNSRe89Qf7m
         YIHoFbp1lSLh6EBlYbN1DuXyTIiiJ3MFMmJREAp8uTb0y6nn6YY/dkurgx7MnVbEnoCN
         yXQxw0l9EzOEWsOCDUsiccJo8JXhF6c05O9dZZC2PKw8OnS4ABpoLCLTz4U1XQcOhC0e
         hCsWVNFwhpNd6lfI1BbipBoVJzqRvGWVfYt/tatONd87JuzoYtE1ygzZyNONGoFE3YBX
         eNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFjaeE4eSo23upfyzVu9yFw6RjIFdreut8TNcWwSiF4=;
        b=W32+8MmTxfOX7GPk0cMFFZKJbn280bO76z01eryJnksFwkxM66/IN2plE9DY+DH4zl
         YryicWqNNotAlyu6FmmHWRPITfUOKrPC5K6t8gzcdYKbmTAzR3MRzaZtAY83X/Ar5oP9
         /JyaSFHUEqs/3QY1w6unp7A3iQDJiqGabz6tE8kJi+SecWxeMCzzxFC/eJwe1S8xF3O5
         1rYv6Bmb5b5DIM4u+PZ0kK0dodEznkR6ph1X+J8S9NN/PlsKdbBWjMaZsXnJjo65DoP8
         DbLGKyWY0cKmNnz/xC6ZgbeX+AOQIyXNxdK0UghzGU1U/gIR0V5RNO1uWR+kpuZ/6+d5
         ZZYw==
X-Gm-Message-State: AO0yUKVXV25TF7km8cwFUriUqLP2b9pfPwaNniaM8j+2ccU45meRzKYE
        VzHTT4UcZn6x0G2yvQ6zwlTdeF6JAOglE1RRHghbsA==
X-Google-Smtp-Source: AK7set9qHVWcnczC7w/zdZpnGo7qQwK8i/JAfp2TvzaYrL306mHwychbjLxDpLl/X96ArazXBXjqTO1MX9W/D4/zI7k=
X-Received: by 2002:a25:e210:0:b0:a99:de9d:d504 with SMTP id
 h16-20020a25e210000000b00a99de9dd504mr213188ybe.12.1677539399179; Mon, 27 Feb
 2023 15:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20230227094726.3833247-1-elver@google.com> <20230227141646.084c9a49fcae018852ca60f5@linux-foundation.org>
In-Reply-To: <20230227141646.084c9a49fcae018852ca60f5@linux-foundation.org>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Feb 2023 00:09:13 +0100
Message-ID: <CANpmjNNtxW41H8ju6iog=ynMdEE0awa7GYabsuL6ZRihmVYQHw@mail.gmail.com>
Subject: Re: [PATCH mm] kasan, powerpc: Don't rename memintrinsics if compiler
 adds prefixes
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Liam Howlett <liam.howlett@oracle.com>,
        kasan-dev@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Daniel Axtens <dja@axtens.net>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 at 23:16, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 27 Feb 2023 10:47:27 +0100 Marco Elver <elver@google.com> wrote:
>
> > With appropriate compiler support [1], KASAN builds use __asan prefixed
> > meminstrinsics, and KASAN no longer overrides memcpy/memset/memmove.
> >
> > If compiler support is detected (CC_HAS_KASAN_MEMINTRINSIC_PREFIX),
> > define memintrinsics normally (do not prefix '__').
> >
> > On powerpc, KASAN is the only user of __mem functions, which are used to
> > define instrumented memintrinsics. Alias the normal versions for KASAN
> > to use in its implementation.
> >
> > Link: https://lore.kernel.org/all/20230224085942.1791837-1-elver@google.com/ [1]
> > Link: https://lore.kernel.org/oe-kbuild-all/202302271348.U5lvmo0S-lkp@intel.com/
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Seems this is a fix against "kasan: treat meminstrinsic as builtins in
> uninstrumented files", so I'll plan to fold this patch into that patch.

Yes, that looks right.

If a powerpc maintainer could take a quick look as well would be good.
The maze of memcpy/memmove/memset definitions and redefinitions isn't
the simplest - I hope in a few years we can delete all the old code
(before CC_HAS_KASAN_MEMINTRINSIC_PREFIX), and let the compilers just
"do the right thing".

Thanks,
-- Marco
