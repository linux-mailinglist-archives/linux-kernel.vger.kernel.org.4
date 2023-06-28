Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F137414B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjF1PQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjF1PQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:16:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97A1A1;
        Wed, 28 Jun 2023 08:16:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F8B82186F;
        Wed, 28 Jun 2023 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687965387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEElvZ5EVshNboB17NtTW6FvyyqnkrFkpvjBte9fm+o=;
        b=AmH4QupUx36ENjL2dvB+y43uaHlXnS3GcLY11OPgVkYb8mgU0CcTMC08vPZR8UnBcE59Ke
        IMqlQpssxMBbrmikIhFPQJ2R1pqVg0be5scp8U0Wx8X/rGRwPajbzaat+RWq8XPERmC59v
        4G8wq9mXUL2D78EzryeBEtBtTK5XgbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687965387;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEElvZ5EVshNboB17NtTW6FvyyqnkrFkpvjBte9fm+o=;
        b=LoXd7V0qhpKEmQW06mKx/FdlAMNJeYTKkkPwp/n+m9jwUrAGOC0/HMLQO928rFbH036r8m
        Asyz53I9Xl2+45CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50C9A138E8;
        Wed, 28 Jun 2023 15:16:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g1psE8tOnGQ1OQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 28 Jun 2023 15:16:27 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 3/3] nvme/{041,042,043,044,045,048}: Use default hostnqn and hostid
Date:   Wed, 28 Jun 2023 17:16:23 +0200
Message-ID: <20230628151623.11340-4-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628151623.11340-1-dwagner@suse.de>
References: <20230628151623.11340-1-dwagner@suse.de>
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

The host might have enabled the udev/systemd auto connect feature.
This disturbs the blktests for the fc transport. nvme-cli is able
to distinguish between the different invocations via the --context
option. In order to get this working we have to use the default
hostnqn and hostid and not random generated IDs for every single
run.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/041 | 8 ++------
 tests/nvme/042 | 8 ++------
 tests/nvme/043 | 8 ++------
 tests/nvme/044 | 8 ++------
 tests/nvme/045 | 8 ++------
 tests/nvme/048 | 8 ++------
 6 files changed, 12 insertions(+), 36 deletions(-)

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
 
-- 
2.41.0

