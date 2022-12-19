Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0426512B0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiLSTTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiLSTTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:19:00 -0500
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949EF11804
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:18:59 -0800 (PST)
Received: by mail-oi1-x249.google.com with SMTP id u18-20020a056808115200b0035a0dff88f9so2712890oiu.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiMsBFbuAwwWsYZNb0dq7gOOooiEFAWwdKh7AXEOnMI=;
        b=tG6Uh3Z9k4jSwxOaxcN6OQxf4A6DyUPQN+PXW+hziPymUkCM9V6sWgKzGQFEjiPvnk
         l8ZiG6ScI3h7Tl6DLWNhreYHLKlhzuA/bfH+IxOgrZm5Mi4KyMF1Olu8Kx1u7+8Q8pjV
         P3/oBaT5dSxMpVqWFG7Y1189wi+y+sXb4JGAfQ+CQHQsSifhGYIs2uQDuEs8FmzWWCoK
         u27LXxUyHmVi5cHa63muTYGy7nmuM93PjZuja1+fYw62O0XgCTfIoGOhUXkqe/u1gBFV
         f0eOEmnLPcn3+X0bEuk4CIGrgqTspj058qgQhdu2GxJEpA8iTcYsnW8eO99RYiq+ofX4
         +NpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiMsBFbuAwwWsYZNb0dq7gOOooiEFAWwdKh7AXEOnMI=;
        b=VoWCIa9wgJnEWlYA2qOT8d1oJF5bumFrW7EEQJbrracnVyFa11lwySbxRODKmnmRSe
         yy3Dt6wt7JHPnJV6eNOUri/w8R2RN95yoCmdud7xMi4bNFlXK1UdF0i69WolVHZ2n5EE
         P4E27PSHxks87IsWUoUHr0+CAZx2m0TPoOMq52oZ1+YT/YOPCFgwwmpc6UCEhXjq7rPE
         BbKac/WLxgd38I2yJGhiYiiN7Z7d5eluHQc53KzPdu+jCaKfO0YyFmLZr5w0k4Mw+ApV
         KykOHynPIE1lKDNmjSKpDiHtM1d0aSvK4u2QH/Y0m6EOTkvFwFyisykzKmXx5pfCGW4m
         XRhQ==
X-Gm-Message-State: ANoB5pn8py+RIGE16XGLq/lW3VTPPOdlqVpGbN5dfybqsQ7cO3yCftaD
        jGF+BULMXM8VjfrOmmUr5lxWnmsSDe7WHB8=
X-Google-Smtp-Source: AA0mqf4DLi2UOpHwa3pj3dhe8A3SizukPo6ORwrd7gzGfGnSsu4F9JCgksQuy24CWtDMyQ4r53h73DKvZRm/mwM=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6830:6408:b0:66e:6b6b:f7a5 with SMTP
 id cj8-20020a056830640800b0066e6b6bf7a5mr20681030otb.153.1671477538946; Mon,
 19 Dec 2022 11:18:58 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:18:46 -0600
In-Reply-To: <20221216221703.294683-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221216221703.294683-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219191855.2010466-1-allenwebb@google.com>
Subject: [PATCH v8 0/9] Generate modules.builtin.alias from match ids
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

Also included in this series are style fixes and fixes for build
breakages for built-in modules that relied on MODULE_DEVICE_TABLE being
a no-op. Some of these were typos in the device table name and one
ifdef-ed out the device table.

--

# Generate modules.builtin.alias from match ids

This series (v7) has incremental improvements over the previous series.
One big positive of this patch series is it makes it harder for bugs
in kernel modules related to MODULE_DEVICE_TABLE to hide when a module
is only ever tested as a built-in module. This is demonstrated by all
the required fixes at the beginning of the series.

Note, cover letters were first added in v5.

  RFC (broken patch): https://lore.kernel.org/lkml/CAJzde042-M4UbpNYKw0eDVg4JqYmwmPYSsmgK+kCMTqsi+-2Yw@mail.gmail.com/
  v1 (missing v1 label): https://lore.kernel.org/lkml/20221111152852.2837363-1-allenwebb@google.com/
  v2 (missing v2 label): https://lore.kernel.org/lkml/20221128201332.3482092-1-allenwebb@google.com/
  v3: https://lore.kernel.org/lkml/20221129224313.455862-1-allenwebb@google.com/
  v4: https://lore.kernel.org/lkml/20221130221447.1202206-1-allenwebb@google.com/
  v5: https://lore.kernel.org/lkml/20221201211630.101541-1-allenwebb@google.com/
  v6: https://lore.kernel.org/lkml/20221202224540.1446952-1-allenwebb@google.com/
  v7: https://lore.kernel.org/lkml/20221216221703.294683-1-allenwebb@google.com/
  v8: This version

## Patch series status
123456789012345678901234567890123456789012345678901234567890123456789012
This series is still going through revisions in response to comments.

I believe there is potential to improve the Makefile part of the patch
series as well as an open question of whether modpost should generate
`modules.built.alias` directly or create a vmlinuz.mod.c containing the
missing module info for the match-id based aliases for built-in modules.

## Acknowledgements

Thanks to Greg Kroah-Hartman, Christophe Leroy, and the Linux
maintainers for being patient with me as I have worked through learning
the kernel workflow to get this series into a more presentable state.

Thanks to Luis Chamberlain for raising the alternative of using kmod to
address the primary motivation of the patch series.

Also, thanks to Intel's kernel test robot <lkp@intel.com> for catching
issues that showed up on different kernel configurations.


Allen Webb (9):
  imx: Fix typo
  rockchip-mailbox: Fix typo
  scsi/BusLogic: Always include device id table
  stmpe-spi: Fix typo
  module.h: MODULE_DEVICE_TABLE for built-in modules
  modpost: Track module name for built-in modules
  modpost: Add -b option for emitting built-in aliases
  file2alias.c: Implement builtin.alias generation
  build: Add modules.builtin.alias

 .gitignore                         |  1 +
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
 11 files changed, 131 insertions(+), 30 deletions(-)

-- 
2.37.3

