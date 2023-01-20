Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7EB67549D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjATMfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjATMfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:35:31 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144B4BD17F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:35:24 -0800 (PST)
Received: from ip4d14bd73.dynamic.kabel-deutschland.de ([77.20.189.115] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pIqc5-0007pV-WF; Fri, 20 Jan 2023 13:35:22 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     =?UTF-8?q?Kai=20Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] checkpatch: warn when unknown tags are used for links
Date:   Fri, 20 Jan 2023 13:35:18 +0100
Message-Id: <3b036087d80b8c0e07a46a1dbaaf4ad0d018f8d5.1674217480.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1674217480.git.linux@leemhuis.info>
References: <cover.1674217480.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1674218125;93060bd7;
X-HE-SMSGID: 1pIqc5-0007pV-WF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Wasserbäch <kai@dev.carbon-project.org>

Issue a warning when encountering URLs behind unknown tags, as Linus
recently stated ```please stop making up random tags that make no sense.
Just use "Link:"```[1]. That statement was triggered by an use of
'BugLink', but that's not the only tag people invented:

$ git log -100000 --no-merges --format=email -P \
   --grep='^\w+:[ \t]*http' | grep -Poh '^\w+:[ \t]*http' | \
  sort | uniq -c | sort -rn | head -n 20
 103958 Link: http
    418 BugLink: http
    372 Patchwork: http
    280 Closes: http
    224 Bug: http
    123 References: http
     84 Bugzilla: http
     61 URL: http
     42 v1: http
     38 Datasheet: http
     20 v2: http
      9 Ref: http
      9 Fixes: http
      9 Buglink: http
      8 v3: http
      8 Reference: http
      7 See: http
      6 1: http
      5 link: http
      3 Link:http

Some of these non-standard tags make it harder for external tools that
rely on use of proper tags. One of those tools is the regression
tracking bot 'regzbot', which looks out for "Link:" tags pointing to
reports of tracked regressions.

The initial idea was to use a disallow list to raise an error when
encountering known unwanted tags like BugLink:; during review it was
requested to use a list of allowed tags instead[2].

Link: https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/15f7df96d49082fb7799dda6e187b33c84f38831.camel@perches.com/ [2]
Signed-off-by: Kai Wasserbäch <kai@dev.carbon-project.org>
Co-developed-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 78cc595b98ce..d739ce0909b1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3250,6 +3250,18 @@ sub process {
 			$commit_log_possible_stack_dump = 0;
 		}
 
+# Check for odd tags before a URI/URL
+		if ($in_commit_log &&
+		    $line =~ /^\s*(\w+):\s*http/ && $1 ne 'Link') {
+			if ($1 =~ /^v(?:ersion)?\d+/i) {
+				WARN("COMMIT_LOG_VERSIONING",
+				     "Patch version information should be after the --- line\n" . $herecurr);
+			} else {
+				WARN("COMMIT_LOG_USE_LINK",
+				     "Unknown link reference '$1:', use 'Link:' instead\n" . $herecurr);
+			}
+		}
+
 # Check for lines starting with a #
 		if ($in_commit_log && $line =~ /^#/) {
 			if (WARN("COMMIT_COMMENT_SYMBOL",
-- 
2.39.0

