Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBD26FF3B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbjEKOKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbjEKOKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:10:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00BF100EF;
        Thu, 11 May 2023 07:10:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A89221D0E;
        Thu, 11 May 2023 14:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683814217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ohCWniQhLy1JmPaSZJVICMhqHrQzKwUuV5HUXtssSws=;
        b=o1LamY2jBs1RbEKKa9AYnDOjUNo9M8Y2Mde0JuNwpYetC0hAXLN+qPSIGaBISu1zu0lIhp
        s9Tutch0R/2UgHvrf5FoPCnvYbbv50PpzcfKTKtNvOkpu7EncCJ5G7fNkvpunuTL251z5C
        7K2XHyKoWHoSBpjtZaD0oRm+Aagw+LI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683814217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ohCWniQhLy1JmPaSZJVICMhqHrQzKwUuV5HUXtssSws=;
        b=0W6dyMkbsIwjkAjT+NoXSN9fSCsQmQB0A3mkL0t2fLFmEJq3L7LqpNiRRWpMuQWWDpUl85
        PByQGNHsAlw+FRAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AFC0A134B2;
        Thu, 11 May 2023 14:10:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nSVCIkj3XGR+PwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 11 May 2023 14:10:16 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4 08/11] nvme: Add minimal test image size requirement
Date:   Thu, 11 May 2023 16:09:50 +0200
Message-Id: <20230511140953.17609-9-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230511140953.17609-1-dwagner@suse.de>
References: <20230511140953.17609-1-dwagner@suse.de>
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/012 |  1 +
 tests/nvme/013 |  1 +
 tests/nvme/045 |  2 +-
 tests/nvme/rc  | 15 +++++++++++++++
 4 files changed, 18 insertions(+), 1 deletion(-)

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
index 8d5305e280ad..c951339fad7d 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,7 @@ nvme_img_size=${nvme_img_size:-"1G"}
 
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
+	if ((nvme_img_size_mb < require_sz_mb)); then
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

