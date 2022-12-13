Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3927F64ADF0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 03:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiLMCxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 21:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiLMCxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:53:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF17BC83;
        Mon, 12 Dec 2022 18:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZKX8lutJbYrUDMvUvqcO0M/AYzReqeJcn+AU7sWbq3c=; b=EzNOmVlRZedDG9/bRxvhjj+pzY
        8cNF1TGiL/ingdazs5LswFkhQQj6oaJUAZUDP25ZlfsNzm+G9PCMZe/wSPPYEudkHJNgAPnR0iB70
        7hIJP6wtcO2jDybwjEaapLAmNHqCm3xih4DUNm76dXY9B1ED0FNNqpLYIrqS7Wq8FDNKTEdNLv/T9
        ij6/E9JYbW4XtBeQgTe8SjWqwCND58EeobUlVmAjBLj/miAiRyFBRjbHnT4BbHk1/n04rSyJqH7xt
        eXDx0QT8GwA/SKU+SfHOJKGCtp93BtUoOY1Ng5uIzmSXrrXCbEBfeoq39YL8EOOmnnyBRWeG3VUB4
        u4vEKwHA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4vQ7-009xiv-1i; Tue, 13 Dec 2022 02:53:27 +0000
Date:   Mon, 12 Dec 2022 18:53:27 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     thunder.leizhen@huawei.com, swboyd@chromium.org,
        yang.lee@linux.alibaba.com, linux@rasmusvillemoes.dk,
        petr.pavlu@suse.com, mwilck@suse.com, pmladek@suse.com,
        mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] modules changes for v6.2-rc1
Message-ID: <Y5fpJ6MOxf9PD8Vh@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit eb037f16f7e843722db5f0275d84b3f738d5649d:

  Merge tag 'perf-tools-fixes-for-v6.1-2-2022-11-10' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux (2022-11-11 09:45:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.2-rc1

for you to fetch changes up to 4f1354d5c6a3264c91238962d1597eef40c40419:

  livepatch: Call klp_match_callback() in klp_find_callback() to avoid code duplication (2022-12-12 18:30:58 -0800)

----------------------------------------------------------------
modules changes for v6.2-rc1

Tux gets for xmass improving the average lookup performance of
kallsyms_lookup_name() by 715x thanks to the work by Zhen Lei, which
upgraded our old implementation from being O(n) to O(log(n)), while also
retaining the old implementation support on /proc/kallsyms. The only
penalty was increasing the memory footprint by 3 * kallsyms_num_syms.
Folks who want to improve this further now also have a dedicated selftest
facility through KALLSYMS_SELFTEST. Since I had to start reviewing other
future kallsyms / modules enhancements by Nick Alcock (his stuff is not
merged, it requires more work) I carefully reviewed and merged Zhen Lei's
kallsyms changes through modules-next tree a bit less than a month ago.
So this has been exposed on linux-next for about a month now with no
reported regressions.

Stephen Boyd added zstd in-kernel decompression support, but the only
users of this would be folks using the load-pin LSM because otherwise
we do module docompression in userspace. This is the newest code and
was merged last week on modules-next.

We spent a lot of time analyzing and coming to grips with a proper
fix to an old modules regression which only recently came to light
(since v5.3-rc1, May 2019) but even though I merged that fix onto
modules-next last week I'm having second thoughts about it now as I was
writing about that fix in this git tag message for you, as I found a few
things we cannot quite justify there yet. So I'm going to push back to the
drawing board again there until all i's are properly dotted. Yes, it's a
regression but the issue has been there for 2 years now and it came up
because of high end CPU count, it can wait a *tiny* bit more for a proper
fix.

The only other thing with mentioning is a minor boot time optimization by
Rasmus Villemoes which deferes param_sysfs_init() to late init. The rest
is cleanups and minor fixes.

----------------------------------------------------------------
Chen Zhongjin (1):
      module: Remove unused macros module_addr_min/max

Miaoqian Lin (1):
      module: Fix NULL vs IS_ERR checking for module_get_next_page

Rasmus Villemoes (2):
      module: remove redundant module_sysfs_initialized variable
      kernel/params.c: defer most of param_sysfs_init() to late_initcall time

Stephen Boyd (1):
      module/decompress: Support zstd in-kernel decompression

Yang Li (1):
      kallsyms: Remove unneeded semicolon

Zhen Lei (8):
      scripts/kallsyms: rename build_initial_tok_table()
      kallsyms: Improve the performance of kallsyms_lookup_name()
      kallsyms: Correctly sequence symbols when CONFIG_LTO_CLANG=y
      kallsyms: Reduce the memory occupied by kallsyms_seqs_of_names[]
      kallsyms: Add helper kallsyms_on_each_match_symbol()
      livepatch: Use kallsyms_on_each_match_symbol() to improve performance
      kallsyms: Add self-test facility
      livepatch: Call klp_match_callback() in klp_find_callback() to avoid code duplication

 include/linux/kallsyms.h   |   9 +
 include/linux/module.h     |   1 -
 init/Kconfig               |  13 ++
 kernel/Makefile            |   1 +
 kernel/kallsyms.c          | 116 +++++++++--
 kernel/kallsyms_internal.h |   1 +
 kernel/kallsyms_selftest.c | 485 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/kallsyms_selftest.h |  13 ++
 kernel/livepatch/core.c    |  31 +--
 kernel/module/Kconfig      |   3 +-
 kernel/module/decompress.c | 100 +++++++++-
 kernel/module/main.c       |   3 -
 kernel/module/sysfs.c      |   2 +-
 kernel/params.c            |  23 ++-
 scripts/kallsyms.c         |  78 +++++++-
 scripts/link-vmlinux.sh    |   4 +
 16 files changed, 840 insertions(+), 43 deletions(-)
 create mode 100644 kernel/kallsyms_selftest.c
 create mode 100644 kernel/kallsyms_selftest.h
