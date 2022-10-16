Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21325FFF34
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 14:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiJPMbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 08:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJPMb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 08:31:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDB031DC2;
        Sun, 16 Oct 2022 05:31:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0CAA20479;
        Sun, 16 Oct 2022 12:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665923480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYqXE6gTN7KoVw9OC/xhUSUlvDrYiQN8v/Jf2xRpmok=;
        b=sgmUHdwlGUrFxU0If1TzdLxN4u/ZkMibWP6aaObTaGTAYogCLf0WWg90MyQrOfomrSCf+Y
        upV0alFTcOAu52NJ4MzMlvra4MSTijbMOT/8MYaC/LLfhIyrj16raLLGVBmRTNST3oUJVM
        BJ6oWRKJZQeGtBYu7B0Re7Zdy1VAF3Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A884513A36;
        Sun, 16 Oct 2022 12:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YC8+KJj5S2MyMAAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Sun, 16 Oct 2022 12:31:20 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     mcgrof@kernel.org
Cc:     pmladek@suse.com, david@redhat.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v3 4/4] selftests: kmod: Add tests for merging same-name module load requests
Date:   Sun, 16 Oct 2022 14:30:31 +0200
Message-Id: <20221016123031.3963-5-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221016123031.3963-1-petr.pavlu@suse.com>
References: <20221016123031.3963-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two tests to check that loading the same module multiple times in
parallel results only in one real attempt to initialize it.
Synchronization of the loads is done by waiting 1000 ms in the init
function of a sample module kmod_test_0014. The tests measure time
needed to perform all inserts to verify that the loads get merged by the
module loader and are not serialized.

* Case 0014 checks a situation when the load is successful. It should
  result in one insert returning 0 and remaining inserts returning
  EEXIST.
* Case 0015 checks a situation when the load is failing because the
  module init function returns ENODEV. It should result in one insert
  returning this error code and remaining inserts returning EBUSY.

The tests use a simple init_module program to load kmod_test_0014.ko. It
enables to obtain directly a return code from the finit_module syscall.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 tools/testing/selftests/kmod/.gitignore       |   1 +
 tools/testing/selftests/kmod/Makefile         |  17 ++-
 tools/testing/selftests/kmod/init_module.c    |  49 ++++++
 tools/testing/selftests/kmod/kmod.sh          | 139 ++++++++++++++++++
 .../selftests/kmod/kmod_test_0014/Makefile    |  14 ++
 .../kmod/kmod_test_0014/kmod_test_0014.c      |  29 ++++
 6 files changed, 244 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/kmod/.gitignore
 create mode 100644 tools/testing/selftests/kmod/init_module.c
 create mode 100644 tools/testing/selftests/kmod/kmod_test_0014/Makefile
 create mode 100644 tools/testing/selftests/kmod/kmod_test_0014/kmod_test_0014.c

diff --git a/tools/testing/selftests/kmod/.gitignore b/tools/testing/selftests/kmod/.gitignore
new file mode 100644
index 000000000000..ea3afcaccc79
--- /dev/null
+++ b/tools/testing/selftests/kmod/.gitignore
@@ -0,0 +1 @@
+init_module
diff --git a/tools/testing/selftests/kmod/Makefile b/tools/testing/selftests/kmod/Makefile
index 5b3e746a0bee..48aeaae76211 100644
--- a/tools/testing/selftests/kmod/Makefile
+++ b/tools/testing/selftests/kmod/Makefile
@@ -1,12 +1,19 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Makefile for kmod loading selftests
 
-# No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
-all:
-
 TEST_PROGS := kmod.sh
 
+# compile but not part of 'make run_tests'
+TEST_GEN_PROGS_EXTENDED := init_module kmod_test_0014.ko
+
+# override lib.mk's default rule
+override define CLEAN
+	$(RM) $(TEST_GEN_PROGS_EXTENDED)
+	$(MAKE) -C kmod_test_0014 clean
+endef
+
 include ../lib.mk
 
