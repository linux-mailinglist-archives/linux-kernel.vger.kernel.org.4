Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD37E652A77
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiLUA30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLUA3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:29:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1EF19282;
        Tue, 20 Dec 2022 16:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ymsMt69UtWxrWU2zbfGlODAg4r7tVA3s2+bb2qRJp6Y=; b=qlNLwU0Y69wH4Ej4tIuftcS1c4
        tegjkPNGTS5ebGZYg/lNvQOAbkGP9jD+yptaFYK/t3sX/Z2BVOdxQj8aEXK/TfeZsvtL5Nozut2LO
        tqEiJzisYpZ0at6tpLV1c3+9X+bvRyGNO9kOFLZPKrtEfWCYlTcP2krZ8Z8xjAxis4+fY9lfLaMFf
        TdIenL21GwCfkfgjVzgvbThnXJAsA/LdmFTTkzMH9fN4WbmfgwFnKg5xGxh20/2ftb0lR1if56+Jj
        /OogEYxb9aviao3tvPx9bFGY1nWFYovs+N+LK/tGrQOn+Z09DDPDzRr3Cwe9MBikx5i+MFhR7pR6O
        MbPIuAdw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7mz4-006PW9-P1; Wed, 21 Dec 2022 00:29:22 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] fstests: update patien module remover usage
Date:   Tue, 20 Dec 2022 16:29:22 -0800
Message-Id: <20221221002922.1528013-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmod now has support for the patient module remover but
it uses --wait instead of -p, and it does not have an option
to wait forever. So let's just deprecate the "forever" option,
and use update our code to use --wait.

Since blktests is also getting support, and since they actually
use 'make check' with consistent shellcheck checks, embrace the
implementation there so we at least match solutions. That way if
there are bugs in one we can fix them in the other project as well.
The style changes are minor.

A few functional changes brought forward from the solution embraced
by blktests

  * sanity check for the modules sysfs directory to replace "-" with
    "_" and document why we do that
  * do not run if the module does not exist or is not loaded, that's
    the addition of:
    [ ! -e "/sys/module/$module_sys" ] && return 0

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

Although the blktests patch is not yet merged its on its v3 now.
I *have not tested* this patch yet on fstests... once I do I'll
poke back here.

 README        |  3 +--
 common/config | 31 +++++++++++++++++++------------
 common/module | 28 ++++++++++++----------------
 3 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/README b/README
index 4c4f22f853de..b2d4744593f3 100644
--- a/README
+++ b/README
@@ -222,8 +222,7 @@ Kernel/Modules related configuration:
    test invocations. This assumes that the name of the module is the same
    as FSTYP.
  - Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to specify the amount of time we
-   should try a patient module remove. The default is 50 seconds. Set this
-   to "forever" and we'll wait forever until the module is gone.
+   should try a patient module remove. The default is 50 seconds.
  - Set KCONFIG_PATH to specify your preferred location of kernel config
    file. The config is used by tests to check if kernel feature is enabled.
 
diff --git a/common/config b/common/config
index b2802e5e0af1..8bc6b3d2ae3f 100644
--- a/common/config
+++ b/common/config
@@ -256,11 +256,15 @@ if [[ "$UDEV_SETTLE_PROG" == "" || ! -d /proc/net ]]; then
 fi
 export UDEV_SETTLE_PROG
 
-# Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to "forever" if you want the patient
-# modprobe removal to run forever trying to remove a module.
+_has_modprobe_patient()
+{
+	modprobe --help >& /dev/null || return 1
+	modprobe --help | grep -q "\-\-wait" || return 1
+	return 0
+}
+
 MODPROBE_REMOVE_PATIENT=""
