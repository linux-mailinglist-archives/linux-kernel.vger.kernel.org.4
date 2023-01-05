Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0124A65E207
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjAEAwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjAEAwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:52:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C602544D7;
        Wed,  4 Jan 2023 16:46:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 116B4B81987;
        Thu,  5 Jan 2023 00:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA748C433D2;
        Thu,  5 Jan 2023 00:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879615;
        bh=3UPywjyx+hFeHfTFTJ1upnL/RWI5roHPf7TTcpaOv40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xx4Q6CS1NayI1b4RmF8TLMTZ877uiGQ05+cYarvCaNdNKzMCfpSfF0dtlUSrBFRdt
         2hLTzXL1s38JQORTmA072IPu61wlu/gqOiuyouJvXNcPI3TIAV5NnQKXzcKxcz7yP6
         tGQZiZ2dSfQDfkOxfUMWi/arcGfFUbaS4Lt6R33t+uk12cfW4fDbQmIQAa0cjs/455
         9Q3dVGQ/9YyqBft6BxJ97uK2JaNzRboG1+alThdVh1h+smZukDkZQ9Ecj/oSPXRT2/
         U6yR5yKJa7GMuNRGW/H1gdu052AyZvlVPF840BUIcMDdCeXo2Xu5mg+whY6F+Rz67S
         BxvMtalMGemnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5E7E65C086D; Wed,  4 Jan 2023 16:46:55 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/4] selftests: rcutorture: Use "grep -E" instead of "egrep"
Date:   Wed,  4 Jan 2023 16:46:50 -0800
Message-Id: <20230105004652.1771676-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105004646.GA1771551@paulmck-ThinkPad-P17-Gen-1>
References: <20230105004646.GA1771551@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

The latest version of grep is deprecating the egrep command, so that
its output contains warnings as follows:

	egrep: warning: egrep is obsolescent; using grep -E

Fix this using "grep -E" instead.

  sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/testing/selftests/rcutorture`

Here are the steps to install the latest grep:

  wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
  tar xf grep-3.8.tar.gz
  cd grep-3.8 && ./configure && make
  sudo make install
  export PATH=/usr/local/bin:$PATH

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/console-badness.sh        |  2 +-
 tools/testing/selftests/rcutorture/bin/kvm-build.sh    |  4 ++--
 .../selftests/rcutorture/bin/kvm-find-errors.sh        |  4 ++--
 tools/testing/selftests/rcutorture/bin/kvm.sh          |  4 ++--
 .../testing/selftests/rcutorture/bin/parse-console.sh  | 10 +++++-----
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh b/tools/testing/selftests/rcutorture/bin/console-badness.sh
index 69f8a5958cefc..aad51e7c0183d 100755
--- a/tools/testing/selftests/rcutorture/bin/console-badness.sh
+++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
@@ -10,7 +10,7 @@
 #
 # Authors: Paul E. McKenney <paulmck@kernel.org>
 
-egrep 'Badness|WARNING:|Warn|BUG|===========|BUG: KCSAN:|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
+grep -E 'Badness|WARNING:|Warn|BUG|===========|BUG: KCSAN:|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
 grep -v 'ODEBUG: ' |
 grep -v 'This means that this is a DEBUG kernel and it is' |
 grep -v 'Warning: unable to open an initial console' |
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index e28a82851f7c4..11f8d232b0ee7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -44,10 +44,10 @@ fi
 ncpus="`getconf _NPROCESSORS_ONLN`"
 make -j$((2 * ncpus)) $TORTURE_KMAKE_ARG > $resdir/Make.out 2>&1
 retval=$?
-if test $retval -ne 0 || grep "rcu[^/]*": < $resdir/Make.out | egrep -q "Stop|Error|error:|warning:" || egrep -q "Stop|Error|error:" < $resdir/Make.out
+if test $retval -ne 0 || grep "rcu[^/]*": < $resdir/Make.out | grep -E -q "Stop|Error|error:|warning:" || grep -E -q "Stop|Error|error:" < $resdir/Make.out
 then
 	echo Kernel build error
-	egrep "Stop|Error|error:|warning:" < $resdir/Make.out
+	grep -E "Stop|Error|error:|warning:" < $resdir/Make.out
 	echo Run aborted.
 	exit 3
 fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
index d4dc059843a43..28981007465bd 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -32,9 +32,9 @@ for i in ${rundir}/*/Make.out
 do
 	scenariodir="`dirname $i`"
 	scenariobasedir="`echo ${scenariodir} | sed -e 's/\.[0-9]*$//'`"
-	if egrep -q "error:|warning:|^ld: .*undefined reference to" < $i
+	if grep -E -q "error:|warning:|^ld: .*undefined reference to" < $i
 	then
-		egrep "error:|warning:|^ld: .*undefined reference to" < $i > $i.diags
+		grep -E "error:|warning:|^ld: .*undefined reference to" < $i > $i.diags
 		files="$files $i.diags $i"
 	elif ! test -f ${scenariobasedir}/vmlinux && ! test -f ${scenariobasedir}/vmlinux.xz && ! test -f "${rundir}/re-run"
 	then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 7710b1e1cddab..3025a949bc99e 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -585,7 +585,7 @@ awk < $T/cfgcpu.pack \
 echo kvm-end-run-stats.sh "$resdir/$ds" "$starttime" >> $T/script
 
 # Extract the tests and their batches from the script.
-egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
+grep -E 'Start batch|Starting build\.' $T/script | grep -v ">>" |
 	sed -e 's/:.*$//' -e 's/^echo //' -e 's/-ovf//' |
 	awk '
 	/^----Start/ {
@@ -622,7 +622,7 @@ then
 elif test "$dryrun" = sched
 then
 	# Extract the test run schedule from the script.
-	egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
+	grep -E 'Start batch|Starting build\.' $T/script | grep -v ">>" |
 		sed -e 's/:.*$//' -e 's/^echo //'
 	nbuilds="`grep 'Starting build\.' $T/script |
 		  grep -v ">>" | sed -e 's/:.*$//' -e 's/^echo //' |
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 822eb037a0573..9ab0f6bc172cd 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -65,7 +65,7 @@ then
 	fi
 
 	grep --binary-files=text 'torture:.*ver:' $file |
