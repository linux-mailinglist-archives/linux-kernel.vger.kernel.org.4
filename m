Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6BF6FF3A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbjEKOKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238385AbjEKOKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:10:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA2B9EFF;
        Thu, 11 May 2023 07:10:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B2F701FEFF;
        Thu, 11 May 2023 14:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683814209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K1xWaU5NJK40HZMN7W2UmSCNyhTa7LefE1rSnVHPBXg=;
        b=YBi8gVHhDnbJCO+z1n5AwCfN4hRrwVDp6NUnNw8h5tv+86qr9+/nRcDMNmkIyfzTPk3NYX
        ADGYAEsEs1EbfeuDBC2S1eAieTJknMJPNA/689jORnpdQMmIKDeRHWuDKwKY19c8Z+FxrF
        P21E/1TQbHztlDO+BCzJWnqwkB92R0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683814209;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K1xWaU5NJK40HZMN7W2UmSCNyhTa7LefE1rSnVHPBXg=;
        b=Z+/aoTgwFArKCe3bT026SUv8Eg1itCRwD9SPYpIF0EJ8/D8xu/PXKNTrrDv6Zb+rPi2e9X
        V0v2fxeEaXMFNfBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62DF4134B2;
        Thu, 11 May 2023 14:10:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +OpiD0H3XGRuPwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 11 May 2023 14:10:09 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4 05/11] nvme{032,040}: Use runtime fio background jobs
Date:   Thu, 11 May 2023 16:09:47 +0200
Message-Id: <20230511140953.17609-6-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230511140953.17609-1-dwagner@suse.de>
References: <20230511140953.17609-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 017d4a339971..93f53ac22a0b 100755
--- a/tests/nvme/032
+++ b/tests/nvme/032
@@ -38,8 +38,8 @@ test_device() {
 	sysfs="/sys/bus/pci/devices/${pdev}"
 
 	# start fio job
-	_run_fio_rand_io --filename="$TEST_DEV" --size=1g \
-		--group_reporting  &> /dev/null &
+	_run_fio_rand_io --filename="$TEST_DEV" \
+		--group_reporting --time_based --runtime=1d &> /dev/null &
 
 	sleep 5
 
diff --git a/tests/nvme/040 b/tests/nvme/040
index 04bd726cd309..10f924082f34 100755
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
+		--time_based --runtime=1d &> /dev/null &
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

