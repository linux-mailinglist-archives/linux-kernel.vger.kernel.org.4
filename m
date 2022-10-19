Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E6B60539E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiJSXCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiJSXCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:02:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085941D639B;
        Wed, 19 Oct 2022 16:02:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82F58619D6;
        Wed, 19 Oct 2022 23:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D912C43145;
        Wed, 19 Oct 2022 23:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220528;
        bh=OglLR7CZcvCfPWNgseELmu/1oNbrB+8cqkekoCOt4F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ibrSr6c4FC2mMxQFw7N6h/dFgGz3kIq6/3mTpg7Vf2U7mshQzOk5GfSxP7hopjndL
         y249yAkSzrvC8zHrqhw7y2YOSk2GlKJvsbxZVqtj1zDKvutfdxEwcE2FQ4R8IXbHGr
         PqsbURueYbqkI31nZk1Z/G3zUWa+jMjQRsDQxUzPxSvz60KCa2qhBOk0NSjAr8GOIU
         REcMpHYka7opn9TPC+MPVWuWW6L5BwE+Jjx1wNrbg7BAA3bmntWCWr0FzPZjjg8ftR
         VQW2rLvZrcRS51aycaPJOngd/5pUM87e2KSlCCEyDX3ZyTbnWcg1wrL69XeeIgAF8M
         Sj4breg03QPLw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F24C15C0A40; Wed, 19 Oct 2022 16:02:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 rcu 6/8] rcutorture: Avoid redundant builds for rcuscale and refscale in torture.sh
Date:   Wed, 19 Oct 2022 16:02:04 -0700
Message-Id: <20221019230206.2501794-6-paulmck@kernel.org>
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

This commit causes torture.sh to use the new --bootargs and --datestamp
parameters to kvm-again.sh in order to avoid redundant kernel builds
during rcuscale and refscale testing.  This trims the better part of an
hour off of torture.sh runs that use --do-kasan.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/torture.sh       | 87 ++++++++++++++++++-
 1 file changed, 83 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 4d285db2fbbdd..b376688fe280a 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -277,6 +277,8 @@ function torture_one {
 	then
 		cat $T/$curflavor.out | tee -a $T/log
 		echo retcode=$retcode | tee -a $T/log
+	else
+		echo $resdir > $T/last-resdir
 	fi
 	if test "$retcode" == 0
 	then
@@ -302,10 +304,12 @@ function torture_set {
 	shift
 	curflavor=$flavor
 	torture_one "$@"
+	mv $T/last-resdir $T/last-resdir-nodebug || :
 	if test "$do_kasan" = "yes"
 	then
 		curflavor=${flavor}-kasan
 		torture_one "$@" --kasan
+		mv $T/last-resdir $T/last-resdir-kasan || :
 	fi
 	if test "$do_kcsan" = "yes"
 	then
@@ -316,6 +320,7 @@ function torture_set {
 			cur_kcsan_kmake_args="$kcsan_kmake_args"
 		fi
 		torture_one "$@" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" $kcsan_kmake_tag $cur_kcsan_kmake_args --kcsan
+		mv $T/last-resdir $T/last-resdir-kcsan || :
 	fi
 }
 
@@ -378,11 +383,48 @@ then
 else
 	primlist=
 fi
+firsttime=1
+do_kasan_save="$do_kasan"
+do_kcsan_save="$do_kcsan"
 for prim in $primlist
 do
-	torture_bootargs="refscale.scale_type="$prim" refscale.nreaders=$HALF_ALLOTED_CPUS refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot"
-	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_TASKS_TRACE_RCU=y CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --bootargs "verbose_batched=$VERBOSE_BATCH_CPUS torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=$VERBOSE_BATCH_CPUS" --trust-make
+	if test -n "$firsttime"
+	then
+		torture_bootargs="refscale.scale_type="$prim" refscale.nreaders=$HALF_ALLOTED_CPUS refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot"
+		torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_TASKS_TRACE_RCU=y CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --bootargs "verbose_batched=$VERBOSE_BATCH_CPUS torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=$VERBOSE_BATCH_CPUS" --trust-make
+		mv $T/last-resdir-nodebug $T/first-resdir-nodebug || :
+		if test -f "$T/last-resdir-kasan"
+		then
+			mv $T/last-resdir-kasan $T/first-resdir-kasan || :
+		fi
+		if test -f "$T/last-resdir-kcsan"
+		then
+			mv $T/last-resdir-kcsan $T/first-resdir-kcsan || :
+		fi
+		firsttime=
+		do_kasan=
+		do_kcsan=
+	else
+		torture_bootargs=
+		for i in $T/first-resdir-*
+		do
+			case "$i" in
+			*-nodebug)
+				torture_suffix=
+				;;
+			*-kasan)
+				torture_suffix="-kasan"
+				;;
+			*-kcsan)
+				torture_suffix="-kcsan"
+				;;
+			esac
+			torture_set "refscale-$prim$torture_suffix" tools/testing/selftests/rcutorture/bin/kvm-again.sh "`cat "$i"`" --duration 5 --bootargs "refscale.scale_type=$prim"
+		done
+	fi
 done
+do_kasan="$do_kasan_save"
+do_kcsan="$do_kcsan_save"
 
 if test "$do_rcuscale" = yes
 then
@@ -390,11 +432,48 @@ then
 else
 	primlist=
 fi
+firsttime=1
+do_kasan_save="$do_kasan"
+do_kcsan_save="$do_kcsan"
 for prim in $primlist
 do
-	torture_bootargs="rcuscale.scale_type="$prim" rcuscale.nwriters=$HALF_ALLOTED_CPUS rcuscale.holdoff=20 torture.disable_onoff_at_boot"
-	torture_set "rcuscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --kconfig "CONFIG_TASKS_TRACE_RCU=y CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
+	if test -n "$firsttime"
+	then
+		torture_bootargs="rcuscale.scale_type="$prim" rcuscale.nwriters=$HALF_ALLOTED_CPUS rcuscale.holdoff=20 torture.disable_onoff_at_boot"
+		torture_set "rcuscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --kconfig "CONFIG_TASKS_TRACE_RCU=y CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
+		mv $T/last-resdir-nodebug $T/first-resdir-nodebug || :
+		if test -f "$T/last-resdir-kasan"
+		then
+			mv $T/last-resdir-kasan $T/first-resdir-kasan || :
+		fi
+		if test -f "$T/last-resdir-kcsan"
+		then
+			mv $T/last-resdir-kcsan $T/first-resdir-kcsan || :
+		fi
+		firsttime=
+		do_kasan=
+		do_kcsan=
+	else
+		torture_bootargs=
+		for i in $T/first-resdir-*
+		do
+			case "$i" in
+			*-nodebug)
+				torture_suffix=
+				;;
+			*-kasan)
+				torture_suffix="-kasan"
+				;;
+			*-kcsan)
+				torture_suffix="-kcsan"
+				;;
+			esac
+			torture_set "rcuscale-$prim$torture_suffix" tools/testing/selftests/rcutorture/bin/kvm-again.sh "`cat "$i"`" --duration 5 --bootargs "rcuscale.scale_type=$prim"
+		done
+	fi
 done
+do_kasan="$do_kasan_save"
+do_kcsan="$do_kcsan_save"
 
 if test "$do_kvfree" = "yes"
 then
-- 
2.31.1.189.g2e36527f23

