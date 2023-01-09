Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BD56632FA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbjAIVeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjAIVdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:33:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD3C7D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:33:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8511A613EF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D46C433D2;
        Mon,  9 Jan 2023 21:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673300025;
        bh=YoH2tR8NLH+QbhLgJ/r04bzOqFDeQdgriWy2NASAc0k=;
        h=From:To:Cc:Subject:Date:From;
        b=tG9V3TNBUY0/wfoUfLXTIpTeXPSAFHZ2Zw+oAXdW09R0hULHv4cAPV9k5vMXA42c3
         dAatgxDxPlenTlDWEi8/LepR1AfAT7h//7FTkXFtw83bJHvdw7qyF7EV/OIFRP/5AP
         dMzN9hmFgX7xkX7IwIE/tDvM2M8SiVvPeEFvHEkMScUjOquZS09Sojdd00gVHCtT6j
         5Y7aI/HVmWKVmWkDAhxmJllGVt5IBxketV3RIIzzUK2uqsN35a2/8C6yyIYBjclN/r
         qjYDQs5jQaNR7EzINZ/64L3j/qOz4peyjij6wChVy8XccpurVH4f5CDxY3+nDg1UgO
         wdwj3/v6L/RJw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] mm/damon/{v,p}addr: misc fixups for folio usage
Date:   Mon,  9 Jan 2023 21:33:29 +0000
Message-Id: <20230109213335.62525-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
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

DAMON's monitoring operations set for the virtual and the physical
address spaces use folio now, but some code is not reflecting the fact.
Further cleanup the code for folio usage.

SeongJae Park (6):
  mm/damon/vaddr: rename 'damon_young_walk_private->page_sz' to
    'folio_sz'
  mm/damon/vaddr: support folio of neither HPAGE_PMD_SIZE nor PAGE_SIZE
  mm/damon/vaddr: record appropriate folio size when the access is not
    found
  mm/damon/paddr: rename 'damon_pa_access_chk_result->page_sz' to
    'folio_sz'
  mm/damon/paddr: remove folio_sz filed from damon_pa_access_chk_result
  mm/damon/paddr: remove damon_pa_access_chk_result struct

 mm/damon/paddr.c | 44 +++++++++++++++++---------------------------
 mm/damon/vaddr.c | 30 ++++++++++++++----------------
 2 files changed, 31 insertions(+), 43 deletions(-)

-- 
2.25.1

