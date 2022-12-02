Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B2E640DF6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiLBSyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiLBSyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:54:12 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5AC6357
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:53:57 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id s16so2444588iln.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 10:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+IlkcihNFHJyA3n7MDxRBqeitYBTuuPEepu2A5KGxpo=;
        b=ChOQbsqjv5s3kpubStmmCeD7p+nYw4dFq21Uq+Pn2ZWPWGP2y5GChi+rqb0ge/W0qv
         lXQRtP1tWLiqYErWMyuFfFcrZ8ZABBVrn4ztZB7J2OgWBEXuhsW1esZ+10XhRMTySn/T
         fp4WvyoUynBGtcqkSF/wjQFiKkVrgXtc2xl89Cigay+U0ZfjiYX6kuGehY8FJxGwiqYt
         3QocLqiifLcpLETZitEu6IVCJjLEJi+/azAG32sN02AbHkGZNTEm1W3Xp6Oits3mUWbw
         c/1oWW0+jjgA1A2J2BVOjoI90D775jvoheZ5Lsmq1NWy7KGWIHGBuE31r6JrbivrliDV
         CaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IlkcihNFHJyA3n7MDxRBqeitYBTuuPEepu2A5KGxpo=;
        b=bn/7fKWguy2uS9U5Tipw08TOqY73Ex+D4hGcbT5k36jtIAo/JICa79vHp6bwhbX9j/
         Pe82iV5IAb1rlaIs+I/XyVjuHfiFOm5IpZD/rkhmCwFfE7xWdlJDJtQvvqt42pXrGSqJ
         DmS6ZJqcDYnigAVu2UtbYNqo8JBW+XNNBVKtcwflyqbPHruMuzlS1lq62CJ7bluRL5tX
         5jGz6JVZuMSzTPI2kbAAONnZPmWncLstfP/IjbrDOjvdx35Du6wzbwUFzhMvnZ5zXEb9
         YcHip9HRVFFhncN3L91Mp5DeOwxbiw/OPe1WB6MrmkTQzK3aWaUb/7EY++pRGps1vOG3
         evTA==
X-Gm-Message-State: ANoB5plW8Gfc2Fc8AO+1GK7OEh4JNmrDY2hDeUEG7alr/+YSOeVhadL9
        vQxX8lWaBhQf9sJIgDXSDLjlsyV/SyInnvz2SndF0A==
X-Google-Smtp-Source: AA0mqf68pjoJ4fPsShveu0rA+Q2e2QNgJwdW7H4KfqQ1EkpcK8XqnVRjhl/Lc3DbxUbuPp7SrHdcS4P+kwGWLKHDoP8=
X-Received: by 2002:a92:6809:0:b0:2f9:4d92:5b2a with SMTP id
 d9-20020a926809000000b002f94d925b2amr24339211ilc.177.1670007236288; Fri, 02
 Dec 2022 10:53:56 -0800 (PST)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Dec 2022 19:53:20 +0100
Message-ID: <CAG48ez1tJZTOjS_FjRZhvtDA-STFmdw8PEizPDwMGFd_ui0Nrw@mail.gmail.com>
Subject: brk() in v6.1-rc1 can expand file mappings, seemingly without taking
 file locks
To:     Linux-MM <linux-mm@kvack.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Jason Donenfeld <Jason@zx2c4.com>, Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
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

As of commit ca57f02295f, brk() can expand ordinary file mappings (but
not file mappings with weird flags), and I think it does it with
insufficient locks. I think brk() probably needs some extra checks to
make sure it's operating on a brk-like VMA (which means it should at
least be anonymous, and perhaps pass the full can_vma_merge_after()
check so that we're not creating unnecessary special cases?).

user@vm:~/brk_stretch$ cat brk_file.c
#define _GNU_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <err.h>
#include <stdlib.h>
#include <malloc.h>
#include <sys/auxv.h>
#include <sys/mman.h>
#include <sys/syscall.h>

