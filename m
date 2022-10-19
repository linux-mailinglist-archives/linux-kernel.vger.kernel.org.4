Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17196053A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiJSXDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiJSXCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:02:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C2D1D73C3;
        Wed, 19 Oct 2022 16:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FCF4B82626;
        Wed, 19 Oct 2022 23:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E229C433B5;
        Wed, 19 Oct 2022 23:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220528;
        bh=5BTxcY5LF9MfXVRtivOD2ef6M9lAyzmoojWa+ipYWug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3gNP2JF210YeXGJB1VLv91V59d2xGDTeuIlzG3m9+SypLAYbn4SJ1SuVxzmc9ocJ
         3lfJzCN/7rNlFKj/dhq9UwNy9JonsQcfMJwfkIC4XrmZSiJvduE5El0h88yeGTff4g
         tdADZ+UZs2KeV2vQMA3lG4CzmGrQLFx/vZUnB87CYkOt9rHV+Gvd5Ad3HrRCo/RK4a
         myJPg4s2XbUBgnLe+hc0aRIXrTrNBiW8K6hly+sI+YRlEzbU07FFN4VpdrFOL2rUqf
         1YF5C81T6fxYw/YYZSlMUe9Jwyg3nikWVW5+4WKPoM2ETElRkJc9r4KBMKTtIx7Nio
         BNYVf+C6GgpCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EA0FB5C0879; Wed, 19 Oct 2022 16:02:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 rcu 2/8] torture: Use mktemp instead of guessing at unique names
Date:   Wed, 19 Oct 2022 16:02:00 -0700
Message-Id: <20221019230206.2501794-2-paulmck@kernel.org>
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

This commit drags the rcutorture scripting kicking and screaming into the
twenty-first century by making use of the BSD-derived mktemp command to
create temporary files and directories.  In happy contrast to many of its
ill-behaved predecessors, mktemp seems to actually work reasonably reliably!

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/bin/config2csv.sh  |  3 +--
 .../selftests/rcutorture/bin/config_override.sh     |  3 +--
 .../testing/selftests/rcutorture/bin/configcheck.sh |  3 +--
 .../testing/selftests/rcutorture/bin/configinit.sh  |  3 +--
 tools/testing/selftests/rcutorture/bin/kvm-again.sh |  3 +--
 .../selftests/rcutorture/bin/kvm-assign-cpus.sh     |  3 +--
 tools/testing/selftests/rcutorture/bin/kvm-build.sh |  3 +--
 .../selftests/rcutorture/bin/kvm-end-run-stats.sh   |  3 +--
 .../testing/selftests/rcutorture/bin/kvm-remote.sh  | 13 ++++++-------
 .../rcutorture/bin/kvm-test-1-run-batch.sh          |  3 +--
 .../selftests/rcutorture/bin/kvm-test-1-run-qemu.sh |  3 +--
 .../selftests/rcutorture/bin/kvm-test-1-run.sh      |  3 +--
 tools/testing/selftests/rcutorture/bin/kvm.sh       |  3 +--
 .../testing/selftests/rcutorture/bin/parse-build.sh |  3 +--
 tools/testing/selftests/rcutorture/bin/torture.sh   |  3 +--
 15 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/config2csv.sh b/tools/testing/selftests/rcutorture/bin/config2csv.sh
index d5a16631b16ee..0cf55f1bf6548 100755
--- a/tools/testing/selftests/rcutorture/bin/config2csv.sh
+++ b/tools/testing/selftests/rcutorture/bin/config2csv.sh
@@ -30,9 +30,8 @@ else
 fi
 scenarios="`echo $scenariosarg | sed -e "s/\<CFLIST\>/$defaultconfigs/g"`"
 
-T=/tmp/config2latex.sh.$$
+T=`mktemp -d /tmp/config2latex.sh.XXXXXX`
 trap 'rm -rf $T' 0
