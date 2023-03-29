Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992826CD16D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjC2FJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2FJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:09:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF13E5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:09:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d17so14326956wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680066594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HrrIoxB+zKV0UEkWODap9Ww4pQQF6XVCTKbb7wsxq9w=;
        b=RGW7BPAzQrFqvwD0TyHAZcelsSUbPUly85CojGz+IUBF8zmCAbCb8KYciS7rl3Y1Ha
         86+DjMvDX54STPJNHzOUCHOGix1k6adhqnwaupVt5swn2r+fuhcQ26kaO25qGhDx7cIr
         cjOm+De9MIKde3lbwKzubPsrex1i2a0xTiDZbLxQAnDDhwKCjFWDXsBjiishvop/eJQq
         RtsxAUcVof32GUDt77IdHVYQTl9Ef+HOGwgVwbTvOiqiyumna4EIYGRpo0o2nCBQEjBm
         oA8l9zAUkkyJZw80jxlp4HJm3VH2O41RDJJy1Hv36gaKi5rudRsqERD1XMES1PGEKzuO
         QyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680066594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrrIoxB+zKV0UEkWODap9Ww4pQQF6XVCTKbb7wsxq9w=;
        b=gmFASpMUbSH1buIt9R6JDA0B7CRUnX1O3qkCEqh6WRtXUeKUuhyvB4G6fgbTTIE/zf
         oED7+uCxUAXIk784Vl6vhR7lr1EPGu3PFbBPp+rlUdbsBwebLbH8jWYu3xWkUM7XZp6s
         YsBLNSbX5Nrj8LSemR66kY13OLb0xSPQNxZ3iJ7J54AkOWg2DkRPJxMXwe8rsK7cxiRh
         BovGZRJ/fvmX8EDFQQxftNPvjloyN995bvgCnu/eUJMZl2cbrT+i6D1xOghup7RLNKVp
         HQyZEx1UXEtbiFhqdczYknBK8kMU2Ae1oB69QuNGmOQ98Jh2Mz1TwQGC2kVguIq5Ymaj
         qyoQ==
X-Gm-Message-State: AAQBX9eglCkxyNDu+xLPvmD02ez/lI+hujb/RNxoIOL0IVKrGVsXwi+w
        TjkF9UQyXmrNQJ0bPgHp6MwiCg==
X-Google-Smtp-Source: AKy350aemnnDJZg1tjixCU1DyyeIbsbWItubuUCQbq2D2yP+v86vrpuRBNS6XgT2PoDV795mcpn0Xw==
X-Received: by 2002:a5d:4642:0:b0:2c5:5ec7:43bc with SMTP id j2-20020a5d4642000000b002c55ec743bcmr622318wrs.18.1680066594447;
        Tue, 28 Mar 2023 22:09:54 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d5307000000b002c5a1bd5280sm29161207wrv.95.2023.03.28.22.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 22:09:54 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v9 0/1] riscv: Allow to downgrade paging mode from the command line
Date:   Wed, 29 Mar 2023 07:09:50 +0200
Message-Id: <20230329050951.66085-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new version gets rid of the limitation that prevented KASAN kernels
to use the newly introduced parameters.

While looking into KASLR, I fell onto commit aacd149b6238 ("arm64: head:
avoid relocating the kernel twice for KASLR"): it allows to use the fdt
functions very early in the boot process with KASAN enabled by simply
compiling a new version of those functions without instrumentation.

I had to change the handling of the command line parsing to make the
code self-contained in kernel/pi/cmd_early.c to avoid calling too many
__pi prefixed functions from outside this file.

I'll use this approach like arm64 to handle the extraction of the random
seedi from the device tree for KASLR.

This patchset is rebased on top:

Introduce 64b relocatable kernel
(https://patchwork.kernel.org/project/linux-riscv/list/?series=734847)
base-commit-tag: v6.3-rc1

v9:
- Fix medlow builds by marking pi/ medany, as reported by Palmer

v8:
- Fix LLVM ld warning by moving the section .init.sdata from
  kernel/pi/string.c into the newly created section .init.pidata

v7:
- Rebased on top of for-next which introduces lots of errors (thanks to
  the patchwork CI)
- Add __NO_FORTIFY to avoid undefined __pi_fortify_panic
- Add an alias to our newly introduced strlen
- Remove __init as sections are already prefixed in the Makefile
- Introduce new section for kernel/pi/string.c to quiet the following
  warnings (once we have all the string functions, we'll be able to get
  rid of this):

warning: orphan section `.init__bug_table' from `arch/riscv/kernel/pi/string.pi.o' being placed in section `.init__bug_table'
warning: orphan section `.init.srodata.cst8' from `arch/riscv/kernel/pi/string.pi.o' being placed in section `.init.srodata.cst8'

v6:
- Fix llvm warning by forward declaring set_satp_mode_from_cmdline

v5:
- Handle null command line, Thanks Björn!
- Add RB/TB from Björn

v4:
- Introduce pi/ for KASAN to work

v3:
- Massage commit log to make no4lvl clearer, as asked by Conor
- Add a note to kernel-parameters.txt regarding the impossibility to use
  those parameters when KASAN is enabled, as suggested by Conor
- Add RB from Björn

v2:
- Honor CMDLINE_EXTEND and CMDLINE_FORCE as noticed by Björn

Alexandre Ghiti (1):
  riscv: Allow to downgrade paging mode from the command line

 .../admin-guide/kernel-parameters.txt         |  5 +-
 arch/riscv/kernel/Makefile                    |  2 +
 arch/riscv/kernel/pi/Makefile                 | 39 ++++++++++++
 arch/riscv/kernel/pi/cmdline_early.c          | 62 +++++++++++++++++++
 arch/riscv/kernel/vmlinux.lds.S               |  8 +++
 arch/riscv/lib/memcpy.S                       |  2 +
 arch/riscv/lib/memmove.S                      |  2 +
 arch/riscv/lib/strlen.S                       |  1 +
 arch/riscv/mm/init.c                          | 36 +++++++++--
 9 files changed, 150 insertions(+), 7 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/Makefile
 create mode 100644 arch/riscv/kernel/pi/cmdline_early.c

-- 
2.37.2

