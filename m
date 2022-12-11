Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B2664919B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 02:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiLKBDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 20:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKBDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 20:03:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6790BCE36;
        Sat, 10 Dec 2022 17:03:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F135360CE8;
        Sun, 11 Dec 2022 01:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C309C433EF;
        Sun, 11 Dec 2022 01:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670720598;
        bh=1HK76CNmfvt/mEiTJAF2A1tnfVtfZqywZPbIbOXOt9g=;
        h=Date:From:To:Cc:Subject:From;
        b=SdNVNdcN+UTgrtIsZvrOIvpMlukY30CLr1+R8JhovblmrfOca+Nh2vkj1nImD2Wzh
         zydG/Rzq7WseiBdEOlTEpttl/AvhuXOVYyeacaJXWPXlGtzpIFyn3UA+N4XZEBU6YB
         0Oh6qPo+/hPDDZ/v9HehPOWqMLKRHGv+qBCfRI6I=
Date:   Sat, 10 Dec 2022 17:03:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.1 final
Message-Id: <20221210170317.130e7dbfc0e78de6067c4012@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this final batch of hotfixes for 6.1, thanks.


The following changes since commit 1d351f1894342c378b96bb9ed89f8debb1e24e9f:

  revert "kbuild: fix -Wimplicit-function-declaration in license_is_gpl_compatible" (2022-11-30 14:49:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-12-10-1

for you to fetch changes up to 4a7ba45b1a435e7097ca0f79a847d0949d0eb088:

  memcg: fix possible use-after-free in memcg_write_event_control() (2022-12-09 18:41:17 -0800)

----------------------------------------------------------------
9 hotfixes.  6 for MM, 3 for other areas.  Four of these patches address
post-6.0 issues.

----------------------------------------------------------------
David Hildenbrand (1):
      mm/swap: fix SWP_PFN_BITS with CONFIG_PHYS_ADDR_T_64BIT on 32bit

Hugh Dickins (1):
      tmpfs: fix data loss from failed fallocate

Jason A. Donenfeld (1):
      mm: do not BUG_ON missing brk mapping, because userspace can unmap it

John Starks (1):
      mm/gup: fix gup_pud_range() for dax

Liam Howlett (1):
      mmap: fix do_brk_flags() modifying obviously incorrect VMAs

Matti Vaittinen (1):
      mailmap: update Matti Vaittinen's email address

Michal Hocko (1):
      kselftests: cgroup: update kmem test precision tolerance

Muchun Song (1):
      MAINTAINERS: update Muchun Song's email

Tejun Heo (1):
      memcg: fix possible use-after-free in memcg_write_event_control()

 .mailmap                                   |  3 +++
 MAINTAINERS                                |  4 ++--
 include/linux/cgroup.h                     |  1 +
 include/linux/swapops.h                    |  8 +++++---
 kernel/cgroup/cgroup-internal.h            |  1 -
 mm/gup.c                                   |  2 +-
 mm/memcontrol.c                            | 15 +++++++++++++--
 mm/mmap.c                                  | 14 ++++----------
 mm/shmem.c                                 | 11 +++++++++++
 tools/testing/selftests/cgroup/test_kmem.c |  6 +++---
 10 files changed, 43 insertions(+), 22 deletions(-)

