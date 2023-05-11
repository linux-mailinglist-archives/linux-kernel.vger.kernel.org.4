Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873D86FF3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbjEKOKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbjEKOKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:10:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A946900A;
        Thu, 11 May 2023 07:10:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD9BE21D13;
        Thu, 11 May 2023 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683814202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXg62EC96ajQDdHpd1YF2tGo6DqtEOKYIRcHTFG94OY=;
        b=cMSL7Vm67GcoZAg0LdTOd732b0V5Drf1VRqpTeENJC4jAnIVOaFkYkJFIAPsqjE9ViJGCk
        SeuKhi5wzO2xQ4/zvvCb86YapD5N9CtIEpb9/FLF4H5uruDcmh03w0inW/881BLtbPuiOb
        yzWW7I+7a9e1OZxTpHkbz/vOpvkGTQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683814202;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXg62EC96ajQDdHpd1YF2tGo6DqtEOKYIRcHTFG94OY=;
        b=CzjJMIC6iAg1E/DwNiH3JJbvV3i/DKdswjiwf9ov8BYYh1JIBOR0W9bKfUkb3DXOqlLhW5
        ooNJNDPMiNK5hDDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68AFC134B2;
        Thu, 11 May 2023 14:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WS7NEDr3XGRTPwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 11 May 2023 14:10:02 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4 02/11] nvme{014/015}: Do not hard code device size for dd test
Date:   Thu, 11 May 2023 16:09:44 +0200
Message-Id: <20230511140953.17609-3-dwagner@suse.de>
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

Read the block device sizes instead hard coding them,
so that the device size can be configurable in future.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
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