-mkdir $T
 
 cat << '---EOF---' >> $T/p.awk
 END	{
diff --git a/tools/testing/selftests/rcutorture/bin/config_override.sh b/tools/testing/selftests/rcutorture/bin/config_override.sh
index 90016c359e839..b3d2e7efa40cd 100755
--- a/tools/testing/selftests/rcutorture/bin/config_override.sh
+++ b/tools/testing/selftests/rcutorture/bin/config_override.sh
@@ -29,9 +29,8 @@ else
 	exit 1
 fi
 
-T=${TMPDIR-/tmp}/config_override.sh.$$
+T="`mktemp -d ${TMPDIR-/tmp}/config_override.sh.XXXXXX`"
 trap 'rm -rf $T' 0
-mkdir $T
 
 sed < $override -e 's/^/grep -v "/' -e 's/=.*$/="/' |
 	awk '
diff --git a/tools/testing/selftests/rcutorture/bin/configcheck.sh b/tools/testing/selftests/rcutorture/bin/configcheck.sh
index 31584cee84d71..83fac1852ab23 100755
--- a/tools/testing/selftests/rcutorture/bin/configcheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/configcheck.sh
@@ -7,9 +7,8 @@
 #
 # Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
-T=${TMPDIR-/tmp}/abat-chk-config.sh.$$
+T="`mktemp -d ${TMPDIR-/tmp}/configcheck.sh.XXXXXX`"
 trap 'rm -rf $T' 0
-mkdir $T
 
 cat $1 > $T/.config
 
diff --git a/tools/testing/selftests/rcutorture/bin/configinit.sh b/tools/testing/selftests/rcutorture/bin/configinit.sh
index d6e5ce084b1cf..28bdb3ac7ba6f 100755
--- a/tools/testing/selftests/rcutorture/bin/configinit.sh
+++ b/tools/testing/selftests/rcutorture/bin/configinit.sh
@@ -15,9 +15,8 @@
 #
 # Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
-T=${TMPDIR-/tmp}/configinit.sh.$$
+T="`mktemp -d ${TMPDIR-/tmp}/configinit.sh.XXXXXX`"
 trap 'rm -rf $T' 0
-mkdir $T
 
 # Capture config spec file.
 
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index 85cfd139f9737..20941c1051087 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -12,9 +12,8 @@
 scriptname=$0
 args="$*"
 
-T=${TMPDIR-/tmp}/kvm-again.sh.$$
+T="`mktemp -d ${TMPDIR-/tmp}/kvm-again.sh.XXXXXX`"
 trap 'rm -rf $T' 0
-mkdir $T
 
 if ! test -d tools/testing/selftests/rcutorture/bin
 then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-assign-cpus.sh b/tools/testing/selftests/rcutorture/bin/kvm-assign-cpus.sh
index f99b2c146f835..46b08cd16ba5c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-assign-cpus.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-assign-cpus.sh
@@ -7,9 +7,8 @@
 #
 # Usage: kvm-assign-cpus.sh /path/to/sysfs
 
-T=/tmp/kvm-assign-cpus.sh.$$
+T="`mktemp -d ${TMPDIR-/tmp}/kvm-assign-cpus.sh.XXXXXX`"
 trap 'rm -rf $T' 0 2
-mkdir $T
 
 sysfsdir=${1-/sys/devices/system/node}
 if ! cd "$sysfsdir" > $T/msg 2>&1
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index 5ad973dca8207..e28a82851f7c4 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -23,9 +23,8 @@ then
 fi
 resdir=${2}
 
-T=${TMPDIR-/tmp}/test-linux.sh.$$
+T="`mktemp -d ${TMPDIR-/tmp}/kvm-build.sh.XXXXXX`"
 trap 'rm -rf $T' 0
-mkdir $T
 
 cp ${config_template} $T/config
 cat << ___EOF___ >> $T/config
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
index ee886b40a5d2c..2b56baceb05d7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh
@@ -18,9 +18,8 @@ then
 	exit 1
 fi
 
-T=${TMPDIR-/tmp}/kvm-end-run-stats.sh.$$
+T="`mktemp -d ${TMPDIR-/tmp}/kvm-end-run-stats.sh.XXXXXX`"
 trap 'rm -rf $T' 0
-mkdir $T
 
 RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
 PATH=${RCUTORTURE}/bin:$PATH; export PATH
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 9f0a5d5ff2ddc..a2328163eba1d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -34,19 +34,18 @@ fi
 shift
 
 # Pathnames:
-# T:	  /tmp/kvm-remote.sh.$$
-# resdir: /tmp/kvm-remote.sh.$$/res
-# rundir: /tmp/kvm-remote.sh.$$/res/$ds ("-remote" suffix)
+# T:	  /tmp/kvm-remote.sh.NNNNNN where "NNNNNN" is set by mktemp
+# resdir: /tmp/kvm-remote.sh.NNNNNN/res
+# rundir: /tmp/kvm-remote.sh.NNNNNN/res/$ds ("-remote" suffix)
 # oldrun: `pwd`/tools/testing/.../res/$otherds
 #
 # Pathname segments:
-# TD:	  kvm-remote.sh.$$
+# TD:	  kvm-remote.sh.NNNNNN
 # ds:	  yyyy.mm.dd-hh.mm.ss-remote
 
-TD=kvm-remote.sh.$$
-T=${TMPDIR-/tmp}/$TD
+T="`mktemp -d ${TMPDIR-/tmp}/kvm-remote.sh.XXXXXX`"
 trap 'rm -rf $T' 0
-mkdir $T
+TD="`basename "$T"`"
 
 resdir="$T/res"
 ds=`date +%Y.%m.%d-%H.%M.%S`-remote
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
index 1e29d656501bc..c3808c490d92d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
@@ -13,9 +13,8 @@
 #
 # Authors: Paul E. McKenney <paulmck@kernel.org>
 
-T=${TMPDIR-/tmp}/kvm-test-1-run-batch.sh.$$
+T="`mktemp -d ${TMPDIR-/tmp}/kvm-test-1-run-batch.sh.XXXXXX`"
 trap 'rm -rf $T' 0
-mkdir $T
 
 echo ---- Running batch $*
 # Check arguments
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
index 44280582c594e..9da86e6cd1812 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
@@ -17,9 +17,8 @@
 #
 # Authors: Paul E. McKenney <paulmck@kernel.org>
 
-T=${TMPDIR-/tmp}/kvm-test-1-run-qemu.sh.$$
+T="`mktemp -d ${TMPDIR-/tmp}/kvm-test-1-run-qemu.sh.XXXXXX`"
 trap 'rm -rf $T' 0
-mkdir $T
 
 resdir="$1"
 if ! test -d "$resdir"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index f4c8055dbf7ad..d2a3710a5f2ad 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -25,9 +25,8 @@
 #
 # Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
-T=${TMPDIR-/tmp}/kvm-test-1-run.sh.$$
+T="`mktemp -d ${TMPDIR-/tmp}/kvm-test-1-run.sh.XXXXXX`"
 trap 'rm -rf $T' 0
-mkdir $T
 
 . functions.sh
 . $CONFIGFRAG/ver_functions.sh
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6c734818a8757..7710b1e1cddab 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -14,9 +14,8 @@
 scriptname=$0
 args="$*"
 
-T=${TMPDIR-/tmp}/kvm.sh.$$
+T="`mktemp -d ${TMPDIR-/tmp}/kvm.sh.XXXXXX`"
 trap 'rm -rf $T' 0
-mkdir $T
 
 cd `dirname $scriptname`/../../../../../
 
diff --git a/tools/testing/selftests/rcutorture/bin/parse-build.sh b/tools/testing/selftests/rcutorture/bin/parse-build.sh
index 2dbfca3589b17..5a0b7ffcf047a 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-build.sh
@@ -15,9 +15,8 @@
 
 F=$1
 title=$2
-T=${TMPDIR-/tmp}/parse-build.sh.$$
+T="`mktemp -d ${TMPDIR-/tmp}/parse-build.sh.XXXXXX`"
 trap 'rm -rf $T' 0
-mkdir $T
 
 . functions.sh
 
diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index d477618e7261d..4d285db2fbbdd 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -206,9 +206,8 @@ ds="`date +%Y.%m.%d-%H.%M.%S`-torture"
 startdate="`date`"
 starttime="`get_starttime`"
 
-T=/tmp/torture.sh.$$
+T="`mktemp -d ${TMPDIR-/tmp}/torture.sh.XXXXXX`"
 trap 'rm -rf $T' 0 2
-mkdir $T
 
 echo " --- " $scriptname $args | tee -a $T/log
 echo " --- Results directory: " $ds | tee -a $T/log
-- 
2.31.1.189.g2e36527f23