-	egrep --binary-files=text -v '\(null\)|rtc: 000000000* ' |
+	grep -E --binary-files=text -v '\(null\)|rtc: 000000000* ' |
 	sed -e 's/^(initramfs)[^]]*] //' -e 's/^\[[^]]*] //' |
 	sed -e 's/^.*ver: //' |
 	awk '
@@ -128,17 +128,17 @@ then
 	then
 		summary="$summary  Badness: $n_badness"
 	fi
-	n_warn=`grep -v 'Warning: unable to open an initial console' $file | grep -v 'Warning: Failed to add ttynull console. No stdin, stdout, and stderr for the init process' | egrep -c 'WARNING:|Warn'`
+	n_warn=`grep -v 'Warning: unable to open an initial console' $file | grep -v 'Warning: Failed to add ttynull console. No stdin, stdout, and stderr for the init process' | grep -E -c 'WARNING:|Warn'`
 	if test "$n_warn" -ne 0
 	then
 		summary="$summary  Warnings: $n_warn"
 	fi
-	n_bugs=`egrep -c '\bBUG|Oops:' $file`
+	n_bugs=`grep -E -c '\bBUG|Oops:' $file`
 	if test "$n_bugs" -ne 0
 	then
 		summary="$summary  Bugs: $n_bugs"
 	fi
-	n_kcsan=`egrep -c 'BUG: KCSAN: ' $file`
+	n_kcsan=`grep -E -c 'BUG: KCSAN: ' $file`
 	if test "$n_kcsan" -ne 0
 	then
 		if test "$n_bugs" = "$n_kcsan"
@@ -158,7 +158,7 @@ then
 	then
 		summary="$summary  lockdep: $n_badness"
 	fi
-	n_stalls=`egrep -c 'detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state' $file`
+	n_stalls=`grep -E -c 'detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state' $file`
 	if test "$n_stalls" -ne 0
 	then
 		summary="$summary  Stalls: $n_stalls"
-- 
2.31.1.189.g2e36527f23

