Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFD373FA91
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjF0KzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjF0KzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:55:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E7E19AA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:55:06 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8063aa2e1so11915935ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687863306; x=1690455306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+7pb9kkezXuALuGQ9D1BYYeolzOO/8PS1XTZd2C/jQ=;
        b=XkZMAaIH6zTafrMpOtt/Rf5k5qj+eqHlO+XMiByS4e8QgTS/8NhUZMLb1Lqs6hkpae
         aKSWR6SPugzj8jYgur2WN7XvK1mC09zEb88/2Jnj/XzToXqr2hHgcXOPwgHUZBoU+D5Y
         RJaD0qLZWzrDMGpdEsOqH82xIZio6q1r8JKdfnGsKaCQ5ycwwQTp3glfKMb/eiXp7535
         E8kgrTKbCxR0HGo8zl5vYysIaEFc1+T6g0dB3s9JDgrEGzzPhHXy0TL6+m750ICWIMAu
         TLDbtlEsbfJERpwPgon/CMBWEEeLsn4lMftSfcZe5rKayV5IJuWkzWf4wWtTuv9MJRKf
         KxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687863306; x=1690455306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+7pb9kkezXuALuGQ9D1BYYeolzOO/8PS1XTZd2C/jQ=;
        b=VK3wu0YKw1XuhQfOQsKzyr9g2cYZrCM5BYHjBDKPdjeljXVaIzthXySv7QxcJdaqSk
         sOUSV7jDwW2Ef/4ClV2r6CzfbRNJVBNORiam8K6zqYCrK4JZjhFjhFYxIFSCIMvavu8A
         dxMi/cho82Y8ptmRq0InnMRYgdL+2teGm7tuya7uuC0HpYA3sTCyfl+T09lAfa7dY3CI
         w2tNM4WG6u7B+9G5qmmxYngyi7b3dYs4g/PLLXgTO23ZTbddqPEgTXbTmE13U+yzOYp1
         6XqqZq14ldcUuOLv9I1iTjATXegekeRCF/9QgSpmJDEt0gAO7qQLJczVEq4L8/1Ra1wf
         iXKA==
X-Gm-Message-State: AC+VfDye9FbFC79dqPZhRyH5dwTAIYwq82r7M5JemSUYPFJnp8Yz/FIs
        bKEo6cjxGWdI+3hRz9xBBak4UdBaB+o=
X-Google-Smtp-Source: ACHHUZ4YPJ4GQ3UeoAQCoAoc+jmw/lW9SVBKsgAgEQlTFrrgLQcshXBgjIGN6MKbxWWejCQ2unRMbg==
X-Received: by 2002:a17:902:eccf:b0:1b3:e6ba:1573 with SMTP id a15-20020a170902eccf00b001b3e6ba1573mr5854659plh.6.1687863306247;
        Tue, 27 Jun 2023 03:55:06 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:96d2:5d2:b10f:c30c])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b001b8053b8e0esm3256635plr.136.2023.06.27.03.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 03:55:05 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 00/18] xtensa updates for v6.5
Date:   Tue, 27 Jun 2023 03:54:51 -0700
Message-Id: <20230627105451.803122-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following updates for the Xtensa architecture.

The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230627

for you to fetch changes up to f7667ca106df50ff8b776db54f85074dc9c52e1b:

  xtensa: dump userspace code around the exception PC (2023-06-24 06:34:27 -0700)

----------------------------------------------------------------
Xtensa updates for v6.5

- clean up platform_* interface of the xtensa architecture
- enable HAVE_ASM_MODVERSIONS
- drop ARCH_WANT_FRAME_POINTERS
- clean up unaligned access exception handler
- provide handler for load/store exceptions
- various small fixes and cleanups

----------------------------------------------------------------
Max Filippov (18):
      xtensa: xt2000: drop empty platform_init
      xtensa: drop platform_heartbeat
      xtensa: drop platform_restart
      xtensa: drop platform_halt and platform_power_off
      xtensa: clean up default platform functions
      xtensa: boot-redboot: clean up Makefile
      xtensa: drop EXPORT_SYMBOL for common_exception_return
      xtensa: drop bcopy implementation
      xtensa: only build __strncpy_user with CONFIG_ARCH_HAS_STRNCPY_FROM_USER
      xtensa: add asm-prototypes.h
      xtensa: report trax and perf counters in cpuinfo
      xtensa: drop ARCH_WANT_FRAME_POINTERS
      xtensa: move early_trap_init from kasan_early_init to init_arch
      xtensa: always install slow handler for unaligned access exception
      xtensa: rearrange unaligned exception handler
      xtensa: add load/store exception handler
      xtensa: rearrange show_stack output
      xtensa: dump userspace code around the exception PC

 arch/xtensa/Kconfig                      |  14 +-
 arch/xtensa/Kconfig.debug                |   8 +
 arch/xtensa/boot/boot-redboot/Makefile   |   9 +-
 arch/xtensa/include/asm/asm-prototypes.h |  29 ++++
 arch/xtensa/include/asm/asmmacro.h       |   1 +
 arch/xtensa/include/asm/core.h           |   8 +
 arch/xtensa/include/asm/ftrace.h         |   9 --
 arch/xtensa/include/asm/platform.h       |  20 ---
 arch/xtensa/include/asm/string.h         |   3 -
 arch/xtensa/include/asm/traps.h          |   7 +
 arch/xtensa/kernel/align.S               | 256 +++++++++++++++++++++----------
 arch/xtensa/kernel/mcount.S              |   1 +
 arch/xtensa/kernel/platform.c            |  29 ++--
 arch/xtensa/kernel/setup.c               |  41 ++++-
 arch/xtensa/kernel/stacktrace.c          |   4 -
 arch/xtensa/kernel/time.c                |   4 -
 arch/xtensa/kernel/traps.c               | 102 +++++++++---
 arch/xtensa/kernel/xtensa_ksyms.c        |  95 +-----------
 arch/xtensa/lib/Makefile                 |   3 +-
 arch/xtensa/lib/ashldi3.S                |   1 +
 arch/xtensa/lib/ashrdi3.S                |   1 +
 arch/xtensa/lib/bswapdi2.S               |   1 +
 arch/xtensa/lib/bswapsi2.S               |   1 +
 arch/xtensa/lib/checksum.S               |   2 +
 arch/xtensa/lib/divsi3.S                 |   1 +
 arch/xtensa/lib/lshrdi3.S                |   1 +
 arch/xtensa/lib/memcopy.S                |  19 +--
 arch/xtensa/lib/memset.S                 |   2 +
 arch/xtensa/lib/modsi3.S                 |   1 +
 arch/xtensa/lib/mulsi3.S                 |   1 +
 arch/xtensa/lib/strncpy_user.S           |   1 +
 arch/xtensa/lib/strnlen_user.S           |   1 +
 arch/xtensa/lib/udivsi3.S                |   1 +
 arch/xtensa/lib/umodsi3.S                |   1 +
 arch/xtensa/lib/umulsidi3.S              |   1 +
 arch/xtensa/lib/usercopy.S               |   1 +
 arch/xtensa/mm/kasan_init.c              |   2 -
 arch/xtensa/mm/misc.S                    |   5 +
 arch/xtensa/platforms/iss/setup.c        |  24 +--
 arch/xtensa/platforms/xt2000/setup.c     |  48 +++---
 arch/xtensa/platforms/xtfpga/setup.c     |  34 ++--
 41 files changed, 467 insertions(+), 326 deletions(-)
 create mode 100644 arch/xtensa/include/asm/asm-prototypes.h

-- 
Thanks.
-- Max
