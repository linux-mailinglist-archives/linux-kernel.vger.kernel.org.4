Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EAC6DBC04
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 17:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjDHPvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 11:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDHPvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:51:44 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8110FEFB9
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 08:51:37 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1842f69fe1fso1365339fac.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 08:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680969097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xbMqxWkswZ+j8vnTKs/LDwFFKDpT5yB5iqVFJaXrdK0=;
        b=f47is1vb+JbkCQQfIXJ2m/c93n99bT/X424DtFyIruIHTQ6UWgZpe2Viw/V4xL2pLT
         gOIi7DNETja0ezD/QuncBUzcOum0e4Pb/g6Lkewu6wb0UdDlJzpWuIRCmOeuYtGE0EJK
         5pkSmr0Y7HXrWawBdYBZZ8SHURQMA9w88I7UbDbUT9YCfFPSEl81eU6jkCh+ge06inVv
         P3jkP3n22C9zEmL6z3NzsfyYyGoMDv6e3LeHnDm73MVI25MmB+x92HuypFZQlricaw2x
         rn3Qo1qtu/5/94Xt2XEasV2gWuDj3BEpokdA5OtJfXV6FTOEmjCabGcAXmSbFfvt2Wpb
         kTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680969097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbMqxWkswZ+j8vnTKs/LDwFFKDpT5yB5iqVFJaXrdK0=;
        b=eRevl3o6K/v7ZzZyTA25GG/hUoNIMJiH8gkpkpqIFDLrHkF5cVszt1MeRKszvTqiHr
         G7qOOXDwL9m6Kow2sAbYwsARd/VwxtWMEYIcn3j5eQJG916y5N6rBOVW5VSvFNz7r5OX
         UZybG1VRJpsXcDhclqeM5NS194wrkbV0GISIMRd9d0KnGvwcBI9mF8lWaxJOoOGH5clY
         r1UcKw+ImUacPmKrbB52JjXRg5o1GwcUEbCdh/4UUbnBieEoZ3VS9y/v/SIwq1e8k7/J
         rbnyV1sy9UUhbtclzuMJN7OvIkVRaEIdqMQAg4tbiCiUzKHu/5zto7IhHkMS3mRLEru1
         XlZA==
X-Gm-Message-State: AAQBX9e2x94pYPxRgz93pbpnEa1zDFHzkg8pvZKi62ZDfeEcUPOV73ND
        h0Z+ZZhyr8q2s1d9N5QdbqO1bE0RZG0SrEB6Stw=
X-Google-Smtp-Source: AKy350baogKz7qZ8DoqJQN/5M78y5On02n0InjTOAKSGKWAb3fNiOkPdlXCbi9UZCyTTVpjaYDSiWJOCsgNgFn6RMbQ=
X-Received: by 2002:a05:6870:4184:b0:184:1a2c:83df with SMTP id
 y4-20020a056870418400b001841a2c83dfmr2001463oac.4.1680969096727; Sat, 08 Apr
 2023 08:51:36 -0700 (PDT)
MIME-Version: 1.0
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Sat, 8 Apr 2023 08:51:26 -0700
Message-ID: <CANX2M5ZRrRA64k0hOif02TjmY9kbbO2aCBPyq79es34RXZ=cAw@mail.gmail.com>
Subject: Possible incorrect handling of fault injection inside KMSAN instrumentation
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Marius Fleischer <fleischermarius@googlemail.com>,
        Priyanka Bose <its.priyanka.bose@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We would like to report a =E2=80=9Cpotential=E2=80=9D bug in the KMSAN inst=
rumentation
which has been found during the root-cause analysis of another bug
discovered by our modified version of syzkaller.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
description: Possible incorrect handling of fault injection inside
KMSAN instrumentation
affected file: mm/kmsan/shadow.c
kernel version: 6.2.0-rc5
kernel commit: 41c66f47061608dc1fd493eebce198f0e74cc2d7
git tree: kmsan
kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3Da9=
a22da1efde3af6.
The config has Fault Injection (FI) turned on, which is important in
this case.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
We reported the =E2=80=9Csupposed=E2=80=9D bug discovered by our fuzzer her=
e:
https://groups.google.com/u/1/g/syzkaller/c/_83qwErVKlA. Initially, we
presumed that the vzalloc() call (refer to Jiri Slaby=E2=80=99s comment on
that thread) fails due to fault injection (refer to the reproducer
attached). However, we were confused to see that the allocation
failure triggers a crash, though clearly the driver code checks for
allocation failures. Nonetheless, we reported the crash to the
developers. Following Jiri=E2=80=99s comments, who evidently had the same
impression as ours, we started investigating. Below is our
observation.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
TL;DR:

kmsan's allocation of shadow or origin memory in
kmsan_vmap_pages_range_noflush() fails silently due to fault injection
(FI). KMSAN sort of =E2=80=9Cswallows=E2=80=9D the allocation failure, and =
moves on.
When either of them is later accessed while updating the metadata,
there are no checks to test the validity of the respective pointers,
which results in a page fault.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Detail explanation:

- In drivers/tty/n_tty.c:1879 (n_tty_open) , the driver calls vzalloc
to allocate memory for ldata.

- This triggers the KMSAN instrumentation to allocate the
corresponding shadow and origin memory in mm/kmsan/shadow.c:236
(kmsan_vmap_pages_range_noflush) .

- This allocation of the shadow memory fails (through fault
injection). KMSAN checks for failure, frees the allocated memory and
returns. Note: There is no return value signaling the error.
Additionally, the pages for shadow and origin memory are not mapped at
the addresses where KMSAN expects them to be (in fact, there are no
pages that could be mapped at all since the allocation failed).

- The allocation of the actual memory for the driver is successful.
Therefore, vzalloc (from 1.) returns a valid pointer (not NULL).

- After checking that the allocation succeeded
(drivers/tty/n_tty.c:1880), the driver tries to dereference ldata and
write to one of the fields at drivers/tty/n_tty.c:1883 (n_tty_open).

- This triggers the KMSAN instrumentation to update the shadow/origin
memory according to the write by calling
__msan_metadata_ptr_for_store_8  which subsequently calls
mm/kmsan/shadow.c:81 (kmsan_get_shadow_origin_ptr).

- Since the address that the driver is trying to access is with the
vmalloc range, this function will only calculate the offset of this
pointer from the base of the vmalloc range and add this to the base of
the shadow/origin memory range to retrieve the pointer for the
corresponding shadow/origin memory. Note: there are no checks ensuring
that this memory is actually mapped.

- Next, after the return of __msan_metadata_ptr_for_store_8 , the
instrumentation will try to update the shadow memory (or origin, we
are not entirely confident which of the two. We think it is the
shadow, but it also does not really change anything). Since this
memory is not mapped, it leads to the crash.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Our conclusions/Questions:

- Should KMSAN fail silently? Probably not. Otherwise, the
instrumentation always needs to check whether shadow/origin memory
exists.

- Should KMSAN even be tested using fault injection? We are not sure.
On one hand, the primary purpose of FI should be testing the
application code. But also, inducing faults inside instrumentation
clearly helps to find mistakes in that, too.

- What is a fix for this? Should a failure in the KMSAN
instrumentation be propagated up so that the kernel allocator
(vzalloc() in this case) can =E2=80=9Cpretend=E2=80=9D to fail, too?

--=20
Thanks and Regards,

Dipanjan
