Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C405D69D1C8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjBTRBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBTRBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:01:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84785E3BF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:01:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9E5760ED2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65349C433D2;
        Mon, 20 Feb 2023 17:01:40 +0000 (UTC)
Date:   Mon, 20 Feb 2023 12:01:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] ktest.pl: Updates for 6.3
Message-ID: <20230220120138.2ae03ccd@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Updates to ktest.pl:

- Fix three instances that the tty is not given back to the console on exit.
  Forcing the user to do a "reset" to get the console back.

- Fix the console monitor to not hang when too much data is given by the ssh
  output.

Note, these were all fixes, but I like to run them internally for a bit
before pushing.

Please pull the latest ktest-v6.3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
ktest-v6.3

Tag SHA1: 9534fe8bbe22b6c7f7de555ad54e414f4165b88e
Head SHA1: 7dc8e24f0e09834341f84d37433840b353d64bc8


Masami Hiramatsu (Google) (1):
      ktest: Restore stty setting at first in dodie

Steven Rostedt (3):
      ktest.pl: Fix missing "end_monitor" when machine check fails
      ktest.pl: Give back console on Ctrt^C on monitor
      ktest.pl: Add RUN_TIMEOUT option with default unlimited

----
 tools/testing/ktest/ktest.pl    | 36 ++++++++++++++++++++++++++----------
 tools/testing/ktest/sample.conf |  5 +++++
 2 files changed, 31 insertions(+), 10 deletions(-)
---------------------------
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index ac59999ed3de..829f5bdfd2e4 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -178,6 +178,7 @@ my $store_failures;
 my $store_successes;
 my $test_name;
 my $timeout;
+my $run_timeout;
 my $connect_timeout;
 my $config_bisect_exec;
 my $booted_timeout;
@@ -340,6 +341,7 @@ my %option_map = (
     "STORE_SUCCESSES"		=> \$store_successes,
     "TEST_NAME"			=> \$test_name,
     "TIMEOUT"			=> \$timeout,
+    "RUN_TIMEOUT"		=> \$run_timeout,
     "CONNECT_TIMEOUT"		=> \$connect_timeout,
     "CONFIG_BISECT_EXEC"	=> \$config_bisect_exec,
     "BOOTED_TIMEOUT"		=> \$booted_timeout,
@@ -1495,7 +1497,8 @@ sub reboot {
 
 	# Still need to wait for the reboot to finish
 	wait_for_monitor($time, $reboot_success_line);
-
+    }
+    if ($powercycle || $time) {
 	end_monitor;
     }
 }
@@ -1535,6 +1538,11 @@ sub dodie {
     return if ($in_die);
     $in_die = 1;
 
+    if ($monitor_cnt) {
+	# restore terminal settings
+	system("stty $stty_orig");
+    }
+
     my $i = $iteration;
 
     doprint "CRITICAL FAILURE... [TEST $i] ", @_, "\n";
@@ -1581,11 +1589,6 @@ sub dodie {
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
@@ -1857,6 +1860,14 @@ sub run_command {
     $command =~ s/\$SSH_USER/$ssh_user/g;
     $command =~ s/\$MACHINE/$machine/g;
 
+    if (!defined($timeout)) {
+	$timeout = $run_timeout;
+    }
+
+    if (!defined($timeout)) {
+	$timeout = -1; # tell wait_for_input to wait indefinitely
+    }
+
     doprint("$command ... ");
     $start_time = time;
 
@@ -1883,13 +1894,10 @@ sub run_command {
 
     while (1) {
 	my $fp = \*CMD;
-	if (defined($timeout)) {
-	    doprint "timeout = $timeout\n";
-	}
 	my $line = wait_for_input($fp, $timeout);
 	if (!defined($line)) {
 	    my $now = time;
-	    if (defined($timeout) && (($now - $start_time) >= $timeout)) {
+	    if ($timeout >= 0 && (($now - $start_time) >= $timeout)) {
 		doprint "Hit timeout of $timeout, killing process\n";
 		$hit_timeout = 1;
 		kill 9, $pid;
@@ -2061,6 +2069,11 @@ sub wait_for_input {
 	$time = $timeout;
     }
 
+    if ($time < 0) {
+	# Negative number means wait indefinitely
+	undef $time;
+    }
+
     $rin = '';
     vec($rin, fileno($fp), 1) = 1;
     vec($rin, fileno(\*STDIN), 1) = 1;
@@ -4200,6 +4213,9 @@ sub send_email {
 }
 
 sub cancel_test {
+    if ($monitor_cnt) {
+	end_monitor;
+    }
     if ($email_when_canceled) {
 	my $name = get_test_name;
 	send_email("KTEST: Your [$name] test was cancelled",
diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index 2d0fe15a096d..f43477a9b857 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -817,6 +817,11 @@
 # is issued instead of a reboot.
 # CONNECT_TIMEOUT = 25
 
+# The timeout in seconds for how long to wait for any running command
+# to timeout. If not defined, it will let it go indefinitely.
+# (default undefined)
+#RUN_TIMEOUT = 600
+
 # In between tests, a reboot of the box may occur, and this
 # is the time to wait for the console after it stops producing
 # output. Some machines may not produce a large lag on reboot
