Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128086439E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiLFAYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLFAYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:24:46 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B844B1EAC1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:24:45 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so16497931pjp.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 16:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fSn64lA6oOBfrAoW7WXj8/H2jGDtpKbMdr3HnhRjW6w=;
        b=fJv0gtp8ktPanlVZErSowEpOjCG8B3RTWc11iBQ6wIpfTbZitDiCgPsmrQqUCyGwiJ
         EqvkYItD2U569jtY/PRs0n2sQz9LsvQ6otQ1yY1gm4t0d4lP9cYx8CGRWYXPbsHBQPdc
         uPuYQqXMZc9EF9SO4akrJo/p20rEPOkwIMRiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSn64lA6oOBfrAoW7WXj8/H2jGDtpKbMdr3HnhRjW6w=;
        b=M/Z018ayNKnqKRyVAqHrjhmaFrVuwO0JyMdPjKpvKOp+1ers1D/FffAx2VC2tud8bv
         8zQaINuhtfD567n/PIa+GaKa28J8N+vI/+16iHtwpLnUK6rJ9kxnV5PFpn7jpgf1NoFu
         mgu22H7iZmB5TAgFI6N0hA5uY41rqgZtYfK4W1QXeObGHn3UYHpTjPW/piA7Yazrl2ER
         hoSQFXaIXjVOx9Rmv/9yz4s+SIbYojvWRZSu/ItjqJIBL4C9sI/+v+JQfiNGmAzUdWgA
         c+rCwiU/xBUWp5Y3H+m0Ja5YldX+Z38XFpTg7d4qNXS8KZGJJ/4ZlcxAWVL7hxXyufl2
         LoSQ==
X-Gm-Message-State: ANoB5pm3wZtx24WwR2oCXtnLbHbK9mD6CU3+HzIbi/u5v0NR7grhoBrO
        w7T4BSUV+h18Mjp2FbiNmOcALvgumjF+UvI1
X-Google-Smtp-Source: AA0mqf61oim4nORZhPCJehsh7G9AigpD+lO7T5lsPjLavGi14J68n81A1rfoxn0zmi1mhLm2fhV6qg==
X-Received: by 2002:a17:902:f643:b0:188:9ae7:bb81 with SMTP id m3-20020a170902f64300b001889ae7bb81mr80344261plg.66.1670286285221;
        Mon, 05 Dec 2022 16:24:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t23-20020aa79477000000b00575d6dc996bsm8811536pfq.161.2022.12.05.16.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:24:44 -0800 (PST)
Date:   Mon, 5 Dec 2022 16:24:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Colin Cross <ccross@android.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Paramjit Oberoi <pso@chromium.org>,
        Qiujun Huang <hqjagain@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Wang Yufen <wangyufen@huawei.com>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>
Subject: [GIT PULL] pstore updates for v6.2-rc1
Message-ID: <202212051623.33FD7D5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these pstore updates for v6.2-rc1. It's a small collection
of bug fixes, refactorings, and general improvements noted below.

Thanks!

-Kees

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.2-rc1

for you to fetch changes up to e6b842741b4f39007215fd7e545cb55aa3d358a2:

  pstore: Avoid kcore oops by vmap()ing with VM_IOREMAP (2022-12-05 16:15:09 -0800)

----------------------------------------------------------------
pstore updates for v6.2-rc1

- Reporting improvements and return path fixes (Guilherme G. Piccoli,
  Wang Yufen, Kees Cook).

- Clean up kmsg_bytes module parameter usage (Guilherme G. Piccoli).

- Add Guilherme to pstore MAINTAINERS entry.

- Choose friendlier allocation flags (Qiujun Huang, Stephen Boyd).

----------------------------------------------------------------
Guilherme G. Piccoli (5):
      pstore: Improve error reporting in case of backend overlap
      pstore: Expose kmsg_bytes as a module parameter
      pstore: Inform unregistered backend names as well
      efi: pstore: Follow convention for the efi-pstore backend name
      pstore: Alert on backend write error

Kees Cook (5):
      pstore/ram: Consolidate kfree() paths
      pstore/ram: Move pmsg init earlier
      pstore/ram: Move internal definitions out of kernel-wide include
      pstore/ram: Set freed addresses to NULL
      MAINTAINERS: Update pstore maintainers

Qiujun Huang (1):
      pstore/zone: Use GFP_ATOMIC to allocate zone buffer

Stephen Boyd (1):
      pstore: Avoid kcore oops by vmap()ing with VM_IOREMAP

Wang Yufen (1):
      pstore/ram: Fix error return code in ramoops_probe()

 MAINTAINERS                       |  8 ++--
 drivers/firmware/efi/efi-pstore.c |  2 +-
 fs/pstore/platform.c              | 25 ++++++++--
 fs/pstore/ram.c                   | 44 +++++++++--------
 fs/pstore/ram_core.c              | 20 ++++++--
 fs/pstore/ram_internal.h          | 98 ++++++++++++++++++++++++++++++++++++++
 fs/pstore/zone.c                  |  2 +-
 include/linux/pstore_ram.h        | 99 ---------------------------------------
 8 files changed, 165 insertions(+), 133 deletions(-)
 create mode 100644 fs/pstore/ram_internal.h

-- 
Kees Cook
