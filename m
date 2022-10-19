Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E531A6053A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiJSXCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiJSXCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:02:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D12BC8E;
        Wed, 19 Oct 2022 16:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97FD4B82628;
        Wed, 19 Oct 2022 23:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C8EC433C1;
        Wed, 19 Oct 2022 23:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220528;
        bh=tHcc2B7c83D/AJeLWIhIM+jYPygjYHJqQ8I1kz/8AQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OsyMZgEUf4T635jHRA/9oARMtIje01NcafXIXP5AWDx3mtOSXoDx0k6nMAjABdP82
         NanHk9itMjd0BWB8bqYPMH6mN+Jn2KRWVYpbUh5r2GTLREmqd9zs+DUpfRirdL7uTn
         Z0Ox9C6sY0IUJCv0HCk0i9cfJyMFWFUk0A4KH8f0spwC7IVE6VlVm8cYSXC2tivO6f
         BkBpu4ISKA8V7b1lQ/ts6NFI31bI2FaDY53jVGL0HW+63851jGalIf86o6xmLy6Czm
         9lDagiWXIK6BvQi2Tx9Wy47NCYAkAqkUwEA+xcB7bb/o0eusxhUCX9o1ZsPPwOAgQz
         zN0M46UotIWiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E774B5C06B4; Wed, 19 Oct 2022 16:02:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 rcu 1/8] rcutorture: Add --bootargs parameter to kvm-again.sh
Date:   Wed, 19 Oct 2022 16:01:59 -0700
Message-Id: <20221019230206.2501794-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019230203.GA2501612@paulmck-ThinkPad-P17-Gen-1>
References: <20221019230203.GA2501612@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kvm-again.sh script can be used to repeat short boot-time tests,
but the kernel boot arguments cannot be changed.  This means that every
change in kernel boot arguments currently necessitates a kernel build,
which greatly increases the duration of kernel-boot testing.

This commit therefore adds a --bootargs parameter to kvm-again.sh,
which allows a given kernel to be repeatedly booted, but overriding
old and adding new kernel boot parameters.  This allows an old kernel
to be booted with new kernel boot parameters, avoiding the overhead of
rebuilding the kernel under test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-again.sh     |  9 ++-
 .../selftests/rcutorture/bin/kvm-transform.sh | 68 ++++++++++++++++---
 2 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index 0941f1ddab658..85cfd139f9737 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -51,6 +51,7 @@ RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
 PATH=${RCUTORTURE}/bin:$PATH; export PATH
 . functions.sh
 
+bootargs=
 dryrun=
 dur=
 default_link="cp -R"
@@ -61,6 +62,7 @@ starttime="`get_starttime`"
 
 usage () {
 	echo "Usage: $scriptname $oldrun [ arguments ]:"
+	echo "       --bootargs kernel-boot-arguments"
 	echo "       --dryrun"
 	echo "       --duration minutes | <seconds>s | <hours>h | <days>d"
 	echo "       --link hard|soft|copy"
@@ -72,6 +74,11 @@ usage () {
 while test $# -gt 0
 do
 	case "$1" in
+	--bootargs|--bootarg)
+		checkarg --bootargs "(list of kernel boot arguments)" "$#" "$2" '.*' '^--'
+		bootargs="$bootargs $2"
+		shift
+		;;
 	--dryrun)
 		dryrun=1
 		;;
@@ -156,7 +163,7 @@ do
 	qemu_cmd_dir="`dirname "$i"`"
 	kernel_dir="`echo $qemu_cmd_dir | sed -e 's/\.[0-9]\+$//'`"
 	jitter_dir="`dirname "$kernel_dir"`"
-	kvm-transform.sh "$kernel_dir/bzImage" "$qemu_cmd_dir/console.log" "$jitter_dir" $dur < $T/qemu-cmd > $i
+	kvm-transform.sh "$kernel_dir/bzImage" "$qemu_cmd_dir/console.log" "$jitter_dir" $dur "$bootargs" < $T/qemu-cmd > $i
 	if test -n "$arg_remote"
 	then
 		echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-transform.sh b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
index d40b4e60a50cb..75a2610a27f37 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
@@ -3,10 +3,14 @@
 #
 # Transform a qemu-cmd file to allow reuse.
 #
