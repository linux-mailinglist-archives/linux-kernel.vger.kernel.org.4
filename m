Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76E364763C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiLHTdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLHTcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:32:55 -0500
Received: from blackmesa.kw-serverwartung.de (blackmesa.kw-serverwartung.de [78.46.90.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0FB36C4C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:32:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTP id E81787B81BE;
        Thu,  8 Dec 2022 19:32:50 +0000 (UTC)
Received: from blackmesa.kw-serverwartung.de ([127.0.0.1])
        by localhost (blackmesa.kw-serverwartung.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 60jFDUbe9VS7; Thu,  8 Dec 2022 19:32:48 +0000 (UTC)
Received: from citadel.fritz.box (i59F4DED6.versanet.de [89.244.222.214])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTPSA id 355F07B8099;
        Thu,  8 Dec 2022 19:32:48 +0000 (UTC)
From:   =?UTF-8?q?Kai=20Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/2] checkpatch: warn when unknown tags are used for links
Date:   Thu,  8 Dec 2022 20:32:45 +0100
Message-Id: <869badb999d4021dd6efd792f53fc2859257c350.1670527774.git.kai@dev.carbon-project.org>
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

Issue a warning when encountering URLs behind unknown tags, as Linus
recently stated ```please stop making up random tags that make no sense.
Just use "Link:"```[1]. That statement was triggered by an use of
'BugLink', but that's not the only tag people invented:

$ git log -100000 --format=email -P --grep='^\w+:[ \t]*http' | \
  grep -Poh '^\w+:[ \t]*http' | \
  sort | uniq -c | sort -rn | head -n 20
 103889 Link: http
    415 BugLink: http
    372 Patchwork: http
    270 Closes: http
    221 Bug: http
    121 References: http
    101 v1: http
     77 Bugzilla: http
     60 URL: http
     59 v2: http
     37 Datasheet: http
     35 v3: http
     19 v4: http
     12 v5: http
      9 Ref: http
      9 Fixes: http
      9 Buglink: http
      8 v6: http
      8 Reference: http
      7 V1: http

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
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1e5e66ae5a..f2f997f487 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3239,6 +3239,13 @@ sub process {
 			$commit_log_possible_stack_dump = 0;
 		}
 
+# Check for odd tags before a URI/URL
+		if ($in_commit_log &&
+		    $line =~ /^\s*(\w+):\s*http/ && $1 !~ /^Link/) {
+			WARN("COMMIT_LOG_USE_LINK",
+			     "Unknown link reference '$1:', use 'Link:' instead.\n" . $herecurr);
+		}
+
 # Check for lines starting with a #
 		if ($in_commit_log && $line =~ /^#/) {
 			if (WARN("COMMIT_COMMENT_SYMBOL",
-- 
2.35.1

