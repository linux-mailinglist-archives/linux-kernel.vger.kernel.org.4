Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA4A6CEF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjC2QWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2QWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:22:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9B091;
        Wed, 29 Mar 2023 09:22:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u10so15434260plz.7;
        Wed, 29 Mar 2023 09:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680106924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eL805LanJCOtJR13Sv0bSKaadQ6dj4kBVLoTB3pCMlY=;
        b=bw1OMPbv63jCW6z5zwcrjh7m+55uhBfSqng2W/HmczxHL3TcG5RIbu/Ae1+drJPfkj
         r3FiuKCqsa6TMlHoLyJs9h1CDElGHjgfeh+udceyadCu0VCItBIS1/7FqEy7u09pQy2w
         WjNGWpkhG2ioEFry8C9vgmtvEvk7ZvrkDKBVk/7QRH3nMmXyl4+FERCpPcd86fRBfSN7
         E3GXpz0u3jMddlrT2dxqgjxQ8dkc5KyYWDsr+ey4XAc8oUv06iPQHVp+R41zFNEMnL8o
         F5dy1rggrE8Rq1mtkBN7xogBwYqLjtA0o+DiMTgD4M5wlwI0+2OPP8xcktbQ98DAmlfU
         EE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680106924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eL805LanJCOtJR13Sv0bSKaadQ6dj4kBVLoTB3pCMlY=;
        b=aSPVANK2wDu91Uup0pytMPEAcTf6Bmzf4zvK0Rp3qyu5jywqEv8BOTOZJGEVyfmARS
         h/8V4Kke5lZcHFR9FcsREFG+mbkybd3IAgFrJRi10eFAR3SDhQ9/q8zhgKWd80Pxo4lS
         SJO//2CgxYpbJdlD1usQmHeOgcg92mxAsOfpVbxTKjhb+59SgtyEVprlLmdR30Z2faLp
         og0PkX//2oyv6ykN8AhIleeNcIOY1C2ThpDywC9OCbTM0hTN4GoHChMjoIzyia1zCfYn
         02gRaOmUtqepQT9KMgZWDuqBhHwWz3YM9HRkPihgJhAGR+TQ6C90Bgxi2iTV2WOTr9z5
         Jivg==
X-Gm-Message-State: AAQBX9clQNQDH+YHvzrhiM6keWpWB8tPUCf1agCVaKL0jwgGOcB0ZOx9
        468wFjeoFtaUk282PmGzW0s=
X-Google-Smtp-Source: AKy350bkl3Js0CxHq/OfLJhRqkWjrD3+HMYyX6ssnyqmd4SG8heNYygswD09G0AIgTVAbuK1C4rA1A==
X-Received: by 2002:a17:902:dacf:b0:19c:d7a9:8bf0 with SMTP id q15-20020a170902dacf00b0019cd7a98bf0mr3003399plx.10.1680106923636;
        Wed, 29 Mar 2023 09:22:03 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:cf16:fc3d:6c49:2909])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902b58a00b00198b01b412csm23176845pls.303.2023.03.29.09.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:22:02 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     chaitanyak@nvidia.com
Cc:     akinobu.mita@gmail.com, akpm@linux-foundation.org, axboe@kernel.dk,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests] don't require modular null_blk for fault-injection
Date:   Thu, 30 Mar 2023 01:21:45 +0900
Message-Id: <20230329162145.147395-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7c00f4f8-5bdf-4fa6-d9f0-141cf88c9ec9@nvidia.com>
References: <7c00f4f8-5bdf-4fa6-d9f0-141cf88c9ec9@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to allow configuration of null_blk fault-injection via configfs.

This blktests change changes null_blk fault-injection settings to be
configured via configfs instead of module parameters.
This allows null_blk fault-injection tests to run even if the null_blk is
built-in the kernel and not built as a module.

However, to keep the scripts simple, we will skip testing if the null_blk
does not yet support configuring fault-injection via configfs.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 tests/block/014 | 18 ++++++++++++------
 tests/block/015 | 18 ++++++++++++------
 tests/block/030 | 26 +++++++++++++++-----------
 3 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/tests/block/014 b/tests/block/014
index facd4bc..65913e5 100755
--- a/tests/block/014
+++ b/tests/block/014
@@ -16,20 +16,26 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
-	# The format is "<interval>,<probability>,<space>,<times>". Here, we
-	# fail 50% of I/Os.
-	if ! _init_null_blk timeout='1,50,0,-1'; then
+	# Here, we fail 50% of I/Os.
+	if ! _configure_null_blk faultb0 timeout_inject/probability=50 \
+	     timeout_inject/times=-1 timeout_inject/verbose=0 power=1; then
+		if [[ -d /sys/kernel/config/nullb/faultb0/timeout_inject ]]; then
+			echo "Configuring null_blk failed"
+		else
+			SKIP_REASONS+=("requires fault injection via configfs")
+		fi
+		rmdir /sys/kernel/config/nullb/faultb0
 		return 1
 	fi
 
