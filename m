Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE2E641CB6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 12:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiLDLja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 06:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiLDLjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 06:39:02 -0500
X-Greylist: delayed 309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 04 Dec 2022 03:38:59 PST
Received: from blackmesa.kw-serverwartung.de (blackmesa.kw-serverwartung.de [78.46.90.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9057C18353
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 03:38:59 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTP id B5D127B80BE;
        Sun,  4 Dec 2022 11:33:47 +0000 (UTC)
Received: from blackmesa.kw-serverwartung.de ([127.0.0.1])
        by localhost (blackmesa.kw-serverwartung.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DsZqioH_2RIr; Sun,  4 Dec 2022 11:33:45 +0000 (UTC)
Received: from citadel.fritz.box (i5C74630E.versanet.de [92.116.99.14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTPSA id 410137B81BA;
        Sun,  4 Dec 2022 11:33:45 +0000 (UTC)
From:   =?UTF-8?q?Kai=20Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH 1/2] feat: checkpatch: error on usage of a Buglink tag in the commit log
Date:   Sun,  4 Dec 2022 12:33:38 +0100
Message-Id: <66fc52aadd45f0c4178fbc6063615fee163b5a3f.1670152844.git.kai@dev.carbon-project.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1670152844.git.kai@dev.carbon-project.org>
References: <cover.1670152844.git.kai@dev.carbon-project.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggested-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Kai Wasserbäch <kai@dev.carbon-project.org>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1e5e66ae5a..a6d2ccaa3e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3248,6 +3248,12 @@ sub process {
 			}
 		}
 
+# check if Bug[lL]ink: or Bugzilla: is used and error
+		if ($in_commit_log && $line =~ /^\s*(buglink|bugzilla):\s*(.*)/i) {
+		    ERROR("COMMIT_LOG_BAD_BUGLINK",
+			  "Non-standard tag '" . $1 . "' - use 'Link:' instead!\n" . $herecurr);
+		}
+
 # Check for git id commit length and improperly formed commit descriptions
 # A correctly formed commit description is:
 #    commit <SHA-1 hash length 12+ chars> ("Complete commit subject")
-- 
2.35.1