#define SYSCHK(x) ({          \
  typeof(x) __res = (x);      \
  if (__res == (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

int main(void) {
  mallopt(M_MMAP_THRESHOLD, 0);

  void *brk_space = sbrk(0x2000);
  if (brk_space == NULL)
    errx(1, "sbrk() fail");
  printf("brk_space = %p\n", brk_space);
  int fd = SYSCHK(open("/etc/services", O_RDONLY));
  void *map = SYSCHK(mmap(brk_space, 0x2000, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED, fd, 0));

  /* stretch */
  if (sbrk(0x111000) == NULL)
    err(1, "sbrk");
  printf("sbrk() success\n");

  system("cat /proc/$PPID/maps");

  return 0;
}
user@vm:~/brk_stretch$ gcc -o brk_file brk_file.c
user@vm:~/brk_stretch$ ./brk_file
brk_space = 0x557f71b5d000
sbrk() success
557f70616000-557f70617000 r--p 00000000 fd:00 2752938
  /home/user/brk_stretch/brk_file
557f70617000-557f70618000 r-xp 00001000 fd:00 2752938
  /home/user/brk_stretch/brk_file
557f70618000-557f70619000 r--p 00002000 fd:00 2752938
  /home/user/brk_stretch/brk_file
557f70619000-557f7061a000 r--p 00002000 fd:00 2752938
  /home/user/brk_stretch/brk_file
557f7061a000-557f7061b000 rw-p 00003000 fd:00 2752938
  /home/user/brk_stretch/brk_file
557f71b5d000-557f71c70000 rw-p 00000000 fd:00 2621496
  /etc/services
7fd67993d000-7fd67995f000 r--p 00000000 fd:00 527268
  /usr/lib/x86_64-linux-gnu/libc-2.28.so
7fd67995f000-7fd679aa6000 r-xp 00022000 fd:00 527268
  /usr/lib/x86_64-linux-gnu/libc-2.28.so
7fd679aa6000-7fd679af2000 r--p 00169000 fd:00 527268
  /usr/lib/x86_64-linux-gnu/libc-2.28.so
7fd679af2000-7fd679af3000 ---p 001b5000 fd:00 527268
  /usr/lib/x86_64-linux-gnu/libc-2.28.so
7fd679af3000-7fd679af7000 r--p 001b5000 fd:00 527268
  /usr/lib/x86_64-linux-gnu/libc-2.28.so
7fd679af7000-7fd679af9000 rw-p 001b9000 fd:00 527268
  /usr/lib/x86_64-linux-gnu/libc-2.28.so
7fd679af9000-7fd679aff000 rw-p 00000000 00:00 0
7fd679b16000-7fd679b18000 rw-p 00000000 00:00 0
7fd679b18000-7fd679b19000 r--p 00000000 fd:00 527258
  /usr/lib/x86_64-linux-gnu/ld-2.28.so
7fd679b19000-7fd679b37000 r-xp 00001000 fd:00 527258
  /usr/lib/x86_64-linux-gnu/ld-2.28.so
7fd679b37000-7fd679b3f000 r--p 0001f000 fd:00 527258
  /usr/lib/x86_64-linux-gnu/ld-2.28.so
7fd679b3f000-7fd679b40000 r--p 00026000 fd:00 527258
  /usr/lib/x86_64-linux-gnu/ld-2.28.so
7fd679b40000-7fd679b41000 rw-p 00027000 fd:00 527258
  /usr/lib/x86_64-linux-gnu/ld-2.28.so
7fd679b41000-7fd679b42000 rw-p 00000000 00:00 0
7ffd58087000-7ffd580a8000 rw-p 00000000 00:00 0                          [stack]
7ffd581fa000-7ffd581fe000 r--p 00000000 00:00 0                          [vvar]
7ffd581fe000-7ffd58200000 r-xp 00000000 00:00 0                          [vdso]
user@vm:~/brk_stretch$

The codepaths that are intended to expand file VMAs do stuff like
i_mmap_lock_write() and vma_interval_tree_remove(), which
do_brk_flags() doesn't seem to do (because it was never intended to
operate on file VMAs?).
