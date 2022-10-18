Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BB460289E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJRJpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJRJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:45:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99879DFAD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D550614FA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01ACC433D6;
        Tue, 18 Oct 2022 09:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666086338;
        bh=ynFfTnsMzotOvesw2GH8zo+VK9nmB0W4W0cdoZ7kzQM=;
        h=Date:From:To:Cc:Subject:From;
        b=GNfiAcGQnrrL6bKw5nbO7Vgu6yGNgbpkmhdRW+jVcUF0qgEKNUPr8N0Xqewf537SH
         /5fVLtG/mhOF6s+5bnKJ4J8iCv8EFA+1u/w0Y1yxCfeCWK6oAFu10y6AZWvXllcn+T
         gOtgsmOKL+Kc2IGmntilHIMpSlnyRaEuc2ynpjYJ3VQXkTrTRYhEnfD+n7PM9C2P0e
         tIz5PZOs2ggc6f1M561ODPlMCfwEWKXJmEi6MgWZ4VYH3r0U1EQDOOuYr7NYrWvFH+
         v/hFIK2C9JYaXZkUQjspuOOKR08uCZeVHH07r/u4YwTXQp9aoO1iWPqL+zn8RzDo/F
         KD38S88m0uPFQ==
Date:   Tue, 18 Oct 2022 17:45:30 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Jia Zhu <zhujia.zj@bytedance.com>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] erofs fixes for 6.1-rc2
Message-ID: <Y051uhn/opotPmAo@hsiangkao-PC>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry, forgot to send to related mailing lists... resend now)

Hi Linus,

Could you consider these fixes for 6.1-rc2?

There are some bugs reported these days and the following patches
address them.

Some issues looks trivial but the compressed data deduplication one
can only be reproduced with the stress test for almost two weeks.

Anyway, I think all of them needs to be fixed immediately and details
are shown as below.  All commits have been in linux-next and no merge
conflicts.

Thanks,
Gao Xiang

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.1-rc2-fixes

for you to fetch changes up to ce4b815686573bef82d5ee53bf6f509bf20904dc:

  erofs: protect s_inodes with s_inode_list_lock for fscache (2022-10-17 14:57:57 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix illegal unmapped accesses when initializing compressed inodes;

 - Fix up very rare hung on page lock after enabling compressed data
   deduplication;

 - Fix up inplace decompression success rate;

 - Take s_inode_list_lock to protect sb->s_inodes for fscache shared
   domain.

----------------------------------------------------------------
Dawei Li (1):
      erofs: protect s_inodes with s_inode_list_lock for fscache

Gao Xiang (2):
      erofs: shouldn't churn the mapping page for duplicated copies
      erofs: fix up inplace decompression success rate

Yue Hu (1):
      erofs: fix illegal unmapped accesses in z_erofs_fill_inode_lazy()

 fs/erofs/fscache.c |  3 +++
 fs/erofs/zdata.c   | 17 +++++++----------
 fs/erofs/zdata.h   |  6 +++---
 fs/erofs/zmap.c    | 22 ++++++++++------------
 4 files changed, 23 insertions(+), 25 deletions(-)
