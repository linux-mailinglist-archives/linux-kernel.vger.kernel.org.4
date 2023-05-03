Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4326E6F5291
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjECIDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjECIDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:03:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAF310F5;
        Wed,  3 May 2023 01:03:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EEDCA200AD;
        Wed,  3 May 2023 08:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683100990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xw83kEvyDvOY4G+duwKj+zpJnWldo/RL4BBA4e0mSGM=;
        b=J4gbtqMOaRgITZNuTkoHNOTSHNPZQVgIAUhLkOtKGIzeLOBaWeo940hhp+gl5Omfsv9Xml
        QszrUOiYnj+RF/CiuxWU+uAdW2/u/JTJZ6xJynFvs/zvxwJA4oBlehEdPn7BPMiWgvgsRl
        6Gg/Ik9TNNjBWwz/67d1Umf5x1v/IWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683100990;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xw83kEvyDvOY4G+duwKj+zpJnWldo/RL4BBA4e0mSGM=;
        b=qpcx2sDyYcBTYxeXHcHB+6JB1vu5LPj/85rqnKETu851ayoBKHu3LJ3UkeLfmToFuzWWZ4
        TlvdCYH2EwfGPxDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E18621331F;
        Wed,  3 May 2023 08:03:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id scv+Nj4VUmQvYgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:10 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 02/12] nvme: Do not hard code device size for dd test
Date:   Wed,  3 May 2023 10:02:48 +0200
Message-Id: <20230503080258.14525-3-dwagner@suse.de>
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

Read the block device sizes instead hard coding them,
so that the device size can be configurable in future.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/014 | 10 +++++++++-
 tests/nvme/015 | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/014 b/tests/nvme/014
index d13cff7921da..875e99eea346 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -23,6 +23,9 @@ test() {
 	local port
 	local nvmedev
 	local loop_dev
+	local size
+	local bs
+	local count
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
@@ -41,7 +44,12 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	dd if=/dev/urandom of="/dev/${nvmedev}n1" count=128000 bs=4k status=none
+	size="$(blockdev --getsize64 "/dev/${nvmedev}n1")"
+	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
+	count=$((size / bs))
+
+	dd if=/dev/urandom of="/dev/${nvmedev}n1" \
+		count="${count}" bs="${bs}" status=none
 
 	nvme flush "/dev/${nvmedev}" -n 1
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index bb52ba2598db..8cb343e1d31c 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -22,6 +22,9 @@ test() {
 
 	local port
 	local nvmedev
+	local size
+	local bs
+	local count
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
@@ -38,7 +41,12 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	dd if=/dev/urandom of="/dev/${nvmedev}n1" count=128000 bs=4k status=none
+	size="$(blockdev --getsize64 "/dev/${nvmedev}n1")"
+	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
+	count=$((size / bs))
+
+	dd if=/dev/urandom of="/dev/${nvmedev}n1" \
+		count="${count}" bs="${bs}" status=none
 
 	nvme flush "/dev/${nvmedev}n1" -n 1
 
-- 
2.40.0

