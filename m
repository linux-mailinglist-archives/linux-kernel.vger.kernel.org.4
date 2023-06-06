Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B538D723AC3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjFFH6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbjFFH6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:58:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCC235AB;
        Tue,  6 Jun 2023 00:55:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 59EBB2199D;
        Tue,  6 Jun 2023 07:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686038088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=n79PuqCtTM6IuZSKm3i8HhaY4FkFU/7zhn2k+OQPD+g=;
        b=t0QMs+Joe0sxSFTDVoOqgzB0WU4lrO54RcHAcRVp5Xrc4rqDTNgKCbV1oBA/V1+l8fXKBy
        p3l7h47B73MFvhhZ5328nT40xlffUaNXPGS9+seBXosndpyNRTLA3qy1slzY7pttkC/EXX
        rgFRkHAaDwuWogdeLF0yO0Abhx0ksi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686038088;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=n79PuqCtTM6IuZSKm3i8HhaY4FkFU/7zhn2k+OQPD+g=;
        b=7RuhnEzgW7+IFwJOhKSSwT9w7hQWb5V4xy9zT/WbILxsNCebLhVvLDOH6dMor9zVTTFlyS
        DIu6vboBYxE+sHAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 484C513519;
        Tue,  6 Jun 2023 07:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s1aVEUjmfmSGHAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 06 Jun 2023 07:54:48 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>,
        John Meneghini <jmeneghi@redhat.com>
Subject: [PATCH blktests v1] nvmeof-mp: Remove nvmeof-mp tests
Date:   Tue,  6 Jun 2023 09:54:43 +0200
Message-Id: <20230606075443.17437-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nvmeof-mp are designed to test a NVMe multipathing setup using
dm_multipath, which was a configuration RHEL shipped. In the meantime,
RHEL switched also to NVMe native multipathing which is tested with the
nvme tests.

The nvme tests cover all the use cases which are testes by nvmeof-mp
including the transport failure, see nvme/040.

During LSFMM 2023 conference it was decided it is better to drop these
tests and reduce the maintenance burden on blktests.

Cc: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md |   4 +-
 common/multipath-over-rdma     |   2 +-
 tests/nvmeof-mp/.gitignore     |   1 -
 tests/nvmeof-mp/001            |  40 -----
 tests/nvmeof-mp/001.out        |   2 -
 tests/nvmeof-mp/002            |  36 ----
 tests/nvmeof-mp/002.out        |   2 -
 tests/nvmeof-mp/004            |  40 -----
 tests/nvmeof-mp/004.out        |   2 -
 tests/nvmeof-mp/005            |  26 ---
 tests/nvmeof-mp/005.out        |   2 -
 tests/nvmeof-mp/006            |  26 ---
 tests/nvmeof-mp/006.out        |   2 -
 tests/nvmeof-mp/009            |  26 ---
 tests/nvmeof-mp/009.out        |   2 -
 tests/nvmeof-mp/010            |  26 ---
 tests/nvmeof-mp/010.out        |   2 -
 tests/nvmeof-mp/011            |  32 ----
 tests/nvmeof-mp/011.out        |   2 -
 tests/nvmeof-mp/012            |  42 -----
 tests/nvmeof-mp/012.out        |   2 -
 tests/nvmeof-mp/multipath.conf |  27 ---
 tests/nvmeof-mp/rc             | 292 ---------------------------------
 23 files changed, 2 insertions(+), 636 deletions(-)
 delete mode 100644 tests/nvmeof-mp/.gitignore
 delete mode 100755 tests/nvmeof-mp/001
 delete mode 100644 tests/nvmeof-mp/001.out
 delete mode 100755 tests/nvmeof-mp/002
 delete mode 100644 tests/nvmeof-mp/002.out
 delete mode 100755 tests/nvmeof-mp/004
 delete mode 100644 tests/nvmeof-mp/004.out
 delete mode 100755 tests/nvmeof-mp/005
 delete mode 100644 tests/nvmeof-mp/005.out
 delete mode 100755 tests/nvmeof-mp/006
 delete mode 100644 tests/nvmeof-mp/006.out
 delete mode 100755 tests/nvmeof-mp/009
 delete mode 100644 tests/nvmeof-mp/009.out
 delete mode 100755 tests/nvmeof-mp/010
 delete mode 100644 tests/nvmeof-mp/010.out
 delete mode 100755 tests/nvmeof-mp/011
 delete mode 100644 tests/nvmeof-mp/011.out
 delete mode 100755 tests/nvmeof-mp/012
 delete mode 100644 tests/nvmeof-mp/012.out
 delete mode 100644 tests/nvmeof-mp/multipath.conf
 delete mode 100755 tests/nvmeof-mp/rc

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index b35ae10316e4..62fae60f43fa 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -110,18 +110,16 @@ The NVMe tests can be additionally parameterized via environment variables.
 - nvme_num_iter: 1000 (default)
   The number of iterations a test should do.
 
