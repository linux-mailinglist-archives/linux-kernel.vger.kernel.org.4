Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3F170E359
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbjEWRU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbjEWRUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:20:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77D7B5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5880B634F7
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F26C433D2;
        Tue, 23 May 2023 17:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684862407;
        bh=f46ZRC2jjMXG31VuvQ607oPUvDN+Mcrlg8Kzt5AOalU=;
        h=Date:From:To:Cc:Subject:From;
        b=fvT0WSR3TJ+jl8pfMLH5fFkL82VMBh+qig2K3u97ERovmbs+R1TvgTIfn5DCfrNXF
         cXzpTa8ZiGLhGVAEXxjCYar8isqslMJH+zwo2wGOvnNhH3k2TBokfTEcSr0n2TngTc
         lH3LulIyV/UUghTUReEgeRO5rLWYciINzXwgrfK3OArSc3p5RSjU8ATdo1eDlNqN3k
         05ia4jDW0R3fjKt9cTDx5OKymtl/B1sEARmoGKekW1ta8NWGp1a2FYqYYFLXGe6OQv
         V7XaFttllzWhwQnZTtIlaJCISNeTLHEtwjacseYPkGvOW90GrjXLYmXL4lO9IS2vS1
         tGHp7N8qgX4tw==
Date:   Wed, 24 May 2023 01:20:02 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>
Subject: [GIT PULL] erofs fixes for 6.4-rc4
Message-ID: <ZGz1wpqyI+lfCaUA@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider these three patches for 6.4-rc4?

One patch addresses a null-ptr-deref issue reported by syzbot weeks
ago, which is caused by the new long xattr name prefix feature and
needs to be fixed.

The remaining two patches are minor cleanups to avoid unnecessary
compilation and adjust per-cpu kworker configuration.

Thanks,
Gao Xiang

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.4-rc4-fixes

for you to fetch changes up to cf7f2732b4b83026842832e7e4e04bf862108ac2:

  erofs: use HIPRI by default if per-cpu kthreads are enabled (2023-05-23 16:57:08 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix null-ptr-deref related to long xattr name prefixes;

 - Avoid pcpubuf compilation if CONFIG_EROFS_FS_ZIP is off;

 - Use high priority kthreads by default if per-cpu kthread workers are
   enabled.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: use HIPRI by default if per-cpu kthreads are enabled

Jingbo Xu (1):
      erofs: fix null-ptr-deref caused by erofs_xattr_prefixes_init

Yue Hu (1):
      erofs: avoid pcpubuf.c inclusion if CONFIG_EROFS_FS_ZIP is off

 fs/erofs/Kconfig    |  1 +
 fs/erofs/Makefile   |  4 ++--
 fs/erofs/internal.h | 13 +++++++------
 fs/erofs/xattr.c    |  2 +-
 fs/erofs/zdata.c    |  2 --
 5 files changed, 11 insertions(+), 11 deletions(-)
