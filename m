Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A272C89C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjFLOcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbjFLOcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:32:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB4A420B;
        Mon, 12 Jun 2023 07:31:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 089F72030A;
        Mon, 12 Jun 2023 14:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686580216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ez66F1snArM9P0uDmhUnqyiFlGNOsdEpoDZ1RavyOTI=;
        b=uMCG4NIphRz5S9uoYRnrCKvCoLcECjXLKwv/y+2qRIDSRCUEZB/s3XnMysKHqh1rorDplR
        o6uoD5y4crk/iS3qWSpk0cohTfUEv5zH2L6lm+KHby8xOeA3LwnkK6QJFg2MAl6Z4RmZON
        gBo5wTc0XPDLbeO0n4SFCKd/6r71Dv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686580216;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ez66F1snArM9P0uDmhUnqyiFlGNOsdEpoDZ1RavyOTI=;
        b=JiMidvkXJ3mEhkDjsK2YlVtA/LX5S4jU+WNFUTcO6nJnPx0/wh8pvt9y4ZKBHQUU+dsZ7r
        N301rxdG4Tsiw9Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED40B1357F;
        Mon, 12 Jun 2023 14:30:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p6GzOfcrh2RrIQAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 12 Jun 2023 14:30:15 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1] nvme/040: Free loop back resources
Date:   Mon, 12 Jun 2023 16:29:45 +0200
Message-Id: <20230612142945.10969-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.1
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

The tests does not cleanup all resources after it has finished. This
leads to rm not being able to remove the TMPDIR cleanly:

  + rm -rf blktests/results/tmpdir.nvme.040.m2J
  rm: cannot remove 'blktests/results/tmpdir.nvme.040.m2J': Directory not empty

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/040 | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/040 b/tests/nvme/040
index b6ab34d611ba..688a0939a376 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -18,6 +18,7 @@ requires() {
 
 test() {
 	local subsys="blktests-subsystem-1"
+	local file_path="${TMPDIR}/img"
 	local port
 	local loop_dev
 	local nvmedev
@@ -26,8 +27,8 @@ test() {
 	echo "Running ${TEST_NAME}"
 
 	_setup_nvmet
-	truncate -s "${nvme_img_size}" "$TMPDIR/img"
-	loop_dev="$(losetup -f --show "$TMPDIR/img")"
+	truncate -s "${nvme_img_size}" "${file_path}"
+	loop_dev="$(losetup -f --show "${file_path}")"
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_create_nvmet_subsystem "${subsys}" "${loop_dev}"
@@ -57,5 +58,9 @@ test() {
 	_remove_nvmet_subsystem "${subsys}"
 	_remove_nvmet_port "${port}"
 
+	losetup -d "${loop_dev}"
+
+	rm -f "${file_path}"
+
 	echo "Test complete"
 }
-- 
2.40.1

