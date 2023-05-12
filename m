Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D52E700B01
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjELPFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241713AbjELPFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:05:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25414100E8
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:05:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6438d95f447so7086222b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683903921; x=1686495921;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrSKXQMrxZy3B2xcqbpKyp9JfcjpHClnhEvXrHIQx28=;
        b=swn0xzMao9c+7wrFYVIGTExuBibZc6aUZAGfyeRYhTp3aZXqqRNaof4AjCvfETX9V5
         YVvP2yfwG/AQUbdBkHmnHm200r3rHSfwrcCx2k9mxADy118J5re3bfA9WTgDSlvodFLS
         XI91/xIlACifIiItrxtMuZ098pEluhpiEXdk/zk87MmN2MxROEgcKJupCTS3GdX0BuUe
         eNDT3TPWLXc+ERsUTgLVuQc9XS/lZMsSgtz0U4Rws3HUZmRrAAqdLld1w2d0PDUsR4E8
         oBmIIxo8bZwaKIe4kxIm+2Ry3p72SwgJC7pFCXtd744yUwidLo3l4bLdOtgZOopo/Yib
         0BWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683903921; x=1686495921;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrSKXQMrxZy3B2xcqbpKyp9JfcjpHClnhEvXrHIQx28=;
        b=Jgxv7nI9sRonPZ534rw7Qivd1sskDQ/k0zUVbOihyPKhS/bqI6YPcUGFOgG4mdzQOo
         iIi3C0QmCsLSu3mQkyoLjtoEhOJ1mAK/hm9eb8cSQsvgqIGM3jb0TAlKGLoAfMYnfyHB
         EElGYiHRAklc2b7d4DrPu7PNj1E+c3l+HymqQMJqSGmg2HsgeS/mLaWlWNHJO9zt3AjM
         43DQLEhw2U9dot1jnv0njzVBfTnYOJeFVEXtX8gO1T8zwr9g/GCkqxJB7T1Icq8UK+AR
         FE79I2oxFpzfiWN5mLNMUT4aBtxuNDvWafbOoGLuTm8HEoBCOcapwXFe4RGwCF0JRi9/
         NwRw==
X-Gm-Message-State: AC+VfDyIUltS7VVL1PrniOiTihSqOJjJXEJLLZj/FoYhhPzIuNsx32sj
        tUPK9elMFGu39s6txLg8kgiOLHOX/N2UbKySKfA=
X-Google-Smtp-Source: ACHHUZ7quZ/W/3oBQEaRf/HYdJB9y9lDWuJfi0McS7LZztm4C7a7wfdb5/pX6q0IS1pfwSYdHzYviQ==
X-Received: by 2002:a05:6a20:8e03:b0:104:2226:1b96 with SMTP id y3-20020a056a208e0300b0010422261b96mr6492368pzj.22.1683903921429;
        Fri, 12 May 2023 08:05:21 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090a408500b0024c1ac09394sm17325869pjg.19.2023.05.12.08.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 08:05:20 -0700 (PDT)
Date:   Fri, 12 May 2023 08:05:20 -0700 (PDT)
X-Google-Original-Date: Fri, 12 May 2023 08:05:12 PDT (-0700)
Subject: [GIT PULL] RISC-V Fix for 6.4-rc2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-f7f97b7f-e3aa-4fff-abc7-19439d1720fe@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-rc2

for you to fetch changes up to 3b90b09af5be42491a8a74a549318cfa265b3029:

  riscv: Fix orphan section warnings caused by kernel/pi (2023-05-09 18:20:23 -0700)

----------------------------------------------------------------
RISC-V Fix for 6.4-rc2

* A fix to the linker script to avoid orpahaned sections in kernel/pi.

----------------------------------------------------------------
Just a single fix this week for a build issue.  That'd usually be a good sign,
but we've started to get some reports of boot failures on some
hardware/bootloader configurations.  Nothing concrete yet, but I've got a funny
feeling that's where much of the bug hunting is going right now.

Nothing's reproducing on my end, though, and this fixes some pretty concrete
issues so I figured there's no reason to delay it.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Fix orphan section warnings caused by kernel/pi

 arch/riscv/kernel/pi/Makefile   | 2 +-
 arch/riscv/kernel/vmlinux.lds.S | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)
