Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F556F5298
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjECIDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjECIDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:03:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8D110F5;
        Wed,  3 May 2023 01:03:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C54632233D;
        Wed,  3 May 2023 08:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683100992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7w0k+oXuT3ygMJBORCHbE7gJuAfade3I+Yj4aO2iQ4=;
        b=QnWEZFn5QsXCkwyHBQsdL6x12IWRpfaU0FhE/tNMa0MHiWKsu2XILyr1gYWyAl9B1W2rG/
        3oxlsp92hqnyMInwoHxnico5eVjAci+JoDkgH0+Izt/YEV4ztfZsRachvVQAXo8KTVD84+
        bGFsNAJEJbUYNWVDL0u5p96VKsZe7PI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683100992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7w0k+oXuT3ygMJBORCHbE7gJuAfade3I+Yj4aO2iQ4=;
        b=XQIMNtqZ8muZDol8RlsMpug/UOB/qwYif3FZgM1zc4yyBJsUtN04+nPYrB96tlHF/PC33z
        K2dG+UicqUyGAtCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B811B1331F;
        Wed,  3 May 2023 08:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /kHuLEAVUmQ3YgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:12 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 05/12] nvme: Use runtime fio background jobs
Date:   Wed,  3 May 2023 10:02:51 +0200
Message-Id: <20230503080258.14525-6-dwagner@suse.de>
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

The fio jobs are supposed to run long in background during the test.
Instead relying on a job size use explicit runtime for this.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/032 | 4 ++--
 tests/nvme/040 | 9 +++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/nvme/032 b/tests/nvme/032
index 017d4a339971..2e4b7f0760c7 100755
--- a/tests/nvme/032
+++ b/tests/nvme/032
@@ -38,8 +38,8 @@ test_device() {
 	sysfs="/sys/bus/pci/devices/${pdev}"
 
 	# start fio job
-	_run_fio_rand_io --filename="$TEST_DEV" --size=1g \
-		--group_reporting  &> /dev/null &
+	_run_fio_rand_io --filename="$TEST_DEV" \
+		--group_reporting --time_based --runtime=-1 &> /dev/null &
 
 	sleep 5
 
diff --git a/tests/nvme/040 b/tests/nvme/040
index 04bd726cd309..05b4f5472ef5 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -21,6 +21,7 @@ test() {
 	local port
 	local loop_dev
 	local nvmedev
+	local fio_pid
 
 	echo "Running ${TEST_NAME}"
 
@@ -37,8 +38,10 @@ test() {
 
 	# start fio job
 	echo "starting background fio"
-	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size=1g \
-		--group_reporting --ramp_time=5  &> /dev/null &
+	_run_fio_rand_io --filename="/dev/${nvmedev}n1" \
+		--group_reporting --ramp_time=5 \
+		--time_based --runtime=-1 &> /dev/null &
+	fio_pid=$!
 	sleep 5
 
 	# do reset/remove operation
@@ -48,6 +51,8 @@ test() {
 	echo "deleting controller"
 	_nvme_delete_ctrl "${nvmedev}"
 
+	{ kill "${fio_pid}"; wait; } &> /dev/null
+
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys}"
 	_remove_nvmet_subsystem "${subsys}"
 	_remove_nvmet_port "${port}"
-- 
2.40.0

