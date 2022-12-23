Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762CF65537E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 19:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiLWSKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 13:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiLWSKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 13:10:30 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F16415A35
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 10:10:21 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id t2so5609843ply.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 10:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+W6znzYikgthIHqAsodQzTODii43I4pz6o86CSVkKY=;
        b=NlxFzFp6oxhdJwdm+cyc7GSZ5WJfeNogbUly2rKcbycHh9aBY/vO1gIiMTnoRjQ8xQ
         JjKiW2lody/8COOPqjoaDGWHHbuYINcwBh0xKkEF3DZUBwDExEwlSdbgjnYRt3M8Tuvg
         2DFn9Rk2qE9RSyWXqO003OUNPjC74700ZcM1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+W6znzYikgthIHqAsodQzTODii43I4pz6o86CSVkKY=;
        b=mi5SSkKCfQ56nERW7CzUdR0/Tcj4w/MH9wa2Edst3kb7euLA7BYuALSmXHWVvXw5VW
         sTDaFZlnIYMqKcNFpaB8eu1S61sAlFWpRGcfmAI1wIWHAWNlgPeEqr99A2VuybtcCu2x
         IU+YqtUha83okkI4D5A/HtQ5tKQZcKfh/9TPhLfVr7hYFQ+y1vhKdsEcNPXpC8f2hNBJ
         nb8wlZRhbze3UFDQCUA2ckW1QO7K67Ir96PH3WPvPKDeGWovBleecy8tCYtfntCdRZXU
         r9hhVgIK3/Y2r0L88Tbfb6KVXwV/yW4XZOMODfF8aapJ8SImXR+Pk2cyW38PqFuXFTLt
         bHvA==
X-Gm-Message-State: AFqh2kqa1SdREpmW34SenAF1JGycl1mvZ8O9glFhax2vv288Rnw1qnUx
        avR2ReEl9ceiHxqMIAH8fnIObA==
X-Google-Smtp-Source: AMrXdXuNZNPYkACiKVfKc6KMMM98DCtIMH4HjpMg1lJrM6gl1VxbK+WW95O+/CAFdZNlRfCRFMjh9A==
X-Received: by 2002:a17:902:7488:b0:189:f708:9b67 with SMTP id h8-20020a170902748800b00189f7089b67mr11585591pll.46.1671819020829;
        Fri, 23 Dec 2022 10:10:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902e54200b001887e30b9ddsm2633377plf.257.2022.12.23.10.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 10:10:20 -0800 (PST)
Date:   Fri, 23 Dec 2022 10:10:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        tangmeng <tangmeng@uniontech.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [GIT PULL] kernel hardening fixes for v6.1-rc1
Message-ID: <202212231009.EC864645D8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these kernel hardening fixes for v6.1-rc1, collected over the
last week.

Thanks!

-Kees

The following changes since commit d272e01fa0a2f15c5c331a37cd99c6875c7b7186:

  ksmbd: replace one-element arrays with flexible-array members (2022-12-02 13:14:29 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.1-rc1-fixes

for you to fetch changes up to cf8016408d880afe9c5dc495af40dc2932874e77:

  cfi: Fix CFI failure with KASAN (2022-12-23 10:04:31 -0800)

----------------------------------------------------------------
kernel hardening fixes for v6.1-rc1

- Fix CFI failure with KASAN (Sami Tolvanen)

- Fix LKDTM + CFI under GCC 7 and 8 (Kristina Martsenko)

- Limit CONFIG_ZERO_CALL_USED_REGS to Clang > 15.0.6 (Nathan Chancellor)

- Ignore "contents" argument in LoadPin's LSM hook handling

- Fix paste-o in /sys/kernel/warn_count API docs

- Use READ_ONCE() consistently for oops/warn limit reading

----------------------------------------------------------------
Kees Cook (3):
      LoadPin: Ignore the "contents" argument of the LSM hooks
      docs: Fix path paste-o for /sys/kernel/warn_count
      exit: Use READ_ONCE() for all oops/warn limit reads

Kristina Martsenko (1):
      lkdtm: cfi: Make PAC test work with GCC 7 and 8

Nathan Chancellor (1):
      security: Restrict CONFIG_ZERO_CALL_USED_REGS to gcc or clang > 15.0.6

Sami Tolvanen (1):
      cfi: Fix CFI failure with KASAN

 Documentation/ABI/testing/sysfs-kernel-warn_count |  2 +-
 drivers/misc/lkdtm/cfi.c                          |  6 ++++-
 kernel/Makefile                                   |  3 ---
 kernel/exit.c                                     |  6 +++--
 kernel/panic.c                                    |  7 ++++--
 security/Kconfig.hardening                        |  3 +++
 security/loadpin/loadpin.c                        | 30 ++++++++++++++---------
 7 files changed, 36 insertions(+), 21 deletions(-)

-- 
Kees Cook
