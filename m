Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA276553AE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 19:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiLWSkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 13:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiLWSkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 13:40:07 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BEF1D327
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 10:40:04 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso9483391pjp.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 10:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/K5s6GQ5c0Fl7h8Q3vjGYSICC8DwtoPDk3CYf+DbHR0=;
        b=bBjEl+jjssxnMJPc+K1JNmIFXEx2lWOLSHwlOQ/M3JiZ58DP+dad09cwvP8wsY1FYU
         UkHtTeG7i9TaXVCNDzwlbqyj2ZezrKd06FybmG8T4GF8DkYbJRJE5KupEi8zCYWt2/Oj
         HeVm5TOzkkwncKxD/gB9vB4CNxhy08X0/FEFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/K5s6GQ5c0Fl7h8Q3vjGYSICC8DwtoPDk3CYf+DbHR0=;
        b=nfbd7rr+3D/ZRxRUAIjv76HpXYtVLENbXyR2PQZmTFeEHqY6YRWHLMplMEnDNtufoW
         jZhfqBg4ZpxW6fupeKOXceJgXBKJ2ZCCJ1U3o2W/C0RFrzdspTRaJYRYFWdjK0D6XzUi
         BTo/zahTXjNgelxP/fp8e3yq6vK8qYH6tSgAA9zX/fOaLpGRO+fuVOCu4j6khhai3Q9L
         TvsVZMln0KwuJy43KgxsYEqD9ZqQSfJ/yu47j2AZhcSCzZlBEyZWVTqeSlVfdDKg6y2N
         Bru+AUbCzyzxPp51lsH3JOUPZMS4qBWHvsREjSAd0Ctt+2UaW+Zjo0wbAzmkopmDCKZ8
         Hjmg==
X-Gm-Message-State: AFqh2kp9KUaxEQEqn+ZTKx31Pj2UhM0VGe+Ca0nGgnGeoL0lZGRHjgq2
        +7geu+1qiqe7ajoAR0ANk5Wi0A==
X-Google-Smtp-Source: AMrXdXs+QHPmxwDy7aPJ1g+JYLej95aQhHI3yqa4ZuGWIBwyQi/3+rmMhhK70nTpgnK71s48rvMTEg==
X-Received: by 2002:a05:6a21:788f:b0:b2:2e66:482d with SMTP id bf15-20020a056a21788f00b000b22e66482dmr17159162pzc.50.1671820804375;
        Fri, 23 Dec 2022 10:40:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f17-20020a63f751000000b0047712e4bc51sm2576700pgk.55.2022.12.23.10.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 10:40:03 -0800 (PST)
Date:   Fri, 23 Dec 2022 10:40:03 -0800
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
Subject: [GIT PULL] kernel hardening fixes for v6.2-rc1
Message-ID: <202212231039.504D027B9@keescook>
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

Please pull these kernel hardening fixes for v6.2-rc1. (Yay typos.)

Thanks!

-Kees

The following changes since commit d272e01fa0a2f15c5c331a37cd99c6875c7b7186:

  ksmbd: replace one-element arrays with flexible-array members (2022-12-02 13:14:29 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.2-rc1-fixes

for you to fetch changes up to cf8016408d880afe9c5dc495af40dc2932874e77:

  cfi: Fix CFI failure with KASAN (2022-12-23 10:04:31 -0800)

----------------------------------------------------------------
kernel hardening fixes for v6.2-rc1

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
