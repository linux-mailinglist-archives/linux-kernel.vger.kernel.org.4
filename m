Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B8E6F52A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjECIEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjECIDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:03:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D67C468F;
        Wed,  3 May 2023 01:03:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E1D7B200AC;
        Wed,  3 May 2023 08:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683100995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aAwZIxK8I8pPL4wc47pZHOduEchq/9jTkHlk6SsankQ=;
        b=oHTrdFgGWHdqnfD+LmHOQdC5XxD2Q22DtAONTOxgLJf/EWoUlRQLmuOOSPtFAJNKFUaW/g
        wDSyCILm9vuuMzjsDANBpaByMMOnj4PqJ+YfhZ/+gF9w/aP7S80cYagj41PsmMqN7Bt+9U
        GRLLeaX2nPhPwpje3o2sJYYsooSWp1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683100995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aAwZIxK8I8pPL4wc47pZHOduEchq/9jTkHlk6SsankQ=;
        b=MxQz4XTPHtABvGW4lt/ezlfxVpkfpb+uBHpI520ezQrRzSHKhjJXADr8VqkOGIIhWXVhs9
        siDcr1VKAtzwA+Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4BDC1331F;
        Wed,  3 May 2023 08:03:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tjTuM0MVUmRFYgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:15 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 10/12] nvme/rc: Calculate IO size for random fio jobs
Date:   Wed,  3 May 2023 10:02:56 +0200
Message-Id: <20230503080258.14525-11-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503080258.14525-1-dwagner@suse.de>
References: <20230503080258.14525-1-dwagner@suse.de>
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

_nvme_calc_run_io_size() returns the jobs size for _run_fio_rand_io()
function. The jobs size is the size per job, thus we have to divide
through the number of CPUs.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/045 |  4 +++-
 tests/nvme/047 |  6 ++++--
 tests/nvme/rc  | 10 ++++++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/tests/nvme/045 b/tests/nvme/045
index 99012f6bed8f..f50087cccb6a 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -31,6 +31,7 @@ test() {
 	local ctrlkey
 	local new_ctrlkey
 	local ctrldev
+	local rand_io_size
 
 	echo "Running ${TEST_NAME}"
 
@@ -120,7 +121,8 @@ test() {
 
 	nvmedev=$(_find_nvme_dev "${subsys_name}")
 
-	_run_fio_rand_io --size=4m --filename="/dev/${nvmedev}n1"
+	rand_io_size="$(_nvme_calc_rand_io_size 4m)"
+	_run_fio_rand_io --size="${rand_io_size}" --filename="/dev/${nvmedev}n1"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
diff --git a/tests/nvme/047 b/tests/nvme/047
index b5a8d469a983..6a7599bc2e91 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -25,6 +25,7 @@ test() {
 	local port
 	local nvmedev
 	local loop_dev
+	local rand_io_size
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
@@ -42,7 +43,8 @@ test() {
 
 	nvmedev=$(_find_nvme_dev "${subsys_name}")
 
-	_xfs_run_fio_verify_io /dev/"${nvmedev}n1" "1m" || echo FAIL
+	rand_io_size="$(_nvme_calc_rand_io_size 4M)"
+	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
 
 	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
@@ -50,7 +52,7 @@ test() {
 		--nr-write-queues 1 \
 		--nr-poll-queues 1 || echo FAIL
 
-	_xfs_run_fio_verify_io /dev/"${nvmedev}n1" "1m" || echo FAIL
+	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
 
 	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 0b4d5f6570d6..268418e5b3e0 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -150,6 +150,16 @@ _test_dev_nvme_nsid() {
 	cat "${TEST_DEV_SYSFS}/nsid"
 }
 
+_nvme_calc_rand_io_size() {
+	local img_size_mb
+	local io_size_kb
+
+	img_size_mb="$(convert_to_mb "$1")"
+	io_size_kb="$(((img_size_mb * 1024) / $(OMP_THREAD_LIMIT=32 nproc)))"
+
+	echo "${io_size_kb}k"
+}
+
 _nvme_fcloop_add_rport() {
 	local local_wwnn="$1"
 	local local_wwpn="$2"
-- 
2.40.0

