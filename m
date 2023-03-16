Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788306BDBF2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCPWtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCPWtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:49:04 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5DBB75B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:48:59 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id t129so1505887iof.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679006939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gxr240v7gPTttE+NPLSA84Q9E6emq53Syi5SVB2+hgU=;
        b=ADu4GbHaErlrOn0VmVYPpIMKX5Zqy2fcRK+6i6Bqjfj4gjh1PNDY94sbkf8tssn95g
         BYrOfR5ONrGboCnUY8prbwyzRYVLUGR1wHq3Wb46NnQOa46KT/VECOqelGgbK8Fe+NMJ
         Iz7KE+EnBfBNp0PIaPN752kzqZhe2MbQrFIaoKFs064grmcITMVJkP5QDij30fLT5oBs
         DwBZFMwRaHskwcxkzteuDcExPAHp66elMbVDLz8o6NPxXR4SlF8QBxNP35BPBZnzz+i5
         1Ti0uKXIo0DAoMLq7I6mkbMYeKZkLWGTFq2ojDkdNuZEi5ZZGmagvwTFEGV3YeBIBLCf
         ODiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679006939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gxr240v7gPTttE+NPLSA84Q9E6emq53Syi5SVB2+hgU=;
        b=ZitbUwarfLHYPxQIX1UKrnbqpMbCUXzxCOV4x0AcZpTAsbePwHulPgQvsqMEt+pVp+
         HY0tVzpnjYyv1hxcv0KZdmLzogAt6YkAJj/LfPyBNiAsfXKzQF1GAe/cTaLqeBScT7xU
         Mwob20iJ1MI5Uc4FLEKVoQ1TLF91xPepbjImH5dCRuFGufaO9pD/mbWW5564sV6tfHCM
         BMnKIxwZzgEAGfTWqfV8FhbNUCEUlLPzWDxpBoqiQQGStig9PBmsIvVYgSGq0kTIvkJP
         xveN2CMP+B+AYhpFhvhJkEZWTEI81Y4N4OtsJ1wOapFSjnbTHcE/yALDG3THeHfq0e8w
         Ko6g==
X-Gm-Message-State: AO0yUKUumiun7arYpr6FNMb5EGIX/DkbimhRgeEocPBaSFuDpIO7FV/s
        pnPCKJJgN4IRVxvMqV7o7v3b1VtMtSiwnRI5b/e0MKA6ExqPaZejPpk=
X-Google-Smtp-Source: AK7set/+QGT+zp/m9OIPmBdmW5Wf2XkrsV6D8oXdPUwkZGggZmYAUbh6m4uhfMEPWmVTSHCdOvuqn7BR9TPWZ6YANdY=
X-Received: by 2002:a05:6602:228d:b0:74c:8c3c:b71 with SMTP id
 d13-20020a056602228d00b0074c8c3c0b71mr533639iod.12.1679006939131; Thu, 16 Mar
 2023 15:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230316155104.594662-1-elver@google.com> <20230316153354.bc31b9583eae6a79a1789de0@linux-foundation.org>
In-Reply-To: <20230316153354.bc31b9583eae6a79a1789de0@linux-foundation.org>
From:   Marco Elver <elver@google.com>
Date:   Thu, 16 Mar 2023 23:48:15 +0100
Message-ID: <CANpmjNNqmRa3qYPoWcfe=FQXtJvLU5xN05hnZTjo4-cG9B984A@mail.gmail.com>
Subject: Re: [PATCH] kfence, kcsan: avoid passing -g for tests
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nathan Chancellor <nathan@kernel.org>
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

On Thu, 16 Mar 2023 at 23:33, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 16 Mar 2023 16:51:04 +0100 Marco Elver <elver@google.com> wrote:
>
> > Nathan reported that when building with GNU as and a version of clang
> > that defaults to DWARF5:
> >
> >   $ make -skj"$(nproc)" ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- \
> >                       LLVM=1 LLVM_IAS=0 O=build \
> >                       mrproper allmodconfig mm/kfence/kfence_test.o
> >   /tmp/kfence_test-08a0a0.s: Assembler messages:
> >   /tmp/kfence_test-08a0a0.s:14627: Error: non-constant .uleb128 is not supported
> >   /tmp/kfence_test-08a0a0.s:14628: Error: non-constant .uleb128 is not supported
> >   /tmp/kfence_test-08a0a0.s:14632: Error: non-constant .uleb128 is not supported
> >   /tmp/kfence_test-08a0a0.s:14633: Error: non-constant .uleb128 is not supported
> >   /tmp/kfence_test-08a0a0.s:14639: Error: non-constant .uleb128 is not supported
> >   ...
> >
> > This is because `-g` defaults to the compiler debug info default. If the
> > assembler does not support some of the directives used, the above errors
> > occur. To fix, remove the explicit passing of `-g`.
> >
> > All these tests want is that stack traces print valid function names,
> > and debug info is not required for that. I currently cannot recall why I
> > added the explicit `-g`.
>
> Does this need to be backported into earlier kernels?
>
> If so, we'd need to do it as two patches, each with the relevant
> Fixes:, which appear to be a146fed56f8 and bc8fbc5f30.

Good point - sent
https://lkml.kernel.org/r/20230316224705.709984-1-elver@google.com

Thanks,
-- Marco
