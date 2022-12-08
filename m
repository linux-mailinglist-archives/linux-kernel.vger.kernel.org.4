Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40AF64763D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLHTdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiLHTcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:32:55 -0500
Received: from blackmesa.kw-serverwartung.de (blackmesa.kw-serverwartung.de [78.46.90.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A293722E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:32:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTP id E44B27B8099;
        Thu,  8 Dec 2022 19:32:51 +0000 (UTC)
Received: from blackmesa.kw-serverwartung.de ([127.0.0.1])
        by localhost (blackmesa.kw-serverwartung.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U3bU109iuLOH; Thu,  8 Dec 2022 19:32:48 +0000 (UTC)
Received: from citadel.fritz.box (i59F4DED6.versanet.de [89.244.222.214])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTPSA id 856CA7B81B9;
        Thu,  8 Dec 2022 19:32:48 +0000 (UTC)
From:   =?UTF-8?q?Kai=20Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/2] checkpatch: warn when Reported-by: is not followed by Link:
Date:   Thu,  8 Dec 2022 20:32:46 +0100
Message-Id: <4af6cd7f0833f18e9eee8caba1913e682c5ec071.1670527774.git.kai@dev.carbon-project.org>
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

Encourage patch authors to link to reports by issuing a warning, if
a Reported-by: is not accompanied by a link to the report. Those links
are often extremely useful for any code archaeologist that wants to know
more about the backstory of a change than the commit message provides.
That includes maintainers higher up in the patch-flow hierarchy, which
is why Linus asks developers to add such links [1, 2, 3]. To quote [1]:

> Again, the commit has a link to the patch *submission*, which is
> almost entirely useless. There's no link to the actual problem the
> patch fixes.
>
> [...]
>
> Put another way: I can see that
>
> Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
>
> in the commit, but I don't have a clue what the actual report was, and
> there really isn't enough information in the commit itself, except for
> a fairly handwavy "Device drivers might, for instance, still need to
> flush operations.."
>
> I don't want to know what device drivers _might_ do. I would want to
> have an actual pointer to what they do and where.

Another reason why these links are wanted: the ongoing regression
tracking efforts can only scale with them, as they allow the regression
tracking bot 'regzbot' to automatically connect tracked reports with
patches that are posted or committed to fix tracked regressions.

Link: https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/ [2]
Link: https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/ [3]
Signed-off-by: Kai Wasserbäch <kai@dev.carbon-project.org>
Co-developed-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 scripts/checkpatch.pl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f2f997f487..d4547c5fd4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3144,6 +3144,20 @@ sub process {
 					     "Co-developed-by and Signed-off-by: name/email do not match \n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
 				}
 			}
+
+			# check if Reported-by: is followed by a Link:
+			if ($sign_off =~ /^reported-by:$/i) {
+				if (!defined $lines[$linenr]) {
+					WARN("BAD_REPORTED_BY_LINK",
+					     "Reported-by: should be immediately followed by Link: to the report\n" . "$here\n" . $rawline);
+				} elsif ($rawlines[$linenr] !~ /^\s*link:\s*(.*)/i) {
+					WARN("BAD_REPORTED_BY_LINK",
+					     "Reported-by: should be immediately followed by Link: to the report\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
+				} elsif ($lines[$linenr] !~ /https?:\/\//i) {
+					WARN("BAD_REPORTED_BY_LINK",
+					     "Link: following Reported-by: should contain an URL\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
+				}
+			}
 		}
 
 # Check Fixes: styles is correct
-- 
2.35.1

