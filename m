Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF14E641CB5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 12:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiLDLjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 06:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiLDLjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 06:39:02 -0500
Received: from blackmesa.kw-serverwartung.de (blackmesa.kw-serverwartung.de [78.46.90.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A051E1838A
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 03:38:59 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTP id A55107B81E4;
        Sun,  4 Dec 2022 11:33:49 +0000 (UTC)
Received: from blackmesa.kw-serverwartung.de ([127.0.0.1])
        by localhost (blackmesa.kw-serverwartung.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KInPBbexaMGr; Sun,  4 Dec 2022 11:33:47 +0000 (UTC)
Received: from citadel.fritz.box (i5C74630E.versanet.de [92.116.99.14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTPSA id 6C9457B81BF;
        Sun,  4 Dec 2022 11:33:45 +0000 (UTC)
From:   =?UTF-8?q?Kai=20Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH 2/2] feat: checkpatch: Warn about Reported-by: not being followed by a Link:
Date:   Sun,  4 Dec 2022 12:33:39 +0100
Message-Id: <721266a0e453bdebf9dc9b4a5fb5482f278fb7d0.1670152844.git.kai@dev.carbon-project.org>
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
 scripts/checkpatch.pl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a6d2ccaa3e..d957e9fddf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3144,6 +3144,20 @@ sub process {
 					     "Co-developed-by and Signed-off-by: name/email do not match \n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
 				}
 			}
+
+# check if Reported-by: is followed by a Link:
+			if ($sign_off =~ /^reported-by:$/i) {
+				if (!defined $lines[$linenr]) {
+					WARN("BAD_REPORTED_BY_LINK",
+					     "Reported-by: must be immediately followed by Link:\n" . "$here\n" . $rawline);
+				} elsif ($rawlines[$linenr] !~ /^\s*link:\s*(.*)/i) {
+					WARN("BAD_REPORTED_BY_LINK",
+					     "Reported-by: must be immediately followed by Link:\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
+				} elsif ($lines[$linenr] !~ /https?:\/\//i) {
+					WARN("BAD_REPORTED_BY_LINK",
+					     "Link: following Reported-by: should contain an URL\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
+				}
+			}
 		}
 
 # Check Fixes: styles is correct
-- 
2.35.1

