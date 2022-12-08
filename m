Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151196466FB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLHCaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLHC3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:29:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2985B93A4F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 18:29:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D068AB821EB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A54C433C1;
        Thu,  8 Dec 2022 02:29:45 +0000 (UTC)
Date:   Wed, 7 Dec 2022 21:29:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John 'Warthog9' Hawley <warthog9@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] ktest.pl: Add shell commands to variables
Message-ID: <20221207212944.277ee850@gandalf.local.home>
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Allow variables to execute shell commands. Note, these are processed when
they are first seen while parsing the config file. This is useful if you
have the same config file used for multiple hosts (as they may be in a git
repository).

 HOSTNAME := ${shell hostname}
 DEFAULTS IF "${HOSTNAME}" == "frodo"

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl    | 9 ++++++++-
 tools/testing/ktest/sample.conf | 8 ++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 1737c59e4ff6..ac59999ed3de 100755
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
-- 
2.35.1