-### Running nvme-rdma nvmeof-mp srp tests
+### Running nvme-rdma srp tests
 
 Most of these tests will use the rdma_rxe (soft-RoCE) driver by default. The siw (soft-iWARP) driver is also supported.
 ```sh
 To use the rdma_rxe driver:
 nvme_trtype=rdma ./check nvme/
-./check nvmeof-mp/
 ./check srp/
 
 To use the siw driver:
 use_siw=1 nvme_trtype=rdma ./check nvme/
-use_siw=1 ./check nvmeof-mp/
 use_siw=1 ./check srp/
 ```
 
diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 9bc1c19258f4..f124897917ca 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Functions and global variables used by both the srp and nvmeof-mp tests.
+# Functions and global variables used by the srp tests.
 
 . common/shellcheck
 . common/null_blk
diff --git a/tests/nvmeof-mp/.gitignore b/tests/nvmeof-mp/.gitignore
deleted file mode 100644
index ecb6268a585b..000000000000
--- a/tests/nvmeof-mp/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-multipath.conf
diff --git a/tests/nvmeof-mp/001 b/tests/nvmeof-mp/001
deleted file mode 100755
index 70a4455808cb..000000000000
--- a/tests/nvmeof-mp/001
+++ /dev/null
@@ -1,40 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
-
-. tests/nvmeof-mp/rc
-
-DESCRIPTION="Log in and log out"
-QUICK=1
-
-count_devices() {
-	local d devs=0
-
-	for d in /sys/class/nvme-fabrics/ctl/*/*/device; do
-		[[ "$d" =~ hwmon[0-9]+|ng[0-9]+n[0-9]+ ]] && continue
-		[ -d "$d" ] && ((devs++))
-	done
-	echo "$devs"
-}
-
-wait_for_devices() {
-	local expected=0 i devices
-
-	for i in $(rdma_network_interfaces); do
-		((expected++))
-	done
-
-	use_blk_mq y || return $?
-	for ((i=0;i<100;i++)); do
-		devices=$(count_devices)
-		[ "$devices" -ge "$expected" ] && break
-		sleep .1
-	done
-	echo "count_devices(): $devices <> $expected" >>"$FULL"
-	[ "$devices" -ge "$expected" ]
-}
-
-test() {
-	trap 'trap "" EXIT; teardown' EXIT
-	setup && wait_for_devices && echo Passed
-}
diff --git a/tests/nvmeof-mp/001.out b/tests/nvmeof-mp/001.out
deleted file mode 100644
index a7d4cb9bcb29..000000000000
--- a/tests/nvmeof-mp/001.out
+++ /dev/null
@@ -1,2 +0,0 @@
-Configured NVMe target driver
-Passed
diff --git a/tests/nvmeof-mp/002 b/tests/nvmeof-mp/002
deleted file mode 100755
index 2aebe9895649..000000000000
--- a/tests/nvmeof-mp/002
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
-
-. tests/nvmeof-mp/rc
-
-DESCRIPTION="File I/O on top of multipath concurrently with logout and login (mq)"
-TIMED=1
-
-test_disconnect_repeatedly() {
-	local dev fio_status m
-
-	use_blk_mq y || return $?
-	dev=$(get_bdev 0) || return $?
-	m=$(mountpoint 0) || return $?
-	create_filesystem "$dev" || return $?
-	mount_and_check "$dev" "$m" || return $?
-	# shellcheck disable=SC2064
-	trap "unmount_and_check $m" RETURN
-	simulate_network_failure_loop "$dev" "$TIMEOUT" &
-	run_fio --verify=md5 --rw=randwrite --bs=4K --loops=$((10**6)) \
-		--iodepth=64 --group_reporting --sync=1 --direct=1 \
-		--ioengine=libaio --directory="$m" --runtime="${TIMEOUT}" \
-		--name=data-integrity-test-mq --thread --numjobs=16 \
-		--output="${RESULTS_DIR}/nvmeof-mp/fio-output-002.txt" \
-		>>"$FULL"
-	fio_status=$?
-	wait
-	return $fio_status
-}
-
-test() {
-	: "${TIMEOUT:=30}"
-	trap 'trap "" EXIT; teardown' EXIT
-	setup && test_disconnect_repeatedly && echo Passed
-}
diff --git a/tests/nvmeof-mp/002.out b/tests/nvmeof-mp/002.out
deleted file mode 100644
index a7d4cb9bcb29..000000000000
--- a/tests/nvmeof-mp/002.out
+++ /dev/null
@@ -1,2 +0,0 @@
-Configured NVMe target driver
-Passed
diff --git a/tests/nvmeof-mp/004 b/tests/nvmeof-mp/004
deleted file mode 100755
index 990fcfc9e472..000000000000
--- a/tests/nvmeof-mp/004
+++ /dev/null
@@ -1,40 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
-
-. tests/nvmeof-mp/rc
-
-DESCRIPTION="File I/O on top of multipath concurrently with logout and login (sq-on-mq)"
-TIMED=1
-
-requires() {
-	_have_legacy_dm
-}
-
-test_disconnect_repeatedly() {
-	local dev fio_status m
-
-	use_blk_mq n || return $?
-	dev=$(get_bdev 0) || return $?
-	m=$(mountpoint 0) || return $?
-	create_filesystem "$dev" || return $?
-	mount_and_check "$dev" "$m" || return $?
-	# shellcheck disable=SC2064
-	trap "unmount_and_check $m" RETURN
-	simulate_network_failure_loop "$dev" "$TIMEOUT" &
-	run_fio --verify=md5 --rw=randwrite --bs=4K --loops=$((10**6)) \
-		--iodepth=64 --group_reporting --sync=1 --direct=1 \
-		--ioengine=libaio --directory="$m" \
-		--name=data-integrity-test-02-sq-on-mq --thread \
-		--numjobs=16 --runtime="${TIMEOUT}" \
-		--output="${RESULTS_DIR}/nvmeof-mp/fio-output-004.txt" >>"$FULL"
-	fio_status=$?
-	wait
-	return $fio_status
-}
-
-test() {
-	: "${TIMEOUT:=30}"
-	trap 'trap "" EXIT; teardown' EXIT
-	setup && test_disconnect_repeatedly && echo Passed
-}
diff --git a/tests/nvmeof-mp/004.out b/tests/nvmeof-mp/004.out
deleted file mode 100644
index a7d4cb9bcb29..000000000000
--- a/tests/nvmeof-mp/004.out
+++ /dev/null
@@ -1,2 +0,0 @@
-Configured NVMe target driver
-Passed
diff --git a/tests/nvmeof-mp/005 b/tests/nvmeof-mp/005
deleted file mode 100755
index fb623acc0d99..000000000000
--- a/tests/nvmeof-mp/005
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
-
-. tests/nvmeof-mp/rc
-
-DESCRIPTION="Direct I/O with large transfer sizes and bs=4M"
-QUICK=1
-
-test_large_transfer_size() {
-	local dev m
-
-	use_blk_mq y || return $?
-	dev=$(get_bdev 0) || return $?
-	run_fio --verify=md5 --rw=randwrite --bs=4M --loops=$((10**6)) \
-		--iodepth=4 --group_reporting --sync=1 --direct=1 \
-		--ioengine=libaio \
-		--filename="$dev" --name=large-io-test --thread --numjobs=1 \
-		--runtime=10 --output="${RESULTS_DIR}/nvmeof-mp/fio-output-005.txt" \
-		>>"$FULL"
-}
-
-test() {
-	trap 'trap "" EXIT; teardown' EXIT
-	setup && test_large_transfer_size && echo Passed
-}
diff --git a/tests/nvmeof-mp/005.out b/tests/nvmeof-mp/005.out
deleted file mode 100644
index a7d4cb9bcb29..000000000000
--- a/tests/nvmeof-mp/005.out
+++ /dev/null
@@ -1,2 +0,0 @@
-Configured NVMe target driver
-Passed
diff --git a/tests/nvmeof-mp/006 b/tests/nvmeof-mp/006
deleted file mode 100755
index 2034ed1729c6..000000000000
--- a/tests/nvmeof-mp/006
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
-
-. tests/nvmeof-mp/rc
-
-DESCRIPTION="Direct I/O with large transfer sizes and bs=8M"
-QUICK=1
-
-test_large_transfer_size() {
-	local dev m
-
-	use_blk_mq y || return $?
-	dev=$(get_bdev 0) || return $?
-	run_fio --verify=md5 --rw=randwrite --bs=8M --loops=$((10**6)) \
-		--iodepth=4 --group_reporting --sync=1 --direct=1 \
-		--ioengine=libaio \
-		--filename="$dev" --name=large-io-test --thread --numjobs=1 \
-		--runtime=10 --output="${RESULTS_DIR}/nvmeof-mp/fio-output-006.txt" \
-		>>"$FULL"
-}
-
-test() {
-	trap 'trap "" EXIT; teardown' EXIT
-	setup && test_large_transfer_size && echo Passed
-}
diff --git a/tests/nvmeof-mp/006.out b/tests/nvmeof-mp/006.out
deleted file mode 100644
index a7d4cb9bcb29..000000000000
--- a/tests/nvmeof-mp/006.out
+++ /dev/null
@@ -1,2 +0,0 @@
-Configured NVMe target driver
-Passed
diff --git a/tests/nvmeof-mp/009 b/tests/nvmeof-mp/009
deleted file mode 100755
index 35c706fd8534..000000000000
--- a/tests/nvmeof-mp/009
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
-
-. tests/nvmeof-mp/rc
-
-DESCRIPTION="Buffered I/O with large transfer sizes and bs=4M"
-QUICK=1
-
-test_large_transfer_size() {
-	local dev m
-
-	use_blk_mq y || return $?
-	dev=$(get_bdev 0) || return $?
-	run_fio --verify=md5 --rw=randwrite --bs=4M --loops=$((10**6)) \
-		--iodepth=4 --group_reporting --sync=1 --direct=0 \
-		--ioengine=libaio \
-		--filename="$dev" --name=large-io-test --thread --numjobs=1 \
-		--runtime=10 --output="${RESULTS_DIR}/nvmeof-mp/fio-output-009.txt" \
-		>>"$FULL"
-}
-
-test() {
-	trap 'trap "" EXIT; teardown' EXIT
-	setup && test_large_transfer_size && echo Passed
-}
diff --git a/tests/nvmeof-mp/009.out b/tests/nvmeof-mp/009.out
deleted file mode 100644
index a7d4cb9bcb29..000000000000
--- a/tests/nvmeof-mp/009.out
+++ /dev/null
@@ -1,2 +0,0 @@
-Configured NVMe target driver
-Passed
diff --git a/tests/nvmeof-mp/010 b/tests/nvmeof-mp/010
deleted file mode 100755
index 9f6c245bb13e..000000000000
--- a/tests/nvmeof-mp/010
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
-
-. tests/nvmeof-mp/rc
-
-DESCRIPTION="Buffered I/O with large transfer sizes and bs=8M"
-QUICK=1
-
-test_large_transfer_size() {
-	local dev m
-
-	use_blk_mq y || return $?
-	dev=$(get_bdev 0) || return $?
-	run_fio --verify=md5 --rw=randwrite --bs=8M --loops=$((10**6)) \
-		--iodepth=4 --group_reporting --sync=1 --direct=0 \
-		--ioengine=libaio \
-		--filename="$dev" --name=large-io-test --thread --numjobs=1 \
-		--runtime=10 --output="${RESULTS_DIR}/nvmeof-mp/fio-output-010.txt" \
-		>>"$FULL"
-}
-
-test() {
-	trap 'trap "" EXIT; teardown' EXIT
-	setup && test_large_transfer_size && echo Passed
-}
diff --git a/tests/nvmeof-mp/010.out b/tests/nvmeof-mp/010.out
deleted file mode 100644
index a7d4cb9bcb29..000000000000
--- a/tests/nvmeof-mp/010.out
+++ /dev/null
@@ -1,2 +0,0 @@
-Configured NVMe target driver
-Passed
diff --git a/tests/nvmeof-mp/011 b/tests/nvmeof-mp/011
deleted file mode 100755
index d0a4f8c0db30..000000000000
--- a/tests/nvmeof-mp/011
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
-
-. tests/nvmeof-mp/rc
-
-DESCRIPTION="Block I/O on top of multipath concurrently with logout and login"
-TIMED=1
-
-test_disconnect_repeatedly() {
-	local dev fio_status m
-
-	use_blk_mq y || return $?
-	dev=$(get_bdev 0) || return $?
-	simulate_network_failure_loop "$dev" "$TIMEOUT" &
-	run_fio --verify=md5 --rw=randwrite --bs=4K --loops=10000 \
-		--ioengine=libaio --iodepth=64 --iodepth_batch=32 \
-		--group_reporting --sync=1 --direct=1 --filename="$dev" \
-		--name=data-integrity-test-06 --thread --numjobs=1 \
-		--runtime="${TIMEOUT}" \
-		--output="${RESULTS_DIR}/nvmeof-mp/fio-output-011.txt" \
-		>>"$FULL"
-	fio_status=$?
-	wait
-	return $fio_status
-}
-
-test() {
-	: "${TIMEOUT:=30}"
-	trap 'trap "" EXIT; teardown' EXIT
-	setup && test_disconnect_repeatedly && echo Passed
-}
diff --git a/tests/nvmeof-mp/011.out b/tests/nvmeof-mp/011.out
deleted file mode 100644
index a7d4cb9bcb29..000000000000
--- a/tests/nvmeof-mp/011.out
+++ /dev/null
@@ -1,2 +0,0 @@
-Configured NVMe target driver
-Passed
diff --git a/tests/nvmeof-mp/012 b/tests/nvmeof-mp/012
deleted file mode 100755
index b2d7a6351bf7..000000000000
--- a/tests/nvmeof-mp/012
+++ /dev/null
@@ -1,42 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2018 Western Digital Corporation or its affiliates
-
-. tests/nvmeof-mp/rc
-
-DESCRIPTION="dm-mpath on top of multiple I/O schedulers"
-QUICK=1
-
-test_io_schedulers() {
-	local dev m dm scheds
-
-	# Load all I/O scheduler kernel modules
-	for m in "/lib/modules/$(uname -r)/kernel/block/"*.ko; do
-		modprobe "$(basename "$m")" >&/dev/null
-	done
-	for mq in y n; do
-		use_blk_mq ${mq} || return $?
-		dev=$(get_bdev 0) || return $?
-		dm=$(basename "$(readlink -f "${dev}")") || return $?
-		scheds="$(_io_schedulers "$dm")" || return $?
-		for sched in $scheds; do
-			set_scheduler "$dm" "$sched" \
-				      >>"$FULL" 2>&1 || continue
-			echo "I/O scheduler: $sched; use_blk_mq: $mq" >>"$FULL"
-			run_fio --verify=md5 --rw=randwrite --bs=4K --size=64K \
-				--ioengine=libaio --iodepth=64 \
-				--iodepth_batch=32 --group_reporting --sync=1 \
-				--direct=1 --filename="$dev" \
-				--name="${sched}" --thread --numjobs=1 \
-				--output="${RESULTS_DIR}/nvmeof-mp/012-${sched}-${mq}.txt" \
-				>>"$FULL" ||
-				return $?
-		done
-	done
-	return 0
-}
-
-test() {
-	trap 'trap "" EXIT; teardown' EXIT
-	setup && test_io_schedulers && echo Passed
-}
diff --git a/tests/nvmeof-mp/012.out b/tests/nvmeof-mp/012.out
deleted file mode 100644
index a7d4cb9bcb29..000000000000
--- a/tests/nvmeof-mp/012.out
+++ /dev/null
@@ -1,2 +0,0 @@
-Configured NVMe target driver
-Passed
diff --git a/tests/nvmeof-mp/multipath.conf b/tests/nvmeof-mp/multipath.conf
deleted file mode 100644
index 8aed22e11f3e..000000000000
--- a/tests/nvmeof-mp/multipath.conf
+++ /dev/null
@@ -1,27 +0,0 @@
-defaults {
-	find_multipaths		no
-	user_friendly_names	yes
-	queue_without_daemon	no
-}
-devices {
-	device {
-		vendor		"NVME"
-		product		"Linux"
-		no_path_retry	"queue"
-		path_checker	"directio"
-	}
-}
-blacklist {
-	device {
-		vendor	"ATA|QEMU"
-	}
-	device {
-		vendor	"Linux"
-		product	"scsi_debug"
-	}
-	devnode	"^nullb.*"
-}
-blacklist_exceptions {
-	property	".*"
-	devnode		"^nvme"
-}
diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
deleted file mode 100755
index 4f4d518c6483..000000000000
--- a/tests/nvmeof-mp/rc
+++ /dev/null
@@ -1,292 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2018 Western Digital Corporation or its affiliates
-
-. common/rc
-. common/multipath-over-rdma
-
-namespace=(1)
-elevator=none
-nvme_subsysnqn="nvme-test"
-nvme_port=7777
-ini_timeout=1
-
-group_requires() {
-	local m name p
-
-	_have_kernel_config_file || return
-	# Since the nvmeof-mp tests are based on the dm-mpath driver, these
-	# tests are incompatible with the NVME_MULTIPATH kernel configuration
-	# option with multipathing enabled in the nvme_core kernel module.
-	if _check_kernel_option NVME_MULTIPATH && \
-		_have_module_param_value nvme_core multipath Y; then
-		SKIP_REASONS+=("CONFIG_NVME_MULTIPATH has been set in .config and multipathing has been enabled in the nvme_core kernel module")
-		return
-	fi
-
-	_have_configfs || return
-
-	_have_module dm_multipath
-	_have_module dm_queue_length
-	_have_module dm_service_time
-	_have_module null_blk
-	_have_module rdma_cm
-	_have_module ib_ipoib
-	_have_module ib_umad
-	_have_module nvme-rdma
-	_have_module nvmet-rdma
-	_have_module rdma_rxe
-	_have_module scsi_dh_alua
-	_have_module scsi_dh_emc
-	_have_module scsi_dh_rdac
-
-	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof rdma fio; do
-		_have_program "$p" || return
-	done
-
-	_multipathd_version_ge 0.7.0 || return
-	
-	_have_root || return
-
-	_have_kernel_option DM_UEVENT || return
-
-	# shellcheck disable=SC2043
-	for name in multipathd; do
-		if pidof "$name" >/dev/null; then
-			SKIP_REASONS+=("$name must be stopped before the nvmeof-mp tests are run")
-			return
-		fi
-	done
-	if [ -e /etc/multipath.conf ] &&
-	    ! diff -q /etc/multipath.conf tests/nvmeof-mp/multipath.conf >&/dev/null
-	then
-		SKIP_REASONS+=("/etc/multipath.conf already exists")
-		return
-	fi
-}
-
-# Log out, set dm use_blk_mq parameter to $1 and log in.
-use_blk_mq() {
-	local dm_mode=$1
-
-	(
-		cd /sys/module/dm_mod/parameters || return $?
-		if [ -e use_blk_mq ]; then
-			echo "$dm_mode" >use_blk_mq || return 1
-		fi
-	)
-
-	log_out &&
-		remove_mpath_devs &&
-		start_client &&
-		log_in &&
-		return 0
-
-	echo "use_blk_mq $* failed" >>"$FULL"
-	return 1
-}
-
-log_in() {
-	local i ipv4_addr loginparams
-
-	[ -c /dev/nvme-fabrics ] &&
-		for i in $(rdma_network_interfaces); do
-			ipv4_addr=$(get_ipv4_addr "$i")
-			if [ -n "${ipv4_addr}" ]; then
-				loginparams="transport=rdma,traddr=${ipv4_addr},trsvcid=${nvme_port},nqn=$nvme_subsysnqn"
-				echo "Login parameters: $loginparams" >>"$FULL"
-				{
-					echo -n "$loginparams" > /dev/nvme-fabrics
-				} 2>>"$FULL"
-			fi
-		done
-}
-
-log_out() {
-	local c
-
-	for c in /sys/class/nvme-fabrics/ctl/*/delete_controller; do
-		[ -e "$c" ] && echo 1 > "$c" &
-	done
-	wait
-}
-
-# Simulate network failures for device $1 during $2 seconds.
-simulate_network_failure_loop() {
-	local d dev="$1" duration="$2" deadline i rc=0 sf
-
-	[ -e "$dev" ] || return 1
-	[ -n "$duration" ] || return 1
-	deadline=$(($(_uptime_s) + duration))
-	while [ $rc = 0 ]; do
-		sleep_until 5 ${deadline} || break
-		for d in $(held_by "$dev"); do
-			for sf in /sys/class/nvme/*/device/*/"${d#/dev/}/reset_controller"; do
-				[ -e "$sf" ] && echo 1 > "$sf"
-			done
-		done
-	done 2>>"$FULL"
-
-	for ((i=0;i<5;i++)); do
-		log_in 2>/dev/null && break
-		sleep 1
-	done
-}
-
-remove_mpath_devs() {
-	local dm h
-
-	{
-		for h in /sys/class/block/nvme*/holders/*; do
-			[ -e "$h" ] || continue
-			d=$(basename "$(dirname "$(dirname "$h")")")
-			dm=/dev/$(basename "$h")
-			echo -n "NVME dev $d: removing $dm: "
-			dmsetup remove "$(dev_to_mpath "$dm")" && echo "done"
-		done
-
-		remove_stale_mpath_devs
-	} &>> "$FULL"
-}
-
-start_nvme_client() {
-	modprobe nvme-core dyndbg=+pmf &&
-		modprobe nvme dyndbg=+pmf &&
-		modprobe nvme-fabrics dyndbg=+pmf &&
-		modprobe nvme-rdma dyndbg=+pmf &&
-		mkdir -p "$(mountpoint 0)"
-	udevadm settle
-	if [ ! -c /dev/nvme-fabrics ]; then
-		echo "Error:  /dev/nvme-fabrics not available"
-	fi
-}
-
-stop_nvme_client() {
-	_unload_module nvme-rdma || return $?
-	_unload_module nvme-fabrics || return $?
-	# Ignore nvme and nvme-core unload errors - this test may be run on a
-	# system equipped with one or more NVMe SSDs.
-	_unload_module nvme >&/dev/null
-	_unload_module nvme-core >&/dev/null
-	return 0
-}
-
-# Load the initiator kernel driver with kernel module parameters $1..$n.
-start_client() {
-	start_nvme_client
-}
-
-stop_client() {
-	stop_nvme_client
-}
-
-# Get the name of the initiator device node that communicates with target
-# device $1. $1 is an index in the $namespace array.
-get_bdev_path() {
-	local i=$1 uuid
-
-	is_number "$i" || return $?
-	uuid=$(<"/sys/kernel/config/nvmet/subsystems/${nvme_subsysnqn}/namespaces/${namespace[$1]}/device_uuid") || return $?
-	echo "/dev/disk/by-id/dm-uuid-mpath-uuid.$uuid"
-}
-
-# Get a /dev/... path that points at dm device number $1. $1 is an index in
-# the $namespace array.
-get_bdev() {
-	get_bdev_n "$1" "$elevator" "$ini_timeout"
-}
-
-configure_nvmet_port() {
-	local p=$1 ipv4_addr=$2 i
-
-	echo "Configuring $p with address $ipv4_addr as an NVMeOF target port" \
-	     >>"$FULL"
-	(
-		cd /sys/kernel/config/nvmet/ports &&
-			for ((i=1;1;i++)); do [ -e "$i" ] || break; done &&
-			mkdir "$i" &&
-			cd "$i" &&
-			echo ipv4            > addr_adrfam &&
-			echo rdma            > addr_trtype &&
-			echo -n "$ipv4_addr" > addr_traddr &&
-			echo -n ${nvme_port} > addr_trsvcid
-	)
-}
-
-start_nvme_target() {
-	local d i ipv4_addr num_ports=0
-
-	echo "Configuring NVMe target driver ..." >>"$FULL"
-	modprobe nvmet dyndbg=+pmf &&
-		modprobe nvmet-rdma dyndbg=+pmf &&
-		sleep .1 &&
-		(
-			cd /sys/kernel/config/nvmet/subsystems &&
-				mkdir ${nvme_subsysnqn} &&
-				cd ${nvme_subsysnqn} &&
-				cd namespaces &&
-				mkdir "${namespace[0]}" &&
-				cd "${namespace[0]}" &&
-				echo 00000000-0000-0000-0000-000000000000 >device_nguid &&
-				echo -n /dev/nullb0 >device_path &&
-				echo 1 >enable &&
-				cd ../.. &&
-				echo 1 >attr_allow_any_host
-		) && for i in $(rdma_network_interfaces); do
-			ipv4_addr=$(get_ipv4_addr "$i")
-			if [ -n "${ipv4_addr}" ]; then
-				configure_nvmet_port "$i" "${ipv4_addr}"
-				((num_ports++))
-				true
-			fi
-		done &&
-		if [[ $num_ports = 0 ]]; then
-			echo "No NVMeOF target ports"
-			false
-		fi && (
-			cd /sys/kernel/config/nvmet/ports &&
-				for i in *; do
-					[ -e "$i" ] && (
-						cd "$i/subsystems" &&
-							ln -s "../../../subsystems/${nvme_subsysnqn}" .
-					)
-				done
-		)
-	echo "Configured NVMe target driver"
-}
-
-stop_nvme_target() {
-	local d
-
-	(
-		cd /sys/kernel/config/nvmet 2>/dev/null &&
-			rm -f -- ports/*/subsystems/* &&
-			for d in {*/*/*/*,*/*}; do
-				[ -e "$d" ] &&
-				[[ ! "$(basename "$(dirname "$d")")" =~ ana_groups|passthru ]] &&
-				rmdir "$d"
-			done
-	)
-	_unload_module nvmet_rdma &&
-		_unload_module nvmet &&
-		_exit_null_blk
-}
-
-start_target() {
-	start_nvme_target
-}
-
-stop_target() {
-	stop_nvme_target
-}
-
-shutdown_client() {
-	remove_mpath_devs &&
-		log_out &&
-		stop_client
-}
-
-# Set up test configuration
-setup() {
-	setup_test "$PWD/tests/nvmeof-mp/multipath.conf"
-}
-- 
2.40.1

