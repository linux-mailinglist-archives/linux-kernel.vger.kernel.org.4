Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51C85F1E79
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 19:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJARq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 13:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiJARqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 13:46:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B31230547
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 10:46:53 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x29so1475285pfp.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=DJoZjCl9pw1WFJosNyRDkJYXJctBgaqjQblgteCNFU0=;
        b=n5TFlZE7eXPF7eFDbdDocMnLLkm6txwEMFD3BDoG/1OF6tpgQ/v4rWD97HP0YNy7VC
         nBdwWlusVYXRXC2TpV5DHL2ZHn+jNv6yW0G4ZJmll5m6ob4gmOjmOGp8rFG6TF8w11KD
         sqTbos0IA+Uboj1RzpY6W7szlts3PmQwLzeAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DJoZjCl9pw1WFJosNyRDkJYXJctBgaqjQblgteCNFU0=;
        b=EzXmYHXChee7/w1aLTH4ckQXvFheHcg6kiGJ6vGrHuO53Cu97c8zcUnpe8vVdc6b2i
         tTskccd+b5bM0htVDm61Y5/EKpNfxJFDgaWfLyPiBim3hItPnte47ZjU/WxUjFHYDK4H
         Rqoy5arBXWksDzUfe2fmbEjT5FzTswYlrwdPEMfTOg046vBBOEyNX3wCHqEMaRxlAciV
         RMMK1WitV66yQymOvsLx13kZPW/3HmIjYN7e69oAk+qKrka5hWQS31Buh/q8anCafPnj
         lfH0+pawO6FDSyHq8ksWvutY8+OS6YHNxEG1enTn3IJd6oVTsa1FgdM6E0j1buWxG83u
         fD+Q==
X-Gm-Message-State: ACrzQf10Kj/YrxnAg+qtshXA8RNfE8sL9ml2UJEF5jmuWJoSYToPYbWz
        JVxxnNte0MYX0TYrZC7G0RDZkg==
X-Google-Smtp-Source: AMsMyM6djcd1zQv2COFCTgh6LKnUAS/I9DsINlzPgdku0IwrDgGiU+tJyVncuFuUoPCEpD73ltHNeQ==
X-Received: by 2002:a63:65c4:0:b0:440:5352:3812 with SMTP id z187-20020a6365c4000000b0044053523812mr11075164pgb.285.1664646412972;
        Sat, 01 Oct 2022 10:46:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b15-20020a170903228f00b0017305e99f00sm4264490plh.107.2022.10.01.10.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 10:46:52 -0700 (PDT)
Date:   Sat, 1 Oct 2022 10:46:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Bill Wendling <morbo@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] kernel hardening updates for v6.1-rc1
Message-ID: <202210011003.B89BF8B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these kernel hardening updates for v6.1-rc1. Most of
the collected changes here are fixes across the tree for various
hardening features (noted in the tag commit log below).

The most notable new feature here is the addition of the memcpy()
overflow warning (under CONFIG_FORTIFY_SOURCE), which is the next step
on the path to killing the common class of "trivially detectable" buffer
overflow conditions (i.e. on arrays with sizes known at compile time)
that have resulted in many exploitable vulnerabilities over the years
(e.g. BleedingTooth).

This feature is expected to still have some undiscovered false
positives. It's been in -next for a full development cycle and all
the reported false positives have been fixed in their respective trees.
All the known-bad code patterns we could find with Coccinelle are
also either fixed in their respective trees or in flight.

The commit log[1] for the feature has extensive details, but I'll repeat
here that this is a warning _only_, and is not intended to actually block
overflows (yet). The many patches fixing array sizes and struct members
have been landing for several years now, and we're finally able to turn
this on to find any remaining stragglers.

1 expected conflict is minimal:
- https://lore.kernel.org/linux-next/20220906174946.61819060@canb.auug.org.au/

Thanks!

-Kees

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=54d9469bc515dc5fcbc20eecbe19cea868b70d68

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.1-rc1

for you to fetch changes up to 2120635108b35ecad9c59c8b44f6cbdf4f98214e:

  Makefile.extrawarn: Move -Wcast-function-type-strict to W=1 (2022-10-01 07:46:05 -0700)

----------------------------------------------------------------
hardening updates for v6.1-rc1

Various fixes across several hardening areas:

- loadpin: Fix verity target enforcement (Matthias Kaehlcke).

- zero-call-used-regs: Add missing clobbers in paravirt (Bill Wendling).

- CFI: clean up sparc function pointer type mismatches (Bart Van Assche).

- Clang: Adjust compiler flag detection for various Clang changes (Sami
  Tolvanen, Kees Cook).

