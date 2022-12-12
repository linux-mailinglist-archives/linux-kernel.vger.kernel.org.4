Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13D864AA40
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiLLWaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiLLWaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:30:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901E813F82
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E03C61255
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C122C433D2;
        Mon, 12 Dec 2022 22:30:19 +0000 (UTC)
Date:   Mon, 12 Dec 2022 17:30:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] ktest.pl: Updates for 6.2
Message-ID: <20221212173018.3c55203a@gandalf.local.home>
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

ktest changes for 6.2

- Fix minconfig test to unset the config and not relying on
  olddefconfig to do it, as some configs are set to default y

- Fix reading grub2 menus for handling submenus

- Add new ${shell <cmd>} to execute shell commands that will be useful
  for setting variables like: HOSTNAME := ${shell hostname}


Please pull the latest ktest-v6.2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
ktest-v6.2

Tag SHA1: 92ab08b90a396b3d430a1e95e387f110e453a852
Head SHA1: 88a51b4f2e65ca4378a81ff0925fad076e82e177


Steven Rostedt (2):
      ktest.pl minconfig: Unset configs instead of just removing them
      kest.pl: Fix grub2 menu handling for rebooting

Steven Rostedt (Google) (1):
      ktest.pl: Add shell commands to variables

----
 tools/testing/ktest/ktest.pl    | 32 +++++++++++++++++++++++++-------
 tools/testing/ktest/sample.conf |  8 ++++++++
 2 files changed, 33 insertions(+), 7 deletions(-)
---------------------------
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 09d1578f9d66..ac59999ed3de 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -802,7 +802,14 @@ sub process_variables {
 	my $end = $3;
 	# append beginning of value to retval
 	$retval = "$retval$begin";
-	if (defined($variable{$var})) {
+	if ($var =~ s/^shell\s+//) {
+	    $retval = `$var`;
+	    if ($?) {
+		doprint "WARNING: $var returned an error\n";
+	    } else {
+		chomp $retval;
+	    }
+	} elsif (defined($variable{$var})) {
 	    $retval = "$retval$variable{$var}";
 	} elsif (defined($remove_undef) && $remove_undef) {
 	    # for if statements, any variable that is not defined,
@@ -1963,7 +1970,7 @@ sub run_scp_mod {
 
 sub _get_grub_index {
 
-    my ($command, $target, $skip) = @_;
+    my ($command, $target, $skip, $submenu) = @_;
 
     return if (defined($grub_number) && defined($last_grub_menu) &&
 	$last_grub_menu eq $grub_menu && defined($last_machine) &&
@@ -1980,11 +1987,16 @@ sub _get_grub_index {
 
     my $found = 0;
 
+    my $submenu_number = 0;
+
     while (<IN>) {
 	if (/$target/) {
 	    $grub_number++;
 	    $found = 1;
 	    last;
+	} elsif (defined($submenu) && /$submenu/) {
+		$submenu_number++;
+		$grub_number = -1;
 	} elsif (/$skip/) {
 	    $grub_number++;
 	}
@@ -1993,6 +2005,9 @@ sub _get_grub_index {
 
     dodie "Could not find '$grub_menu' through $command on $machine"
 	if (!$found);
+    if ($submenu_number > 0) {
+	$grub_number = "$submenu_number>$grub_number";
+    }
     doprint "$grub_number\n";
     $last_grub_menu = $grub_menu;
     $last_machine = $machine;
@@ -2003,6 +2018,7 @@ sub get_grub_index {
     my $command;
     my $target;
     my $skip;
+    my $submenu;
     my $grub_menu_qt;
 
     if ($reboot_type !~ /^grub/) {
@@ -2017,8 +2033,9 @@ sub get_grub_index {
 	$skip = '^\s*title\s';
     } elsif ($reboot_type eq "grub2") {
 	$command = "cat $grub_file";
-	$target = '^menuentry.*' . $grub_menu_qt;
-	$skip = '^menuentry\s|^submenu\s';
+	$target = '^\s*menuentry.*' . $grub_menu_qt;
+	$skip = '^\s*menuentry';
+	$submenu = '^\s*submenu\s';
     } elsif ($reboot_type eq "grub2bls") {
 	$command = $grub_bls_get;
 	$target = '^title=.*' . $grub_menu_qt;
@@ -2027,7 +2044,7 @@ sub get_grub_index {
 	return;
     }
 
-    _get_grub_index($command, $target, $skip);
+    _get_grub_index($command, $target, $skip, $submenu);
 }
 
 sub wait_for_input {
@@ -2090,7 +2107,7 @@ sub reboot_to {
     if ($reboot_type eq "grub") {
 	run_ssh "'(echo \"savedefault --default=$grub_number --once\" | grub --batch)'";
     } elsif (($reboot_type eq "grub2") or ($reboot_type eq "grub2bls")) {
-	run_ssh "$grub_reboot $grub_number";
+	run_ssh "$grub_reboot \"'$grub_number'\"";
     } elsif ($reboot_type eq "syslinux") {
 	run_ssh "$syslinux --once \\\"$syslinux_label\\\" $syslinux_path";
     } elsif (defined $reboot_script) {
@@ -3768,9 +3785,10 @@ sub test_this_config {
     # .config to make sure it is missing the config that
     # we had before
     my %configs = %min_configs;
-    delete $configs{$config};
+    $configs{$config} = "# $config is not set";
     make_new_config ((values %configs), (values %keep_configs));
     make_oldconfig;
+    delete $configs{$config};
     undef %configs;
     assign_configs \%configs, $output_config;
 
diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index 5e7d1d729752..2d0fe15a096d 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -259,6 +259,14 @@
 # If PATH is not a config variable, then the ${PATH} in
 # the MAKE_CMD option will be evaluated by the shell when
 # the MAKE_CMD option is passed into shell processing.
+#
+# Shell commands can also be inserted with the ${shell <command>}
+# expression. Note, this is case sensitive, thus ${SHELL <command>}
+# will not work.
+#
+# HOSTNAME := ${shell hostname}
+# DEFAULTS IF "${HOSTNAME}" == "frodo"
+#
 
 #### Using options in other options ####
 #
