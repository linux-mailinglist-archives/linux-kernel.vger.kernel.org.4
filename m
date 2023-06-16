Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA9A7333DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345685AbjFPOoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345684AbjFPOoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:44:06 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A303230F3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:44:04 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qAAgC-009VIn-Dp; Fri, 16 Jun 2023 15:44:01 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qAAgD-000ivQ-09;
        Fri, 16 Jun 2023 15:44:01 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] zstd: fix g_debuglevel export warning
Date:   Fri, 16 Jun 2023 15:44:00 +0100
Message-Id: <20230616144400.172683-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The g_debuglevel variable in debug.c is only used when DEBUGLEVEL is
defined to be above 2. This means by default there's no actual definition
of this in the headers, so sparse is giving the following warning:

lib/zstd/common/debug.c:24:5: warning: symbol 'g_debuglevel' was not declared. Should it be static?

We can use the same check as in the header to remove this if it isn't
going to be used, silencing the warning and removing a small bit of unused
data.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 lib/zstd/common/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/zstd/common/debug.c b/lib/zstd/common/debug.c
index bb863c9ea616..820520b93d2b 100644
--- a/lib/zstd/common/debug.c
+++ b/lib/zstd/common/debug.c
@@ -21,4 +21,6 @@
 
 #include "debug.h"
 
+#if (DEBUGLEVEL>=2)
 int g_debuglevel = DEBUGLEVEL;
+#endif
-- 
2.39.2

