Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ED167549E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjATMfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjATMf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:35:29 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14376BD17E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:35:24 -0800 (PST)
Received: from ip4d14bd73.dynamic.kabel-deutschland.de ([77.20.189.115] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pIqc6-0007pV-S7; Fri, 20 Jan 2023 13:35:22 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     =?UTF-8?q?Kai=20Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] checkpatch: use proper way for show problematic line
Date:   Fri, 20 Jan 2023 13:35:20 +0100
Message-Id: <a6d455c5196219b2095c2ac3645498052845f32e.1674217480.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1674217480.git.linux@leemhuis.info>
References: <cover.1674217480.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1674218125;93060bd7;
X-HE-SMSGID: 1pIqc6-0007pV-S7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using an unnecessarily complicated approach to print a line
that is warned about, use `$herecurr` instead, just like everywhere else
in checkpatch.

While at it, remove a superfluous space in one of the changed lines,
too. In a unmodified line also remove a superfluous check for a space
before a signed-off-by tag, to me consistent with the check at the
start of the section.

All three problems were found by Joe Perches during review of new code
inspired by the code modified here.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 scripts/checkpatch.pl | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b74d6002f773..b1bf0c7b03a7 100755
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
-				} elsif ($rawlines[$linenr] !~ /^\s*signed-off-by:\s*(.*)/i) {
+					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . $herecurr);
+				} elsif ($rawlines[$linenr] !~ /^signed-off-by:\s*(.*)/i) {
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
2.39.0

