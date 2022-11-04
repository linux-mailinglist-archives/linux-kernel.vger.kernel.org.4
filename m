Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153A3618E57
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiKDCil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKDCii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:38:38 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1071123388
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 19:38:36 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id YDQ00033;
        Fri, 04 Nov 2022 10:38:33 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.12; Fri, 4 Nov 2022 10:38:33 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <minchan@kernel.org>, <ngupta@vflare.org>,
        <akpm@linux-foundation.org>
CC:     <senozhatsky@chromium.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] zsmalloc: replace IS_ERR() with IS_ERR_VALUE()
Date:   Thu, 3 Nov 2022 22:38:18 -0400
Message-ID: <20221104023818.1728-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   20221104103833531fac831319cb0b27e05bee90e47ef1
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid typecasts that are needed for IS_ERR() and use IS_ERR_VALUE()
instead.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 mm/zsmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index a40c548520d3..1322f3615067 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -379,7 +379,7 @@ static int zs_zpool_malloc(void *pool, size_t size, gfp_t gfp,
 {
 	*handle = zs_malloc(pool, size, gfp);
 
-	if (IS_ERR((void *)(*handle)))
+	if (IS_ERR_VALUE(*handle))
 		return PTR_ERR((void *)*handle);
 	return 0;
 }
-- 
2.27.0

