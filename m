Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184D470DFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbjEWPJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbjEWPI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:08:58 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C055C11A
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:08:57 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:b0ac:7afd:272:4cff])
        by laurent.telenet-ops.be with bizsmtp
        id 0F8x2A0070Jkz7G01F8x2D; Tue, 23 May 2023 17:08:57 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q1Tcw-002svi-K2;
        Tue, 23 May 2023 17:08:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q1TdB-00CkL4-2F;
        Tue, 23 May 2023 17:08:57 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] xfs: Fix undefined behavior of shift into sign bit
Date:   Tue, 23 May 2023 17:08:55 +0200
Message-Id: <2af4f6b4f57f0c692bec8eff5bed8c1fb8e55d66.1684854501.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc-5:

    In file included from ./include/trace/define_trace.h:102:0,
		     from ./fs/xfs/scrub/trace.h:988,
		     from fs/xfs/scrub/trace.c:40:
    ./fs/xfs/./scrub/trace.h: In function ‘trace_raw_output_xchk_fsgate_class’:
    ./fs/xfs/scrub/scrub.h:111:28: error: initializer element is not constant
     #define XREP_ALREADY_FIXED (1 << 31) /* checking our repair work */
				^

Shifting the (signed) value 1 into the sign bit is undefined behavior.

Fix this for all definitions in the file by shifting "1U" instead of
"1".

This was exposed by the first user added in commit 466c525d6d35e691
("xfs: minimize overhead of drain wakeups by using jump labels").

Fixes: 160b5a784525e8a4 ("xfs: hoist the already_fixed variable to the scrub context")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
v2:
  - Add Reviewed-by.
---
 fs/xfs/scrub/scrub.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/scrub/scrub.h b/fs/xfs/scrub/scrub.h
index b38e93830ddea2b0..e113f2f5c254b085 100644
--- a/fs/xfs/scrub/scrub.h
+++ b/fs/xfs/scrub/scrub.h
@@ -105,10 +105,10 @@ struct xfs_scrub {
 };
 
 /* XCHK state flags grow up from zero, XREP state flags grown down from 2^31 */
-#define XCHK_TRY_HARDER		(1 << 0)  /* can't get resources, try again */
-#define XCHK_FSGATES_DRAIN	(1 << 2)  /* defer ops draining enabled */
-#define XCHK_NEED_DRAIN		(1 << 3)  /* scrub needs to drain defer ops */
-#define XREP_ALREADY_FIXED	(1 << 31) /* checking our repair work */
+#define XCHK_TRY_HARDER		(1U << 0)  /* can't get resources, try again */
+#define XCHK_FSGATES_DRAIN	(1U << 2)  /* defer ops draining enabled */
+#define XCHK_NEED_DRAIN		(1U << 3)  /* scrub needs to drain defer ops */
+#define XREP_ALREADY_FIXED	(1U << 31) /* checking our repair work */
 
 /*
  * The XCHK_FSGATES* flags reflect functionality in the main filesystem that
-- 
2.34.1

