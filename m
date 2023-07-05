Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357B47486F4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjGEOyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjGEOyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:54:38 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE52C1985
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:54:16 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5979:7b6f:39a:b9cb])
        by baptiste.telenet-ops.be with bizsmtp
        id HSuC2A00Z45Xpxs01SuCGm; Wed, 05 Jul 2023 16:54:13 +0200
Received: from rox.of.borg ([192.168.97.57] helo=rox)
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qH3tR-000ccO-2b;
        Wed, 05 Jul 2023 16:54:12 +0200
Received: from geert by rox with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qH3tU-00Aw3y-K5;
        Wed, 05 Jul 2023 16:54:12 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] lib: dhry: Fix sleeping allocations inside non-preemptable section
Date:   Wed,  5 Jul 2023 16:54:04 +0200
Message-Id: <bac6d517818a7cd8efe217c1ad649fffab9cc371.1688568764.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Smatch static checker reports the following warnings:

    lib/dhry_run.c:38 dhry_benchmark() warn: sleeping in atomic context
    lib/dhry_run.c:43 dhry_benchmark() warn: sleeping in atomic context

Indeed, dhry() does sleeping allocations inside the non-preemptable
section delimited by get_cpu()/put_cpu().

Fix this by using atomic allocations instead.
Add error handling, as atomic these allocations may fail.

Fixes: 13684e966d46283e ("lib: dhry: fix unstable smp_processor_id(_) usage")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/0469eb3a-02eb-4b41-b189-de20b931fa56@moroto.mountain
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Alternatively, memory (de)allocation could be spin off into their own
functions, and called outside the non-preemptable section.  But that
would be more intrusive.
---
 lib/dhry_1.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/dhry_1.c b/lib/dhry_1.c
index 83247106824cc7f4..08edbbb19f573ff7 100644
--- a/lib/dhry_1.c
+++ b/lib/dhry_1.c
@@ -139,8 +139,15 @@ int dhry(int n)
 
 	/* Initializations */
 
-	Next_Ptr_Glob = (Rec_Pointer)kzalloc(sizeof(Rec_Type), GFP_KERNEL);
-	Ptr_Glob = (Rec_Pointer)kzalloc(sizeof(Rec_Type), GFP_KERNEL);
+	Next_Ptr_Glob = (Rec_Pointer)kzalloc(sizeof(Rec_Type), GFP_ATOMIC);
+	if (!Next_Ptr_Glob)
+		return -ENOMEM;
+
+	Ptr_Glob = (Rec_Pointer)kzalloc(sizeof(Rec_Type), GFP_ATOMIC);
+	if (!Ptr_Glob) {
+		kfree(Next_Ptr_Glob);
+		return -ENOMEM;
+	}
 
 	Ptr_Glob->Ptr_Comp = Next_Ptr_Glob;
 	Ptr_Glob->Discr = Ident_1;
-- 
2.34.1

