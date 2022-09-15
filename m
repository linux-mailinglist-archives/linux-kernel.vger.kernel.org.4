Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155075B9284
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiIOCHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiIOCHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:07:36 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1508E9A3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:07:35 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id l14so4715552qvq.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=y/PHuSJ8wTSRrcbOr2aFg3n/97xYid7IyAo6M70Jk1o=;
        b=kBZaazuURI47oWhYdTUPIr4EE8inNQ1K3QD1izrAFfBg9My9CcgIUcuDxKTUTAvze6
         rs6oxg7LlK4s5IBmrjwGjZXUNVEmLJIVxLqgfkO+ca7zkuDwwI8s2PgrH0lr1xFK344M
         9+Qp923F5BKE+4jllIl0hXg/IAyZiLupiPDCC16dFJXGs1vs++iNxJxThZFidSi7hAW1
         KYaKevID+zmtCWUpe9mEk/odBC7hA0yHejFx/ul7q43KAZSiq62qa6qgW6HIcz49MbX5
         lWAaLx7TTGZF9kS8FXuh7CAKoaBacvmwjBS88SKHziDBK0+k+e3oJeXHMZU6dtixGIl0
         WrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=y/PHuSJ8wTSRrcbOr2aFg3n/97xYid7IyAo6M70Jk1o=;
        b=4fPQkrfAFfPZy2/5/QGKVsmd8NVsQqMhvSPHCNdgb1ZsH9bCvu+Ts/xGQ08aYG9dVJ
         m+c91L5iuzZd6VIbu4BJ1gQm2hbR+G16iNnuJTzokLu0eJFgJU5nNRRIOEJ5bwwRuudK
         eZvgoJrD90oaSs98a9nZaDktnVXr9T0PsOe/aIazp18Tpu78fDS9Jt6fdbxRTurnN/Dr
         Ej88jz+EdBJfnpVdvmC2sUtmNlxp2a6OphIIBTZzx9yc2jaZSCAKC8u5K2Wh33ZGduWq
         lpBohHR1yHpFFfqd9Fu6BLakM2BJXLgmTJutl1i9UYK7HkEFIuDCeijR/wtxEpWGZgeE
         IjGg==
X-Gm-Message-State: ACgBeo3LJxllFdLIeSHPdBHxFCSeSyDR95BiTiRWios3eOPhkmXdXyQ5
        e6EkgPA799fIxtVi+Rux/4i+I4ljQcE=
X-Google-Smtp-Source: AA6agR7OD8VEvonxaqWGUlifTIOq48JgArlx1JNiMPCLdPgIodpwOgYPBctdIisc+snKB8DgTdn+UQ==
X-Received: by 2002:a05:6214:c44:b0:4ac:ad73:4c6a with SMTP id r4-20020a0562140c4400b004acad734c6amr16939379qvj.14.1663207654355;
        Wed, 14 Sep 2022 19:07:34 -0700 (PDT)
Received: from localhost (96-87-29-153-static.hfc.comcastbusiness.net. [96.87.29.153])
        by smtp.gmail.com with ESMTPSA id e12-20020ac8670c000000b0035bb6298526sm2686062qtp.17.2022.09.14.19.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 19:07:34 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Valentin Schneider <vschneid@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 0/4] lib: optimize find_bit() functions
Date:   Wed, 14 Sep 2022 19:07:26 -0700
Message-Id: <20220915020730.852234-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the recent discussion, it was noticed that find_next_bit() functions may
be improved by adding wrappers around common __find_next_bit() in .c file.

As suggested by Linus, I tried the meta-programming trick with the
EXPRESSION macro, which is passed from wrapper into find_bit()
helpers:

  #define BIT_FIND_BODY(addr, size, start, EXPRESSION)          \
        BIT_FIND_SETUP(addr, size, start)                       \
        BIT_FIND_FIRST_WORD(addr, size, start, EXPRESSION)      \
        BIT_WORD_LOOP(addr, size, idx, val, EXPRESSION)         \
        return size;                                            \
  found:        BIT_WORD_SWAB(val);                             \
        return min((idx)*BITS_PER_LONG + __ffs(val), size)

  unsigned long _find_next_and_bit(const unsigned long *addr1,
                                 const unsigned long *addr2,
                                 unsigned long size,
                                 unsigned long start)
  { BIT_FIND_BODY(addr, size, start, addr1[idx] & addr2[idx]); }

I appreciated the potential of how the EXPRESSION works, but I don't like
that the resulting macro is constructed from pieces because it makes it
harder to understand what happens behind the ifdefery. Checkpatch isn't
happy as well because the final macro contains 'return' statement; and I
would agree that it's better to avoid it.

I spun the idea one more time, trying to make FIND helper a more or
less standard looking macro.

This new approach saves 10-11K of Image size, and is 15% faster in the
performance benchmark. See the 3rd patch for some statistics.

v1: https://lore.kernel.org/all/20220728161208.865420-2-yury.norov@gmail.com/T/
v2: https://lore.kernel.org/lkml/YwaXvphVpy5A7fSs@yury-laptop/t/
v3: https://lore.kernel.org/all/xhsmhedwnb15r.mognet@vschneid.remote.csb/T/
v4:
 - fix for-loop break condition in FIND_NEXT_BIT;
 - add review tags from Valentin Schneider.

Yury Norov (4):
  lib/find_bit: introduce FIND_FIRST_BIT() macro
  lib/find_bit: create find_first_zero_bit_le()
  lib/find_bit: optimize find_next_bit() functions
  tools: sync find_bit() implementation

 include/linux/find.h       |  46 +++++++---
 lib/find_bit.c             | 178 ++++++++++++++++++++++---------------
 tools/include/linux/find.h |  61 +++----------
 tools/lib/find_bit.c       | 149 ++++++++++++++-----------------
 4 files changed, 220 insertions(+), 214 deletions(-)

-- 
2.34.1

