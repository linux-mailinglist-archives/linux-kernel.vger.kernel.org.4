Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9C36F5296
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjECID1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjECIDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:03:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FCA1716;
        Wed,  3 May 2023 01:03:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8A71921D04;
        Wed,  3 May 2023 08:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683100991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OHyLoSeY6bQ/dWfNCp2pJm0/BcIAe4YZOdyK2WISgIM=;
        b=f3nOzPgqtMoGfGKUson9CJmdn1/wwMpH0YXr3JSHfjDI/HRASmNz349PqaRZTYuIwlQkUM
        HWm0xIVnr8CU+fduiQiLan9Rnoc9pbansSCRyZc/J02HeQGdxUc29eZtrLuhe43SiyHs89
        rsep41uspNt3NUT9LGl6+hc/Jd08cWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683100991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OHyLoSeY6bQ/dWfNCp2pJm0/BcIAe4YZOdyK2WISgIM=;
        b=G4aoxJpgAAjFOBndkq6a4W5bppQvIZWy0v1cVsnPyvP0G1TxIaziNOQ2sljJ5m+Ny0tiio
        K8REybhEj7KRziBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E0861331F;
        Wed,  3 May 2023 08:03:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O7J2Hj8VUmQxYgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:11 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 03/12] common/xfs: Make size argument optional for _xfs_run_fio_verify_io
Date:   Wed,  3 May 2023 10:02:49 +0200
Message-Id: <20230503080258.14525-4-dwagner@suse.de>
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

Make the size argument optional by reading the filesystem info. The
caller doesn't have to guess (or calculate) how big the max IO size.
The log data structure of XFS is reducing the capacity.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/xfs     | 14 +++++++++++++-
 tests/nvme/012 |  2 +-
 tests/nvme/013 |  2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/common/xfs b/common/xfs
index 2c5d96164ac1..413c2820ffaf 100644
--- a/common/xfs
+++ b/common/xfs
@@ -24,10 +24,22 @@ _xfs_run_fio_verify_io() {
 	local mount_dir="/mnt/blktests"
 	local bdev=$1
 	local sz=$2
+	local sz_mb
+	local avail
+	local avail_mb
 
 	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
 
-	_run_fio_verify_io --size="$sz" --directory="${mount_dir}/"
+	avail="$(df --output=avail "${mount_dir}" | tail -1)"
+	avail_mb="$((avail / 1024))"
+
+	if [[ -z "${sz}" ]]; then
+		sz_mb="${avail_mb}"
+	else
+		sz_mb="$(convert_to_mb "${sz}")"
+	fi
+
+	_run_fio_verify_io --size="${sz_mb}m" --directory="${mount_dir}/"
 
 	umount "${mount_dir}" >> "${FULL}" 2>&1
 	rm -fr "${mount_dir}"
diff --git a/tests/nvme/012 b/tests/nvme/012
index e60082c2e751..c9d24388306d 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -44,7 +44,7 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	_xfs_run_fio_verify_io "/dev/${nvmedev}n1" "900m"
+	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 9d60a7df4577..265b6968fd34 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -41,7 +41,7 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	_xfs_run_fio_verify_io "/dev/${nvmedev}n1" "900m"
+	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
-- 
2.40.0

