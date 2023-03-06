Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7791A6AB4D8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 04:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCFDDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 22:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCFDD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 22:03:29 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F5E59E1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 19:03:27 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id v11so8754988plz.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 19:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678071807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYopMUaQRW9Dv0DHFros5KA77xZDqrJK6NU0WooYypU=;
        b=X3JAn9LL3tBtDUT+BbLvnP6eATZM7qc5rqV2LaZVW1t7hPPZcn3usqeIfQYzV2JqiS
         sVRCxguJTHLczZJGcNJe8SzvKxJxv66vX03Hae3/o4IaZlp0+WLCQBGO9aao/V6d2IM9
         GnK1fctWu4SfY42KNVGCKuTLAQAf1iDIt8hdCbdgZgvqbxxENQC5v2n7+Ef6G1e0l299
         0+GjQ4xuJMw3C0VzL5nfVuf7XPLjNjkQ3NiJRGgBJwMFOxFi+SLC6RIFIBtWbuAseMXG
         iyOwDRoQg8cMCY5VXJLsQgT3VXDvLYPe57WErycdWslVjjkkPgQnA8aw3byLvdQrxG6v
         UEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678071807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYopMUaQRW9Dv0DHFros5KA77xZDqrJK6NU0WooYypU=;
        b=SN2R/28AsAqhzVxw5nkY8AtnCK1NVEHezQkbKZMBSyKvj3+dLbeb67p2xciHgEw33o
         4vWR6e56IO4jfTif37jAv6tFbdIlDtUaq3NFUUjfufEmM0hLOezSumod884vvvyuZQey
         3IQDNMV7KRS4i1P8+SibrQnHjFJ2CD4i7kH8Zeok9f9Pb9EuIzFvg7dA9zbiAu/nPd6l
         zgNJCTGiJrh9U4P9KsiOZr4sx32pIJ2Av0BnExZsPzwcPl3V9PLVj0uQACd2dkbCLjFx
         NZux94ryEuGSugO7KB8Xiu7BHzexBI3RTyPnVcZ42tGH5ihRWtjeITpqAunX873ZRx/Q
         9RTA==
X-Gm-Message-State: AO0yUKWOk9L6LU92j+JtQzRDLwuzuUVLIPugpwRsAVV1eRNCy3rETGhn
        2ZeLlitvg2hYXrY/QFs/tw==
X-Google-Smtp-Source: AK7set8MGWb52Jm1pOUgvUaZvO0N8sqK6Q1bmEy5eoJ0WrhT3EB7tvx03iog7dzsZQLFMpfes3oJcg==
X-Received: by 2002:a17:903:2cb:b0:19c:f747:2517 with SMTP id s11-20020a17090302cb00b0019cf7472517mr12094679plk.1.1678071807419;
        Sun, 05 Mar 2023 19:03:27 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jy16-20020a17090342d000b0019719f752c5sm5410439plb.59.2023.03.05.19.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 19:03:26 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, kexec@lists.infradead.org
Subject: [PATCH 0/6] arm64: make kexec_file able to load zboot image
Date:   Mon,  6 Mar 2023 11:02:59 +0800
Message-Id: <20230306030305.15595-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After introducing zboot image, kexec_file can not load and jump to the
new style image. Hence it demands a method to load the new kernel.

The crux of the problem lies in when and how to decompress the Image.gz.
There are three possible courses to take: -1. in user space, but hard to
achieve due to the signature verification inside the kernel.  -2. at the
boot time, let the efi_zboot_entry() handles it, which means a simulated
EFI service should be provided to that entry, especially about how to be
aware of the memory layout.  -3. in kernel space, during the file load
of the zboot image. At that point, the kernel masters the whole memory
information, and easily allocates a suitable memory for the decompressed
kernel image. (I think this is similar to what grub does today).

The core of this series is [5/6].  [3,6/6] handles the config option.
The assumption of [3/6] is kexec_file_load is independent of zboot,
especially it can load kernel images compressed with different
compression method.  [6/6] is if EFI_ZBOOT, the corresponding
decompression method should be included.


Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: kexec@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org

Pingfan Liu (6):
  arm64: kexec: Rename kexec_image.c to kexec_raw_image.c
  lib/decompress: Introduce decompress_method_by_name()
  arm64: Kconfig: Pick decompressing method for kexec file load
  lib/decompress: Keep decompress routines based on selection
  arm64: kexec: Introduce zboot image loader
  init/Kconfig: Select decompressing method if compressing kernel

 arch/arm64/Kconfig                            |  59 ++++++
 arch/arm64/include/asm/kexec.h                |   4 +-
 arch/arm64/kernel/Makefile                    |   2 +-
 .../{kexec_image.c => kexec_raw_image.c}      |   2 +-
 arch/arm64/kernel/kexec_zboot_image.c         | 186 ++++++++++++++++++
 arch/arm64/kernel/machine_kexec.c             |   1 +
 arch/arm64/kernel/machine_kexec_file.c        |   3 +-
 include/linux/decompress/generic.h            |   2 +
 include/linux/decompress/mm.h                 |   9 +-
 include/linux/zboot.h                         |  26 +++
 init/Kconfig                                  |   7 +
 lib/Kconfig                                   |   3 +
 lib/decompress.c                              |  17 +-
 13 files changed, 314 insertions(+), 7 deletions(-)
 rename arch/arm64/kernel/{kexec_image.c => kexec_raw_image.c} (98%)
 create mode 100644 arch/arm64/kernel/kexec_zboot_image.c
 create mode 100644 include/linux/zboot.h

-- 
2.31.1

