Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31EB6E9BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjDTSbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjDTSbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:31:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C37230E3;
        Thu, 20 Apr 2023 11:31:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B482F1FDCB;
        Thu, 20 Apr 2023 18:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682015488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGJ8+x4oOv8BH7OP38itoB2VZdEGzcVipLnzQChvils=;
        b=l9N3KLMhHYSFD3EuUHevu9MXorcwyrBrWsVF1kw+2tZ4S2J3Lh/2IdQ+FvnDcE22UWXIXA
        jTN5PphopDbn+N9KE/8ljjs+j/rQPv9JsFLdGXm5q7Ia4UJwlWUGVGAlVDJRp2eZRiPNwD
        /s3jVjubpHLFYlBer8F3rDGWTaXQwt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682015488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGJ8+x4oOv8BH7OP38itoB2VZdEGzcVipLnzQChvils=;
        b=OVcBqu8rfqHUFlbT+Ez7DCSA+YeVH3uJzhBPBXzg9IYEpPjYebiVKXStHqfdw6+oRivJfE
        c4drv3zwXdwHx3AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5EE613584;
        Thu, 20 Apr 2023 18:31:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HVkxKACFQWSxNAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 20 Apr 2023 18:31:28 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 4/9] nvme: Use runtime fio background jobs
Date:   Thu, 20 Apr 2023 20:31:16 +0200
Message-Id: <20230420183121.4489-8-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420183121.4489-1-dwagner@suse.de>
References: <20230420183121.4489-1-dwagner@suse.de>
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
 tests/nvme/032 | 2 +-
 tests/nvme/040 | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/032 b/tests/nvme/032
index 017d4a339971..81e074cc11bc 100755
--- a/tests/nvme/032
+++ b/tests/nvme/032
@@ -39,7 +39,7 @@ test_device() {
 
 	# start fio job
 	_run_fio_rand_io --filename="$TEST_DEV" --size=1g \
-		--group_reporting  &> /dev/null &
+		--group_reporting --time_based --runtime=1m &> /dev/null &
 
 	sleep 5
 
diff --git a/tests/nvme/040 b/tests/nvme/040
index 04bd726cd309..8d29f905adb5 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -38,7 +38,8 @@ test() {
 	# start fio job
 	echo "starting background fio"
 	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size=1g \
-		--group_reporting --ramp_time=5  &> /dev/null &
+		--group_reporting --ramp_time=5 \
+		--time_based --runtime=1m &> /dev/null &
 	sleep 5
 
 	# do reset/remove operation
-- 
2.40.0

