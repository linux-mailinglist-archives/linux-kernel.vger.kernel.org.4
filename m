Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371AB5B4EF3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 15:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiIKNPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIKNPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 09:15:39 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7284913F27
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 06:15:37 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id XMoAo3G0KjJi0XMoBoWog3; Sun, 11 Sep 2022 15:15:36 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Sep 2022 15:15:36 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [RFC PATCH] checkpatch: Check check for places where dev_err_probe() would likely be better than dev_err()
Date:   Sun, 11 Sep 2022 15:15:33 +0200
Message-Id: <3cdc2e776dea77b07c75694ba1410bd21e8ed749.1662902045.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions are known to potentially return -EPROBE_DEFER. In such a
case, it is likely that dev_err_probe() is a better choice than err_err().

dev_err_probe():
  - is usually less verbose
  - generates smaller .o files
  - handles -EPROBE_DEFER so that logs are not spammed
  - automatically log the error code in a human readable way

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is only a PoC to see if there is some interest in such a new
check.
The hard coded '5 lines of context' has been chosen because a typical
pattern is:

	clk = devm_clk_get(dev, "clk_lcd");
	if (IS_ERR(clk) {
		dev_err(dev, "Error meesage\n");
		return PTR_ERR(clk);
	}
---
 scripts/checkpatch.pl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2737e4ced574..88365749ed2e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2625,6 +2625,9 @@ sub process {
 	my $last_blank_line = 0;
 	my $last_coalesced_string_linenr = -1;
 
+	my $last_function_that_return_defer = "";
+	my $last_function_that_return_defer_linenr = 0;
+
 	our @report = ();
 	our $cnt_lines = 0;
 	our $cnt_error = 0;
@@ -7459,6 +7462,17 @@ sub process {
 			WARN("DUPLICATED_SYSCTL_CONST",
 				"duplicated sysctl range checking value '$1', consider using the shared one in include/linux/sysctl.h\n" . $herecurr);
 		}
+
+# check for places where dev_err_probe() would likely be better than dev_err()
+		if ($line =~ /((?:devm_)?clk_get)s*\(/) {
+			$last_function_that_return_defer = $1;
+			$last_function_that_return_defer_linenr = $linenr;
+		}
+		if ($last_function_that_return_defer_linenr >= ($linenr - 5) &&
+		    $line =~ /dev_err[^_]/) {
+			WARN("LIKELY_DEV_ERR_PROBE",
+				"dev_err_probe() is likely a better choice than err_err() after a " . $last_function_that_return_defer . "() call\n" . $herecurr);
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on
-- 
2.34.1

