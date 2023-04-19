Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8FD6E75C9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjDSI47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjDSI4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:56:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291135FFB;
        Wed, 19 Apr 2023 01:56:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A187F1FD87;
        Wed, 19 Apr 2023 08:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681894606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lGY4ffVjjHszNWuxC5CmUVyZQQhkB62a85lqZpBo2M=;
        b=gte1c0UJs5S8uX+RxfkIH0gnjynTKndiNQIPI/mLtgLNtakPfaksKWgRa2E0SdaIvKD+by
        9hcaT+ZTiDYTmRk/Wbt0/qtBjZdYQp+56g5UdkxUkH3x1NLd/rlgGY4i0ZaqCxc2XtrrKe
        fDakMQB2uoCtpp7ryGhHpUjDINRr2Lw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681894606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lGY4ffVjjHszNWuxC5CmUVyZQQhkB62a85lqZpBo2M=;
        b=q1pB4uCe/0J7G360evHh+M+zbI0emr3IEe8DO7NmqS6Hlm2Z0QObetwAXZ2NbulOsOdK26
        J8LOCllCP9jwjBDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9357F1390E;
        Wed, 19 Apr 2023 08:56:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hsrTI86sP2RnegAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 19 Apr 2023 08:56:46 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [RFC v1 1/1] nvme: Limit runtime for verification and limit test image size
Date:   Wed, 19 Apr 2023 10:56:43 +0200
Message-Id: <20230419085643.25714-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230419085643.25714-1-dwagner@suse.de>
References: <20230419085643.25714-1-dwagner@suse.de>
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

The reduce the overall runtime of the testsuite by limiting the runtime
of the verification jobs. We are only interested that some normal I/O is
transferred between host and controller.

Also limit the resource usage of the tests. This allows to run more tiny
VMs and thus more parallel blktests on the same machine.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/xfs     |  3 ++-
 tests/nvme/004 |  2 +-
 tests/nvme/005 |  2 +-
 tests/nvme/006 |  2 +-
 tests/nvme/007 |  2 +-
 tests/nvme/008 |  2 +-
 tests/nvme/009 |  2 +-
 tests/nvme/010 |  5 +++--
 tests/nvme/011 |  5 +++--
 tests/nvme/012 |  4 ++--
 tests/nvme/013 |  4 ++--
 tests/nvme/014 | 10 ++++++++--
 tests/nvme/015 | 10 ++++++++--
 tests/nvme/017 |  2 +-
 tests/nvme/018 |  2 +-
 tests/nvme/019 |  2 +-
 tests/nvme/020 |  2 +-
 tests/nvme/021 |  2 +-
 tests/nvme/022 |  2 +-
 tests/nvme/023 |  2 +-
 tests/nvme/024 |  2 +-
 tests/nvme/025 |  2 +-
 tests/nvme/026 |  2 +-
 tests/nvme/027 |  2 +-
 tests/nvme/028 |  2 +-
 tests/nvme/029 |  2 +-
 tests/nvme/031 |  2 +-
 tests/nvme/032 |  4 ++--
 tests/nvme/034 |  3 ++-
 tests/nvme/035 |  4 ++--
 tests/nvme/040 |  4 ++--
 tests/nvme/041 |  2 +-
 tests/nvme/042 |  2 +-
 tests/nvme/043 |  2 +-
 tests/nvme/044 |  2 +-
 tests/nvme/045 |  2 +-
 tests/nvme/047 |  2 +-
 tests/nvme/048 |  2 +-
 38 files changed, 63 insertions(+), 47 deletions(-)

