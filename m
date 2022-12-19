Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4661165143B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiLSUq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiLSUqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:46:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C84120A5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:46:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z17-20020a25e311000000b00719e04e59e1so12092488ybd.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NV6WBBu4eI6YMtgjaGT7Oej7x3xxNbQTIC5eaXZoYAk=;
        b=W888lr4QI2BJ31+socKSVmNlPWGpZYcjEx2iUq9OSJHUU0oIwM/GaDpUiwZufVXIhI
         cCzoWHFxaIDWvjs8UevdT9NYFtnP2TmOE4yEWcVIAzis58oXiIsvrjCvo5ZrsNt2Qw5R
         NM96KrcXx5zEJG5yDLASvX7b/eKrFVq5ZUcEs0CtLF4oi1XeZMKvIzZA3gWEw/KGFR+1
         RgkOc4OUF6W83bNAcTsQp47JH31oEEkpHcdvS6gi9Z/k9By4jJAbJGALl7ngNRjU8Dx/
         wC3AnzNOAHctvwsZ8R/nUJNXNDoG9G3zjttBjUrg3jTTkPam5uA28/EMs7ZaoqpYd5vS
         Qe/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NV6WBBu4eI6YMtgjaGT7Oej7x3xxNbQTIC5eaXZoYAk=;
        b=mj1IhYMt4dRYFoRam2ZT6IIcr5PCRyVqs/uEGyWjhkSfoUsIDTdwaPSXGnrFmeMrgn
         3ZShM504LmiV9qVd89Rz4Re0G6+a7CGQ31vcgYMpg9NAS6JPvU8++umjFOS99fXyYWTJ
         sKsu27AMnVYpaJYnBN43J51Y1vrsKvNPNto4vl7cietS6PtuzT/SlGNNkDdbgx6r8yMu
         yDGsmkQsUWrnxSa1e0r/Amewk+VScfi2+fylY4qAcpCyS33DfM7HRgM2Q/jPnthr6EW6
         e0pWQT344y44Xf2RJLBDfpCqnD19Cu3uu7wS4gVkJ50zcApoLBSGC6wX6psoxQElB3h6
         +YkQ==
X-Gm-Message-State: AFqh2kogWRhFSorcOEO3Tm2D9BMmbB4TJA9ZGxoeElvVPge7itKKT+m4
        Np6rTzEkWAx3orN6icWYVZ1vEp6luqDqUi8=
X-Google-Smtp-Source: AMrXdXsJNP7J9KnpYRNg3mE1BM/X2PEmEWHiFIalYpF5KgHbUgp4e/KC6ExGC/9s4UtH7jlIMLik+f4PmtHOcho=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a25:ca4c:0:b0:735:b280:6964 with SMTP id
 a73-20020a25ca4c000000b00735b2806964mr1487492ybg.361.1671482781888; Mon, 19
 Dec 2022 12:46:21 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:46:08 -0600
In-Reply-To: <20221219191855.2010466-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219204619.2205248-1-allenwebb@google.com>
Subject: [PATCH v9 00/10] Generate modules.builtin.alias from match ids
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generate modules.builtin.alias from match ids

This patch series (v8) generates `modules.builtin.alias` during modpost.
The goal is for tools like USBGuard to leverage not only modules.aliases
but also `modules.builtin.aliases` to associate devices with the modules
that may be bound before deciding to authorize a device or not. This is
particularly useful in cases when new devices of a particular type
shouldn't be allowed part of the time like for lock screens.

Also included in this series are added documentation, style fixes and
fixes for build breakages for built-in modules that relied on
MODULE_DEVICE_TABLE being a no-op. Some of these were typos in the
device table name and one ifdef-ed out the device table.

--

# Generate modules.builtin.alias from match ids

This series (v8) adds missing `cc:stable` and `fixes:` commit tags to
the relevant commits. It is unlikely these drivers were being built as
modules because compilation would have failed. It also updates the build
documentation to cover `modules.builtin.alias`.

Note, cover letters were first added in v5.

  RFC (broken patch): https://lore.kernel.org/lkml/CAJzde042-M4UbpNYKw0eDVg4JqYmwmPYSsmgK+kCMTqsi+-2Yw@mail.gmail.com/
  v1 (missing v1 label): https://lore.kernel.org/lkml/20221111152852.2837363-1-allenwebb@google.com/
  v2 (missing v2 label): https://lore.kernel.org/lkml/20221128201332.3482092-1-allenwebb@google.com/
  v3: https://lore.kernel.org/lkml/20221129224313.455862-1-allenwebb@google.com/
  v4: https://lore.kernel.org/lkml/20221130221447.1202206-1-allenwebb@google.com/
  v5: https://lore.kernel.org/lkml/20221201211630.101541-1-allenwebb@google.com/
  v6: https://lore.kernel.org/lkml/20221202224540.1446952-1-allenwebb@google.com/
  v7: https://lore.kernel.org/lkml/20221216221703.294683-1-allenwebb@google.com/
  v8: https://lore.kernel.org/lkml/20221219191855.2010466-1-allenwebb@google.com/
  v9: This version

## Patch series status

This series is still going through revisions in response to comments.

I believe there is potential to improve the Makefile part of the patch
series as well as an open question of whether modpost should generate
`modules.built.alias` directly or create a vmlinuz.mod.c containing the
missing module info for the match-id based aliases for built-in modules.

## Acknowledgements

Thanks to Greg Kroah-Hartman, Christophe Leroy, Luis Chamberlain and the
other Linux maintainers for being patient with me as I have worked
through learning the kernel workflow to get this series into a more
presentable state.

Thanks to Luis Chamberlain for raising the alternative of using kmod to
address the primary motivation of the patch series.

Also, thanks to Intel's kernel test robot <lkp@intel.com> for catching
issues that showed up on different kernel configurations.


Allen Webb (10):
  imx: Fix typo
  rockchip-mailbox: Fix typo
  scsi/BusLogic: Always include device id table
  stmpe-spi: Fix typo
  module.h: MODULE_DEVICE_TABLE for built-in modules
  modpost: Track module name for built-in modules
  modpost: Add -b option for emitting built-in aliases
  file2alias.c: Implement builtin.alias generation
  build: Add modules.builtin.alias
  Documentation: Include modules.builtin.alias

 .gitignore                         |  1 +
 Documentation/kbuild/kbuild.rst    |  6 ++
 Makefile                           |  1 +
 drivers/mailbox/rockchip-mailbox.c |  2 +-
 drivers/mfd/stmpe-spi.c            |  2 +-
 drivers/scsi/BusLogic.c            |  2 -
 drivers/soc/imx/imx8mp-blk-ctrl.c  |  2 +-
 include/linux/module.h             | 15 ++++-
 scripts/Makefile.modpost           | 17 +++++-
 scripts/mod/file2alias.c           | 94 +++++++++++++++++++++++-------
 scripts/mod/modpost.c              | 23 +++++++-
 scripts/mod/modpost.h              |  2 +
 12 files changed, 137 insertions(+), 30 deletions(-)

-- 
2.37.3

