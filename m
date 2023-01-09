Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47CB6632F9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbjAIVd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjAIVdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:33:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257E1DD0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:33:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB40D6140C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EB2C43392;
        Mon,  9 Jan 2023 21:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673300026;
        bh=S9qpLQ77vZLkX0Fi/FnXthnFg4be2LJbk3/kO/j1qTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jRDHdTCz4fpg4pSg+atnuiWHPSzA34OuiyN0y4hpkdydvPbEXc5zQNd2rmXYtLG3R
         3qnhCqhu0s5e6yY71KGAHWgxIuU/eKP9xpeghcLzTaHoAiaNpS1AV6Ixh21DKD0orM
         uSzwGl7Itp0qOi0SAjUWVJgo6gllE3SdJ2Tfo53cV7OsSDL+n310BVjzmPDIcm0XMO
         p8wPGPwVOXBEM6ivtFSJskAo1VQNvggSIM9GNleCP4uRobOuMxdi9GBMueeRyyR1Rr
         BEaar4UIe6j/wPq/l0eaX6+bLZBckUQuURSfg9NUCEN8MXUiJ4raIz5tcuKTpBcfsR
         BUGNJ394IFnhg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] mm/damon/vaddr: support folio of neither HPAGE_PMD_SIZE nor PAGE_SIZE
Date:   Mon,  9 Jan 2023 21:33:31 +0000
Message-Id: <20230109213335.62525-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109213335.62525-1-sj@kernel.org>
References: <20230109213335.62525-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON virtual address space monitoring operations set treats folios
having non-HPAGE_PMD_SIZE size as having PAGE_SIZE size.  Use the exact
size of the folio.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d6cb1fca1769..c7b192006fe6 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -475,7 +475,7 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 		goto out;
 	if (pte_young(*pte) || !folio_test_idle(folio) ||
 			mmu_notifier_test_young(walk->mm, addr)) {
-		*priv->folio_sz = PAGE_SIZE;
+		*priv->folio_sz = folio_size(folio);
 		priv->young = true;
 	}
 	folio_put(folio);
-- 
2.25.1

