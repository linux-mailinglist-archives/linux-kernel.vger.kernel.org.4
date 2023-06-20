Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470FF736D54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjFTN1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjFTN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:27:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE191A5;
        Tue, 20 Jun 2023 06:27:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AE1631F86B;
        Tue, 20 Jun 2023 13:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687267638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mslHR0E96Ru1KBDgtfzc/TQeGRugMHwpdwx8xTSeZLI=;
        b=u1Y6gAvWfLwIMKwpqnUclWDht7+JiU/eaT0Gc6viAweQwelf9bVzxymRMXv/bQFD1z0Cw4
        FzFbWcIsbqfRwn0TYr542AERzdcESF0h3IXlS3G4bww666VG8MyKpoFnPJFalctsup98q4
        8Y9DPB+i+2w1ECg12BCt+MEp52PwjLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687267638;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mslHR0E96Ru1KBDgtfzc/TQeGRugMHwpdwx8xTSeZLI=;
        b=ZlzgfU+pWRMK1Uh0Apu/qRfRDHxbbpCdUKer/8PHL3tW8Pb0DmdhbvE3zcV2XAsd484RHq
        mtnTeEr14c+Tt9Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FC361346D;
        Tue, 20 Jun 2023 13:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MS/oJjapkWSlOAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 20 Jun 2023 13:27:18 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 3/3] nvme/{041,042,043,044,045}: Use default hostnqn and hostid
Date:   Tue, 20 Jun 2023 15:27:03 +0200
Message-ID: <20230620132703.20648-4-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620132703.20648-1-dwagner@suse.de>
References: <20230620132703.20648-1-dwagner@suse.de>
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
hostnqn and hostid and not randon generated IDs for every single
run.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/041 | 8 ++------
 tests/nvme/042 | 8 ++------
 tests/nvme/043 | 8 ++------
 tests/nvme/044 | 8 ++------
 tests/nvme/045 | 8 ++------
 5 files changed, 10 insertions(+), 30 deletions(-)

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
-- 
2.41.0

