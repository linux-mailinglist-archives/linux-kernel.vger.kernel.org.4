Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE98D74F24D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjGKOdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjGKOdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:33:49 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B33BB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:33:48 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-514b3b99882so3633704a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689086026; x=1691678026;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VGRLS9PZfnsNdW8E7+rt3QYOMitkf0dfb3D8ONqanVU=;
        b=ACM+cmGPaftl+r3a03wCYTyz2PTNsij/STVLE0V1vKEw3eDekfjR2QqscyUvAcrHV3
         QGkpbdnQNoqC975Ln+UEnAT8MAFdiF7vk8wpKVcOjwCMJPgCiUT3Z4Loe0Qrcu0RgJkt
         cMhJU1XgJyJznWvlLYniCeM+vUrEe1caZbLfkbgRFTu2S0OvU1IS+QOIfUAhO9o7et0A
         i5oKV90GR6Av8ruuPsx32GRhKe4GRqhxmdmkntNNXPEIqb7g/fjMNp+Wd5jatboPFKjA
         fus/lzZ24m9bSMyr98fSmlv1TxZOLLqGkAmuMg815NfxzMDvgWaEgBcrghFvygJFuET1
         OZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086026; x=1691678026;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGRLS9PZfnsNdW8E7+rt3QYOMitkf0dfb3D8ONqanVU=;
        b=LW8IuVOg7dte/qTZDsriI/5XqsJ2WPQn0/NPnEy1zr3r8LeseZ7IMAB9P1XEGfeU0r
         Fi75lEyaDOYWhHuYBcN71CT8Tiby80KibHeFYTQyu1z2qMJSjA6hqyO+Y6LCIcVl1Gp0
         MxCLfo95lEWWWQVT/03yzjdmdg5EZbiye/QaN3B6Zx+/RgBtdrldzzI5VhjJIXRtL2e4
         MPIsSGkfBRRt/skR4G3lEmc1yz2BGMIM1rrcG62gpMiITqJBqsRq17hgktvK+aKke+I0
         1wRx01B5AFVXKsECj6HL8B01gWVt0r5LANVedf3N2llYWtLLDNlvYdG3jfU605SKvEVP
         cwGA==
X-Gm-Message-State: ABy/qLZSGNwPIpXSCJGEKa/9OblQ9HHJXknFj/jij42wrXTSolokB8qL
        KC7buPSi62bLLAvEzcZVQfWO18or1w0=
X-Google-Smtp-Source: APBJJlEc2CXHpERZgeEynf388KWaCCGl5zbXJJ2YYem5Q9YuIP0R6kODxnUyy5vGIV8WQAS14Zxnx8YEWQg=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:564d:3aaa:6b5f:4419])
 (user=glider job=sendgmr) by 2002:a50:bb67:0:b0:51e:164c:5444 with SMTP id
 y94-20020a50bb67000000b0051e164c5444mr48540ede.8.1689086026234; Tue, 11 Jul
 2023 07:33:46 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:33:27 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711143337.3086664-1-glider@google.com>
Subject: [PATCH 0/5] Implement MTE tag compression for swapped pages
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when MTE pages are swapped out, the tags are kept in the
memory, occupying 128 bytes per page. This is especially problematic
for devices that use zram-backed in-memory swap, because tags stored
uncompressed in the heap effectively reduce the available amount of
swap memory.

The RLE-based EA0 algorithm suggested by Evgenii Stepanov and
implemented in this patch series is able to efficiently compress
128-byte tag buffers, resulting in practical compression ratio between
2.5x and 20x. In most cases it is possible to store the compressed data
in 63-bit Xarray values, resulting in no extra memory allocations.

Our measurements show that EA0 provides better compression than existing
kernel compression algorithms (LZ4, LZO, LZ4HC, ZSTD) can offer, because
EA0 specifically targets 128-byte buffers.

To implement compression/decompression, we introduce <linux/bitqueue.h>,
which provides a simple bit queue interface.

We refactor arch/arm64/mm/mteswap.c to support both the compressed
(CONFIG_ARM64_MTE_COMP) and non-compressed case. For the former, in
addition to tag compression, we move tag allocation from kmalloc() to
separate kmem caches, providing greater locality and relaxing the
alignment requirements.

Alexander Potapenko (5):
  linux/bitqueue.h: add a KUnit test for bitqueue.h
  arm64: mte: implement CONFIG_ARM64_MTE_COMP
  arm64: mte: add a test for MTE tags compression
  arm64: mte: add compression support to mteswap.c
  fixup mteswap

 arch/arm64/Kconfig               |  20 ++
 arch/arm64/include/asm/mtecomp.h |  60 +++++
 arch/arm64/mm/Makefile           |   7 +
 arch/arm64/mm/mtecomp.c          | 398 +++++++++++++++++++++++++++++++
 arch/arm64/mm/mteswap.c          |  19 +-
 arch/arm64/mm/mteswap.h          |  12 +
 arch/arm64/mm/mteswap_comp.c     |  50 ++++
 arch/arm64/mm/mteswap_nocomp.c   |  37 +++
 arch/arm64/mm/test_mtecomp.c     | 175 ++++++++++++++
 lib/Kconfig.debug                |   8 +
 lib/Makefile                     |   1 +
 lib/test_bitqueue.c              | 244 +++++++++++++++++++
 12 files changed, 1020 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/asm/mtecomp.h
 create mode 100644 arch/arm64/mm/mtecomp.c
 create mode 100644 arch/arm64/mm/mteswap.h
 create mode 100644 arch/arm64/mm/mteswap_comp.c
 create mode 100644 arch/arm64/mm/mteswap_nocomp.c
 create mode 100644 arch/arm64/mm/test_mtecomp.c
 create mode 100644 lib/test_bitqueue.c

-- 
2.41.0.255.g8b1d071c50-goog

