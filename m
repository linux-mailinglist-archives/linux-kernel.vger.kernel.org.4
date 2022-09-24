Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674F75E904D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 00:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiIXWW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 18:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiIXWWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 18:22:23 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658BF40BCD
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:22:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id b5so3366473pgb.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=5XRHfXkr0Fe4SAzJoRUw8fMVykjX3P3cSngjSUsS0BI=;
        b=UMg/xlXZevAPqbw04V0IV9GiY59diX6sjJjaSMv9bzrCrshLGxxoG5aekzqI39a+z7
         dXt71TE6i9/c5Rl2BtdeeHe2H75euozjIO28dSSWmaa1Mk8utjS1Pa8S1ep/L8YAKCoJ
         p7nERFlFjWms9tV8WGjVZkJv6eLN24FPTRXE4//UlV8YdJ2P23S65pSecv9ej6ODQqlN
         flQsY5fCKXCqyUHXKOi7yRQhfZatVKKaHxvOMiwzUHRR4AhiiuHBgduc39L6zAYfzvGi
         6i8K1Oqd3VYfe5nGC3PY1Rv0IPWkAsCmwPEOJLp2ibelZeINKSJo1kzh2ogogZu8OqDX
         V5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=5XRHfXkr0Fe4SAzJoRUw8fMVykjX3P3cSngjSUsS0BI=;
        b=ww73hUwdemc+7lX+B8tel8YP1p9KIGmLHWjFtNUws5GPAvqRGaexYPoTWEfqjo7ECi
         Hy0T5Y7MXL4HcusoMgjrQoyxs1cdYiCSyQUo16GEPJ/WGH8I0YYTsmVMpcA1TjVV0ZIT
         6DMqtMOxtQGiOa6kL7gFn7gRDKcf8sjMHEomPBBzC2IxhtDnrGFLE7jJSf+1GKHI5baX
         sHdhcF4WY8XT/8vB1Ga0/+iYD58lD56Gbano70gfnwWHYVBn9ps0LYJdpHmwCgepCvTJ
         E96Y8QoEHJn0GDy7a6T+vphHwF4h6TYFGfHjjzo1aBZLjxGxpwk/5MuSR1g17RGLUjb3
         4Nlw==
X-Gm-Message-State: ACrzQf0dGjk2/pBbK+9PMY/unaebRg3Wn5yDViVAr9a0rYIINWfnkE3E
        hm26LrfECQT58Rqg8Xqsghh/yG2KtUeTRiQqIEJgi186ByGSLF80
X-Google-Smtp-Source: AMsMyM5LIIMPm0LP/Sk6kCuZaOQBucIrSAcLFwD4lkx0BZ1RjOPpAHzAJ2b3tcGH5hEV0Y57O9Wpv/VOnIT26IF0f9E=
X-Received: by 2002:a63:90c4:0:b0:438:a962:61e7 with SMTP id
 a187-20020a6390c4000000b00438a96261e7mr13153649pge.426.1664058141628; Sat, 24
 Sep 2022 15:22:21 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sun, 25 Sep 2022 03:22:10 +0500
Message-ID: <CABXGCsN8LHqz7=OSvBpKCqKdV4L_4FPXtQ32bgYveA9yP2_xiQ@mail.gmail.com>
Subject: Unable bisect issue because kernel not building from old commits
To:     ast@kernel.org, yhs@fb.com, sean.wang@mediatek.com
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I want to make bisect between commits fdaf9a5840ac and babf0bb978e3,
because after commit babf0bb978e3 Wi-Fi (mt7921e) upload speed became
limited to 170Mbps. On commit fdaf9a5840ac upload speed was 784Mbps.

But I ran into a problem that the gcc-12.2.1 compiler on my
distribution (Fedora) can't build the kernel from old commits. The
build fails with the following error:
ld: warning: arch/x86/power/hibernate_asm_64.o: missing
.note.GNU-stack section implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future
version of the linker
  MODPOST vmlinux.symvers
  MODINFO modules.builtin.modinfo
  GEN     modules.builtin
  CC      .vmlinux.export.o
  LD      .tmp_vmlinux.btf
ld: warning: arch/x86/power/hibernate_asm_64.o: missing
.note.GNU-stack section implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future
version of the linker
ld: warning: .tmp_vmlinux.btf has a LOAD segment with RWX permissions
  BTF     .btf.vmlinux.bin.o
  LD      .tmp_vmlinux.kallsyms1
ld: warning: .btf.vmlinux.bin.o: missing .note.GNU-stack section
implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future
version of the linker
ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
  KSYMS   .tmp_vmlinux.kallsyms1.S
  AS      .tmp_vmlinux.kallsyms1.S
  LD      .tmp_vmlinux.kallsyms2
ld: warning: .btf.vmlinux.bin.o: missing .note.GNU-stack section
implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future
version of the linker
ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with RWX permissions
  KSYMS   .tmp_vmlinux.kallsyms2.S
  AS      .tmp_vmlinux.kallsyms2.S
  LD      vmlinux
ld: warning: .btf.vmlinux.bin.o: missing .note.GNU-stack section
implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future
version of the linker
ld: warning: vmlinux has a LOAD segment with RWX permissions
  BTFIDS  vmlinux
FAILED: load BTF from vmlinux: Invalid argument
make: *** [Makefile:1160: vmlinux] Error 255
make: *** Deleting file 'vmlinux'


I found a commit that fixes the build:
dffbbdc2d9889670c30e07d05fc0dd712e8ad430 is the first bad commit
commit dffbbdc2d9889670c30e07d05fc0dd712e8ad430
Author: Yonghong Song <yhs@fb.com>
Date:   Mon Jun 6 23:26:21 2022 -0700

    libbpf: Add enum64 parsing and new enum64 public API

    Add enum64 parsing support and two new enum64 public APIs:
      btf__add_enum64
      btf__add_enum64_value

    Also add support of signedness for BTF_KIND_ENUM. The
    BTF_KIND_ENUM API signatures are not changed. The signedness
    will be changed from unsigned to signed if btf__add_enum_value()
    finds any negative values.

    Acked-by: Andrii Nakryiko <andrii@kernel.org>
    Signed-off-by: Yonghong Song <yhs@fb.com>
    Link: https://lore.kernel.org/r/20220607062621.3719391-1-yhs@fb.com
    Signed-off-by: Alexei Starovoitov <ast@kernel.org>

 tools/lib/bpf/btf.c      | 103 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h      |  12 ++++++
 tools/lib/bpf/libbpf.map |   2 +
 3 files changed, 117 insertions(+)


But I can't cherry pick it because there are conflicts:
$ git bisect start
status: waiting for both good and bad commits
$ git bisect good fdaf9a5840ac
status: waiting for bad commit, 1 good commit known
$ git bisect bad babf0bb978e3
Bisecting: 2687 revisions left to test after this (roughly 11 steps)
[86c87bea6b42100c67418af690919c44de6ede6e] Merge tag
'devicetree-for-5.19' of
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
$ git cherry-pick -n dffbbdc2d9889670c30e07d05fc0dd712e8ad430
Auto-merging tools/lib/bpf/btf.c
CONFLICT (content): Merge conflict in tools/lib/bpf/btf.c
Auto-merging tools/lib/bpf/libbpf.map
CONFLICT (content): Merge conflict in tools/lib/bpf/libbpf.map
error: could not apply dffbbdc2d988... libbpf: Add enum64 parsing and
new enum64 public API
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'

Are there any other options to fix the kernel build?

Thanks.


-- 
Best Regards,
Mike Gavrilov.
