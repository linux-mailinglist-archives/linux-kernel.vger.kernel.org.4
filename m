Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB8965E14F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbjAEAK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbjAEAKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:10:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0D144346;
        Wed,  4 Jan 2023 16:10:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27BB9B81987;
        Thu,  5 Jan 2023 00:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC52C433A7;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672877397;
        bh=47ZqK3G8Z6W2//45p9y8TR73Xz/Q6+3lfGpPEhloL98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4mDAd3/mCvN4bb3U6zGCAmbCT35ci9yivTiyU4IWLZHR++V9x5vUF1TzMPwm04Hs
         LqLCOePs4eCqoysLoucwVPVjMps3iSG/Wg7YgFSV0i1VrD/xepa6gV+CGZ0jINaYbu
         ETkdlOUblaghCxvdrYK4J8av/M/QP8wR6tjAs0EFDKkM/ON/zOK1oJW8EZr3LYF3iQ
         H6yRIw8+kh7aqhO3yce+RohFzRYBAeBf0ucd5t8lvhrECU8BK/MTTB/wjpurfp34NO
         bFTO0s2OI2adf9ZcIDNA9n2NlDP2ARBJTFsAvU6LBebyTVxDGdhfC10+Hj1miJDKBr
         2im7TD7qFhRKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D135B5C1C5B; Wed,  4 Jan 2023 16:09:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/15] doc: Update torture.rst
Date:   Wed,  4 Jan 2023 16:09:48 -0800
Message-Id: <20230105000955.1767218-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
References: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
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

This commit updates torture.rst with wordsmithing and the addition of a
few more scripts.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/torture.rst | 89 +++++++++++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 4 deletions(-)

diff --git a/Documentation/RCU/torture.rst b/Documentation/RCU/torture.rst
index a901477130629..0316ba0c69225 100644
--- a/Documentation/RCU/torture.rst
+++ b/Documentation/RCU/torture.rst
@@ -206,7 +206,11 @@ values for memory may require disabling the callback-flooding tests
 using the --bootargs parameter discussed below.
 
 Sometimes additional debugging is useful, and in such cases the --kconfig
-parameter to kvm.sh may be used, for example, ``--kconfig 'CONFIG_KASAN=y'``.
+parameter to kvm.sh may be used, for example, ``--kconfig 'CONFIG_RCU_EQS_DEBUG=y'``.
+In addition, there are the --gdb, --kasan, and --kcsan parameters.
+Note that --gdb limits you to one scenario per kvm.sh run and requires
+that you have another window open from which to run ``gdb`` as instructed
+by the script.
 
 Kernel boot arguments can also be supplied, for example, to control
 rcutorture's module parameters.  For example, to test a change to RCU's
@@ -219,10 +223,17 @@ require disabling rcutorture's callback-flooding tests::
 		--bootargs 'rcutorture.fwd_progress=0'
 
 Sometimes all that is needed is a full set of kernel builds.  This is
-what the --buildonly argument does.
+what the --buildonly parameter does.
 
-Finally, the --trust-make argument allows each kernel build to reuse what
-it can from the previous kernel build.
+The --duration parameter can override the default run time of 30 minutes.
+For example, ``--duration 2d`` would run for two days, ``--duration 3h``
+would run for three hours, ``--duration 5m`` would run for five minutes,
+and ``--duration 45s`` would run for 45 seconds.  This last can be useful
+for tracking down rare boot-time failures.
+
+Finally, the --trust-make parameter allows each kernel build to reuse what
+it can from the previous kernel build.  Please note that without the
+--trust-make parameter, your tags files may be demolished.
 
 There are additional more arcane arguments that are documented in the
 source code of the kvm.sh script.
@@ -291,3 +302,73 @@ the following summary at the end of the run on a 12-CPU system::
     TREE07 ------- 167347 GPs (30.9902/s) [rcu: g1079021 f0x0 ] n_max_cbs: 478732
     CPU count limited from 16 to 12
     TREE09 ------- 752238 GPs (139.303/s) [rcu: g13075057 f0x0 ] n_max_cbs: 99011
+
+
+Repeated Runs
+=============
+
+Suppose that you are chasing down a rare boot-time failure.  Although you
+could use kvm.sh, doing so will rebuild the kernel on each run.  If you
+need (say) 1,000 runs to have confidence that you have fixed the bug,
+these pointless rebuilds can become extremely annoying.
+
+This is why kvm-again.sh exists.
+
+Suppose that a previous kvm.sh run left its output in this directory::
+
+	tools/testing/selftests/rcutorture/res/2022.11.03-11.26.28
+
+Then this run can be re-run without rebuilding as follow:
+
+	kvm-again.sh tools/testing/selftests/rcutorture/res/2022.11.03-11.26.28
+
+A few of the original run's kvm.sh parameters may be overridden, perhaps
+most notably --duration and --bootargs.  For example::
+
+	kvm-again.sh tools/testing/selftests/rcutorture/res/2022.11.03-11.26.28 \
+		--duration 45s
+
+would re-run the previous test, but for only 45 seconds, thus facilitating
+tracking down the aforementioned rare boot-time failure.
+
+
+Distributed Runs
+================
+
+Although kvm.sh is quite useful, its testing is confined to a single
+system.  It is not all that hard to use your favorite framework to cause
+(say) 5 instances of kvm.sh to run on your 5 systems, but this will very
+likely unnecessarily rebuild kernels.  In addition, manually distributing
+the desired rcutorture scenarios across the available systems can be
+painstaking and error-prone.
+
+And this is why the kvm-remote.sh script exists.
+
+If you the following command works::
+
+	ssh system0 date
+
+and if it also works for system1, system2, system3, system4, and system5,
+and all of these systems have 64 CPUs, you can type::
+
+	kvm-remote.sh "system0 system1 system2 system3 system4 system5" \
+		--cpus 64 --duration 8h --configs "5*CFLIST"
+
+This will build each default scenario's kernel on the local system, then
+spread each of five instances of each scenario over the systems listed,
+running each scenario for eight hours.  At the end of the runs, the
+results will be gathered, recorded, and printed.  Most of the parameters
+that kvm.sh will accept can be passed to kvm-remote.sh, but the list of
+systems must come first.
+
+The kvm.sh ``--dryrun scenarios`` argument is useful for working out
+how many scenarios may be run in one batch across a group of systems.
+
+You can also re-run a previous remote run in a manner similar to kvm.sh:
+
+	kvm-remote.sh "system0 system1 system2 system3 system4 system5" \
+		tools/testing/selftests/rcutorture/res/2022.11.03-11.26.28-remote \
+		--duration 24h
+
+In this case, most of the kvm-again.sh parmeters may be supplied following
+the pathname of the old run-results directory.
-- 
2.31.1.189.g2e36527f23

