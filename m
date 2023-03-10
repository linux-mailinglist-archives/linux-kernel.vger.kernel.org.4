Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3496F6B4D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjCJQnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjCJQmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:42:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8951E290
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:40:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF2E861AC7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3F5C433A4;
        Fri, 10 Mar 2023 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678466421;
        bh=lF4WQCD0iAfVt+U1sHPjQ+RcRXvl9M8ViINfhAY6SF8=;
        h=Date:From:To:Cc:Subject:From;
        b=V+8fpkbisZNTc39jlqnOxlbNiBvxEmUYsdJ6F+oOUw5nJLfqqE5Wii6BgLDDlRhSi
         1PclQm+31z6r8bt8mmvNFxEvnpnXOmXSJ7BnP+RE47Duofyqx2ZJFc0CsZ5dmgb4aY
         joyrhG63M+GrXerqaZ0BH1+A8aHZn6/HJhPBkGpsAjq4qrrLOnvJZmuVFQ1GHmUk0H
         In9SlABlwBMhAHMuIcVdU8S/fZQUqNwSjToOLJXwD5/gFxtUzBBeMpDTwQfXtIqL1t
         1aTaG60cy0CcRSXVGGVEb6XXbAZpqAInHN7GswlWb4PJVhKNloaAgumwiBQeftif48
         44ASInrgcn9gg==
Date:   Sat, 11 Mar 2023 00:40:14 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Yangtao Li <frank.li@vivo.com>, Yue Hu <huyue2@coolpad.com>,
        Chao Yu <chao@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: [GIT PULL] erofs fixes for 6.3-rc2
Message-ID: <ZAtdbhFmLD4MCRk+@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Yangtao Li <frank.li@vivo.com>, Yue Hu <huyue2@coolpad.com>,
        Chao Yu <chao@kernel.org>, Jingbo Xu <jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider these fixes for 6.3-rc2?

The most important one reverts an improper fix which can cause an
unexpected warning more often on specific images, and another one
fixes LZMA decompression on 32-bit platforms.  The others are minor
fixes and cleanups.

All commits have been in -next and tested without strange happening.

Thanks,
Gao Xiang

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.3-rc2-fixes

for you to fetch changes up to 3993f4f456309580445bb515fbc609d995b6a3ae:

  erofs: use wrapper i_blocksize() in erofs_file_read_iter() (2023-03-09 23:36:04 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix LZMA decompression failure on HIGHMEM platforms;

 - Revert an inproper fix since it is actually an implementation
   issue of vmalloc();

 - Avoid a wrong DBG_BUGON since it could be triggered with -EINTR;

 - Minor cleanups.

----------------------------------------------------------------
Gao Xiang (3):
      erofs: fix wrong kunmap when using LZMA on HIGHMEM platforms
      erofs: Revert "erofs: fix kvcalloc() misuse with __GFP_NOFAIL"
      erofs: get rid of a useless DBG_BUGON

Yangtao Li (1):
      erofs: mark z_erofs_lzma_init/erofs_pcpubuf_init w/ __init

Yue Hu (1):
      erofs: use wrapper i_blocksize() in erofs_file_read_iter()

 fs/erofs/data.c              |  2 +-
 fs/erofs/decompressor_lzma.c |  4 ++--
 fs/erofs/internal.h          |  4 ++--
 fs/erofs/pcpubuf.c           |  2 +-
 fs/erofs/zdata.c             | 12 ++++++------
 fs/erofs/zmap.c              |  3 ---
 6 files changed, 12 insertions(+), 15 deletions(-)