-# Nothing to clean up.
-clean:
+$(OUTPUT)/kmod_test_0014.ko: $(wildcard kmod_test_0014/Makefile kmod_test_0014/*.[ch])
+	$(MAKE) -C kmod_test_0014
+	cp kmod_test_0014/kmod_test_0014.ko $@
diff --git a/tools/testing/selftests/kmod/init_module.c b/tools/testing/selftests/kmod/init_module.c
new file mode 100644
index 000000000000..529abd0a8357
--- /dev/null
+++ b/tools/testing/selftests/kmod/init_module.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Simple program to insert a module, similar to insmod but tailored
+ * specifically for needs of module loader tests.
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <errno.h>
+
+int main(int argc, char *argv[])
+{
+	const char *filename, *args;
+	int fd, ret;
+
+	if (argc < 2 || argc > 3) {
+		fprintf(stderr, "usage: %s filename [args]\n", argv[0]);
+		return EINVAL;
+	}
+
+	filename = argv[1];
+	args = argc > 2 ? argv[2] : "";
+
+	fd = open(filename, O_RDONLY);
+	if (fd == -1) {
+		ret = errno;
+		fprintf(stderr, "init_module: could not open file %s: %s\n",
+			filename, strerror(ret));
+		return ret;
+	}
+
+	ret = syscall(SYS_finit_module, fd, args, 0);
+	if (ret != 0) {
+		ret = errno;
+		fprintf(stderr, "init_module: could not load module %s: %s\n",
+			filename, strerror(ret));
+	}
+
+	close(fd);
+
+	return ret;
+}
diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index afd42387e8b2..8836d7fe1a0a 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -65,6 +65,8 @@ ALL_TESTS="$ALL_TESTS 0010:1:1"
 ALL_TESTS="$ALL_TESTS 0011:1:1"
 ALL_TESTS="$ALL_TESTS 0012:1:1"
 ALL_TESTS="$ALL_TESTS 0013:1:1"
+ALL_TESTS="$ALL_TESTS 0014:1:1"
+ALL_TESTS="$ALL_TESTS 0015:1:1"
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
@@ -171,6 +173,12 @@ errno_name_to_val()
 		echo -1;;
 	-ENOENT)
 		echo -2;;
+	-EBUSY)
+		echo -16;;
+	-EEXIST)
+		echo -17;;
+	-ENODEV)
+		echo -19;;
 	-EINVAL)
 		echo -22;;
 	-ERR_ANY)
@@ -190,6 +198,12 @@ errno_val_to_name()
 		echo -EPERM;;
 	-2)
 		echo -ENOENT;;
+	-16)
+		echo -EBUSY;;
+	-17)
+		echo -EEXIST;;
+	-19)
+		echo -ENODEV;;
 	-22)
 		echo -EINVAL;;
 	-123456)
@@ -504,6 +518,129 @@ kmod_test_0013()
 		"cat /sys/module/${DEFAULT_KMOD_DRIVER}/sections/.*text | head -n1"
 }
 
+# Test that loading the same module multiple times in parallel results only in
+# one real attempt to initialize it. Synchronization of the loads is done by
+# waiting 1000 ms in the init function of a sample module kmod_test_0014. Tests
+# measure time needed to perform all inserts to verify that the loads get merged
+# by the module loader and are not serialized.
+#
+# * Case 0014 checks a situation when the load is successful. It should result
+#   in one insert returning 0 and remaining inserts returning EEXIST.
+# * Case 0015 checks a situation when the load is failing because the module
+#   init function returns ENODEV. It should result in one insert returning this
+#   error code and remaining inserts returning EBUSY.
+kmod_check_parallel_loads()
+{
+	local test_name="$1"
+	local parallel_loads="$2"
+	local insmod_params="$3"
+	local max_time="$4"
+	local success_exp="$5"
+	local ebusy_exp="$6"
+	local eexist_exp="$7"
+	local enodev_exp="$8"
+	local other_exp="$9"
+
+	local EBUSY=$(errno_name_to_val -EBUSY)
+	local EEXIST=$(errno_name_to_val -EEXIST)
+	local ENODEV=$(errno_name_to_val -ENODEV)
+	local start end elapsed pids
+	local success_cnt=0 ebusy_cnt=0 eexist_cnt=0 enodev_cnt=0 other_cnt=0
+	local test_ok=true
+
+	# Do a dummy insert to get the file into the page cache.
+	./init_module kmod_test_0014.ko "sleep_msecs=0 retval=0"
+	rmmod kmod_test_0014
+
+	# Run the parallel loads.
+	let start=$(date +%s%N)/1000000
+
+	for i in $(seq 0 $(($parallel_loads - 1))); do
+		./init_module kmod_test_0014.ko "$insmod_params" &
+		pids[$i]=$!
+	done
+
+	for pid in ${pids[*]}; do
+		local rc
+		{ wait $pid; let rc=-$?; } || true
+
+		case $rc in
+		0)
+			let success_cnt=$success_cnt+1;;
+		$EBUSY)
+			let ebusy_cnt=$ebusy_cnt+1;;
+		$EEXIST)
+			let eexist_cnt=$eexist_cnt+1;;
+		$ENODEV)
+			let enodev_cnt=$enodev_cnt+1;;
+		*)
+			let other_cnt=$other_cnt+1;;
+		esac
+	done
+
+	let end=$(date +%s%N)/1000000
+	let elapsed=$end-$start
+
+	if (( $success_cnt > 0 )); then
+		rmmod kmod_test_0014
+	fi
+
+	# Check the results.
+	if (( $elapsed > $max_time )); then
+		echo "$test_name: FAIL, time to load the modules is within limit, test expects '<$max_time' ms - got '$elapsed' ms" >&2
+		test_ok=false
+	else
+		echo "$test_name: OK! - time to load the modules is within limit, test expects '<$max_time' ms - got '$elapsed' ms" >&2
+	fi
+	if (( $success_cnt != $success_exp )); then
+		echo "$test_name: FAIL, number of successful loads, test expects '$success_exp' - got '$success_cnt'" >&2
+		test_ok=false
+	else
+		echo "$test_name: OK! - number of successful loads, test expects '$success_exp' - got '$success_cnt'" >&2
+	fi
+	if (( $ebusy_cnt != $ebusy_exp )); then
+		echo "$test_name: FAIL, number of loads returning EBUSY, test expects '$ebusy_exp' - got '$ebusy_cnt'" >&2
+		test_ok=false
+	else
+		echo "$test_name: OK! - number of loads returning EBUSY, test expects '$ebusy_exp' - got '$ebusy_cnt'" >&2
+	fi
+	if (( $eexist_cnt != $eexist_exp )); then
+		echo "$test_name: FAIL, number of loads returning EEXIST, test expects '$eexist_exp' - got '$eexist_cnt'" >&2
+		test_ok=false
+	else
+		echo "$test_name: OK! - number of loads returning EEXIST, test expects '$eexist_exp' - got '$eexist_cnt'" >&2
+	fi
+	if (( $enodev_cnt != $enodev_exp )); then
+		echo "$test_name: FAIL, number of loads returning ENODEV, test expects '$enodev_exp' - got '$enodev_cnt'" >&2
+		test_ok=false
+	else
+		echo "$test_name: OK! - number of loads returning ENODEV, test expects '$enodev_exp' - got '$enodev_cnt'" >&2
+	fi
+	if (( $other_cnt != $other_exp )); then
+		echo "$test_name: FAIL, number of loads returning other values, test expects '$other_exp' - got '$other_cnt'" >&2
+		test_ok=false
+	else
+		echo "$test_name: OK! - number of loads returning other values, test expects '$other_exp' - got '$other_cnt'" >&2
+	fi
+
+	[ $test_ok = true ] || exit 1
+}
+
+kmod_test_0014()
+{
+	kmod_check_parallel_loads \
+		"${FUNCNAME[0]}" 4 "sleep_msecs=1000 retval=0" 3000 \
+		1 0 3 0 0
+}
+
+kmod_test_0015()
+{
+	local ENODEV=$(errno_name_to_val -ENODEV)
+	kmod_check_parallel_loads \
+		"${FUNCNAME[0]}" 4 "sleep_msecs=1000 retval=$ENODEV" 3000 \
+		0 3 0 1 0
+}
+
 list_tests()
 {
 	echo "Test ID list:"
@@ -525,6 +662,8 @@ list_tests()
 	echo "0011 x $(get_test_count 0011) - test completely disabling module autoloading"
 	echo "0012 x $(get_test_count 0012) - test /proc/modules address visibility under CAP_SYSLOG"
 	echo "0013 x $(get_test_count 0013) - test /sys/module/*/sections/* visibility under CAP_SYSLOG"
+	echo "0014 x $(get_test_count 0014) - test handling of parallel loads, success case"
+	echo "0015 x $(get_test_count 0015) - test handling of parallel loads, init returning error"
 }
 
 usage()
diff --git a/tools/testing/selftests/kmod/kmod_test_0014/Makefile b/tools/testing/selftests/kmod/kmod_test_0014/Makefile
new file mode 100644
index 000000000000..c90afe5a98ad
--- /dev/null
+++ b/tools/testing/selftests/kmod/kmod_test_0014/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+KMOD_TEST_0014_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= $(abspath $(KMOD_TEST_0014_DIR)/../../../../..)
+
+MODULES = kmod_test_0014.ko
+
+obj-m += kmod_test_0014.o
+
+all:
+	$(MAKE) -C $(KDIR) M=$(KMOD_TEST_0014_DIR) modules
+
+clean:
+	$(MAKE) -C $(KDIR) M=$(KMOD_TEST_0014_DIR) clean
diff --git a/tools/testing/selftests/kmod/kmod_test_0014/kmod_test_0014.c b/tools/testing/selftests/kmod/kmod_test_0014/kmod_test_0014.c
new file mode 100644
index 000000000000..2b2ebeefe689
--- /dev/null
+++ b/tools/testing/selftests/kmod/kmod_test_0014/kmod_test_0014.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+
+static unsigned int sleep_msecs = 1000;
+module_param(sleep_msecs, uint, 0644);
+MODULE_PARM_DESC(sleep_msecs, "init sleep in miliseconds, default 1000");
+
+static int retval;
+module_param(retval, int, 0644);
+MODULE_PARM_DESC(retval, "init return value, default 0");
+
+static int __init kmod_test_0014_init(void)
+{
+	msleep(sleep_msecs);
+	return retval;
+}
+
+static void __exit kmod_test_0014_exit(void)
+{
+}
+
+module_init(kmod_test_0014_init);
+module_exit(kmod_test_0014_exit);
+
+MODULE_AUTHOR("Petr Pavlu <petr.pavlu@suse.com>");
+MODULE_LICENSE("GPL");
-- 
2.35.3

