Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E330745783
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjGCIjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjGCIjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:39:23 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1498FD1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:39:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc0981756so38838665e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 01:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688373560; x=1690965560;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0b8WPxUgG/kLpFlfKimQGwlhM3L/BCb5GZU2JKKXVJw=;
        b=EwcnimWgRym2GXpY5uxc6sFan/nUO913/OHvUHJLP8U3gbFiTM4lNyIihBf8XMM01i
         GIu6tu3aHXwTnqIZqNm2gzoARTzpfA5isImmuzbsEsufgB+8wOMFoX/hkSFf7CMPkXs/
         UJuapvtpnQDmcA/9JMsLCTb5nL4Okd4/E5ujFbyCZ+ZLfrGzo2fFSz7Iv6RH73TMOYy5
         SpI5HBlxeGHQJDdB0neurT+bnan8t5AuvepJSSedM0LWEwttEwrqR8/lb3KP786IiAav
         yOJS0HeyD4e95pTpiB9h5uYSifMmmnAqrbhPYw1BQUi34FuqmJruZVM6kQue41weJGQR
         MzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688373560; x=1690965560;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0b8WPxUgG/kLpFlfKimQGwlhM3L/BCb5GZU2JKKXVJw=;
        b=GJrApg9GOBetaQ5/Pty8k8jRpANxkS0USpkt7sA0u0SE/kJoBiXzLwNbzWVu4d4W8x
         N4uRLV1jLPaL0fEbV4LRazdLiWIKZKx9OWtf5kiZVVkbhcC4LCiECfdsJHi2//wpVEgH
         i2rOrCPaAMH8G4NBO9904T2pnHjNEplVog8/rdC0giezlqRcuMX1S5zf0SocrLuBI/Ub
         ljaxGSS44N8g4yzYRmtlY/JUvWJQuGK6qKToufU/XA1+9T/q2QXPVFk+hV6DbR+8bmFp
         wLHXEr1AWWRkumhEs9lawJ3ubcu57Dt8R3kmiee0mahtk1T1d5Rg9Q1xK3KyNkybXuc/
         e39g==
X-Gm-Message-State: AC+VfDzPegMs3SYGdtStFr3uPuDnWOGSRb5GgY3FsvAnPtCUkikgU87k
        Y3SLpcKrZez6pS79YJuYp0WxoaJrASYZSKSPjiHxkg==
X-Google-Smtp-Source: ACHHUZ4tN0f2cwe7Jy2PeqpxFL2IHeXmigP3M9C8jQYp0FF1Q2v+M4zpGUp6MNPxCrfvOnzhnAhHbw==
X-Received: by 2002:a7b:cd8f:0:b0:3fb:c225:1b21 with SMTP id y15-20020a7bcd8f000000b003fbc2251b21mr7198629wmj.14.1688373560468;
        Mon, 03 Jul 2023 01:39:20 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b003f733c1129fsm17489909wmc.33.2023.07.03.01.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 01:39:20 -0700 (PDT)
Date:   Mon, 3 Jul 2023 09:39:18 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] kgdb changes for v6.5
Message-ID: <20230703083918.GA5601@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.5-rc1

for you to fetch changes up to b6464883f45ae6412de33e53587974fd86ba811e:

  kdb: move kdb_send_sig() declaration to a better header file (2023-07-03 09:27:12 +0100)

----------------------------------------------------------------
kgdb patches for 6.5

Fairly small changes this cycle.

 * An additional static inline function when kgdb is not enabled to
   reduce boilerplate in arch files.
 * kdb will now handle input with linefeeds more like carriage return.
   This will make little difference for interactive use but can make
   it script to use expect-like interaction with kdb.
 * A couple of warning fixes.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      kdb: include kdb_private.h for function prototypes

Daniel Thompson (1):
      kdb: move kdb_send_sig() declaration to a better header file

Douglas Anderson (2):
      kgdb: Provide a stub kgdb_nmicallback() if !CONFIG_KGDB
      kdb: Handle LF in the command parser

 include/linux/kdb.h             |  2 ++
 include/linux/kgdb.h            |  1 +
 kernel/debug/kdb/kdb_io.c       | 16 +++++++++++++++-
 kernel/debug/kdb/kdb_keyboard.c |  2 ++
 kernel/debug/kdb/kdb_private.h  |  1 -
 5 files changed, 20 insertions(+), 2 deletions(-)
