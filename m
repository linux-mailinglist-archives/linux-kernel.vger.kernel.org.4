Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1286DF8CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjDLOkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjDLOkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:40:09 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C789ECC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:39:45 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e127so11948807ybf.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681310382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pKFL1ied8XK1n0xf5sr2x4G8CCMOMqbda58ygnphsg=;
        b=tz7PxQgn6gzQz8HEG3T6gvJ1HxHfF3bb8fwFZIv6Cn/XdL2siEFBe9pzWmztQ8VsoO
         +9lTgLTZPHW5NhSVSX33SjwYogn7QD4PDjD7d874V8InAIaf+8PLFCxl5L/cxX5/Herq
         M8BKWoAUmKF5bMqjjiKWYA6tDGpJDEa7WBTjQtRL6VZ3lm5EI8Msj33G6WJgVRw5IdEf
         Z+WUOexqL5HPy+trtcMaB+LyVliDjjquWbzM50gPknAA004/W4eIlAisQ/57c+cefLNr
         b195g1wLW7xO3QCNuthF0ycpEYOLhZlgMJVVNB+ImGcQGiBT6b/zyu6PfTMWwEI+2TqK
         sicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681310382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pKFL1ied8XK1n0xf5sr2x4G8CCMOMqbda58ygnphsg=;
        b=7bRMbcRDcuMIQpHBUw0Vh1FmhmlOwNdV4sH6ButUdy0wN04Fna5Gd+xok028rqH7tl
         zERcw4UQ6g9Mf8Wt63PPSLjgYxegQEegobsxIGG+CnZJVxEOP8QfZOAK7mha+xcfht2/
         gR/y67osDqa4HMDvr9mBj4xZXRhSp18oxRCPsbOpw1R7exqqOlGN9ttgBfHrahvWbVqq
         zAeaNTdeYQsrqZCLShAoTb4bstQ34256pfGIVNVeXA8zJ8dJdtx/WITlK6ZiceSs+Jvi
         sXokM9xhM2/PoM34gIHJliHNobTl+t720kaeBzKBJzUSG6MVZwuZtX6roYwaWQXbByfG
         9TTQ==
X-Gm-Message-State: AAQBX9c6QEE9EQE+su/ZceUOi2RFgzA9lal0pMxWbJaOYzraaSJe6TOG
        zL/WjHTwdhzZ4TqQT8ecvjcVv56Z9Tjn4bNHYDi72g==
X-Google-Smtp-Source: AKy350bM2d+cGoRLEt4LS9dBT2iR+dDtIsW8oTA5rF12QIkmhn/JAZ3KqEkmO1U+uTtlgBXN4JBf6viLTfXuUR782MA=
X-Received: by 2002:a25:ada1:0:b0:b67:412e:a81e with SMTP id
 z33-20020a25ada1000000b00b67412ea81emr16250857ybi.17.1681310382532; Wed, 12
 Apr 2023 07:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <CANX2M5ZRrRA64k0hOif02TjmY9kbbO2aCBPyq79es34RXZ=cAw@mail.gmail.com>
In-Reply-To: <CANX2M5ZRrRA64k0hOif02TjmY9kbbO2aCBPyq79es34RXZ=cAw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 12 Apr 2023 16:39:05 +0200
Message-ID: <CAG_fn=V57m0om5HUHHFOQr9R9TWHtfm4+jO96Smf+Q+XjRkxtQ@mail.gmail.com>
Subject: Re: Possible incorrect handling of fault injection inside KMSAN instrumentation
To:     Dipanjan Das <mail.dipanjan.das@gmail.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Marius Fleischer <fleischermarius@googlemail.com>,
        Priyanka Bose <its.priyanka.bose@gmail.com>
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

On Sat, Apr 8, 2023 at 5:51=E2=80=AFPM Dipanjan Das <mail.dipanjan.das@gmai=
l.com> wrote:
>
> Hi,

Hi Dipanjan, thanks a lot for the elaborate analysis!


> kmsan's allocation of shadow or origin memory in
> kmsan_vmap_pages_range_noflush() fails silently due to fault injection
> (FI). KMSAN sort of =E2=80=9Cswallows=E2=80=9D the allocation failure, an=
d moves on.
> When either of them is later accessed while updating the metadata,
> there are no checks to test the validity of the respective pointers,
> which results in a page fault.

You are absolutely right.

> Our conclusions/Questions:
>
> - Should KMSAN fail silently? Probably not. Otherwise, the
> instrumentation always needs to check whether shadow/origin memory
> exists.

KMSAN shouldn't fail silently in any case.
kmsan_vmap_pages_range_noflush() used to have KMSAN_WARN_ON() to catch
such cases, but unfortunately I've failed to check the return values
of the kcalloc() calls.

> - Should KMSAN even be tested using fault injection? We are not sure.

At least our deployment of KMSAN on syzbot uses fault injection, so
having the two play well together is important.

> On one hand, the primary purpose of FI should be testing the
> application code. But also, inducing faults inside instrumentation
> clearly helps to find mistakes in that, too.

At first I had an idea of having a special GFP flag that prohibits
fault injections for the tool's allocations.
But this would just shift the allocations failures right, making them
harder to detect, because they will occur less often.
We'd better handle the failures properly instead.

> - What is a fix for this? Should a failure in the KMSAN
> instrumentation be propagated up so that the kernel allocator
> (vzalloc() in this case) can =E2=80=9Cpretend=E2=80=9D to fail, too?

Yes, I think so.
Here are two patches that fix the problem:
 - https://github.com/google/kmsan/commit/b793a6d5a1c1258326b0f53d6e3ac8aa3=
eeb3499
- for kmsan_vmap_pages_range_noflush();
 - https://github.com/google/kmsan/commit/cb9e33e0cd7ff735bc302ff69c02274f2=
4060cff
- for kmsan_ioremap_page_range()

Can you please try them out?

Alex