- fortify: Fix warnings in arch-specific code in sh, ARM, and xen.

Improvements to existing features:

- testing: improve overflow KUnit test, introduce fortify KUnit test,
  add more coverage to LKDTM tests (Bart Van Assche, Kees Cook).

- overflow: Relax overflow type checking for wider utility.

New features:

- string: Introduce strtomem() and strtomem_pad() to fill a gap in
  strncpy() replacement needs.

- um: Enable FORTIFY_SOURCE support.

- fortify: Enable run-time struct member memcpy() overflow warning.

----------------------------------------------------------------
Bart Van Assche (4):
      testing/selftests: Add tests for the is_signed_type() macro
      overflow, tracing: Define the is_signed_type() macro once
      lib: Improve the is_signed_type() kunit test
      sparc: Unbreak the build

Bill Wendling (2):
      x86/paravirt: clean up typos and grammaros
      x86/paravirt: add extra clobbers with ZERO_CALL_USED_REGS enabled

Kees Cook (17):
      overflow: Allow mixed type arguments
      overflow: Split up kunit tests for smaller stack frames
      string: Introduce strtomem() and strtomem_pad()
      fortify: Fix __compiletime_strlen() under UBSAN_BOUNDS_LOCAL
      fortify: Add KUnit test for FORTIFY_SOURCE internals
      fortify: Use SIZE_MAX instead of (size_t)-1
      fortify: Add run-time WARN for cross-field memcpy()
      lkdtm: Update tests for memcpy() run-time warnings
      um: Enable FORTIFY_SOURCE
      kunit/memcpy: Avoid pathological compile-time string size
      sh: machvec: Use char[] for section boundaries
      fortify: Adjust KUnit test for modular build
      ARM: decompressor: Include .data.rel.ro.local
      x86/entry: Work around Clang __bdos() bug
      fortify: Explicitly check bounds are compile-time constants
      fortify: Convert to struct vs member helpers
      hardening: Remove Clang's enable flag for -ftrivial-auto-var-init=zero

Matthias Kaehlcke (3):
      LoadPin: Fix Kconfig doc about format of file with verity digests
      dm: verity-loadpin: Only trust verity targets with enforcement
      LoadPin: Require file with verity root digests to have a header

Sami Tolvanen (1):
      Makefile.extrawarn: Move -Wcast-function-type-strict to W=1

 Documentation/process/deprecated.rst    |  11 +-
 MAINTAINERS                             |   1 +
 Makefile                                |   4 +-
 arch/arm/boot/compressed/vmlinux.lds.S  |   2 +
 arch/sh/include/asm/sections.h          |   2 +-
 arch/sh/kernel/machvec.c                |  10 +-
 arch/sparc/include/asm/smp_32.h         |  15 +-
 arch/sparc/kernel/leon_smp.c            |  12 +-
 arch/sparc/kernel/sun4d_smp.c           |  12 +-
 arch/sparc/kernel/sun4m_smp.c           |  10 +-
 arch/sparc/mm/srmmu.c                   |  29 ++--
 arch/um/Kconfig                         |   1 +
 arch/um/os-Linux/user_syms.c            |   1 +
 arch/x86/include/asm/paravirt_types.h   |  27 ++--
 arch/x86/xen/enlighten_pv.c             |   3 +-
 drivers/md/dm-verity-loadpin.c          |   8 ++
 drivers/md/dm-verity-target.c           |  16 +++
 drivers/md/dm-verity.h                  |   1 +
 drivers/misc/lkdtm/fortify.c            |  96 +++++++++++--
 include/linux/compiler.h                |   6 +
 include/linux/fortify-string.h          | 245 +++++++++++++++++++++++---------
 include/linux/overflow.h                |  73 +++++-----
 include/linux/string.h                  |  43 ++++++
 include/linux/trace_events.h            |   2 -
 lib/Kconfig.debug                       |  21 +++
 lib/Makefile                            |   2 +
 lib/fortify_kunit.c                     |  76 ++++++++++
 lib/is_signed_type_kunit.c              |  53 +++++++
 lib/memcpy_kunit.c                      |  59 +++++++-
 lib/overflow_kunit.c                    | 177 ++++++++++++++++-------
 scripts/Makefile.extrawarn              |   1 +
 security/Kconfig.hardening              |  14 +-
 security/loadpin/Kconfig                |   7 +-
 security/loadpin/loadpin.c              |  16 ++-
 tools/testing/selftests/lkdtm/tests.txt |   8 +-
 35 files changed, 821 insertions(+), 243 deletions(-)
 create mode 100644 lib/fortify_kunit.c
 create mode 100644 lib/is_signed_type_kunit.c

-- 
Kees Cook
