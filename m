Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C6E692FEC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBKKNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBKKNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:13:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1171E5E0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 02:13:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EBF0B80E3D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 10:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A169BC433EF;
        Sat, 11 Feb 2023 10:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676110409;
        bh=p+IdxaBG7C0I9P6ldP+PpkrL7/XCuQ5WEyqo+TXFHXE=;
        h=Date:From:To:Cc:Subject:From;
        b=fmOrGje95DQT3J1lJkLkBlgX0jcrdRhmgbH7yYiT04I3k2DtJvgFCms1WrQLD9DRe
         DPVwfwXBX29epAl+HYwzjyLPKILn+wsV1MrTlv7kUMleoOZ09CTwVXJaybcaca2Ji1
         tk5ZFL8nQ9bu5++4AHmbOxu9yWYZTNp/uOPwSn3xWaN9x44Wv5hI9rGIr+7MFb6wR/
         oeNyG6Wh9QS/lcWZT88L6CsCdlb32jGB41s+gk8ZW/fiXKY6XjAt4DjUFLZO7Q8Qf1
         Yf2O2a+r8u8v3nlTPRlspAsm9gC+fT+4A4ktwQA8WFqDJDWjmdHgfWGiQZ2jd/ASSm
         +BVss6ol6Z7JQ==
Date:   Sat, 11 Feb 2023 12:13:17 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Aaron Thompson <dev@aaront.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock: Revert "mm: Always release pages to the buddy
 allocator in memblock_free_late()."
Message-ID: <Y+dqPRXSqoP1x7u5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

The following changes since commit 4ec5183ec48656cec489c49f989c508b68b518e3:

  Linux 6.2-rc7 (2023-02-05 13:13:28 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2023-02-11

for you to fetch changes up to 647037adcad00f2bab8828d3d41cd0553d41f3bd:

  Revert "mm: Always release pages to the buddy allocator in memblock_free_late()." (2023-02-07 13:07:37 +0200)

----------------------------------------------------------------
Revert "mm: Always release pages to the buddy allocator in memblock_free_late()."

This reverts commit 115d9d77bb0f9152c60b6e8646369fa7f6167593.

The pages being freed by memblock_free_late() have already been
initialized, but if they are in the deferred init range, __free_one_page()
might access nearby uninitialized pages when trying to coalesce buddies,
which will cause a crash.

A proper fix will be more involved so revert this change for the time
being.

----------------------------------------------------------------
Aaron Thompson (1):
      Revert "mm: Always release pages to the buddy allocator in memblock_free_late()."

 mm/memblock.c                     | 8 +-------
 tools/testing/memblock/internal.h | 4 ----
 2 files changed, 1 insertion(+), 11 deletions(-)

-- 
Sincerely yours,
Mike.
