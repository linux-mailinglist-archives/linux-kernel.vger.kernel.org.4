Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A38B69A7E4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjBQJLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBQJLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:11:38 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18481EFF5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:11:37 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id g1so216253ioe.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Wm0umPVZ0DPbMR0SC6Fc8s0kVXs3TVj3JMgvwdynUc=;
        b=E1ro5b2E81eIiwPEwmuiOWcZqlJcgz8FSDemCwstdjwIk6VMZf5JSv6567JqEdm3lo
         QcuhlruFSoTqHO1SCXWO56tFqPdOQOOg7K6Lopcy+SuUNudcn6dk2hcnRsezcASEze/b
         ivxB7MWiDw4qHjP5MzwTVwjAJEsiPSxQ52p+GfHokqI2kxv+9EuiCqBlB96QcdJb12hJ
         hOMLTYZP043WftuiWHLOfkiVk83Y0uf6XA56DwLIiTLoYTVRd5qt3dauLuR9doklXMcD
         w9CDxk4jBll8wGXRcToLS/dPRWYJ7z8nQLGRKhWQaNGoey/Cuw/z2AUHN5kW/CVjmjyR
         5fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Wm0umPVZ0DPbMR0SC6Fc8s0kVXs3TVj3JMgvwdynUc=;
        b=bWWCI8EYgQJFljP75MEoRO9tEIwI3ZvA+p9IA93akqjplAYYB4zySdTJHovXoasoA0
         4BpuWg8O1oabF/Z/Ha0tJof1gaORyN3oSOpdk0YRctJTOBIpqmrF0Cq0+vjokGVAnHWn
         NKXHDOOnZk6gJM/PoldJAhPt+ji90nfT3D9qhxeJW0g2P003/u73yJvE+e8PZ7DsNDDC
         CVMgTjkGZUiBxCLxyUVdXjQCHmEgaLiBe9VaAmZ0mpvMuoISw0U7ElDnGPQAO7KeF/oA
         ZmYBNoWgJ8M/FJTIgz9gcd+924EhGfVxDdMEw9tEdPvgWx9yIJEdMIoFsZlpOoaB75aE
         /V7Q==
X-Gm-Message-State: AO0yUKWLT/0cTJslUSlilgkiXnaRl1pIO7HxYMmIHX4x91l7Qn0UBAWh
        DREzS3xT95ELRiBXD2rP0aYsmviTYNDoBiIKoSm11A==
X-Google-Smtp-Source: AK7set+JODGnHt30HQ5GaftVO6/VXO8N/bXVXgwVLyXxj6TP1Kq6r1WjJdUyMn9cHCZfIqRkqi7luHeXWavUN0/WnKQ=
X-Received: by 2002:a5d:9859:0:b0:6de:383e:4146 with SMTP id
 p25-20020a5d9859000000b006de383e4146mr2600092ios.48.1676625097139; Fri, 17
 Feb 2023 01:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20230216234522.3757369-1-elver@google.com> <20230216234522.3757369-3-elver@google.com>
In-Reply-To: <20230216234522.3757369-3-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 17 Feb 2023 10:11:00 +0100
Message-ID: <CAG_fn=XPn-gp+FVZi3nERgMq5HzZ6K4Z21sqZ0+BwrAbfCpa2Q@mail.gmail.com>
Subject: Re: [PATCH -tip v4 3/3] kasan: test: Fix test for new meminstrinsic instrumentation
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        linux-toolchains@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Feb 17, 2023 at 12:45=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
>
> The tests for memset/memmove have been failing since they haven't been
> instrumented in 69d4c0d32186.
>
> Fix the test to recognize when memintrinsics aren't instrumented, and
> skip test cases accordingly. We also need to conditionally pass
> -fno-builtin to the test, otherwise the instrumentation pass won't
> recognize memintrinsics and end up not instrumenting them either.
>
> Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() funct=
ions")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Marco Elver <elver@google.com>
Tested-by: Alexander Potapenko <glider@google.com>

Now the tests pass with Clang-17 and are correctly skipped with GCC-12.
