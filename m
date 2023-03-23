Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AEA6C6131
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjCWH60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjCWH6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:58:24 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998DBBDEE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:58:22 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id f23so9072884vsv.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679558301;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qy+avBLXTpqBs7wiLv4nHuWGknSEznmW36KI6MrLqak=;
        b=XXv51V0gWpl8UrC6TIbTl/Nsx6t1lMItjiNjdwnbK9G4GQZp7r518YdFtkkZfQSPm9
         5t9QmO87cXoLBPZLjE3ffFYfiBMh+Fzm6ag1FApovASZRizeFttP6VTDwDXgEGg8I4Ca
         EddOmS1e/8vj2F8EbdMEOfwPPFUMD1MokOKMj9f7Dt9Hk/NDbPIGRmDQecaBhAJcOt9Q
         rPib6lHQTRdROEuAVn3L0u+JUOVvC6/de6EoHu3VbJ6mUVk0MDY0Ve3mrS9A6puCpPuM
         ET3o27jrpGF9MUtaHfpIeBs6ikBzbwd3edyrpPfB6Lln/1NOrpySifRo0QhlnRZoqFaS
         /xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679558301;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qy+avBLXTpqBs7wiLv4nHuWGknSEznmW36KI6MrLqak=;
        b=naa4+IwsN0as//Ht7lV8bpmGY9nG33XZ4HwDA+0tVcYkd5Nx5m7DX+sskiIobaNhjm
         EY9BxhfXStLlItM11/0AGIwmvwV3w7y/Ij+k86yZ09Q8W7G0d9NYZ5R76uClB1p03Ldz
         e/ju7avUktq3xivbiKwE00EQlwxV+jUUdKTg8mRUPcBzzYxpFjRmP4kJijH5Rhg0/4bd
         Eii0HQnRZad0LA3GrQyzRtizGx3ag8aGo8WW56/N2k5bsRy5UjNiKP34wpelHF+La7jS
         X9YOECquxA56aooYNYDZcqWCxfQdhWXwy5ZivQ2Ku73yNYN7jzmoXsCu9ltIRmPb1B8e
         RmGA==
X-Gm-Message-State: AO0yUKVGrGSgR/KgqJGw3qziPOfdnayds5XWa9+6qjS498nvCpj7FiUx
        HbxU1Oo2N+y9tTu9AzWkTu7uanZoJu8jscH+tw7/Kw==
X-Google-Smtp-Source: AK7set+2jSxcjk2ShsjiG4KrocUujp4Queqnqp3zqlHipOMcCbLh4yZmFjwK6WEb+j/oACpaL/fM0x6CwZsXKs06MIQ=
X-Received: by 2002:a67:d20f:0:b0:426:392a:92bc with SMTP id
 y15-20020a67d20f000000b00426392a92bcmr1341687vsi.1.1679558301631; Thu, 23 Mar
 2023 00:58:21 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 23 Mar 2023 13:28:10 +0530
Message-ID: <CA+G9fYvEqk8tC7w3xxPcFhycctZeOj4CMJj3JbrtWKkp3w9qPQ@mail.gmail.com>
Subject: mm/mmap.c:939:11: error: variable 'next' is used uninitialized
 whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following multiple build warnings / errors noticed while building
Linux next-20230323 with clang-16 for x86_64.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build warnings / errors:
---------
mm/mmap.c:939:11: error: variable 'next' is used uninitialized
whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        else if (!curr)
                 ^~~~~
mm/mmap.c:952:15: note: uninitialized use occurs here
        merge_next = next && mpol_equal(policy, vma_policy(next)) &&
                     ^~~~
mm/mmap.c:939:7: note: remove the 'if' if its condition is always true
        else if (!curr)
             ^~~~~~~~~~
mm/mmap.c:912:36: note: initialize the variable 'next' to silence this warning
        struct vm_area_struct *curr, *next, *res;
                                          ^
                                           = NULL
1 error generated.
make[3]: *** [scripts/Makefile.build:252: mm/mmap.o] Error 1

mm/vmalloc.c:3543:6: error: variable 'remains' is used uninitialized
whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/vmalloc.c:3587:17: note: uninitialized use occurs here
        return count - remains + zero_iter(iter, remains);
                       ^~~~~~~
mm/vmalloc.c:3543:2: note: remove the 'if' if its condition is always false
        if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/vmalloc.c:3539:6: error: variable 'remains' is used uninitialized
whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (!vb)
            ^~~
mm/vmalloc.c:3587:17: note: uninitialized use occurs here
        return count - remains + zero_iter(iter, remains);
                       ^~~~~~~
mm/vmalloc.c:3539:2: note: remove the 'if' if its condition is always false
        if (!vb)
        ^~~~~~~~
mm/vmalloc.c:3524:16: note: initialize the variable 'remains' to
silence this warning
        size_t remains, n;
                      ^
                       = 0
2 errors generated.
make[3]: *** [scripts/Makefile.build:252: mm/vmalloc.o] Error 1
make[3]: Target 'mm/' not remade because of errors.

steps to reproduce:
----------

tuxmake  \
  --runtime podman \
  --target-arch x86_64 \
  --toolchain clang-16 LLVM=1 LLVM_IAS=1 \
  --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2NOjxURhByyb4dR3Ld788iuYvAR/config

Related discussion on mailing list,
 - https://lore.kernel.org/llvm/202303231055.DeninwHS-lkp@intel.com/
 - https://lore.kernel.org/llvm/14c60785-2427-45db-9613-683410ff6802@lucifer.local/T/#t


--
Linaro LKFT
https://lkft.linaro.org