diff --git a/common/xfs b/common/xfs
index 2c5d96164ac1..ee3033da6ccc 100644
--- a/common/xfs
+++ b/common/xfs
@@ -27,7 +27,8 @@ _xfs_run_fio_verify_io() {
 
 	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
 
-	_run_fio_verify_io --size="$sz" --directory="${mount_dir}/"
+	_run_fio_verify_io --size="$sz" --directory="${mount_dir}/" \
+		--time_based --runtime=5s
 
 	umount "${mount_dir}" >> "${FULL}" 2>&1
 	rm -fr "${mount_dir}"
diff --git a/tests/nvme/004 b/tests/nvme/004
index 9dda538b1ac0..b069d4cc1753 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -25,7 +25,7 @@ test() {
 	local port
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
-	truncate -s 1G "$TMPDIR/img"
+	truncate -s 256M "$TMPDIR/img"
 
 	local loop_dev
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
diff --git a/tests/nvme/005 b/tests/nvme/005
index de567a74a891..18d886f19b06 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -24,7 +24,7 @@ test() {
 	local port
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
-	truncate -s 1G "$TMPDIR/img"
+	truncate -s 256M "$TMPDIR/img"
 
 	local loop_dev
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
diff --git a/tests/nvme/006 b/tests/nvme/006
index d993861c06ba..a757b761e966 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -24,7 +24,7 @@ test() {
 
 	_setup_nvmet
 
-	truncate -s 1G "$TMPDIR/img"
+	truncate -s 256M "$TMPDIR/img"
 
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
 
diff --git a/tests/nvme/007 b/tests/nvme/007
index d53100f3ff7b..1468a03e8c3c 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -25,7 +25,7 @@ test() {
 
 	file_path="${TMPDIR}/img"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
diff --git a/tests/nvme/008 b/tests/nvme/008
index 5568fe46e463..2452801e9d7b 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -26,7 +26,7 @@ test() {
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
 
diff --git a/tests/nvme/009 b/tests/nvme/009
index 2814c79164ee..1a3cec39cf0b 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -24,7 +24,7 @@ test() {
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
diff --git a/tests/nvme/010 b/tests/nvme/010
index b7b1d5188e9b..5831243e414d 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -26,7 +26,7 @@ test() {
 	local file_path="${TMPDIR}/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
 
@@ -41,7 +41,8 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	_run_fio_verify_io --size=950m --filename="/dev/${nvmedev}n1"
+	_run_fio_verify_io --time_based --runtime=5s \
+		--filename="/dev/${nvmedev}n1"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
diff --git a/tests/nvme/011 b/tests/nvme/011
index 4bfe9af084e4..efd8728bf1e1 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -26,7 +26,7 @@ test() {
 	local file_path="${TMPDIR}/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
@@ -39,7 +39,8 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	_run_fio_verify_io --size=950m --filename="/dev/${nvmedev}n1"
+	_run_fio_verify_io --time_based --runtime=5s \
+		--filename="/dev/${nvmedev}n1"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
diff --git a/tests/nvme/012 b/tests/nvme/012
index e60082c2e751..6d275748bd0f 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -29,7 +29,7 @@ test() {
 	local file_path="${TMPDIR}/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
 
@@ -44,7 +44,7 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	_xfs_run_fio_verify_io "/dev/${nvmedev}n1" "900m"
+	_xfs_run_fio_verify_io "/dev/${nvmedev}n1" "200m"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 9d60a7df4577..ffeef71a20df 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -28,7 +28,7 @@ test() {
 
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
@@ -41,7 +41,7 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	_xfs_run_fio_verify_io "/dev/${nvmedev}n1" "900m"
+	_xfs_run_fio_verify_io "/dev/${nvmedev}n1" "200M"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
diff --git a/tests/nvme/014 b/tests/nvme/014
index d13cff7921da..88ebf2979cc7 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -26,7 +26,7 @@ test() {
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
 
@@ -41,7 +41,13 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	dd if=/dev/urandom of="/dev/${nvmedev}n1" count=128000 bs=4k status=none
+	local sectors
+	local bs
+	sectors="$(blockdev --getss "/dev/${nvmedev}n1")"
+	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
+
+	dd if=/dev/urandom of="/dev/${nvmedev}n1" \
+		count="${sectors}" bs="${bs}" status=none
 
 	nvme flush "/dev/${nvmedev}" -n 1
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index bb52ba2598db..fa174e71a3a6 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -25,7 +25,7 @@ test() {
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
@@ -38,7 +38,13 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	dd if=/dev/urandom of="/dev/${nvmedev}n1" count=128000 bs=4k status=none
+	local sectors
+	local bs
+	sectors="$(blockdev --getss "/dev/${nvmedev}n1")"
+	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
+
+	dd if=/dev/urandom of="/dev/${nvmedev}n1" \
+		count="${sectors}" bs="${bs}" status=none
 
 	nvme flush "/dev/${nvmedev}n1" -n 1
 
diff --git a/tests/nvme/017 b/tests/nvme/017
index f2a95cf276cb..049204fa19dc 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -25,7 +25,7 @@ test() {
 
 	file_path="${TMPDIR}/img"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
diff --git a/tests/nvme/018 b/tests/nvme/018
index 315e79534348..747e316e893f 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -26,7 +26,7 @@ test() {
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
diff --git a/tests/nvme/019 b/tests/nvme/019
index 4cb3509a12b2..2e6524423b44 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -28,7 +28,7 @@ test() {
 	local nblk_range="10,10,10,10,10,10,10,10,10,10"
 	local sblk_range="100,200,300,400,500,600,700,800,900,1000"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
 
diff --git a/tests/nvme/020 b/tests/nvme/020
index 16fdfcc94918..7d094b614972 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -26,7 +26,7 @@ test() {
 	local nblk_range="10,10,10,10,10,10,10,10,10,10"
 	local sblk_range="100,200,300,400,500,600,700,800,900,1000"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
diff --git a/tests/nvme/021 b/tests/nvme/021
index 6ee0af1fe158..d499148e40a3 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -25,7 +25,7 @@ test() {
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
diff --git a/tests/nvme/022 b/tests/nvme/022
index 1d76ffa44178..166a88bd0559 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -25,7 +25,7 @@ test() {
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
diff --git a/tests/nvme/023 b/tests/nvme/023
index b65be07edc38..f4a98d95e7bd 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -26,7 +26,7 @@ test() {
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
 
diff --git a/tests/nvme/024 b/tests/nvme/024
index f756797d6f29..1e952aa9c27f 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -25,7 +25,7 @@ test() {
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
diff --git a/tests/nvme/025 b/tests/nvme/025
index 941bf36f67fb..f3ba5409be20 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -25,7 +25,7 @@ test() {
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
diff --git a/tests/nvme/026 b/tests/nvme/026
index c3f06c2a377c..95915c5a4bd9 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -25,7 +25,7 @@ test() {
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
diff --git a/tests/nvme/027 b/tests/nvme/027
index 0ad663ace811..78176930274d 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -25,7 +25,7 @@ test() {
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
diff --git a/tests/nvme/028 b/tests/nvme/028
index 7de977a81213..eccdc561d3aa 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -25,7 +25,7 @@ test() {
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
diff --git a/tests/nvme/029 b/tests/nvme/029
index f8b4cbbb9156..db858cdf595d 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -59,7 +59,7 @@ test() {
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 1G "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
 
diff --git a/tests/nvme/031 b/tests/nvme/031
index 4e1798246db1..16dfddfc614b 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -33,7 +33,7 @@ test() {
 
 	_setup_nvmet
 
-	truncate -s 1G "$TMPDIR/img"
+	truncate -s 256M "$TMPDIR/img"
 
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
 
diff --git a/tests/nvme/032 b/tests/nvme/032
index 017d4a339971..1a467119a2ff 100755
--- a/tests/nvme/032
+++ b/tests/nvme/032
@@ -38,8 +38,8 @@ test_device() {
 	sysfs="/sys/bus/pci/devices/${pdev}"
 
 	# start fio job
-	_run_fio_rand_io --filename="$TEST_DEV" --size=1g \
-		--group_reporting  &> /dev/null &
+	_run_fio_rand_io --filename="$TEST_DEV" --size=256M \
+		--group_reporting --time_based --runtime=1m > /dev/null &
 
 	sleep 5
 
diff --git a/tests/nvme/034 b/tests/nvme/034
index f92e5e20865b..0da188521c20 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -26,7 +26,8 @@ test_device() {
 	port=$(_nvmet_passthru_target_setup "${subsys}")
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
 
-	_run_fio_verify_io --size=950m --filename="${nsdev}"
+	_run_fio_verify_io --size=256M --filename="${nsdev}" \
+		--time_based --runtime=5s
 
 	_nvme_disconnect_subsys "${subsys}"
 	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
diff --git a/tests/nvme/035 b/tests/nvme/035
index d169e351e3d0..356b501a16f9 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -17,7 +17,7 @@ requires() {
 }
 
 device_requires() {
-	_require_test_dev_size_mb 1024
+	_require_test_dev_size_mb 256
 }
 
 test_device() {
@@ -32,7 +32,7 @@ test_device() {
 	port=$(_nvmet_passthru_target_setup "${subsys}")
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
 
-	_xfs_run_fio_verify_io "${nsdev}" "900m"
+	_xfs_run_fio_verify_io "${nsdev}" "250m"
 
 	_nvme_disconnect_subsys "${subsys}"
 	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
diff --git a/tests/nvme/040 b/tests/nvme/040
index 04bd726cd309..4c28e8061d40 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -25,7 +25,7 @@ test() {
 	echo "Running ${TEST_NAME}"
 
 	_setup_nvmet
-	truncate -s 1G "$TMPDIR/img"
+	truncate -s 256M "$TMPDIR/img"
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
@@ -37,7 +37,7 @@ test() {
 
 	# start fio job
 	echo "starting background fio"
-	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size=1g \
+	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size=250m \
 		--group_reporting --ramp_time=5  &> /dev/null &
 	sleep 5
 
diff --git a/tests/nvme/041 b/tests/nvme/041
index 03e2dab25918..f2f070d928b4 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -44,7 +44,7 @@ test() {
 
 	_setup_nvmet
 
-	truncate -s 512M "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"b92842df-a394-44b1-84a4-92ae7d112861"
diff --git a/tests/nvme/042 b/tests/nvme/042
index 4ad726f72f5a..4ecfbd990cc6 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -41,7 +41,7 @@ test() {
 
 	_setup_nvmet
 
-	truncate -s 512M "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
diff --git a/tests/nvme/043 b/tests/nvme/043
index c031cecf34a5..51d7d566e64b 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -42,7 +42,7 @@ test() {
 
 	_setup_nvmet
 
-	truncate -s 512M "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
diff --git a/tests/nvme/044 b/tests/nvme/044
index f2406ecadf7d..d4397565b5b7 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -53,7 +53,7 @@ test() {
 
 	_setup_nvmet
 
-	truncate -s 512M "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
diff --git a/tests/nvme/045 b/tests/nvme/045
index 612e5f168e3c..f89b53a59a3b 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -55,7 +55,7 @@ test() {
 
 	_setup_nvmet
 
-	truncate -s 512M "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
diff --git a/tests/nvme/047 b/tests/nvme/047
index d56d3be185b0..54f92fa62c78 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -28,7 +28,7 @@ test() {
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
-	truncate -s 512M "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
 
diff --git a/tests/nvme/048 b/tests/nvme/048
index b4ee7371eb68..374b0b892d96 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -84,7 +84,7 @@ test() {
 	fi
 	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
 
-	truncate -s 512M "${file_path}"
+	truncate -s 256M "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"b92842df-a394-44b1-84a4-92ae7d112861"
-- 
2.40.0

