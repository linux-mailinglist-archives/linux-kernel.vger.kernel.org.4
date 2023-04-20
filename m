Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668EE6E9BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjDTSbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjDTSba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:31:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC163C27;
        Thu, 20 Apr 2023 11:31:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 22CAF1FDCA;
        Thu, 20 Apr 2023 18:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682015488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y7LYG31wkiXr0z2RVLriiPlnLrwv4Qw3dEuqAPHE1Yc=;
        b=HIwIZTxZlCi9PZTOn04wtqJsiu2afZALKP1d+05IUbQDYVti2tms+mIB0UCiootLHzbmi5
        05es4+zi03scBG50QImpj9ZPYwK+pPjgIThJC2vdVVuidZgc4TxSUj7sp3v5PegMitP6rZ
        s6IS9h3p+DX5wiWy7UbtBtocBrHoyDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682015488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y7LYG31wkiXr0z2RVLriiPlnLrwv4Qw3dEuqAPHE1Yc=;
        b=w3yoKl+IYSZvFFG29GHh81UWinTgF6pjQSL0YVVqYtKHHdDqHHftkNGOqSNqMEpn1hNANL
        UJsuQz4ebNpn33Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1382F13584;
        Thu, 20 Apr 2023 18:31:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Rb2TBACFQWSvNAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 20 Apr 2023 18:31:28 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 4/4] nvme: Make the number iterations configurable
Date:   Thu, 20 Apr 2023 20:31:15 +0200
Message-Id: <20230420183121.4489-7-dwagner@suse.de>
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

The test hard code the number of iterations certain test should run.
Make this variable via the newly introduced nvme_num_iter environment
variable.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/002 | 2 +-
 tests/nvme/016 | 2 +-
 tests/nvme/017 | 2 +-
 tests/nvme/031 | 2 +-
 tests/nvme/037 | 2 +-
 tests/nvme/rc  | 1 +
 6 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index 6b8484844b4d..c28035483514 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -20,7 +20,7 @@ test() {
 
 	_setup_nvmet
 
-	local iterations=1000
+	local iterations="${nvme_num_iter}"
 	local port
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
diff --git a/tests/nvme/016 b/tests/nvme/016
index 4eba30223a08..c0c31a55b190 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -17,7 +17,7 @@ test() {
 	echo "Running ${TEST_NAME}"
 
 	local port
-	local iterations=1000
+	local iterations="${nvme_num_iter}"
 	local loop_dev
 	local subsys_nqn="blktests-subsystem-1"
 
diff --git a/tests/nvme/017 b/tests/nvme/017
index 0248aee9bc41..e1674508f654 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -18,7 +18,7 @@ test() {
 
 	local port
 	local file_path
-	local iterations=1000
+	local iterations="${nvme_num_iter}"
 	local subsys_name="blktests-subsystem-1"
 
 	_setup_nvmet
diff --git a/tests/nvme/031 b/tests/nvme/031
index e70898819a86..9b08ec1f6989 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -25,7 +25,7 @@ requires() {
 
 test() {
 	local subsys="blktests-subsystem-"
-	local iterations=10
+	local iterations="${nvme_num_iter}"
 	local loop_dev
 	local port
 
diff --git a/tests/nvme/037 b/tests/nvme/037
index fc6c21343652..de9765af194b 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -14,7 +14,7 @@ requires() {
 
 test_device() {
 	local subsys="blktests-subsystem-"
-	local iterations=10
+	local iterations="${nvme_num_iter}"
 	local ctrldev
 	local port
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 8cd89af703bb..03b66100423b 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -18,6 +18,7 @@ def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
 def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
 nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"64M"}
+nvme_num_iter=${nvme_num_iter:-"100"}
 
 _nvme_requires() {
 	_have_program nvme
-- 
2.40.0

