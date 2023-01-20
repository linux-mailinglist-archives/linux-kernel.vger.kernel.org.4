Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFFB67507E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjATJQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjATJQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:16:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BE390863
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:16:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12EAB61E5D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5F3C433EF;
        Fri, 20 Jan 2023 09:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674206179;
        bh=KTNR9LhVdrM+/rBfaq95DAQYa8pxtNZi3bmJKjmNgrY=;
        h=From:To:Cc:Subject:Date:From;
        b=mCShWcPuse7og84SELWbj2KjDHSLC2MGOyXozLwO0asViFNLhm0n/UTXR2BNZDDRY
         npgEhyPnSnUIS5XoTLFBqxb8gpy2AKG0lhCU21gEVx0FcFy5Q04P7Il0AhcKqFvjLk
         bBMozRynucAd5L9+WWAkOI0iHH8dhYYNfwKqOoRPR+c6/Q23XwghHSTyL3wD2vOeJV
         mqGihdTncuZstEmbsHIIV9KnBQkH7XXA96F38e6DnhZ0NSm2C2L5QrzhY5F+vKSgIa
         ehJaJeh1qpFygIbM6UUbG6FMusC5fdkgcGVw2LDt4v77IKbVBNyAjoxfajZ1jGD4bQ
         vduBZLBJLIrzw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John 'Warthog9' Hawley <warthog9@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] ktest: Restore stty setting at first in dodie
Date:   Fri, 20 Jan 2023 18:16:16 +0900
Message-Id: <167420617635.2988775.13045295332829029437.stgit@devnote3>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

The do_send_email() will call die before restoring stty if sendmail
setting is not correct or sendmail is not installed. It is safer to
restore it in the beginning of dodie().

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/testing/ktest/ktest.pl |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index ac59999ed3de..9fb3d79b084c 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1535,6 +1535,11 @@ sub dodie {
     return if ($in_die);
     $in_die = 1;
 
+    if ($monitor_cnt) {
+	# restore terminal settings
+	system("stty $stty_orig");
+    }
+
     my $i = $iteration;
 
     doprint "CRITICAL FAILURE... [TEST $i] ", @_, "\n";
@@ -1581,11 +1586,6 @@ sub dodie {
 		"Your test started at $script_start_time has failed with:\n@_\n", $log_file);
     }
 
-    if ($monitor_cnt) {
-	# restore terminal settings
-	system("stty $stty_orig");
-    }
-
     if (defined($post_test)) {
 	run_command $post_test;
     }

