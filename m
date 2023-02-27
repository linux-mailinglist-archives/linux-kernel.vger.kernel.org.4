Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741576A3DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjB0JMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjB0JMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:12:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6621F5E6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:04:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A42EAB80CA5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54ABAC433EF;
        Mon, 27 Feb 2023 09:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677488674;
        bh=TnR4+ResYQpZ7xd4crafgGHzrGYANiSPQn6G5mtYVpM=;
        h=Date:From:To:Cc:Subject:From;
        b=EwyXzhZWtuudP1fNwrlZfHno7WNKgPViYVPgVpuwG4snqxwIlwD9PY6VzMm1yhpaR
         sv2qxlSP+BoRU3YHOb5V8e4p5KAxxwzcg8n62k3mFEGkNbFbBHwTNMuCnsNsIKBKSY
         spFYXdIM11gxlRdQQuUis6HczWKfF7kwE/joK/eHPhfQJssShBj7x4640Qxh3vaz7+
         RDBcKrtOEr0VVTFsnQ4Vzho0s/H5VuqhbPwfcfuJ+3qwcKyevSSOoLcJn75ZerpLtQ
         GX5kiX5O/1SlKj7w/Bn+0brgTWf8ClyBVvyGWGTgkb/e6+B/mNwPkRFzx5YSelOOn2
         pIGII0FO1qwJA==
Date:   Mon, 27 Feb 2023 11:04:22 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock: small optimizations
Message-ID: <Y/xyFjdgpYP5rm3z@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

The following changes since commit 6d796c50f84ca79f1722bb131799e5a5710c4700:

  Linux 6.2-rc6 (2023-01-29 13:59:43 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.3-rc1

for you to fetch changes up to 2fe03412e2e1be3d5ab37b8351a37c3aec506556:

  memblock: Avoid useless checks in memblock_merge_regions(). (2023-01-31 15:51:56 +0200)

----------------------------------------------------------------
memblock: small optimizations

* fix off-by-one in the check whether memblock_add_range() should
  reallocate memory to accommodate newly inserted range
* check only for relevant regions in memblock_merge_regions() rather than
  swipe over the entire array

----------------------------------------------------------------
Peng Zhang (2):
      memblock: Make a boundary tighter in memblock_add_range().
      memblock: Avoid useless checks in memblock_merge_regions().

 mm/memblock.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

-- 
Sincerely yours,
Mike.
