Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDCE738A43
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjFUP6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjFUP6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:58:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E311BF1;
        Wed, 21 Jun 2023 08:58:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 69C4321EF7;
        Wed, 21 Jun 2023 15:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687363121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YGOyuozdZEg1rV2jSDdWfg2dvvscaZag+fZjO1LUAHM=;
        b=i905QhIv+FXqDw8Dz5cOkH/8gXD9yZy0t2H44eD3ePVrn03+4FcEDEsDIc/0ZDDSIlDrFY
        4CrQY/5qVxYRLd/hXpixOSz3IuYVhgpPBwHcen4ctjbOz+fbw6kdbUkPeLjuadMzu5OSxV
        +WP+vWlhDgo0ILez/KhAYGABLqaxsV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687363121;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YGOyuozdZEg1rV2jSDdWfg2dvvscaZag+fZjO1LUAHM=;
        b=nEu+0ySm0inoWxM7P5QKVyCQtbi16QpI6LAX7eZzbCgEiKH+oSnBK7XJI3TnatOrlg+n/S
        ZQFKWWfauw4aeLCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5962D134B1;
        Wed, 21 Jun 2023 15:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v+FuFTEek2RMMgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 21 Jun 2023 15:58:41 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin George <Martin.George@netapp.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v1 1/1] nvme/050: test DNR handling on reconnect
Date:   Wed, 21 Jun 2023 17:58:25 +0200
Message-ID: <20230621155825.20146-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621155825.20146-1-dwagner@suse.de>
References: <20230621155825.20146-1-dwagner@suse.de>
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

When the host gets disconnected and tries to reconnect,
it should honor the DNR bit and do not retry to connect
with the same parameters.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/050     | 126 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/050.out |   2 +
 2 files changed, 128 insertions(+)
 create mode 100644 tests/nvme/050
 create mode 100644 tests/nvme/050.out

diff --git a/tests/nvme/050 b/tests/nvme/050
new file mode 100644
index 000000000000..d33eb24e2f13
--- /dev/null
+++ b/tests/nvme/050
@@ -0,0 +1,126 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 SUSE LLC
+#
+# Test DNR is handled on connnect attempt with invalid arguments.
+
+. tests/nvme/rc
+
+DESCRIPTION="test DNR is handled on connect attempt with invalid arguments"
+
+requires() {
+	_nvme_requires
+	_require_nvme_trtype tcp rdma fc
+	_require_min_cpus 2
+}
+
+nvmf_wait_for_state() {
+	local def_state_timeout=5
+	local subsys_name="$1"
+	local state="$2"
+	local timeout="${3:-$def_state_timeout}"
+	local nvmedev
+	local state_file
+	local start_time
+	local end_time
+
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
+
+	start_time=$(date +%s)
+	while ! grep -q "${state}" "${state_file}"; do
+		sleep 1
+		end_time=$(date +%s)
+		if (( end_time - start_time > timeout )); then
+			echo "expected state \"${state}\" not " \
+				"reached within ${timeout} seconds"
+			return 1
+		fi
+	done
+
+	return 0
+}
+
+nvmf_wait_for_ctrl_delete() {
+	local def_state_timeout=5
+	local nvmedev="$1"
+	local timeout="${2:-$def_state_timeout}"
+	local ctrl="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
+	local start_time
+	local end_time
+
+	start_time=$(date +%s)
+	while [ -f "${ctrl}" ]; do
+		sleep 1
+		end_time=$(date +%s)
+		if (( end_time - start_time > timeout )); then
+			echo "controller \"${nvmedev}\" not deleted" \
+				"within ${timeout} seconds"
+			return 1
+		fi
+	done
+
+	return 0
+}
+
+set_nvmet_attr_qid_max() {
+	local nvmet_subsystem="$1"
+	local qid_max="$2"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
+	echo "${qid_max}" > "${cfs_path}/attr_qid_max"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local port
+	local loop_dev
+	local file_path="$TMPDIR/img"
+	local subsys_name="blktests-subsystem-1"
+	local hostid="77b49aba-06b4-431a-9af8-75e318740f1a"
+	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local cfs_path="${NVMET_CFS}/subsystems/${subsys_name}"
+	local nvmedev
+
+	truncate -s "${nvme_img_size}" "${file_path}"
+
+	loop_dev="$(losetup -f --show "${file_path}")"
+
+	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+		--hostnqn "${hostnqn}" \
+		--reconnect-delay 1 \
+		--ctrl-loss-tmo 10
+
+	nvmf_wait_for_state "${subsys_name}" "live"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+
+	# Only allow connects from ${def_hostnqn}
+	echo 0 > "${cfs_path}/attr_allow_any_host"
+
+	# Force a reconnect
+	set_nvmet_attr_qid_max "${subsys_name}" 1
+
+	# The reconnect fails with the DNR bit set
+	# Thus the host should remove the controller
+	nvmf_wait_for_ctrl_delete "${nvmedev}"
+
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_port "${port}"
+
+	losetup -d "${loop_dev}"
+
+	rm "${file_path}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/050.out b/tests/nvme/050.out
new file mode 100644
index 000000000000..b78b05f78424
--- /dev/null
+++ b/tests/nvme/050.out
@@ -0,0 +1,2 @@
+Running nvme/050
+Test complete
-- 
2.41.0

