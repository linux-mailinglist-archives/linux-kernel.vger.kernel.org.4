Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C1E73DABC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjFZJDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFZJDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:03:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC81AE7A;
        Mon, 26 Jun 2023 01:58:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa96fd7a01so8960515e9.1;
        Mon, 26 Jun 2023 01:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687769893; x=1690361893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BW6tD5LOYWEQLPeqm6MtP4jYXlwBj96utCaHDwz4Kxc=;
        b=RRjPJ80u+sy8/xjuKuQc1tJhhq1uyD5CsNrRA39bWR4FyyGMA6XStFH2P76h/nR2En
         pDzDxVoXa3N0uhye3NfPf/6DBgfySBdosx9Nun49hKlpYIyQo1NxoHt7lb1K2bqioMRQ
         4UYaZ35+n1WxcQ3ud8ms034GRB7/wWyC28wmvzKGFZzh1P/nY+xm+FSTSkz3GYdGWFRU
         BUyNcBcwdFza+fLXV/WNU/bToNvfxkvqTCKb/GX6Hs5FHTI++jdta7sRc3NVyJQPPdzx
         Zmj+fUBwcrWPeIo5IFlJwWS+XgcY88SF3holQ6YmG2fTZVafwAfz+vgjRE8Suw7464L4
         HUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687769893; x=1690361893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BW6tD5LOYWEQLPeqm6MtP4jYXlwBj96utCaHDwz4Kxc=;
        b=altq6zMPoHCNjouSgW+QMupxofGWow8d0L0SROkyTCCVo4rQOBLB99ZDr3kBdhKhsM
         I4jh9of9RqG09G2i8C81Gxn2kHSaO2TrRf6eYXfCVC9dNBaKaWAFuXBOeexYvvj16z2l
         H3H4BucIV1v1uj0PrdQTJ/S1cTAgmKu20dbX+lHCaEQGMbU0IxnHpcCeJVI/LvE4mlmW
         yg2uKh+EC92VNdWYtS8z+G1/BVPC/HaVNcozcvCdZpJe0bwibHVSlCyxuXUP+l0HlJHi
         4/3a7DhGmU8EMn/4pRWjMOL8bX1/INEiMwxHV6Rl3kd4ptvYQUSQqf/0ZrND7PqodwCI
         wW6A==
X-Gm-Message-State: AC+VfDw6QFjDm/76qtx+TdYpYRr+9gUCjVbWOoVR8xkWtE3K35AW16Xr
        HRDloACKt0CIlfoXHbZOfZU=
X-Google-Smtp-Source: ACHHUZ6tVXS7MOEvgK570FibtSg2oP1aHFaBodfNSREPRFB2rcVLuJ1Ld7L87ssLJZfF8OX/o4adAQ==
X-Received: by 2002:a05:600c:284:b0:3fa:7dfc:411f with SMTP id 4-20020a05600c028400b003fa7dfc411fmr7082596wmk.23.1687769892795;
        Mon, 26 Jun 2023 01:58:12 -0700 (PDT)
Received: from ip-172-31-22-112.eu-west-1.compute.internal (ec2-34-242-96-229.eu-west-1.compute.amazonaws.com. [34.242.96.229])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b00313e8dc7facsm4883533wrt.116.2023.06.26.01.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 01:58:12 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     puranjay12@gmail.com
Subject: [PATCH bpf-next v4 0/3] bpf, arm64: use BPF prog pack allocator in BPF JIT
Date:   Mon, 26 Jun 2023 08:58:08 +0000
Message-Id: <20230626085811.3192402-1-puranjay12@gmail.com>
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

Chanes in V3 => V4: Changes only in 3rd patch
1. Fix the I-cache maintenance: Clean the data cache and invalidate the i-Cache
   only *after* the instructions have been copied to the ROX region.

Chanes in V2 => V3: Changes only in 3rd patch
1. Set prog = orig_prog; in the failure path of bpf_jit_binary_pack_finalize()
call.
2. Add comments explaining the usage of the offsets in the exception table.

Changes in v1 => v2:
1. Make the naming consistent in the 3rd patch:
   ro_image and image
   ro_header and header
   ro_image_ptr and image_ptr
2. Use names dst/src in place of addr/opcode in second patch.
3. Add Acked-by: Song Liu <song@kernel.org> in 1st and 2nd patch.

Puranjay Mohan (3):
  bpf: make bpf_prog_pack allocator portable
  arm64: patching: Add aarch64_insn_copy()
  bpf, arm64: use bpf_jit_binary_pack_alloc

 arch/arm64/include/asm/patching.h |   1 +
 arch/arm64/kernel/patching.c      |  39 ++++++++
 arch/arm64/net/bpf_jit_comp.c     | 145 +++++++++++++++++++++++++-----
 kernel/bpf/core.c                 |   8 +-
 4 files changed, 165 insertions(+), 28 deletions(-)

-- 
2.40.1

