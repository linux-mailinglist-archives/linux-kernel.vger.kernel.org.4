Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC666E9BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjDTSbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjDTSbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:31:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740C53A92;
        Thu, 20 Apr 2023 11:31:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E319E1FD8C;
        Thu, 20 Apr 2023 18:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682015489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vYu2UT5lDEOdiTT1ESF8e0PH0sTJl298MdWvcXc3Wac=;
        b=2KswRzz5JfO3CyQW09bNUue/G8SyuDqDFi/Td2fvqHSZMoaprZqLtlL1KKby8cda08qn8X
        WUidgiJRXSp74k0coJJ2NEf0UaD81agu7iSU90t7Ug7XCZxl7IFSymvd1c66oDU6zkPFqm
        dPss0lp++NXTi/S/IcS+7whCKNbMgzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682015489;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vYu2UT5lDEOdiTT1ESF8e0PH0sTJl298MdWvcXc3Wac=;
        b=4F5D1uLN8oDmjxNK57MVatI40n5X6KRkRsLf7i+sLBN7kdZAv0MP/s90PKf5OWi6tW4kds
        HTmB5bAluOHI94Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5CDB13584;
        Thu, 20 Apr 2023 18:31:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GGjdMwGFQWS1NAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 20 Apr 2023 18:31:29 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 6/9] nvme-rc: Add minimal test image size requirement
Date:   Thu, 20 Apr 2023 20:31:18 +0200
Message-Id: <20230420183121.4489-10-dwagner@suse.de>
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

Some tests need a minimal test image size to work correctly. Thus add a
helper to check the size and update these tests accordingly.

The image minimum is 4M because some of the test have hard coded values.
All tests which use the xfs fio verification job have a minimum
requirement of 350M impossed by the xfs filesystem.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/012 |  1 +
 tests/nvme/013 |  1 +
 tests/nvme/029 |  1 -
 tests/nvme/045 |  2 +-
 tests/nvme/rc  | 15 +++++++++++++++
 5 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/012 b/tests/nvme/012
index ecf44fcb5a51..efe227538c57 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -16,6 +16,7 @@ requires() {
 	_have_fio
 	_have_loop
 	_require_nvme_trtype_is_fabrics
+	_require_nvme_test_img_size 350m
 }
 
 test() {
diff --git a/tests/nvme/013 b/tests/nvme/013
index e249add46295..14e646a19c47 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -15,6 +15,7 @@ requires() {
 	_have_xfs
 	_have_fio
 	_require_nvme_trtype_is_fabrics
+	_require_nvme_test_img_size 350m
 }
 
 test() {
diff --git a/tests/nvme/029 b/tests/nvme/029
index 1808b7b0edf1..c6d38b42af70 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -14,7 +14,6 @@ requires() {
 	_nvme_requires
 	_have_loop
 	_require_nvme_trtype_is_fabrics
-	_require_test_dev_size 1M
 }
 
 test_user_io()
diff --git a/tests/nvme/045 b/tests/nvme/045
index 7c51da27b5f1..99012f6bed8f 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -120,7 +120,7 @@ test() {
 
 	nvmedev=$(_find_nvme_dev "${subsys_name}")
 
-	_run_fio_rand_io --size=8m --filename="/dev/${nvmedev}n1"
+	_run_fio_rand_io --size=4m --filename="/dev/${nvmedev}n1"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index e5ba9a6d5f54..b1f2dacae125 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,7 @@ nvme_img_size=${nvme_img_size:-"350M"}
 
 _nvme_requires() {
 	_have_program nvme
+	_require_nvme_test_img_size 4m
 	case ${nvme_trtype} in
 	loop)
 		_have_driver nvme-loop
@@ -94,6 +95,20 @@ _require_test_dev_is_nvme() {
 	return 0
 }
 
+_require_nvme_test_img_size() {
+	local require_sz_mb
+	local nvme_img_size_mb
+
+	require_sz_mb="$(convert_to_mb "$1")"
+	nvme_img_size_mb="$(convert_to_mb "${nvme_img_size}")"
+
+	if (( "${nvme_img_size_mb}" < "$require_sz_mb" )); then
+		SKIP_REASONS+=("nvme_img_size must be at least ${require_sz_mb}m")
+		return 1
+	fi
+	return 0
+}
+
 _require_nvme_trtype() {
 	local trtype
 	for trtype in "$@"; do
-- 
2.40.0

