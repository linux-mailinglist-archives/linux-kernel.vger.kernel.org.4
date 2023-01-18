Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9201A671E54
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjARNth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjARNtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:49:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFAEC925B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:19:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C84A617E1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0E0C433EF;
        Wed, 18 Jan 2023 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674047908;
        bh=etRSyexaS7lKbqSE4du4p/95DwyYLBtFmlpNtRNPPuU=;
        h=Date:From:To:Cc:Subject:From;
        b=ovM5RSgXPoDJsfcJTyCDMZdrECwUmy0zlmZLgKpWF13ffxheqn2JunkHddIdVyVaI
         eoFZq0RahuoDiIhU2rI1wZo65E9JSrbZIbZdYuT0HE3W1r6FfZlZHTWM9NounHg947
         9WqlNi2DkPcstcA5Or2Lzjq+X1Z5GWsO5MJCjONrt2F7I8XUb0wPawxKgv3rwDH+e0
         T0tgahFM94fssrjQ6OyadtsV7UM84BU3to+JaZai+Clxy3sue+Urywchea72B7JYeZ
         ROPJhYKK6mRutC1H5Nvvi0f554Oe2lhgE6Rn4Esi7Nj1Pb90TxcyVTVVuj61Zy1CWv
         HI27XMef2yimA==
Date:   Wed, 18 Jan 2023 21:18:21 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Siddh Raman Pant <code@siddh.me>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Jia Zhu <zhujia.zj@bytedance.com>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>
Subject: [GIT PULL] erofs fixes for 6.2-rc5
Message-ID: <Y8fxnV7ol9OP6JSz@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Siddh Raman Pant <code@siddh.me>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Jia Zhu <zhujia.zj@bytedance.com>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>
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

Could you consider this pull request for 6.2-rc5?

Two patches fixes issues reported by syzbot, one fixes
missing `domain_id` mount option started from v6.1 in
documentation and a minor cleanup.  Details are shown
below as well.

All commits have been in -next for a while.

Thanks,
Gao Xiang

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc5

for you to fetch changes up to e02ac3e7329f76c5de40cba2746cbe165f571dff:

  erofs: clean up parsing of fscache related options (2023-01-16 22:39:47 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix wrong iomap->length calculation post EOF, which could
   cause a WARN_ON in iomap_iter_done() (Siddh);

 - Fix improper kvcalloc() use with __GFP_NOFAIL (me);

 - Add missing `domain_id` mount option in documentation (Jingbo);

 - Clean up fscache option parsing (Jingbo).

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix kvcalloc() misuse with __GFP_NOFAIL

Jingbo Xu (2):
      erofs: add documentation for 'domain_id' mount option
      erofs: clean up parsing of fscache related options

Siddh Raman Pant (1):
      erofs/zmap.c: Fix incorrect offset calculation

 Documentation/filesystems/erofs.rst |  2 ++
 fs/erofs/super.c                    | 13 ++++++-------
 fs/erofs/zdata.c                    | 12 ++++++------
 fs/erofs/zmap.c                     | 10 +++++++---
 4 files changed, 21 insertions(+), 16 deletions(-)
