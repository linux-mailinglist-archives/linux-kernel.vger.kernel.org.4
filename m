Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4F16FF39F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbjEKOKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbjEKOKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:10:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB117DBD;
        Thu, 11 May 2023 07:10:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6849B1FEFE;
        Thu, 11 May 2023 14:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683814200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M3XBtCch7yegyAAPfwB9jr7VWVnA8HEFlGZxwrQXAF0=;
        b=pkAvHPEJGR5Eysl//odafJ9jp6OZ7fc8BqQfUYsHku8XCtNN2/xE+CqZuN6zqtTeDjNsb8
        LQ1YcQmeRAYL+EYYrJbMg7P0kewY13QpEoCcpeeCVGn/VKSsVlSm2XQSoVAU+V/7xMZxdc
        5PCIr60NaF/Q94Cz1WC+4yX36GYgs5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683814200;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M3XBtCch7yegyAAPfwB9jr7VWVnA8HEFlGZxwrQXAF0=;
        b=JqbwMwKLXau30gKt+fpnfoSXFc9p+FMidfBvDDPwmSZKk09UKRbg9NoGrVinb9mVP+n9A7
        dAhcOcU0CpfdHdBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 188CB134B2;
        Thu, 11 May 2023 14:09:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jH/rODf3XGRHPwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 11 May 2023 14:09:59 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4 01/11] nvme/rc: Auto convert test device size info
Date:   Thu, 11 May 2023 16:09:43 +0200
Message-Id: <20230511140953.17609-2-dwagner@suse.de>
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

Introduce a convert_to_mb() helper which converts the size argument
to MBytes and use in test device require function. This makes it
possible to use user input strings in future.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/rc      | 30 +++++++++++++++++++++++++++---
 tests/nvme/035 |  2 +-
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index af4c0b1cab22..f22a7a5eadf8 100644
--- a/common/rc
+++ b/common/rc
@@ -324,9 +324,12 @@ _get_pci_parent_from_blkdev() {
 		tail -2 | head -1
 }
 
-_require_test_dev_size_mb() {
-	local require_sz_mb=$1
-	local test_dev_sz_mb=$(($(blockdev --getsize64 "$TEST_DEV")/1024/1024))
+_require_test_dev_size() {
+	local require_sz_mb
+	local test_dev_sz_mb
+
+	require_sz_mb="$(convert_to_mb "$1")"
+	test_dev_sz_mb="$(($(blockdev --getsize64 "$TEST_DEV")/1024/1024))"
 
 	if (( "$test_dev_sz_mb" < "$require_sz_mb" )); then
 		SKIP_REASONS+=("${TEST_DEV} required at least ${require_sz_mb}m")
@@ -422,3 +425,24 @@ _have_writeable_kmsg() {
 _run_user() {
 	su "$NORMAL_USER" -c "$1"
 }
+
+convert_to_mb()
+{
+	local str=$1
+	local res
+
+	res=$(echo "${str}" | sed -n 's/^\([0-9]\+\)$/\1/p')
+	if [[ -n "${res}" ]]; then
+		echo "$((res / 1024 / 1024))"
+	fi
+
+	res=$(echo "${str}" | sed -n 's/^\([0-9]\+\)[mM]$/\1/p')
+	if [[ -n "${res}" ]]; then
+		echo "$((res))"
+	fi
+
+	res=$(echo "${str}" | sed -n 's/^\([0-9]\+\)[gG]$/\1/p')
+	if [[ -n "${res}" ]]; then
+		echo "$((res * 1024))"
+	fi
+}
diff --git a/tests/nvme/035 b/tests/nvme/035
index d169e351e3d0..eb1024edddbf 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -17,7 +17,7 @@ requires() {
 }
 
 device_requires() {
-	_require_test_dev_size_mb 1024
+	_require_test_dev_size 1024m
 }
 
 test_device() {
-- 
2.40.0

