Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2A35F2523
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 21:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJBTbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 15:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBTbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 15:31:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095953AB13
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 12:31:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A0F560ECC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 19:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADC4C433D6;
        Sun,  2 Oct 2022 19:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664739096;
        bh=bQS/eXJeMiPmj71PLej7rSCZfOQeTrzaD8xCsX+qwWs=;
        h=From:To:Cc:Subject:Date:From;
        b=mqXGGEijWGYOiDoFBLN96KIHMPXk+iRXIEhFZEthkWkhHbII4hJTk8mU7LmVLy5Hb
         27BrqgLA7UBZEmpgEnID8xnk6WO0IGDFKavvDraIxLFdEbbt/bmMCDhtEWDyM8u7aQ
         yI+/LFUrOlsM1ulAgbtmQxXx5kOqO55fG59CsmEiJ5elUp6M3tiNfsCmq7pqLCMXoZ
         PbWKrJE01GK1Gt0BUUXA9wxzzh3sAwSL6vF3F1rgr/zEyXKuyp1CuwunE6vDOqW5Zi
         khuo8Dk5lBvSZ6cMAIlkRdtunin+/MAJCHpz6LYqi5cpCkFwVPDTIoFpa8Spw2bFcR
         kkDribUKFF/Cg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH] mm/damon/core: initialize damon_target->list in damon_new_target()
Date:   Sun,  2 Oct 2022 19:31:30 +0000
Message-Id: <20221002193130.8227-1-sj@kernel.org>
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

'struct damon_target' creation function, 'damon_new_target()' is not
initializing its '->list' field, unlike other DAMON structs creator
functions such as 'damon_new_region()'.  Normal users of
'damon_new_target()' initializes the field by adding the target to DAMON
context's targets list, but some code could access the uninitialized
field.

This commit avoids the case by initializing the field in
'damon_new_target()'.

Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Fixes: f23b8eee1871 ("mm/damon/core: implement region-based sampling")
Signed-off-by: SeongJae Park <sj@kernel.org>
---

 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1d952fa7ba3e..1e6691771a95 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -345,6 +345,7 @@ struct damon_target *damon_new_target(void)
 	t->pid = NULL;
 	t->nr_regions = 0;
 	INIT_LIST_HEAD(&t->regions_list);
+	INIT_LIST_HEAD(&t->list);
 
 	return t;
 }
-- 
2.25.1