-modprobe --help >& /dev/null && modprobe --help | grep -q -1 "remove-patiently"
-if [[ $? -ne 0 ]]; then
+if ! _has_modprobe_patient; then
 	if [[ -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
 		# We will open code our own implementation of patient module
 		# remover in fstests. Use a 50 second default.
@@ -268,22 +272,25 @@ if [[ $? -ne 0 ]]; then
 	fi
 else
 	MODPROBE_RM_PATIENT_TIMEOUT_ARGS=""
-	if [[ ! -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
-		if [[ "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" != "forever" ]]; then
-			MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
-			MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-t $MODPROBE_PATIENT_RM_TIMEOUT_MS"
+	if [[ -n "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
+		MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
+		MODPROBE_RM_PATIENT_TIMEOUT_ARGS="--wait $MODPROBE_PATIENT_RM_TIMEOUT_MS"
+		if [[ "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" == "forever" ]];
+			echo "Warning: deprecated MODPROBE_PATIENT_RM_TIMEOUT_SECONDS forever setting"
+			echo "Just set this to a high value if you want this to linger for a long time"
+			exit 1
 		fi
 	else
 		# We export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS here for parity
-		# with environments without support for modprobe -p, but we
+		# with environments without support for modprobe --wait, but we
 		# only really need it exported right now for environments which
-		# don't have support for modprobe -p to implement our own
+		# don't have support for modprobe --wait to implement our own
 		# patient module removal support within fstests.
 		export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS="50"
 		MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
-		MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-t $MODPROBE_PATIENT_RM_TIMEOUT_MS"
+		MODPROBE_RM_PATIENT_TIMEOUT_ARGS="--wait $MODPROBE_PATIENT_RM_TIMEOUT_MS"
 	fi
-	MODPROBE_REMOVE_PATIENT="modprobe -p $MODPROBE_RM_PATIENT_TIMEOUT_ARGS"
+	MODPROBE_REMOVE_PATIENT="modprobe -r $MODPROBE_RM_PATIENT_TIMEOUT_ARGS"
 fi
 export MODPROBE_REMOVE_PATIENT
 
diff --git a/common/module b/common/module
index 6efab71d348e..bd205dafeaff 100644
--- a/common/module
+++ b/common/module
@@ -107,9 +107,9 @@ _patient_rmmod_check_refcnt()
 # MODPROBE_PATIENT_RM_TIMEOUT_SECONDS prior to including this file.
 # If you want this to try forever just set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS
 # to the special value of "forever". This applies to both cases where kmod
-# supports the patient module remover (modrobe -p) and where it does not.
+# supports the patient module remover (modrobe --wait) and where it does not.
 #
-# If your version of kmod supports modprobe -p, we instead use that
+# If your version of kmod supports modprobe --wait, we instead use that
 # instead. Otherwise we have to implement a patient module remover
 # ourselves.
 _patient_rmmod()
@@ -119,6 +119,12 @@ _patient_rmmod()
 	local max_tries=0
 	local mod_ret=0
 	local refcnt_is_zero=0
+	# Since we are looking for a directory we must adopt the
+	# specific directory used by scripts/Makefile.lib for
+	# KBUILD_MODNAME
+	local module_sys=${module//-/_}
+
+	[ ! -e "/sys/module/$module_sys" ] && return 0
 
 	if [[ ! -z $MODPROBE_REMOVE_PATIENT ]]; then
 		$MODPROBE_REMOVE_PATIENT $module
@@ -131,20 +137,13 @@ _patient_rmmod()
 
 	max_tries=$max_tries_max
 
-	# We must use a string check as otherwise if max_tries is set to
-	# "forever" and we don't use a string check we can end up skipping
-	# entering this loop.
 	while [[ "$max_tries" != "0" ]]; do
-		_patient_rmmod_check_refcnt $module
-		if [[ $? -eq 0 ]]; then
+		if _patient_rmmod_check_refcnt "$module_sys"; then
 			refcnt_is_zero=1
 			break
 		fi
 		sleep 1
-		if [[ "$max_tries" == "forever" ]]; then
-			continue
-		fi
-		let max_tries=$max_tries-1
+		((max_tries--))
 	done
 
 	if [[ $refcnt_is_zero -ne 1 ]]; then
@@ -169,17 +168,14 @@ _patient_rmmod()
 	# https://bugzilla.kernel.org/show_bug.cgi?id=212337
 	# https://bugzilla.kernel.org/show_bug.cgi?id=214015
 	while [[ $max_tries != 0 ]]; do
-		if [[ -d /sys/module/$module ]]; then
+		if [[ -d /sys/module/$module_sys ]]; then
 			modprobe -r $module 2> /dev/null
 			mod_ret=$?
 			if [[ $mod_ret == 0 ]]; then
 				break;
 			fi
 			sleep 1
-			if [[ "$max_tries" == "forever" ]]; then
-				continue
-			fi
-			let max_tries=$max_tries-1
+			((max_tries--))
 		else
 			break
 		fi
-- 
2.35.1

