Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2B05B852B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiINJig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiINJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:38:16 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84BFB1ED
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:37:13 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663148231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hHiFxLoQl7nFkGX8kgtVUXbRSPMp0KpED73uMSjHu+w=;
        b=VoSrXwXuRHkuMJqgFeh5tLtjh1NB+Ha72/uvICQk9QNQ0pkQ03EOA93YfkOxxjmDqWxgrR
        8MYTYS34zwlstEhfu5gl+oJ43Iu4OeA6gADuRa1He9hy+nycYoP5A6zpOG5V9cmFBsW2yk
        h4tFSd/Q9+2rr/XMyyF4obkf2M4yTOk=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     sieberf@amazon.com, shakeelb@google.com, foersleo@amazon.de,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/damon: fix missing damon_del_region()
Date:   Wed, 14 Sep 2022 17:36:36 +0800
Message-Id: <20220914093636.1184590-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be called damon_del_region() before free each region, so use
damon_destroy_region() instead of damon_free_region().

Fixes: f23b8eee1871 (mm/damon/core: implement region-based sampling)
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0b1eb945c68a..e62e7ebf4b12 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -361,7 +361,7 @@ void damon_free_target(struct damon_target *t)
 	struct damon_region *r, *next;
 
 	damon_for_each_region_safe(r, next, t)
-		damon_free_region(r);
+		damon_destroy_region(r, t);
 	kfree(t);
 }
 
-- 
2.25.1

