Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D3D64DD0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiLOOnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLOOni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:43:38 -0500
Received: from blackmesa.kw-serverwartung.de (blackmesa.kw-serverwartung.de [78.46.90.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D182F020
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:43:36 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTP id A34F97B80EA;
        Thu, 15 Dec 2022 14:43:35 +0000 (UTC)
Received: from blackmesa.kw-serverwartung.de ([127.0.0.1])
        by localhost (blackmesa.kw-serverwartung.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ksv2ZMC1t23A; Thu, 15 Dec 2022 14:43:33 +0000 (UTC)
Received: from citadel.fritz.box (i59F4DEB3.versanet.de [89.244.222.179])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTPSA id 534267B81E1;
        Thu, 15 Dec 2022 14:43:31 +0000 (UTC)
From:   =?UTF-8?q?Kai=20Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 3/3] checkpatch: use proper way for show problematic line
Date:   Thu, 15 Dec 2022 15:43:26 +0100
Message-Id: <da2b21b7d6fc00404e5ba296ab3de3731b6af5c2.1671114724.git.kai@dev.carbon-project.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1671114724.git.kai@dev.carbon-project.org>
References: <cover.1670152844.git.kai@dev.carbon-project.org> <cover.1671114724.git.kai@dev.carbon-project.org>
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

From: Thorsten Leemhuis <linux@leemhuis.info>

Instead of using an unnecessarily complicated approach to print a line
that is warned about, use `$herecurr` instead, just like everywhere else
in checkpatch. While at it, remove a superfluous  space in one of the
changed lines, too.

Both problems were found by Joe Perches.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Kai Wasserbäch <kai@dev.carbon-project.org>
---
 scripts/checkpatch.pl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9434f94d2d..f7ebbdf4f0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3142,17 +3142,17 @@ sub process {
 			if ($sign_off =~ /^co-developed-by:$/i) {
 				if ($email eq $author) {
 					WARN("BAD_SIGN_OFF",
-					      "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . "$here\n" . $rawline);
+					      "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . $herecurr);
 				}
 				if (!defined $lines[$linenr]) {
 					WARN("BAD_SIGN_OFF",
-					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline);
+					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . $herecurr);
 				} elsif ($rawlines[$linenr] !~ /^\s*signed-off-by:\s*(.*)/i) {
 					WARN("BAD_SIGN_OFF",
-					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
+					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . $herecurr . $rawlines[$linenr] . "\n");
 				} elsif ($1 ne $email) {
 					WARN("BAD_SIGN_OFF",
-					     "Co-developed-by and Signed-off-by: name/email do not match \n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
+					     "Co-developed-by and Signed-off-by: name/email do not match\n" . $herecurr . $rawlines[$linenr] . "\n");
 				}
 			}
 
-- 
2.35.1

