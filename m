Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A603F610122
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiJ0TIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiJ0TIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:08:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5BC66867
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:08:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b29so2547252pfp.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pz8zXqY+zopYmFYEDPYp4rZ/wqA2DduP8+Q5Z49opO0=;
        b=f3rr8QI97B9OqJZ7yUoma9kH33i0pAPXYTq+vR+V+kGWyCm2m5w2/Vl/qgLHgq9jUd
         KwZLIVXaJC+NVVhp2GOPRW+cdnVbazCcG1n0oQmXzxxzNy8kXPY4wyfkMtmeSKvutMMb
         cjQZto9sV4T1SGgsHs0qfO3Hw4XFvcIo+gsck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pz8zXqY+zopYmFYEDPYp4rZ/wqA2DduP8+Q5Z49opO0=;
        b=LfElNySXKkLa07l++VkJk9iIBZacrXTk1h4HzPbK8muWyD9se3ddls4llTTAZJHwDd
         1bhjW4aFyI4jL6GyWEnJCOWh66WjJtaqGLqlPHmOfCSJU1dRAbdmszVWIQBOSRG0bdzg
         ipmzwtMvlT9FMw8ssWjSFCdK3F9FTM5uCAO3aO8Ya8Fxrj2RPHtbD83GWnrn0PrpZDRv
         ScAUrhHZooSThyKOddHjO1ygNIrOdgpP1Rzw1qfRNs44C/0wupI1IgjgSmWTSCD1wl3K
         bx7vOs11jnD87uAAOYlshznzQ9i4Kuo/DJvRcTHvvkpo7pCrmt/dWCYJw6DmZQmd83ZK
         Y9SA==
X-Gm-Message-State: ACrzQf0vvCZiYEIZ5s5hWwYoU9Fucq0rAPWuEX/9fWsWD83L3VC0M9ik
        cW5pjRy/BxArKj60LqgOSRhMpw==
X-Google-Smtp-Source: AMsMyM5psMP1Kjl6M6/IZVs9P7TYkYRPX8B8obpiMvGw2hCzaSYLSFelZlouKfs9/YmJKcJhnuLKGw==
X-Received: by 2002:a65:6944:0:b0:43c:da07:5421 with SMTP id w4-20020a656944000000b0043cda075421mr44276826pgq.72.1666897723139;
        Thu, 27 Oct 2022 12:08:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ead200b00176a6ba5969sm1533611pld.98.2022.10.27.12.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 12:08:42 -0700 (PDT)
Date:   Thu, 27 Oct 2022 12:08:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Kees Cook <keescook@chromium.org>,
        Li Zetao <lizetao1@huawei.com>
Subject: [GIT PULL] execve fixes for v6.1-rc3
Message-ID: <202210271208.CBD42E5E9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these execve fixes for v6.1-rc3.

Thanks!

-Kees

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.1-rc3

for you to fetch changes up to 594d2a14f2168c09b13b114c3d457aa939403e52:

  fs/binfmt_elf: Fix memory leak in load_elf_binary() (2022-10-25 15:11:21 -0700)

----------------------------------------------------------------
execve fixes for v6.1-rc3

- Fix an ancient signal action copy race. (Bernd Edlinger)

- Fix a memory leak in ELF loader, when under memory pressure. (Li Zetao)

----------------------------------------------------------------
Bernd Edlinger (1):
      exec: Copy oldsighand->action under spin-lock

Li Zetao (1):
      fs/binfmt_elf: Fix memory leak in load_elf_binary()

 fs/binfmt_elf.c | 3 ++-
 fs/exec.c       | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
Kees Cook