-	for sched in $(_io_schedulers nullb0); do
+	for sched in $(_io_schedulers faultb0); do
 		echo "Testing $sched" >> "$FULL"
-		echo "$sched" > /sys/block/nullb0/queue/scheduler
+		echo "$sched" > /sys/block/faultb0/queue/scheduler
 		# Do a bunch of I/Os which will timeout and then complete. The
 		# only thing we're really testing here is that this doesn't
 		# crash or hang.
 		for ((i = 0; i < 100; i++)); do
-			dd if=/dev/nullb0 of=/dev/null bs=4K count=4 \
+			dd if=/dev/faultb0 of=/dev/null bs=4K count=4 \
 				iflag=direct status=none > /dev/null 2>&1 &
 		done
 		wait
diff --git a/tests/block/015 b/tests/block/015
index 389c67f..5257d33 100755
--- a/tests/block/015
+++ b/tests/block/015
@@ -18,16 +18,22 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
-	# The format is "<interval>,<probability>,<space>,<times>". Here, we
-	# requeue 10% of the time.
-	if ! _init_null_blk requeue='1,10,0,-1'; then
+	# Here, we requeue 10% of the time.
+	if ! _configure_null_blk faultb0 requeue_inject/probability=10 \
+	     requeue_inject/times=-1 requeue_inject/verbose=0 power=1; then
+		if [[ -d /sys/kernel/config/nullb/faultb0/requeue_inject ]]; then
+			echo "Configuring null_blk failed"
+		else
+			SKIP_REASONS+=("requires fault injection via configfs")
+		fi
+		rmdir /sys/kernel/config/nullb/faultb0
 		return 1
 	fi
 
-	for sched in $(_io_schedulers nullb0); do
+	for sched in $(_io_schedulers faultb0); do
 		echo "Testing $sched" >> "$FULL"
-		echo "$sched" > /sys/block/nullb0/queue/scheduler
-		dd if=/dev/nullb0 of=/dev/null bs=4K count=$((512 * 1024)) \
+		echo "$sched" > /sys/block/faultb0/queue/scheduler
+		dd if=/dev/faultb0 of=/dev/null bs=4K count=$((512 * 1024)) \
 			iflag=direct status=none
 	done
 
diff --git a/tests/block/030 b/tests/block/030
index 7a0712b..f3cc337 100755
--- a/tests/block/030
+++ b/tests/block/030
@@ -17,19 +17,23 @@ requires() {
 }
 
 test() {
-	local i sq=/sys/kernel/config/nullb/nullb0/submit_queues
+	local i sq=/sys/kernel/config/nullb/faultb0/submit_queues
 
 	: "${TIMEOUT:=30}"
-	# Legend: init_hctx=<interval>,<probability>,<space>,<times>
 	# Set <space> to $(nproc) + 1 to make loading of null_blk succeed.
-	if ! _init_null_blk nr_devices=0 \
-	     "init_hctx=$(nproc),100,$(($(nproc) + 1)),-1"; then
-		echo "Loading null_blk failed"
-		return 1
-	fi
-	if ! _configure_null_blk nullb0 completion_nsec=0 blocksize=512 size=16\
-	     submit_queues="$(nproc)" memory_backed=1 power=1; then
-		echo "Configuring null_blk failed"
+	if ! _configure_null_blk faultb0 completion_nsec=0 blocksize=512 size=16\
+	     submit_queues="$(nproc)" memory_backed=1 \
+	     init_hctx_fault_inject/interval="$(nproc)" \
+	     init_hctx_fault_inject/probability=100 \
+	     init_hctx_fault_inject/space="$(($(nproc) + 1))" \
+	     init_hctx_fault_inject/times=-1 \
+	     init_hctx_fault_inject/verbose=0 power=1; then
+		if [[ -d /sys/kernel/config/nullb/faultb0/init_hctx_fault_inject ]]; then
+			echo "Configuring null_blk failed"
+		else
+			SKIP_REASONS+=("requires fault injection via configfs")
+		fi
+		rmdir /sys/kernel/config/nullb/faultb0
 		return 1
 	fi
 	# Since older null_blk versions do not allow "submit_queues" to be
@@ -47,7 +51,7 @@ test() {
 	else
 		SKIP_REASONS+=("Skipping test because $sq cannot be modified")
 	fi
-	rmdir /sys/kernel/config/nullb/nullb0
+	rmdir /sys/kernel/config/nullb/faultb0
 	_exit_null_blk
 	echo Passed
 }
-- 
2.34.1

