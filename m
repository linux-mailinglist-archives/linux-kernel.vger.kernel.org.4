Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604F2745830
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjGCJRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjGCJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:16:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA264191;
        Mon,  3 Jul 2023 02:16:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A8DF11FD76;
        Mon,  3 Jul 2023 09:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688375816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwQ11ZCMfUbee76s3nRrSEKyCvgmp2Gel3xnxd/kPGE=;
        b=YbvAdaHs2zQbMAkwg2aFEvUVKke4jx1axyARonpkBkIYq1qZ4JqWQCAMNQmw9l2qq8tATv
        DSKtOuZ15kVDXqJm4Yfhn6hwwK0ctT7Dd/3nyJsdhJYQq0tdhBQrKsocY5/pM+RUv31VFf
        bf+veDj8jnaslQsoENzloT3nPW06X0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688375816;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwQ11ZCMfUbee76s3nRrSEKyCvgmp2Gel3xnxd/kPGE=;
        b=Us5QDSYjGJVTs39nuAyJdKx0428NkKHgJtr73DJDkahqT/agx5kzixI9qR/68S0tuftrZZ
        LnufDr/rT7avDVBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9482613276;
        Mon,  3 Jul 2023 09:16:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zYFoJAiSomSNDgAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 03 Jul 2023 09:16:56 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 3/3] nvme/{041,042,043,044,045,048}: Use default hostnqn and hostid
Date:   Mon,  3 Jul 2023 11:16:47 +0200
Message-ID: <20230703091647.800-4-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703091647.800-1-dwagner@suse.de>
References: <20230703091647.800-1-dwagner@suse.de>
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

The host might have enabled the udev/systemd auto connect feature.
This disturbs the blktests for the fc transport. nvme-cli is able
to distinguish between the different invocations via the --context
option.

Instead creating random generated IDs or reuse the hostnqn, it's safer
to always use the same hostnqn to reduce the risk that the matching
logic doesn't work.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/041 |  8 ++------
 tests/nvme/042 |  8 ++------
 tests/nvme/043 |  8 ++------
 tests/nvme/044 |  8 ++------
 tests/nvme/045 |  8 ++------
 tests/nvme/048 |  8 ++------
 tests/nvme/rc  | 19 ++-----------------
 7 files changed, 14 insertions(+), 53 deletions(-)

diff --git a/tests/nvme/041 b/tests/nvme/041
index 308655dd6090..5b04b99b128e 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -30,12 +30,8 @@ test() {
 
 	echo "Running ${TEST_NAME}"
 
-	hostid="$(uuidgen)"
-	if [ -z "$hostid" ] ; then
-		echo "uuidgen failed"
-		return 1
-	fi
-	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	hostid="${def_hostid}"
+	hostnqn="${def_hostnqn}"
 	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
 		echo "nvme gen-dhchap-key failed"
diff --git a/tests/nvme/042 b/tests/nvme/042
index fed2efead013..8df5ed37aacc 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -32,12 +32,8 @@ test() {
 
 	echo "Running ${TEST_NAME}"
 
-	hostid="$(uuidgen)"
-	if [ -z "$hostid" ] ; then
-		echo "uuidgen failed"
-		return 1
-	fi
-	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	hostid="${def_hostid}"
+	hostnqn="${def_hostnqn}"
 
 	_setup_nvmet
 
diff --git a/tests/nvme/043 b/tests/nvme/043
index a030884aa4ed..b591e39d0706 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -33,12 +33,8 @@ test() {
 
 	echo "Running ${TEST_NAME}"
 
-	hostid="$(uuidgen)"
-	if [ -z "$hostid" ] ; then
-		echo "uuidgen failed"
-		return 1
-	fi
-	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	hostid="${def_hostid}"
+	hostnqn="${def_hostnqn}"
 
 	_setup_nvmet
 
diff --git a/tests/nvme/044 b/tests/nvme/044
index 9928bcc55397..fca0897af27b 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -32,12 +32,8 @@ test() {
 
 	echo "Running ${TEST_NAME}"
 
-	hostid="$(uuidgen)"
-	if [ -z "$hostid" ] ; then
-		echo "uuidgen failed"
-		return 1
-	fi
-	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	hostid="${def_hostid}"
+	hostnqn="${def_hostnqn}"
 
 	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
diff --git a/tests/nvme/045 b/tests/nvme/045
index 26a55335a92c..eca629a18691 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -36,12 +36,8 @@ test() {
 
 	echo "Running ${TEST_NAME}"
 
-	hostid="$(uuidgen)"
-	if [ -z "$hostid" ] ; then
-		echo "uuidgen failed"
-		return 1
-	fi
-	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	hostid="${def_hostid}"
+	hostnqn="${def_hostnqn}"
 
 	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
diff --git a/tests/nvme/048 b/tests/nvme/048
index bbfb9873b5e8..a6ebb8927865 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -93,12 +93,8 @@ test() {
 
 	_setup_nvmet
 
-	hostid="$(uuidgen)"
-	if [ -z "$hostid" ] ; then
-		echo "uuidgen failed"
-		return 1
-	fi
-	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	hostid="${def_hostid}"
+	hostnqn="${def_hostnqn}"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 9b5442b2c07b..4f3a994d75ce 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -14,23 +14,8 @@ def_remote_wwnn="0x10001100aa000001"
 def_remote_wwpn="0x20001100aa000001"
 def_local_wwnn="0x10001100aa000002"
 def_local_wwpn="0x20001100aa000002"
-
-if [ -f "/etc/nvme/hostid" ]; then
-	def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
-else
-	def_hostid="$(uuidgen)"
-fi
-if [ -z "$def_hostid" ] ; then
-	def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
-fi
-
-if [ -f "/etc/nvme/hostnqn" ]; then
-	def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
-fi
-if [ -z "$def_hostnqn" ] ; then
-	def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
-fi
-
+def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
+def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
-- 
2.41.0

