Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B3D6E9BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjDTSbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjDTSb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:31:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5494930E3;
        Thu, 20 Apr 2023 11:31:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E212B2197E;
        Thu, 20 Apr 2023 18:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682015486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Piq20gmCbu/sfasT+BJykUx1CpQBqc0w9RDrikSeIvU=;
        b=FqlAaB7VQf937XJ4IqGhpNSFSf9GkwmOUmwjwLXKVuyPN33waFQzqIb6giB1RLQNmAncYu
        FQ4+nhoKkYpk2yDVHCXhmOfPLW8bZ3gAudBZuyqQcK0EoiLBPbC2JMWeGE9eohNvotrwcF
        KtsnOtDjILUgDRZCxh87EhxNUwBfz0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682015486;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Piq20gmCbu/sfasT+BJykUx1CpQBqc0w9RDrikSeIvU=;
        b=ajRf4HRB9pmqcBDtcDAwVAA2xALAvOT7YK/t98otENHzD1fch2kAnSyNLhlwfoQuA9s1SM
        Vl4npiaPmgIlK7Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3BAA13584;
        Thu, 20 Apr 2023 18:31:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4ZacM/6EQWSrNAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 20 Apr 2023 18:31:26 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 3/9] common-xfs: Make size argument optional for _xfs_run_fio_verify_io
Date:   Thu, 20 Apr 2023 20:31:13 +0200
Message-Id: <20230420183121.4489-5-dwagner@suse.de>
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

Make the size argument optional by reading the filesystem info. The
caller doesn't have to guess (or calculate) how big the max IO size.
The log data structure of XFS is reducing the capacity.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/xfs     | 6 ++++++
 tests/nvme/012 | 2 +-
 tests/nvme/013 | 2 +-
 tests/nvme/035 | 2 +-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/common/xfs b/common/xfs
index 2c5d96164ac1..ec35599e017b 100644
--- a/common/xfs
+++ b/common/xfs
@@ -27,6 +27,12 @@ _xfs_run_fio_verify_io() {
 
 	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
 
+	if [[ -z "${sz}" ]]; then
+		local avail
+		avail="$(df --output=avail "${mount_dir}" | awk 'NR==2 {print $1}')"
+		sz="$(printf "%d" $((avail / 1024 - 1 )))m"
+	fi
+
 	_run_fio_verify_io --size="$sz" --directory="${mount_dir}/"
 
 	umount "${mount_dir}" >> "${FULL}" 2>&1
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
 
diff --git a/tests/nvme/035 b/tests/nvme/035
index eb1024edddbf..8b485bc8e682 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -32,7 +32,7 @@ test_device() {
 	port=$(_nvmet_passthru_target_setup "${subsys}")
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
 
-	_xfs_run_fio_verify_io "${nsdev}" "900m"
+	_xfs_run_fio_verify_io "${nsdev}"
 
 	_nvme_disconnect_subsys "${subsys}"
 	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
-- 
2.40.0

