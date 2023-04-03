Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306AB6D5536
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 01:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjDCX1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 19:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjDCX1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 19:27:46 -0400
X-Greylist: delayed 504 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Apr 2023 16:27:44 PDT
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0AD199C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:27:44 -0700 (PDT)
Received: from lbrmn-lnxub113.ric.broadcom.net (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 5CDA5C0000F4;
        Mon,  3 Apr 2023 16:19:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 5CDA5C0000F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1680563956;
        bh=tmSvhqBD1nLln5LQR8/qQKvplJ+bIFJ60+31wQisXAE=;
        h=From:To:Cc:Subject:Date:From;
        b=ve1ntz29sYqibYb9e9pPUErGrUDBv+0VwFMTKmqSpt6WKmTmJlThml7L2w7GGF11T
         ZXwd3BBzDcP4314nvHv4gEaTuqyhAAxjAWIsMp94ul0ouW0xDLCbvMm4JhmVEhc4w4
         9/5mabM7i53V5O+qdtaDMcQtcyMWNIllUUftRJng=
From:   Scott Branden <scott.branden@broadcom.com>
To:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] checkpatch: improve signature check on empty description
Date:   Mon,  3 Apr 2023 16:18:21 -0700
Message-Id: <20230403231821.4737-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing check assumed there could be a single Signed-off-by line which
should be ignored when checking for an empty commit message.
Other lines with identifiers "Reported-by:", "Acked-by:", or anything
invented by the person who constructed the commit were counted as a
body of the commit message.

Improve the check for an empty body of the commit message by not counting
any lines that begin with a $signature or similar formatted line of a
keyword followed by a colon.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 scripts/checkpatch.pl | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bd44d12965c9..5922a6df7f5d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2901,15 +2901,14 @@ sub process {
 		$cnt_lines++ if ($realcnt != 0);
 
 # Verify the existence of a commit log if appropriate
-# 2 is used because a $signature is counted in $commit_log_lines
 		if ($in_commit_log) {
-			if ($line !~ /^\s*$/) {
-				$commit_log_lines++;	#could be a $signature
+			if ($line !~ /^\s*($|[a-zA-Z0-9_-]+:)/) {
+				$commit_log_lines++;
 			}
-		} elsif ($has_commit_log && $commit_log_lines < 2) {
+		} elsif ($has_commit_log && $commit_log_lines < 1) {
 			WARN("COMMIT_MESSAGE",
 			     "Missing commit description - Add an appropriate one\n");
-			$commit_log_lines = 2;	#warn only once
+			$commit_log_lines = 1;	#warn only once
 		}
 
 # Check if the commit log has what seems like a diff which can confuse patch
-- 
2.40.0

