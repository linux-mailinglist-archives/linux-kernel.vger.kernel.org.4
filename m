Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA07A721FCB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjFEHkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjFEHk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:40:29 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81080AD;
        Mon,  5 Jun 2023 00:40:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6e68cc738so38472095e9.1;
        Mon, 05 Jun 2023 00:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685950826; x=1688542826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUyEfMhLLTzApUSuVw0hL9LIb5HjNC0r0IZHse6dF0M=;
        b=p5lUl0sH3PapCIVuk0Rj1akMOgctzNNB3D3OJofCBHt+j/2cWSwcFpv5bHyH8MMYC1
         ntXW0x58YUQL0NOPL7ConfVn3v3V7phyZUHpB7ueU0hbyWBBFKp6nTr+MVxW6QbSAgJI
         E0PJRKzdXQDw6Rc7XEIMljMq6+ABvQ7GomvdqcO8wtUjeVLdJHA5NYWlTsEMujlo+ziH
         PYfyfTWOor8W8OgFd8lSvST0SAHmh0s06HGOBYOY0hEqJcsIiRIcsq7j27IkZDM1wuFo
         zQCTJYA+e1UtX/gH/pdq4FPlwpXy6m+VUmy331UI7WFW58SolGXyvoLabDH2Hq3lhrdW
         8sYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685950826; x=1688542826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUyEfMhLLTzApUSuVw0hL9LIb5HjNC0r0IZHse6dF0M=;
        b=FSZgRA0yaTCe6aKe2w4ygxi+vrWaQkGAQNfnEZZ16cwcFR0xtqLddr7ZgbwJzOd+i/
         QfaDBkU43VRfI0i6OopwoQ/3Y8tLOtpCpwSyy1w2FFhRLL2L7XS3Hjr+tnIWRq4hxRDv
         HkLeeQ2Y1Nb/y6qhfDwVxKvOi1UXxAuoWfiMaSJLWr+LisKt4TAb/LW5ACX1qoqmTNS5
         S+04KAqg2mOhri0oHKh+4G0N1OSkw0IhZ0rrTdoOkJM5SmmNenHZHN9pj65cPbLs/ZJT
         1a0WpnT8KyuCmVnyOEUFbztxX+vlN5I644NJSSASv7pkSe5G0vOvTDtqom8EVsI38jY7
         niMA==
X-Gm-Message-State: AC+VfDzUFn3DmSVptJWSPTUrCbTf6mOsHhseiZb0MBrL2KpPyrFemabk
        TRQti8fae5ZpZX2qO1USMtQ=
X-Google-Smtp-Source: ACHHUZ4rKLOskEiQUMEpvzpZ4WN2cJueLSFc8NlgKFn172q/HDPS6iyaPQQE0rxPJwIMCQFpWhcaHA==
X-Received: by 2002:a05:600c:a395:b0:3f7:38e1:5e53 with SMTP id hn21-20020a05600ca39500b003f738e15e53mr1775155wmb.4.1685950825718;
        Mon, 05 Jun 2023 00:40:25 -0700 (PDT)
Received: from ip-172-31-22-112.eu-west-1.compute.internal (ec2-34-244-49-215.eu-west-1.compute.amazonaws.com. [34.244.49.215])
        by smtp.gmail.com with ESMTPSA id c18-20020adfed92000000b0030ae499da59sm8882103wro.111.2023.06.05.00.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:40:25 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     puranjay12@gmail.com
Subject: [PATCH bpf-next 0/3] bpf, arm64: use BPF prog pack allocator in BPF JIT
Date:   Mon,  5 Jun 2023 07:40:21 +0000
Message-Id: <20230605074024.1055863-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF programs currently consume a page each on ARM64. For systems with many BPF
programs, this adds significant pressure to instruction TLB. High iTLB pressure
usually causes slow down for the whole system.

Song Liu introduced the BPF prog pack allocator[1] to mitigate the above issue.
It packs multiple BPF programs into a single huge page. It is currently only
enabled for the x86_64 BPF JIT.

This patch series enables the BPF prog pack allocator for the ARM64 BPF JIT.

====================================================
Performance Analysis of prog pack allocator on ARM64
====================================================

To test the performance of the BPF prog pack allocator on ARM64, a stresser
tool[2] was built. This tool loads 8 BPF programs on the system and triggers
5 of them in an infinite loop by doing system calls.

The runner script starts 20 instances of the above which loads 8*20=160 BPF
programs on the system, 5*20=100 of which are being constantly triggered.

In the above environment we try to build Python-3.8.4 and try to find different
iTLB metrics for the compilation done by gcc-12.2.0.

The source code[3] is  configured with the following command:
./configure --enable-optimizations --with-ensurepip=install

Then the runner script is executed with the following command:
./run.sh "perf stat -e ITLB_WALK,L1I_TLB,INST_RETIRED,iTLB-load-misses -a make -j32"

This builds Python while 160 BPF programs are loaded and 100 are being constantly
triggered and measures iTLB related metrics.

The output of the above command is discussed below before and after enabling the
BPF prog pack allocator.

The tests were run on qemu-system-aarch64 with 32 cpus, 4G memory, -machine virt,
-cpu host, and -enable-kvm.

Results
-------

Before enabling prog pack allocator:
------------------------------------

Performance counter stats for 'system wide':

         333278635      ITLB_WALK
     6762692976558      L1I_TLB
    25359571423901      INST_RETIRED
       15824054789      iTLB-load-misses

     189.029769053 seconds time elapsed

After enabling prog pack allocator:
-----------------------------------

Performance counter stats for 'system wide':

         190333544      ITLB_WALK
     6712712386528      L1I_TLB
    25278233304411      INST_RETIRED
        5716757866      iTLB-load-misses

     185.392650561 seconds time elapsed

Improvements in metrics
-----------------------

Compilation time                             ---> 1.92% faster
iTLB-load-misses/Sec (Less is better)        ---> 63.16% decrease
ITLB_WALK/1000 INST_RETIRED (Less is better) ---> 42.71% decrease
ITLB_Walk/L1I_TLB (Less is better)           ---> 42.47% decrease

[1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org/
[2] https://github.com/puranjaymohan/BPF-Allocator-Bench
[3] https://www.python.org/ftp/python/3.8.4/Python-3.8.4.tgz 

Puranjay Mohan (3):
  bpf: make bpf_prog_pack allocator portable
  arm64: patching: Add aarch64_insn_copy()
  bpf, arm64: use bpf_jit_binary_pack_alloc

 arch/arm64/include/asm/patching.h |   1 +
 arch/arm64/kernel/patching.c      |  39 ++++++++++
 arch/arm64/net/bpf_jit_comp.c     | 119 +++++++++++++++++++++++++-----
 kernel/bpf/core.c                 |   8 +-
 4 files changed, 146 insertions(+), 21 deletions(-)

-- 
2.39.2

