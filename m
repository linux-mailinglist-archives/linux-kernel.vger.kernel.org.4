Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DDE74F282
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjGKOml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGKOmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:42:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A44CBC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:42:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57704a25be9so84568037b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689086558; x=1691678558;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JUYDVerV8URpwGJ6F0fNfWvwfXeGFLCwYeiofYpp/QI=;
        b=FqXpeZjc4sttpuWzmF3jWCSEBcVkYsunCs48g4nQPBHG01elPa9vB7+xnkIcnUlOc4
         IZ86oal0oY7zOPlMq4NxW48QHHGG/Y1DL1ZLVxNQNzZhsSN1uzOwFLRwJ6wL9t3vSDYO
         FGIUxXokO757d1lZ6tmoruS6re+Kj+2bkUxvxu6MIxOSqdJNf3D4sQI+yF5ho4KAR0x9
         Ayn7RicV+Kr+klHsefaDAk+AjhlCiz72Sf+zpbK9COQitEzzbi0IlzQ7yoUxRX58D4Tx
         CtwuG3Sh9AAVrlIEGQfWSrBUcho3i7hzbS5PUG9RjNQjnERlbzMOy4d2bK96VK5DHI6+
         fIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086558; x=1691678558;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JUYDVerV8URpwGJ6F0fNfWvwfXeGFLCwYeiofYpp/QI=;
        b=GKQFc698tHsOdgIdFNtZssvO645NrSuedocAHcyHWPxkXUckJsI9ibEK3guvzbPZlx
         JSS6taPQJoqzjpLn+ljE1OS+PxpSe+sK5qCptK0LLq1gLoR7nSAaMdJTVtqM72q3dyT8
         +1Z13CoFysF1ZDWJIUq2P4EiqPqT4KMcR8hPPynflc8ihCbYjOkNgHWYB7cybMzGDMbm
         53qx8493V5HEB8C9f+JHv8EZs8oQXCINcOXznouqx68zf4u5C3rvFY5XG//yzH+bYARH
         UgJAe0OqM7DT/w3t/gGMp1DKg4267R4Q7AMQ7iM9RAE3SPya4kx+G8sDOjgQ2jxPB/Xw
         6L0Q==
X-Gm-Message-State: ABy/qLZLoaw3HOroRY+Yvzxh7lIt3QU+lRX145Zu1Rb+hAihGUd6zWrf
        HTfVbLX2J3LPkCbua0jGQ5Gf20zfm7A=
X-Google-Smtp-Source: APBJJlG8H5mxRAaZPSqfDthhmY3+Q9TwHSjryqeG2QVFvwHLl2FTUuvh4e8eI7hJ628wohDrg1Uo9DDM7Wg=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:564d:3aaa:6b5f:4419])
 (user=glider job=sendgmr) by 2002:a81:aa53:0:b0:577:6462:24c3 with SMTP id
 z19-20020a81aa53000000b00577646224c3mr269427ywk.4.1689086557872; Tue, 11 Jul
 2023 07:42:37 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:42:28 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711144233.3129207-1-glider@google.com>
Subject: [Resend v1 0/5] Implement MTE tag compression for swapped pages
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
  linux/bitqueue.h: add the bit queue implementation
  linux/bitqueue.h: add a KUnit test for bitqueue.h
  arm64: mte: implement CONFIG_ARM64_MTE_COMP
  arm64: mte: add a test for MTE tags compression
  arm64: mte: add compression support to mteswap.c

 arch/arm64/Kconfig               |  20 ++
 arch/arm64/include/asm/mtecomp.h |  60 +++++
 arch/arm64/mm/Makefile           |   7 +
 arch/arm64/mm/mtecomp.c          | 398 +++++++++++++++++++++++++++++++
 arch/arm64/mm/mteswap.c          |  19 +-
 arch/arm64/mm/mteswap.h          |  12 +
 arch/arm64/mm/mteswap_comp.c     |  50 ++++
 arch/arm64/mm/mteswap_nocomp.c   |  37 +++
 arch/arm64/mm/test_mtecomp.c     | 175 ++++++++++++++
 include/linux/bitqueue.h         | 144 +++++++++++
 lib/Kconfig.debug                |   8 +
 lib/Makefile                     |   1 +
 lib/test_bitqueue.c              | 244 +++++++++++++++++++
 13 files changed, 1164 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/asm/mtecomp.h
 create mode 100644 arch/arm64/mm/mtecomp.c
 create mode 100644 arch/arm64/mm/mteswap.h
 create mode 100644 arch/arm64/mm/mteswap_comp.c
 create mode 100644 arch/arm64/mm/mteswap_nocomp.c
 create mode 100644 arch/arm64/mm/test_mtecomp.c
 create mode 100644 include/linux/bitqueue.h
 create mode 100644 lib/test_bitqueue.c

-- 
2.41.0.255.g8b1d071c50-goog