-# Usage: kvm-transform.sh bzImage console.log jitter_dir [ seconds ] < qemu-cmd-in > qemu-cmd-out
+# Usage: kvm-transform.sh bzImage console.log jitter_dir seconds [ bootargs ] < qemu-cmd-in > qemu-cmd-out
 #
 #	bzImage: Kernel and initrd from the same prior kvm.sh run.
 #	console.log: File into which to place console output.
+#	jitter_dir: Jitter directory for TORTURE_JITTER_START and
+#		TORTURE_JITTER_STOP environment variables.
+#	seconds: Run duaration for *.shutdown_secs module parameter.
+#	bootargs: New kernel boot parameters.  Beware of Robert Tables.
 #
 # The original qemu-cmd file is provided on standard input.
 # The transformed qemu-cmd file is on standard output.
@@ -17,6 +21,9 @@
 #
 # Authors: Paul E. McKenney <paulmck@kernel.org>
 
+T=`mktemp -d /tmp/kvm-transform.sh.XXXXXXXXXX`
+trap 'rm -rf $T' 0 2
+
 image="$1"
 if test -z "$image"
 then
@@ -41,9 +48,17 @@ then
 	echo "Invalid duration, should be numeric in seconds: '$seconds'"
 	exit 1
 fi
+bootargs="$5"
+
+# Build awk program.
+echo "BEGIN {" > $T/bootarg.awk
+echo $bootargs | tr -s ' ' '\012' |
+	awk -v dq='"' '/./ { print "\tbootarg[" NR "] = " dq $1 dq ";" }' >> $T/bootarg.awk
+echo $bootargs | tr -s ' ' '\012' | sed -e 's/=.*$//' |
+	awk -v dq='"' '/./ { print "\tbootpar[" NR "] = " dq $1 dq ";" }' >> $T/bootarg.awk
+cat >> $T/bootarg.awk << '___EOF___'
+}
 
-awk -v image="$image" -v consolelog="$consolelog" -v jitter_dir="$jitter_dir" \
-    -v seconds="$seconds" '
 /^# seconds=/ {
 	if (seconds == "")
 		print $0;
@@ -70,13 +85,7 @@ awk -v image="$image" -v consolelog="$consolelog" -v jitter_dir="$jitter_dir" \
 {
 	line = "";
 	for (i = 1; i <= NF; i++) {
-		if ("" seconds != "" && $i ~ /\.shutdown_secs=[0-9]*$/) {
-			sub(/[0-9]*$/, seconds, $i);
-			if (line == "")
-				line = $i;
-			else
-				line = line " " $i;
-		} else if (line == "") {
+		if (line == "") {
 			line = $i;
 		} else {
 			line = line " " $i;
@@ -87,7 +96,44 @@ awk -v image="$image" -v consolelog="$consolelog" -v jitter_dir="$jitter_dir" \
 		} else if ($i == "-kernel") {
 			i++;
 			line = line " " image;
+		} else if ($i == "-append") {
+			for (i++; i <= NF; i++) {
+				arg = $i;
+				lq = "";
+				rq = "";
+				if ("" seconds != "" && $i ~ /\.shutdown_secs=[0-9]*$/)
+					sub(/[0-9]*$/, seconds, arg);
+				if (arg ~ /^"/) {
+					lq = substr(arg, 1, 1);
+					arg  = substr(arg, 2);
+				}
+				if (arg ~ /"$/) {
+					rq = substr(arg, length($i), 1);
+					arg = substr(arg, 1, length($i) - 1);
+				}
+				par = arg;
+				gsub(/=.*$/, "", par);
+				j = 1;
+				while (bootpar[j] != "") {
+					if (bootpar[j] == par) {
+						arg = "";
+						break;
+					}
+					j++;
+				}
+				if (line == "")
+					line = lq arg;
+				else
+					line = line " " lq arg;
+			}
+			for (j in bootarg)
+				line = line " " bootarg[j];
+			line = line rq;
 		}
 	}
 	print line;
-}'
+}
+___EOF___
+
+awk -v image="$image" -v consolelog="$consolelog" -v jitter_dir="$jitter_dir" \
+    -v seconds="$seconds" -f $T/bootarg.awk
-- 
2.31.1.189.g2e36527f23

