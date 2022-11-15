Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9862629C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiKOO0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKOOZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:25:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B4112606
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:25:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C804617C8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B16C433C1;
        Tue, 15 Nov 2022 14:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668522356;
        bh=WXu6kxIQDc98LvRRfjvGWQ6aV8piv1ExqJ/ldXVYpBg=;
        h=Date:From:To:Cc:Subject:From;
        b=l5Pktcy4VNyVfeoHn/2Ew9ji3BKPDu9R7l6pExb9L6//QezjtM2LdxsQNKvWkIna3
         UGeyfbozku4nrUT6EXVh6Wax0HFY56IGO0PJtval45STmpqB47j/3ISqwC5NRNJTjk
         4RaXby5tZyGHvgp7iZVz5u72lLWqUUle5+4vDjjhTj+JxMMlYymJhA/J66137bHR4S
         4CaOC3QpJejOZhCjCS3bv7ZWahpkILMwIfB6Y3h79thjaYUxEF5PcYaL0IlFXhZgns
         VJWSwSiHBBlTb9WD+ZOBJbCJ/hS4JjiKQTU49np/CO4poxmJFP21u3r3ZM2C5qxFXe
         Bp8tPeDEBDIVQ==
Date:   Tue, 15 Nov 2022 22:25:50 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        David Howells <dhowells@redhat.com>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] erofs fixes for 6.1-rc6
Message-ID: <Y3OhbojEWZa35DVf@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        David Howells <dhowells@redhat.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider these three fixes for 6.1-rc6?

Most patches randomly fix error paths or corner cases in fscache mode
reported recently.  And the rest one fixes an invalid access relating
to fragments on crafted images.  Details are shown as below.

I should submit earlier for -rc5 but actually delay a bit since one
commit message got minor updated.  All commits have been in linux-next
and no merge conflicts.

Thanks,
Gao Xiang

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.1-rc6-fixes

for you to fetch changes up to 37020bbb71d911431e16c2c940b97cf86ae4f2f6:

  erofs: fix missing xas_retry() in fscache mode (2022-11-14 23:48:38 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix packed_inode invalid access when reading fragments on crafted
   images;

 - Add a missing erofs_put_metabuf() in an error path in fscache mode;

 - Fix incorrect `count' for unmapped extents in fscache mode;

 - Fix use-after-free of fsid and domain_id string when remounting;

 - Fix missing xas_retry() in fscache mode.

----------------------------------------------------------------
Jingbo Xu (4):
      erofs: put metabuf in error path in fscache mode
      erofs: get correct count for unmapped range in fscache mode
      erofs: fix use-after-free of fsid and domain_id string
      erofs: fix missing xas_retry() in fscache mode

Yue Hu (1):
      erofs: fix general protection fault when reading fragment

 fs/erofs/fscache.c  | 35 +++++++++++++++++++++--------------
 fs/erofs/internal.h |  6 ++++--
 fs/erofs/super.c    | 39 ++++++++++++++++++++++-----------------
 fs/erofs/sysfs.c    |  8 ++++----
 fs/erofs/zdata.c    |  3 +++
 5 files changed, 54 insertions(+), 37 deletions(-)
