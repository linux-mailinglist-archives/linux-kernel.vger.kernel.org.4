Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE61E5F1DC1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJAQkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiJAQkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:40:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3A630550
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 09:40:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n7so6425436plp.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 09:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=Yw2Hnw2B3YgrGU9Oa/MhTUu5FUGIUvGOjrQ/Ea03tSs=;
        b=gbDDpWOaQcIB/5zQI+N+qwgOGVDaAJyI08DqtJmK57OHMrLCfaNXr/CkykJclffE/v
         /hzjIaygeQFtbxQI3bnOi38VsxICoOa5OS+rIFahFH0KKztwbA6wZgStOPuF50stkRu7
         w9LerNtj3+/vdzrZAV3SmTk9v8VWExEYiKH88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Yw2Hnw2B3YgrGU9Oa/MhTUu5FUGIUvGOjrQ/Ea03tSs=;
        b=ghcWEXwf3QxaLmHfRBswpIyMO4JHX9DlaZcrL11lIsL+ExpQzCSfmrBAQ/CO3Fpftg
         bXBZ1w+7LRhrWLC/1NYcI9jJMwIm/uFFGY40CDaBj+eYn04oIPjC1wOjigtk/IxjIrWZ
         I5xNwpdJJi/QbZzIBGGEuskpt1365F9cM2MIG4K2zhgoWNlxRIiXoeT26XfQHHBX0q8h
         0NqJVoE2OLquxg/lK6vzFm1GJEcr7OAldPcHt6kMw8wZThmyfqSEhWQp9kUwJOXTvScb
         dmCC7Z3t6azqn3Ork9j6405jUTSyxvmmw2biRlaC8mZlTyxyuxJOZJyblGYD6K3JRIYJ
         EcqQ==
X-Gm-Message-State: ACrzQf3U7iDvVN/GamutYGzxaPy+jiStEojtfEPCgvfT7fO87auCHpl3
        2yl092qb07QmRQqO+9hpiQ2S7g==
X-Google-Smtp-Source: AMsMyM4l8Kb1tMPt9/4jcDl/BPpEciUuhpA1PFePcAM7PbCtIYrWvuAhHDl2jx7DRO5XtuY7Ily1Iw==
X-Received: by 2002:a17:90b:38d1:b0:200:8178:1c94 with SMTP id nn17-20020a17090b38d100b0020081781c94mr4084516pjb.219.1664642413219;
        Sat, 01 Oct 2022 09:40:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i198-20020a6287cf000000b00540c8ed61ddsm3943444pfe.150.2022.10.01.09.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 09:40:12 -0700 (PDT)
Date:   Sat, 1 Oct 2022 09:40:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [GIT PULL] execve updates for v6.1-rc1
Message-ID: <202210010938.3922D4DCE@keescook>
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

Please pull these execve updates for v6.1-rc1. This removes a.out
support globally; it has been disabled for a while now.

Thanks!

-Kees

The following changes since commit 33a2d6bc3480f9f8ac8c8def29854f98cc8bfee2:

  Revert "fs/exec: allow to unshare a time namespace on vfork+exec" (2022-09-13 10:38:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.1-rc1

for you to fetch changes up to 9f4beead610c83065cc0410bfe97ff51d8e9578d:

  binfmt: remove taso from linux_binprm struct (2022-09-29 16:38:05 -0700)

----------------------------------------------------------------
execve updates for v6.1-rc1

- Remove a.out implementation globally (Eric W. Biederman)

- Remove unused linux_binprm::taso member (Lukas Bulwahn)

----------------------------------------------------------------
Eric W. Biederman (1):
      a.out: Remove the a.out implementation

Lukas Bulwahn (1):
      binfmt: remove taso from linux_binprm struct

 MAINTAINERS                           |   1 -
 arch/alpha/include/asm/a.out.h        |  16 --
 arch/alpha/kernel/Makefile            |   4 -
 arch/alpha/kernel/binfmt_loader.c     |  46 -----
 arch/alpha/kernel/osf_sys.c           |  30 ---
 arch/arm/configs/badge4_defconfig     |   1 -
 arch/arm/configs/corgi_defconfig      |   1 -
 arch/arm/configs/ezx_defconfig        |   1 -
 arch/arm/configs/footbridge_defconfig |   1 -
 arch/arm/configs/hackkit_defconfig    |   1 -
 arch/arm/configs/iop32x_defconfig     |   1 -
 arch/arm/configs/jornada720_defconfig |   1 -
 arch/arm/configs/lart_defconfig       |   1 -
 arch/arm/configs/neponset_defconfig   |   1 -
 arch/arm/configs/netwinder_defconfig  |   1 -
 arch/arm/configs/rpc_defconfig        |   1 -
 arch/arm/configs/spitz_defconfig      |   1 -
 fs/Kconfig.binfmt                     |  33 ----
 fs/Makefile                           |   1 -
 fs/binfmt_aout.c                      | 342 ----------------------------------
 fs/exec.c                             |   3 +-
 include/linux/a.out.h                 |  18 --
 include/linux/binfmts.h               |   3 -
 23 files changed, 1 insertion(+), 508 deletions(-)
 delete mode 100644 arch/alpha/include/asm/a.out.h
 delete mode 100644 arch/alpha/kernel/binfmt_loader.c
 delete mode 100644 fs/binfmt_aout.c
 delete mode 100644 include/linux/a.out.h

-- 
Kees Cook
