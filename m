Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14AB6A0147
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 03:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjBWCog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 21:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjBWCo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 21:44:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F4E28216
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bXX0DMS2swWkMqSYibcCFsHDgPbrh21a4B1H1mImqJM=; b=mUlD/MPP0fVPyx7NdHMz3zb0YB
        nmVgJCICeQKODh7hp10D24qRCz0ZhxuWrkIljrcfQJIcQPB3xwNrm63aTNppEDbJMrrbJ3eTducUT
        meT0EmUMpB9gdr9ADY+5zvAGtFkRpXSvLwr0Vluqq34ZNE7n46NFyjTTwpJfd9bl59YQwBqaMMSz6
        m6OVIyv2xw38XY0Mm68dFC0zBEnLMhJq3Gueeet4xmWgjFodCB/sevSVQBjeIGaOVJHXChEsu0NID
        OxkWZEalI1ch06GvCxIMWD/e6cSc09wckUA+MevURiUImgvOZ7ZG+/ecImJe4vBPkv843CXoKgcJX
        DX79YhqQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pV1ah-00EmN6-4b; Thu, 23 Feb 2023 02:44:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, dave@stgolabs.net,
        a.manzanares@samsung.com, yosryahmed@google.com, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 0/5] tmpfs: add the option to disable swap
Date:   Wed, 22 Feb 2023 18:44:07 -0800
Message-Id: <20230223024412.3522465-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This adds noswap support to tmpfs. This follows up the first RFC [0],
you can look at that link for details of the testing done. On this
v2 I've addressed the feedback provided by Matthew Wilcox and Yosry
Ahmed. I've also made some other changes. Changes on this v2:

  o Matthew suggested BUG_ON(!folio_test_locked(folio)) is not needed
    on writepage() callback for shmem so just remove that.
  o Based on Matthew's feedback the inode is set up early as it is not
    reset in case we split the folio. So now we move all the variables
    we can set up really early.
  o shmem writepage() should only be issued on reclaim, so just move
    the WARN_ON_ONCE(!wbc->for_reclaim) early so that the code and
    expectations are easier to read. This also avoid the folio splitting
    in case of that odd case.
  o There are a few cases where the shmem writepage() could possibly
    hit, but in the total_swap_pages we just bail out. We shouldn't be
    splitting the folio then. Likewise for VM_LOCKED case. But for
    a writepage() on a VM_LOCKED case is not expected so we want to
    learn about it so add a WARN_ON_ONCE() on that condition.
  o Based on Yosry Ahmed's feedback the patch which allows tmpfs to
    disable swap now just uses mapping_set_unevictable() on inode
    creation. In that case writepage() should not be called so we
    augment the WARN_ON_ONCE() for writepage() for that case to ensure
    that never happens.

If this all seems peachy I can move this to PATCH form next. I've tested
and indeed just using mapping_set_unevictable() suffices to disable swap
upon inode creation.

[0] https://lkml.kernel.org/r/20230207025259.2522793-1-mcgrof@kernel.org

Luis Chamberlain (5):
  shmem: remove check for folio lock on writepage()
  shmem: set shmem_writepage() variables early
  shmem: move reclaim check early on writepages()
  shmem: skip page split if we're not reclaiming
  shmem: add support to ignore swap

 Documentation/mm/unevictable-lru.rst |  2 +
 include/linux/shmem_fs.h             |  1 +
 mm/shmem.c                           | 68 ++++++++++++++++++----------
 3 files changed, 48 insertions(+), 23 deletions(-)

-- 
2.39.1

