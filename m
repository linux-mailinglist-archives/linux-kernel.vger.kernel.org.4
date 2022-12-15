Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B13564DD0B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiLOOns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiLOOni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:43:38 -0500
Received: from blackmesa.kw-serverwartung.de (blackmesa.kw-serverwartung.de [78.46.90.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528FD2F016
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:43:35 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTP id 5AD807B807E;
        Thu, 15 Dec 2022 14:43:33 +0000 (UTC)
Received: from blackmesa.kw-serverwartung.de ([127.0.0.1])
        by localhost (blackmesa.kw-serverwartung.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aEN2543Ta_UB; Thu, 15 Dec 2022 14:43:30 +0000 (UTC)
Received: from citadel.fritz.box (i59F4DEB3.versanet.de [89.244.222.179])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTPSA id A589A7B80EA;
        Thu, 15 Dec 2022 14:43:30 +0000 (UTC)
From:   =?UTF-8?q?Kai=20Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/3] checkpatch: warn when unknown tags are used for links
Date:   Thu, 15 Dec 2022 15:43:24 +0100
Message-Id: <d05ef86d7c2e8ea6080c7ec94f1780dff9d8787f.1671114724.git.kai@dev.carbon-project.org>
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
Co-developed-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Kai Wasserbäch <kai@dev.carbon-project.org>
---
 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 78cc595b98..d739ce0909 100755
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
2.35.1

