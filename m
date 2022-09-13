Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129B85B797E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiIMS1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiIMS0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:26:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91635FDF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F1DB61547
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B87CC433C1;
        Tue, 13 Sep 2022 17:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663091094;
        bh=A+CgN3B+g3StjvR1ecSJxFzUf8y+UUwnpB+0EtAIiO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CaZNkoG/DVyccvLtqoqoXyvYOsHQtVbs6/wMr5ibaQ7DAm+4nezKW8iI7X+nPrA/L
         ZQiVPvS/2eoWgjc45bbWm9hmWeeoxRGXCrEYslIJMGLNa6nuHsgWuBSsmFfL1DfABf
         of72OPPFBIWP3hapXUV0alxnuRiZx3zVSIXg8XXPNpNQVW5dwTex4KEDlPQAO5Xe34
         OsdNZRiLs4KjD0ofUTXPgIAI88nH4KUH8FcBu9Dw3JwbR/idcFmxqE46Qe29kkfuvQ
         9j2yEPtwNm2knoIE4eAI+4gV1axPzGOMUwTDlyMrXqhHIQuMEY7occdn9bn74VZdT2
         VqhFkGWzuH27g==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/22] mm/damon/paddr: make supported DAMOS actions of paddr clear
Date:   Tue, 13 Sep 2022 17:44:28 +0000
Message-Id: <20220913174449.50645-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913174449.50645-1-sj@kernel.org>
References: <20220913174449.50645-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'swtich-case' statement in 'damon_va_apply_scheme()' function
provides a 'case' for every supported DAMOS action while all
not-yet-supported DAMOS actions fall through the 'default' case, and
comment it so that people can easily know which actions are supported.
Its counterpart in 'paddr', 'damon_pa_apply_scheme()', however, doesn't.
This commit makes the 'paddr' side function follows the pattern of
'vaddr' for better readability and consistency.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index f00cbe74a00e..5eba09d50855 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -274,7 +274,10 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		return damon_pa_mark_accessed(r);
 	case DAMOS_LRU_DEPRIO:
 		return damon_pa_deactivate_pages(r);
+	case DAMOS_STAT:
+		break;
 	default:
+		/* DAMOS actions that not yet supported by 'paddr'. */
 		break;
 	}
 	return 0;
-- 
2.25.1

