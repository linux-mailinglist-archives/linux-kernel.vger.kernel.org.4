Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E3969A2B0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 00:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjBPXwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 18:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjBPXwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 18:52:51 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AFA595BC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:52:42 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id w22so2343659vsf.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676591561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r8AHC9C5MjMuHRim+xbd7khMCwzT9fB8DRzXrlAFNl0=;
        b=BWv/RC5RYRHUHlunLNk5iuHtg1N0p0f1GBnHSwDXKG4iLKqS75rNV6TSMQEgMh1COy
         K7ZFRQVDxkm7tcvHZIPunE8E5KuAhqsc2SuZq1FhAnI/9lTkvWU0KOM/XfThWs97mg5P
         0VEUd24R40T+1512zdYPTyvnuJ6PB2FwNVlNkgd/ydD9esxYX113ylMzvFzhsa03fB5O
         JbZmdcPYTCYcTytV00jqyf72ulouC2RZ5wpCsfN20xx1jWmtRF0Vq6kGKQS4S3yhD2bR
         wilXlXXBJ6uus7nvaTSZ+Kp1/FvFACMOZ4dM8ve90//R82+/uGgtYvX3RP3x6pakdUuA
         0P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676591561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8AHC9C5MjMuHRim+xbd7khMCwzT9fB8DRzXrlAFNl0=;
        b=WkB1WoUJiK+TK7onBfqyS0pF7psm6MfgVP5RsNwGC6UCUbO2dfHxlPI0Pr0gwJYiyA
         fQEl5Se0l1NP2REcLcvtM50SxIPK73Oahx+xFQJPBeUgyrucgfi0xMFarz1Ec7unE/Cc
         etHOxSIH0ycTKnG87LvwMgQAsZR//zVruZI3ngddF9LbJOmmoPkaTs8ZlHIcadPqviGp
         M17l2UO2+TvlNKAOBcvmKQ5PPODmE8iOr60T30Ua0ajLF+llHmld/L0qtf+AcmXA3Jwz
         ehXf0h3qhqKmxEb2ZVxsgl2s21F8qa5qK/hHebql8a5ll7nMUvL79n8JdgCM+5FHtqdb
         nWDQ==
X-Gm-Message-State: AO0yUKVvKzbaiGX/8lf175xFzROqXG6ye3JSMUXGgX/zGmuvOUW+6M1W
        JeuscF3Q4fr5p0WpwbMHnyAKEplpuk0NYba2ufX9Eg==
X-Google-Smtp-Source: AK7set9s0+V4GZG35TLTtCHNiSMJR5wePZ4+XXizwIrrnw3bn7L+WzNkZ1SID/jr9/iulYpYmS8AAH+NkbFgYjPqBOU=
X-Received: by 2002:a67:70c6:0:b0:412:2e92:21a6 with SMTP id
 l189-20020a6770c6000000b004122e9221a6mr1433170vsc.13.1676591560792; Thu, 16
 Feb 2023 15:52:40 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvZqytp3gMnC4-no9EB=Jnzqmu44i8JQo6apiZat-xxPg@mail.gmail.com>
 <CAG_fn=V3a-kLkjE252V4ncHWDR0YhMby7nd1P6RNQA4aPf+fRw@mail.gmail.com> <CAG_fn=VuD+8GL_3-aSa9Y=zLqmroK11bqk48GBuPgTCpZMe-jw@mail.gmail.com>
In-Reply-To: <CAG_fn=VuD+8GL_3-aSa9Y=zLqmroK11bqk48GBuPgTCpZMe-jw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 17 Feb 2023 00:52:03 +0100
Message-ID: <CANpmjNOciiDNkWDrkQ+BEgAj=rSYGQAuHVS1DTDfvPHSbAndoA@mail.gmail.com>
Subject: Re: next: x86_64: kunit test crashed and kernel panic
To:     Alexander Potapenko <glider@google.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Collingbourne <pcc@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        kunit-dev@googlegroups.com, lkft-triage@lists.linaro.org,
        regressions@lists.linux.dev,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Konovalov <andreyknvl@gmail.com>
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

On Thu, 16 Feb 2023 at 19:59, Alexander Potapenko <glider@google.com> wrote:
>
> >
> > > <4>[   38.796558]  ? kmalloc_memmove_negative_size+0xeb/0x1f0
> > > <4>[   38.797376]  ? __pfx_kmalloc_memmove_negative_size+0x10/0x10
> >
> > Most certainly kmalloc_memmove_negative_size() is related.
> > Looks like we fail to intercept the call to memmove() in this test,
> > passing -2 to the actual __memmove().
>
> This was introduced by 69d4c0d321869 ("entry, kasan, x86: Disallow
> overriding mem*() functions")

Ah, thanks!

> There's Marco's "kasan: Emit different calls for instrumentable
> memintrinsics", but it doesn't fix the problem for me (looking
> closer...), and GCC support is still not there, right?

Only Clang 15 supports it at this point. Some future GCC will support it.

> Failing to intercept memcpy/memset/memmove should normally result in
> false negatives, but kmalloc_memmove_negative_size() makes a strong
> assumption that KASAN will catch and prevent memmove(dst, src, -2).

Ouch - ok, so we need to skip these tests if we know memintrinsics
aren't instrumented.

I've sent a series here:
https://lore.kernel.org/all/20230216234522.3757369-1-elver@google.com/
